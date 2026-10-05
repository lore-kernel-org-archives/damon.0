Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5B418A5E
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190015; cv=none; b=LZO8BvU+JGtmZ2J8RXUIi/cz0Zv+vyvjN60DN6tPVNvZwtsL3Zl80dfBEFVcKX2CEDwPcMD1KMaZNMtlidLWaaqmq77bM+aOYvp1y4JJKCfTP/pe0Vs0rrQGpQiDk23VRpIcolNkK6hfxHyb4/Bk5y1H7gwJB0cn8oA02MYcxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190015; c=relaxed/simple;
	bh=Q6X5cMnxfbFv1kLPBOF+zyFBTmJZLWIIC90aG9kW9lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZfu7jCY/emA+J94FSblj/8WcOph5tf+yOcc1Wr9/y6qBlvnim4zJ3XkKesuhHYDxIje4+xuzRR4LQPJnklu/0r6jbyKnuJGujZ1pW0OgpfsBHWXYScRloKaxWTEerSoWZyT09K8POMNfV0RNnY+zRnZ54RnKbGhQf1O5MA1Uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JheiQ6OV; arc=none smtp.client-ip=74.125.224.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JheiQ6OV"
Received: by mail-yx2-f2.google.com with SMTP id 956f58d0204a3-67569b8cbf8so297237d50.1
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791190012; x=1791794812; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iy7K2MY429karblm1RWZnJsHtbbKuquWPEKzVkmQqvM=;
        b=JheiQ6OVgtgPkPFB+vRkcMxvChCYmt/DaVAeFSoNtrexh2uwZQur7xq5axSfgq5bmf
         faJ4reIO6EtPf6Fk4V49vgpidYodNja5m0BZFvLHj4QsQXSZg64vj6PZF4YAtPFD9eai
         gGzMiiRHifeC3/hb4CW2JOdqCV/VcQA0uFGJ89mIrxwQ6B3d426hEiuRM0mBFJVNFHgh
         TVnx2EtynYaVwROvcqG89zputH5Yk4WlgqTCmGkFN8vPN6oz8hMYmmXrs9OuSvjkBCNh
         kE+ZLdLtDfdnrFub3Z/c/vEzCdO9qDl+NLG20yFo5EhN97ahl2Lr4VCL7NY87wn2/T7Z
         ojZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791190012; x=1791794812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iy7K2MY429karblm1RWZnJsHtbbKuquWPEKzVkmQqvM=;
        b=M/Y4FicXZsYENq0E64OYfAb0GC3zZz5UloY38MDmSlSd1KG9LGUHAP0fIsOqPbWaMq
         aDYr6LXGBra4vQ46xgetxFrOJxp8svybckRhwzdlvvbBM2kDd7w6NyL0b2v5IzBGcAIi
         OpA1+Mdvx4848+S0Vi1JZA4CARy29NeJuwO3HSufSU/pHmnUBSeSOiw+YQB0tpPh6NcR
         NPnqMlNsaXge7/R7GG9yfWnpzUthpfIyu0cB+cuVuEO4BRdUbw7xbZaOGQKBiYSBqHMi
         xeqmdBNdP2XorcvKbHHlFtllWx2zzcNZyPeU+XWpeWKgaYmbrjExPFnFuyv9nuVrr9zM
         4q5Q==
X-Gm-Message-State: AFq9FYL7+8sL/ys10lB8MzTke4bdBnyyw8qF3Cc3A882mg9T7YgiZDLI
	b5xRwz9XRCEN5BxiCzMO3ygg4qclz0hesNxYTKe7R8BO8lH5dOmsM60=
X-Gm-Gg: AYBFou0BwptyzZkOYtvGDmBgns801Xhjjm1TXtFjjFnYTPJ8/cMGJg6vLjAfl975VMq
	CTIcdZtbb2q327yerQywH54wUuSeLftbUknX9N5rTSLYQuTSTrLpzeYi/sb+/IpAIsLO4mgfjP5
	S9QSXWcn6bnwZxLiz6ylmQSbhVk6yuyAA9HFUn0ur/9w4KcBczxdAdklLgrcL6ZH+HDlEWd3w44
	Nm1ckZDGh5kFXmZcN5t0rO82npTHCHQJ5oQqbtOo/03Vlt+j6MeFd6uHxXyVDsFMmuWJT9wbujl
	vsTZ3+ScWGSxs07fEOn4pe4xOwQTKLiSlgMPeQmNoBwZH7maMrZ4TSwicHaOgjsxbuKg+MCPXvE
	TmOWZlHcsrvUM3M3I9ihW4NyD/xelhBvFxpMtNohMyyvfYuyALTT8rOZfvafly2zjKIjolQqhIi
	L79F492zGrEzsKiXI3qztV380knCtjLs3VFnsNEqZ1lVw75c+nyw77z2owK0C3gfsWVNUS4N2Te
	zXgZ3qPdp5v2kGy+ecJt7rvbLjEHvbGrLyoC+CebQaX2ON0NM3rYiIbXXKwvxzjwnq6G85hChMi
	U+jpSj02ocT3nOxcNfxPLi4VqmTgyDvqyQ==
X-Received: by 2002:a05:690e:1309:b0:677:dae6:51b0 with SMTP id 956f58d0204a3-677dae663d0mr758067d50.18.1791190012138;
        Mon, 05 Oct 2026 01:46:52 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:1149:2fcd:c86b:8747])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b9c895sm2346306d50.13.2026.10.05.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:46:51 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 05 Oct 2026 01:46:45 -0700
Subject: [RFC PATCH v4 1/9] mm/damon/paddr: remove page_fault access check
 primitive
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-1-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

The page_fault access check primitive reports faults through
damon_report_page_fault() into the global, mutex-protected
damon_access_reports[] buffer.  A later patch in this series replaces that
buffer with per-context rings fed only by perf-event probes, which leaves
the page-fault producer with nowhere to report.  Remove the producer here
so no report is silently dropped.

Remove damon_pa_prepare_access_checks_faults() and its supporting
damon_pa_change_protection()/damon_pa_change_protection_one() helpers,
and the page_fault dispatch in damon_pa_prepare_access_checks().  Remove
damon_report_page_fault() and its sole caller, do_damon_page(), along
with the two page-fault-handler dispatch sites in mm/memory.c that
selected it over the ordinary NUMA-hinting fault path.

Writing Y to the sysfs page_fault file now returns -EOPNOTSUPP, and core
validation rejects a context with page_fault set, so a configuration
cannot select a primitive that no longer reports and have every region
read as cold.  With page_fault gone, page_table is the only access check
primitive left, so a context must enable it.  This leaves MM_CP_DAMON
with no user that sets it; its check in mm/mprotect.c is left for a
separate cleanup.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h   | 12 +----------
 mm/damon/core.c         | 24 +++------------------
 mm/damon/paddr.c        | 57 -------------------------------------------------
 mm/damon/sysfs-sample.c |  7 +++---
 mm/memory.c             | 53 ---------------------------------------------
 5 files changed, 8 insertions(+), 145 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3d0c05df3258..7940840b4da9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -930,7 +930,7 @@ struct damon_attrs {
  * struct damon_primitives_enabled - Enablement of access sampling primitives.
  *
  * @page_table:	Page table Accessed bits scanning.
- * @page_fault:	Page faults monitoring.
+ * @page_fault:	Page faults monitoring.  Not supported; must be false.
  *
  * Read &struct damon_sample_control for more details.
  */
@@ -1299,13 +1299,6 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 void damon_report_access(struct damon_access_report *report);
-#ifdef CONFIG_MMU
-void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
-#else
-static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
-{
-}
-#endif
 
 int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
@@ -1323,9 +1316,6 @@ unsigned long damon_alloced_bytes(void);
 static inline void damon_report_access(struct damon_access_report *report)
 {
 }
-static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
-{
-}
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ddf9c08aa6c1..3638e2054030 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2087,7 +2087,9 @@ static int damon_commit_sample_filters(struct damon_sample_control *dst,
 static bool damon_primitives_enabled_invalid(
 		struct damon_primitives_enabled *config)
 {
-	return config->page_table == config->page_fault;
+	if (config->page_fault)
+		return true;
+	return !config->page_table;
 }
 
 static int damon_commit_sample_control(
@@ -2544,26 +2546,6 @@ void damon_report_access(struct damon_access_report *report)
 	mutex_unlock(&damon_access_reports_lock);
 }
 
-#ifdef CONFIG_MMU
-void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
-{
-	struct damon_access_report access_report = {
-		.vaddr = vmf->address,
-		.size = 1,	/* todo: set appripriately */
-		.cpu = smp_processor_id(),
-		.tid = task_pid_vnr(current),
-		.is_write = vmf->flags & FAULT_FLAG_WRITE,
-	};
-
-	if (huge_pmd)
-		access_report.paddr = PFN_PHYS(pmd_pfn(vmf->orig_pmd));
-	else
-		access_report.paddr = PFN_PHYS(pte_pfn(vmf->orig_pte));
-
-	damon_report_access(&access_report);
-}
-#endif
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index f4fa7c231e55..65a5b3269d1d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -67,67 +67,10 @@ static void damon_pa_prepare_access_checks_abit(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_pa_change_protection_one(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *arg)
-{
-	/* todo: batch or remove tlb flushing */
-	struct mmu_gather tlb;
-
-	if (!vma_is_accessible(vma))
-		return true;
-
-	tlb_gather_mmu(&tlb, vma->vm_mm);
-
-	change_protection(&tlb, vma, addr, addr + PAGE_SIZE, MM_CP_DAMON);
-
-	tlb_finish_mmu(&tlb);
-	return true;
-}
-
-static void damon_pa_change_protection(unsigned long paddr)
-{
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
-	struct rmap_walk_control rwc = {
-		.rmap_one = damon_pa_change_protection_one,
-		.anon_lock = folio_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!folio)
-		return;
-	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
-		return;
-
-	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio))
-		return;
-
-	rmap_walk(folio, &rwc);
-
-	if (need_lock)
-		folio_unlock(folio);
-}
-
-static void damon_pa_prepare_access_checks_faults(struct damon_ctx *ctx)
-{
-	struct damon_target *t;
-	struct damon_region *r;
-
-	damon_for_each_target(t, ctx) {
-		damon_for_each_region(r, t) {
-			r->sampling_addr = damon_rand(ctx, r->ar.start,
-					r->ar.end);
-			damon_pa_change_protection(r->sampling_addr);
-		}
-	}
-}
-
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 {
 	if (ctx->sample_control.primitives_enabled.page_table)
 		damon_pa_prepare_access_checks_abit(ctx);
-	if (ctx->sample_control.primitives_enabled.page_fault)
-		damon_pa_prepare_access_checks_faults(ctx);
 }
 
 static bool damon_pa_young(phys_addr_t paddr)
diff --git a/mm/damon/sysfs-sample.c b/mm/damon/sysfs-sample.c
index ffc9c8545547..27f35cbb509f 100644
--- a/mm/damon/sysfs-sample.c
+++ b/mm/damon/sysfs-sample.c
@@ -421,7 +421,9 @@ static ssize_t page_fault_store(struct kobject *kobj,
 
 	if (err)
 		return err;
-	primitives->page_fault = enable;
+	if (enable)
+		return -EOPNOTSUPP;
+	primitives->page_fault = false;
 	return count;
 }
 
@@ -590,8 +592,7 @@ int damon_sysfs_set_sample_control(
 {
 	control->primitives_enabled.page_table =
 		sysfs_sample->primitives->page_table;
-	control->primitives_enabled.page_fault =
-		sysfs_sample->primitives->page_fault;
+	control->primitives_enabled.page_fault = false;
 
 	return damon_sysfs_set_sample_filters(control,
 			sysfs_sample->filters);
diff --git a/mm/memory.c b/mm/memory.c
index 41278e32dde6..44034d5b32ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6565,54 +6565,6 @@ static void fix_spurious_fault(struct vm_fault *vmf,
 	}
 }
 
-/*
- * NOTE: This is only poc purpose "hack" that will not be upstreamed as is.
- * More discussions between all stakeholders including maintainers of MM core,
- * NUMA balancing, and DAMON should be made to make this upstreamable.
- * (https://lore.kernel.org/20251128193947.80866-1-sj@kernel.org)
- *
- * This function is called from page fault handler, for page faults on
- * P{TE,MD}-protected but vma-accessible pages.  DAMON is making the fake
- * protection for access sampling purpose.  This function simply clear the
- * protection and report this access to DAMON, by calling
- * damon_report_page_fault().
- *
- * The protection clear code is copied from NUMA fault handling code for PTE.
- * Again, this is only poc purpose "hack" to show what information DAMON want
- * from page fault events, rather than an upstream-aimed version.
- */
-static vm_fault_t do_damon_page(struct vm_fault *vmf, bool huge_pmd)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio;
-	pte_t pte, old_pte;
-	bool writable = false, ignore_writable = false;
-	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
-
-	spin_lock(vmf->ptl);
-	old_pte = ptep_get(vmf->pte);
-	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
-	}
-	pte = pte_modify(old_pte, vma->vm_page_prot);
-	writable = pte_write(pte);
-	if (!writable && pte_write_upgrade &&
-			can_change_pte_writable(vma, vmf->address, pte))
-		writable = true;
-	folio = vm_normal_folio(vma, vmf->address, pte);
-	if (folio && folio_test_large(folio))
-		numa_rebuild_large_mapping(vmf, vma, folio, pte,
-				ignore_writable, pte_write_upgrade);
-	else
-		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
-				writable);
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
-
-	damon_report_page_fault(vmf, huge_pmd);
-	return 0;
-}
-
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -6686,8 +6638,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 */
 		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
 			return do_uffd_rwp(vmf);
-		if (sysctl_numa_balancing_mode == NUMA_BALANCING_DISABLED)
-			return do_damon_page(vmf, false);
 		return do_numa_page(vmf);
 	}
 
@@ -6806,9 +6756,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
 			if (userfaultfd_huge_pmd_rwp(vma, vmf.orig_pmd))
 				return do_huge_pmd_uffd_rwp(&vmf);
-			if (sysctl_numa_balancing_mode ==
-					NUMA_BALANCING_DISABLED)
-				return do_damon_page(&vmf, true);
 			return do_huge_pmd_numa_page(&vmf);
 		}
 

-- 
Git-157)

