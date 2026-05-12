Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D78377000
	for <damon@lists.linux.dev>; Tue, 12 May 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598938; cv=none; b=iQQEbCUtKJx4f75kM1FClsx+lgTMbzAg2e22A79f15SX/Dl9ohRcineKdmnxliDXtC0acuTsaO2e4aBckHO4I1+4LnxyZcotdOVwlikJPXR2TOnoYQ5HYNYvAAYBqXfSkmCTc9FtGokYeFCnSIxa8nZ2PxfObXRHiG/XJFgE34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598938; c=relaxed/simple;
	bh=9fFuFRGYnUI/E2vbkiO++VJHW4XHJ6ez8pB+7fO9Zik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXSelBevtoLhPjDeaH+X2TzVluliYp6UGy/Lo+3oUDzwoxj0KraLS7QL8qoBkCRnzCTFC2hBlXdjwA/FDCz7bTYEqD7IkBnOQPd+MBD3hcU0U/b5b6l7PdOa/092MXShF2TCch41AkF5WzPF7C1eeq4s+1R0qY08zQGje7XZVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WpousURH; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WpousURH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U2xsWflxLokFAJktyTCaR8iB2eeILFp1cGamAg2ZdJo=;
	b=WpousURHqs5YNQK6mXUiWj2yIRrturD8aV/Cm3BphM6a/Mem+OaPGe8ZsgPlDf3tYFz5/6FLc
	4WQxlIk7b3fm2Ucn+JySn+SgwW9oRlCr/Pe85z7nuCtaNWdjoI7xgoB/VZwyiHXqMjW9yh9N/S9
	61pOJ2C1o6xNQD8lsdt30r4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gFKjH2Y4xz12LFQ;
	Tue, 12 May 2026 23:08:19 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 06F08201E9;
	Tue, 12 May 2026 23:15:25 +0800 (CST)
Received: from localhost.localdomain (10.50.87.83) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 23:15:24 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <sunnanyong@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm/damon/vaddr: attempt per-vma lock during page table walk
Date: Tue, 12 May 2026 23:15:23 +0800
Message-ID: <20260512151523.2092638-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100008.china.huawei.com (7.185.36.138)

Currently, DAMON virtual address operations use mmap_read_lock
during page table walks, which can cause unnecessary contention
under high concurrency.

Introduce damon_va_walk_page_range() to first attempt acquiring a
per-vma lock. If the VMA is found and the range is fully contained
within it, the page table walk proceeds with the per-vma lock
instead of mmap_read_lock.

This optimization is particularly effective for damon_va_young()
and damon_va_mkold(), which are frequently called and typically
operate within a single VMA.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: avoid handling VMAs with the VM_PFNMAP for per-vma path, found by
    Sashiko review.
v1: https://lore.kernel.org/linux-mm/20260511132546.1973270-1-wangkefeng.wang@huawei.com/

 mm/damon/vaddr.c | 69 ++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1b0ebe3b6951..d27147603564 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -237,6 +237,35 @@ static void damon_va_update(struct damon_ctx *ctx)
 	}
 }
 
+static void damon_va_walk_page_range(struct mm_struct *mm, unsigned long start,
+		unsigned long end, struct mm_walk_ops *ops, void *private)
+{
+	struct vm_area_struct *vma;
+
+	vma = lock_vma_under_rcu(mm, start);
+	if (!vma)
+		goto lock_mmap;
+
+	if (end > vma->vm_end) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+
+	if (!(vma->vm_flags & VM_PFNMAP)) {
+		ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
+		walk_page_range_vma(vma, start, end, ops, private);
+	}
+
+	vma_end_read(vma);
+	return;
+
+lock_mmap:
+	mmap_read_lock(mm);
+	ops->walk_lock = PGWALK_RDLOCK;
+	walk_page_range(mm, start, end, ops, private);
+	mmap_read_unlock(mm);
+}
+
 static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
@@ -315,17 +344,14 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_mkold_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_mkold_ops = {
-	.pmd_entry = damon_mkold_pmd_entry,
-	.hugetlb_entry = damon_mkold_hugetlb_entry,
-	.walk_lock = PGWALK_RDLOCK,
-};
-
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
 {
-	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
-	mmap_read_unlock(mm);
+	struct mm_walk_ops damon_mkold_ops = {
+		.pmd_entry = damon_mkold_pmd_entry,
+		.hugetlb_entry = damon_mkold_hugetlb_entry,
+	};
+
+	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
 }
 
 /*
@@ -445,12 +471,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_young_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_young_ops = {
-	.pmd_entry = damon_young_pmd_entry,
-	.hugetlb_entry = damon_young_hugetlb_entry,
-	.walk_lock = PGWALK_RDLOCK,
-};
-
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 		unsigned long *folio_sz)
 {
@@ -459,9 +479,12 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 		.young = false,
 	};
 
-	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
-	mmap_read_unlock(mm);
+	struct mm_walk_ops damon_young_ops = {
+		.pmd_entry = damon_young_pmd_entry,
+		.hugetlb_entry = damon_young_hugetlb_entry,
+	};
+
+	damon_va_walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
 	return arg.young;
 }
 
@@ -750,7 +773,6 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	struct mm_walk_ops walk_ops = {
 		.pmd_entry = damos_va_migrate_pmd_entry,
 		.pte_entry = NULL,
-		.walk_lock = PGWALK_RDLOCK,
 	};
 
 	use_target_nid = dests->nr_dests == 0;
@@ -768,9 +790,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	if (!mm)
 		goto free_lists;
 
-	mmap_read_lock(mm);
-	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
-	mmap_read_unlock(mm);
+	damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
 	mmput(mm);
 
 	for (int i = 0; i < nr_dests; i++) {
@@ -862,7 +882,6 @@ static unsigned long damos_va_stat(struct damon_target *target,
 	struct mm_struct *mm;
 	struct mm_walk_ops walk_ops = {
 		.pmd_entry = damos_va_stat_pmd_entry,
-		.walk_lock = PGWALK_RDLOCK,
 	};
 
 	priv.scheme = s;
@@ -875,9 +894,7 @@ static unsigned long damos_va_stat(struct damon_target *target,
 	if (!mm)
 		return 0;
 
-	mmap_read_lock(mm);
-	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
-	mmap_read_unlock(mm);
+	damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
 	mmput(mm);
 	return 0;
 }
-- 
2.27.0

