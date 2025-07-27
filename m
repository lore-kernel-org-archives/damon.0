Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192E23A98D;
	Sun, 27 Jul 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647504; cv=none; b=c6jureDmvispNvDTYKiHbyc33VLCCdOTr3YLDoYgqYDsuswPhl2Jbe2bdciGmKA9kU+x7fwWx13PDDrG3TVxwx2t3tZJdWFHIoMzkRI8cmDDbnXVrUeLZXToBGPruwHvePlkwVhjh9zTLHBgu+NJ86cs+7sPlIhr4Lj8x/owRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647504; c=relaxed/simple;
	bh=WGQcM9UnLZgKBQqcVI81lbDDPjMMbRc1qGpPElDOEoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6tvDtD2gfdwQNFoy4QqO35mqZjpisX/MwzQg1wGHp/J0OLk6qhunNv8OC3EGcUIdHWdadynAkrOxBJtH5wPZcKQX1KaETjXFmluK+nVPAmMzHeGgJnmED9Qo5Y4qjE5HABvMkIbzd4JHbq81EKlwM6B7crUgRbPt4s7pzpAcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwk10txZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwk10txZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AEDC4CEEF;
	Sun, 27 Jul 2025 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647503;
	bh=WGQcM9UnLZgKBQqcVI81lbDDPjMMbRc1qGpPElDOEoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pwk10txZDLZxjPwQc1qT4zeUjOU9Po7GZs0gkYhI9apYTp89LeOs+ML2c2IstQ5oz
	 2oJxTDKqVp9sz5jghf6QByvyejV8Xt+Z3bGx2snEozm5e6JwbcsLsgEQrR6VUnAAgv
	 2UzrHdggs5IlMth+PJsPs5B9DKF3xHu5yj3PXxb8z+RnJvzPOAtBEarANZEJztZnPV
	 jL2UWDQ7NQuED2XQWMSzxZc/ERzdNYvafbVpQDyZgcy7r1pnHsXAf9OZz1QQmyAb4s
	 GnuxF99fxHci/Dh4AyWaio8GSn1u0150UlDt9NvZ/feTj/7XeQUPlyD975a2jXPdd1
	 7WWY3/E1wR5EA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 5/7] mm/memory: implement MM_CP_DAMON
Date: Sun, 27 Jul 2025 13:18:11 -0700
Message-Id: <20250727201813.53858-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON is using Accessed bits of page table entries as the major source
of the access information.  It lacks some additional information such as
which CPU was making the access.  Page faults could be another source of
information for such additional information.

Implement another change_protection() flag for such use case, namely
MM_CP_DAMON.  DAMON will install PAGE_NONE protections using the flag.
To avoid interfering with NUMA_BALANCING, which is also using PAGE_NON
protection, pass the faults to DAMON only when NUMA_BALANCING is
disabled.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/mm.h |  1 +
 mm/memory.c        | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/mprotect.c      |  5 +++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21270f1664a4..ad92b77bf782 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2567,6 +2567,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
+#define MM_CP_DAMON                        (1UL << 4)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
diff --git a/mm/memory.c b/mm/memory.c
index 92fd18a5d8d1..656e610867b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -75,6 +75,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/damon.h>
 
 #include <trace/events/kmem.h>
 
@@ -5972,6 +5973,47 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+static vm_fault_t do_damon_page(struct vm_fault *vmf, bool huge_pmd)
+{
+	struct damon_access_report access_report = {
+		.addr = vmf->address,
+		.size = 1,
+	};
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
+	pte_t pte, old_pte;
+	bool writable = false, ignore_writable = false;
+	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
+
+	if (huge_pmd)
+		access_report.addr = PFN_PHYS(pmd_pfn(vmf->orig_pmd));
+	else
+		access_report.addr = PFN_PHYS(pte_pfn(vmf->orig_pte));
+
+	spin_lock(vmf->ptl);
+	old_pte = ptep_get(vmf->pte);
+	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+	pte = pte_modify(old_pte, vma->vm_page_prot);
+	writable = pte_write(pte);
+	if (!writable && pte_write_upgrade &&
+			can_change_pte_writable(vma, vmf->address, pte))
+		writable = true;
+	folio = vm_normal_folio(vma, vmf->address, pte);
+	if (folio && folio_test_large(folio))
+		numa_rebuild_large_mapping(vmf, vma, folio, pte,
+				ignore_writable, pte_write_upgrade);
+	else
+		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
+				writable);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	damon_report_access(&access_report);
+	return 0;
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -6036,8 +6078,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		if (sysctl_numa_balancing_mode == NUMA_BALANCING_DISABLED)
+			return do_damon_page(vmf, false);
 		return do_numa_page(vmf);
+	}
 
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
@@ -6159,8 +6204,12 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			return 0;
 		}
 		if (pmd_trans_huge(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
+				if (sysctl_numa_balancing_mode ==
+						NUMA_BALANCING_DISABLED)
+					return do_damon_page(&vmf, true);
 				return do_huge_pmd_numa_page(&vmf);
+			}
 
 			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
 			    !pmd_write(vmf.orig_pmd)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 78bded7acf79..e8a76114e4f9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -714,6 +714,11 @@ long change_protection(struct mmu_gather *tlb,
 	WARN_ON_ONCE(cp_flags & MM_CP_PROT_NUMA);
 #endif
 
+#ifdef CONFIG_ARCH_SUPPORTS_NUMA_BALANCING
+	if (cp_flags & MM_CP_DAMON)
+		newprot = PAGE_NONE;
+#endif
+
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot,
 						  cp_flags);
-- 
2.39.5
