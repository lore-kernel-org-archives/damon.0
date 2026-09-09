Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1735F172
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934658; cv=none; b=pAzgebjazG0PVmrrBZ6QJPdNh4KNC80iaaEAsCmmdAtIyJsE22fBWC1452An74vznlCQnvr67S8Rx/ZT5V2glDYnfS/EBbZsMKZi2bi60fqQis5oQVt0YLIbKTM7ysg6McQZrXBxbwo0xUzne+fFTEpo1bZMuGB4NcWjI5n86LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934658; c=relaxed/simple;
	bh=+4BMWL3jHWCRHOJEOwN7zNxb1o6BHlT2+AtyspitgiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+L2H/fzv7vqaseZ7dtD2qP4RUG+MKDwg0efw+ohsYLV+cvuJmf2LZY8kpWQote/1mlXzpJrD7beTAtWrxA1CltsW0cV+7iDAhfDI80P07MpJwi+xTe8f3ZL1ih4PEERpimPol4b+10PFNcCQrLqCwDLdbFE2kCTHCqbYOQ5mNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD5aDTjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD5aDTjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6830A1F00A3A;
	Wed,  9 Sep 2026 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788934656;
	bh=DH7TbrhDGK/ICV/O+z/IL+NLFnZ9ZVe8cY0OnrVpGm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OD5aDTjEuxG5FajddYvEU0OZsfZiXDK7wr5QGMSrxEa3imZSF+ncpjKak3fwIFr1k
	 9XX7HBf7aD2o/8ybI4qc1F0vgrNBlc7ams6hVBvCGfy0Z3vbj9EYdzYqIL5iBTwP5S
	 v+IazVGB7zD+qx8qxfmRe+2RIf4/SDqzamAXYUSDY3S4hIrAvftYemM4unmoEyxJBe
	 TnmZl94uCPHRtmHeLy73vF0CHcehXx3/4FkartFFZyjudiKoCSyykBbeedHx2TTrw1
	 NthatMgVIqmJJzFpX0+cOUrxmObQT/mqo1wG0wGdjlu9uGRmUTy1r3ZvAlpo3FBtKm
	 ux9oCprqpIMOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/vaddr: drop last same folio access
 check optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909060736.273661-1-sj@kernel.org>
References: <2026090859-trouble-fanatic-b990@gregkh>
 <20260909060736.273661-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:17:35 +0000
Message-Id: <20260909061736.6830A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless PMD read without pmdp_get_lockless() causes torn reads on=
 architectures with non-atomic PMD accesses.
--

commit 9322a55f3a2ea66cbeb4b3b0525204fccdd0b8a4
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/vaddr: drop last same folio access check optimization

This commit drops an optimization in DAMON's virtual memory access check
that reused results if the region fell within the last checked page. The
optimization was removed because it could race when multiple kdamonds are
running and its actual impact was questionable.

Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index dbb0f0fb2e598..bc0034b235d83 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -545,10 +544,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigne=
d long addr,
>  			goto huge_out;
>  		if (pmd_young(*pmd) || !page_is_idle(page) ||
>  					mmu_notifier_test_young(walk->mm,

[Severity: High]
This is a pre-existing issue, but does the lockless PMD read earlier in
damon_young_pmd_entry() risk torn reads on architectures with non-atomic PMD
accesses?

In the THP check, the code performs a direct dereference:

	if (pmd_huge(*pmd)) {
		ptl =3D pmd_lock(walk->mm, pmd);

If a torn read occurs (e.g., on 32-bit architectures with 64-bit page table
entries like ARM LPAE or i386 PAE) while concurrent huge page operations li=
ke
THP collapse or split are happening, pmd_huge() might misidentify a huge PMD
as a regular PMD.

> -						addr)) {
> -			*priv->page_sz =3D ((1UL) << HPAGE_PMD_SHIFT);
> +						addr))
>  			priv->young =3D true;
> -		}
>  		put_page(page);
>  huge_out:
>  		spin_unlock(ptl);
> @@ -567,10 +564,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigne=
d long addr,
>  	if (!page)
>  		goto out;
>  	if (pte_young(*pte) || !page_is_idle(page) ||

[Severity: High]
This is also a pre-existing issue, but does the regular page fallback path
have the same torn read vulnerability?

Just before this block, the code directly dereferences the PMD again:

	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
		return -EINVAL;
	pte =3D pte_offset_map_lock(walk->mm, pmd, addr, &ptl);

If the execution falls through to pte_offset_map_lock() due to a torn
read misidentifying a huge PMD as regular, it would attempt to map the huge
page's physical memory as a page table. Dereferencing this could trigger
memory corruption or a machine check exception on non-existent memory.

Should these accesses be using pmdp_get_lockless() to ensure atomic reads?

> -			mmu_notifier_test_young(walk->mm, addr)) {
> -		*priv->page_sz =3D PAGE_SIZE;
> +			mmu_notifier_test_young(walk->mm, addr))
>  		priv->young =3D true;
> -	}
>  	put_page(page);
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909060736.2736=
61-1-sj@kernel.org?part=3D1
