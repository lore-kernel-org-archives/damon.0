Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F073BB69D
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788106423; cv=none; b=ilfnVxddbAgbEJrbib7PtxXcJgsoWVuu7hrHRN0dyeLQwNCpEzN9waAcDTIVyxcsu2hAz/JPk6dnRMn7PQZujsybM2u+ARinGT0O+oOs0QogFh7PKg3SzNqBuCCmG4Ox2xVimM4RBLP1k+wFfjUmHwJPHp1U4KrFVbTPGF+lchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788106423; c=relaxed/simple;
	bh=6N7rhQU5ddPN+8Z4sexJfHmAiq2ssaW2VHrs56NmqFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpnhLWRnfAELi4mWIhr4JaxM/uaj6RbCGu+ZG61LPKnoRqJILAcXBmmNi08JnPc75uNMZ/xTu8vDt8ZEAfY1SoUs4BEWSK1IJohrjMCLmcmYcjmI+eKfZxzVKsEDfultJjTIVXLMCd/ZtvfOqks1/+ChkTyDj3+bjotA4rZxsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxvaYTyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxvaYTyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE31F000E9;
	Sun, 30 Aug 2026 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788106413;
	bh=Iz5dz+UOBCNy+RpK0Ob/nFbicFnFJaDdhcKfdywlRb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxvaYTybzlvyGNEqA8mFhAfdxMXfeazjRgO69f22GmQgTr1qUUqWtbxFf5ZN1RWgg
	 veQDiqpxDXYV9jEeZ0qhqRAb87RWFjXHD8snk/cvrNacq05ssDISQv50mLIKlrPxY9
	 bSwEEZc000x7J326bMV4eoTh2/+Mb25pVCuJM31OsEw2iyzoc0AtcApCW0TSr0ISJm
	 RYqTz+BmDTdWjqCH2MkahLCm5diGHJuS4P3LnQP4qmc+5G/I5mnE7jMB57+bSD4JPa
	 iTJQ0LDqj9kZ1xOOO5cjiBy68dZqcddz54ZcjtUgRI8CRqN7W0d7KfJPpBA82BPWFG
	 gE4OE0tpX21Qg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/6] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Sun, 30 Aug 2026 09:13:25 -0700
Message-ID: <20260830161325.99195-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830052855.93DE21F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 05:28:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] mmu_notifier_test_young() evaluates only a single base page, masking accesses within shattered huge pages.
> 
> Pre-existing issues:
> - [High] Non-atomic read-modify-write of huge PTE in damon_hugetlb_mkold() silently drops hardware-managed dirty bits.
> --
> 
> commit 69bb3f48e79ddddcf3eaf4001d7704e62df0da69
> Author: Krishna Iyer <kiyer@crusoe.ai>
> 
> mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
> 
> This commit introduces hugetlb branches to DAMON's rmap walkers by reusing
> damon_hugetlb_mkold() for clearing the young bit and introducing
> damon_hugetlb_young() for checking it. It ensures huge PTEs are read and
> aged correctly rather than using base page granularity helpers.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index f5fe92b825bbc..62004206ca310 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -193,10 +193,20 @@ static bool damon_folio_mkold_one(struct folio *folio,
> >  
> >  	while (page_vma_mapped_walk(&pvmw)) {
> >  		addr = pvmw.address;
> > -		if (pvmw.pte)
> > -			damon_ptep_mkold(pvmw.pte, vma, addr);
> > -		else
> > +		if (pvmw.pte) {
> > +			/*
> > +			 * For hugetlb folios, page_vma_mapped_walk() sets
> > +			 * pvmw.pte to the huge PTE with its page table lock
> > +			 * held.
> > +			 */
> > +			if (folio_test_hugetlb(folio))
> > +				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
> > +						addr);
> 
> [Severity: High]
> This is a pre-existing issue, but does damon_hugetlb_mkold() perform a
> non-atomic read-modify-write that could silently drop hardware-managed
> dirty bits?
> 
> Looking at damon_hugetlb_mkold(), the code reads the PTE, clears the young
> bit, and writes it back:
> 
> 	pte_t entry = huge_ptep_get(mm, addr, pte);
> ...
> 	if (pte_young(entry)) {
> 		referenced = true;
> 		entry = pte_mkold(entry);
> 		set_huge_pte_at(mm, addr, pte, entry, psize);
> 	}
> 
> If a hardware write access occurs and sets the hardware A/D bit after
> huge_ptep_get() but before set_huge_pte_at(), won't the dirty bit be
> overwritten with the stale, clean value?
> 
> This could potentially lead to data loss if hugetlb pages are reclaimed
> or migrated without writeback. Hooking this up for DAMON folio monitoring
> means this path can be triggered frequently in the background.

I'm planning to fix this.

> 
> > +			else
> > +				damon_ptep_mkold(pvmw.pte, vma, addr);
> > +		} else {
> >  			damon_pmdp_mkold(pvmw.pmd, vma, addr);
> > +		}
> >  	}
> 
> [ ... ]
> 
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
> > +		unsigned long addr, struct folio *folio)
> > +{
> > +	pte_t entry = huge_ptep_get(vma->vm_mm, addr, pte);
> > +
> > +	return (pte_present(entry) && pte_young(entry)) ||
> > +		!folio_test_idle(folio) ||
> > +		mmu_notifier_test_young(vma->vm_mm, addr);
> 
> [Severity: Medium]
> Will mmu_notifier_test_young() miss accesses within shattered huge pages here?
> 
> Since the kernel's mmu_notifier_test_young() API does not take a size
> parameter, passing only the base address of the huge page means it will
> only evaluate the first base page.
> 
> For secondary MMUs like KVM EPT that map huge pages as multiple smaller
> pages, wouldn't accesses to other subpages within the huge page be completely
> missed? This could cause DAMON to classify the huge page as colder than it
> actually is, which might lead to inappropriate reclaim or migration decisions.

This is also a pre-existing issue.  I will work on fixing this.


Thanks,
SJ

[...]
