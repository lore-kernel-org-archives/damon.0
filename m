Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184C2153C6
	for <damon@lists.linux.dev>; Wed, 28 May 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430659; cv=none; b=tV+qaplTwe5PNdMUUn/7lVfCdRQSm7l1rF8eSs78hcxPYhGI43r6V0AK5CvhOwQVIGvPl2dlFibmiSUz+Zynl1vt620lhtu7bN91EEXJ/BPXr1ITIZW/ZzolRlwEf1FI4SDUIt8kbuimgqaFpwc55SuBNN4fuW3CLdfHRauLdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430659; c=relaxed/simple;
	bh=5hWjnfe+SC6eqhDVuWyOHQODTUfXYLw2KtzJakqj2sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT0jFUa/kR4JuwB63ebptXPgOmT3DgscBAJ2yAiW354kRb7o44BWP6fTcXwz4zudl7xX4nj47GWH+j0RYznP+3ysXY8P/EodI2NafJDPN0dSTla77Sif00GZxWMGccxksyuSP0X65k3+Ev52cezcLbvKfTm7PFTz30QdMcoJnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202505281910510913;
        Wed, 28 May 2025 19:10:51 +0800
Received: from vbox.home.langchao.com (10.94.6.79) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 28 May 2025 19:10:49 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <sj@kernel.org>
CC: <david@redhat.com>, <mhocko@kernel.org>, <zhengqi.arch@bytedance.com>,
	<shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>, wangchuanguo
	<wangchuanguo@inspur.com>
Subject: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Wed, 28 May 2025 19:10:38 +0800
Message-ID: <20250528111038.18378-3-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250528111038.18378-1-wangchuanguo@inspur.com>
References: <20250528111038.18378-1-wangchuanguo@inspur.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20255281910518f65f22d2065e4c72f8fb32c25b40d2b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

This patch adds use_nodes_of_tier under
  /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/

The 'use_nodes_of_tier' can be used to select nodes within the same memory
tier of target_nid for DAMOS actions such as DAMOS_MIGRATE_{HOT,COLD}.

Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
---
 include/linux/damon.h        |  9 ++++++++-
 include/linux/memory-tiers.h |  5 +++++
 mm/damon/core.c              |  6 ++++--
 mm/damon/lru_sort.c          |  3 ++-
 mm/damon/paddr.c             | 19 ++++++++++++-------
 mm/damon/reclaim.c           |  3 ++-
 mm/damon/sysfs-schemes.c     | 31 ++++++++++++++++++++++++++++++-
 mm/memory-tiers.c            | 13 +++++++++++++
 samples/damon/mtier.c        |  3 ++-
 samples/damon/prcl.c         |  3 ++-
 10 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4011726cb3b..05eae7fd66ad 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -455,6 +455,7 @@ struct damos_access_pattern {
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
+ * @use_nodes_of_tier:	Whether to use nodes of the target tier.
  * @filters:		Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
  * @last_applied:	Last @action applied ops-managing entity.
@@ -476,6 +477,10 @@ struct damos_access_pattern {
  * migrate_cold actions, which means it's only meaningful when @action is either
  * "migrate_hot" or "migrate_cold".
  *
+ * @use_nodes_of_tier is used to select nodes of the target tier for migrating
+ * when target_nid is out of memory.Similar to @target_nid, this parameter is
+ * only meaningful when @action is either 'migrate_hot' or 'migrate_cold'.
+ *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
  * &filters
@@ -519,6 +524,7 @@ struct damos {
 	union {
 		int target_nid;
 	};
+	bool use_nodes_of_tier;
 	struct list_head filters;
 	struct list_head ops_filters;
 	void *last_applied;
@@ -896,7 +902,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
 			struct damos_watermarks *wmarks,
-			int target_nid);
+			int target_nid,
+			bool use_nodes_of_tier);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0dc0cf2863e2..4434f95dfde2 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -56,6 +56,7 @@ void mt_put_memory_types(struct list_head *memory_types);
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
+nodemask_t get_tier_nodemask(int node);
 #else
 static inline int next_demotion_node(int node)
 {
@@ -71,6 +72,10 @@ static inline bool node_is_toptier(int node)
 {
 	return true;
 }
+nodemask_t get_tier_nodemask(int node)
+{
+	return NODE_MASK_NONE;
+}
 #endif
 
 #else
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..2c0feca8f87b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -378,7 +378,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
 			struct damos_watermarks *wmarks,
-			int target_nid)
+			int target_nid,
+			bool use_nodes_of_tier)
 {
 	struct damos *scheme;
 
@@ -408,6 +409,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks.activated = true;
 
 	scheme->target_nid = target_nid;
+	scheme->use_nodes_of_tier = use_nodes_of_tier;
 
 	return scheme;
 }
@@ -1006,7 +1008,7 @@ static int damon_commit_schemes(struct damon_ctx *dst, struct damon_ctx *src)
 				src_scheme->action,
 				src_scheme->apply_interval_us,
 				&src_scheme->quota, &src_scheme->wmarks,
-				NUMA_NO_NODE);
+				NUMA_NO_NODE, false);
 		if (!new_scheme)
 			return -ENOMEM;
 		err = damos_commit(new_scheme, src_scheme);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..f663b66550dc 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -164,7 +164,8 @@ static struct damos *damon_lru_sort_new_scheme(
 			&quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks,
-			NUMA_NO_NODE);
+			NUMA_NO_NODE,
+			false);
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e8464f7e0014..e13321cff38f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -383,7 +383,7 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 
 static unsigned int __damon_pa_migrate_folio_list(
 		struct list_head *migrate_folios, struct pglist_data *pgdat,
-		int target_nid)
+		int target_nid, bool use_nodes_of_tier)
 {
 	unsigned int nr_succeeded = 0;
 	nodemask_t allowed_mask = NODE_MASK_NONE;
@@ -405,6 +405,9 @@ static unsigned int __damon_pa_migrate_folio_list(
 	if (list_empty(migrate_folios))
 		return 0;
 
+	if (use_nodes_of_tier)
+		allowed_mask = get_tier_nodemask(target_nid);
+
 	/* Migration ignores all cpuset and mempolicy settings */
 	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
@@ -415,7 +418,7 @@ static unsigned int __damon_pa_migrate_folio_list(
 
 static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 						struct pglist_data *pgdat,
-						int target_nid)
+						int target_nid, bool use_nodes_of_tier)
 {
 	unsigned int nr_migrated = 0;
 	struct folio *folio;
@@ -444,7 +447,7 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 
 	/* Migrate folios selected for migration */
 	nr_migrated += __damon_pa_migrate_folio_list(
-			&migrate_folios, pgdat, target_nid);
+			&migrate_folios, pgdat, target_nid, use_nodes_of_tier);
 	/*
 	 * Folios that could not be migrated are still in @migrate_folios.  Add
 	 * those back on @folio_list
@@ -466,7 +469,7 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 }
 
 static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
-					    int target_nid)
+					    int target_nid, bool use_nodes_of_tier)
 {
 	int nid;
 	unsigned long nr_migrated = 0;
@@ -489,13 +492,15 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 
 		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
 							   NODE_DATA(nid),
-							   target_nid);
+							   target_nid,
+							   use_nodes_of_tier);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
 	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
 						   NODE_DATA(nid),
-						   target_nid);
+						   target_nid,
+						   use_nodes_of_tier);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
@@ -529,7 +534,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
-	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
+	applied = damon_pa_migrate_pages(&folio_list, s->target_nid, s->use_nodes_of_tier);
 	cond_resched();
 	s->last_applied = folio;
 	return applied * PAGE_SIZE;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a675150965e0..1b770553bbd2 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -178,7 +178,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_reclaim_wmarks,
-			NUMA_NO_NODE);
+			NUMA_NO_NODE,
+			false);
 }
 
 static int damon_reclaim_apply_parameters(void)
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0f6c9e1fec0b..654e209fd6fd 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1584,6 +1584,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
 	int target_nid;
+	bool use_nodes_of_tier;
 };
 
 /* This should match with enum damos_action */
@@ -1612,6 +1613,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
 	scheme->target_nid = NUMA_NO_NODE;
+	scheme->use_nodes_of_tier = false;
 	return scheme;
 }
 
@@ -1896,6 +1898,29 @@ static ssize_t target_nid_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t use_nodes_of_tier_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%s\n", scheme->use_nodes_of_tier ? "true" : "false");
+}
+
+static ssize_t use_nodes_of_tier_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int err;
+
+	err = kstrtobool(buf, &scheme->use_nodes_of_tier);
+	if (err < 0)
+		return err;
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -1910,10 +1935,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
 		__ATTR_RW_MODE(target_nid, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_use_nodes_of_tier_attr =
+		__ATTR_RW_MODE(use_nodes_of_tier, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
 	&damon_sysfs_scheme_target_nid_attr.attr,
+	&damon_sysfs_scheme_use_nodes_of_tier_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -2258,7 +2287,7 @@ static struct damos *damon_sysfs_mk_scheme(
 
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
 			sysfs_scheme->apply_interval_us, &quota, &wmarks,
-			sysfs_scheme->target_nid);
+			sysfs_scheme->target_nid, sysfs_scheme->use_nodes_of_tier);
 	if (!scheme)
 		return NULL;
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fc14fe53e9b7..393f3012a612 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -299,6 +299,19 @@ bool node_is_toptier(int node)
 	return toptier;
 }
 
+nodemask_t get_tier_nodemask(int node)
+{
+	struct memory_tier *memtier;
+	nodemask_t tier_nodes = NODE_MASK_NONE;
+
+	memtier = __node_get_memory_tier(node);
+	if (!memtier)
+		return tier_nodes;
+
+	tier_nodes = get_memtier_nodemask(memtier);
+	return tier_nodes;
+}
+
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 {
 	struct memory_tier *memtier;
diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..b5d42086b221 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -105,7 +105,8 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 				.weight_age = 100,
 			},
 			&(struct damos_watermarks){},
-			promote ? 0 : 1);	/* migrate target node id */
+			promote ? 0 : 1,	/* migrate target node id */
+			false);
 	if (!scheme)
 		goto free_out;
 	damon_set_schemes(ctx, &scheme, 1);
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 056b1b21a0fe..445a9f4e0905 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -88,7 +88,8 @@ static int damon_sample_prcl_start(void)
 			0,
 			&(struct damos_quota){},
 			&(struct damos_watermarks){},
-			NUMA_NO_NODE);
+			NUMA_NO_NODE,
+			false);
 	if (!scheme) {
 		damon_destroy_ctx(ctx);
 		return -ENOMEM;
-- 
2.39.3

