Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A766E7
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7E9C43151;
	Tue, 13 Sep 2022 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091103;
	bh=EUuPVZLbnXd6SBFdDW4wKU/+gayhFIMwTcrg4+QxxWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpUlnHdc26OPTg1yxMTXlAowNfl6YjCTuoTtN5FJ4KAKQb/tSBSm7kdH+sEMY9BvA
	 qPxha3Saj5x3ct+8eiJHNju+ktvYbENaL7OLwQJ41lIHCNNOiKVPt36D6IAzDL6+P6
	 hMrnE5iJVW/z14sf/fqJnvD6hIBusVincW6EebBKMWKdFsPSvKKU7AXm8xNH3uj17g
	 wWfW3p5Z+lHIY+sH1zlQa2omZPbPxlTl436USYWCDdo7S403sapHLQ94HerP8okiOr
	 RN5OuNBhtk72du/6Q4K4nriCge71KpxuN2NYpXsqfKY9OCAS8dey9FS1w6XsOcjL7Y
	 n8JTBGkcjUNAw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/22] mm/damon/lru_sort: use watermarks parameters generator macro
Date: Tue, 13 Sep 2022 17:44:40 +0000
Message-Id: <20220913174449.50645-14-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes DAMON_LRU_SORT to generate the module parameters for
DAMOS watermarks using the generator macro to simplify the code and
reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c       | 64 ++++++---------------------------------
 mm/damon/modules-common.h |  4 +--
 2 files changed, 12 insertions(+), 56 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index e95626acee6f..20760b39b50a 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -90,44 +90,14 @@ module_param(quota_ms, ulong, 0600);
 static unsigned long quota_reset_interval_ms __read_mostly = 1000;
 module_param(quota_reset_interval_ms, ulong, 0600);
 
-/*
- * The watermarks check time interval in microseconds.
- *
- * Minimal time to wait before checking the watermarks, when DAMON_LRU_SORT is
- * enabled but inactive due to its watermarks rule.  5 seconds by default.
- */
-static unsigned long wmarks_interval __read_mostly = 5000000;
-module_param(wmarks_interval, ulong, 0600);
-
-/*
- * Free memory rate (per thousand) for the high watermark.
- *
- * If free memory of the system in bytes per thousand bytes is higher than
- * this, DAMON_LRU_SORT becomes inactive, so it does nothing but periodically
- * checks the watermarks.  200 (20%) by default.
- */
-static unsigned long wmarks_high __read_mostly = 200;
-module_param(wmarks_high, ulong, 0600);
-
-/*
- * Free memory rate (per thousand) for the middle watermark.
- *
- * If free memory of the system in bytes per thousand bytes is between this and
- * the low watermark, DAMON_LRU_SORT becomes active, so starts the monitoring
- * and the LRU-lists sorting.  150 (15%) by default.
- */
-static unsigned long wmarks_mid __read_mostly = 150;
-module_param(wmarks_mid, ulong, 0600);
-
-/*
- * Free memory rate (per thousand) for the low watermark.
- *
- * If free memory of the system in bytes per thousand bytes is lower than this,
- * DAMON_LRU_SORT becomes inactive, so it does nothing but periodically checks
- * the watermarks.  50 (5%) by default.
- */
-static unsigned long wmarks_low __read_mostly = 50;
-module_param(wmarks_low, ulong, 0600);
+struct damos_watermarks damon_lru_sort_wmarks = {
+	.metric = DAMOS_WMARK_FREE_MEM_RATE,
+	.interval = 5000000,	/* 5 seconds */
+	.high = 200,		/* 20 percent */
+	.mid = 150,		/* 15 percent */
+	.low = 50,		/* 5 percent */
+};
+DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_lru_sort_wmarks);
 
 static struct damon_attrs damon_lru_sort_mon_attrs = {
 	.sample_interval = 5000,	/* 5 ms */
@@ -242,13 +212,6 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 		.min_age_region = 0,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_watermarks wmarks = {
-		.metric = DAMOS_WMARK_FREE_MEM_RATE,
-		.interval = wmarks_interval,
-		.high = wmarks_high,
-		.mid = wmarks_mid,
-		.low = wmarks_low,
-	};
 	struct damos_quota quota = {
 		/*
 		 * Do not try LRU-lists sorting of hot pages for more than half
@@ -270,7 +233,7 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&wmarks);
+			&damon_lru_sort_wmarks);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
@@ -287,13 +250,6 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 		.min_age_region = cold_thres,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_watermarks wmarks = {
-		.metric = DAMOS_WMARK_FREE_MEM_RATE,
-		.interval = wmarks_interval,
-		.high = wmarks_high,
-		.mid = wmarks_mid,
-		.low = wmarks_low,
-	};
 	struct damos_quota quota = {
 		/*
 		 * Do not try LRU-lists sorting of cold pages for more than
@@ -316,7 +272,7 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&wmarks);
+			&damon_lru_sort_wmarks);
 }
 
 static int damon_lru_sort_apply_parameters(void)
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 1370590a37d1..4c2ce84869d5 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -18,8 +18,8 @@
 			0600);
 
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
-	module_param_named(wmarks_interval, wmarks->interval, ulong,	\
+	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
 	module_param_named(wmarks_high, wmarks.high, ulong, 0600);	\
 	module_param_named(wmarks_mid, wmarks.mid, ulong, 0600);	\
-	module_param_named(wmarks_low, wmarks.lowulong, 0600);
+	module_param_named(wmarks_low, wmarks.low, ulong, 0600);
-- 
2.25.1

