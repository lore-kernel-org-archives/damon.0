Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F81D7E41;
	Fri,  1 May 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598270; cv=none; b=iNnAKYe/P8cQXR6so9MoYc3P0qKj04WC8WVpwAQ+0GEkAYyEQT2H+h0Dzutr4ARpHvL8NTmojNyz8ab47EZnL4YUXgRemWSK/RyCngPJihH3dfHLqAPL6R0rdRL6zYDXcoBW7p0fl8mAtWYhQREki+DIMFaYipy2H679KXX3Ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598270; c=relaxed/simple;
	bh=IXV4ofHUNMR7uLHKHC1smn2YPflRBM60edKH9TblUOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW40TYENMmReqWYiMpFLcTITXmKdT6aLM7DtpyXt3Nz8YF2i+VKv4DjP0UgOMsvifJjdUMezEme2WCCVwAfg3mIeOaWBjAK8lBZFtTSD3a8gnPydOHEFNPn5iExOFDb4dGmwv6DgImRqtKaEhoJn4aqh4/Jzf53JqJS94McjcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbMB9IzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbMB9IzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E4C2BCC9;
	Fri,  1 May 2026 01:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598270;
	bh=IXV4ofHUNMR7uLHKHC1smn2YPflRBM60edKH9TblUOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbMB9IzAxL8CGD1ii9D2yRqsbgrM9kjX/48Sp/hSKyIDsMlPVIPaPgMtx/x1wkb1r
	 USo9ckkVyeUSxsWNwZe+spjqCq7p4QpEIIb72fGShnD6EIRcZgUiC7QMpQzB53mXCF
	 YM/EMdTyUmgolIqihfckuNdUx9DavJreC5SIQMQrdLXE7dRk1W1JpDs/zqWJ477VBl
	 BGS4iy9o0ipTNocI4Fym69HFrW4pnBDty0c8zZS9CjbzocJAP475Kml3DzLlavFsz5
	 Gn0zoZHtDk1qVaW40EpSsXL8n7QawiqyHf4YkrLDlYg2ekMC9/g4UmfdTSwh1Bu31S
	 jgiB4ykXX6mog==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/reclaim: add autotune_monitoring_intervals parameter
Date: Thu, 30 Apr 2026 18:17:38 -0700
Message-ID: <20260501011740.81988-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501011740.81988-1-sj@kernel.org>
References: <20260501011740.81988-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's monitoring intervals auto-tuning feature has proven to be useful
in multiple environments.  DAMON_RECLAIM is still asking users to do the
manual tuning of the intervals.  Add a module parameter for utilizing
the auto-tuning feature with the suggested default setup.

Note that use of the auto-tuning overrides the manually entered
monitoring intervals.  Also, note that the 'min_age' will dynamically
changed proportional to auto-tuned intervals.  It is recommended to use
'min_age' short enough and use 'quota_mem_pressure_us' like coldness
threshold auto-tuning features together.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a60ee800d63e9..7126d47fb8b2f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -91,6 +91,20 @@ module_param(quota_mem_pressure_us, ulong, 0600);
 static unsigned long quota_autotune_feedback __read_mostly;
 module_param(quota_autotune_feedback, ulong, 0600);
 
+/*
+ * Auto-tune monitoring intervals.
+ *
+ * If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+ * sampling and aggregation intervals.  The auto-tuning aims to capture
+ * meaningful amount of access events in each DAMON-snapshot, while keeping the
+ * sampling intervals 5 milliseconds in minimum, and 10 seconds in maximum.
+ * Setting this as ``N`` disables the auto-tuning.
+ *
+ * Disabled by default.
+ */
+static bool autotune_monitoring_intervals __read_mostly;
+module_param(autotune_monitoring_intervals, bool, 0600);
+
 static struct damos_watermarks damon_reclaim_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
 	.interval = 5000000,	/* 5 seconds */
@@ -152,7 +166,7 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-static struct damos *damon_reclaim_new_scheme(void)
+static struct damos *damon_reclaim_new_scheme(unsigned long aggr_interval)
 {
 	struct damos_access_pattern pattern = {
 		/* Find regions having PAGE_SIZE or larger size */
@@ -162,8 +176,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 		.min_nr_accesses = 0,
 		.max_nr_accesses = 0,
 		/* for min_age or more micro-seconds */
-		.min_age_region = min_age /
-			damon_reclaim_mon_attrs.aggr_interval,
+		.min_age_region = min_age / aggr_interval,
 		.max_age_region = UINT_MAX,
 	};
 
@@ -184,6 +197,7 @@ static int damon_reclaim_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
 	struct damon_target *param_target;
+	struct damon_attrs attrs;
 	struct damos *scheme;
 	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
@@ -201,12 +215,21 @@ static int damon_reclaim_apply_parameters(void)
 		goto out;
 	}
 
-	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
+	attrs = damon_reclaim_mon_attrs;
+	if (autotune_monitoring_intervals) {
+		attrs.sample_interval = 5000;
+		attrs.aggr_interval = 100000;
+		attrs.intervals_goal.access_bp = 40;
+		attrs.intervals_goal.aggrs = 3;
+		attrs.intervals_goal.min_sample_us = 5000;
+		attrs.intervals_goal.max_sample_us = 10 * 1000 * 1000;
+	}
+	err = damon_set_attrs(param_ctx, &attrs);
 	if (err)
 		goto out;
 
 	err = -ENOMEM;
-	scheme = damon_reclaim_new_scheme();
+	scheme = damon_reclaim_new_scheme(attrs.aggr_interval);
 	if (!scheme)
 		goto out;
 	damon_set_schemes(param_ctx, &scheme, 1);
-- 
2.47.3
