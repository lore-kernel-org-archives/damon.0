Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA04734C5
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268734; cv=none; b=I6s4CDv4Uq2h2+z2epbkdNF+0IrN/hG4MiNQj+64QRsr7QnPgoI5unv066NSWaEtBjLRNu/SvNL/J+JIAUzjO6BMKaUg9Vd7RDd1eMozW80VUdYt/Yqiuo4mz8pqOsqtVp6PVoIZOPdNQbV1Qrmxbg6jABun1Dwoa3a/6qTEFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268734; c=relaxed/simple;
	bh=KjpJ58OHKr51+fvCEi9BG8l3onA0CU24TF5Nx7DKVY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M6cgXt5QVqyaVcF0LFznLYKBfUXbZHYAsstX4cuvJ/Kow3LXO+3LspmoqN3JP5hgYvw85XK0rWbBWlCX/t1lV37g/b/toVHMlrUTIz8t470G67HNTkYg996w93PzuFfB27OxaewN59m6tj5eyEYEjkx+k6j4M/2pK0BSyABynB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8M7SxHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8M7SxHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798821F00A3A;
	Tue, 28 Jul 2026 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785268733;
	bh=0KQT0Iqi87WpzxXJOyHpyAdEasKTEwDFf7ZkS/GhWKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8M7SxHt+1Ph59dOm6bW8eMdSRtLKquidXKWHLWVwjignC8WAZxhWLJ3+yhcrBHzJ
	 7iLVtLqJd3nlYo1tQw6ZfImOm5Zvr+GqC3efbg1UKM8/q/m4xbQP9AZGxtnCwqm1Gd
	 5Jgq4iAeWNZzpYZuEKw/x3DrGVjP7DmQ6RsjmW8wZOMwg0qKqGwEYVAZRL3n9lxCtO
	 MVsLrNc2AC5MlGcpgJGxZSsfQ7khQ+AyL7AtHLHyyvV2E7wPPlnZBFZDBmsKSlb2NP
	 hyzBy2lordrcPLzEmXaLNFhRn2XzeXvTgTiZUYfH8j8L/zAhoR6voS1crSFBqb6ks4
	 aMTgigfjSv9Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/madvise: skip zone device folios in cold/pageout
 PMD range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728194714.3713735-4-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-4-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 19:58:53 +0000
Message-Id: <20260728195853.798821F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Direct assignment to *ptep bypasses set_pte_at(), causing hype=
rvisor faults on paravirtualized architectures.
- [Critical] madvise_cold_or_pageout_pte_range() blindly calls pmd_folio() =
on PMD entries without checking if the VMA allows raw PFN mappings, leading=
 to invalid folio pointer dereferences.
--

--- Patch [3]: [PATCH 3/4] mm/madvise: skip zone device folios in cold/page=
out PMD range ---
commit f53274ca71e03d22eaac643cdc7488b95adca203
Author: Gregory Price <gourry@gourry.net>

mm/madvise: skip zone device folios in cold/pageout PMD range

This patch modifies madvise_cold_or_pageout_pte_range() to explicitly
filter out ZONE_DEVICE folios. It uses folio_is_zone_device() to prevent
aging or paging out device memory that might bypass existing VMA and PMD
checks.

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 07a21ca31bad4..ffd6a68320a86 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -395,6 +395,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
> =20
>  		folio =3D pmd_folio(orig_pmd);
> =20

[Severity: Critical]
This is a pre-existing issue, but does this code dereference an invalid
folio pointer?

The madvise_cold_or_pageout_pte_range() function handles MADV_COLD and
MADV_PAGEOUT hints, and the can_madv_lru_vma() filter rejects VM_PFNMAP but
allows VM_MIXEDMAP VMAs.

Device drivers can map raw PFNs (not backed by a struct page) as huge PMDs
into VM_MIXEDMAP VMAs using vmf_insert_pfn_pmd().

When encountering such a PMD, pmd_trans_huge() is true, but pmd_folio()
translates the raw PFN into a garbage struct folio pointer.

Could this cause a kernel panic due to an out-of-bounds read when
folio_is_zone_device() dereferences folio->flags on the invalid pointer?

> +		if (folio_is_zone_device(folio))
> +			goto huge_unlock;
> +
>  		/* Do not interfere with other mappings of this folio */
>  		if (folio_maybe_mapped_shared(folio))
>  			goto huge_unlock;

[ ... ]

While reviewing mm/madvise.c, I also noticed another pre-existing regression
in guard_install_set_pte():

> static int guard_install_set_pte(unsigned long addr, unsigned long next,
> 				 pte_t *ptep, struct mm_walk *walk)
> {
> 	unsigned long *nr_pages =3D (unsigned long *)walk->private;
>=20
> 	/* Simply install a PTE marker, this causes segfault on access. */
> 	*ptep =3D make_pte_marker(PTE_MARKER_GUARD);

[Severity: Critical]
This is a pre-existing issue, but does this direct assignment bypass
architecture-specific hooks?

By assigning directly to *ptep instead of using set_pte_at(), this skips
hooks required by paravirtualized architectures.

On architectures like Xen PV where guest page tables are mapped read-only by
the hypervisor, will this direct write trigger a hypervisor fault and crash
the kernel if an unprivileged user calls madvise(..., MADV_GUARD_INSTALL) on
a valid anonymous VMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728194714.3713=
735-1-gourry@gourry.net?part=3D3
