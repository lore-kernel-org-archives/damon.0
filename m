Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE2622
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 02:41:19 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VP7M5Ao_1662691269;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VP7M5Ao_1662691269)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 10:41:10 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH V4] mm/damon: Remove duplicate get_monitoring_region() definitions
Date: Fri,  9 Sep 2022 10:41:05 +0800
Message-Id: <20220909024105.84831-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lru_sort.c and reclaim.c, they are all defining get_monitoring_region()
function, there is no need to define it separately.

As 'get_monitoring_region()' is not a 'static' function anymore, we try
to use a prefix to distinguish with other functions, so there rename it
to 'damon_find_biggest_system_ram'.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 11 +++++++++++
 mm/damon/core.c       | 29 +++++++++++++++++++++++++++++
 mm/damon/lru_sort.c   | 37 ++-----------------------------------
 mm/damon/reclaim.c    | 37 ++-----------------------------------
 4 files changed, 44 insertions(+), 70 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7b1f4a488230..6c863b281fb2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -448,6 +448,16 @@ struct damon_ctx {
 	struct list_head schemes;
 };
 
+/**
+ * struct damon_system_ram_region - System RAM resource address region of [@start, @end).
+ * @start:	Start address of the  (inclusive).
+ * @end:	End address of the region (exclusive).
+ */
+struct damon_system_ram_region {
+	unsigned long start;
+	unsigned long end;
+};
+
 static inline struct damon_region *damon_next_region(struct damon_region *r)
 {
 	return container_of(r->list.next, struct damon_region, list);
@@ -500,6 +510,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
+bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
 
 struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d25dc582fe3..d07181e1473b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -276,6 +276,35 @@ struct damos *damon_new_scheme(
 	return scheme;
 }
 
+static int walk_system_ram(struct resource *res, void *arg)
+{
+	struct damon_system_ram_region *a = arg;
+
+	if (a->end - a->start < resource_size(res)) {
+		a->start = res->start;
+		a->end = res->end;
+	}
+	return 0;
+}
+
+/*
+ * Find biggest 'System RAM' resource and store its start and end address in
+ * @start and @end, respectively.  If no System RAM is found, returns false.
+ */
+bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
+
+{
+	struct damon_system_ram_region arg = {};
+
+	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
+	if (arg.end <= arg.start)
+		return false;
+
+	*start = arg.start;
+	*end = arg.end;
+	return true;
+}
+
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
 {
 	list_add_tail(&s->list, &ctx->schemes);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9de6f00a71c5..b8ec52739e0f 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -257,39 +257,6 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-struct damon_lru_sort_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct damon_lru_sort_ram_walk_arg *a = arg;
-
-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
-{
-	struct damon_lru_sort_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
-		return false;
-
-	*start = arg.start;
-	*end = arg.end;
-	return true;
-}
-
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
@@ -404,8 +371,8 @@ static int damon_lru_sort_apply_parameters(void)
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
 	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
+	    !damon_find_biggest_system_ram(&monitor_region_start,
+					   &monitor_region_end))
 		return -EINVAL;
 	addr_range.start = monitor_region_start;
 	addr_range.end = monitor_region_end;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a7faf51b4bd4..7d41913cb0e1 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -229,39 +229,6 @@ module_param(nr_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
-struct damon_reclaim_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct damon_reclaim_ram_walk_arg *a = arg;
-
-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
-{
-	struct damon_reclaim_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
-		return false;
-
-	*start = arg.start;
-	*end = arg.end;
-	return true;
-}
-
 static struct damos *damon_reclaim_new_scheme(void)
 {
 	struct damos_watermarks wmarks = {
@@ -323,8 +290,8 @@ static int damon_reclaim_apply_parameters(void)
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
 	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
+	    !damon_find_biggest_system_ram(&monitor_region_start,
+					   &monitor_region_end))
 		return -EINVAL;
 	addr_range.start = monitor_region_start;
 	addr_range.end = monitor_region_end;
-- 
2.31.0

