Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380F3242BA
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317827; cv=none; b=qdUjlnMcK7IqU9y+0oxSusg+VYMPPSNiGejd+wBbum/zsT4yNuIG+rsvDVf+7skgS0j4Eschzd3uZZQ9lSVMPB1h+LFQgLLb5DmEjroTNHVu44dLNC/vsgCwD/XwiY5VxIqp5AobgF2aldtLa/yXgt+w+bh9PVtpJlBSHr2zpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317827; c=relaxed/simple;
	bh=4fjEPD+lrgKFPwhNPaNEjHit28uMZCyLw1Vle+YjuOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZeFKh4RlCUYITZ8aL0ECziP3JZ4T3F0bVT36lS8L2SwXMYbzrMZWrLkfCuklFfV5GP1iHwiHSB1rYtfpvlnrJqivT+xhapf4xK2J2UD4Fg/JPB+rLaUfze00qQ/TWXZfeqStYs9pseVK3zRi5qJESAFOl7Dwlsn7OT/HDR5oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=ObkJXzcA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="ObkJXzcA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6e954afbdso3095435ad.2
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788317825; x=1788922625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AfIUElBfsBuc32fcVrUuC+qxuGAKqGDmpiNow6bdW8=;
        b=ObkJXzcAhTOD6zJZ+Mufi+LQjSlV/GGy2OTM3p4zmhM10DPwq0toYe290olzl9CJmq
         SQIZNlmnFUx6qMBwEGlwv70s7J7OBOxtEOiLPIRnf1N4RoSjjIkwmDcG0LD9BaQlWXdx
         eOhtV7Q4nh4TFB4o3jxt6bQU1vhwCl0NL/FndQQh2Y/+298OkwIDGB9Y0BOlov2Cxu6s
         KD4EfxykUz8Fv7D0fsEURCBkNv/SObUY+aUIpOw2aYyABfJiOzS1fzYGt4in3INUPZp6
         1ectDsFC+xt8pu5IBd19+MxTPFPP6dFgQX8R0eGnyo2I+ktsZY+sfW6vb0pVRIihOkAB
         xWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317825; x=1788922625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AfIUElBfsBuc32fcVrUuC+qxuGAKqGDmpiNow6bdW8=;
        b=f7lAT1bjFI/oqX50Aj1M2+AAhFGlLy2kfYEe6yKtJT5irzcN+Fs5vzNUPL/RQeXnM+
         qW6vwbPw9+aIOEKihD3BZkltOk+FTStwGmjuvZJ5ulWN15HQ/Pe57KFwzBmEOmpB3H+7
         BtxRQ/l8BqxrHC6EcxHGDTmN4Ea2aUj91tM8hfMN2QfEeLlRU1kwkvVa4nyA87vyB+0j
         Q9kUFR6czgXltlyFRqPqM6cWelvyCRtR5VVC6ZHtoLH3Lzq0QSfTSjOd1UTjqrKJyeVk
         X7cN3L6z1lzMiQpVBlDN/ha0q294wP8BIC0gStR4bWc6YwtTx136Se4XG5FcsC7f1MO5
         XFYg==
X-Forwarded-Encrypted: i=1; AKwUvByg6tXrGGPJXkjgRcwHz68bgNC5/Q1VacBlV1DcxR2Ueh3RuXOfSxdGsYD+Gcw8N3b9cTpLqQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ngHCcVFHOI4upGBXcLLT7KwntX2XGt5kN4UXdS/InBsYkJngqF
	1/NdS7seHTtpWaJAOgzRn/zwH9mFrgbhqWV0nfzEMhvwWo03tJ40v5ZcbnQRr4o5zK8=
X-Gm-Gg: AYBFou3+q2RBx36/VNI5pvI7O6njpAwJLwVEotb8ZUWdo3hRNtNoc5/yIYJ/Isuki6W
	nBSfmIIGlvWFtPuTVy0ijfOTcIaIoZlulNq99blQ+pvZzJIAgP1x6pV588MytmOuxPFsfjWrR6P
	dV9YwuUC1scDLbQPvz82b+Id/5IlQLL4p2xccm/a1NC3Iva9L7XRk/O/cdXTygDdy51VjhhZuIo
	V6zh8DI8cZj6PebZNQa8URqVr2RN07fhvfNq2bIV2u80xJYNGBP54lYSyN+M0gbLKelYhtPHyIP
	WP8HPHR7iw88/cvbxNoA+z8UZzDqiNQkFLZbsP3HegmYeWJboS+mSOPWDyKXnftZ+0zm4srmb1B
	CZAK6Mv+OeegoWsXCLeD6BsE0z9r+ETsX8QKYyN2T9E5eOou9jL8Q3lV2hBD2/busnsJRHRt98R
	zCfFcY/PelfEpRGpVGB1Hx1mDPgRmo14ACDpV4u3HyEa7aahcTno9xqv193mp9dlQSki8m2hpSn
	/Hoi9Vumo0UAAR4IRXq0xeg2A70CFVIDf0L
X-Received: by 2002:a17:902:d491:b0:2d9:3636:d01a with SMTP id d9443c01a7336-2daec74e5e3mr22490315ad.15.1788317825337;
        Tue, 01 Sep 2026 19:57:05 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:a1c2:77c:7ab7:f9a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07bde5bfsm2066469eec.27.2026.09.01.19.57.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 19:57:05 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Tue,  1 Sep 2026 19:56:59 -0700
Message-ID: <20260902025700.17975-3-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902025700.17975-1-kiyer@crusoe.ai>
References: <20260902025700.17975-1-kiyer@crusoe.ai>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_folio_mkold_one() and damon_folio_young_one() assume the folios
they walk are mapped by normal PTEs or THP PMDs.  When the folio is a
hugetlb folio, page_vma_mapped_walk() returns the huge PTE in pvmw.pte
with its page table lock held, but the walkers treat it as a normal
PTE: they read and age it with PAGE_SIZE-granularity helpers, which is
wrong for huge PTEs (up to PUD level), and notify secondary MMUs for
only PAGE_SIZE of the mapping.

Add hugetlb branches to both walkers.  The mkold walker reuses
damon_hugetlb_mkold(), which the virtual address space operations set
has been using for hugetlb aging: it clears the young bit of the huge
PTE via set_huge_pte_at() and calls mmu_notifier_clear_young() spanning
the whole huge page size.  The young walker gets an equivalent new
helper, damon_hugetlb_young(), which reads the huge PTE with
huge_ptep_get() and consults the page idle flag and
mmu_notifier_test_young() like the existing PTE branch.

Locking mirrors what page_vma_mapped_walk() provides: the huge PTE's
page table lock is held inside the walk, and for shared hugetlb
mappings (the only ones subject to huge PMD sharing), rmap_walk_file()
already holds i_mmap_rwsem, satisfying hugetlb_walk()'s locking
requirements.

This is currently dead code: both rmap walkers are only reachable
through damon_get_folio(), which rejects hugetlb folios since they are
not on the LRU lists.  A following commit will let the physical address
space monitoring primitives opt in to hugetlb folios.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/ops-common.c | 61 +++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index f5fe92b825bb..373b25db5950 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -193,10 +193,15 @@ static bool damon_folio_mkold_one(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
-		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma, addr);
-		else
+		if (pvmw.pte) {
+			if (folio_test_hugetlb(folio))
+				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
+						addr);
+			else
+				damon_ptep_mkold(pvmw.pte, vma, addr);
+		} else {
 			damon_pmdp_mkold(pvmw.pmd, vma, addr);
+		}
 	}
 	return true;
 }
@@ -221,27 +226,55 @@ void damon_folio_mkold(struct folio *folio)
 
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
+		unsigned long addr, struct folio *folio)
+{
+	pte_t entry = huge_ptep_get(vma->vm_mm, addr, pte);
+
+	return (pte_present(entry) && pte_young(entry)) ||
+		!folio_test_idle(folio) ||
+		mmu_notifier_test_young(vma->vm_mm, addr);
+}
+#else
+static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
+		unsigned long addr, struct folio *folio)
+{
+	return false;
+}
+#endif	/* CONFIG_HUGETLB_PAGE */
+
+static bool damon_pte_young(pte_t *pte, struct vm_area_struct *vma,
+		unsigned long addr, struct folio *folio)
+{
+	pte_t entry = ptep_get(pte);
+
+	/*
+	 * PFN swap PTEs, such as device-exclusive ones, that actually map
+	 * pages are "old" from a CPU perspective. The MMU notifier takes care
+	 * of any device aspects.
+	 */
+	return (pte_present(entry) && pte_young(entry)) ||
+		!folio_test_idle(folio) ||
+		mmu_notifier_test_young(vma->vm_mm, addr);
+}
+
 static bool damon_folio_young_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	bool *accessed = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
-	pte_t pte;
 
 	*accessed = false;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			pte = ptep_get(pvmw.pte);
-
-			/*
-			 * PFN swap PTEs, such as device-exclusive ones, that
-			 * actually map pages are "old" from a CPU perspective.
-			 * The MMU notifier takes care of any device aspects.
-			 */
-			*accessed = (pte_present(pte) && pte_young(pte)) ||
-				!folio_test_idle(folio) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
+			if (folio_test_hugetlb(folio))
+				*accessed = damon_hugetlb_young(pvmw.pte, vma,
+						addr, folio);
+			else
+				*accessed = damon_pte_young(pvmw.pte, vma,
+						addr, folio);
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			pmd_t pmd = pmdp_get(pvmw.pmd);
-- 
2.54.0

