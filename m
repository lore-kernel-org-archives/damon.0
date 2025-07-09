Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779926290
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022856; cv=none; b=XCYm7ntKpyyFtAhNwwS+yqpHTIvqa+Btt75cAAf7vnF8zF7LCwUKv5qbQbHyrMSdyCLb7irW/ng9sGqx9l6Kgks8Jq0oJLFL+n5tqjBaXwpZRxmkrQE0O3M5xNf7CDfM3mbRb1EApnsdg9MibKl6Z2qERXxizXjCnl9AHw3YY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022856; c=relaxed/simple;
	bh=L9z9MlZY9GADbKkS2o+6k0p7RSnZuJugrqzlxUfWhGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSzVwFQlRk+uTHMVjyujo9PA64d1PNl/11QO1YUNa9jZvJiILQ4+4xiJMxsslnxhkg+vCd/IO2UmmO5GoEnHbkCQY9/62SQ88yJqQFhB+tFPwRa19bTlbzngmKcpACWSa7pEo4iHXbJ7E8ctgQAlCWiRtZnqKGWOla1F2D9ndP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3b7rCbV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3b7rCbV"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e87c86845d9so3978956276.1
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022853; x=1752627653; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXQH/ve6qx1KBEN74fLQjfqY8wtfZagojlNvUz86dAc=;
        b=U3b7rCbVTRpURMN7d6uhoMSEV0raCKt1r3sI+fRDTO8yoGnlW6weQgsNdyPT/6+1ux
         /6XTEctXjgJq+Kwuph7cm7n0C8WtihEqe7HwLwlRQze2+BM7K2SGm9K00dJYKLejJrsd
         5JPolHD95Y/HQk9z6T3eawuQp8TttdjaSw/PY1K0Bm1Chum1RMfBpXPv2E4lVyD79F7h
         knnKmLVk3WSpEK6zN43klRXrBvgWb7vxc6idiqg/i9IZ3zceAuF+W+VeMR9gZwO4CZnq
         zXqZtQFHjzNmEftyGrresQEBzgKOsHNZjPGK/+TVTFtAIO+/eTIU4UKe7yPtENKwAimo
         uuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022853; x=1752627653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXQH/ve6qx1KBEN74fLQjfqY8wtfZagojlNvUz86dAc=;
        b=PGKxowp6aes+wCumeb/1N5JhNpBGiN5fcdKSo8at63dUopsInudfKIiBTy2dcI+m87
         jAadnptwFqDt5m9S/wI3bjQlzDsWhTlxg/ZU6xAyvgdH287uuxuXnTQUD+2FhEZVGsZj
         CRkmhcbjO84j/Fof6NjI58AJBLgpCL3/nE+SRHbHYkJvVa/pLFCjjv6pr/c4y4+FKAqW
         KepmKh33MWOUliRDNMBbJq1jM4HS5he0lT/pvSfgvuHh/u63QamhjcnN7gkjTSaaJrUD
         W2VtVqjweNXC46zkhNzldvLLiUpZ5Z/VqeGGgeQN5PitpQSUrlgaeqxQPi8FIkXsL5du
         YzbA==
X-Gm-Message-State: AOJu0YyBiC4uVDm3axA1bznjyzR1q3uskf2Rhfs2gXC+Ma/KBaEVOOa7
	yPsri3vBm4QjjwzTgngDOMbd0bEpYTPx4rfd1iOhQbl1DclPq2hYpN1AMIlSIRADGvQ=
X-Gm-Gg: ASbGncvV5FOKyz/bbNAcIYJvhXgJUf78g3OEoKYZ7qA2o9fla9+8I5hfbkA3X07hQ1u
	zBxDT7xOeH1173mA7AjnEG0fT68zMReHr2P2ZMpVTQ48gPeH26vpjh4lLbpGq1Zog3hk8Crfywl
	a7EHatj+z+Z9nChkc0JaGltRGaQbYuRpnpa8a2EDPk269F7vc032BkmnTnH3znaSK63rqw5gc3C
	pbw4JbZTn4eTCbxbabXL5UX9mma6gdbDcJQz/diPUYfiMK/kLjfKRREX6dDt+lrsXKFxA3WP0Wb
	/UW5H39MYGU39FJarHo5GnN8ujjOubG1QAgVl/LmJNrEkSf0yCf808Xw7QhKqK2bBZeFVJcpEtf
	dggaMJvE=
X-Google-Smtp-Source: AGHT+IH4QyN9DH4rspZx7He5z7+iL9YLC4MetFnDASWRiFISwzMF2jwtmKA6AtCtBMwy//dlFDHNCA==
X-Received: by 2002:a05:6902:128f:b0:e85:e06a:7845 with SMTP id 3f1490d57ef6-e8b6e107726mr1137039276.5.1752022853205;
        Tue, 08 Jul 2025 18:00:53 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:52 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 08/13] mm/damon: Move migration helpers from paddr to ops-common
Date: Tue,  8 Jul 2025 19:59:38 -0500
Message-ID: <20250709005952.17776-9-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
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
Reviewed-by: SeongJae Park <sj@kernel.org>
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
2.43.0

