Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C93D61
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 11:44:27 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPnAFuw_1663155541;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPnAFuw_1663155541)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 19:39:03 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH V2] mm/damon: simplify scheme create in lru_sort.c
Date: Wed, 14 Sep 2022 19:38:59 +0800
Message-Id: <20220914113859.37637-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
they have so much in common, so we can combine them into a single
function, and we just need to distinguish their differences.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/lru_sort.c | 57 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 07a0908963fd..2eac907e866d 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -135,17 +135,40 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-static struct damos *damon_lru_sort_new_scheme(
-		struct damos_access_pattern *pattern, enum damos_action action)
+static struct damos *damon_lru_sort_new_scheme(unsigned int thres,
+					       enum damos_action action)
 {
+	struct damos_access_pattern pattern = {
+		/* Find regions having PAGE_SIZE or larger size */
+		.min_sz_region = PAGE_SIZE,
+		.max_sz_region = ULONG_MAX,
+		/* and accessed for more than the threshold */
+		.min_nr_accesses = 0,
+		.max_nr_accesses = 0,
+		/* no matter its age */
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
 	struct damos_quota quota = damon_lru_sort_quota;
 
 	/* Use half of total quota for hot/cold pages sorting */
 	quota.ms = quota.ms / 2;
 
+	switch (action) {
+	case DAMOS_LRU_PRIO:
+		pattern.min_nr_accesses = thres;
+		pattern.max_nr_accesses = UINT_MAX;
+		break;
+	case DAMOS_LRU_DEPRIO:
+		pattern.min_age_region = thres;
+		break;
+	default:
+		return NULL;
+	}
+
 	return damon_new_scheme(
 			/* find the pattern, and */
-			pattern,
+			&pattern,
 			/* (de)prioritize on LRU-lists */
 			action,
 			/* under the quota. */
@@ -157,37 +180,13 @@ static struct damos *damon_lru_sort_new_scheme(
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and accessed for more than the threshold */
-		.min_nr_accesses = hot_thres,
-		.max_nr_accesses = UINT_MAX,
-		/* no matter its age */
-		.min_age_region = 0,
-		.max_age_region = UINT_MAX,
-	};
-
-	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
+	return damon_lru_sort_new_scheme(hot_thres, DAMOS_LRU_PRIO);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
 static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and not accessed at all */
-		.min_nr_accesses = 0,
-		.max_nr_accesses = 0,
-		/* for min_age or more micro-seconds */
-		.min_age_region = cold_thres,
-		.max_age_region = UINT_MAX,
-	};
-
-	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
+	return damon_lru_sort_new_scheme(cold_thres, DAMOS_LRU_DEPRIO);
 }
 
 static int damon_lru_sort_apply_parameters(void)
-- 
2.31.0

