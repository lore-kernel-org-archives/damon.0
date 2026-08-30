Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C224293C
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788105954; cv=none; b=iseZxgR/O2I5P/TmLBpV72UWQsFnZjUi+N90Y/TI4LBgw2VyA5yLbRUgoInU4frAtxJShvTrWa0ynhsq1oUVqWmVNp13HeeLK0ES45qfjNLwroJuGitZ4wRA5PseZINj8NUXSZE/xY1SRyUgkMkpCCqnd4kSoZRkH36PmgnXQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788105954; c=relaxed/simple;
	bh=y46X7ZF83VDzslW8e/PmFDwY15yWCUGY+ojXnxQImWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuphQBhrTfNP1QMQbJVjpHwxeQFAVtpTjZckF8BCJMcVQEF5NRJHbMyB8EJOI4Wank/wm4nqa3uzDu4Vw6Oa0BHfEcoi3cZ+NycMigskBcg7Ez/nmscECCTgBYg+DyS5kPTfKdwvbpP0We9GsRVUrZXYlfmsCRxgCZqEK1JfJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKqND4zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKqND4zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC991F000E9;
	Sun, 30 Aug 2026 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788105952;
	bh=fCo9nIHCR0SSOf0HUL2g4TpwG8IkTIyxU3dprWnWbs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKqND4zioQvTgum3Z66ZwoALBfqViZy28Xr/uN0sqDRwVYZ3FOLO3p55paQbnPbqL
	 8M2T2CyrOXYEyjsfvwfDELF7LnkbS065vt+xVUG6jHnOrOu9WvGTAeeGWrSo9wdCqr
	 xZWkgh8XO+XdDQ9KcOi0/XytLWba24Jd/yN5KMfltOzAdPML9xC8p5ug7KSnfSf977
	 3n1iKKS4PFaDssEkz8XA7ytf7uJdABhlyPRAicVzZ1mLbacsjLABc/+fM84/eq+cu5
	 qjyMCrQQBh5LWQieeMKzZ7exuqEekvg02ZDK4PuINOedG6Sk7C4kidZUGkMLs5SvjX
	 EzORFASvkqTtg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/6] mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
Date: Sun, 30 Aug 2026 09:05:45 -0700
Message-ID: <20260830160545.98969-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830052629.CC44C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 05:26:29 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Non-atomic update of HugeTLB PTE in damon_hugetlb_mkold() overwrites hardware-set dirty bits and triggers unintended BBM sequences.
> --
> 
> commit a960b7ee57eac1d4fccc44af4918b4b8331a38a3
> Author: Krishna Iyer <kiyer@crusoe.ai>
> 
>     mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
>     
>     damon_hugetlb_mkold() clears the accessed bit of a hugetlb-mapping huge
>     PTE and propagates the aging to secondary MMUs via
>     mmu_notifier_clear_young(), spanning the whole huge page size.  It
>     currently lives in vaddr.c, and is thus usable only by the virtual
>     address space monitoring operations set.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index fbda70d8ea4d0..f5fe92b825bbc 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> 
> [ ... ]
> 
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
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this non-atomic update of the hugetlb
> PTE overwrite hardware-set dirty bits?
> 
> The hardware MMU can set the dirty bit (on x86, or arm64 with hardware managed
> dirty bits) between the huge_ptep_get() read and this set_huge_pte_at()
> write. This non-atomic read-modify-write drops the hardware dirty bit, leading
> to data loss upon reclaim or sync.
> 
> Additionally, on arm64, using set_huge_pte_at() on an already valid contiguous
> PTE triggers an unintended break-before-make sequence with a broadcast TLB
> flush via clear_flush(), which causes severe performance regressions.

Good catch.  I will work on fixing this.


Thanks,
SJ

[...]
