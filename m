Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44052311C35
	for <damon@lists.linux.dev>; Wed, 27 May 2026 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890533; cv=none; b=SVfMqTenzwvRVwa+4uTn3ctxyxYAQ9+CPp3SDbEOlelfszOwSvHS4mk142gqQlsEkf5wyGwcgz6nYkds9uLsSJEt9VVl1tpLsDyUxW1p8kHAcahMvlqFuWgHw48dkADhJeXIWkx7xw4mRAJgM7LPYpvyLAqUprWNQ2vm0t6pWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890533; c=relaxed/simple;
	bh=/bmGRa8uoSStF79McGx39SOsjjwWqOhl0fRRtnKE82M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NpZHb7YSyUqHdEsTXiPa31C+KVwhr38VY+0cngCHLSfBzsZxb747HeDEigQprQ5zdG0qPyB7ablv9pBDCgCMzbQwWPjpzzag11cELH1kD3Qn9oenXVsF7NuCBtJgODVmku5IM8ohwjWIT5HdW49VEQBYdA4gzHOno1yt1MeFRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUCumBBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUCumBBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AAA1F00A3D;
	Wed, 27 May 2026 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890531;
	bh=FkgMOAum7PqDzTK7rKLD/xMr/ND7i1PXGTLXoWRRlSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUCumBBzTerO4N9zhC728UGgQg5B81cHjd6qHqd9/ml/JytxO3Isz3pSBC2X//JCe
	 TOymJU/1GHc+26aijr6LHfY4bi7gW0S0CxGvg38X4wUCrj10Gg3zh+0HlseU1Q4g4C
	 zIoa/XvFiIa1DBJhAF8QygiBl/O1iAHoJHqIi4EFVeZ+1Fw4/SoFivo4bLzfGCWYf4
	 5GcJuwlB+i2iOi15MTvmgYO7/c/KOReTZ+7QU1OskJ315cfex+sI5vlqEhNHlxqs7a
	 1P17tyHlCoXjhy6rS7VdESN5HQl1JRtOL7iAcW5CuBo9x81IoVIxs8L78vAwQSGmtu
	 HfRNKmQsnBqCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] mm: prepare rmap infrastructure for ANON_VMA_LAZY
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-9-tao.wangtao@honor.com>
References: <20260527110147.17815-9-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:01:58 +0000
Message-Id: <20260527140159.53AAA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Race condition and missing synchronization in `anon_vma_lazy_l=
ock_read()` and `anon_vma_tree_lock_write()` for lazy VMAs.
- [Critical] Ignored return value of `vma_get()` in `anon_vma_lazy_lock_rea=
d()` leads to Use-After-Free and refcount underflow.
- [High] Off-by-one boundary check in `anon_rmap_iter_first_vma()` causes f=
alse positive VMA overlap detection and out-of-bounds page table accesses.
--

commit 411934596db1ffd0b45c2469ce0c285daaf6e6e1
Author: tao <tao.wangtao@honor.com>

mm: prepare rmap infrastructure for ANON_VMA_LAZY

Introduce ANON_VMA_LAZY helpers and prepare the anon_rmap and anon_vma_tree
infrastructure for the upcoming ANON_VMA_LAZY feature.

> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 9802bce926959..ebe9f3f61170d 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h

[ ... ]

> @@ -1015,8 +1047,17 @@ static inline struct vm_area_struct *anon_rmap_ite=
r_first_vma(
>  	anon_rmap_t anon_rmap, unsigned long start, unsigned long last,
>  	struct anon_vma_chain **avc)
>  {
> -	struct anon_vma *anon_vma =3D anon_rmap_to_anon_vma(anon_rmap);
> +	struct anon_vma *anon_vma;
> +
> +	*avc =3D NULL;
> +	if (!anon_rmap_is_anon_vma(anon_rmap)) {
> +		struct vm_area_struct *vma =3D anon_rmap_to_vma(anon_rmap);
> =20
> +		if (vma->vm_pgoff + vma_pages(vma) < start || vma->vm_pgoff > last)
                                                    ^^^^^^

[Severity: High]
Does this off-by-one boundary check cause false positive VMA overlap detect=
ion?

It looks like the exclusive end check uses < start instead of <=3D start.
If a folio's start offset is exactly at the VMA's exclusive end, this check
evaluates to false, incorrectly implying the folio overlaps with the VMA.

The iteration would then yield the non-overlapping VMA to rmap_walk_anon(),
which passes the offset to vma_address().

Because the offset is outside the VMA bounds, vma_address() calculates an
address >=3D vma->vm_end and returns -EFAULT. This triggers
VM_BUG_ON_VMA(address =3D=3D -EFAULT, vma) in rmap_walk_anon().

> +			return NULL; /* No overlap in the VMA range. */
> +		return vma;
> +	} else
> +		anon_vma =3D anon_rmap_to_anon_vma(anon_rmap);
>  	*avc =3D anon_vma_interval_tree_iter_first(&anon_vma->rb_root, start, l=
ast);
>  	return *avc ? (*avc)->vma : NULL;
>  }

[ ... ]

> diff --git a/mm/internal.h b/mm/internal.h
> index 639f9c287f4c2..6b703646f66db 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h

[ ... ]

> +/*
> + * ANON_VMA_TREE_VMA is just a VMA, without anon_vma or anon_vma_chain,
> + * so no protection is needed.
> + */
>  static inline void anon_vma_tree_lock_write(anon_vma_tree_t anon_tree)
>  {
>  	struct anon_vma *anon_vma =3D anon_vma_tree_anon_vma(anon_tree);
> =20
> -	anon_vma_lock_write(anon_vma);
> +	if (anon_vma)
> +		anon_vma_lock_write(anon_vma);

[Severity: Critical]
Can this missing synchronization lead to a use-after-free of page table pag=
es?

Here, anon_vma_tree_lock_write() acts as a no-op for lazy VMAs.
In mm/rmap.c, anon_vma_lazy_lock_read() only increments vm_rcuref via vma_g=
et()
without acquiring any synchronization locks.

Consequently, operations that traverse page tables (like rmap_walk_anon()) =
run
completely lockless and concurrently with page table structural changes like
vma_adjust_trans_huge() in __split_vma() or VMA teardowns in free_pgtables(=
).

vma_get() doesn't prevent free_pgd_range() from unmapping and freeing the p=
age
tables. This allows page tables to be freed while page_vma_mapped_walk() is
traversing them, which can lead to a use-after-free of page table pages.

>  }
> =20
>  static inline int anon_vma_tree_trylock_write(anon_vma_tree_t anon_tree)

[ ... ]

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 58f470e0c3ffd..d13395a082c60 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> +static void anon_vma_lazy_lock_read(struct vm_area_struct *vma)
> +{
> +	vma_get(vma);

[Severity: Critical]
Is it safe to ignore the return value of vma_get() here?

vma_get() returns NULL if the VMA's reference count is already zero, indica=
ting
it is scheduled for freeing.

Because this failure is ignored and the function returns void, callers like
anon_rmap_lock_read() might proceed to traverse a dying or freed VMA, assum=
ing
the lock and reference were successfully acquired.

This can lead to a use-after-free when accessing VMA fields.

Additionally, anon_vma_lazy_unlock_read() will later call vma_put(), which
invokes rcuref_put() on an already-zero refcount, causing a refcount underf=
low
and potential double-free of the VMA memory.

> +}
> +
> +static bool anon_vma_lazy_trylock_read(struct vm_area_struct *vma)
> +{
> +	return (bool)vma_get(vma);
> +}
> +
> +static void anon_vma_lazy_unlock_read(struct vm_area_struct *vma)
> +{
> +	vma_put(vma);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D8
