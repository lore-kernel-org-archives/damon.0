Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC74FDE4F
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801375; cv=none; b=a+Mk1TF21tUKsC1IuB667p4IlLeyONPuhQXU8Uo+sl2Dn8IXZn9q4JFmEcjGerCrKsAZZM2dGv0Yj6cjN+Bvw1XIZWCJxQieS+zlN7s7nYs7mswux8fUsan35OCW7+iYmhBrAfBfqn0+UKi0lFJYPC6YLtZoQ5gpx0OdSMnTirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801375; c=relaxed/simple;
	bh=bdFKptNY+l9ekBWzQLQ6eXjGOlNDnnc8BbKfjYweZik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPt/iIkFOt+/huHGS+Q2s9Cnklyqin3ol4ibOtBaNaXucVaFgy+GXpwaOH54DkHO7+xxXa5YB5Mchy0ybe5iUoXuUN/oYdZR2Zjds+BXpghdB5gCvBqqQ2YeaT4mnp+d370LQbPz4moHqr6lEP99OwTV4nuGMhHIn9rKWdYsW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alp0nWeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alp0nWeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09B11F00A3A;
	Mon,  7 Sep 2026 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801373;
	bh=SHTpT3Cb9NIpo2TEZrdqd10Lsb8fCqctKgmmYqgLTh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Alp0nWeLTl1OnWtdoE29fD9PdB6PHeP+vv9g4hXhu5Vrq+3KmaHBSRE+E/tDfYSIC
	 9evDNzdGblSx9MIDvYm6DuLBTPQZzaVINOz59XxT8bpsdiIfHHnnO7YhaApC/4F1Rv
	 ooPV04vvgLi/DH0/jeUCu4/P5l/2Y+sM81Nz3nVog5gSI3aZhLB82mLeb4D9or1hN9
	 8Hl4nEaXqb8bQRC52LcY4pHmvvxJjqYihOOHNv45o+fBVfz0czl8ogqGtFQ4c/iceG
	 l+l2oMbp6LnoORjD+4509735uUSPE3DKZR0jJe47fUKol08xagGO+PGDALl1NHmNQp
	 BMN/yH7XbTPaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: avoid hw-driven pte updates during
 damon_hugetlb_mkold()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260907170358.100168-1-sj@kernel.org>
References: <20260907170358.100168-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 17:16:13 +0000
Message-Id: <20260907171613.A09B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying contiguous huge PTEs by clearing and re-setting without =
an intermediate TLB flush violates Break-Before-Make (BBM) rules on archite=
ctures like arm64, potentially causing fatal TLB conflict aborts.
--

commit 1fee0c4237cb61938cdabe61cd4adf713c7ddbec
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()

This commit attempts to prevent hardware-driven PTE updates (like dirty bit=
s)
from being lost during DAMON's mkold operation on hugetlb pages. It does th=
is
by replacing huge_ptep_get() with huge_ptep_get_and_clear() before calling
set_huge_pte_at().

Link: https://lore.kernel.org/20260830160545.98969-1-sj@kernel.org
Link: https://lore.kernel.org/20260906195417.103263-1-sj@kernel.org

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index f884d3f78f30a..91a0d441c1f94 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -283,22 +283,29 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsign=
ed long addr,
>  }
> =20
>  #ifdef CONFIG_HUGETLB_PAGE
> +static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
> +		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
> +{
> +	unsigned long psize =3D huge_page_size(hstate_vma(vma));
> +
> +	if (!pte_young(*entry))
> +		return false;
> +	*entry =3D huge_ptep_get_and_clear(mm, addr, pte, psize);
> +	*entry =3D pte_mkold(*entry);
> +	set_huge_pte_at(mm, addr, pte, *entry, psize);

[Severity: High]
Does this modification of contiguous huge PTEs violate Break-Before-Make (B=
BM)
rules on architectures like arm64?

By calling huge_ptep_get_and_clear() followed by set_huge_pte_at() without =
an
intermediate TLB flush, the hardware might cache conflicting contiguous TLB
entries, which could cause fatal TLB conflict aborts. On arm64,
huge_ptep_get_and_clear() clears the constituent PTEs but does not flush the
TLB. When set_huge_pte_at() is subsequently called, it skips its internal B=
BM
TLB flush because the PTEs were already cleared and its internal validity
check evaluates to false.

> +	return true;
> +}
> +
>  static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907170358.1001=
68-1-sj@kernel.org?part=3D1
