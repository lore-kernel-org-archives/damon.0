Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E12E8B81;
	Tue, 14 Apr 2026 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142379; cv=none; b=sbFFNWjFxjwIxmiQyWxs/P2H13UBcUUPQcf2Gu36W5vc8ZrTas2ncxDJ22svpcCmPNFfLRFlb2ooC3jojHewvWnFDT7u0s8OaQqDtHKYyEccLhyjQ2GPymsIfCChk06VPOnk5Yh0DK8iEMrl2fj5WdEtHyqAUIy16OlFU1rnwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142379; c=relaxed/simple;
	bh=c+5+KIyLfb5AgagNq7OxOOjGMcrikTwsTu2i1IKcfP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7FMIuSv0+H7O5Gqkj9MDJTtoopWoDcH68Z3mli5bdhUBNpehm0rew2YpVoNy+vlCg7MuxJ+oLrs33pbUmXQeIcI8GMJ1N/6wQPeIpGeSo/kpnizSN/RQWwxp7xOSC45PH/yeSIUhFRJzJBbOVn5bvsUyNFUGO+Udiobzm4tW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjzcbpiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjzcbpiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A79C2BCB9;
	Tue, 14 Apr 2026 04:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776142378;
	bh=c+5+KIyLfb5AgagNq7OxOOjGMcrikTwsTu2i1IKcfP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjzcbpiWnH2uB65rdaigC0+FBemAa4PWf3Twx+UyfL0pEA+MpPRB5kAHEAC/EVABJ
	 1NdlXi0gIrok93+fmpQYUgKyuOM0jNIsEDsQ2be/u+oJmrbjudwHgepgOuR2Q4DhvH
	 tngVuyVrhJ7mkLZHSZZFvXz23MyTaQvN1pl+Rv7tD+ZVSzYcZN9nPojWoOQfACZN8o
	 dNOWGyLec/7oBxc78lCvdEWiUMrlGWdHHB1dSIMo+4+auSHXTXayT4Dz5OPTeZc4ic
	 RP1zbawdqaow3vc6+3GigiP+YWIssR+GGsTM7tEMxfhYLDddW3Trl749pyECcT4tuZ
	 q4GHYHXqK/kEQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/reclaim: add autotune_monitoring_intervals parameter
Date: Mon, 13 Apr 2026 21:52:50 -0700
Message-ID: <20260414045253.88529-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414045253.88529-1-sj@kernel.org>
References: <20260414045253.88529-1-sj@kernel.org>
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

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 4fc4a54b5e546..89998d28628c4 100644
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
@@ -159,7 +173,7 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-static struct damos *damon_reclaim_new_scheme(void)
+static struct damos *damon_reclaim_new_scheme(unsigned long aggr_interval)
 {
 	struct damos_access_pattern pattern = {
 		/* Find regions having PAGE_SIZE or larger size */
@@ -169,8 +183,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 		.min_nr_accesses = 0,
 		.max_nr_accesses = 0,
 		/* for min_age or more micro-seconds */
-		.min_age_region = min_age /
-			damon_reclaim_mon_attrs.aggr_interval,
+		.min_age_region = min_age / aggr_interval,
 		.max_age_region = UINT_MAX,
 	};
 
@@ -191,6 +204,7 @@ static int damon_reclaim_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
 	struct damon_target *param_target;
+	struct damon_attrs attrs;
 	struct damos *scheme;
 	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
@@ -208,12 +222,21 @@ static int damon_reclaim_apply_parameters(void)
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
