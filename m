Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2022C3266
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319379; cv=none; b=dxmnOvYjBKdQ2sTr4v1Ki9Z4lWL6yfY1oML4KBgpKCYuBYpqxM7EK5572iqgkpyGUfrzfD/TFUAmWLNe17LFmuFBhN29r2OYoKgQbfub/3I6JTMDDdkM6lAbeT5fBOCX1pym/qUTT5FnomAlT0ZcnpHz+2GAoDNtkplrf+WSqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319379; c=relaxed/simple;
	bh=7o03Lrf1+YHaZBbxYDq6jalH1JH4t1UNWRp59bjnA60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guZhoFdUX5fi15DW9LBZcijVh9hr/HDJQOdRyFmrLWlf8pfoGHZAApWygRHMkqNuqEmUZjxCLJpmswfRrUlBl65TGpoaNTuMnQTKslID+QbWROiK4Qyv92AORP9XQsYVG72mZMaRkroFRRNhG1gu9Puxh7nYThI7vutSKi6KjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=D22Pp4v9; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="D22Pp4v9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788319377; x=1819855377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDa24XfUwuNC5CheixKhacETQZ+iF+EhwNqflwAH/xY=;
  b=D22Pp4v9E7TfiPcVUgTTtfbtRpLITXJjsL05UqlWeMQC0YQ2FcG1EEhW
   vwEjM0ZRmbsjkSpyT81wgRRAFaUK1OgYm2TO+EXjPFtBq0FbEBxs3wnGa
   ayCcp+qVDD5iFCr+bm5qlxy4c7xuQcxZuf1EPCXK0F9s7Y+A2iaQPodfd
   D3BC0xtJUy3cai8c4NayhzCqQJ58ulGQ9hJ+m8PemCs1SdGvEW1KyT1Ij
   8SsbScjNFLtVx5+g02Q9JIi25JcymQEI61JbUqoXbApT79QFFtEuhuvkv
   SeN+FESYowvbkQXu6ugAZv3bkgvuRplXxpn6yNwpJZU1EEuJpntS+/P0W
   w==;
X-CSE-ConnectionGUID: VoRmV77YRkSl7cE9MTy5OQ==
X-CSE-MsgGUID: 3UwuCVqpSieYpHF33aVWIg==
X-IronPort-AV: E=Sophos;i="6.25,257,1779148800"; 
   d="scan'208";a="27548269"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:22:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:19572]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.52:2525] with esmtp (Farcaster)
 id 4e320bed-27ac-4bc1-9c81-17ec50b9090b; Wed, 2 Sep 2026 03:22:57 +0000 (UTC)
X-Farcaster-Flow-ID: 4e320bed-27ac-4bc1-9c81-17ec50b9090b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 2 Sep 2026 03:22:56 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.39) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 2 Sep 2026 03:22:56 +0000
From: Nathan Gao <zcgao@amazon.com>
To: SJ Park <sj@kernel.org>
CC: Nathan Gao <zcgao@amazon.com>, <akpm@linux-foundation.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <baolin.wang@linux.alibaba.com>,
	<david@kernel.org>, <ryan.roberts@arm.com>
Subject: Re: [PATCH v3] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Tue, 1 Sep 2026 20:22:46 -0700
Message-ID: <20260902032248.86780-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902001142.107226-1-sj@kernel.org>
References:
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

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

No problem.  I think I get your point, to scope the fix down as much as
possible.

v4: https://lore.kernel.org/all/20260902031655.84721-1-zcgao@amazon.com/

> > -- 
> > 2.50.1
> 
> 
> Thanks,
> SJ

Thanks,
Nathan

Sent using hkml (https://github.com/sjp38/hackermail)
