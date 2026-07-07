Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B143DEFF6
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419676; cv=none; b=oqYFawK/OkM6ydafcY5mQJDv/M9yyGA0DPatCjNg/QelKz+hxkrKNXhPKnvkMyJAcYAjE28KXBJ+cu6i01gf8YjIrCVvInuMjiINg3DKXyeGba7rFPtEOSIH9Tjgfxgx1HuJzvZdwetysEYDxtxEa+WgYhWtlPkNW2/HZHjgn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419676; c=relaxed/simple;
	bh=3sgA1DkmhxQ6olVOVX61eRx9j9FBPRD4rmXRuxXFUgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVoH5eanBjkpAvDrCGZ/oXmP9XJobbwA777zf4iKHvIRa9uiavQ7/EI3Q6qzgDP9vHkBYMRE7Sw3SSuLoAguyPr/7PrGZLGY0Dwp2FZjncoJ0FRLtOPnwP+orvfycKzCRQUMW2SFTShcmIG81ATy31uWHyfCW23nU4IMMAMwlxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiHyBBUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiHyBBUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B791F000E9;
	Tue,  7 Jul 2026 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419674;
	bh=Z9OfDVKzr4ZrX1K7LhOsw44W/Z+PAgI+CEXYxHpOpe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiHyBBURjgIjmk6RogkSw9r3nVtj04JB7F49gJifojfdKDoYZ//m7f/4k3ALTDAN1
	 TfQSiF5Zb2tgAyxeMojhUzuJNEZvWdhqC/BuNT6RfglD+Vp8+Xub64A9L7tsld44Dd
	 1IeKUGMKiE0K+Id43FfxsKKIXL9fAFedSTroZ1sPhJ30ViIQVxk/EKCr6moVXCaARB
	 SyTUpz25SJmdttlYvXSUidagyD2u6+HOUnmd81Lsr+bsdJQK0fuuLcM9kSWvONbzVY
	 fAFIEOqhfUVSBP9ed07ENKD5yxydz1QRv6gxIklNBf0MW0kKfWBix/neIWZq/IBVQg
	 qmPgbi96bMQxw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 13/13] mm: Enable CONFIG_ANON_VMA_FRACTAL by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-14-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-14-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:21:14 +0000
Message-Id: <20260707102114.B2B791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RMAP walker Use-After-Free of `mm_struct` and VMA during VMA lock =
release due to skipped `mmgrab()` stabilization and flawed synchronization =
with `exit_mmap()`.
- [High] Enabling `CONFIG_ANON_VMA_SHARED_SEMS` exposes a Use-After-Free vu=
lnerability because the dynamically allocated semaphores are freed without =
RCU protection but accessed under RCU.
--

--- Patch [13]: [RFC PATCH v2 13/13] mm: Enable CONFIG_ANON_VMA_FRACTAL by =
default ---
commit e2497626d5f9a80886b8bd9853568725462fff8d
Author: tao <tao.wangtao@honor.com>

mm: Enable CONFIG_ANON_VMA_FRACTAL by default

Everything is now in place to enable CONFIG_ANON_VMA_FRACTAL and
CONFIG_ANON_VMA_SHARED_SEMS for further testing.

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1a2c8085b12d5..7916c0127de0a 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1453,7 +1453,7 @@ config LOCK_MM_AND_FIND_VMA
> =20
>  config ANON_VMA_FRACTAL
>  	bool "anon_vma fractal list"
> -	def_bool n
> +	def_bool y

[Severity: High]
This isn't a bug introduced by this patch, but enabling this feature by
default exposes a use-after-free race between the RMAP walker and
exit_mmap().

Looking at trylock_leaf_vma_rmap() in mm/rmap.c, it sets other_mm to NULL if
vma->vm_mm =3D=3D mm, which skips the mmgrab() stabilization:

mm/rmap.c:trylock_leaf_vma_rmap() {
    ...
    *other_mm =3D (vma->vm_mm =3D=3D mm) ? NULL : vma->vm_mm;
    ...
}

Then in folio_lock_anon_vma_read(), RCU protection is dropped while holding
an unpinned leaf_vma:

mm/rmap.c:folio_lock_anon_vma_read() {
    ...
    if (leaf_vma && !other_mm && folio_mapped(folio)) {
        rcu_read_unlock();
        return (void *)leaf_vma + ANON_RMAP_LEAF_VMA;
    }
    ...
}

Concurrently, if exit_mmap() acquires mmap_write_lock() but doesn't drain
per-VMA lock readers via vma_start_write(), it can free the VMA and the
unpinned mm_struct.

When the RMAP walker later calls anon_node_unlock_rmap(), it dereferences
the freed VMA and vm_mm to wake up writers:

mm/rmap.c:anon_node_unlock_rmap() {
    ...
    if (anon_rmap_is_leaf_vma(anon_nod)) {
        vma_refcount_put(anon_rmap_to_leaf_vma(anon_nod));
        return;
    }
    ...
}

Should the RMAP walker ensure the mm_struct is stabilized before dropping
RCU protection to prevent this?

>  	depends on MMU
>  	help
>  	  This option uses vma_rmap_base(vma) during rmap to compute the page
> @@ -1481,7 +1481,7 @@ config ANON_VMA_FRACTAL
> =20
>  config ANON_VMA_SHARED_SEMS
>  	bool "anon_vma shared semaphores"
> -	def_bool n
> +	def_bool y

[Severity: High]
This isn't a bug introduced by this patch, but enabling ANON_VMA_SHARED_SEMS
by default exposes a use-after-free vulnerability with the dynamically
allocated semaphores.

In anon_vma_init() in mm/rmap.c, the slab cache for the shared semaphores is
created without SLAB_TYPESAFE_BY_RCU:

mm/rmap.c:anon_vma_init() {
    ...
    anon_sema_cachep =3D KMEM_CACHE(anon_semaphore, SLAB_PANIC|SLAB_ACCOUNT=
);
    ...
}

When the semaphore is freed in anon_root_sema_free(), it happens immediately
without an RCU grace period:

mm/rmap.c:anon_root_sema_free() {
    ...
    kmem_cache_free(anon_sema_cachep, root_sema);
    ...
}

However, folio_lock_anon_vma_read() locklessly accesses root->root_anon_sema
under rcu_read_lock() and attempts to modify it:

mm/rmap.c:folio_lock_anon_vma_read() {
    ...
    root_rwsem =3D anon_root_rmap_sem(root_anon_vma);
    if (down_read_trylock(root_rwsem)) {
    ...
}

Since the semaphore slab is not RCU-safe, the memory can be immediately
reclaimed by the buddy allocator or reallocated.=20

Will down_read_trylock() end up modifying freed or completely unrelated
memory if a reclaim runs concurrently with an unmap?

>  	depends on ANON_VMA_FRACTAL
>  	help
>  	  As rmap operations rarely run concurrently, and fork/delete updates

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D13
