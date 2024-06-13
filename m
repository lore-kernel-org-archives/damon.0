Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91B145FF8
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284880; cv=none; b=Aq0iG+VFJgfJNEa/VBOb538O5BvctYajYY6LIqgz0os6fRCEnjJXWIW1QwE3vJr0/w8nw27OjrJ9f9SzX8cT71Kd/qoDn14vb9WsFx7qtLgK0IopSXHHMiT/5PONovTjntF5drPZv9pUgmrTbd+JsgCqdLAsZMH4HyTtv9c+dtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284880; c=relaxed/simple;
	bh=gK7IYwCVAC/BaeHUelw2TAZSnFTHiuHeoYJ/b8GUzHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHIoTq8r0JA/fTJ0VlFLi/syAb00oebAIu59wUaPTBIVF5YAfxgERat1A9rxYnU5VxgPqOCEwOIQx9lxdwilgw4lyJ2RR36m2/G0MMoP1SY1oICwHM05xsC+Sqno62xE4BBBjk0D85nzAtGoVXS4ShAP2PnFMcaa5v9GqYbCEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-4d-666af24a63ba
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
Subject: [PATCH v5 5/8] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Thu, 13 Jun 2024 22:20:52 +0900
Message-ID: <20240613132056.608-6-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoa7Xp6w0g9WfxCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M94efshRssq5Y+3s1ewPjUoMuRg4OCQETiZfXU2HMEyuNuhg5OdgE1CSuvJzE
	BBIWEbCSmLYjtouRi4NZ4BqzxPLmRUwgNcICERK7f/1lAbFZBFQl/t2aDmbzCphKnD/SyAxi
	SwhoSjze/pMdxOYUMJN4NPcVG4gtBFQz48dVZoh6QYmTM5+A9TILyEs0b53NDLJMQuA9m8Ts
	F99YIQZJShxccYNlAiP/LCQ9s5D0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGAHLav9E
	72D8dCH4EKMAB6MSD6/Hs6w0IdbEsuLK3EOMEhzMSiK8sxYChXhTEiurUovy44tKc1KLDzFK
	c7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTA6CXCEBNY2zxd9Vew3Q1Uqg0eb8V7q6msz
	l8fduzJP89mnfXUWa6bNDpjM9SpPtf2K1pk1KhbWa3NLNpSeUTM/8VdM7+cbE73uVXaPWLPK
	3H6wLjurcnPJS0d/7VSG+ouOx9Nn6jXUtuldSU51lE7K4BazaPj+7sRlE8WYN5yHFsVMrVU9
	zavEUpyRaKjFXFScCADDsl2MfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXCNUNLT9frU1aawddGXouJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtmi88l3RovDc0+yWlzeNYfN4t6a/6wWR9afZbHYfPYMs8Xi
	5WoW+zoeMFkc/vqGyYHfY+npN2weO2fdZfdo2XeL3WPTqk42j02fJrF7nJjxm8XjxeaZjB4b
	P/5n9/h228Nj8YsPTB6fN8kFcEdx2aSk5mSWpRbp2yVwZbw//JSlYJN1xdrfq9kbGJcadDFy
	cEgImEicWGnUxcjJwSagJnHl5SQmkLCIgJXEtB2xXYxcHMwC15glljcvYgKpERaIkNj96y8L
	iM0ioCrx79Z0MJtXwFTi/JFGZhBbQkBT4vH2n+wgNqeAmcSjua/YQGwhoJoZP64yQ9QLSpyc
	+QSsl1lAXqJ562zmCYw8s5CkZiFJLWBkWsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREY7Mtq
	/0zcwfjlsvshRgEORiUeXo9nWWlCrIllxZW5hxglOJiVRHhnLQQK8aYkVlalFuXHF5XmpBYf
	YpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MNrFKhds5j2huJMp/Eg0w1TbV99WN7kw
	3pI9Pd+p71F64O/Gt31y1gpzFcMvB95pLhVdf1tC5Vt7tXz8pk5rm/6iSemfatYJtklpsnn5
	776x09HsjoWF4T/Z+bJr8uu33Kx3qJB4fiRcou+X7KHodRxVAstaOM4Uldef+KyWLnhal4Fz
	dXe3EktxRqKhFnNRcSIAPAtf0nICAAA=
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

