Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9C2EC086
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066856; cv=none; b=cXZmVfchynI5BxAPNdfZ2WLoBCV/itMxZMVcG1gOSBalDP/fuvN0E0q1gghdjJZ5mK0ayjXHONkikEk5SKKrzKsP2coCW0zeV0mFi1cqkUILWfESAseDyJJf9W65D8jBug8ScNNIVy/tjTqG2kebUXEXeO+LE1KW84gUIocEE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066856; c=relaxed/simple;
	bh=iV3sIWrGxvWungLl3IqCNLrET/Em/Bu90IrLBSW4Yxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5gAc7YLsrPaZfGTIBJmvReCqf/FPpz7eWYWgzhwIPGsGH+dGZHt+/gvp/4G8Ep/RYm4GUnhhWwlzawOUs1YmH7RPGS1jSLoFIoqzwYI/JP+AmpGuh83xk1XLDJaoYfTROkqNBfkjy9nIrx3K1zyMLIe//oD6EHAnr/Z3nVa058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=JpVaCX9O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="JpVaCX9O"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-855d2bfae95so2535921b3a.1
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066853; x=1788671653; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gXFO776y6OOEgXqFyZQVNGCJghM1qCvRqbZsaMk0vw=;
        b=JpVaCX9OwTEJKq57dHDRGQe3qw9slAfnmZj/5Fu1M10aXslDTyKW0uKDVfMv+Kp+ej
         CB9ssc5JGcLIdyDXs1whk6IGDvD3DjjQ+LV2EJQrLut8hS8Xz5BWViL46f8tbOhHCwtd
         4+Oesg1+9Bf7J9Na86uTsvulx7KNlTkbiaQtqpzVrCjC551Fve+FuxMyTiXMq0rNJnbf
         FxFPIxD+FaOfSYVvo8VuSXBEIKx+rz+RhiLC7WLAJRVZ256EHMjVDd0ed/qO4yIo5nQ/
         eoHq4JtQRHyZGXz4gmjY2p7YGJ1EYH++jvUMItthhe/2A0FBRKoiDMxhZnj0CRgtFEdq
         +VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066853; x=1788671653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gXFO776y6OOEgXqFyZQVNGCJghM1qCvRqbZsaMk0vw=;
        b=Kj3rIddZizwt5sBQhOVdKGWyP3YZt1vtki8opWwe9So5jAvMg71O4Hjae4yhIqGJrY
         /HzCHVUC11T0vehy3yuGBkWn5ekWImKZP+nVHR+SPfHbQLoUKqMq0MddNBzWRd1VhaKc
         2GgIRh8y4cuuGD6fc2f2aE482kJWsY+aKuV1guYdIL2IoLJ+IGeOVanELFr1qK3YNixN
         dvosg3y3sppFVTNm23Q9jZCrSx42jo8Yr0lFFW30N5PDNSWeS/QZhUkR7GNJFLnifwmL
         b0sEXHaI/Jii0EomNLFCH13t7sm4JB2cxQlv3ylnrsD7kIrD+pVYeAxOws6pdMspKDk7
         56ow==
X-Forwarded-Encrypted: i=1; AHgh+RqDZbOxmQ8z3u0G430n9JkXwLVfoJ9fG82fy/prlMI57oZNjHhU1xXy+R2NsOvszLl1GDL0Fg==@lists.linux.dev
X-Gm-Message-State: AFuF++nCXm/CcjK23GIHxgZk5BC3NY7Zf1xZHfeXU6NnwIP4QRCTMqwM
	9K3CHAluSrUcCXwSXR0u5T8tl7adcp+uCqpC2PV+iJzVq4C7NtL+TQcO8xX6ypiaPck=
X-Gm-Gg: AR+sD13elu7RSiLSpDB2eO3QwXjP0XSuP+m03JL/Yh9cu6YorVkYANeeyE7WsHg6RA3
	MWefWb5sv6ZxMEspmknq0QtZPyzskPs28e/JPWiXHwuP2EFvipEeAzXyo3bXsualaY6dYwGIpAg
	QYHXxj7DldZaqXO7SU3lhIzufTKcDw2hg7QcrTrobvNszyRdWK88mjEV2zKL5One51+gS+D4pJa
	/4DK/99n8tt8KCJqt0aW+/+MOzHysH8jLLJRIy5Yl6QWweB6ESEDpyASmKRCb0RIgevlCfO6411
	TGpbOtI/Q9OrPVDq3rdXspwpo4OO4qX9AGuiPAw0zSBc1ymxLu+6EcI97LTDwu4fRAibfwhnuB1
	D72yMEO6l1EpeKTuqyGCwOLscbj/oW+vzIi79CO44etE0CNAwHe1vAYO/zIvVD3IwHEmCKIx/Cp
	vQhUkf2Z6md6YxZVtNFaqIxpbS+ztZDg6piHBnSbahH7jmqIPKXvLkB+aQqtXI8UNE/ySYi4I/p
	icsMRDMPQ/RZiHBV2dxebT0qz6474M/vEo=
X-Received: by 2002:a05:6a21:7e84:b0:3d3:3dca:f0a3 with SMTP id adf61e73a8af0-3d5d787403dmr293487637.8.1788066853425;
        Sat, 29 Aug 2026 22:14:13 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:13 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 4/6] mm/damon: support flush-assisted access bit clearing for monitoring
Date: Sat, 29 Aug 2026 22:14:05 -0700
Message-ID: <20260830051407.50008-5-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260830051407.50008-1-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's access sampling clears the accessed bit of the sampled page and
re-reads it one sampling interval later.  The clearing uses the
non-flushing primitives, deliberately trading accuracy for low
overhead: cached TLB translations survive the clearing, and accesses
through such cached translations do not perform page table walks, hence
do not set the accessed bit again.  The bit therefore re-arms at the
TLB-refill rate rather than the actual access rate.

For most setups this is a good trade-off, since TLB pressure re-walks
hot pages frequently anyway.  It breaks down when translations are
long-lived, most prominently on virtualization hosts backing guest
memory with 1 GiB hugetlb pages: covering hundreds of GiB takes only
hundreds of TLB entries, translations essentially never get evicted,
and secondary MMU (e.g. KVM/EPT) accessed bits cleared via
mmu_notifier_clear_young() are rarely set again.  Measurements on a
1 TiB host showed the reported access fraction pinned at the TLB-refill
rate: a guest workload continuously accessing 842 GiB was
indistinguishable from an idle guest.

Add an 'aging_flush' monitoring context option, default off.  When set,
the sampling primitives pair the accessed bit clearing with
mmu_notifier_clear_flush_young(), so secondary MMUs invalidate their
cached translations and the next guest access must re-walk and re-set
the accessed bit, making the sampled young state reflect the actual
access rate.

The flush covers secondary MMU TLBs only, uniformly across the PTE,
PMD and hugetlb paths.  Primary MMU TLB young-flushing is deliberately
not added: x86 already implements ptep_clear_flush_young() without a
flush on the grounds that primary-TLB accessed-bit staleness is not
worth the flush cost, and the observability target here is secondary
MMU (guest) access state.

The cost is secondary TLB invalidations during the sampling prepare
pass.  KVM coalesces flush requests issued in a burst (pending-request
deduping), so a prepare pass over all regions results in roughly one
guest TLB flush per pass, and hosts whose guests are backed by huge
pages have small TLB working sets that are cheap to re-fill -- exactly
the hosts that need this option.  Measured on a 1 TiB host with a
176-vCPU guest: ~240 flush calls/sec at auto-tuned intervals,
bounding worst-case aggregate overhead below 0.1%.

DAMOS filter paths keep the non-flushing behavior unconditionally.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       |  2 ++
 mm/damon/ops-common.c | 40 ++++++++++++++++++++++++++++------------
 mm/damon/ops-common.h | 12 +++++++-----
 mm/damon/paddr.c      |  7 ++++---
 mm/damon/vaddr.c      | 19 +++++++++++--------
 6 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..7fc438677dd8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -848,6 +848,7 @@ struct damon_attrs {
  * including damon_call() and damos_walk().
  *
  * @addr_unit:	Scale factor for core to ops address conversion.
+ * @aging_flush:	Flush TLBs when clearing access bits for sampling.
  * @min_region_sz:	Minimum region size.
  * @pause:	Pause kdamond main loop.
  */
@@ -899,6 +900,7 @@ struct damon_ctx {
 
 /* public: */
 	unsigned long addr_unit;
+	bool aging_flush;
 	unsigned long min_region_sz;
 	bool pause;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..46d6ec3dbffa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -859,6 +859,7 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->probes);
 
 	ctx->addr_unit = 1;
+	ctx->aging_flush = false;
 	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
@@ -1800,6 +1801,7 @@ static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	if (err)
 		return err;
 	dst->addr_unit = src->addr_unit;
+	dst->aging_flush = src->aging_flush;
 	dst->min_region_sz = src->min_region_sz;
 
 	dst->maybe_corrupted = false;
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index ece101d34684..5c2cd13b9b05 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -63,7 +63,8 @@ struct folio *damon_get_folio_incl_hugetlb(unsigned long pfn)
 	return __damon_get_folio(pfn, true);
 }
 
-void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr,
+		bool flush)
 {
 	pte_t pteval = ptep_get(pte);
 	struct folio *folio;
@@ -86,7 +87,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	 */
 	if (likely(pte_present(pteval)))
 		young |= ptep_test_and_clear_young(vma, addr, pte);
-	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
+	if (flush)
+		young |= mmu_notifier_clear_flush_young(vma->vm_mm, addr,
+				addr + PAGE_SIZE);
+	else
+		young |= mmu_notifier_clear_young(vma->vm_mm, addr,
+				addr + PAGE_SIZE);
 	if (young)
 		folio_set_young(folio);
 
@@ -94,7 +100,8 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	folio_put(folio);
 }
 
-void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr,
+		bool flush)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	pmd_t pmdval = pmdp_get(pmd);
@@ -113,7 +120,12 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 
 	if (likely(pmd_present(pmdval)))
 		young |= pmdp_test_and_clear_young(vma, addr, pmd);
-	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE);
+	if (flush)
+		young |= mmu_notifier_clear_flush_young(vma->vm_mm, addr,
+				addr + HPAGE_PMD_SIZE);
+	else
+		young |= mmu_notifier_clear_young(vma->vm_mm, addr,
+				addr + HPAGE_PMD_SIZE);
 	if (young)
 		folio_set_young(folio);
 
@@ -124,7 +136,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 
 #ifdef CONFIG_HUGETLB_PAGE
 void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct vm_area_struct *vma, unsigned long addr, bool flush)
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(mm, addr, pte);
@@ -139,8 +151,10 @@ void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 		set_huge_pte_at(mm, addr, pte, entry, psize);
 	}
 
-	if (mmu_notifier_clear_young(mm, addr,
-				     addr + huge_page_size(hstate_vma(vma))))
+	if (flush ? mmu_notifier_clear_flush_young(mm, addr,
+				addr + huge_page_size(hstate_vma(vma))) :
+			mmu_notifier_clear_young(mm, addr,
+				addr + huge_page_size(hstate_vma(vma))))
 		referenced = true;
 
 	if (referenced)
@@ -212,6 +226,7 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 static bool damon_folio_mkold_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
+	bool flush = *(bool *)arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
 	while (page_vma_mapped_walk(&pvmw)) {
@@ -224,19 +239,20 @@ static bool damon_folio_mkold_one(struct folio *folio,
 			 */
 			if (folio_test_hugetlb(folio))
 				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
-						addr);
+						addr, flush);
 			else
-				damon_ptep_mkold(pvmw.pte, vma, addr);
+				damon_ptep_mkold(pvmw.pte, vma, addr, flush);
 		} else {
-			damon_pmdp_mkold(pvmw.pmd, vma, addr);
+			damon_pmdp_mkold(pvmw.pmd, vma, addr, flush);
 		}
 	}
 	return true;
 }
 
-void damon_folio_mkold(struct folio *folio)
+void damon_folio_mkold(struct folio *folio, bool flush)
 {
 	struct rmap_walk_control rwc = {
+		.arg = &flush,
 		.rmap_one = damon_folio_mkold_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
@@ -377,7 +393,7 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio)
 	case DAMOS_FILTER_TYPE_YOUNG:
 		matched = damon_folio_young(folio);
 		if (matched)
-			damon_folio_mkold(folio);
+			damon_folio_mkold(folio, false);
 		break;
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
 		folio_sz = folio_size(folio);
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 68d7de49c87a..df7ef025bc1a 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -8,18 +8,20 @@
 struct folio *damon_get_folio(unsigned long pfn);
 struct folio *damon_get_folio_incl_hugetlb(unsigned long pfn);
 
-void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
-void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr,
+		bool flush);
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr,
+		bool flush);
 #ifdef CONFIG_HUGETLB_PAGE
 void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
-		struct vm_area_struct *vma, unsigned long addr);
+		struct vm_area_struct *vma, unsigned long addr, bool flush);
 #else
 static inline void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct vm_area_struct *vma, unsigned long addr, bool flush)
 {
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
-void damon_folio_mkold(struct folio *folio);
+void damon_folio_mkold(struct folio *folio, bool flush);
 bool damon_folio_young(struct folio *folio);
 
 int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 09d418b2874b..f2aaa82325d1 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -35,14 +35,14 @@ static unsigned long damon_pa_core_addr(
 	return pa / addr_unit;
 }
 
-static void damon_pa_mkold(phys_addr_t paddr)
+static void damon_pa_mkold(phys_addr_t paddr, bool flush)
 {
 	struct folio *folio = damon_get_folio_incl_hugetlb(PHYS_PFN(paddr));
 
 	if (!folio)
 		return;
 
-	damon_folio_mkold(folio);
+	damon_folio_mkold(folio, flush);
 	folio_put(folio);
 }
 
@@ -51,7 +51,8 @@ static void __damon_pa_prepare_access_check(struct damon_region *r,
 {
 	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
 
-	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, ctx->addr_unit));
+	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, ctx->addr_unit),
+			ctx->aging_flush);
 }
 
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 15379d984689..7c11022bb664 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -276,7 +276,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		pmd_t pmde = pmdp_get(pmd);
 
 		if (pmd_present(pmde))
-			damon_pmdp_mkold(pmd, walk->vma, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr,
+					*(bool *)walk->private);
 		spin_unlock(ptl);
 		return 0;
 	}
@@ -286,7 +287,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return 0;
 	if (!pte_present(ptep_get(pte)))
 		goto out;
-	damon_ptep_mkold(pte, walk->vma, addr);
+	damon_ptep_mkold(pte, walk->vma, addr, *(bool *)walk->private);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
@@ -306,7 +307,8 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto out;
 
-	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
+	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr,
+			    *(bool *)walk->private);
 
 out:
 	spin_unlock(ptl);
@@ -316,14 +318,15 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_mkold_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+static void damon_va_mkold(struct mm_struct *mm, unsigned long addr,
+		bool flush)
 {
 	struct mm_walk_ops damon_mkold_ops = {
 		.pmd_entry = damon_mkold_pmd_entry,
 		.hugetlb_entry = damon_mkold_hugetlb_entry,
 	};
 
-	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
+	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, &flush);
 }
 
 /*
@@ -336,7 +339,7 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
 {
 	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
 
-	damon_va_mkold(mm, r->sampling_addr);
+	damon_va_mkold(mm, r->sampling_addr, ctx->aging_flush);
 }
 
 static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
@@ -508,9 +511,9 @@ static bool damos_va_filter_young_match(struct damos_filter *filter,
 		mmu_notifier_test_young(vma->vm_mm, addr);
 
 	if (young && ptep)
-		damon_ptep_mkold(ptep, vma, addr);
+		damon_ptep_mkold(ptep, vma, addr, false);
 	else if (young && pmdp)
-		damon_pmdp_mkold(pmdp, vma, addr);
+		damon_pmdp_mkold(pmdp, vma, addr, false);
 
 	return young == filter->matching;
 }
-- 
2.54.0

