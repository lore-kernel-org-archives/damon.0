Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DD1E9B1A
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788067777; cv=none; b=Qm8JV88upwEMlZ5SAxQSYjRv1SUAwYZhlucPoM17IDNE6D3nGLqqAaojawIqSWrKiZHJJeVecs4EIQQW6Em4oR+ucHbVz6RcY8Y1zeNf7pqWrXGtyP5SbAWhtqt3JmRv47dbHZnxTiD68r9bXlyzSVe7cVDU2w45nLvdJiZXyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788067777; c=relaxed/simple;
	bh=IOWEyhRUf6Z6AIJXXeY389/Hh4hZDZLC76DgoJMilxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gjhUzG+5wmOltOHnDQpOQXQL6OMW1ahe9ns7y0oBhXS7p//vbV4JdKrAVhMcRVS1aHp2iBPUpGrqNCV17sYQ73w9vagmnMY258OQMHhd/IqeMZwXGjiobCVyF/P86N9wkviuVH2kK6mtfJJSrB+/gemkIuixYT4SDDNAp3JFjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPNNnJHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPNNnJHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F301F000E9;
	Sun, 30 Aug 2026 05:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788067776;
	bh=31K070obe1VBEihVyyBa7rFlqTDFswx0R1jwxcU5LRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPNNnJHyoGN4FHCuHhqmL4SeU6UJxiu8kxmvjbtVdkP5Z+FLgGrvXK2RFpshgE7p0
	 6OBPjRYNP0KI2lu1woAmTcwTMfVWFN/ZvewGrgKXgeNq87VT1h1oloUemDm52OXBub
	 v6fcZrmJk87uPdarwCFW47orJl39azO6angMDQgSMZwT3lKL72anSKfHzXsJsFW2Ji
	 hnRXUxekuDkJgKt1iHMJGqvj2MW3Lgk598WOtbXzFGwu33f7zfMy7Nro/TWr8+CD8H
	 iiSXZZwOJyPUoZxuB77f2oHQ2uNLZ1xbnbNeXAlWmhcfmoWebcn4tQUjFdvjTQDZmJ
	 dsM6sK1CXTE4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] mm/damon/paddr: support hugetlb folios in access
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830051407.50008-4-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
 <20260830051407.50008-4-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 05:29:35 +0000
Message-Id: <20260830052936.44F301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Non-atomic huge PTE modification in damon_hugetlb_mkold() caus=
es a TOCTOU race with hardware page table walkers, silently dropping dirty =
bits.
- [High] Incorrect physical address advancement when starting from a tail p=
age of a large folio.
--

commit fa7cc985c2891991281afce141ed40264af354fe
Author: Krishna Iyer <kiyer@crusoe.ai>

    mm/damon/paddr: support hugetlb folios in access monitoring
   =20
    DAMON's physical address space monitoring is blind to hugetlb-backed
    memory. Every access check starts at damon_get_folio(), which rejects
    folios that are not on the LRU lists. This commit adds
    damon_get_folio_incl_hugetlb() to additionally accept hugetlb folios.

[ ... ]

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 62004206ca310..ece101d346844 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does this non-atomic huge PTE modification
drop hardware dirty bits?

In damon_hugetlb_mkold() in mm/damon/ops-common.c:

	pte_t entry =3D huge_ptep_get(mm, addr, pte);
	struct folio *folio =3D pfn_folio(pte_pfn(entry));
	unsigned long psize =3D huge_page_size(hstate_vma(vma));

	folio_get(folio);

	if (pte_young(entry)) {
		referenced =3D true;
		entry =3D pte_mkold(entry);
		set_huge_pte_at(mm, addr, pte, entry, psize);
	}

If a hardware page table walker sets the dirty bit concurrently between the
read and the write, does the non-atomic writeback via set_huge_pte_at()
silently overwrite and clear the dirty bit?

[Severity: High]
This isn't a bug introduced by this patch, but does this physical address
advancement skip memory pages?

In damon_pa_pageout() in mm/damon/paddr.c:

	addr =3D damon_pa_phys_addr(r->ar.start, addr_unit);
	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
		folio =3D damon_get_folio(PHYS_PFN(addr));
...
put_folio:
		addr +=3D folio_size(folio);
		folio_put(folio);
	}

If the region's start address is not naturally aligned to the folio boundary
and lands on a tail page of a large folio, does adding the full folio size
overshoot the start of the next folio?

The same pattern appears in damon_pa_stat() where it also over-accounts the
filter size:

		if (damos_pa_filter_out(s, folio))
			goto put_folio;
		else
			*sz_filter_passed +=3D folio_size(folio) / addr_unit;
...
put_folio:
		addr +=3D folio_size(folio);
		folio_put(folio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830051407.5000=
8-1-kiyer@crusoe.ai?part=3D3
