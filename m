Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC61E25E8
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022872; cv=none; b=WsgWRRMNd0P8yxiRBAZ5RG42LSQi6A92L8Q8E/K74FYY0ZXCywqFnjClvUCK+hWTx+SOf35gXnAHUsF93jQHc5MEttZKmXQQpj3B+nUSqN3bWfucpfheCwNNngEQQC+/pTNzUbTDdQRpAc0AOc768TSWAcNFHDGXiUe+w9dr/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022872; c=relaxed/simple;
	bh=JzE3Nk/VzSdLN7NSVCdb6rvenOkMzV6KjMxB/f2iteE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmxLUp9Jel/eaH1/XvI75qZ5+D4fO4Ln3Uwmc+VnZedgcSxzLsfabGwqdVTS6n73kPncT1mBOSaIgdkfYFvp9L+ckzF6k9yWKvqg8sboUxm+/I0AYc/EsZ1OjrZ067znQJ0AOlzkwh8XkokJQ7ThJvnEnfKC5bvlFHCRJY4bxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/V02OB0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/V02OB0"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8275f110c6so3526003276.2
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022869; x=1752627669; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwtNm4BtmVP3B29Sr0z6Dg9gSZdTDCfEDKjBCM7yKB4=;
        b=Y/V02OB0EfzKUrYjbpX1iL2MbO0T9m40GAlnDODHXDmImSWx2cOaZuih0ZIGNDKnkl
         /28SKE1oApd1Q9Bn3XRajBMjahK1dmIa+PFcQRMk8sS3RsO4aLMvN41U4SnVpUdvNd5j
         m2K63ZY5eBc6geAtUSEHrCMii0eIivyNY4jLXc63mO4fcayX/EAMKGQMH65S7gpOdH3S
         WPcF0cKldKvr5Vuq5U2+R/b5DL+88V+Hfur81/GcArX5K404x8NtGPFrHmYwtWqO+6X4
         5UgIRkN8ygNazIW4+PKG9e3/ujj/1GC/Avwvty78Yj0kUvv2bmXC4/LbBmjSNbjPEv4Z
         QhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022869; x=1752627669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwtNm4BtmVP3B29Sr0z6Dg9gSZdTDCfEDKjBCM7yKB4=;
        b=RPl/utb59LHrF0wjPkOvsBCs9D0YGAK8hNdXhRCL+ltIuR+MxlreisS4HUSQq+LPae
         pmBw5hF6zAswMdkLt2op1hgLeTNTk4fnMqtct4+lGaOsaca04rHaEmb36VbnxRkEl9dX
         RnB3QWGWg5LV/elzacKinTWrch+W8JFdxXe+49c/BKeTiu1jKCzILVboPa3RQU3gM4O/
         0eKXqNPlzQ48CJJdjLjCvckFr6RQ++XLsZxs27u6Jvb2btR1nLgjrKqZRt/bf8YpLiox
         Zx1WjaNsbExAhTPeR4Vcw9qbxE2X25LskBeAyx6creQ9+nhYkdO0n6UHThtoXXZkANVM
         wdHA==
X-Gm-Message-State: AOJu0YzK3E30yBp/5QMmbfI50mSnF8vlWovs1y61MCr7U1XyLF/Yt+SO
	2BaxicjGgNyhl+9u58sEm+ZG4/mZpPz27BDEtsYNDIbK42uECbqDjJa4Jujj5xx+o8Q=
X-Gm-Gg: ASbGnctu/65accqgXNJOo35v9QxdzByFH8eSACq8Sf0UREje/3yC4dOLtZBZ8krnMd/
	U+sNIwHzOrmS+/INTQtSp75JOv8t+48rJ4fQfzxwGyHrwX1nfxyNtqakkqIfswLPDz2RAIZB5dL
	DPs+O1WQ2KkMDMb1YDQmPKuoV6f0Uu7WzSWaq1Uyckd03mZZLkCJkC7CNl28j8I3B+19N/fZlJv
	2kC5Vlbu0uY3sGJEDmHBA/23HPHXRCuSuVHvpam2+1SNKy18gN8iMVShHtnEc4OMw3KTCrnd2wZ
	88dr2+qNR/G35iyKfIOYq5b8hG6GPW/7y8beBf59r01rmEi0+iqNEoFjM22oO2fjpgkf0lFwAZ6
	hQ6QS0Mg=
X-Google-Smtp-Source: AGHT+IEyRvCqbPeHTafmEDhZZQo8dDhtfIjvEfEuUPSnxmp83I7UH79ZdtpmrabA8PjyfakEBMidxg==
X-Received: by 2002:a05:6902:2309:b0:e8b:53ba:535 with SMTP id 3f1490d57ef6-e8b6e0e2aeamr1046878276.15.1752022869325;
        Tue, 08 Jul 2025 18:01:09 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:01:08 -0700 (PDT)
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
Subject: [PATCH v4 11/13] mm/damon/vaddr: Use damos->migrate_dests in migrate_{hot,cold}
Date: Tue,  8 Jul 2025 19:59:41 -0500
Message-ID: <20250709005952.17776-12-bijan311@gmail.com>
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
 mm/damon/vaddr.c | 108 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 16 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b244ac056416..47d5f33f89c8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -611,11 +611,69 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+struct damos_va_migrate_private {
+	struct list_head *migration_lists;
+	struct damos_migrate_dests *dests;
+};
+
+/*
+ * Place the given folio in the migration_list corresponding to where the folio
+ * should be migrated.
+ *
+ * The algorithm used here is similar to weighted_interleave_nid()
+ */
+static void damos_va_migrate_dests_add(struct folio *folio,
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
+	struct list_head *migration_lists = priv->migration_lists;
+	struct damos_migrate_dests *dests = priv->dests;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pmd_t pmde;
@@ -633,12 +691,9 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto unlock;
 
-	if (!folio_isolate_lru(folio))
-		goto put_folio;
-
-	list_add(&folio->lru, migration_list);
+	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
+		migration_lists);
 
-put_folio:
 	folio_put(folio);
 unlock:
 	spin_unlock(ptl);
@@ -651,7 +706,9 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
-	struct list_head *migration_list = walk->private;
+	struct damos_va_migrate_private *priv = walk->private;
+	struct list_head *migration_lists = priv->migration_lists;
+	struct damos_migrate_dests *dests = priv->dests;
 	struct folio *folio;
 	pte_t ptent;
 
@@ -663,12 +720,9 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (!folio)
 		return 0;
 
-	if (!folio_isolate_lru(folio))
-		goto out;
+	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
+		migration_lists);
 
-	list_add(&folio->lru, migration_list);
-
-out:
 	folio_put(folio);
 	return 0;
 }
@@ -721,26 +775,48 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 		unsigned long *sz_filter_passed)
 {
 	LIST_HEAD(folio_list);
+	struct damos_va_migrate_private priv;
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
+	priv.dests = dests;
+	priv.migration_lists = kmalloc_array(nr_dests,
+		sizeof(*priv.migration_lists), GFP_KERNEL);
+	if (!priv.migration_lists)
+		return 0;
+
+	for (int i = 0; i < nr_dests; i++)
+		INIT_LIST_HEAD(&priv.migration_lists[i]);
+
+
 	mm = damon_get_mm(target);
 	if (!mm)
-		return 0;
+		goto free_lists;
 
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
 
+free_lists:
+	kfree(priv.migration_lists);
 	return applied * PAGE_SIZE;
 }
 
-- 
2.43.0

