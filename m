Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DD28488F
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788067591; cv=none; b=bcZbQ+k45WEvnUxpRQTr3gpLiT4D9WQHknzoZKBUZf/ZrMUuJBdUk+tkeqEVWrSQLU3tGOJBLusqAOIt41eYMEhlQ37meRFdZnOr/UXNuLQgCNwGw7x7AJPtiFWgCP2QBMMerSToOFf6cQWIfFuE0bTwXEc1thgMfUz1YeeC638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788067591; c=relaxed/simple;
	bh=TMWl8K8BJ+W+7QddKiBDus2V1rSLdzgaDGC5OyNkZ9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sRE6YqqoqnRXZLtPf9OvMBjNug5oahljhCwbUZg0dRhb+aZb7YCHLlebuUdwXyLIbNNkkZqs4eA0p81f+SwFKzKqx1Dsw4HY7/2TNzIwDTqbsxFamJl00817Zq4BnNz/qdZXIKBtbzcEUQp4wQcnn6HYEDt5Ar1qqimXEAbmusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S40G3W9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S40G3W9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC44C1F000E9;
	Sun, 30 Aug 2026 05:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788067590;
	bh=QdYXfx/6VuhTIdgM/xhCXmRKmsHtVv95lB8Alikt+e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S40G3W9/9dKKEYM0rUDHqMtcWdhKv5FfgZUvyg/7kBaQkT7BNI7hUG9cR6Y2MOe4m
	 R0kNiYovrc4zqbqRY+F6crHx/5Be/K8Z5EQ3HStWdXlUTSejkLTJ3/UMLcSFbC4Asu
	 EwagdkOWI0Dy+lvIuVFbcBim3xeAHD/E0gorP+DstFC25KB9X7zHrnmmPkmOMK9h45
	 F7LiFkK5Jld8cUQDST5rT5tFy9Wm7ERH1H3iAdY+mQlJkzQ/EUY7tSIJ4jLgx38JHq
	 NYBLUgMzkoEZTPIHU0kZD/vPWepFnyLwwEj8iolhIVuIZhLbgxQYWBDlsiLHnjDOhb
	 6bXsaberkReaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] mm/damon: move damon_hugetlb_mkold() from vaddr to
 ops-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830051407.50008-2-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
 <20260830051407.50008-2-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 05:26:29 +0000
Message-Id: <20260830052629.CC44C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Non-atomic update of HugeTLB PTE in damon_hugetlb_mkold() over=
writes hardware-set dirty bits and triggers unintended BBM sequences.
--

commit a960b7ee57eac1d4fccc44af4918b4b8331a38a3
Author: Krishna Iyer <kiyer@crusoe.ai>

    mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
   =20
    damon_hugetlb_mkold() clears the accessed bit of a hugetlb-mapping huge
    PTE and propagates the aging to secondary MMUs via
    mmu_notifier_clear_young(), spanning the whole huge page size.  It
    currently lives in vaddr.c, and is thus usable only by the virtual
    address space monitoring operations set.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index fbda70d8ea4d0..f5fe92b825bbc 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

> @@ -98,6 +99,35 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struc=
t *vma, unsigned long addr
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  }
> =20
> +#ifdef CONFIG_HUGETLB_PAGE
> +void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
> +		struct vm_area_struct *vma, unsigned long addr)
> +{
> +	bool referenced =3D false;
> +	pte_t entry =3D huge_ptep_get(mm, addr, pte);
> +	struct folio *folio =3D pfn_folio(pte_pfn(entry));
> +	unsigned long psize =3D huge_page_size(hstate_vma(vma));
> +
> +	folio_get(folio);
> +
> +	if (pte_young(entry)) {
> +		referenced =3D true;
> +		entry =3D pte_mkold(entry);
> +		set_huge_pte_at(mm, addr, pte, entry, psize);

[Severity: Critical]
This is a pre-existing issue, but does this non-atomic update of the hugetlb
PTE overwrite hardware-set dirty bits?

The hardware MMU can set the dirty bit (on x86, or arm64 with hardware mana=
ged
dirty bits) between the huge_ptep_get() read and this set_huge_pte_at()
write. This non-atomic read-modify-write drops the hardware dirty bit, lead=
ing
to data loss upon reclaim or sync.

Additionally, on arm64, using set_huge_pte_at() on an already valid contigu=
ous
PTE triggers an unintended break-before-make sequence with a broadcast TLB
flush via clear_flush(), which causes severe performance regressions.

> +	}
> +
> +	if (mmu_notifier_clear_young(mm, addr,
> +				     addr + huge_page_size(hstate_vma(vma))))
> +		referenced =3D true;
> +
> +	if (referenced)
> +		folio_set_young(folio);
> +
> +	folio_set_idle(folio);
> +	folio_put(folio);
> +}
> +#endif	/* CONFIG_HUGETLB_PAGE */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830051407.5000=
8-1-kiyer@crusoe.ai?part=3D1
