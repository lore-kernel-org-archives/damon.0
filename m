Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9F2E612B
	for <damon@lists.linux.dev>; Fri, 20 Jun 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442789; cv=none; b=TpGho/xrkTN0SMmj++NbR55Wy5lwiih2+7FVZ55kW2Q+fhfKaa0pIweZJQM/XS0DEkj3QMiSPcpXJ2ShHKNuQgLe+rg65Hrab9Rnl3/Ksz495ZSR4+RrMamfAGmCJT3qTXOm1tvxpsUOM3RdOO+ATVM2wRe2ir+7fwWmEJWWUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442789; c=relaxed/simple;
	bh=gQQ+TW3T6Kz+WGCp9Do+l77Cs8BlOAo+Vk9W049PrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6UVGy0YuuTzZS2yzS1DMQoD2aLU9Te0QdEldrMvYmLT5deuBrVelDSUQnb/RX6BfK8oBcwL6XQH6rS5Tdg5mYoyhfqNL63aC7ZrkCQqWqZtkYM878bqjKWnuS8hmANuRC/MgLCownzS5nPSxwCoLq0VeMhOxqjqEjGM3zeQQv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4mMgEpj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4mMgEpj"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e82278e3889so1615412276.2
        for <damon@lists.linux.dev>; Fri, 20 Jun 2025 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750442786; x=1751047586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaFtJKJaSQ0X8KtK2W7VsRkyNzQ4Tdja7cH9ZDxlNF4=;
        b=Z4mMgEpjuGOSXd5G+IKWyyYcPOO+e4XEUEKKbosRV8Pm5TdzX9t2n2M+JcqEjYZ/Ic
         Mcx4JhOcLM/s5mAB81+zJ/vqbuw+4fbPc5SI/xgU+94+P0UenTksJ7WGMBzukxSahzQV
         Lipe5nclbhB8Umw97vgonb8rwyEhoqx78yl2Ja5Ln+EDUJ6hA1eo992LaFmdDRuSs8fS
         4DzOCuV+6vZJKMZPP/xLUbFGmRNp3hS/hZviMgglHj+wE8mTZ5e+h0LOhsDmUzafUZ6X
         oF1P7cI1VwkuUEAh6bEq8T94JITTMUusTyH5rtGIETQYFDyydtIfmjxXtymbOEZ7ViG3
         qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442786; x=1751047586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaFtJKJaSQ0X8KtK2W7VsRkyNzQ4Tdja7cH9ZDxlNF4=;
        b=aSq11+sFoRo7JjkOADWRFL766FGeiZS1/gltsexwKSKCFE+btUL28EIigQ/GvQt46o
         YP435dPkFnnT0//fKzr+TfIawCbectq4IrPodBjZs5uuSKC9jscgaOWoxLU1Qp54zhVj
         f+TxX7rV7zqXF9jO7Qte8SIQ+ctxNJLleRhtsr+Hc76nuK4RJ+KMP3tbIqbxqXm8E7Ge
         GOuApR6tea6HCwfXPTp0H71rv73OqsLIEAGBTOwg8EuUBXHCATHmZJ8E6YProbIx1Oij
         /DPRDP+QjfDh5H/+NZbBllbklXfYdzdJ5NN2bYd6AVct5ecWIWutQyHvCO/YaUhg09tS
         GqHQ==
X-Gm-Message-State: AOJu0YxW66GJQXrHHyaiHILcqCUxreWyflfDxkw4Y0pHRCpzAEWI4hHd
	sutpIL6ssSGW+DOYaBIKGfhHEtWUq0kLTzFdM4JCI5ouxbU3fqTDBAZEFwpGjf0hmeU=
X-Gm-Gg: ASbGncu6oJ05CtYEjHGvKcHGgOni5XIR/WYiS5KvVAwhuPomI5uTlC5hK5ef4SamfMv
	LsNIrTJa5MNQqmIBYPElzRlJPpPeJor5afJjEIWW2+M25pvJUJi7AbPwbiLGsyj9vsrjl+YrNmN
	XfdLXnTUvw86YG0ETtioK8XZ5rMy9JScVdkNImLMezFe4pYpadUlAzkPZy4ImGDEWksydLbo2iU
	yvJruJHbOMx5LrB5g1ZDu8hNkXSWXQruUz7Zod7X3Myo3A2EkvQ6LgoldopWdTmyAVu5uQBLdNa
	W3aPw5fBYc0m27iCrLFdO3ZDfKN4HyYrs3OTxk4f48HcqqDjK0tAyTWcoyOFj9t85kQDSLiqXho
	bsfxCgg==
X-Google-Smtp-Source: AGHT+IHB9tstmfrLI97FahUCW/o2VuoIss/BX4z3uWAwHAZuzEGkwR46NwuaxCccXmdK76MiXTWoUg==
X-Received: by 2002:a05:6902:6901:b0:e84:315a:795b with SMTP id 3f1490d57ef6-e84315a7aa5mr2916197276.39.1750442785843;
        Fri, 20 Jun 2025 11:06:25 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:227e:8527:3def:3ad])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aaed6e4sm769304276.20.2025.06.20.11.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:06:25 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Fri, 20 Jun 2025 13:04:58 -0500
Message-ID: <20250620180458.5041-3-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620180458.5041-1-bijan311@gmail.com>
References: <20250620180458.5041-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

The migrate_{hot,cold} DAMONS actions take a parameter, target_nid, to
indicate what node the actions should migrate pages to. In this patch,
we allow passing in a list of migration targets into target_nid. When
this is done, the mirgate_{hot, cold} actions will migrate pages between
the specified nodes using the global interleave weights found at
/sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionality
can be used to dynamically adjust how pages are interleaved in response
to changes in bandwidth utilization to improve performance, as discussed
in [1]. When only a single migration target is passed to target_nid, the
migrate_{hot,cold} actions will act the same as before.

Below is an example of this new functionality. The user initially sets
the interleave weights to interleave pages at a 1:1 ratio and starts an
application, alloc_data, using those weights that allocates 1GB of data
then sleeps. Afterwards, the weights are changed to interleave pages at
a 2:1 ratio. Using numastat, we show that DAMON has migrated the
application's pages to match the new interleave weights.
  $ # Show that the migrate_hot action is used with multiple targets
  $ cd /sys/kernel/mm/damon/admin/kdamonds/0
  $ sudo cat ./contexts/0/schemes/0/action
  migrate_hot
  $ sudo cat ./contexts/0/schemes/0/target_nid
  0-1
  $ # Initially interleave at a 1:1 ratio
  $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node0
  $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node1
  $ # Start alloc_data with the initial interleave ratio
  $ numactl -w 0,1 ~/alloc_data 1G &
  $ # Verify the initial allocation
  $ numastat -c -p alloc_data

  Per-node process memory usage (in MBs) for PID 12224 (alloc_data)
           Node 0 Node 1 Total
           ------ ------ -----
  Huge          0      0     0
  Heap          0      0     0
  Stack         0      0     0
  Private     514    514  1027
  -------  ------ ------ -----
  Total       514    514  1027
  $ # Start interleaving at a 2:1 ratio
  $ echo 2 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node0
  $ # Verify that DAMON has migrated data to match the new ratio
  $ numastat -c -p alloc_data

  Per-node process memory usage (in MBs) for PID 12224 (alloc_data)
           Node 0 Node 1 Total
           ------ ------ -----
  Huge          0      0     0
  Heap          0      0     0
  Stack         0      0     0
  Private     684    343  1027
  -------  ------ ------ -----
  Total       684    343  1027

[1] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h    |   8 +--
 mm/damon/core.c          |   9 ++--
 mm/damon/lru_sort.c      |   2 +-
 mm/damon/paddr.c         | 108 +++++++++++++++++++++++++++++++++++++--
 mm/damon/reclaim.c       |   2 +-
 mm/damon/sysfs-schemes.c |  14 +++--
 samples/damon/mtier.c    |   6 ++-
 samples/damon/prcl.c     |   2 +-
 8 files changed, 131 insertions(+), 20 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4011726cb3b..24e726ee146a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -454,7 +454,7 @@ struct damos_access_pattern {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
- * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
+ * @target_nids:	Destination nodes if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
  * @last_applied:	Last @action applied ops-managing entity.
@@ -472,7 +472,7 @@ struct damos_access_pattern {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
- * @target_nid is used to set the migration target node for migrate_hot or
+ * @target_nids is used to set the migration targets node for migrate_hot or
  * migrate_cold actions, which means it's only meaningful when @action is either
  * "migrate_hot" or "migrate_cold".
  *
@@ -517,7 +517,7 @@ struct damos {
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	union {
-		int target_nid;
+		nodemask_t target_nids;
 	};
 	struct list_head filters;
 	struct list_head ops_filters;
@@ -896,7 +896,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
 			struct damos_watermarks *wmarks,
-			int target_nid);
+			nodemask_t *target_nids);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..b57eae393df8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -378,7 +378,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
 			struct damos_watermarks *wmarks,
-			int target_nid)
+			nodemask_t *target_nids)
 {
 	struct damos *scheme;
 
@@ -407,7 +407,10 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
-	scheme->target_nid = target_nid;
+	if (target_nids)
+		nodes_copy(scheme->target_nids, *target_nids);
+	else
+		nodes_clear(scheme->target_nids);
 
 	return scheme;
 }
@@ -1006,7 +1009,7 @@ static int damon_commit_schemes(struct damon_ctx *dst, struct damon_ctx *src)
 				src_scheme->action,
 				src_scheme->apply_interval_us,
 				&src_scheme->quota, &src_scheme->wmarks,
-				NUMA_NO_NODE);
+				NULL);
 		if (!new_scheme)
 			return -ENOMEM;
 		err = damos_commit(new_scheme, src_scheme);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..ef584c49ecf1 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -164,7 +164,7 @@ static struct damos *damon_lru_sort_new_scheme(
 			&quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks,
-			NUMA_NO_NODE);
+			NULL);
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4102a8c5f992..cbd262d21779 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -19,6 +19,12 @@
 #include "../internal.h"
 #include "ops-common.h"
 
+struct damon_pa_migrate_rmap_arg {
+	nodemask_t *nids;
+	u8 *weights;
+	int *target_nid;
+};
+
 static bool damon_folio_mkold_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
@@ -502,12 +508,83 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 	return nr_migrated;
 }
 
+static bool damon_pa_migrate_rmap(struct folio *folio,
+				  struct vm_area_struct *vma,
+				  unsigned long addr,
+				  void *arg)
+{
+	struct damon_pa_migrate_rmap_arg *rmap_arg;
+	pgoff_t ilx;
+	int order;
+	unsigned int target;
+	unsigned int weight_total = 0;
+	int nid;
+
+	rmap_arg = (struct damon_pa_migrate_rmap_arg *)arg;
+
+	order = folio_order(folio);
+	ilx = vma->vm_pgoff >> order;
+	ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+
+	/* Same logic as weighted_interleave_nid() */
+	for_each_node_mask(nid, *rmap_arg->nids) {
+		weight_total += rmap_arg->weights[nid];
+	}
+
+	target = ilx % weight_total;
+	nid = first_node(*rmap_arg->nids);
+	while (target) {
+		if (target < rmap_arg->weights[nid])
+			break;
+		target -= rmap_arg->weights[nid];
+		nid = next_node_in(nid, *rmap_arg->nids);
+	}
+
+	if (nid == folio_nid(folio))
+		*rmap_arg->target_nid = NUMA_NO_NODE;
+	else
+		*rmap_arg->target_nid = nid;
+	return false;
+}
+
 static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied;
-	LIST_HEAD(folio_list);
+	struct rmap_walk_control rwc;
+	struct damon_pa_migrate_rmap_arg rmap_arg;
+	struct list_head *folio_lists;
 	struct folio *folio;
+	u8 *weights;
+	int target_nid;
+	int nr_nodes;
+
+	nr_nodes = nodes_weight(s->target_nids);
+	if (!nr_nodes)
+		return 0;
+
+	folio_lists = kmalloc_array(nr_node_ids, sizeof(struct list_head),
+		GFP_KERNEL);
+	if (!folio_lists)
+		return 0;
+
+	weights = kmalloc_array(nr_node_ids, sizeof(u8), GFP_KERNEL);
+	if (!weights) {
+		kfree(folio_lists);
+		return 0;
+	}
+
+	for (int i = 0; i < nr_node_ids; i++) {
+		INIT_LIST_HEAD(&folio_lists[i]);
+		weights[i] = get_il_weight(i);
+	}
+
+	memset(&rwc, 0, sizeof(struct rmap_walk_control));
+	rwc.rmap_one = damon_pa_migrate_rmap;
+	rwc.arg = &rmap_arg;
+	rmap_arg.nids = &s->target_nids;
+	rmap_arg.weights = weights;
+	rmap_arg.target_nid = &target_nid;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
@@ -522,15 +599,38 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		else
 			*sz_filter_passed += folio_size(folio);
 
+		/*
+		 * If there is only one target node, migrate there. Otherwise,
+		 * interleave across the nodes according to the global
+		 * interleave weights
+		 */
+		if (nr_nodes == 1) {
+			target_nid = first_node(s->target_nids);
+		} else {
+			target_nid = NUMA_NO_NODE;
+			/* Updates target_nid */
+			rmap_walk(folio, &rwc);
+		}
+
+		if (target_nid == NUMA_NO_NODE)
+			goto put_folio;
+
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
-		list_add(&folio->lru, &folio_list);
+		list_add(&folio->lru, &folio_lists[target_nid]);
 put_folio:
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
-	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
-	cond_resched();
+
+	applied = 0;
+	for (int i = 0; i < nr_node_ids; i++) {
+		applied += damon_pa_migrate_pages(&folio_lists[i], i);
+		cond_resched();
+	}
+
+	kfree(weights);
+	kfree(folio_lists);
 	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a675150965e0..9b9546606424 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -178,7 +178,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_reclaim_wmarks,
-			NUMA_NO_NODE);
+			NULL);
 }
 
 static int damon_reclaim_apply_parameters(void)
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0f6c9e1fec0b..eb4e2ded5c83 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1583,7 +1583,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_scheme_filters *filters;
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
-	int target_nid;
+	nodemask_t target_nids;
 };
 
 /* This should match with enum damos_action */
@@ -1611,7 +1611,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->kobj = (struct kobject){};
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
-	scheme->target_nid = NUMA_NO_NODE;
+	nodes_clear(scheme->target_nids);
 	return scheme;
 }
 
@@ -1880,18 +1880,22 @@ static ssize_t target_nid_show(struct kobject *kobj,
 	struct damon_sysfs_scheme *scheme = container_of(kobj,
 			struct damon_sysfs_scheme, kobj);
 
-	return sysfs_emit(buf, "%d\n", scheme->target_nid);
+	return bitmap_print_to_pagebuf(true, buf, scheme->target_nids.bits, MAX_NUMNODES);
 }
 
 static ssize_t target_nid_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
+	nodemask_t new;
 	struct damon_sysfs_scheme *scheme = container_of(kobj,
 			struct damon_sysfs_scheme, kobj);
 	int err = 0;
 
 	/* TODO: error handling for target_nid range. */
-	err = kstrtoint(buf, 0, &scheme->target_nid);
+	err = nodelist_parse(buf, new);
+
+	if (!err)
+		nodes_copy(scheme->target_nids, new);
 
 	return err ? err : count;
 }
@@ -2258,7 +2262,7 @@ static struct damos *damon_sysfs_mk_scheme(
 
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
 			sysfs_scheme->apply_interval_us, &quota, &wmarks,
-			sysfs_scheme->target_nid);
+			&sysfs_scheme->target_nids);
 	if (!scheme)
 		return NULL;
 
diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..b9ac075cbd25 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -47,6 +47,10 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
+	nodemask_t target_node;
+
+	nodes_clear(target_node);
+	node_set(promote ? 0 : 1, target_node);
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -105,7 +109,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 				.weight_age = 100,
 			},
 			&(struct damos_watermarks){},
-			promote ? 0 : 1);	/* migrate target node id */
+			&target_node);
 	if (!scheme)
 		goto free_out;
 	damon_set_schemes(ctx, &scheme, 1);
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 056b1b21a0fe..4d3e4e2e15cc 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -88,7 +88,7 @@ static int damon_sample_prcl_start(void)
 			0,
 			&(struct damos_quota){},
 			&(struct damos_watermarks){},
-			NUMA_NO_NODE);
+			NULL);
 	if (!scheme) {
 		damon_destroy_ctx(ctx);
 		return -ENOMEM;
-- 
2.43.5

