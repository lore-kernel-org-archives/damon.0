Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CE23BD1D
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417281; cv=none; b=g+N6I2Q8RznmQ48t+nUrOnpKUkms/pFhob2ryEZglKNu6e6XFGdNtktYp5erOn+vQeMicKgVFPFOohNpSKwmPk0gic0RIw19VHbZSucKXOuyBBqfERZkC9OlpYmdWRgFUlU8t51ukunLSPXhjapRP0S0GOSC1w+RPYxtRGkzDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417281; c=relaxed/simple;
	bh=vYOzdQm5PFossVGz7X7IwhykO+VLZr0JHByQ7ybNoeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iqt0LgVt0f/d6qTWBzTzAMQl2yDXXuEXjCU8fcxKiCKO+pWJqB++CoUvTt3bUIp5XRfIxYdDUS60TMK5l9zV4GwcOEGU1Cppt8HXpcDGUYG6ZMHJzqet7jRmdZ5eQOkxZ360K1BRlcHxbte4lcLgjrwfinRA1S7UQU9fJdYGm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjWg/Av4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjWg/Av4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A7E1F000E9;
	Tue,  7 Jul 2026 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783417280;
	bh=ktgJGEsiNzMTHojKqSVGdTi0wMFRYHX/okco6tSMyPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjWg/Av4RCGqgN/kYW5n8KaTc+aS/3rAPTIsx+EYH0eLwiq8pUlTi3xZ+d1/o/nfl
	 nVPtREbjJF9GjfMSUrWSwUdhxMBSPpPnFv/bnTcUzNv3HV0Jn2t5P7dS1d5kx6kBMJ
	 MV2ogVlSbkjUmn0MRcIZY9THo+oE67K2vHy9FZ5Yd6XuhSV3RZ0bkiGCf8D8MCHO6L
	 /EbeC5slhb/j2HjPy+Ykq7/3pwqIgylbfU6R8Ry1XJZKJ/By/6ioSqYrUc9cVx/5uL
	 n/JU9HvTMbiChTjqu+QwdfC7cb6OMdZvYKzq/HZX+UXhPWlxOUitJ2uJUIXcW6UjR3
	 LhF23ot+lIiBw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/13] mm: optimize rmap for ANON_VMA_FRACTAL
 with PVL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-12-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-12-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:41:18 +0000
Message-Id: <20260707094119.28A7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Use-After-Free of `mm_struct` in `vma_refcount_put()` due to dropp=
ed `mm` pin.
- [High] Per-VMA lock `vm_lock_seq` exclusion bypass in `trylock_leaf_vma_r=
map()`.
- [High] Lockless speculative access of `anon_nod->mm` risks dereferencing =
a freed pointer.
- [High] Use-After-Free of `anon_vma` on `folio_lock_anon_vma_read()` error=
 path.
- [High] `trylock_leaf_vma_rmap()` locks completely unrelated VMAs due to m=
issing `anon_vma` validation.
- [High] TOCTOU race due to missing VMA bounds re-validation after acquirin=
g the VMA read lock.
- [High] Valid zero-address VMAs silently fail the fast path and are ignore=
d by rmap iteration.
--

--- Patch [11]: [RFC PATCH v2 11/13] mm: optimize rmap for ANON_VMA_FRACTAL=
 with PVL ---
commit e9e971f63165144548b2891ce74a7cd4448a1490
Author: tao <tao.wangtao@honor.com>

mm: optimize rmap for ANON_VMA_FRACTAL with PVL
   =20
Leaf anon_nodes have no children, and a given address can belong to at
most one VMA. In this case, PVL can protect the rmap.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index d3677515fae92..0967ba2d2a466 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> @@ -1035,9 +1037,48 @@ void anon_node_lock_rmap(struct anon_node *anon_no=
d)
> =20
>  void anon_node_unlock_rmap(struct anon_node *anon_nod)
>  {
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* Corresponds to folio_lock_anon_vma_read(). */
> +	if (anon_rmap_is_leaf_vma(anon_nod)) {
> +		vma_refcount_put(anon_rmap_to_leaf_vma(anon_nod));

[Severity: High]
Can this cause a use-after-free crash by accessing an unpinned mm_struct?

In trylock_leaf_vma_rmap(), the original mm_struct is temporarily pinned
via mmget_not_zero(mm), but the pin is immediately dropped with
mmput_async(mm). It then checks vma->vm_mm =3D=3D mm and sets other_mm =3D =
NULL.

The caller folio_lock_anon_vma_read() sees other_mm =3D=3D NULL and returns
the tagged leaf VMA without holding any pin (via mmgrab()) on the
mm_struct. When the rmap operation completes, anon_node_unlock_rmap()
calls vma_refcount_put() here. Since the thread holds no reference to
the mm_struct, it can be freed concurrently. vma_refcount_put() then
accesses the unpinned mm_struct to call
rcuwait_wake_up(&vma->vm_mm->vma_writer_wait), which can crash.

> +		return;
> +	}
> +#endif
> +
>  	up_read(anon_node_rmap_sem(anon_nod));
>  }
> =20
> +static struct vm_area_struct *trylock_leaf_vma_rmap(
> +		struct anon_node *anon_nod, const struct folio *folio,
> +		struct mm_struct **other_mm)
> +{
> +	unsigned long pgoff_start =3D folio_pgoff(folio);
> +	unsigned long pgoff_end =3D pgoff_start + folio_nr_pages(folio) - 1;
> +	unsigned long addr =3D anon_node_rmap_address(anon_nod, pgoff_start);
> +	struct mm_struct *mm =3D anon_nod->mm;
> +	struct vm_area_struct *vma;
> +	int oldcnt;
> +
> +	if (anon_nod->nr_children)
> +		return NULL;
> +
> +	if (!addr || !mm || !mmget_not_zero(mm))

[Severity: High]
Is it safe to read anon_nod->mm locklessly under RCU?

The anon_node structure is allocated with SLAB_TYPESAFE_BY_RCU, meaning
the object itself can be freed and reused. However, the mm_struct it
points to is not RCU protected and can be completely freed and returned
to the allocator. Dereferencing the potentially stale mm pointer from
the SLAB-recycled anon_nod and passing it to mmget_not_zero() could
access unmapped memory or corrupt unrelated structures.

[Severity: High]
Does this unintentionally exclude valid VMAs mapped at address zero?

anon_node_rmap_address() can legitimately return 0 for an anonymous VMA
mapped at virtual address 0. Checking if (!addr) treats 0 as an error
rather than a valid address, which silently skips valid zero-address
VMAs for rmap walkers, hwpoison, and KSM.

> +		return NULL;
> +
> +	vma =3D vma_lookup(mm, addr);
> +	mmput_async(mm);
> +	if (!vma || vma_last_pgoff(vma) < pgoff_end)

[Severity: High]
Could this inadvertently lock a completely unrelated VMA?

This uses vma_lookup() to locate a VMA and returns it if it covers the
target offset, but fails to verify that the returned VMA's anon_vma
pointer matches the anon_nod, or even if the VMA is anonymous. If the
original VMA was unmapped and a completely unrelated VMA was mapped at
the exact same address, vma_lookup() will find it. This unrelated VMA
will be incorrectly locked and returned to the rmap walker, skipping
the true anon_vma tree and executing callbacks on the wrong VMA.

> +		return NULL;
> +
> +	if (!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> +						     VM_REFCNT_LIMIT)) {

[Severity: High]
Does this bypass the required per-VMA lock vm_lock_seq exclusion?

The per-VMA lock algorithm strictly requires a reader to increment
vm_refcnt and then verify that vma->vm_lock_seq !=3D mm->mm_lock_seq to
ensure no writer is currently locking the VMA. This successfully grants
the VMA read lock purely by incrementing vm_refcnt, failing to perform
any vm_lock_seq exclusion checks. A reader will incorrectly proceed even
if a writer holds the VMA lock, leading to potential data corruption as
the rmap walker accesses page tables concurrently with structural VMA
modifications.

[Severity: High]
Is there a time-of-check to time-of-use race here?

vma_last_pgoff(vma) < pgoff_end is checked locklessly under RCU just
before this. Between that check and the increment of vm_refcnt to
acquire the read lock, a concurrent writer could modify the VMA. Because
this function fails to re-check the VMA bounds after locking, the rmap
walker might receive a locked VMA that is too small and no longer covers
the required address range, resulting in out-of-bounds page table
accesses.

> +		return NULL;
> +	}
> +
> +	*other_mm =3D (vma->vm_mm =3D=3D mm) ? NULL : vma->vm_mm;
> +	return vma;
> +}

[ ... ]

> @@ -1156,9 +1208,8 @@ struct anon_vma *folio_lock_anon_vma_read(const str=
uct folio *folio,
>  	}
> =20
>  	if (!folio_mapped(folio)) {
> -		rcu_read_unlock();
>  		put_anon_vma(anon_vma);
> -		return NULL;
> +		goto out;

[Severity: High]
Will this leave the caller with a freed anon_vma pointer?

In this fallback path, if down_read_trylock() fails and
!folio_mapped(folio) is true, the code calls put_anon_vma(anon_vma).
The original code correctly returned NULL at this point. By replacing
this with goto out, it falls through to return anon_vma without setting
anon_vma to NULL. The caller receives a non-NULL pointer, falsely
assuming the read lock was acquired, and will operate on the unpinned
and potentially freed anon_vma object.

>  	}
> =20
>  	/* we pinned the anon_vma, its safe to sleep */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D11
