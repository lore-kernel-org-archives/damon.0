Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D43939AF;
	Tue, 13 Jan 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318054; cv=none; b=NBftNOoIFwkwPxDcuFbP4XyPVdp+U+LQD7HeyGkE+xVtS1Aj2+baoO+DChdzOrtwKSBSDcvbg5Dc+wefXy0WR6wQJjmrSx6GP6dce28cLYUBLWEM4jL5UKADmBqoLZj6up/qCtejPniHztzgBrlB+WuSTSWylPmzo/YNl5UdNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318054; c=relaxed/simple;
	bh=f3S6xDzMYwBAJsmHW3zullLbXTgyY6fprlw1+nJamAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMpcxzjW+C/UvXL2KlftxTClNp9H5ZnEGXnMMVd6t9vTgGawKHvA6s8OvmYuB4hxastimcgwbXjXn/l3Gy7vCJqN17v0YdFqzP0IqBmqoNY4L11kYr/YvP65xOD8Bdm3h6MaQOIl9HXk2M7W6BTKATGurN5CA2GayVl3qDvUHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU7j9M+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU7j9M+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963CBC19424;
	Tue, 13 Jan 2026 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318053;
	bh=f3S6xDzMYwBAJsmHW3zullLbXTgyY6fprlw1+nJamAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BU7j9M+T12Pl2/6y/ThZgQsOBqc2tov7ik5qihZ+zekXx4nv/okg1SjeyuMJKE8ct
	 UrrJK6PnCIRHTrzVLUx8eLaLQqYzPFlZRzqi0VP+0oPaXA6dcPAmoxzpwVvDUxRPc3
	 ZYkXjvDj37yDuO31Wj5O2XtCX47hiyIIh1/NIfE3vQz5BlKMHaafY/I/y3p6NdQFaZ
	 nwnwNdhHh5cJ4WyEhhHDDu8V0GHAqm0sj4jzdyThuvafKvoZpu214Q3E+edJaqqcGL
	 uqbxEceh/bVlsT6G7KOQYkYBBJQUXcIRGQ2nwvCDZqV64YiKPprYbLvO+nN6mdeN9B
	 PU1b4lvH3tbVQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/11] mm/damon/lru_sort: add monitoring intervals auto-tuning parameter
Date: Tue, 13 Jan 2026 07:27:15 -0800
Message-ID: <20260113152717.70459-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitoring intervals tuning was crucial for every DAMON use case.
Now there are a tuning guideline and an automated intervals tuning
feature.  DAMON_LRU_SORT is still using manual control of intervals.
Add a module parameter for utilizing the auto-tuning feature with a
suggested auto-tuning parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f3a9dfc246b6..717cc585d207 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -55,6 +55,20 @@ module_param(commit_inputs, bool, 0600);
 static unsigned long active_mem_bp __read_mostly;
 module_param(active_mem_bp, ulong, 0600);
 
+/*
+ * Auto-tune monitoring intervals.
+ *
+ * If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tunes
+ * DAMON's sampling and aggregation intervals.  The auto-tuning aims to capture
+ * meaningful amount of access events in each DAMON-snapshot, while keeping the
+ * sampling interval 5 milliseconds in minimum, and 10 seconds in maximum.
+ * Setting this as ``N`` disables the auto-tuning.
+ *
+ * Disabled by default.
+ */
+static bool autotune_monitoring_intervals __read_mostly;
+module_param(autotune_monitoring_intervals, bool, 0600);
+
 /*
  * Filter [non-]young pages accordingly for LRU [de]prioritizations.
  *
@@ -268,6 +282,7 @@ static int damon_lru_sort_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
 	struct damon_target *param_target;
+	struct damon_attrs attrs;
 	struct damos *hot_scheme, *cold_scheme;
 	unsigned int hot_thres, cold_thres;
 	int err;
@@ -290,18 +305,27 @@ static int damon_lru_sort_apply_parameters(void)
 		goto out;
 	}
 
-	err = damon_set_attrs(param_ctx, &damon_lru_sort_mon_attrs);
+	attrs = damon_lru_sort_mon_attrs;
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
-	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
+	hot_thres = damon_max_nr_accesses(&attrs) *
 		hot_thres_access_freq / 1000;
 	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!hot_scheme)
 		goto out;
 
-	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
+	cold_thres = cold_min_age / attrs.aggr_interval;
 	cold_scheme = damon_lru_sort_new_cold_scheme(cold_thres);
 	if (!cold_scheme) {
 		damon_destroy_scheme(hot_scheme);
-- 
2.47.3
