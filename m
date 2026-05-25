Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AB388E76
	for <damon@lists.linux.dev>; Mon, 25 May 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720605; cv=none; b=RC4JMkvc9A7qZWnI1feQDs/jvZWrGK27jFXzcQ83L7mcCgZyuegdrZT4LyVmgd94sImosxqUlEV47tjJi/h2YSuoiaRQ6oLaXpuUe5Mr4VKwwnFui3XdTGbh5tfeyh96r6IevM/1GFrrSVBuOUV4jxkEwBUjlFxLZZBXQln4xVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720605; c=relaxed/simple;
	bh=hm3f4xSSUmzMgNgd6H1qlbv1OHhh2gq/Kq+14gGzwwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gs5GmnHMEhheMvNhPJVNEPtuP8VgwwIJsr0CP4+mp+NT3C29RvkYGHyGkotCdGZKh8+RNvu/crjGe8avDSHUQS6dNoxRE0RCkWRQ+pZ9+QFVgFtP7mAlwNR0AvJV1aP7IqNU/8Tm6Yz6XQzcMwFznPBTxCX0cUKwwgSLvPVFtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oo+AYvPq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oo+AYvPq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779720600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ucSIcO4wSAFyi9/y+041p6DDmf5uXKO9TV+iwW1k9vA=;
	b=Oo+AYvPqrAIfQRtBUGJfd+uwofEoQLg3o5NYKUA9HU5F3C11+79MpXYtD09oGCda9IXWie
	Nk1ier+Va67B/2ajvHBSf6VzwAZMaMOeD2xbS9N8Qe2muSc83QHoqk3eBD/l48MmDCnWBD
	fpXbWl/Gg6JYe0b1dSMb8eYMff8GQcw=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
Date: Mon, 25 May 2026 22:48:46 +0800
Message-ID: <20260525144846.604907-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

damon_ptep_mkold() clears the PTE Access Flag so that a later
access will set it again and damon_folio_young() can observe it
via pte_young().

On arm64, however, ptep_test_and_clear_young() clears AF in the
page tables without invalidating the corresponding TLB entry.
Subsequent accesses can therefore continue hitting a stale TLB
entry without a page table walk.  The PTE AF bit stays clear,
pte_young() reports false, and DAMON treats the region as
unaccessed.

folio_set_idle() does not help here.  It updates only software
state, and accesses through a stale TLB entry do not clear the
idle flag.

As a result, nr_accesses stays low regardless of the real access
pattern.  DAMOS schemes fail to match, WSS estimation reports
zero, and actions like pageout never trigger.

Fix this by switching to ptep_clear_flush_young() and
pmdp_clear_flush_young().

On arm64 these perform the required TLB invalidation after
clearing AF.  The invalidation is deferred, but still sufficient
for DAMON's sampling granularity.

On x86, ptep_clear_flush_young() is equivalent to
ptep_test_and_clear_young() for base pages, so there is no
behavioral change.  pmdp_clear_flush_young() additionally performs
a flush at PMD level, matching the existing x86 implementation.

On powerpc, riscv, and s390, the clear_flush variants currently
map back to test_and_clear implementations, so this patch does not
change their behavior.

Reproduced on arm64 (128 CPUs, 7.1.0-rc4):

  before:
    WSS estimation: 50th percentile error 100% (reported as zero)
    apply_interval: schemes never tried

  after:
    WSS estimation: 50th percentile error 0.08%
    apply_interval: passes

Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Tested-by: Kunwu Chan <chentao@kylinos.cn>
---
 mm/damon/ops-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8c6d61342..33d689c14 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -63,7 +63,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	 * device aspects.
 	 */
 	if (likely(pte_present(pteval)))
-		young |= ptep_test_and_clear_young(vma, addr, pte);
+		young |= ptep_clear_flush_young(vma, addr, pte);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
 	if (young)
 		folio_set_young(folio);
@@ -90,7 +90,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 		return;
 
 	if (likely(pmd_present(pmdval)))
-		young |= pmdp_test_and_clear_young(vma, addr, pmd);
+		young |= pmdp_clear_flush_young(vma, addr, pmd);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE);
 	if (young)
 		folio_set_young(folio);
-- 
2.43.0

