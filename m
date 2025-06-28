Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9625D549;
	Sat, 28 Jun 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129518; cv=none; b=k4GwMQ8VLC2nhpbZQqgyoWOKtbJaDVAdRBJ/tEUXWFmBNVPN/wMo2W7lrKBEHZQZcAUnnBiaANT8R2BkpGwTCFSCru1jgTe/DMrN0IbK0lNKicb/wamCh6OyGpBm0XkN8sa6zmJj2i3h1WKY354zbB3yjOJyUCMv49ST3p5BTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129518; c=relaxed/simple;
	bh=tlvqxxIUDAypcpXix4DDUce9Gvf8SrIMBmaTGFZI30U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQiQyIX1g8f4iwHxJpNwodAYPjel3Xki7EwNLJppsfV18Kcqlls15iXJYX6/Okh2cwFB8tOn94scxm+fSY675uWhJg3JrCX3J5ny4+is1Ip8jb8DNm4Aqifi9xVDnu72XYJMPOYWJbiunCYyWH03EpiuXNLK1dsHULSs3699rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgLtLZ6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgLtLZ6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405D1C4CEED;
	Sat, 28 Jun 2025 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129518;
	bh=tlvqxxIUDAypcpXix4DDUce9Gvf8SrIMBmaTGFZI30U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgLtLZ6q9JHyXcZE7E3djoYPOZN6LsoO2UhZ5uv5R40j+Kt/aTRhT71X+TgkdBMWc
	 epy51+h6/a+DXlMCvZwjFGaoVr7BNrO9FmPkC95JSnXO5SxX1FE3V7vH7IwNHCUTvy
	 CU1DpW+/553Is8RvXDBb82W4sPBn39AuMfLcZjVD/SQtayqs6319uJuCl+erCXEqpz
	 7l8usr6qm4bB3L0l2/V6L8WiP/t8ZiRRWuNwy8lKA2HB88I0Omf4IEEt06p7CD/tEj
	 tflx4ALke51tN6w42QYzk5kVHblMRp8csfEYwWLcX/rQavPWGKArTWqJ9Q/4g15EDm
	 X+5qNzFqaRMDQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/11] mm/damon/lru_sort: add monitoring intervals auto-tuning parameter
Date: Sat, 28 Jun 2025 09:51:43 -0700
Message-Id: <20250628165144.55528-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
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
index 99c5a22cf3f2..1e9e19f15b33 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -55,6 +55,20 @@ module_param(commit_inputs, bool, 0600);
 static unsigned long active_mem_bp __read_mostly;
 module_param(active_mem_bp, ulong, 0600);
 
+/*
+ * Auto-tune monitoring intervals.
+ *
+ * If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tune
+ * DAMON's sampling and aggregation intervals.  The auto-tuning aims to capture
+ * meaningful amount of access events in each DAMON-snapshot, while keeping the
+ * sampling interval 5 milliseconds in minimu, and 10 seconds in maximum.
+ * Setting this as ``Y`` disables the auto-tuning.
+ *
+ * Disabled by default.
+ */
+static bool autotune_monitoring_intervals __read_mostly;
+module_param(autotune_monitoring_intervals, bool, 0600);
+
 /*
  * Filter [none-]young pages accordingly for LRU [de]prioritizations.
  *
@@ -261,6 +275,7 @@ static int damon_lru_sort_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
 	struct damon_target *param_target;
+	struct damon_attrs attrs;
 	struct damos *hot_scheme, *cold_scheme;
 	unsigned int hot_thres, cold_thres;
 	int err;
@@ -269,18 +284,27 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
-	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
+	attrs = damon_lru_sort_mon_attrs;
+	if (autotune_monitoring_intervals) {
+		attrs.sample_interval = 5000;
+		attrs.aggr_interval = 100000;
+		attrs.intervals_goal.access_bp = 40;
+		attrs.intervals_goal.aggrs = 3;
+		attrs.intervals_goal.min_sample_us = 5000;
+		attrs.intervals_goal.max_sample_us = 10 * 1000 * 1000;
+	}
+	err = damon_set_attrs(ctx, &attrs);
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
2.39.5
