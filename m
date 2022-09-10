Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DC184E
	for <damon@lists.linux.dev>; Sat, 10 Sep 2022 16:55:48 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPFllr8_1662828937;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPFllr8_1662828937)
          by smtp.aliyun-inc.com;
          Sun, 11 Sep 2022 00:55:39 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH] mm/damon: simplify scheme create in damon_lru_sort_apply_parameters
Date: Sun, 11 Sep 2022 00:55:36 +0800
Message-Id: <20220910165536.99023-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_lru_sort_apply_parameters(), we can use damon_set_schemes() to
replace the way of creating the first 'scheme' in original code, this
makes the code look cleaner.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/lru_sort.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index b8ec52739e0f..b581b7b76fb2 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -350,17 +350,15 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;

-	/* free previously set schemes */
-	damon_for_each_scheme_safe(scheme, next_scheme, ctx)
-		damon_destroy_scheme(scheme);
-
 	/* aggr_interval / sample_interval is the maximum nr_accesses */
 	hot_thres = aggr_interval / sample_interval * hot_thres_access_freq /
 		1000;
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
 		return -ENOMEM;
-	damon_add_scheme(ctx, scheme);
+	err = damon_set_schemes(ctx, &scheme, 1);
+	if (err)
+		return err;

 	cold_thres = cold_min_age / aggr_interval;
 	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
--
2.31.0
