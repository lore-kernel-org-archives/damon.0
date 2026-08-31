Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732252F5498
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214323; cv=none; b=N8+nik1n20Bgtli/wkxeRpU6Ax3Zoz0nV7LeSLTM3zXkyFAZmypUPoGkfFGWNcDu6ZfVQ/HbUpx4JNDPf8JSOloM9/Ulzyyzh3EXACsBbEP7PSeJusbQhyeEWqzKSh9N550Bp9/vOXOr9ma68eNKsicOYVKVO90yWc8Sfxk6nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214323; c=relaxed/simple;
	bh=o5W9o5rNP5s499mXGQO9Hug5/lBDR1pGrnbCVJVCDo8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J2C0Nrsm+p09g1hcMx3Or2Wcqq9xn+ckQHQRg835eRX/J6B4PB8Pb1Olw2OjhxnE241BlIYUoB3Ia+cyVA9kBY54AMYo2LuHAvyZ1iqFccb1Vs1moF1HRjGB9Ax2D+Rafh9G54jcwSXDfVilwiyjiHA3RecZQHtaxiwjGaOBI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gukZoG37; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gukZoG37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788214322; x=1819750322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/X8kM8mFmh3GkThmAvG35lkCePNBjW1VUyypxdJ8g9A=;
  b=gukZoG37LGtJmMcXph4R1Go5rsHCA2+mkpoib0xTgzzemevHuYm7FJES
   ivGSTpsKELVegbH4fZaKO6Ud+TORee7/Z5H0uPQ99sJpabM/6wdsgVeGP
   aQYumX7f0KhzcpEiRn1wiUP2AzlGfguwKwyOOtjHBpqOEfchPjlvZKUVd
   gLVfYyYl2hsXCtcbIQR9gyhu5ED8bNKM0gYfYCbRmn6UHy8xMqi8dR+xw
   kNumh+eBCOPWG4r3OhWPzrGZL3qzrkMVEJ8V7TYeOJFsI7klX/ykJEGYL
   VLi9lh5y0vU6ZEftftRaWIroXGa0hRUMAedqgJxNWdxjBgrh7N+P79os1
   A==;
X-CSE-ConnectionGUID: mfHRJFKpS7GxXRUqgKEPDw==
X-CSE-MsgGUID: FyVwAOAWQJiu3Xorfce8cQ==
X-IronPort-AV: E=Sophos;i="6.25,254,1779148800"; 
   d="scan'208";a="27209376"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 22:11:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:13487]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.146:2525] with esmtp (Farcaster)
 id 6c0612df-8596-4553-97cd-ae226648a58c; Mon, 31 Aug 2026 22:11:58 +0000 (UTC)
X-Farcaster-Flow-ID: 6c0612df-8596-4553-97cd-ae226648a58c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 31 Aug 2026 22:11:58 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Mon, 31 Aug 2026 22:11:58 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <baolin.wang@linux.alibaba.com>,
	<david@kernel.org>, <ryan.roberts@arm.com>
Subject: [PATCH v2] mm/damon/vaddr: use a page-aligned address for the sampling walks
Date: Mon, 31 Aug 2026 15:11:51 -0700
Message-ID: <20260831221151.50561-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

__damon_va_prepare_access_check() picks a random byte address within the
region and stores it in r->sampling_addr. There are two users of
r->sampling_addr in vaddr.c that pass it into a page table walk, and
both use it as the address of a page.

  damon_va_mkold(mm, r->sampling_addr)
    damon_va_walk_page_range(mm, addr, addr + 1)
      damon_mkold_pmd_entry()
        damon_ptep_mkold(pte, vma, addr)
          ptep_test_and_clear_young(vma, addr, pte)
          mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)

  damon_va_young(mm, r->sampling_addr, &folio_sz)
    damon_va_walk_page_range(mm, addr, addr + 1)
      damon_young_pmd_entry()
        ptep_get(pte)
        mmu_notifier_test_young(walk->mm, addr)

For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
clearing of the young flag for large folios"), the contpte helper walked
exactly CONT_PTES entries from the aligned-down page table pointer and
used @addr only to pass down to each entry, so an unaligned value was
harmless:

        ptep = contpte_align_down(ptep);
        addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
        for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)

Now the range to walk is derived from @addr instead: end = addr +
nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
page of a contpte block, the sub-page offset puts end just past the
block boundary, so the round-up lands a whole block further and the
walk clears PTE_AF in CONT_PTES entries beyond the sampled block. For
the last block in a page table page, those entries are past the end of
that page, so the walk writes into the page that follows.

Triggered by the full 7.1/7.2 kernel selftest suite on arm64 (EC2
c/m6g.4xlarge). The kernel sometimes crashes at or shortly after the
DAMON test.

What the overrun does depends on the page that happens to follow the
page table, so there is no single signature. If that page is read-only,
the write faults in the sampling path itself:

  Unable to handle kernel write to read-only memory at virtual address ffff0003c5d2d000
    FSC = 0x0f: level 3 permission fault
    CM = 0, WnR = 1, TnD = 0, TagAccess = 0
  CPU: 10 UID: 0 PID: 3487 Comm: kdamond.2
  pc : contpte_test_and_clear_young_ptes+0x70/0xc0
  lr : damon_ptep_mkold+0x1e8/0x1f8
  Call trace:
   contpte_test_and_clear_young_ptes+0x70/0xc0 (P)
   damon_mkold_pmd_entry+0x150/0x170
   walk_pmd_range+0x110/0x2b0
   walk_pud_range+0x10c/0x208
   walk_pgd_range+0x134/0x258
   __walk_page_range+0x98/0x1b0
   walk_page_range_vma_unsafe+0x90/0x148
   walk_page_range_vma+0x28/0x40
   damon_va_walk_page_range+0x114/0x2b8
   damon_va_prepare_access_checks+0xec/0x1a8
   kdamond_fn+0x534/0x770
   kthread+0x128/0x138
   ret_from_fork+0x10/0x20

Otherwise the page is writable, the PTE_AF clearing succeeds silently
and the damage only surfaces later, in whatever happened to own the
page, so the backtrace is unrelated to DAMON and differs between runs.

Align the address down to a page boundary in damon_va_mkold() and
damon_va_young(), the two users that pass it into a page table walk. It
is the address of the page to sample, so this matches its intended
meaning. r->sampling_addr itself is left as is, so the sampling and
region bookkeeping semantics are unchanged.

Fixes: 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for large folios")
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
V1 -> V2:
- Align inside damon_va_mkold() and damon_va_young(), the two users that
  pass the address into a page table walk, rather than aligning
  r->sampling_addr itself, so that sub-page sampling addresses remain
  possible for future non-PTE access check primitives (SJ)
- Point Fixes: at 6f0e1142173a instead of 3f49584b262c, since the
  unaligned address was harmless before that commit (SJ)
- Describe how the issue was noticed and what it does to the kernel (SJ)
- Reword the subject to match the narrower change

v1: https://lore.kernel.org/all/20260827193821.46115-1-zcgao@amazon.com/

 mm/damon/vaddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2c1c1952c008d..e7aa18200088f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -349,6 +349,9 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
 		.hugetlb_entry = damon_mkold_hugetlb_entry,
 	};
 
+	/* Arch helpers can derive a page range from @addr; align it down. */
+	addr = PAGE_ALIGN_DOWN(addr);
+
 	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
 }
 
@@ -482,6 +485,9 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 		.hugetlb_entry = damon_young_hugetlb_entry,
 	};
 
+	/* Arch helpers can derive a page range from @addr; align it down. */
+	addr = PAGE_ALIGN_DOWN(addr);
+
 	damon_va_walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
 	return arg.young;
 }
-- 
2.50.1

