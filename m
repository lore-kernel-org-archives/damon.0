Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96533FE15
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325070; cv=none; b=lARv8f542xDNDbx5pKK0+PlOAoezTtXdan/BEFBhfDjAr/EQlBmQUHIJM7ORlSuJZVaFNmiJntsYTKgdC5ykjJ8mUT+VNkGKE2CJU3pB2rCDk87EmYiih76AX0CtDIqbJgg4gHZo2aJLKwYwKkztypnij5udSoKOXnT8yj6cgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325070; c=relaxed/simple;
	bh=3m5WKrc7ESpbZOVGcwippNCTDefWi4/+mxKoLaDe+jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxB37DxNY6u9TiXTTmBHz41sFDGSi3fc4joIyEHnD+Uayb2VG2vwAaEP1O4QMo33niCj9UrfACTKzRV9MBMhWcFTGfbjbIY8qv5n+/gdV/AiPLLgkz05Odr2ad8eOiwjq+Hcqgn2EY9g0XINNdq65chWO3MUzfUq0kFjoVT32hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FApynPRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FApynPRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352611F000E9;
	Wed,  2 Sep 2026 04:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788325069;
	bh=w0VzdupalHkFpY02kAuS6Vowdrap/knD62xGt5Fh5x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FApynPRbiHefbclybKyy5gg2syKTCZsWT+JTtNjuppPx26G572elPfQFS0Qk5BEkO
	 Hk4rVHoR1Rm8C8NG+RgTyGS4ZNhMW2u9jS/bmzZk+F77l4Aukn0KB3+W44lYzNZFJO
	 kYQIapdZXuDBegE1824ITPhhgJnLsjjaOj9gmQRYsRx8LsOH1+5WUA8/AgeBDM0bE6
	 NpvKp1Nc6Ynvn6c7a4/W+wVHAq1c6llSJfpeFXLUFP47MYLUEEdZhXEw7Znh78Br86
	 78XFgxjvxR5YksQupCqTLJUNrMZUj5hc8zQjSsUnU5NMpApW90bc/39IP0q0WAwZzB
	 TvJMfzjyjTTdw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: support hugetlb folios in access monitoring
Date: Tue,  1 Sep 2026 21:57:40 -0700
Message-ID: <20260902045742.89356-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902031518.8BE6D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 03:15:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Non-atomic PTE modification in `damon_hugetlb_mkold()` clobbers hardware-updated dirty bits.
> - [High] DAMOS action appliers suffer from severe O(N) performance overhead on hugetlb pages due to PAGE_SIZE stepping.
> --
> 
> commit c04c513b2839f46c6e864892a28fa35c945f1209
> Author: Krishna Iyer <kiyer@crusoe.ai>
> 
> mm/damon/paddr: support hugetlb folios in access monitoring
> 
> This commit introduces damon_get_monitor_folio() to allow Damon's physical
> address space monitoring to sample hugetlb-backed memory. It updates the
> access monitoring primitives damon_pa_mkold() and damon_pa_young() to use
> this new function. The Damos action appliers continue to use
> damon_get_folio() to skip hugetlb folios.
> 
> >     The DAMOS action appliers (damon_pa_pageout(),
> >     damon_pa_mark_accessed_or_deactivate(), damon_pa_migrate(),
> >     damon_pa_stat()) keep using damon_get_folio(): reclaim, LRU
> >     manipulation and migration cannot act on hugetlb folios, so their
> >     behavior is unchanged.
> 
> [Severity: High]
> This is a pre-existing issue, but does this unchanged behavior cause a severe
> performance regression when Damos action appliers encounter hugetlb pages?
> 
> When damon_pa_pageout() and damon_pa_stat() (with filters) run on regions
> with hugetlb memory, damon_get_folio() rejects the hugetlb folios. This causes
> the code to fall back to PAGE_SIZE stepping:
> 
> mm/damon/paddr.c:damon_pa_pageout() {
> ...
> 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
> 		folio = damon_get_folio(PHYS_PFN(addr));
> 		if (damon_pa_invalid_damos_folio(folio, s)) {
> 			addr += PAGE_SIZE;
> 			continue;
> 		}
> ...
> }
> 
> For large folios like 1 GiB hugetlb pages, this results in hundreds of thousands
> of redundant atomic refcount operations per page (262,144 times). Does this
> PAGE_SIZE stepping need to be updated to advance by folio_size() to prevent
> massive CPU consumption by Damon threads?

For such cases DAMOS quota feature exists.  We could revisit this later, or
whenever a real user reports this as a problem.

> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5c6c3a597fd0b..ed7b7f31291a0 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -37,7 +37,7 @@ static unsigned long damon_pa_core_addr(
> >  
> >  static void damon_pa_mkold(phys_addr_t paddr)
> >  {
> > -	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
> > +	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
> >  
> >  	if (!folio)
> >  		return;
> 
> [Severity: Critical]
> This is a pre-existing issue, but can this resulting call chain clobber
> hardware-updated dirty bits?
> 
> Now that damon_pa_mkold() supports hugetlb folios, it processes them via
> damon_folio_mkold_one(), which reaches damon_hugetlb_mkold(). In this
> function, the PTE is updated non-atomically:
> 
> mm/damon/ops-common.c:damon_hugetlb_mkold() {
> ...
> 	if (pte_young(entry)) {
> 		referenced = true;
> 		entry = pte_mkold(entry);
> 		set_huge_pte_at(mm, addr, pte, entry, psize);
> 	}
> ...
> }
> 
> Any hardware modifications to the PTE (like setting the dirty bit) between
> huge_ptep_get() and set_huge_pte_at() are silently overwritten. Could this
> result in data loss or memory corruption where modified memory is discarded
> without writeback?

I'm separatively working on it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902025700.17975-1-kiyer@crusoe.ai?part=3


Thanks,
SJ
