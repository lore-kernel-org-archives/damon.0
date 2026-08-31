Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26F3AAF54
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215978; cv=none; b=K0+k7H4HZX0hK0jdMc/A331xwfu4DF6g1BEvla/kA+upXAFsxT2952f8U1d0HeE3iveAfGG6/w09u2mi9DkIYSJ/aG72nUIUwJPhs/L8/dRKqWeH2n+waDRRSDpN0wu9ygHZlz2aZVLjQ2uGfcDG59VDRLcJVzEcIqRoxEEGeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215978; c=relaxed/simple;
	bh=Qwh9ZK+lJt5vSb3Eex4BdprBaVZkUTEnrmZd+06vxmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5g0v96xy7NWKimSvHUdQ1uVYaxq5ILABO/HdOhSGvlpE+D7+jivygwENs+7+mwTVZ5huGJ31OpaEQrN7QIO++XNb0KFDZb4L3CPEDlWrNT/yei13ljEapLRUQMqO0+n7f+ikmHy3uw12kuCKhVkKyJhHkvcA9I0m0w+xQhWRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSJ2bLyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSJ2bLyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42841F000E9;
	Mon, 31 Aug 2026 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215977;
	bh=V3Fw4EyWlZfZBRPzq68sCOhKv6jmdLDdOXnMXiAnnRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSJ2bLytDvw11t3kWDXr5XLCodIhLxijRfyxzFJP5jnmnbivsCQ5DdARTAoUVC8O+
	 5bjEF8a4JLAHb89o3uh3HWiLzbyjSG3op9WyjSvNFOP4E+GBo0y+MlqFPdxBYOcjg0
	 HKvPnJQ086h2I2LFEFPmTa8OqM3uTmAZOnClp0zHi1zE4ZzQ7a4/ZSYm5XF38LaVbZ
	 e2o7o1ai/hGDF0cH6NjWHdjSfPMsKyeXAj+zMFZcdoZFR4ErXlOf49NSILu/eeLCvn
	 YctKaer0M1Dv+65SNyFM0BWPSOTqcrDgxTzVXfEnHpRqM+bYJ0eaJBUe39H+9TFDrE
	 LVavUljJ2FQ3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/vaddr: use a page-aligned address for the
 sampling walks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Gao" <zcgao@amazon.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831221151.50561-1-zcgao@amazon.com>
References: <20260831221151.50561-1-zcgao@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:39:36 +0000
Message-Id: <20260831223936.D42841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fix the unaligned page table walk vulnerability=
 for `r->ar.start` in DAMOS migration and stat paths.
- [High] Incorrect PTE advancement for large folios in `damos_va_migrate_pm=
d_entry` and `damos_va_stat_pmd_entry` causes unrelated PTEs to be silently=
 skipped.
- [High] `damos_madvise` miscalculates the madvise range when region bounda=
ries are not page-aligned, potentially applying actions to memory completel=
y outside the region.
- [High] Unaligned huge page address passed to `mmu_notifier_clear_young()`=
 corrupts adjacent huge pages' access bits.
--

commit fa91d6928f529249184a9980dfc55fc3ff427ea8
Author: Nathan Gao <zcgao@amazon.com>

mm/damon/vaddr: use a page-aligned address for the sampling walks

This commit aligns the sampling address passed to damon_va_walk_page_range()
down to a page boundary in damon_va_mkold() and damon_va_young(). This
prevents an out-of-bounds page table access on arm64 caused by clearing the
young flag on a batch of PTEs derived from an unaligned address.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 0648400b2d65b..fe76714d8e3d6 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -350,6 +350,9 @@ static void damon_va_mkold(struct mm_struct *mm, unsi=
gned long addr)
>  		.hugetlb_entry =3D damon_mkold_hugetlb_entry,
>  	};
> =20
> +	/* Arch helpers can derive a page range from @addr; align it down. */
> +	addr =3D PAGE_ALIGN_DOWN(addr);
> +

[Severity: High]
This is a pre-existing issue, but does this patch miss fixing the same
unaligned page table walk vulnerability for r->ar.start in the DAMOS
migration and stat paths?

While this commit fixes damon_va_mkold() and damon_va_young() by
aligning the address before walking the page table, DAMON region boundaries
(r->ar.start) can also be unaligned. damos_va_migrate() and
damos_va_stat() pass r->ar.start to damon_va_walk_page_range()
without aligning it.

When a YOUNG filter is applied, this unaligned address propagates through
damos_va_filter_out() to damon_ptep_mkold(..., addr):

mm/damon/vaddr.c:damos_va_migrate() {
    ...
    damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
    ...
}

Will this trigger the exact same out-of-bounds PTE access bug on arm64
that this patch intends to fix?


[Severity: High]
This is a pre-existing issue, but can passing this PAGE_SIZE aligned
address cause state corruption for memory access tracking in secondary MMUs
(like KVM) for huge pages?

The page table walker calls damon_mkold_pmd_entry() and
damon_mkold_hugetlb_entry() with this page-aligned, but not necessarily
huge-page-aligned addr.

In damon_pmdp_mkold(), this unaligned addr is passed verbatim to
mmu_notifier_clear_young():

mm/damon/ops-common.c:damon_pmdp_mkold() {
    ...
    young |=3D mmu_notifier_clear_young(vma->vm_mm, addr,
                                      addr + HPAGE_PMD_SIZE);
    ...
}

Because addr is offset within the huge page, does the invalidation range
[addr, addr + HPAGE_PMD_SIZE) span past the end of the current huge page
and corrupt the access bits of the adjacent huge page?

>  	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
>  }

[ ... ]

> @@ -476,6 +479,9 @@ static bool damon_va_young(struct mm_struct *mm, unsi=
gned long addr)
>  		.hugetlb_entry =3D damon_young_hugetlb_entry,
>  	};
> =20
> +	/* Arch helpers can derive a page range from @addr; align it down. */
> +	addr =3D PAGE_ALIGN_DOWN(addr);
> +

[Severity: High]
This is a pre-existing issue, but does the PTE loop in
damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() incorrectly
skip unrelated PTEs for large folios?

In these PMD entry callbacks, the advancement relies on
folio_nr_pages(folio):

mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
    ...
    nr =3D folio_nr_pages(folio);
    ...
    pte +=3D nr;
    addr +=3D nr * PAGE_SIZE;
    ...
}

If the iteration starts on a tail subpage of a large folio (for example, if
the region boundary r->ar.start lands in the middle of a folio), the
remaining pages of that folio in the current PMD are fewer than
folio_nr_pages(folio). By advancing by the full folio_nr_pages(folio),
will this overstep the end of the folio and silently skip subsequent,
unrelated PTEs?


[Severity: High]
This is a pre-existing issue, but does damos_madvise() miscalculate the
range when region boundaries are not page-aligned, potentially applying
actions to memory completely outside the target region?

The boundaries are calculated using PAGE_ALIGN:

mm/damon/vaddr.c:damos_madvise() {
    ...
    unsigned long start =3D PAGE_ALIGN(r->ar.start);
    unsigned long len =3D PAGE_ALIGN(damon_sz_region(r));
    ...
}

If a region spans from 0x10005 to 0x11000 (size 0xFFB), start
becomes 0x11000 and len becomes 0x1000. The resulting do_madvise()
range is 0x11000 to 0x12000. Will this completely miss the target
region (which ends at 0x11000) and incorrectly apply destructive actions
like MADV_PAGEOUT or MADV_FREE to the page entirely after the region?

>  	damon_va_walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
>  	return arg.young;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831221151.5056=
1-1-zcgao@amazon.com?part=3D1
