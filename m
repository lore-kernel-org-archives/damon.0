Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A1380FF4
	for <damon@lists.linux.dev>; Sun,  7 Jun 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840818; cv=none; b=MNlXCPWtbJPHzkCVolOyrSoYR0GgLUkLFzcS5auY8lsNVIqVNG06DfGgAUgHAzpHZo70PP0093BjXie2WpskBhzM84HAFiXsnIowpYVZKKdjYbWMOxixACqVMoi0oJAxdBPxUflzLr9irX0Y5WFlnYuRIiZBG+BibP1B1Byp75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840818; c=relaxed/simple;
	bh=YRt3HI8ieIHP3qdibSnMyP/Rf/vHQJ+Fht08ALRkmCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l1hvjo2BW/geqiqVo5q2ii5FJQInak4LtDL0mJbIMI7XHni4HNuprzMxYJ+Ox4IgUlBlG751nikkwbZ3GL1or2HPP49b4/H2pillMCqWYX7sOz68b83DG4Ke/WKniHIu3HLo3vB2ain3d9phujoHX3x/ksVXTFiMIKyb/zFwgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuEji9WE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuEji9WE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191771F00893;
	Sun,  7 Jun 2026 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780840817;
	bh=KcVViYXgpWt5B4rrv55dPN7YwNJTj0HdLfLWVvTVobI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OuEji9WEwRqp6iC1xaLIvg2VKyInCqwiTb85FWm24R+LNKFWjt2kMOLn+tg1ngA/I
	 Ol6c71tXeFJ29mOlInWHA3ZLUx47RzKlO8EBhb+tKIRGkDmdLFYWigNPNVzlrhClSB
	 PeDZbVN4kQlxvcN8KaN+y/Tn+iHvHb3WLe0t3bTENuS2aN8XGZDDA7MknfcoA+yKnW
	 faWqKjxJXKeVhqs1yvN0eA1PCxZbBukJAgrTHlvamXW8WziO2j5N4wcVMEJAsEq703
	 oozET1bKCTDJyasDZ0D3a638JQRvD9+Ngiji2x/sQtA1x+w/8l5g8TMPFzXfRDykMw
	 cjBENPykO/30A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: drop redundant mmap_read_lock from
 damon_va_three_regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunlong Li" <shenxiaogll@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260607-rcu-v1-1-3c9f5995a3a0@gmail.com>
References: <20260607-rcu-v1-1-3c9f5995a3a0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 14:00:16 +0000
Message-Id: <20260607140017.191771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unsafe lockless VMA iteration exposes `SLAB_TYPESAFE_BY_RCU` freel=
ist pointer corruption

Pre-existing issues:
- [High] Missing `check_stable_address_space()` validation during external =
`mm_struct` VMA iteration
--

commit fc1954fba1bc736b5f26aad51449f15c4774293c
Author: Cunlong Li <shenxiaogll@gmail.com>

mm/damon/vaddr: drop redundant mmap_read_lock from damon_va_three_regions

__damon_va_three_regions() already walks VMAs under rcu_read_lock(), so
the outer mmap_read_lock() is no longer needed.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b069dbc7e3d25..27e34596c43b8 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -77,7 +77,7 @@ static int __damon_va_three_regions(struct mm_struct *m=
m,
>  	struct damon_addr_range first_gap =3D {0}, second_gap =3D {0};
>  	VMA_ITERATOR(vmi, mm, 0);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to iterate over
the VMAs of an external mm_struct here without first checking
check_stable_address_space(mm)?

If the target address space becomes unstable (for example, due to an OOM
reap or a failed dup_mmap()), the maple tree may contain XA_ZERO_ENTRY
markers and the mm is flagged MMF_UNSTABLE.

Without validating the address space, could the maple tree iterator
return XA_ZERO_ENTRY as a VMA pointer and lead to a kernel panic when
vma->vm_start is dereferenced?

>  	struct vm_area_struct *vma, *prev =3D NULL;
> -	unsigned long start;
> +	unsigned long start =3D 0, last_vma_end =3D 0;
> =20
>  	/*
>  	 * Find the two biggest gaps so that first_gap > second_gap > others.

[ ... ]

> @@ -140,9 +141,7 @@ static int damon_va_three_regions(struct damon_target=
 *t,
>  	if (!mm)
>  		return -EINVAL;
> =20
> -	mmap_read_lock(mm);
>  	rc =3D __damon_va_three_regions(mm, regions);
> -	mmap_read_unlock(mm);

[Severity: High]
Does removing this mmap_read_lock() expose the VMA iteration to
SLAB_TYPESAFE_BY_RCU freelist pointer corruption?

Since the VMA slab cache is created with SLAB_TYPESAFE_BY_RCU, a VMA can
be freed while an RCU reader is still accessing it. When this happens,
the SLUB allocator overwrites the first word of the structure with its
freelist pointer (vm_freeptr).

Because vm_freeptr is in a union with vm_start and vm_end, locklessly
reading vma->vm_start from a recently freed VMA in
__damon_va_three_regions() will yield an unvalidated kernel freelist
pointer instead of a valid address.

Could subtracting prev->vm_end from this corrupted pointer cause massive
arithmetic underflows, tricking DAMON into tracking bogus memory regions?

> =20
>  	mmput(mm);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607-rcu-v1-1-3=
c9f5995a3a0@gmail.com?part=3D1
