Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35430E844
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487285; cv=none; b=Kptbh4ufivBT8Rk1FmrmFSCRX+CrT0HNOIIQIVIxLe7bTzfBUkgdWq3mcB9XR556pTmZj1BPlUu20JL4z5Rjguhkqpyv8kZhC0TD3IDZ+f/AxTjj1PxNYRMYkwKOAL53ggbyB3JMmmZa4qZ8wt7x/UQi5/R29eih9VWw/sIHIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487285; c=relaxed/simple;
	bh=ya5MwjEB1xHq/yOFXYAj+pDIdDIqM4iOdvLYL2l39jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWN7wK7OzigiJAwio3DRKjrVjwVYmE7qvVN0rG6850vM7dMhK7+mHaNSCGxRRK3TT3YHiqewJMYwp2t9WlJ7Ov7aDwk84/5UI2yBVZm1/cGv7s5g+sWuFpazfd3keeZ5/dV8+Lv8Z8t9ieXNrPFiXCpeUpkDxdFlyVp4RKiasMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuxN+k96; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuxN+k96"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8600a33792so3498351276.0
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487282; x=1752092082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux7vTJe4Gmqx6TiCWWLEznlY/hR11iXVrOjLOOQ9hBo=;
        b=XuxN+k96Q0SQCSZVsQLoC/hdk3WL75ZyncDfS7VBeeUYgq7YKI7jTPYqYebhuuJX5f
         RvIl1W/6aCtm6JQZ7uilG7Hq/8D8W0Kb5zYoXmqfKsBw2cHmZHXOSMeXZCTCj99j6uB2
         0DOhO0hWYfQF9Z5+vu2EK5IRKGAxxXJjThTz4kRUXLZcyfTEI5yfjf9vnDegEoF97DNA
         oiOzqm58kjbbhzKlq6FcLx0GG0vQvq/7zw7bsldcvxAyoYBqoM228sjb7sPNd+wn8XpK
         ZIa+Ah7F/8Ouklt1xb+/hSwfcbFaEWn+z30ED6n4s8ISEISE/0YlZ4SxcvvCqUBcXzwx
         k/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487282; x=1752092082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux7vTJe4Gmqx6TiCWWLEznlY/hR11iXVrOjLOOQ9hBo=;
        b=Uw0MBslrwUV+HW0msghnBF9eJTM9UKWMlHVj33nYe52CRT0fwpXyehZ/1lPzwjY6+b
         K6GTWWSL1qdxFxslk3VKqKKO6Ki+M0ojTW8sMMeLO4B9H8/z7faN6iS6rJM0f2RaYAp5
         HZzVr8fcz0/EmXh3FBERtektciv1Y5U5exOra7KCOuE202p0KIDWkbsxAQN2j3hGvQjB
         278oz0+UWUN0Agt/Ytt7ML2P3f7r9k7TtXHj86b6stP7g7tVUSx3aWV8eo4KaOuOTCBS
         Gn2+EAzuU2Gx6jwKbos6ZMNalZ+jKH1UV5vl6TK+wBzxGZAHjS2eWx3AOpScMV0Lrdke
         vIzQ==
X-Gm-Message-State: AOJu0YwBu2Ny7yQ2yOldBS40tMKen2VY2FTsXk7SQWnin21W/a1+cDAa
	vra4IHGQVOQCFG/mD3wygz3Zbq+xLx1OmLB4CfqiZCS2B2pVj6EhslJiqdztuJ74R1o=
X-Gm-Gg: ASbGnctgzU/81AXVq88eTdyXyxg0etB3Fk3GvXB1Ra4gd8ug8qulafJxuGuzJOxDIrm
	4VA+DbioDaNbOQ3L2G2d6t+VuoRSJMIMxUOLV4GU4efGnnaGd2VaOoXjqzJwFlVcRL9pHaFs/1D
	ajyi2YfPDRgTRIechFwBfVyxhtuwTvgynYM+7qUBcvne4jIdTro3xyVUIUwdp6qxuX8HRjAVi/v
	dpX97UuyrRA+agKEu4iGO7jTNItS5g+6TWylnFfkGggpGhOi2RVuMW5q6GhYAjLuAsTym2Xq6l9
	vWyPeFHCDKoS3ugyjC/i6/TWFc2cnz3/7DeCzMlB0RZKRaxMsEegPAKycc4ARn41usyhWb6sMvP
	EY9Qu/ywBatUwiYG8Pg==
X-Google-Smtp-Source: AGHT+IHA+gOuV+brpZwRwERkJ7yj/jSN/p3J3iXUigSwyqpIrYWnlxAOmwngxwZ6r4wEWO6YRW3O0Q==
X-Received: by 2002:a05:690c:6002:b0:70e:a1e:d9f8 with SMTP id 00721157ae682-716590c4d46mr15751777b3.22.1751487281890;
        Wed, 02 Jul 2025 13:14:41 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:41 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH v3 08/13] mm/damon: Move migration helpers from paddr to ops-common
Date: Wed,  2 Jul 2025 15:13:31 -0500
Message-ID: <20250702201337.5780-9-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patch moves the damon_pa_migrate_pages function along with its
corresponding helper functions from paddr to ops-common. The function
prefix of "damon_pa_" was also changed to just "damon_" accordingly.

This patch will allow page migration to be available to vaddr schemes as
well as paddr schemes.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/ops-common.c | 120 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      | 122 +-----------------------------------------
 3 files changed, 123 insertions(+), 121 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b43620fee6bb..918158ef3d99 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -5,6 +5,7 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/migrate.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
@@ -12,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
+#include "../internal.h"
 #include "ops-common.h"
 
 /*
@@ -138,3 +140,121 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 	/* Return coldness of the region */
 	return DAMOS_MAX_SCORE - hotness;
 }
+
+static unsigned int __damon_migrate_folio_list(
+		struct list_head *migrate_folios, struct pglist_data *pgdat,
+		int target_nid)
+{
+	unsigned int nr_succeeded = 0;
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
+			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+	};
+
+	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
+		return 0;
+
+	if (list_empty(migrate_folios))
+		return 0;
+
+	/* Migration ignores all cpuset and mempolicy settings */
+	migrate_pages(migrate_folios, alloc_migration_target, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
+		      &nr_succeeded);
+
+	return nr_succeeded;
+}
+
+static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
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
+	nr_migrated += __damon_migrate_folio_list(
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
+unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
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
+		nr_migrated += damon_migrate_folio_list(&node_folio_list,
+							   NODE_DATA(nid),
+							   target_nid);
+		nid = folio_nid(lru_to_folio(folio_list));
+	} while (!list_empty(folio_list));
+
+	nr_migrated += damon_migrate_folio_list(&node_folio_list,
+						   NODE_DATA(nid),
+						   target_nid);
+
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	return nr_migrated;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index cc9f5da9c012..54209a7e70e6 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -16,3 +16,5 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
+
+unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fcab148e6865..48e3e6fed636 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -13,7 +13,6 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
-#include <linux/migrate.h>
 #include <linux/mm_inline.h>
 
 #include "../internal.h"
@@ -381,125 +380,6 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 			sz_filter_passed);
 }
 
-static unsigned int __damon_pa_migrate_folio_list(
-		struct list_head *migrate_folios, struct pglist_data *pgdat,
-		int target_nid)
-{
-	unsigned int nr_succeeded = 0;
-	struct migration_target_control mtc = {
-		/*
-		 * Allocate from 'node', or fail quickly and quietly.
-		 * When this happens, 'page' will likely just be discarded
-		 * instead of migrated.
-		 */
-		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
-			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
-	};
-
-	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
-		return 0;
-
-	if (list_empty(migrate_folios))
-		return 0;
-
-	/* Migration ignores all cpuset and mempolicy settings */
-	migrate_pages(migrate_folios, alloc_migration_target, NULL,
-		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
-		      &nr_succeeded);
-
-	return nr_succeeded;
-}
-
-static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
-						struct pglist_data *pgdat,
-						int target_nid)
-{
-	unsigned int nr_migrated = 0;
-	struct folio *folio;
-	LIST_HEAD(ret_folios);
-	LIST_HEAD(migrate_folios);
-
-	while (!list_empty(folio_list)) {
-		struct folio *folio;
-
-		cond_resched();
-
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-
-		if (!folio_trylock(folio))
-			goto keep;
-
-		/* Relocate its contents to another node. */
-		list_add(&folio->lru, &migrate_folios);
-		folio_unlock(folio);
-		continue;
-keep:
-		list_add(&folio->lru, &ret_folios);
-	}
-	/* 'folio_list' is always empty here */
-
-	/* Migrate folios selected for migration */
-	nr_migrated += __damon_pa_migrate_folio_list(
-			&migrate_folios, pgdat, target_nid);
-	/*
-	 * Folios that could not be migrated are still in @migrate_folios.  Add
-	 * those back on @folio_list
-	 */
-	if (!list_empty(&migrate_folios))
-		list_splice_init(&migrate_folios, folio_list);
-
-	try_to_unmap_flush();
-
-	list_splice(&ret_folios, folio_list);
-
-	while (!list_empty(folio_list)) {
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-		folio_putback_lru(folio);
-	}
-
-	return nr_migrated;
-}
-
-static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
-					    int target_nid)
-{
-	int nid;
-	unsigned long nr_migrated = 0;
-	LIST_HEAD(node_folio_list);
-	unsigned int noreclaim_flag;
-
-	if (list_empty(folio_list))
-		return nr_migrated;
-
-	noreclaim_flag = memalloc_noreclaim_save();
-
-	nid = folio_nid(lru_to_folio(folio_list));
-	do {
-		struct folio *folio = lru_to_folio(folio_list);
-
-		if (nid == folio_nid(folio)) {
-			list_move(&folio->lru, &node_folio_list);
-			continue;
-		}
-
-		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
-							   NODE_DATA(nid),
-							   target_nid);
-		nid = folio_nid(lru_to_folio(folio_list));
-	} while (!list_empty(folio_list));
-
-	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
-						   NODE_DATA(nid),
-						   target_nid);
-
-	memalloc_noreclaim_restore(noreclaim_flag);
-
-	return nr_migrated;
-}
-
 static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
@@ -527,7 +407,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
-	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
+	applied = damon_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
 	s->last_applied = folio;
 	return applied * PAGE_SIZE;
-- 
2.43.5

