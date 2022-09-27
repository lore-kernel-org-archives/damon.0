Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC82362
	for <damon@lists.linux.dev>; Tue, 27 Sep 2022 00:20:00 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQpBVKM_1664237989;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQpBVKM_1664237989)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 08:19:50 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH v2 1/2] mm/damon: move sz_damon_region to damon_sz_region
Date: Tue, 27 Sep 2022 08:19:45 +0800
Message-Id: <20220927001946.85375-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here, i rename sz_damon_region() to damon_sz_region(), and move it to
"include/linux/damon.h", because in many places, we can to use this func.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---

Changes from v1
( https://lore.kernel.org/linux-mm/20220926071100.76379-1-xhao@linux.alibaba.com/)
- Move sz_damon_region() to static inline in include/linux/damon.h
- Rename sz_damon_region() to damon_sz_region()

 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 9 ++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ed5470f50bab..620ada094c3b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -484,6 +484,12 @@ static inline struct damon_region *damon_first_region(struct damon_target *t)
 	return list_first_entry(&t->regions_list, struct damon_region, list);
 }

+static inline unsigned long damon_sz_region(struct damon_region *r)
+{
+	return r->ar.end - r->ar.start;
+}
+
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4de8c7c52979..5b9e0d585aef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -864,18 +864,13 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }

-static inline unsigned long sz_damon_region(struct damon_region *r)
-{
-	return r->ar.end - r->ar.start;
-}
-
 /*
  * Merge two adjacent regions into one region
  */
 static void damon_merge_two_regions(struct damon_target *t,
 		struct damon_region *l, struct damon_region *r)
 {
-	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
+	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);

 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
@@ -904,7 +899,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,

 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
-		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
+		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
 			damon_merge_two_regions(t, prev, r);
 		else
 			prev = r;
--
2.31.0
