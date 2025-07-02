Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEB2F6FAD
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487301; cv=none; b=A4TeK+6Ufh4s52vrY9ymDQZljgNnQBpw1SYIwjxyAyqAaISUR8CfemVoIXrfpnfo5ra++AsTeI6g7g5vLtGQPHE0fMTeY97BZaij56Vvhxf6yJWRWI9UOSx1pUkpe9mOLRKGGETMqm3o/WRSMG7KXju8S92OBuxMyjlnatGujaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487301; c=relaxed/simple;
	bh=B4LAEboPZeHhWRFgO3AFh7AK7EfZpX1npJEWMOLqfyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJhvHi6T8JU6V/Bm4zs1t7GmF+h+Zbhqvq3aMl2irvwJs3yTodOTMOpvmOmHedQDftY8kdlUbBUg6T06XRJXHELa/pre+Di29NCCQuxX8sz5cngSJ3WyyPt/D0+NHVwSxx2z1YaCBByePPYxMb+/htcWch5D1HKGx8zjR7v4u5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIH4YR/T; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIH4YR/T"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e898fb745beso152208276.1
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487299; x=1752092099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVqvDTgUdbQeaLQbOWegVEyiOQ5l1FCYExImfHBr7Tc=;
        b=GIH4YR/T5elQ6CHxbmdQESR+oxv2c/78BtVnB879qJiDTTanqvErYDR1ILsDHtbx7a
         H+U3u/a5AIRx88Pv9EOtRPYqy3z3TxaY80+cEyJ47jbum/xqaGe1cq2ZaQLagDo4eUEc
         cP++OW1uZKIe2mNZ2ixr97p9BodwT96JoH0TSJ1ITu7Zl+OKgmyn/rZHJwRq/49Zcc73
         FzEh/0Zz3LQ2NenQwI4Z4hPJ60wO+awXfPnDLt52FpMcxhS7nTHvm2/lqPaLaeHkVCf6
         pU0ZhjOBHAkCuW5Ix1ndKxkIyf4ZAcLFR8XUMZiFB6dbrRBesv8QhxEKEecDFYA6aQyZ
         8OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487299; x=1752092099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVqvDTgUdbQeaLQbOWegVEyiOQ5l1FCYExImfHBr7Tc=;
        b=LoDk2LJs3NLkm3ZBwMCQqBoKzfL3vTRthk7Jn+ped1m+T691bs9BYV0qzU13ON+FaG
         1XWtUpLYI9s7TB13jw1KcE7u0h0dcBiotOKk0VQOXaddP6bbZG5DC5oSxw4RuEFH2Ai6
         GKVAv3vdWB0xLnfK+maWrHwm4wha4I85n3yWxOsOIzJ75YGcIo+3XqKU9bVipsOL9xMG
         yxCqc0DhxdjNozrIXl7yiMqc5hhRkd+zlMoxOPmACPWI2yJBA6XNX/hHFhHA8HEjuYKk
         oRbPLiR1i9vptZCHPROX0mz91rTDCraegoWf5t+SxQBOZkoHb3Vgf4Qac6tRYzpsnn/u
         YRzQ==
X-Gm-Message-State: AOJu0YyUrLBx905RkTp/mB8YtQ5L594wcdTMLdNPNfqBxjzTpvBG8Ghu
	ec2LqkOHb3EGbsQzI+zVdQezOHZAlfOVv83fq05tmOPvkADDjLq2ah2immrPVoiB6Ig=
X-Gm-Gg: ASbGncsGnLHfH2ebHXeca6st5aPr6C9aIqx703V2WoZXV5olpHYhi7/gctmTNZgvNRE
	ofKKRvBGEtsreGSSLXCN2j0CSfcLCBHFj/umRLPBhPMJCFBFs2lhdRAifM3ztVCssyg3WNUIeyz
	PhcR9RGRt0toDu7RWXZroQKy4RKVfpREz7KMrCeWNbXz4vqGcLrWVUwHm6JTY0sd4pZDPZwmP+d
	Yf/fQxrrL97B1GFlTNcqw74A5X/jdEzXKsA8q0w2oSgrc/zwFB/G5DFAF63GDPZhR4g5UyIPqAy
	+03Hwqg1pB3BdkewbkH+IgtrQx/begbwjbVKx7S1frWU+Xe4f5uwzJCF9F2ODv25Iy3T628nCP3
	XYPahrXDG25MZkION9A==
X-Google-Smtp-Source: AGHT+IHCCc83L/Ed/tXXORICBO5ubDFIQHrqXVUSwSXIp5c0xPoL3pJjjGIyHzRoVNsFfggSP3dVNw==
X-Received: by 2002:a05:690c:b17:b0:70e:7158:6fda with SMTP id 00721157ae682-716590c8c4amr15208317b3.9.1751487298340;
        Wed, 02 Jul 2025 13:14:58 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:57 -0700 (PDT)
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
Subject: [RFC PATCH v3 11/13] mm/damon/vaddr: Use damos->migrate_dests in migrate_{hot,cold}
Date: Wed,  2 Jul 2025 15:13:34 -0500
Message-ID: <20250702201337.5780-12-bijan311@gmail.com>
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

damos->migrate_dests provides a list of nodes the migrate_{hot,cold}
actions should migrate to, as well as the weights which specify the
ratio pages should be migrated to each destination node.

This patch interleaves pages in the migrate_{hot,cold} actions according
to the information provided in damos->migrate_dests if it is used. The
interleaving algorithm used is similar to the one used in
weighted_interleave_nid(). If damos->migration_dests is not provided, the
actions migrate pages to the node specified in damos->target_nid as
before.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/vaddr.c | 114 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 17 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 5cdfdc47c5ff..5f230a427fdc 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -611,11 +611,76 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+struct damos_va_migrate_private {
+	struct list_head *migration_lists;
+	struct damos *scheme;
+};
+
+/*
+ * Place the given folio in the migration_list corresponding to where the folio
+ * should be migrated.
+ *
+ * The algorithm used here is similar to weighted_interleave_nid()
+ */
+static void damos_va_migrate_folio(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr,
+		struct damos_migrate_dests *dests,
+		struct list_head *migration_lists)
+{
+	pgoff_t ilx;
+	int order;
+	unsigned int target;
+	unsigned int weight_total = 0;
+	int i;
+
+	/*
+	 * If dests is empty, there is only one migration list corresponding
+	 * to s->target_nid.
+	 */
+	if (!dests->nr_dests) {
+		i = 0;
+		goto isolate;
+	}
+
+	order = folio_order(folio);
+	ilx = vma->vm_pgoff >> order;
+	ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+
+	for (i = 0; i < dests->nr_dests; i++)
+		weight_total += dests->weight_arr[i];
+
+	/* If the total weights are somehow 0, don't migrate at all */
+	if (!weight_total)
+		return;
+
+	target = ilx % weight_total;
+	for (i = 0; i < dests->nr_dests; i++) {
+		if (target < dests->weight_arr[i])
+			break;
+		target -= dests->weight_arr[i];
+	}
+
+	/* No index being chosen indicates a mistake in the algorithm */
+	if (i == dests->nr_dests) {
+		WARN_ONCE(1, "Error determining target interleave node");
+		return;
+	}
+
+isolate:
+	if (!folio_isolate_lru(folio))
+		return;
+
+	list_add(&folio->lru, &migration_lists[i]);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
-	struct list_head *migration_list = walk->private;
+	struct damos_va_migrate_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	struct list_head *migration_lists = priv->migration_lists;
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pmd_t pmde;
@@ -630,12 +695,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto unlock;
 
-	if (!folio_isolate_lru(folio))
-		goto put_folio;
-
-	list_add(&folio->lru, migration_list);
+	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
 
-put_folio:
 	folio_put(folio);
 unlock:
 	spin_unlock(ptl);
@@ -648,7 +709,10 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 		unsigned long enxt, struct mm_walk *walk)
 {
-	struct list_head *migration_list = walk->private;
+	struct damos_va_migrate_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	struct list_head *migration_lists = priv->migration_lists;
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	pte_t ptent;
 
@@ -660,12 +724,8 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (!folio)
 		return 0;
 
-	if (!folio_isolate_lru(folio))
-		goto out;
-
-	list_add(&folio->lru, migration_list);
+	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
 
-out:
 	folio_put(folio);
 	return 0;
 }
@@ -717,34 +777,54 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 		struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	LIST_HEAD(folio_list);
+	struct damos_va_migrate_private priv;
 	struct task_struct *task;
 	struct mm_struct *mm;
+	int nr_dests;
+	int nid;
+	bool use_target_nid;
 	unsigned long applied = 0;
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct mm_walk_ops walk_ops = {
 		.pmd_entry = damos_va_migrate_pmd_entry,
 		.pte_entry = damos_va_migrate_pte_entry,
 		.walk_lock = PGWALK_RDLOCK,
 	};
 
+	use_target_nid = dests->nr_dests == 0;
+	nr_dests = use_target_nid ? 1 : dests->nr_dests;
+	priv.scheme = s;
+	priv.migration_lists = kmalloc_array(nr_dests,
+		sizeof(struct list_head), GFP_KERNEL);
+	if (!priv.migration_lists)
+		return 0;
+
+	for (int i = 0; i < nr_dests; i++)
+		INIT_LIST_HEAD(&priv.migration_lists[i]);
+
 	task = damon_get_task_struct(target);
 	if (!task)
-		return 0;
+		goto free_lists;
 
 	mm = damon_get_mm(target);
 	if (!mm)
 		goto put_task;
 
 	mmap_read_lock(mm);
-	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &folio_list);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
 	mmap_read_unlock(mm);
 	mmput(mm);
 
-	applied = damon_migrate_pages(&folio_list, s->target_nid);
-	cond_resched();
+	for (int i = 0; i < nr_dests; i++) {
+		nid = use_target_nid ? s->target_nid : dests->node_id_arr[i];
+		applied += damon_migrate_pages(&priv.migration_lists[i], nid);
+		cond_resched();
+	}
 
 put_task:
 	put_task_struct(task);
+free_lists:
+	kfree(priv.migration_lists);
 	return applied * PAGE_SIZE;
 }
 
-- 
2.43.5

