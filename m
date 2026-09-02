Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46953054E4
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 04:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324695; cv=none; b=h/voZJ+O2hmrqkJs/lcgImlswYEm7dK3vjWSE8fIWKoEWX3mN6W3cBoynEeNzmeUsLCcR54WiYwqzivuMpNGHyduE4K9fTH9mOEtyjs1X0XqV9d2YN4sn8UCZEzVoiGdE588sC7EYvLW9uKs//J9588BwU+aAUk2IcawImAFEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324695; c=relaxed/simple;
	bh=1XR8KwQMMf/rbgCHbURbMHqMD23RiuIsOTewp3wZA5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhbdqAGKQfHSKkwdqShD48vHNrqAB2M9KjXA1/U2P3wCXro4s7dbnNFLU4suD1GJ9LgMIRo24Sp0F/f/q/YHjZgIbqLNQ0Mk1GNlwQavE9gvulPYjA9/aIjLzl7b1HLINK68MVe5bwraFzzw9rxhXYNXfdrtm+wGwApUVZ5pvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRC51GLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRC51GLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CED51F000E9;
	Wed,  2 Sep 2026 04:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788324693;
	bh=M6OYJXPJkdJuS8D/y8LxBZlLzeawwZ954QV1hullYL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRC51GLrTDaO02opi14iqF+SQH2f8CeedUIwJ1Gt00ogDUIct9LdAMi7xtbuBnHD9
	 qZ96DB7X7mbJLNIBXL9dIkLd3HlxRfE3MhkEkoAh5u4UyaVe5kdA6EMM21paENKVb1
	 hyKWNl1IWiJq/vFDWs2/USWo/XToawNjnYq65YfKRkXpcIhyvF5Sp4gyFUQtyZn2wq
	 /zTtiv97MYGTklcbxlT5ULbWoeHHLXg+OeEbavj4xfS2swF+7svrEJxbafyjrfz91z
	 8ZB0pD0I5cftd6JPrVYAG7o7hyfvEu6ZwjJgmkZzg/Apm7ESxyAayPuRZK2Ui+HQV0
	 6Q7v+sWBMz/lw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
Date: Tue,  1 Sep 2026 21:51:24 -0700
Message-ID: <20260902045126.47244-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902031422.AD24A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 03:14:22 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Non-atomic read-modify-write of huge PTE in damon_hugetlb_mkold clobbers hardware-updated dirty bits.
> - [High] Unaligned addresses in DAMON mkold functions cause incorrect secondary MMU aging.
> --
> 
> commit c27851bf8f97112ca3d3c8258d2ecf636424ff88
> Author: Krishna Iyer <kiyer@crusoe.ai>
> 
> mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
> 
> This commit moves the damon_hugetlb_mkold function from the virtual address
> space monitoring operations set to the common operations set. The physical
> address space monitoring operations set will now be able to use it to
> support access monitoring of hugetlb-backed memory.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index fbda70d8ea4d0..f5fe92b825bbc 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> [ ... ]
> > @@ -98,6 +99,35 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >  }
> >  
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
> > +		struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	bool referenced = false;
> > +	pte_t entry = huge_ptep_get(mm, addr, pte);
> > +	struct folio *folio = pfn_folio(pte_pfn(entry));
> > +	unsigned long psize = huge_page_size(hstate_vma(vma));
> > +
> > +	folio_get(folio);
> > +
> > +	if (pte_young(entry)) {
> > +		referenced = true;
> > +		entry = pte_mkold(entry);
> > +		set_huge_pte_at(mm, addr, pte, entry, psize);
> > +	}
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this non-atomic sequence overwrite
> the PTE and silently clobber concurrent hardware updates to the dirty bit?
> 
> In damon_hugetlb_mkold(), the entry is read via huge_ptep_get(), manually
> cleared of the young bit with pte_mkold(), and unconditionally written back
> with set_huge_pte_at(). A hardware update to the dirty bit occurring between
> the read and the write could be lost. If the dirty bit is overwritten with a
> stale clean copy, data could be reclaimed and lost instead of being written
> back.

I'm separatively working on this.

> 
> > +
> > +	if (mmu_notifier_clear_young(mm, addr,
> > +				     addr + huge_page_size(hstate_vma(vma))))
> 
> [Severity: High]
> This is a pre-existing issue, but could passing an unaligned addr to
> mmu_notifier_clear_young() cause incorrect secondary MMU aging?
> 
> When mmu_notifier_clear_young() receives a range that crosses page
> boundaries due to an unaligned start address, the secondary MMU (such as
> KVM) may age multiple adjacent host pages instead of just the target page.
> This would corrupt working set statistics for adjacent pages and lead to
> incorrect memory management, like reclaiming hot pages.
> 
> This unaligned addr behavior appears to originate from damon_rand() and is
> also present in damon_ptep_mkold() and damon_pmdp_mkold().

I will separatively work on this.

FYI, I think Sashiko maybe reported this kind of issue before, but I ignored it
by misunderstanding the point.  Now I understand it better and agree this is an
issue that better to be fixed.

> 
> > +		referenced = true;
> > +
> > +	if (referenced)
> > +		folio_set_young(folio);
> > +
> > +	folio_set_idle(folio);
> > +	folio_put(folio);
> > +}
> > +#endif	/* CONFIG_HUGETLB_PAGE */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902025700.17975-1-kiyer@crusoe.ai?part=1


Thanks,
SJ
