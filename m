Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C61E98E3
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318864; cv=none; b=SJAUDj8EcDlW14Qdu4y+/Qs6xe+poua/fZV0diookWMJcYhcZ0muYj3P8sqVZaDrPdNP45yrSaNF18kiz2nbNHpOiA1uezo9XGJBKRPAo7RuHGoNadFP7WaWa45kT03WSxT9OvXNU5l66kZqlH993oAu9hCz1xsjVtdoLIhpx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318864; c=relaxed/simple;
	bh=8kJgcByVgpex5n9mK8h279g35x+Tt7YK5Tdzb0JLtK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKuMebz58Dxks+qp3eBCG2TalFYi8Kdl1VscFUsy7dV6cOi6icuQV7umP/9+ySc/rOq+p4+sRol15Tak7i85HVmPoLiROe59v3E2HO6IQIgNFmR8aK4Arwm7gR2BL6GAnKTRXi2MxFYTkdYFxtdg2k4ac95Zlqbbc1jee5cI8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU71/5s7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU71/5s7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD24A1F000E9;
	Wed,  2 Sep 2026 03:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318862;
	bh=WJ1O6CMdb1Y8KRZ4aGdDX9F59n+ldEqog5Mp9EPYtg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PU71/5s7TuzAeyky+paSTyn2kYAW9YGB33V23VDG7f7+HWDLk5t/Eo3vpwzjKFU6s
	 hYwhuyUZ3bKRf1wTFxIxstdKooO1dfndc6TTrqjPrPi1CQB+LwAZ5EbtEdbX80fiVG
	 9gtZyZ2tL9MX909CbJa5PdYZeB+anGv3GQ8dSR0YYh8sA89zWS/SyEaGv5PCNCd53k
	 p3EYqSxb5gvQeQsVpmjIkA9vxSOcTAAuHQu6SWU/7Jy3ahwZ9U/acfx5hR5Hwa0Hzl
	 Tol/NCTEkwowiKkPAKYYuURAl+naZ4PBnKdE8zHkPPBClYkoYbMT9vdu8P8qSvqcTn
	 xDCyqKp+iSuIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon: move damon_hugetlb_mkold() from vaddr
 to ops-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902025700.17975-2-kiyer@crusoe.ai>
References: <20260902025700.17975-1-kiyer@crusoe.ai>
 <20260902025700.17975-2-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:14:22 +0000
Message-Id: <20260902031422.AD24A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Non-atomic read-modify-write of huge PTE in damon_hugetlb_mkol=
d clobbers hardware-updated dirty bits.
- [High] Unaligned addresses in DAMON mkold functions cause incorrect secon=
dary MMU aging.
--

commit c27851bf8f97112ca3d3c8258d2ecf636424ff88
Author: Krishna Iyer <kiyer@crusoe.ai>

mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common

This commit moves the damon_hugetlb_mkold function from the virtual address
space monitoring operations set to the common operations set. The physical
address space monitoring operations set will now be able to use it to
support access monitoring of hugetlb-backed memory.

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
> +	}

[Severity: Critical]
This is a pre-existing issue, but does this non-atomic sequence overwrite
the PTE and silently clobber concurrent hardware updates to the dirty bit?

In damon_hugetlb_mkold(), the entry is read via huge_ptep_get(), manually
cleared of the young bit with pte_mkold(), and unconditionally written back
with set_huge_pte_at(). A hardware update to the dirty bit occurring between
the read and the write could be lost. If the dirty bit is overwritten with a
stale clean copy, data could be reclaimed and lost instead of being written
back.

> +
> +	if (mmu_notifier_clear_young(mm, addr,
> +				     addr + huge_page_size(hstate_vma(vma))))

[Severity: High]
This is a pre-existing issue, but could passing an unaligned addr to
mmu_notifier_clear_young() cause incorrect secondary MMU aging?

When mmu_notifier_clear_young() receives a range that crosses page
boundaries due to an unaligned start address, the secondary MMU (such as
KVM) may age multiple adjacent host pages instead of just the target page.
This would corrupt working set statistics for adjacent pages and lead to
incorrect memory management, like reclaiming hot pages.

This unaligned addr behavior appears to originate from damon_rand() and is
also present in damon_ptep_mkold() and damon_pmdp_mkold().

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902025700.1797=
5-1-kiyer@crusoe.ai?part=3D1
