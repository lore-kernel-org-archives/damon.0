Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652B1F5821
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318920; cv=none; b=ZXYy456p8K+MMGB7+rZod+ZEwyfGapCgvudjzvztlGsobVMuCv0PsUmp4aNdBiuL8dXKNNKfBN1YAJXS2tgWI/A7aMPxhql8XC+ua5fo7Vx9v2DSmdSjs14crdQu4JVG+Alu3zoOAQ8nikHFDDqd138qXbCWBd9dV7YgTAkKfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318920; c=relaxed/simple;
	bh=G7RbIonbw2mno7s+7N4vj8cMLCXT6CzAABWOh4F8ayY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMEzs6SYjBvNw/gCX+9gXsCumsgRhApOrkoQAJANrF5NUWbAHXhmd5/6Zai/A3pl8CRVcKojTf6whyvPDtjlxN5q3r6Be7ICXvCzgTYJL9GodlIUAnUjyMVX6l+LCoRCfwrbmaq4MgshrxwkuKwfAME2UrL+xn0v/2Xw7671puA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS8IdDxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS8IdDxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE6D1F000E9;
	Wed,  2 Sep 2026 03:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318918;
	bh=XhfgmYHpBEVHpGqrIDtvtH3C8zSYUZznXa3CfR6+vYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IS8IdDxg52eL9EZQOa2BHJrn5Qpj1hn9+qBzMgnXCC6bKYLOHQBAc6B7jSFu74yqv
	 RWmt17PY3xv8uPHl0u5VdHDBbObkBrLShiyixzNzkU7stPGOjIP7HtF6Fj7nDajJIA
	 FMY/h4QXLx+MkdKKEfOXDkjwJz+rqtf40B70olDbuxMVhplxC2kbJvxa+fHJP+TlNp
	 IxG87clTTdBTG8rt3bVp2PEa/BvLMx3orHZS3C8ioj+QXYFBYfQTQ/dNamFviR4/hs
	 MG4B92yYagdI9ecsBvVH+tlMtyWMYI4KBLkcKH0nifUT1q062x4gZtcneFl6BeRSRI
	 o7gSYRrIYxR7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: support hugetlb folios in access
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902025700.17975-4-kiyer@crusoe.ai>
References: <20260902025700.17975-1-kiyer@crusoe.ai>
 <20260902025700.17975-4-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:15:18 +0000
Message-Id: <20260902031518.8BE6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Non-atomic PTE modification in `damon_hugetlb_mkold()` clobber=
s hardware-updated dirty bits.
- [High] DAMOS action appliers suffer from severe O(N) performance overhead=
 on hugetlb pages due to PAGE_SIZE stepping.
--

commit c04c513b2839f46c6e864892a28fa35c945f1209
Author: Krishna Iyer <kiyer@crusoe.ai>

mm/damon/paddr: support hugetlb folios in access monitoring

This commit introduces damon_get_monitor_folio() to allow Damon's physical
address space monitoring to sample hugetlb-backed memory. It updates the
access monitoring primitives damon_pa_mkold() and damon_pa_young() to use
this new function. The Damos action appliers continue to use
damon_get_folio() to skip hugetlb folios.

>     The DAMOS action appliers (damon_pa_pageout(),
>     damon_pa_mark_accessed_or_deactivate(), damon_pa_migrate(),
>     damon_pa_stat()) keep using damon_get_folio(): reclaim, LRU
>     manipulation and migration cannot act on hugetlb folios, so their
>     behavior is unchanged.

[Severity: High]
This is a pre-existing issue, but does this unchanged behavior cause a seve=
re
performance regression when Damos action appliers encounter hugetlb pages?

When damon_pa_pageout() and damon_pa_stat() (with filters) run on regions
with hugetlb memory, damon_get_folio() rejects the hugetlb folios. This cau=
ses
the code to fall back to PAGE_SIZE stepping:

mm/damon/paddr.c:damon_pa_pageout() {
...
	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
		folio =3D damon_get_folio(PHYS_PFN(addr));
		if (damon_pa_invalid_damos_folio(folio, s)) {
			addr +=3D PAGE_SIZE;
			continue;
		}
...
}

For large folios like 1 GiB hugetlb pages, this results in hundreds of thou=
sands
of redundant atomic refcount operations per page (262,144 times). Does this
PAGE_SIZE stepping need to be updated to advance by folio_size() to prevent
massive CPU consumption by Damon threads?

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5c6c3a597fd0b..ed7b7f31291a0 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -37,7 +37,7 @@ static unsigned long damon_pa_core_addr(
> =20
>  static void damon_pa_mkold(phys_addr_t paddr)
>  {
> -	struct folio *folio =3D damon_get_folio(PHYS_PFN(paddr));
> +	struct folio *folio =3D damon_get_monitor_folio(PHYS_PFN(paddr));
> =20
>  	if (!folio)
>  		return;

[Severity: Critical]
This is a pre-existing issue, but can this resulting call chain clobber
hardware-updated dirty bits?

Now that damon_pa_mkold() supports hugetlb folios, it processes them via
damon_folio_mkold_one(), which reaches damon_hugetlb_mkold(). In this
function, the PTE is updated non-atomically:

mm/damon/ops-common.c:damon_hugetlb_mkold() {
...
	if (pte_young(entry)) {
		referenced =3D true;
		entry =3D pte_mkold(entry);
		set_huge_pte_at(mm, addr, pte, entry, psize);
	}
...
}

Any hardware modifications to the PTE (like setting the dirty bit) between
huge_ptep_get() and set_huge_pte_at() are silently overwritten. Could this
result in data loss or memory corruption where modified memory is discarded
without writeback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902025700.1797=
5-1-kiyer@crusoe.ai?part=3D3
