Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F330C359
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610215; cv=none; b=CHxmTIzxTke2v9s4Jb31MUU6FLhAilJ6onEn/r0U4TPy5WJWp8XHfhvI26kGYqGhfac3BHK8OHlGRUBVV2cXtgHcIDN3VMeQN3kReMPRC1f5404pEzNg1Vv6kH4f/DPSBvoiV8vhVE2K6mQVlpx4RDHQbWd75LehGvV/02Ic9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610215; c=relaxed/simple;
	bh=SJJ2HpSop4urdopNzfbpnuL4JtfEov01Bj4f9nDh9T4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndZ2Z6ODU9UERaVpVYi5DUtcz/jqEg4rhe0Khzy7EvpVO4LMNqIpaOo52p2T+x3ik6Jx/qYkTvbU13xUyrccONP83T4neoAa2t7BMDbSPRbcW+OE6WORglvug+oJPLdaWOfEpMm0ZhHnhXLgfLMwhXxfM+aMvgu6t+8ZQvcoo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGkARp8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGkARp8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4481F00AC4;
	Sat,  1 Aug 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610213;
	bh=IyjJvYRr2FPDr5muus8iZeOYtx+v2c09VsVBHrVC+XE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGkARp8kbaFbeIT19bbkFZqUaGbBFfVjLGuhjFh5IqsGluaMgpOIXuqb5s84i6G69
	 jlNGvaeLb3jQCMwMxfAiJZCTuxGssBrj9nJVX3D9sJRa/z/1gL3SpnzDwjJKBWZS1R
	 LiOgohy+7RZPV/WLq417AHLuSoF6rHVe56VvWPJqHalzo38dW6DKDraZ2vleyv7mar
	 /QtzlB9B1i0OfQ15N+PfDARUj5R5YnwVY4EEgw14Ww20GqPnuVrSaFTcHI1QkRAYX8
	 kLM+HRdJe087JVyxaOP/8lJeLMLuLrnUVFpPDd1AqOu9F2v7cyGbLBHtqCSBV5gDSf
	 Px1qGBnEc3xCw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/9] mm/damon/vaddr: respect folio end for
 DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801173554.94710-6-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
 <20260801173554.94710-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:50:13 +0000
Message-Id: <20260801185013.8E4481F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Direct dereference of PTE pointer `*pte` instead of using the lo=
cal safely fetched `ptent`.

Pre-existing issues:
- [High] Batched PTE advancement blindly skips interleaved folios and PTE-l=
evel Accessed/Young bits within a large folio's virtual footprint.
- [High] The exact page iteration bug fixed in `damos_va_stat_pmd_entry()` =
is also present in `damos_va_migrate_pmd_entry()` but was missed by this pa=
tch.
--

--- Patch [5]: [RFC PATCH 5/9] mm/damon/vaddr: respect folio end for DAMOS_=
STAT ---
commit 20f53909d4e28dc2c1b2dd4ce52890349fc6c85d
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: respect folio end for DAMOS_STAT

For applying DAMOS_STAT action to a region, DAMON virtual address space
operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
filters to folios of addresses of the region in the pmd.  It starts from
the walking address and advances the address by the size of the folio of
the address until it goes out of the pmd or the region.

Link: https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 0648400b2d65b..035cd509f6b58 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -831,6 +831,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsign=
ed long addr,
>  		return 0;
> =20
>  	for (; addr < next; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> +		unsigned long page_idx;
> +
>  		nr =3D 1;
>  		ptent =3D ptep_get(pte);
> =20
> @@ -844,7 +846,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsign=
ed long addr,
> =20
>  		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
>  			*sz_filter_passed +=3D folio_size(folio);
> -		nr =3D folio_nr_pages(folio);
> +		page_idx =3D folio_page_idx(folio, pte_page(*pte));

[Severity: Medium]
Is it safe to directly dereference *pte here instead of using the local
safely fetched ptent?

Reading a PTE directly on 32-bit architectures (like x86 PAE) can result in
a torn read if the hardware concurrently updates the Accessed/Dirty bits,
potentially leading to an incorrect PFN and subsequent wild pointer
arithmetic.

The local snapshot ptent was already obtained via ptep_get(pte) and should
likely be used here.

> +		nr =3D folio_nr_pages(folio) - page_idx;

[Severity: High]
This is a pre-existing issue, but does this batched PTE advancement blindly
skip interleaved folios and PTE-level Accessed/Young bits within a large
folio's virtual footprint?

For PTE-mapped large folios, hardware tracks the Accessed bit independently
per 4K PTE. By checking only the first PTE and blindly skipping the rest,
DAMON ignores accesses to subsequent pages of the folio, potentially
classifying hot memory as cold.

Furthermore, if userspace partially unmaps or interleaves different mapping=
s,
the blind pte +=3D nr skips those unrelated folios completely without
verifying they map the same folio.

>  		s->last_applied =3D folio;
>  	}
>  	pte_unmap_unlock(start_pte, ptl);

While reviewing this patch, I noticed the exact page iteration bug fixed in
damos_va_stat_pmd_entry() is also present in damos_va_migrate_pmd_entry()
but was missed by this patch.

[Severity: High]
This is a pre-existing issue, but does the DAMOS migrate action also advance
the PTE pointer unconditionally by the full size of the large folio?

mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
	...
	for (; addr < next; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
		...
		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
				migration_lists);
		nr =3D folio_nr_pages(folio);
	}
	...
}

If the scanning starts in the middle of a large folio, it will advance past
the end of the large folio and skip unrelated folios that follow it, failing
to migrate them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801173554.9471=
0-1-sj@kernel.org?part=3D5
