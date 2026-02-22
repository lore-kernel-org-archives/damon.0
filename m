Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24F244661
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750195; cv=none; b=cFCpqTxzIsB++mnQwsf8o5k2zleOCvMN5sJ7mJGMs9JZBz9cS6FEtYPw0g82dlhYQYo2i7qv8HqeWMNBtTYkAXGOt92NcNKvHiapm7UAWIWkGBB/8zJulnSaQJJqxEB5vp1KW0XaqXuZx5qZkzfjbO2VZCVvug60eBwgYFRTSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750195; c=relaxed/simple;
	bh=WQREA0eRzyGSJaLiXYZZmNn1uvwWrj7DPFe0mrMY5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR7s/DMUWG6NCx4WENx8OvPQ+RY3WUTH58fW+JOI6Wy2VjaInBeUCRGsa7eAjNAk3vrZa0wnV7j/o6ZOTUNvTw4RBq9SxF+1bbByCQxl8760G+Fg5S0sUAYEemQdE5kJhEX29bggr/l1d+y4LscVbaoUEsyQyeP0DDiwYzjB/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QPmpX8e4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QPmpX8e4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506bcb23a78so29927461cf.3
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750192; x=1772354992; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FaS5B9cAZ3FLbrF/E2Ph8lRS4c3BU4jWIQ83JN7l+U=;
        b=QPmpX8e46ZUjNrbQ3+abIkCCFE/Y8RlA8y71WOOrFolaQgb8pPpHkPG+zHFhpANDzg
         X2jBbFcfMxkXjN3lVswkROa3jPe4mbPBjFzglCjPlh1Je1lVXc+YiQCfKvibwwximWNI
         yambdprU8RcWEjVR8JptsbctC0W1O4Bo/DLGqft4P/17dmyTrJT765Xh5yHF0G9atrOi
         1xsNDzO/3+fo9Yuveevf4MyE5OITP8T9oyWF1XklxbpdxhF65flRwgNwBqTK+Un0sua7
         PbYQsA4UQuchwsGsqDzGTG4qco2wIIOVCTigHVpT3v7J8QTHjUkMuEb85vF9gNJkOE4W
         m5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750192; x=1772354992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FaS5B9cAZ3FLbrF/E2Ph8lRS4c3BU4jWIQ83JN7l+U=;
        b=HzKqXzofrhsr5fdiYNGyA76L8XJYqqfpbyiWO9OKWLDGUe9ove2+kU4JeL+Q3dhhoM
         L+sTzALvJqsAfBvdEHFalr/LvOV3h6IJHbMfZiipD2U0gvilc6NdstaSAXGD/Mc9QCCC
         Ki6J+olDfqy7cI5tJvLWSaEEJHeDMX89Toj2wdtt/3P4id+xYCkduGXKvaSDySwVVoks
         7fYn/jp3sA0ekKlod906Xcc6QFO1+T04H0KkScaFtw2NAnUFzxovQ8jTuVVGPrtDjTLF
         av5+N9hZLe3f/au1RyzxacNK8cburzGp1VKRKV2SpGKx2QzKM2j8erKPcH0jveHHtfH+
         KSzw==
X-Forwarded-Encrypted: i=1; AJvYcCWZheMEozBtFCC5Qrql2PFgn/m7NL+Ql6YW1ExFMVTAgYjkh5FwMzWocO/2OcdomHlv8R2cJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO6Hi6mRYOcs3eOV2zkaHDSUhNnecQitK3rz1PzozIis5708w3
	2GauQtk5Ksf0aTUgB/Old5lqdnD1f0XX6WOvRBHW16stz+VFc4CSrMEI4rdE2aSbQQo=
X-Gm-Gg: AZuq6aJMoFiVzJEmVllVI7qwB1HnBn6lCWGEdiEtD3T0JMjBjGHascVfxVphjJCrtNE
	MY5W1eyA0X1HJtrUN33QZ0WK1UsVACNeZaCWewNfd9t4ftTqnsZcjGCHOcetdCo7AcrZnhkMhZ4
	dBLIU1ORr9f3ubVcg8DEcPukm3hzBhtCt+XoqqCx6ZGBHmi6KagiWgBxxd2/bZcj48b19gXpug+
	P0VixDk/3Dv5todDLI4S0inT8s2bBnxmyMtvLz5XPKNO7Wln8dQECdF77Gn7jv9AQ64unkOQHNq
	HTnJgoAwh28D1mDXiXenMHiEQtIAS0h7wE5VJiH1p2ew7eALbiA9i9R2NySwCZb3GJr5Y0bC1VP
	MfQecOjeHtzc0HlA9fbHN4TfLSoJsG6J8WyvA8No60AHyYv7EDXH65SFdB9p+JfUOka6yGbIRRT
	Ab49STldTBtAJd9YpgwmJ69CBJh5NDx5OpfFm8MosAtM7oKFE0am5WXweIaWI5fBujXsHNHGYM0
	PWkIO+aM35UwiE=
X-Received: by 2002:a05:622a:19a1:b0:4ff:c04c:3d75 with SMTP id d75a77b69052e-5070bc4b9ddmr74426531cf.43.1771750191585;
        Sun, 22 Feb 2026 00:49:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:51 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 15/27] mm/mprotect: NP_OPS_PROTECT_WRITE - gate PTE/PMD write-upgrades
Date: Sun, 22 Feb 2026 03:48:30 -0500
Message-ID: <20260222084842.1824063-16-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Services that intercept write faults (e.g., for promotion tracking)
need PTEs to stay read-only. This requires preventing mprotect
from silently upgrade the PTE, bypassing the service's handle_fault
callback.

Add NP_OPS_PROTECT_WRITE and folio_managed_wrprotect().

In change_pte_range() and change_huge_pmd(), suppress PTE write-upgrade
when MM_CP_TRY_CHANGE_WRITABLE is sees the folio is write-protected.

In handle_pte_fault() and do_huge_pmd_wp_page(), dispatch to the node's
ops->handle_fault callback when set, allowing the service to handle write
faults with promotion or other custom logic.

NP_OPS_MEMPOLICY is incompatible with NP_OPS_PROTECT_WRITE to avoid the
footgun of binding a writable VMA to a write-protected node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  4 ++
 include/linux/node_private.h | 22 ++++++++
 mm/huge_memory.c             | 17 ++++++-
 mm/internal.h                | 99 ++++++++++++++++++++++++++++++++++++
 mm/memory.c                  | 15 ++++++
 mm/migrate.c                 | 14 +----
 mm/mprotect.c                |  4 +-
 7 files changed, 159 insertions(+), 16 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index c08b5a948779..a4955b9b5b93 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -957,6 +957,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    !(ops->flags & NP_OPS_MIGRATION))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_MEMPOLICY) &&
+	    (ops->flags & NP_OPS_PROTECT_WRITE))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index e254e36056cd..27d6e5d84e61 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -70,6 +70,24 @@ struct vm_fault;
  *     PFN-based metadata (compression tables, device page tables, DMA
  *     mappings, etc.) before any access through the page tables.
  *
+ * @handle_fault: Handle fault on folio on this private node.
+ *   [folio-referenced callback, PTL held on entry]
+ *
+ *   Called from handle_pte_fault() (PTE level) or do_huge_pmd_wp_page()
+ *   (PMD level) after lock acquisition and entry verification.
+ *   @folio is the faulting folio, @level indicates the page table level.
+ *
+ *   For PGTABLE_LEVEL_PTE: vmf->pte is mapped and vmf->ptl is the
+ *   PTE lock.  Release via pte_unmap_unlock(vmf->pte, vmf->ptl).
+ *
+ *   For PGTABLE_LEVEL_PMD: vmf->pte is NULL and vmf->ptl is the
+ *   PMD lock.  Release via spin_unlock(vmf->ptl).
+ *
+ *   The callback MUST release PTL on ALL paths.
+ *   The caller will NOT touch the page table entry after this returns.
+ *
+ *   Returns: vm_fault_t result (0, VM_FAULT_RETRY, etc.)
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
@@ -81,6 +99,8 @@ struct node_private_ops {
 				  enum migrate_reason reason,
 				  unsigned int *nr_succeeded);
 	void (*folio_migrate)(struct folio *src, struct folio *dst);
+	vm_fault_t (*handle_fault)(struct folio *folio, struct vm_fault *vmf,
+				   enum pgtable_level level);
 	unsigned long flags;
 };
 
@@ -90,6 +110,8 @@ struct node_private_ops {
 #define NP_OPS_MEMPOLICY		BIT(1)
 /* Node participates as a demotion target in memory-tiers */
 #define NP_OPS_DEMOTION			BIT(2)
+/* Prevent mprotect/NUMA from upgrading PTEs to writable on this node */
+#define NP_OPS_PROTECT_WRITE		BIT(3)
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ecae494291a..d9ba6593244d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2063,12 +2063,14 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t orig_pmd = vmf->orig_pmd;
+	vm_fault_t ret;
+
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
 	if (is_huge_zero_pmd(orig_pmd)) {
-		vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
+		ret = do_huge_zero_wp_pmd(vmf);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -2088,6 +2090,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	folio = page_folio(page);
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
+	/* Private-managed write-protect: let the service handle the fault */
+	if (unlikely(folio_is_private_managed(folio))) {
+		if (folio_managed_handle_fault(folio, vmf,
+					      PGTABLE_LEVEL_PMD, &ret))
+			return ret;
+	}
+
 	/* Early check when only holding the PT lock. */
 	if (PageAnonExclusive(page))
 		goto reuse;
@@ -2633,7 +2642,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
-	    can_change_pmd_writable(vma, addr, entry))
+	    can_change_pmd_writable(vma, addr, entry) &&
+	    !folio_managed_wrprotect(pmd_folio(entry)))
 		entry = pmd_mkwrite(entry, vma);
 
 	ret = HPAGE_PMD_NR;
@@ -4943,6 +4953,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
+	if (folio_managed_wrprotect(folio))
+		pmde = pmd_wrprotect(pmde);
+
 	if (folio_is_device_private(folio)) {
 		swp_entry_t entry;
 
diff --git a/mm/internal.h b/mm/internal.h
index 5950e20d4023..ae4ff86e8dc6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -11,6 +11,7 @@
 #include <linux/khugepaged.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/node_private.h>
 #include <linux/pagemap.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
@@ -18,6 +19,7 @@
 #include <linux/leafops.h>
 #include <linux/swap_cgroup.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/node_private.h>
 
 /* Internal core VMA manipulation functions. */
 #include "vma.h"
@@ -1449,6 +1451,103 @@ static inline bool folio_managed_on_free(struct folio *folio)
 	return false;
 }
 
+/*
+ * folio_managed_handle_fault - Dispatch fault on managed-memory folio
+ * @folio: the faulting folio (must not be NULL)
+ * @vmf: the vm_fault descriptor (PTL held: vmf->ptl locked)
+ * @level: page table level (PGTABLE_LEVEL_PTE or PGTABLE_LEVEL_PMD)
+ * @ret: output fault result if handled
+ *
+ * Called with PTL held.  If a handle_fault callback exists, it is invoked
+ * with PTL still held.  The callback is responsible for releasing PTL on
+ * all paths.
+ *
+ * Returns true if the service handled the fault (PTL released by callback,
+ * caller returns *ret).  Returns false if no handler exists (PTL still held,
+ * caller continues with normal fault handling).
+ */
+static inline bool folio_managed_handle_fault(struct folio *folio,
+					      struct vm_fault *vmf,
+					      enum pgtable_level level,
+					      vm_fault_t *ret)
+{
+	/* Zone device pages use swap entries; handled in do_swap_page */
+	if (folio_is_zone_device(folio))
+		return false;
+
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->handle_fault) {
+			*ret = ops->handle_fault(folio, vmf, level);
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * folio_managed_wrprotect - Should this folio's mappings stay write-protected?
+ * @folio: the folio to check
+ *
+ * Returns true if the folio is on a private node with NP_OPS_PROTECT_WRITE,
+ * meaning page table entries (PTE or PMD) should not be made writable.
+ * Write faults are intercepted by the service's handle_fault callback
+ * to promote the folio to DRAM.
+ *
+ * Used by:
+ *   - change_pte_range() / change_huge_pmd(): prevent mprotect write-upgrade
+ *   - remove_migration_pte() / remove_migration_pmd(): strip write after migration
+ *   - do_huge_pmd_wp_page(): dispatch to fault handler instead of reuse
+ */
+static inline bool folio_managed_wrprotect(struct folio *folio)
+{
+	return unlikely(folio_is_private_node(folio) &&
+			folio_private_flags(folio, NP_OPS_PROTECT_WRITE));
+}
+
+/**
+ * folio_managed_fixup_migration_pte - Fixup PTE after migration for
+ *                                     managed memory pages.
+ * @new: the destination page
+ * @pte: the PTE being installed (normal PTE built by caller)
+ * @old_pte: the original PTE (before migration, for swap entry flags)
+ * @vma: the VMA
+ *
+ * For MEMORY_DEVICE_PRIVATE pages: replaces the PTE with a device-private
+ * swap entry, preserving soft_dirty and uffd_wp from old_pte.
+ *
+ * For N_MEMORY_PRIVATE pages with NP_OPS_PROTECT_WRITE: strips the write
+ * bit so the next write triggers the fault handler for promotion.
+ *
+ * For normal pages: returns pte unmodified.
+ */
+static inline pte_t folio_managed_fixup_migration_pte(struct page *new,
+						      pte_t pte,
+						      pte_t old_pte,
+						      struct vm_area_struct *vma)
+{
+	if (unlikely(is_device_private_page(new))) {
+		softleaf_t entry;
+
+		if (pte_write(pte))
+			entry = make_writable_device_private_entry(
+						page_to_pfn(new));
+		else
+			entry = make_readable_device_private_entry(
+						page_to_pfn(new));
+		pte = softleaf_to_pte(entry);
+		if (pte_swp_soft_dirty(old_pte))
+			pte = pte_swp_mksoft_dirty(pte);
+		if (pte_swp_uffd_wp(old_pte))
+			pte = pte_swp_mkuffd_wp(pte);
+	} else if (folio_managed_wrprotect(page_folio(new))) {
+		pte = pte_wrprotect(pte);
+	}
+	return pte;
+}
+
 /**
  * folio_managed_migrate_notify - Notify service that a folio changed location
  * @src: the old folio (about to be freed)
diff --git a/mm/memory.c b/mm/memory.c
index 2a55edc48a65..0f78988befef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6079,6 +6079,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
+	if (unlikely(folio && folio_managed_wrprotect(folio))) {
+		writable = false;
+		ignore_writable = true;
+	}
 	if (folio && folio_test_large(folio))
 		numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable,
 					   pte_write_upgrade);
@@ -6228,6 +6232,7 @@ static void fix_spurious_fault(struct vm_fault *vmf,
  */
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
+	struct folio *folio;
 	pte_t entry;
 
 	if (unlikely(pmd_none(*vmf->pmd))) {
@@ -6284,6 +6289,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
+
+	folio = vm_normal_folio(vmf->vma, vmf->address, entry);
+	if (unlikely(folio && folio_is_private_managed(folio))) {
+		vm_fault_t fault_ret;
+
+		if (folio_managed_handle_fault(folio, vmf, PGTABLE_LEVEL_PTE,
+					       &fault_ret))
+			return fault_ret;
+	}
+
 	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
diff --git a/mm/migrate.c b/mm/migrate.c
index a54d4af04df3..f632e8b03504 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -398,19 +398,7 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_anon(folio) && !softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		if (unlikely(is_device_private_page(new))) {
-			if (pte_write(pte))
-				entry = make_writable_device_private_entry(
-							page_to_pfn(new));
-			else
-				entry = make_readable_device_private_entry(
-							page_to_pfn(new));
-			pte = softleaf_to_pte(entry);
-			if (pte_swp_soft_dirty(old_pte))
-				pte = pte_swp_mksoft_dirty(pte);
-			if (pte_swp_uffd_wp(old_pte))
-				pte = pte_swp_mkuffd_wp(pte);
-		}
+		pte = folio_managed_fixup_migration_pte(new, pte, old_pte, vma);
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 283889e4f1ce..830be609bc24 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -30,6 +30,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/node_private.h>
 #include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -290,7 +291,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 * COW or special handling is required.
 			 */
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
-			     !pte_write(ptent))
+			     !pte_write(ptent) &&
+			     !(folio && folio_managed_wrprotect(folio)))
 				set_write_prot_commit_flush_ptes(vma, folio, page,
 				addr, pte, oldpte, ptent, nr_ptes, tlb);
 			else
-- 
2.53.0

