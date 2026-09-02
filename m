Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD633A9E1;
	Wed,  2 Sep 2026 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312553; cv=none; b=tDCp7QtMZJTI1OtyDw9MhDeNl5A5kzI4mSpxwU9iFVnerZdGTTtxI99Rh7TWF8+FauIpdXjP0EoXIIwxLLvoX9SjLeBHsFrArj7jgDWpeDfCvQMBtqrOxQNomAE5YxqwlDWozu8/sT65qD7N5LromqcvFIsfVo7qcaB+OJy3ZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312553; c=relaxed/simple;
	bh=FULkgokxcrZqFKGtayLo0lj/GR9r3KH+VAfT3s0r4KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/fQJRqU3Rn0X6E+7gKYzG1Nw3ACJPOt0CtM+Eot3URVgGyV+tLO2SUMQFeIW/KTIN1Vk27pNl+Co+MJJWhD1ylweCm6QXSNYbZtN7tO6fYhRdjhsl3VNwTt3fuCA1He03fX4mgLmnNP6Gqq6XNWmzCV7gE5jm2W8jsNB249vZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asjJlZHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asjJlZHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFEE1F000E9;
	Wed,  2 Sep 2026 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312550;
	bh=81zL3FtVn4KjY0IqffHkZV0IqVRMntkJGqm5iDMz/Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asjJlZHUX9ccv1pGJeMThdQowe7FdXlWqgFsxjO2yXmOeTYhJZUXgYckI1gOxYhLG
	 dh6Y6eeSL4FFZf0VVnvjQPHIJUQbEbMLxDjd4p9X5ba5CHoUpzlmF9CcSwDEPYP0kp
	 LqccIyq9c5EbCSHa1llVXnn+ngb7+Pv15yXr0LY7kCFSBa1+ZeXeiW4BRS3Z739KGZ
	 w9XRdBj2VdtaZ77LalcgQH1PpdWOEMocAlVmqLuxbZbDKhwDLiMgERREs0PGYegeJb
	 R4JKb/GHyjJTdCDRPn7S84PjdVMNyKqlig0iGtIEC3urBi2IA97eEwha2iU028Z+Ak
	 1czjZQ7fXLzvA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Nathan Gao <zcgao@amazon.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v3] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Tue,  1 Sep 2026 18:28:57 -0700
Message-ID: <20260902012858.110515-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902001142.107226-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:11:41 -0700 SJ Park <sj@kernel.org> wrote:

> On Tue, 1 Sep 2026 13:10:01 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> 
> > __damon_va_prepare_access_check() picks a random byte address within the
> > region and stores it in r->sampling_addr. damon_va_mkold() passes it into
> > a page table walk, which hands it to damon_ptep_mkold() as the address of
> > the page to sample:
> > 
> >   damon_va_mkold(mm, r->sampling_addr)
> >     damon_va_walk_page_range(mm, addr, addr + 1)
> >       damon_mkold_pmd_entry()
> >         damon_ptep_mkold(pte, vma, addr)
> >           ptep_test_and_clear_young(vma, addr, pte)
> >           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> > 
> > For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> > clearing of the young flag for large folios"), the contpte helper walked
> > exactly CONT_PTES entries from the aligned-down page table pointer and
> > used @addr only to pass down to each entry, so an unaligned value was
> > harmless:
> > 
> >         ptep = contpte_align_down(ptep);
> >         addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> >         for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> > 
> > Now the range to walk is derived from @addr instead: end = addr +
> > nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
> > page of a contpte block, the sub-page offset puts end just past the
> > block boundary, so the round-up lands a whole block further and the
> > walk clears PTE_AF in CONT_PTES entries beyond the sampled block. For
> > the last block in a page table page, those entries are past the end of
> > that page, so the walk writes into the page that follows.
> 
> I just wanted to call out again that I'm wondering if we could restore the
> unaligned address support in the helper.  E.g., as a very dirty hack that I can
> imagine off the top of my head,
> 
> '''
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -30,6 +30,7 @@ static inline pte_t *contpte_align_addr_ptep(unsigned long *start,
>                                              unsigned long *end, pte_t *ptep,
>                                              unsigned int nr)
>  {
> +       *start = PAGE_ALIGN_DOWN(*start);
>         /*
>          * Note: caller must ensure these nr PTEs are consecutive (present)
>          * PTEs that map consecutive pages of the same large folio within a
> '''

Urgh, I mean, '*end = PAGE_ALIGN_DOWN(*end);'

> 
> I and Nathan have no strong clue, so we are looking for Baolin and others'
> opinion.
> 
> While waiting for the opinions, I and Nathan agree we should stop bleeding with
> a pinpoint hotfix change in DAMON.
> 
> > 
> > Triggered by the full 7.1/7.2 kernel selftest suite on arm64 (EC2
> > c/m6g.4xlarge). The kernel sometimes crashes at or shortly after the
> > DAMON test.
> > 
> > What the overrun does depends on the page that happens to follow the
> > page table, so there is no single signature. If that page is read-only,
> > the write faults in the sampling path itself:
> > 
> >   Unable to handle kernel write to read-only memory at virtual address ffff0003c5d2d000
> >     FSC = 0x0f: level 3 permission fault
> >     CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> >   CPU: 10 UID: 0 PID: 3487 Comm: kdamond.2
> >   pc : contpte_test_and_clear_young_ptes+0x70/0xc0
> >   lr : damon_ptep_mkold+0x1e8/0x1f8
> >   Call trace:
> >    contpte_test_and_clear_young_ptes+0x70/0xc0 (P)
> >    damon_mkold_pmd_entry+0x150/0x170
> >    walk_pmd_range+0x110/0x2b0
> >    walk_pud_range+0x10c/0x208
> >    walk_pgd_range+0x134/0x258
> >    __walk_page_range+0x98/0x1b0
> >    walk_page_range_vma_unsafe+0x90/0x148
> >    walk_page_range_vma+0x28/0x40
> >    damon_va_walk_page_range+0x114/0x2b8
> >    damon_va_prepare_access_checks+0xec/0x1a8
> >    kdamond_fn+0x534/0x770
> >    kthread+0x128/0x138
> >    ret_from_fork+0x10/0x20
> > 
> > Otherwise the page is writable, the PTE_AF clearing succeeds silently
> > and the damage only surfaces later, in whatever happened to own the
> > page, so the backtrace is unrelated to DAMON and differs between runs.
> > 
> > Align the address down to a page boundary in damon_ptep_mkold(). Its
> > ptep_test_and_clear_young() call is the only place DAMON can reach
> > contpte_test_and_clear_young_ptes() from. r->sampling_addr itself is left
> > as is, so the sampling and region bookkeeping semantics are unchanged.
> > 
> > Fixes: 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for large folios")
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: David Hildenbrand (Arm) <david@kernel.org>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nathan Gao <zcgao@amazon.com>
> > ---
> > V2 -> V3:
> > - Move the alignment into damon_ptep_mkold(), instead of aligning in
> >   damon_va_mkold() and damon_va_young().  The ptep_test_and_clear_young()
> >   call in damon_ptep_mkold() is DAMON's only path to
> >   contpte_test_and_clear_young_ptes(), so damon_ptep_mkold() is the
> >   closest place in DAMON to the function that requires an aligned
> >   address (SJ)
> 
> Thank you for doing this revision for my humble request!
> 
> > 
> > V1 -> V2:
> > - Align inside damon_va_mkold() and damon_va_young() rather than aligning
> >   r->sampling_addr itself, so that sub-page sampling addresses remain
> >   possible for future non-PTE access check primitives (SJ)
> > - Point Fixes: at 6f0e1142173a instead of 3f49584b262c, since the
> >   unaligned address was harmless before that commit (SJ)
> > - Describe how the issue was noticed and what it does to the kernel (SJ)
> > 
> > v2: https://lore.kernel.org/all/20260831221151.50561-1-zcgao@amazon.com/
> > v1: https://lore.kernel.org/all/20260827193821.46115-1-zcgao@amazon.com/
> > 
> >  mm/damon/ops-common.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 0bcad6b1e5b9e..cd8aa08233e54 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -46,6 +46,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
> >  	bool young = false;
> >  	unsigned long pfn;
> >  
> > +	/*
> > +	 * Arch implementation of ptep_test_and_clear_young() may require
> > +	 * aligned @addr
> > +	 */
> > +	addr = PAGE_ALIGN_DOWN(addr);
> > +
> >  	if (likely(pte_present(pteval)))
> >  		pfn = pte_pfn(pteval);
> >  	else
> 
> I agree this should fix the issue.
> 
> Maybe I'm being too picky, but...  'addr' is also being used in later
> mmu_notifier_clear_young() call.  Could we further scope down to do the
> alignment only for the function that disallows unaligned address?  For example,
> 
> '''
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -61,7 +61,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>          * device aspects.
>          */
>         if (likely(pte_present(pteval)))
> -               young |= ptep_test_and_clear_young(vma, addr, pte);
> +               /*
> +                * Arch implementation of ptep_test_and_clear_young() may
> +                * require aligned @addr
> +                */
> +               young |= ptep_test_and_clear_young(vma, PAGE_ALIGN_DOWN(addr),
> +                               pte);
>         young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
>         if (young)
>                 folio_set_young(folio);
> '''
> 
> 
> > -- 
> > 2.50.1
> 
> 
> Thanks,
> SJ


Thanks,
SJ
