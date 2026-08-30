Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421591E9B1A
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788067737; cv=none; b=D6BUKOXkRdqks/opGH2W5JtwRiCTtVOShUuoMqZJgp1mHIYSTL7cmj0Cj6l8s9dIRsLcvmDG7DwbgVzYRfGYenSwyVgQl7d1K6HK1DVfSfhnZpKf+ULtDHon1XeSdWrKzzDVkQzoPrsfvkgR0eIKHGcT/rLNIE5tvMtEyBdL7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788067737; c=relaxed/simple;
	bh=+8Q+wRvMB3TJ89m6CuNisMORPZ3MX0cGrzym6JBNKv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8fUv6x6q7eOxU4Qg+qu1G8hVrjOg8XFyyVoDMdhOmTvO4/zoZF0UgIVet74jbHkH2uKgHn/WKSy8gyJ08xXt1j9wAfgx758OXrJVzPBrlq6S98MydMXY/vKgO5Eb4ulB+ApkdH0uEJcmc5t/uj8OdH+yz6fvQ7s8rVwVI190n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vcmj3EED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vcmj3EED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE21F000E9;
	Sun, 30 Aug 2026 05:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788067735;
	bh=Rmv4E07wwdg9iqnEgME21R7WzzKiGlIU7XZmWWKw0yQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vcmj3EEDlcVA4FTbBgaUiLM/W8WyD2geIoP/tThctCdoJLMMwHNfmY+YL4dO6MPDJ
	 NxiBdiMNg2BRBZqjN9X0pvCw6zst9S/E9GgLk/cFZnHW81zTrWgxT3wgj+eQ+/yUJK
	 R8j1w5wLKCQjLu8AvZG0XvhVbnEdWbZQflyb0a6ZTyJpHulYVinEYUb9mI14kQFbrd
	 YkrqCEYfAIUn/hkKqGCW/VU50HagCCxKg3ucaqpD6Ap+QIIkiuLlp0s0oezrI1dROs
	 9REuBzhRydFXFKb7hs2ztWZU2j5iCMy8TH8a/dj1a/jWGNbEeoQGy7yra9DrarHDH9
	 Cb4cbqqVlhLsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] mm/damon/ops-common: handle hugetlb folios in folio
 mkold/young rmap walkers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830051407.50008-3-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
 <20260830051407.50008-3-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 05:28:55 +0000
Message-Id: <20260830052855.93DE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] mmu_notifier_test_young() evaluates only a single base page, mas=
king accesses within shattered huge pages.

Pre-existing issues:
- [High] Non-atomic read-modify-write of huge PTE in damon_hugetlb_mkold() =
silently drops hardware-managed dirty bits.
--

commit 69bb3f48e79ddddcf3eaf4001d7704e62df0da69
Author: Krishna Iyer <kiyer@crusoe.ai>

mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers

This commit introduces hugetlb branches to DAMON's rmap walkers by reusing
damon_hugetlb_mkold() for clearing the young bit and introducing
damon_hugetlb_young() for checking it. It ensures huge PTEs are read and
aged correctly rather than using base page granularity helpers.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index f5fe92b825bbc..62004206ca310 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -193,10 +193,20 @@ static bool damon_folio_mkold_one(struct folio *fol=
io,
> =20
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		addr =3D pvmw.address;
> -		if (pvmw.pte)
> -			damon_ptep_mkold(pvmw.pte, vma, addr);
> -		else
> +		if (pvmw.pte) {
> +			/*
> +			 * For hugetlb folios, page_vma_mapped_walk() sets
> +			 * pvmw.pte to the huge PTE with its page table lock
> +			 * held.
> +			 */
> +			if (folio_test_hugetlb(folio))
> +				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
> +						addr);

[Severity: High]
This is a pre-existing issue, but does damon_hugetlb_mkold() perform a
non-atomic read-modify-write that could silently drop hardware-managed
dirty bits?

Looking at damon_hugetlb_mkold(), the code reads the PTE, clears the young
bit, and writes it back:

	pte_t entry =3D huge_ptep_get(mm, addr, pte);
...
	if (pte_young(entry)) {
		referenced =3D true;
		entry =3D pte_mkold(entry);
		set_huge_pte_at(mm, addr, pte, entry, psize);
	}

If a hardware write access occurs and sets the hardware A/D bit after
huge_ptep_get() but before set_huge_pte_at(), won't the dirty bit be
overwritten with the stale, clean value?

This could potentially lead to data loss if hugetlb pages are reclaimed
or migrated without writeback. Hooking this up for DAMON folio monitoring
means this path can be triggered frequently in the background.

> +			else
> +				damon_ptep_mkold(pvmw.pte, vma, addr);
> +		} else {
>  			damon_pmdp_mkold(pvmw.pmd, vma, addr);
> +		}
>  	}

[ ... ]

> +#ifdef CONFIG_HUGETLB_PAGE
> +static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
> +		unsigned long addr, struct folio *folio)
> +{
> +	pte_t entry =3D huge_ptep_get(vma->vm_mm, addr, pte);
> +
> +	return (pte_present(entry) && pte_young(entry)) ||
> +		!folio_test_idle(folio) ||
> +		mmu_notifier_test_young(vma->vm_mm, addr);

[Severity: Medium]
Will mmu_notifier_test_young() miss accesses within shattered huge pages he=
re?

Since the kernel's mmu_notifier_test_young() API does not take a size
parameter, passing only the base address of the huge page means it will
only evaluate the first base page.

For secondary MMUs like KVM EPT that map huge pages as multiple smaller
pages, wouldn't accesses to other subpages within the huge page be complete=
ly
missed? This could cause DAMON to classify the huge page as colder than it
actually is, which might lead to inappropriate reclaim or migration decisio=
ns.

> +}
> +#else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830051407.5000=
8-1-kiyer@crusoe.ai?part=3D2
