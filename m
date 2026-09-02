Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9D4A35
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319025; cv=none; b=puWhdgDPHfYrsvvYdpp8XgASW0hACybK6XTeG+i2JIj4Ko7hYVOwEAZGrUzEiarQ49CBrQZyWxPW5axQh7tGMTDHDVFRQSgp8gBO58rpv9rbyOHJXHEf5QdMfD97bEFtwlIL5B8ygWNtw51N4XsT25kDcaMq6zJyJwL6CnuNiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319025; c=relaxed/simple;
	bh=9SX2b9a80TY14ABAJL6S91tKo6KqQ31H+7Zk1g3Gn8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PONIRscTEmph3Nhc2a8hRmEZlyVfetgDpneAlvnBipE7gRK625ZahIzexOE42+MPkFrmfa2ms2IpXV5gsgLejBcs5wv1cUQlplwXSvqM7vXHIzkDE8pEm4eMyFh8BBBbL5yLHNbSqt0wH9HhOSJHRkbtLG/wGsSm4qE6Cx7ZabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XOwgpbYF; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XOwgpbYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788319024; x=1819855024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1nCArtEkFHsetVE9HyV3SWkRXMjEedc6y2E/MROxKuc=;
  b=XOwgpbYFHdjsZbUeUJ46TBQMlJH/xh2RV8g2YQl83zLxwscSv6W1HZK9
   BaH6NiSebgcVSqJAIVP5p1rau3A8lhl2leav0amaALK0nBv4ZZdEQk5NS
   cOk123GL81DSCL6CmHUFEskOqnovqbPaIu0wRsDTx6dQnGNWwroVE4Edn
   jYCW11/X5sDSKMbYYDM8MU69Kndkf8G5fn66xSMaJ1OvJR02T/sFw4Cha
   5xWgE1EOBBF0snEIK5PtfadN9sLyV8W0iU2mcXqHJgQn7O/QkBCZm+Id8
   KLE6JT7zbKWED6/NSLNlTJFafv5OxKpju21tGVzwSjA2d1vCS/mVvgMgO
   w==;
X-CSE-ConnectionGUID: ddspb9w1RqWyZOaLdv6KsQ==
X-CSE-MsgGUID: K6gsVCLcS5izi2wOuZbiyA==
X-IronPort-AV: E=Sophos;i="6.25,257,1779148800"; 
   d="scan'208";a="27466435"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:17:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:12458]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.113:2525] with esmtp (Farcaster)
 id de3e0a65-3892-4861-a6e8-836a9a4f846d; Wed, 2 Sep 2026 03:17:03 +0000 (UTC)
X-Farcaster-Flow-ID: de3e0a65-3892-4861-a6e8-836a9a4f846d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 2 Sep 2026 03:17:03 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.39) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 2 Sep 2026 03:17:02 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <baolin.wang@linux.alibaba.com>,
	<david@kernel.org>, <ryan.roberts@arm.com>
Subject: [PATCH v4] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Tue, 1 Sep 2026 20:16:55 -0700
Message-ID: <20260902031655.84721-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

__damon_va_prepare_access_check() picks a random byte address within the
region and stores it in r->sampling_addr. damon_va_mkold() passes it into
a page table walk, which hands it to damon_ptep_mkold() as the address of
the page to sample:

  damon_va_mkold(mm, r->sampling_addr)
    damon_va_walk_page_range(mm, addr, addr + 1)
      damon_mkold_pmd_entry()
        damon_ptep_mkold(pte, vma, addr)
          ptep_test_and_clear_young(vma, addr, pte)
          mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)

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

Pass a page-aligned address to the ptep_test_and_clear_young() call in
damon_ptep_mkold(), which is the only place DAMON can reach
contpte_test_and_clear_young_ptes() from. Nothing else sees the aligned
address, and r->sampling_addr itself is left as is, so the sampling and
region bookkeeping semantics are unchanged.

Fixes: 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for large folios")
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
V3 -> V4:
- Align only the address that is passed to ptep_test_and_clear_young(),
  rather than @addr for the whole of damon_ptep_mkold(), so the
  mmu_notifier_clear_young() call keeps seeing the sampled address (SJ)

V2 -> V3:
- Move the alignment into damon_ptep_mkold(), instead of aligning in
  damon_va_mkold() and damon_va_young().  The ptep_test_and_clear_young()
  call in damon_ptep_mkold() is DAMON's only path to
  contpte_test_and_clear_young_ptes(), so damon_ptep_mkold() is the
  closest place in DAMON to the function that requires an aligned
  address (SJ)

V1 -> V2:
- Align inside damon_va_mkold() and damon_va_young() rather than aligning
  r->sampling_addr itself, so that sub-page sampling addresses remain
  possible for future non-PTE access check primitives (SJ)
- Point Fixes: at 6f0e1142173a instead of 3f49584b262c, since the
  unaligned address was harmless before that commit (SJ)
- Describe how the issue was noticed and what it does to the kernel (SJ)

v3: https://lore.kernel.org/all/20260901201001.33271-1-zcgao@amazon.com/
v2: https://lore.kernel.org/all/20260831221151.50561-1-zcgao@amazon.com/
v1: https://lore.kernel.org/all/20260827193821.46115-1-zcgao@amazon.com/

 mm/damon/ops-common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index fbda70d8ea4d..8fc61d06d358 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -61,7 +61,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	 * device aspects.
 	 */
 	if (likely(pte_present(pteval)))
-		young |= ptep_test_and_clear_young(vma, addr, pte);
+		/*
+		 * Arch implementation of ptep_test_and_clear_young() may
+		 * require aligned @addr
+		 */
+		young |= ptep_test_and_clear_young(vma, PAGE_ALIGN_DOWN(addr),
+				pte);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
 	if (young)
 		folio_set_young(folio);
-- 
2.50.1

