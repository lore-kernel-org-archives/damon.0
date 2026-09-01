Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D74A3844
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294266; cv=none; b=X0ADynTyb0Z7nKsNRW3i8ugBrOFtuz6q8LLor3nVsLRbM9Qjz+ThPE88PVAC4IHLBJlNydq2dEkREpYgCiFd5oNppAXlkSoO8TzUa/F8I1jIRkiybO5KFoubNXD7qT4wuxnQQPWF70i21DYXbVfhe3UvNCn9HPwd1qHyYElQ72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294266; c=relaxed/simple;
	bh=E4pHxCsEOyqrdNa3dBPS7NYe3KlIPx1SLIgIa06hvB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7udgZJA1ntZtNZTvdqbmsBkbKYj3Gn+hca7kLKlAE6WRqUmdQ+C0YVMgwsRrzDCysrMohwk6dkZTMr4yxplpVqg8ZcuzrgzbaET5dt2An4JirZkmR7YqS4iTXmtR9GehnzrqaqVj51aZznCLdm5pGWvBvPJ4HsX0oaDSloaS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiyzBr/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiyzBr/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C781F000E9;
	Tue,  1 Sep 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788294261;
	bh=MGm9kin1gkQupr8IWXCaVdHcCknyTCKp+5VCNoNKduI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZiyzBr/jSZuIA+cVUCY1vFj6wf6o0OPsKNXwlG/vW4daU7PVWKrXZkUVjvgS01KLA
	 U/K3wXG5Jy71kT/tRDOr3WhgHQAkWUawcg/AQm0yke76Q7xF34HTEa3BpZ0MCWymEh
	 OTrW6IiblqfsFsSUqqIfumfp2is/WjRXWL2RXl4rO1Q5400dSpcy2voJSX146EtTtW
	 y/hEGgfg5FD/oJ8ml+IBi2guQM3UgFSZEzaUbgAfzzuHj9pQ7H+AUdl1UFNW2eDHcE
	 onSGXOkK3GIi9Ek+wKfQ+yA3FTWqXvlGUFwC0MeR0tFeNYXHlbWjUSfFr3gIk/OmPT
	 Pp8lNEajEkAyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/damon/ops-common: use a page-aligned address in
 damon_ptep_mkold()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Gao" <zcgao@amazon.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901201001.33271-1-zcgao@amazon.com>
References: <20260901201001.33271-1-zcgao@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:24:20 +0000
Message-Id: <20260901202420.D8C781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned addresses passed to mmu_notifier_clear_young and set_hug=
e_pte_at for PMD and HugeTLB pages cause out-of-bounds clearing of accessed=
 bits and page table corruption.
- [High] Incorrect advancement of PTE pointers for large folios in DAMON's =
vaddr operations skips unrelated PTEs.
--

commit e20303b2de84c12df7877f523196d088cede0a4e
Author: Nathan Gao <zcgao@amazon.com>

    mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
   =20
    __damon_va_prepare_access_check() picks a random byte address within the
    region and stores it in r->sampling_addr. damon_va_mkold() passes it in=
to
    a page table walk, which hands it to damon_ptep_mkold() as the address =
of
    the page to sample.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 7a2e40bc7baed..3a5f5cdeb2017 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -46,6 +46,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struc=
t *vma, unsigned long addr
>  	bool young =3D false;
>  	unsigned long pfn;
> =20
> +	/*
> +	 * Arch implementation of ptep_test_and_clear_young() may require
> +	 * aligned @addr
> +	 */
> +	addr =3D PAGE_ALIGN_DOWN(addr);
> +
>  	if (likely(pte_present(pteval)))
>  		pfn =3D pte_pfn(pteval);
>  	else

[Severity: High]
This isn't a bug introduced by this patch, but while this fixes the
unaligned address issue for damon_ptep_mkold(), the PMD and HugeTLB
paths are identically vulnerable.

In mm/damon/ops-common.c:damon_pmdp_mkold(), the unaligned address is
still passed directly to the MMU notifier:

	if (likely(pmd_present(pmdval)))
		young |=3D pmdp_test_and_clear_young(vma, addr, pmd);
	young |=3D mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZ=
E);

Does this cause the cleared range to spill over into the next PMD mapping?

Similarly, in mm/damon/vaddr.c:damon_hugetlb_mkold():

	if (pte_young(entry)) {
		referenced =3D true;
		entry =3D pte_mkold(entry);
		set_huge_pte_at(mm, addr, pte, entry, psize);
	}

	if (mmu_notifier_clear_young(mm, addr,
				     addr + huge_page_size(hstate_vma(vma))))
		referenced =3D true;

Can passing the unaligned address to architecture-specific page table
modifiers like set_huge_pte_at() corrupt multi-entry contiguous blocks,
and does the MMU notifier suffer from the same out-of-bounds clearing here?

[Severity: High]
This is a pre-existing issue, but there appears to be a logic error with
how large folios are handled during page table walks in DAMON.

In mm/damon/vaddr.c:damos_va_stat_pmd_entry() and
damos_va_migrate_pmd_entry():

	for (; addr < next; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
		nr =3D 1;
		ptent =3D ptep_get(pte);
	=09
		if (pte_none(ptent) || !pte_present(ptent))
			continue;
	=09
		folio =3D vm_normal_folio(walk->vma, addr, ptent);
		if (!folio)
			continue;
	=09
		...
		nr =3D folio_nr_pages(folio);
	}

If the folio is partially mapped, or if the loop starts in the middle
of a large folio, wouldn't advancing by the entire folio size
(folio_nr_pages) overshoot the mapping bounds and silently skip
unrelated PTEs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901201001.3327=
1-1-zcgao@amazon.com?part=3D1
