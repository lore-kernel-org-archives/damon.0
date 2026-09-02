Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AC1B6D08
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318738; cv=none; b=lvtQIeFONecLCeeBEf522cL1jxowh2iySTzONla1EPjb/h7Tp0Fnt7znvjVNLyssQFy1zzoiVkGqll+QcbVEDHrA/Jp3leP4GoUGxM9P+MnPwhH1avciJYg07Evn6k5TPKebm8ER/6c9JwcgfyiTve1xOIjw3w+NgIiX/sA9324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318738; c=relaxed/simple;
	bh=vJrjMlPHrenA3E4MxtGEh0G2GF4qrtQujq2bu0Od/nI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+UVgBpUOz+xG5ioyuAXBXjbxMx2tqMeB/Ko+GoXpSycLHJ4Sh/Pj/7SkgyfN15OgyhD4XodQi3qidpVNPeGS+011kLidVrnfASAL5vUTw6cLoHkP6kB/pk8jA6xDGX0LOBpR8I/3fQLz9/E1bS0/61pisCqMon9gFsIlmj8R1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD/SHn3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD/SHn3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B281F000E9;
	Wed,  2 Sep 2026 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318737;
	bh=r6Q7gRcJDrwQQux+YSKU0GOcwIuRkK/yLmsFyvtzz0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aD/SHn3OrPEh8GYLKDqOsDt2/3lKDGOKLRw8Sg6RJnNbS4KGUKY/gLITzfXvnp4J6
	 kX/ZHoDvcEBrvqcsO4s3ic9U3rLLDwkyLinYGUTTBkSN5lnIApt9O/Fy+D8SC9zZEf
	 pOnTgWND0yAGbX2OynamG6nMdJ4nEF8HpzoHcHtR/A3R5wQODdAvwWgzspyquJlECg
	 D6Tzmkzu4aeaxW58wTbbUZwPMQWtyKFDZdzedB1V0ljNHcsaS4ZAwluTG0z9xVhkc7
	 SyAVm52zgzcMTHz1R0uLoEGFcUcUH0Twc/8nUP3JFQ9AW41iOYtaD1imStQBdnSEdQ
	 6TVuPAslKtRkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/ops-common: handle hugetlb folios in
 folio mkold/young rmap walkers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902025700.17975-3-kiyer@crusoe.ai>
References: <20260902025700.17975-1-kiyer@crusoe.ai>
 <20260902025700.17975-3-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:12:16 +0000
Message-Id: <20260902031216.D2B281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-atomic clearing of huge PTE young bit silently overwrites hard=
ware dirty bit
--

commit 04cc6d81cf1593c6fb092b306da28db5569a3f11
Author: Krishna Iyer <kiyer@crusoe.ai>

mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers

This commit adds hugetlb branches to the damon_folio_mkold_one and
damon_folio_young_one rmap walkers. It reuses damon_hugetlb_mkold to proper=
ly
age huge PTEs and introduces a new helper damon_hugetlb_young for checking
their accessed state.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index f5fe92b825bbc..373b25db59505 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -193,10 +193,15 @@ static bool damon_folio_mkold_one(struct folio *fol=
io,
> =20
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		addr =3D pvmw.address;
> -		if (pvmw.pte)
> -			damon_ptep_mkold(pvmw.pte, vma, addr);
> -		else
> +		if (pvmw.pte) {
> +			if (folio_test_hugetlb(folio))
> +				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
> +						addr);

[Severity: High]
This is a pre-existing issue, but does expanding the use of
damon_hugetlb_mkold here expose us to hardware dirty bit overwrites?

Looking at damon_hugetlb_mkold in mm/damon/ops-common.c, it performs a
non-atomic read-modify-write on the huge PTE:

	pte_t entry =3D huge_ptep_get(mm, addr, pte);
	struct folio *folio =3D pfn_folio(pte_pfn(entry));
	unsigned long psize =3D huge_page_size(hstate_vma(vma));

	folio_get(folio);

	if (pte_young(entry)) {
		referenced =3D true;
		entry =3D pte_mkold(entry);
		set_huge_pte_at(mm, addr, pte, entry, psize);
	}

If the hardware sets the dirty bit after software reads the PTE via
huge_ptep_get, but before it writes it back via set_huge_pte_at, the kernel
will silently discard the newly dirtied state. This can lead to data
corruption as the page might be dropped assuming it is clean.

Since DAMON monitoring can be configured to monitor hugetlb VMAs, triggering
this path, can this non-atomic clearing be safely avoided or addressed here?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902025700.1797=
5-1-kiyer@crusoe.ai?part=3D2
