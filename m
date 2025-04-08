Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3322638B8
	for <damon@lists.linux.dev>; Tue,  8 Apr 2025 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098982; cv=none; b=bPp6M+T2/KSGYhUAREUmw7RBC8gXwYbzkBEQX2EFGqJyJAEwfmhnUzOBP/ofI1BhA/L7QhCN4I4AhiOQcsmZFIb9qxCP5MYXeW5+IBWFPcBMtj77Xo9KJno9zPoe/ef90ALguuo9WbliNEnECR5Pmp/cypS1W2gURELDrHeHf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098982; c=relaxed/simple;
	bh=51YpjJOo472s6Cm8I3PzSJo9ZCqhIuFGH16ewSPMnAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T5YElBOZf/VEsYFx7LziJxWc4JweF62ahtVoWg5i4la7X2PBFvawaEWNVMJBiycgb3BQWkEIWtxncjNOj5Xv0VFmSvOTaT65KlhHfi//FICNCbHMCpjGJFZ/8jRX5Hk15lYPr/P2d8D1kJrzw3fJ1OH4Vf5sGGASe3pbewb8d5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZWyv468Jyz1f1pd;
	Tue,  8 Apr 2025 15:51:12 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FB921402D0;
	Tue,  8 Apr 2025 15:56:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 15:56:08 +0800
From: Ze Zuo <zuoze1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <zuoze1@huawei.com>,
	<wangkefeng.wang@huawei.com>
Subject: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Tue, 8 Apr 2025 15:55:53 +0800
Message-ID: <20250408075553.959388-1-zuoze1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Previously, DAMON's physical address space monitoring only supported
memory ranges below 4GB on LPAE-enabled systems. This was due to
the use of 'unsigned long' in 'struct damon_addr_range', which is
32-bit on ARM32 even with LPAE enabled.

This patch modifies the data types to properly support >4GB physical
address spaces:
1. Changes 'start' and 'end' in 'struct damon_addr_range' from
   'unsigned long' to 'unsigned long long' (u64)
2. Updates all related arithmetic operations and comparisons
3. Adjusts print formats from %lu to %llu where needed
4. Maintains backward compatibility for non-LPAE systems

Since the overhead of always using u64 is negligible on 32-bit systems,
should we prefer this simplified approach over the conditional typedef?

Alternative implementation approaches to consider:

1. Introduce damon_addr_t that adapts to CONFIG_PHYS_ADDR_T_64BIT
2. Convert all DAMON address operations to use this type

Just like implementation:
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
    typedef unsigned long long damon_addr_t;
 #else
    typedef unsigned long damon_addr_t;
 #endif

This method could potentially cause minor issues with print formatting
and division operations. We'd appreciate any suggestions for better
approaches. Thank you for your input.

The patch change allows DAMON to work with:
- 32-bit ARM with LPAE (40-bit physical addresses)
- 64-bit ARM systems
- x86_64 physical address monitoring
while preserving existing behavior on 32-bit systems without LPAE.

Signed-off-by: Ze Zuo <zuoze1@huawei.com>
---
 include/linux/damon.h     | 36 ++++++++++++------------
 mm/damon/core.c           | 58 ++++++++++++++++++++-------------------
 mm/damon/lru_sort.c       | 10 +++----
 mm/damon/modules-common.h |  6 ++--
 mm/damon/paddr.c          | 38 ++++++++++++-------------
 mm/damon/reclaim.c        | 10 +++----
 mm/damon/sysfs-schemes.c  | 32 ++++++++++-----------
 mm/damon/sysfs.c          |  8 +++---
 mm/damon/vaddr.c          | 14 +++++-----
 9 files changed, 108 insertions(+), 104 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 47e36e6ea203..f1673591f7b0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -20,7 +20,8 @@
 #define DAMOS_MAX_SCORE		(99)
 
 /* Get a random number in [l, r) */
-static inline unsigned long damon_rand(unsigned long l, unsigned long r)
+static inline unsigned long long damon_rand(unsigned long long l,
+					    unsigned long long r)
 {
 	return l + get_random_u32_below(r - l);
 }
@@ -31,8 +32,8 @@ static inline unsigned long damon_rand(unsigned long l, unsigned long r)
  * @end:	End address of the region (exclusive).
  */
 struct damon_addr_range {
-	unsigned long start;
-	unsigned long end;
+	unsigned long long start;
+	unsigned long long end;
 };
 
 /**
@@ -75,7 +76,7 @@ struct damon_size_range {
  */
 struct damon_region {
 	struct damon_addr_range ar;
-	unsigned long sampling_addr;
+	unsigned long long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned int nr_accesses_bp;
 	struct list_head list;
@@ -228,9 +229,9 @@ struct damos_quota_goal {
 struct damos_quota {
 	unsigned long reset_interval;
 	unsigned long ms;
-	unsigned long sz;
+	unsigned long long sz;
 	struct list_head goals;
-	unsigned long esz;
+	unsigned long long esz;
 
 	unsigned int weight_sz;
 	unsigned int weight_nr_accesses;
@@ -238,14 +239,14 @@ struct damos_quota {
 
 /* private: */
 	/* For throughput estimation */
-	unsigned long total_charged_sz;
+	unsigned long long total_charged_sz;
 	unsigned long total_charged_ns;
 
 	/* For charging the quota */
-	unsigned long charged_sz;
+	unsigned long long charged_sz;
 	unsigned long charged_from;
 	struct damon_target *charge_target_from;
-	unsigned long charge_addr_from;
+	unsigned long long charge_addr_from;
 
 	/* For prioritization */
 	unsigned int min_score;
@@ -324,10 +325,10 @@ struct damos_watermarks {
  */
 struct damos_stat {
 	unsigned long nr_tried;
-	unsigned long sz_tried;
+	unsigned long long sz_tried;
 	unsigned long nr_applied;
-	unsigned long sz_applied;
-	unsigned long sz_ops_filter_passed;
+	unsigned long long sz_applied;
+	unsigned long long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
@@ -434,7 +435,7 @@ struct damos_walk_control {
  */
 struct damos_access_pattern {
 	unsigned long min_sz_region;
-	unsigned long max_sz_region;
+	unsigned long long max_sz_region;
 	unsigned int min_nr_accesses;
 	unsigned int max_nr_accesses;
 	unsigned int min_age_region;
@@ -592,7 +593,7 @@ struct damon_operations {
 			struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
-			struct damos *scheme, unsigned long *sz_filter_passed);
+			struct damos *scheme, unsigned long long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
 };
@@ -806,7 +807,7 @@ static inline struct damon_region *damon_first_region(struct damon_target *t)
 	return list_first_entry(&t->regions_list, struct damon_region, list);
 }
 
-static inline unsigned long damon_sz_region(struct damon_region *r)
+static inline unsigned long long damon_sz_region(struct damon_region *r)
 {
 	return r->ar.end - r->ar.start;
 }
@@ -853,7 +854,8 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
-struct damon_region *damon_new_region(unsigned long start, unsigned long end);
+struct damon_region *damon_new_region(unsigned long long start,
+				      unsigned long long end);
 
 /*
  * Add a region between two other regions
@@ -933,7 +935,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-				unsigned long *start, unsigned long *end);
+			unsigned long long *start, unsigned long long *end);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f0c1676f0599..f0774ee6bed2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -118,7 +118,8 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
  *
  * Returns the pointer to the new struct if success, or NULL otherwise
  */
-struct damon_region *damon_new_region(unsigned long start, unsigned long end)
+struct damon_region *damon_new_region(unsigned long long start,
+				      unsigned long long end)
 {
 	struct damon_region *region;
 
@@ -1169,11 +1170,11 @@ int damon_nr_running_ctxs(void)
 }
 
 /* Returns the size upper limit for each monitoring region */
-static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
+static unsigned long long damon_region_sz_limit(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long sz = 0;
+	unsigned long long sz = 0;
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
@@ -1181,7 +1182,7 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	}
 
 	if (ctx->attrs.min_nr_regions)
-		sz /= ctx->attrs.min_nr_regions;
+		sz = div64_u64(sz, ctx->attrs.min_nr_regions);
 	if (sz < DAMON_MIN_REGION)
 		sz = DAMON_MIN_REGION;
 
@@ -1471,7 +1472,7 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
 }
 
 static void damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
+			struct damon_region *r, unsigned long long sz_r);
 
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
@@ -1525,7 +1526,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
 	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
-	unsigned long sz_to_skip;
+	unsigned long long sz_to_skip;
 
 	/* Skip previously charged regions */
 	if (quota->charge_target_from) {
@@ -1560,8 +1561,8 @@ static bool damos_skip_charged_region(struct damon_target *t,
 }
 
 static void damos_update_stat(struct damos *s,
-		unsigned long sz_tried, unsigned long sz_applied,
-		unsigned long sz_ops_filter_passed)
+		unsigned long long sz_tried, unsigned long long sz_applied,
+		unsigned long long sz_ops_filter_passed)
 {
 	s->stat.nr_tried++;
 	s->stat.sz_tried += sz_tried;
@@ -1577,7 +1578,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
-	unsigned long start, end;
+	unsigned long long start, end;
 
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
@@ -1726,10 +1727,10 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
-	unsigned long sz = damon_sz_region(r);
+	unsigned long long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
-	unsigned long sz_applied = 0;
-	unsigned long sz_ops_filter_passed = 0;
+	unsigned long long sz_applied = 0;
+	unsigned long long sz_ops_filter_passed = 0;
 	/*
 	 * We plan to support multiple context per kdamond, as DAMON sysfs
 	 * implies with 'nr_contexts' file.  Nevertheless, only single context
@@ -1947,8 +1948,8 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (quota->ms) {
 		if (quota->total_charged_ns)
-			throughput = quota->total_charged_sz * 1000000 /
-				quota->total_charged_ns;
+			throughput = div64_u64(quota->total_charged_sz * 1000000,
+						quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
@@ -2058,12 +2059,13 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 static void damon_merge_two_regions(struct damon_target *t,
 		struct damon_region *l, struct damon_region *r)
 {
-	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
+	unsigned long long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
+
+	l->nr_accesses = div64_u64(l->nr_accesses * sz_l + r->nr_accesses * sz_r,
+				    sz_l + sz_r);
 
-	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
-			(sz_l + sz_r);
 	l->nr_accesses_bp = l->nr_accesses * 10000;
-	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
+	l->age = div64_u64(l->age * sz_l + r->age * sz_r, sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	damon_destroy_region(r, t);
 }
@@ -2076,7 +2078,7 @@ static void damon_merge_two_regions(struct damon_target *t,
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-				   unsigned long sz_limit)
+				   unsigned long long sz_limit)
 {
 	struct damon_region *r, *prev = NULL, *next;
 
@@ -2113,7 +2115,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
  * met while increasing @threshold up to possible maximum level.
  */
 static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
-				  unsigned long sz_limit)
+				  unsigned long long sz_limit)
 {
 	struct damon_target *t;
 	unsigned int nr_regions;
@@ -2139,7 +2141,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
  * sz_r		size of the first sub-region that will be made
  */
 static void damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r)
+			struct damon_region *r, unsigned long long sz_r)
 {
 	struct damon_region *new;
 
@@ -2161,7 +2163,7 @@ static void damon_split_region_at(struct damon_target *t,
 static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 {
 	struct damon_region *r, *next;
-	unsigned long sz_region, sz_sub = 0;
+	unsigned long long sz_region, sz_sub = 0;
 	int i;
 
 	damon_for_each_region_safe(r, next, t) {
@@ -2173,8 +2175,8 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
-			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, DAMON_MIN_REGION);
+			sz_sub = ALIGN_DOWN(div_u64(damon_rand(1, 10) *
+					    sz_region, 10), DAMON_MIN_REGION);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
@@ -2393,7 +2395,7 @@ static int kdamond_fn(void *data)
 	struct damon_target *t;
 	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
-	unsigned long sz_limit = 0;
+	unsigned long long sz_limit = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
@@ -2555,8 +2557,8 @@ static int walk_system_ram(struct resource *res, void *arg)
  * Find biggest 'System RAM' resource and store its start and end address in
  * @start and @end, respectively.  If no System RAM is found, returns false.
  */
-static bool damon_find_biggest_system_ram(unsigned long *start,
-						unsigned long *end)
+static bool damon_find_biggest_system_ram(unsigned long long *start,
+						unsigned long long *end)
 
 {
 	struct damon_system_ram_region arg = {};
@@ -2586,7 +2588,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-			unsigned long *start, unsigned long *end)
+			unsigned long long *start, unsigned long long *end)
 {
 	struct damon_addr_range addr_range;
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..eb1af79638b1 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -99,8 +99,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_lru_sort_mon_attrs);
  * The start physical address of memory region that DAMON_LRU_SORT will do work
  * against.  By default, biggest System RAM is used as the region.
  */
-static unsigned long monitor_region_start __read_mostly;
-module_param(monitor_region_start, ulong, 0600);
+static unsigned long long monitor_region_start __read_mostly;
+module_param(monitor_region_start, ullong, 0600);
 
 /*
  * End of the target memory region in physical address.
@@ -108,8 +108,8 @@ module_param(monitor_region_start, ulong, 0600);
  * The end physical address of memory region that DAMON_LRU_SORT will do work
  * against.  By default, biggest System RAM is used as the region.
  */
-static unsigned long monitor_region_end __read_mostly;
-module_param(monitor_region_end, ulong, 0600);
+static unsigned long long monitor_region_end __read_mostly;
+module_param(monitor_region_end, ullong, 0600);
 
 /*
  * PID of the DAMON thread
@@ -133,7 +133,7 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 static struct damos_access_pattern damon_lru_sort_stub_pattern = {
 	/* Find regions having PAGE_SIZE or larger size */
 	.min_sz_region = PAGE_SIZE,
-	.max_sz_region = ULONG_MAX,
+	.max_sz_region = ULLONG_MAX,
 	/* no matter its access frequency */
 	.min_nr_accesses = 0,
 	.max_nr_accesses = UINT_MAX,
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417005..9ac9d03ecd4c 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -24,7 +24,7 @@
 
 #define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
 	DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(quota)			\
-	module_param_named(quota_sz, quota.sz, ulong, 0600);
+	module_param_named(quota_sz, quota.sz, ullong, 0600);
 
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
@@ -36,11 +36,11 @@
 #define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
 		succ_name, qt_exceed_name)				\
 	module_param_named(nr_##try_name, stat.nr_tried, ulong, 0400);	\
-	module_param_named(bytes_##try_name, stat.sz_tried, ulong,	\
+	module_param_named(bytes_##try_name, stat.sz_tried, ullong,	\
 			0400);						\
 	module_param_named(nr_##succ_name, stat.nr_applied, ulong,	\
 			0400);						\
-	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
+	module_param_named(bytes_##succ_name, stat.sz_applied, ullong,	\
 			0400);						\
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 1b70d3f36046..b1ce866170f7 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -58,7 +58,7 @@ static void damon_folio_mkold(struct folio *folio)
 
 }
 
-static void damon_pa_mkold(unsigned long paddr)
+static void damon_pa_mkold(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 
@@ -156,7 +156,7 @@ static bool damon_folio_young(struct folio *folio)
 	return accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -173,7 +173,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 static void __damon_pa_check_access(struct damon_region *r,
 		struct damon_attrs *attrs)
 {
-	static unsigned long last_addr;
+	static phys_addr_t last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
 
@@ -277,10 +277,10 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
-		unsigned long *sz_filter_passed)
+static unsigned long long damon_pa_pageout(struct damon_region *r, struct damos *s,
+		unsigned long long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	unsigned long long addr, applied;
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
@@ -334,11 +334,11 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
-static inline unsigned long damon_pa_mark_accessed_or_deactivate(
+static inline unsigned long long damon_pa_mark_accessed_or_deactivate(
 		struct damon_region *r, struct damos *s, bool mark_accessed,
-		unsigned long *sz_filter_passed)
+		unsigned long long *sz_filter_passed)
 {
-	unsigned long addr, applied = 0;
+	unsigned long long addr, applied = 0;
 	struct folio *folio;
 
 	addr = r->ar.start;
@@ -367,15 +367,15 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	return applied * PAGE_SIZE;
 }
 
-static unsigned long damon_pa_mark_accessed(struct damon_region *r,
-	struct damos *s, unsigned long *sz_filter_passed)
+static unsigned long long damon_pa_mark_accessed(struct damon_region *r,
+	struct damos *s, unsigned long long *sz_filter_passed)
 {
 	return damon_pa_mark_accessed_or_deactivate(r, s, true,
 			sz_filter_passed);
 }
 
-static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
-	struct damos *s, unsigned long *sz_filter_passed)
+static unsigned long long damon_pa_deactivate_pages(struct damon_region *r,
+	struct damos *s, unsigned long long *sz_filter_passed)
 {
 	return damon_pa_mark_accessed_or_deactivate(r, s, false,
 			sz_filter_passed);
@@ -502,10 +502,10 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 	return nr_migrated;
 }
 
-static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
-		unsigned long *sz_filter_passed)
+static unsigned long long damon_pa_migrate(struct damon_region *r, struct damos *s,
+		unsigned long long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	unsigned long long addr, applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
@@ -545,9 +545,9 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 }
 
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
-		unsigned long *sz_filter_passed)
+		unsigned long long *sz_filter_passed)
 {
-	unsigned long addr;
+	unsigned long long addr;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
@@ -573,7 +573,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme, unsigned long *sz_filter_passed)
+		struct damos *scheme, unsigned long long *sz_filter_passed)
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a675150965e0..6bde292fe959 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -116,8 +116,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_reclaim_mon_attrs);
  * The start physical address of memory region that DAMON_RECLAIM will do work
  * against.  By default, biggest System RAM is used as the region.
  */
-static unsigned long monitor_region_start __read_mostly;
-module_param(monitor_region_start, ulong, 0600);
+static unsigned long long monitor_region_start __read_mostly;
+module_param(monitor_region_start, ullong, 0600);
 
 /*
  * End of the target memory region in physical address.
@@ -125,8 +125,8 @@ module_param(monitor_region_start, ulong, 0600);
  * The end physical address of memory region that DAMON_RECLAIM will do work
  * against.  By default, biggest System RAM is used as the region.
  */
-static unsigned long monitor_region_end __read_mostly;
-module_param(monitor_region_end, ulong, 0600);
+static unsigned long long monitor_region_end __read_mostly;
+module_param(monitor_region_end, ullong, 0600);
 
 /*
  * Skip anonymous pages reclamation.
@@ -158,7 +158,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 	struct damos_access_pattern pattern = {
 		/* Find regions having PAGE_SIZE or larger size */
 		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
+		.max_sz_region = ULLONG_MAX,
 		/* and not accessed at all */
 		.min_nr_accesses = 0,
 		.max_nr_accesses = 0,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 23b562df0839..d6fa40a913a5 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -19,7 +19,7 @@ struct damon_sysfs_scheme_region {
 	struct damon_addr_range ar;
 	unsigned int nr_accesses;
 	unsigned int age;
-	unsigned long sz_filter_passed;
+	unsigned long long sz_filter_passed;
 	struct list_head list;
 };
 
@@ -45,7 +45,7 @@ static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->ar.start);
+	return sysfs_emit(buf, "%llu\n", region->ar.start);
 }
 
 static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -54,7 +54,7 @@ static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->ar.end);
+	return sysfs_emit(buf, "%llu\n", region->ar.end);
 }
 
 static ssize_t nr_accesses_show(struct kobject *kobj,
@@ -81,7 +81,7 @@ static ssize_t sz_filter_passed_show(struct kobject *kobj,
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->sz_filter_passed);
+	return sysfs_emit(buf, "%llu\n", region->sz_filter_passed);
 }
 
 static void damon_sysfs_scheme_region_release(struct kobject *kobj)
@@ -132,7 +132,7 @@ struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
 	struct list_head regions_list;
 	int nr_regions;
-	unsigned long total_bytes;
+	unsigned long long total_bytes;
 };
 
 static struct damon_sysfs_scheme_regions *
@@ -157,7 +157,7 @@ static ssize_t total_bytes_show(struct kobject *kobj,
 	struct damon_sysfs_scheme_regions *regions = container_of(kobj,
 			struct damon_sysfs_scheme_regions, kobj);
 
-	return sysfs_emit(buf, "%lu\n", regions->total_bytes);
+	return sysfs_emit(buf, "%llu\n", regions->total_bytes);
 }
 
 static void damon_sysfs_scheme_regions_rm_dirs(
@@ -199,10 +199,10 @@ static const struct kobj_type damon_sysfs_scheme_regions_ktype = {
 struct damon_sysfs_stats {
 	struct kobject kobj;
 	unsigned long nr_tried;
-	unsigned long sz_tried;
+	unsigned long long sz_tried;
 	unsigned long nr_applied;
-	unsigned long sz_applied;
-	unsigned long sz_ops_filter_passed;
+	unsigned long long sz_applied;
+	unsigned long long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
@@ -226,7 +226,7 @@ static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_stats *stats = container_of(kobj,
 			struct damon_sysfs_stats, kobj);
 
-	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
+	return sysfs_emit(buf, "%llu\n", stats->sz_tried);
 }
 
 static ssize_t nr_applied_show(struct kobject *kobj,
@@ -244,7 +244,7 @@ static ssize_t sz_applied_show(struct kobject *kobj,
 	struct damon_sysfs_stats *stats = container_of(kobj,
 			struct damon_sysfs_stats, kobj);
 
-	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
+	return sysfs_emit(buf, "%llu\n", stats->sz_applied);
 }
 
 static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
@@ -253,7 +253,7 @@ static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
 	struct damon_sysfs_stats *stats = container_of(kobj,
 			struct damon_sysfs_stats, kobj);
 
-	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed);
+	return sysfs_emit(buf, "%llu\n", stats->sz_ops_filter_passed);
 }
 
 static ssize_t qt_exceeds_show(struct kobject *kobj,
@@ -481,7 +481,7 @@ static ssize_t addr_start_show(struct kobject *kobj,
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
 
-	return sysfs_emit(buf, "%lu\n", filter->addr_range.start);
+	return sysfs_emit(buf, "%llu\n", filter->addr_range.start);
 }
 
 static ssize_t addr_start_store(struct kobject *kobj,
@@ -489,7 +489,7 @@ static ssize_t addr_start_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	int err = kstrtoul(buf, 0, &filter->addr_range.start);
+	int err = kstrtoull(buf, 0, &filter->addr_range.start);
 
 	return err ? err : count;
 }
@@ -500,7 +500,7 @@ static ssize_t addr_end_show(struct kobject *kobj,
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
 
-	return sysfs_emit(buf, "%lu\n", filter->addr_range.end);
+	return sysfs_emit(buf, "%llu\n", filter->addr_range.end);
 }
 
 static ssize_t addr_end_store(struct kobject *kobj,
@@ -508,7 +508,7 @@ static ssize_t addr_end_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	int err = kstrtoul(buf, 0, &filter->addr_range.end);
+	int err = kstrtoull(buf, 0, &filter->addr_range.end);
 
 	return err ? err : count;
 }
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1af6aff35d84..72e0d0ad266f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -31,7 +31,7 @@ static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->ar.start);
+	return sysfs_emit(buf, "%llu\n", region->ar.start);
 }
 
 static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -39,7 +39,7 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->ar.start);
+	int err = kstrtoull(buf, 0, &region->ar.start);
 
 	return err ? err : count;
 }
@@ -50,7 +50,7 @@ static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->ar.end);
+	return sysfs_emit(buf, "%llu\n", region->ar.end);
 }
 
 static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -58,7 +58,7 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->ar.end);
+	int err = kstrtoull(buf, 0, &region->ar.end);
 
 	return err ? err : count;
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e6d99106a7f9..cd9a1e716534 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -64,9 +64,9 @@ static struct mm_struct *damon_get_mm(struct damon_target *t)
 static int damon_va_evenly_split_region(struct damon_target *t,
 		struct damon_region *r, unsigned int nr_pieces)
 {
-	unsigned long sz_orig, sz_piece, orig_end;
+	unsigned long long sz_orig, sz_piece, orig_end;
 	struct damon_region *n = NULL, *next;
-	unsigned long start;
+	unsigned long long start;
 	unsigned int i;
 
 	if (!r || !nr_pieces)
@@ -77,7 +77,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+	sz_piece = ALIGN_DOWN(div_u64(sz_orig, nr_pieces), DAMON_MIN_REGION);
 
 	if (!sz_piece)
 		return -EINVAL;
@@ -241,7 +241,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 	struct damon_target *ti;
 	struct damon_region *r;
 	struct damon_addr_range regions[3];
-	unsigned long sz = 0, nr_pieces;
+	unsigned long long sz = 0, nr_pieces;
 	int i, tidx = 0;
 
 	if (damon_va_three_regions(t, regions)) {
@@ -257,7 +257,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 	for (i = 0; i < 3; i++)
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
-		sz /= ctx->attrs.min_nr_regions;
+		sz = div64_u64(sz, ctx->attrs.min_nr_regions);
 	if (sz < DAMON_MIN_REGION)
 		sz = DAMON_MIN_REGION;
 
@@ -270,7 +270,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		}
 		damon_add_region(r, t);
 
-		nr_pieces = (regions[i].end - regions[i].start) / sz;
+		nr_pieces = div64_u64(regions[i].end - regions[i].start, sz);
 		damon_va_evenly_split_region(t, r, nr_pieces);
 	}
 }
@@ -655,7 +655,7 @@ static unsigned long damos_madvise(struct damon_target *target,
 
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme, unsigned long *sz_filter_passed)
+		struct damos *scheme, unsigned long long *sz_filter_passed)
 {
 	int madv_action;
 
-- 
2.25.1

