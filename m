Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D73144D36
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284696; cv=none; b=ohEqWqUVwBW7GQkH4fa7Bzzf/1OVWCaBWQPccaUxAsP78M8lKPz2W/FeEzzMjKSkS58/4KbIYItd7KVhkBwck0rFtU/+Z+YX7ElsbyTn1D3/NTCMrtAiUVOXbWoATOypNDi5bLPJSXShwDzDzktqBl+xAeYV1E5N8PeZeqQtJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284696; c=relaxed/simple;
	bh=gK7IYwCVAC/BaeHUelw2TAZSnFTHiuHeoYJ/b8GUzHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0xbZonEOAgtVKGr8HI0iayEVUQNT4o+VDmR2Uar7In5aKlP4hCeLMsdoMb5EFWEmhgEvVp/be6C2txDqWaJiZKd8U42qxnkjj0KEVPCrY4F8PJg0NXR1xVnErkIC45on4dcPdhvv4mqkScnIkOySNdSW7KQ25MroJOj/LEYZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-40-666af1901b75
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [PATCH 5/8] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Thu, 13 Jun 2024 22:17:36 +0900
Message-ID: <20240613131741.513-6-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613131741.513-1-honggyu.kim@sk.com>
References: <20240613131741.513-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnke6Ej1lpBjdW8llM7DGwmLN+DZvF
	/Qev2S2e/P/NatHQ9IjF4vKuOWwW99b8Z7U4sv4si8Xms2eYLRYvV7PY1/GAyeLw1zdMDjwe
	S0+/YfPYOesuu0fLvlvsHptWdbJ5bPo0id3jxIzfLB4vNs9k9Nj48T+7x+dNcgGcUVw2Kak5
	mWWpRfp2CVwZ7w8/ZSnYZF2x9vdq9gbGpQZdjJwcEgImEtsOnWTuYuQAs+9c0wAJswmoSVx5
	OYkJJCwiYCUxbUdsFyMXB7PANWaJ5c2LwOLCAqESLcscQMpZBFQl/vSdZAWxeQVMJWa132KD
	mK4p8Xj7T3YQm1PATGLdt/uMILYQUE3H/2fMEPWCEidnPmEBsZkF5CWat85mhuj9zCbxcqYW
	hC0pcXDFDZYJjPyzkLTMQtKygJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZg+C+r/RO9g/HT
	heBDjAIcjEo8vB7PstKEWBPLiitzDzFKcDArifDOWggU4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwMjld5Jhq76pcr32hJn12xYavfu4Jf15bvCpuf73
	f6xT/9w3tWOd6Cqv/FPr+5fciy+yeG0srHcxyD/qkMLX6aeLrgtbML9cMNkmq9vN5prZO9HP
	OxgNZ0vf641wmrLLqUi3q2eBxvvsa9W7XaQ0qu5LnPi/w+WJ6ZFQn+tC7B8yXDSfZRR+/KnE
	UpyRaKjFXFScCACWyrSaewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXCNUNLT3fCx6w0g2P3mS0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRi8fnZa2aLziffGS0Ozz3JanF51xw2i3tr/rNaHFl/lsVi89kzzBaL
	l6tZ7Ot4wGRx+OsbJgd+j6Wn37B57Jx1l92jZd8tdo9NqzrZPDZ9msTucWLGbxaPF5tnMnps
	/Pif3ePbbQ+PxS8+MHl83iQXwB3FZZOSmpNZllqkb5fAlfH+8FOWgk3WFWt/r2ZvYFxq0MXI
	wSEhYCJx55pGFyMnB5uAmsSVl5OYQMIiAlYS03bEdjFycTALXGOWWN68CCwuLBAq0bLMAaSc
	RUBV4k/fSVYQm1fAVGJW+y02EFtCQFPi8faf7CA2p4CZxLpv9xlBbCGgmo7/z5gh6gUlTs58
	wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQJDfVnt
	n4k7GL9cdj/EKMDBqMTD6/EsK02INbGsuDL3EKMEB7OSCO+shUAh3pTEyqrUovz4otKc1OJD
	jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRp6wL2+DGuM2la101t3DMlG0L7RqV9u0
	ZRJT7ngJBO573TYh/s45q30vYn57zQ71/rBJK00j5c2z+RsT3hxPUcjeu/WQY8df1fUiF3z6
	/r9Y28Pi+KvowL9VPV6NSnMf3pmw6NQb3dk1R5Yd1J3iuH6iEBejdfLVLe82ts3fvbT024s/
	K12zezWVWIozEg21mIuKEwGItZOkcQIAAA==
X-CFilter-Loop: Reflected

This patch introduces DAMOS_MIGRATE_COLD action, which is similar to
DAMOS_PAGEOUT, but migrate folios to the given 'target_nid' in the sysfs
instead of swapping them out.

The 'target_nid' sysfs knob informs the migration target node ID.

Here is one of the example usage of this 'migrate_cold' action.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
  $ cat contexts/<N>/schemes/<N>/action
  migrate_cold
  $ echo 2 > contexts/<N>/schemes/<N>/target_nid
  $ echo commit > state
  $ numactl -p 0 ./hot_cold 500M 600M &
  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  701 (hot_cold)     501      0    601  1101

Since there are some common routines with pageout, many functions have
similar logics between pageout and migrate cold.

damon_pa_migrate_folio_list() is a minimized version of
shrink_folio_list().

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    |   2 +
 mm/damon/paddr.c         | 154 +++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |   1 +
 3 files changed, 157 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 21d6b69a015c..56714b6eb0d7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_MIGRATE_COLD:	Migrate the regions prioritizing colder regions.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
@@ -122,6 +123,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_MIGRATE_COLD,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 18797c1b419b..882ae54af829 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -12,6 +12,9 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
+#include <linux/memory-tiers.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -325,6 +328,153 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 	return damon_pa_mark_accessed_or_deactivate(r, s, false);
 }
 
+static unsigned int __damon_pa_migrate_folio_list(
+		struct list_head *migrate_folios, struct pglist_data *pgdat,
+		int target_nid)
+{
+	unsigned int nr_succeeded;
+	nodemask_t allowed_mask = NODE_MASK_NONE;
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
+			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+		.nmask = &allowed_mask
+	};
+
+	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
+		return 0;
+
+	if (list_empty(migrate_folios))
+		return 0;
+
+	/* Migration ignores all cpuset and mempolicy settings */
+	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
+		      &nr_succeeded);
+
+	return nr_succeeded;
+}
+
+static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
+						struct pglist_data *pgdat,
+						int target_nid)
+{
+	unsigned int nr_migrated = 0;
+	struct folio *folio;
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(migrate_folios);
+
+	while (!list_empty(folio_list)) {
+		struct folio *folio;
+
+		cond_resched();
+
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+
+		if (!folio_trylock(folio))
+			goto keep;
+
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &migrate_folios);
+		folio_unlock(folio);
+		continue;
+keep:
+		list_add(&folio->lru, &ret_folios);
+	}
+	/* 'folio_list' is always empty here */
+
+	/* Migrate folios selected for migration */
+	nr_migrated += __damon_pa_migrate_folio_list(
+			&migrate_folios, pgdat, target_nid);
+	/*
+	 * Folios that could not be migrated are still in @migrate_folios.  Add
+	 * those back on @folio_list
+	 */
+	if (!list_empty(&migrate_folios))
+		list_splice_init(&migrate_folios, folio_list);
+
+	try_to_unmap_flush();
+
+	list_splice(&ret_folios, folio_list);
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_migrated;
+}
+
+static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
+					    int target_nid)
+{
+	int nid;
+	unsigned long nr_migrated = 0;
+	LIST_HEAD(node_folio_list);
+	unsigned int noreclaim_flag;
+
+	if (list_empty(folio_list))
+		return nr_migrated;
+
+	noreclaim_flag = memalloc_noreclaim_save();
+
+	nid = folio_nid(lru_to_folio(folio_list));
+	do {
+		struct folio *folio = lru_to_folio(folio_list);
+
+		if (nid == folio_nid(folio)) {
+			list_move(&folio->lru, &node_folio_list);
+			continue;
+		}
+
+		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+							   NODE_DATA(nid),
+							   target_nid);
+		nid = folio_nid(lru_to_folio(folio_list));
+	} while (!list_empty(folio_list));
+
+	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+						   NODE_DATA(nid),
+						   target_nid);
+
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	return nr_migrated;
+}
+
+static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
+{
+	unsigned long addr, applied;
+	LIST_HEAD(folio_list);
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+
+		if (!folio)
+			continue;
+
+		if (damos_pa_filter_out(s, folio))
+			goto put_folio;
+
+		if (!folio_isolate_lru(folio))
+			goto put_folio;
+		list_add(&folio->lru, &folio_list);
+put_folio:
+		folio_put(folio);
+	}
+	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
+	cond_resched();
+	return applied * PAGE_SIZE;
+}
+
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -336,6 +486,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_pa_migrate(r, scheme);
 	case DAMOS_STAT:
 		break;
 	default:
@@ -356,6 +508,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0632d28b67f8..880015d5b5ea 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1458,6 +1458,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"migrate_cold",
 	"stat",
 };
 
-- 
2.34.1

