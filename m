Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B6480DEE
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907071; cv=none; b=UB3YsLcufzbBS+t4fJHwxjJru2IyqCCT8vREaQaxt77C1VD505kop9zWFV/hg2nRD0k+wLB/dA6hJRnE+CV0hwcy50m+EDUvDIWEgoXg3+v+BhpcpZVBSUilMjSYGBUPBjZGm3bT5GKnByvB8zbb4ZhnjtcMitbpxtrmoQ2L1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907071; c=relaxed/simple;
	bh=1Wu5rh24vHwlZ1eMGHrZLQJNXqy9ToXv2JHiZg39lwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HD/KDZ4eACDZxvR0PKRw+cnYLb/7ps3uppwbGC2dFuuObAXn+mtv6S69uGkiTlk05TgTOsH8bmqny41rEPUCimFd/cLixiYhAulMVv0AefIVY9FAkWglgrTQVGZ5I002rTLRi3o7FoJyTLYEje1Hj+9OJamD/MQEoFDCY4fq+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdR2VRmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdR2VRmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9521F000E9;
	Wed,  1 Jul 2026 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907070;
	bh=EgnrxBMdFkl2fA+yhnA+KO3NZrkpeh9f8F2V9ose+l8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdR2VRmRWYXDZk/XmgM0pca5URPpqSllo1RckC+HHlmZL0bQCP2it5DWgadSkRh5r
	 xYclwKgV600tXOOzisPa3mF8BjhGlYhY7ZBmPuSSZUSbaEdje1nDtce937yMl9T3kx
	 gxjxSo9tZ9vcEr2wdMN541jF2y8Tx2baUSDX7Zz1uySKy5O2gkgrgIrr0n/88utzhz
	 gOOXVODeB4leG3cPj4iWmTOfvP1g6GHF8YkgNy9Ve/Bh3bKZBLk1x5DONK6jPUE3l9
	 EUUr2dyW2SAjsYBohU0IXcYquWi10/8YuCj4QvBUePtw7hVKEy5h/C5Z4KVWiIkFuv
	 RydMtoyLawlGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "wang lian" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701114716.56503-6-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
 <20260701114716.56503-6-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:57:49 +0000
Message-Id: <20260701115750.0A9521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoded 2MB chunk stepping and alignment skips folios, evaluates=
 out-of-bounds addresses, and inflates DAMON quota accounting.
- [High] Missing VMA validation allows `folio_walk_start` to interact with =
driver-allocated non-folio compound pages and hugetlb pages.
--

commit 5ba0b9e1345c425f2c1d50b6fcfb6b47ff6ed394
Author: Wang Lian <lianux.mm@gmail.com>

mm/damon/vaddr: implement DAMOS_SPLIT handler

This commit implements the vaddr operations layer handler for DAMOS_SPLIT.
It walks the target region and attempts to split any folios larger than
the scheme's target_order using split_folio_to_order().

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index eeaa403eb79e4..2dd268f037a4f 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -932,6 +932,71 @@ static unsigned long damos_va_collapse(struct damon_=
target *target,
>  	return applied;
>  }
> =20
> +static unsigned long damos_va_split(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr, end, chunk_sz;
> +	unsigned int target_order =3D s->target_order;
> +	unsigned long applied =3D 0;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	struct folio *folio;
> +	struct folio_walk fw;
> +
> +	mm =3D damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	chunk_sz =3D PAGE_SIZE << HPAGE_PMD_ORDER;
> +	addr =3D ALIGN_DOWN(r->ar.start, chunk_sz);
> +	end =3D ALIGN(r->ar.end, chunk_sz);

[Severity: High]
Does this alignment safely handle regions that do not start on 2MB
boundaries? By rounding down the start and rounding up the end to chunk_sz,
the loop in damos_va_split() may evaluate addresses outside the intended
damon_region bounds.

> +
> +	while (addr < end) {
> +		mmap_read_lock(mm);
> +		vma =3D find_vma(mm, addr);
> +		/*
> +		 * split_folio_to_order() supports both anon and shmem
> +		 * folios, so we accept any VMA that has a folio at @addr.
> +		 * This covers important use cases like tmpfs THP-backed
> +		 * KVM guest memory where cold and hot pages are bundled
> +		 * together in a single PMD THP.
> +		 */
> +		if (!vma || addr < vma->vm_start)
> +			goto unlock;

[Severity: High]
Are we missing VMA type validation here? This check accepts any VMA, which
can include VM_HUGETLB or driver-allocated VM_MIXEDMAP VMAs.=20

If the VMA is VM_HUGETLB, folio_walk_start() will use standard page table
accessors which can return garbage or crash. If it is a driver-mapped
compound page, folio_walk_start() will return a non-folio page, and
subsequent calls to folio_trylock() and split_folio_to_order() can derefere=
nce
uninitialized fields and corrupt driver state.

> +
> +		folio =3D folio_walk_start(&fw, vma, addr, 0);
> +		if (!folio)
> +			goto unlock;
> +
> +		if (folio_order(folio) > target_order) {
> +			if (!folio_trylock(folio)) {
> +				folio_walk_end(&fw, vma);
> +				goto unlock;
> +			}
> +			folio_get(folio);
> +			folio_walk_end(&fw, vma);
> +
> +			if (!split_folio_to_order(folio, target_order))
> +				applied +=3D chunk_sz;

[Severity: High]
Could this over-account the applied bytes? By unconditionally adding chunk_=
sz
(2MB) here, successfully splitting a smaller folio (like a 64KB mTHP) will
increment the applied counter by 2MB, artificially inflating the DAMON quota
accounting.

> +
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		} else {
> +			folio_walk_end(&fw, vma);
> +		}
> +
> +unlock:
> +		*sz_filter_passed +=3D chunk_sz;
> +		addr +=3D chunk_sz;

[Severity: High]
Does this loop inadvertently skip folios? By unconditionally stepping addr =
by
chunk_sz (2MB) on every iteration, any smaller folios inside this 2MB span
will be completely skipped by the loop in damos_va_split(). Should this step
by the actual folio size instead to ensure we process all folios?

> +		mmap_read_unlock(mm);
> +		cond_resched();
> +	}
> +
> +	mmput(mm);
> +	return applied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701114716.5650=
3-1-lianux.mm@gmail.com?part=3D5
