Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43237B022
	for <damon@lists.linux.dev>; Wed, 27 May 2026 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884120; cv=none; b=bE/g27wr/fiow3TkNvxM2rqI6Be17QCYVJg7N6z4Zjllfwy68ED61gV2Ph1xm/FdJlt5lc3TPY/5xPA1BAMqhTJPjkn75iZ1FbrkbrYB9G2eFEcvHIUO96zudNH88lFuaQN05wM/Lzxk2CbKQWIZdsU1Kfx/9+GpS4LWbgnAjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884120; c=relaxed/simple;
	bh=63dt0qmsjeq7KdMWP+HLW9/WjzemDIGW9E4l6ZdogD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kt5itBnO4iLO60dVJVHT2DMs/1x5VUX547XG5QDXE7uaVTLdHQ+TIajQFA6kXEMvGjHv3Xp92YJObOkGF31RznhbGN88Q6/rI4oSHiG1piS6hTgsfDeibTDZ+28PhYJwptDDITs5dmrJ/fEOVqAo7ZsF7yIrrVt8i3GxU7U7+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnO5GtbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnO5GtbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C9A1F00A3A;
	Wed, 27 May 2026 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779884119;
	bh=TpJOb39Qj7QK5094zeDoDJWtEiXZXf6zCwbFZdxen3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DnO5GtbWPjjbF++bX28lAcpltzPXyeTJlIuGg4YYn2t20rRkBFwesaciQFbXNnVlk
	 /tUAfJV6njSsCqTn1UQhzeMQZd7BOGcJBVD3SyAM5lGwkvozQDww983R2qDKrbNDu/
	 pSQ2leef1A6imXb8eKjZy4uOYMjj/6Vwd0kBqWdkUFLgB8r39Yurm5t9JtogS4Fz5s
	 AyqKCUzXCzo7FsHiSBpbF82YCp0iG6V3msr/OexdXzTKF9Yu5DOVFoUF+OwQ9k6ijy
	 +HFROrSyj33GXtrCVqkIIwHuZnCQHz9R0UBTP/RBHwRmp+ZYB3ENzGgidl/jGwEY8v
	 yXUXh+3amaqlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] mm: implement ANON_VMA_LAZY rmap semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-10-tao.wangtao@honor.com>
References: <20260527110147.17815-10-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:15:18 +0000
Message-Id: <20260527121518.E2C9A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Lockless reverse mapping walk on `ANON_VMA_LAZY` VMAs allows c=
oncurrent VMA modification and page table teardown.
- [High] Accessing `vma->vm_mm` from a potentially recycled `SLAB_TYPESAFE_=
BY_RCU` VMA before taking a reference leads to a Use-After-Free on `mm_stru=
ct`.
- [High] Returning an unreferenced VMA pointer after dropping RCU leads to =
Use-After-Free.
- [High] Unconditional failure in `folio_resolve_anon_vma_lazy()` due to co=
ntradictory `!vma->anon_vma` check.
- [High] Relying on `folio_mapped()` to validate the lifetime of a VMA poin=
ter is fundamentally flawed.
- [High] Erroneous `vma_put()` calls in `folio_resolve_anon_vma_lazy()` lea=
d to double-puts.
--

commit acc9d61dcacaf3e8fb34a6c2e79278b552eb5328
Author: tao <tao.wangtao@honor.com>

mm: implement ANON_VMA_LAZY rmap semantics

This commit implements reverse mapping semantics for ANON_VMA_LAZY VMAs by
updating various rmap resolution functions to resolve the target VMA via
its root_vma pointer.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index d13395a082c60..12693c6897120 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> +static struct vm_area_struct *folio_resolve_anon_vma_lazy(
> +	const struct folio *folio, bool tryget, bool test_map)
> +{
> +	struct vm_area_struct *vma, *anon_lazy_root;
> +	struct mm_struct *mm;
> +	unsigned long anon_mapping;
> +	pgoff_t pgoff;
> +	unsigned long addr;
> +
> +	anon_mapping =3D (unsigned long)READ_ONCE(folio->mapping);
> +	if ((anon_mapping & FOLIO_MAPPING_FLAGS) !=3D FOLIO_MAPPING_ANON_VMA_LA=
ZY)
> +		return NULL;
> +	if (test_folio_unmapped(folio, test_map))
> +		return NULL;
> +
> +	anon_lazy_root =3D vma =3D (struct vm_area_struct *)(anon_mapping -
> +		FOLIO_MAPPING_ANON_VMA_LAZY);

[Severity: High]
Is it safe to rely on folio_mapped() to validate the lifetime of this VMA
pointer?

If a VMA is merged into another VMA, the original VMA structure can be freed
while the folio remains mapped in the new merged VMA.

In this case, test_folio_unmapped(folio) returns false since it is mapped,
but the vm_area_struct pointed to by anon_mapping has been freed. Does this
lead to a use-after-free when accessing its fields below?

> +	mm =3D vma->vm_mm;

[Severity: High]
Could this dereference a freed mm_struct?

VMAs are allocated with SLAB_TYPESAFE_BY_RCU. Here, mm =3D vma->vm_mm is re=
ad
before validating the VMA via vma_get(anon_lazy_root).

If the VMA was concurrently freed and recycled to a new process, vma_get()
will succeed on the newly recycled VMA. However, the mm variable will hold
the mm_struct of the previous owner, which is not protected by RCU and may
have been freed.

The code then proceeds to call vma_lookup(mm, addr) below. Could this cause
a use-after-free?

> +	if (!mm || !vma->anon_vma || !vma_get(anon_lazy_root))
> +		return NULL;

[Severity: High]
Does this logic unconditionally fail for ANON_VMA_LAZY VMAs?

The commit message explicitly states that ANON_VMA_LAZY VMAs "do not have an
anon_vma or anon_vma_chain".

Because vma->anon_vma is expected to be NULL for these VMAs, the
!vma->anon_vma check will always evaluate to true, unconditionally aborting
the resolution and returning NULL.

> +	pgoff =3D folio->index;
> +	if (vma_address(vma, pgoff, folio_nr_pages(folio)) =3D=3D -EFAULT) {
> +		addr =3D vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +		vma =3D vma_lookup(mm, addr);
> +		if (vma && tryget && !vma_get(vma))
> +			vma =3D NULL;
> +	}
> +	if (!tryget || anon_lazy_root !=3D vma)
> +		vma_put(anon_lazy_root);
> +	if (test_folio_unmapped(folio, test_map) && vma) {
> +		vma_put(vma);
> +		vma =3D NULL;
> +	}

[Severity: High]
Could this result in a double-put and refcount underflow on the VMA?

If tryget is false, the code calls vma_put(anon_lazy_root) to drop the
single reference acquired via vma_get() earlier.

Later, if test_folio_unmapped() returns true, it executes vma_put(vma). If
vma equals anon_lazy_root, does this drop the reference a second time?

> +	return vma;
> +}

[ ... ]

> +static struct vm_area_struct *folio_lock_anon_vma_lazy_read(
> +	const struct folio *folio, struct rmap_walk_control *rwc, bool test_map)
> +{
> +	struct vm_area_struct *vma =3D NULL;
> +
> +	rcu_read_lock();
> +	vma =3D folio_resolve_anon_vma_lazy(folio, true, test_map);
> +	rcu_read_unlock();
> +	return vma;
> +}

[Severity: Critical]
Does this allow concurrent VMA modifications while performing a reverse
mapping walk?

Standard anonymous rmap walks hold the anon_vma lock to protect against
concurrent modifications (e.g. split, merge, munmap). This function only
elevates the VMA refcount via vma_get().

While this prevents the VMA structure itself from being freed, it provides
no structural locking. This allows concurrent writers holding mmap_write_lo=
ck
to alter vm_start/vm_end or free the page tables while the rmap walk is
actively scanning them.

Can this result in data races and use-after-free on the page tables?

>  static anon_rmap_t folio_anon_rmap(const struct folio *folio)
>  {
>  	struct anon_vma *anon_vma;
> +	struct vm_area_struct *vma;
> +
> +	if (folio_test_anon_vma_lazy(folio)) {
> +		rcu_read_lock();
> +		vma =3D folio_resolve_anon_vma_lazy(folio, false, false);
> +		rcu_read_unlock();
> +		if (vma)
> +			return vma_to_anon_rmap(vma);
> +	}

[Severity: High]
Does this return an unreferenced VMA pointer that is no longer protected?

When tryget is false, folio_resolve_anon_vma_lazy() intentionally skips
taking a reference on the VMA. This function then releases the
rcu_read_lock() and returns this unprotected VMA pointer.

Since the VMA is no longer protected by RCU, a refcount, or any locks,
can it be freed concurrently before or during the rmap walk, leading to a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D9
