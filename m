Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF466E8
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D7BC43140;
	Tue, 13 Sep 2022 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091101;
	bh=ucRX7WkVCPXQIajil5D7e+L59pOLx2Mv/t/yKy7/hEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBYnta/2AGgdSUfUisgCHWC65vMnHRWb5HvI3ucabhjRnXgU4A+2diqOC1pIausW/
	 6hEar6RKEs6hAvo8D83Nq3z0u/51qnxVOo7kcMsDkgcLgzAVCWpsrdBeJynm7a6TTa
	 k3mAQdnT0J0dNNB76+y4Rr1J7IaWHJL0cYNZ9zmipXrbWx0BLJBkh1LvAxAP6eH0J1
	 I+hCklmdP67C89sHRL0yL+gJ8zZuKb4xScKrmLNfOj6bsHukkVVEu/xRwGyXd7Dgid
	 xUAarQyc6+MDXpxIDgG8PetXTzp2NqGDhUSladDw6OmX5df7xqI0fTRbMiYgKtd8VF
	 tuGJxth1fI8+A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/22] mm/damon/lru_sort: use monitoring attributes parameters generaotr macro
Date: Tue, 13 Sep 2022 17:44:37 +0000
Message-Id: <20220913174449.50645-11-sj@kernel.org>
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
DAMON monitoring attributes using the generator macro to simplify the
code and reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 47 +++++----------------------------------------
 1 file changed, 5 insertions(+), 42 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index ade985b83652..e95626acee6f 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -13,6 +13,8 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 
+#include "modules-common.h"
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
@@ -128,52 +130,13 @@ static unsigned long wmarks_low __read_mostly = 50;
 module_param(wmarks_low, ulong, 0600);
 
 static struct damon_attrs damon_lru_sort_mon_attrs = {
-	.sample_interval = 5000,
-	.aggr_interval = 100000,
+	.sample_interval = 5000,	/* 5 ms */
+	.aggr_interval = 100000,	/* 100 ms */
 	.ops_update_interval = 0,
 	.min_nr_regions = 10,
 	.max_nr_regions = 1000,
 };
-
-/*
- * Sampling interval for the monitoring in microseconds.
- *
- * The sampling interval of DAMON for the hot/cold memory monitoring.  Please
- * refer to the DAMON documentation for more detail.  5 ms by default.
- */
-module_param_named(sample_interval, damon_lru_sort_mon_attrs.sample_interval,
-		ulong, 0600);
-
-/*
- * Aggregation interval for the monitoring in microseconds.
- *
- * The aggregation interval of DAMON for the hot/cold memory monitoring.
- * Please refer to the DAMON documentation for more detail.  100 ms by default.
- */
-module_param_named(aggr_interval, damon_lru_sort_mon_attrs.aggr_interval, ulong,
-		0600);
-
-/*
- * Minimum number of monitoring regions.
- *
- * The minimal number of monitoring regions of DAMON for the hot/cold memory
- * monitoring.  This can be used to set lower-bound of the monitoring quality.
- * But, setting this too high could result in increased monitoring overhead.
- * Please refer to the DAMON documentation for more detail.  10 by default.
- */
-module_param_named(min_nr_regions, damon_lru_sort_mon_attrs.min_nr_regions,
-		ulong, 0600);
-
-/*
- * Maximum number of monitoring regions.
- *
- * The maximum number of monitoring regions of DAMON for the hot/cold memory
- * monitoring.  This can be used to set upper-bound of the monitoring overhead.
- * However, setting this too low could result in bad monitoring quality.
- * Please refer to the DAMON documentation for more detail.  1000 by default.
- */
-module_param_named(max_nr_regions, damon_lru_sort_mon_attrs.max_nr_regions,
-		ulong, 0600);
+DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_lru_sort_mon_attrs);
 
 /*
  * Start of the target memory region in physical address.
-- 
2.25.1

