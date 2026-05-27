Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BB1427A
	for <damon@lists.linux.dev>; Wed, 27 May 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902396; cv=none; b=f+AzEOmn+I2dvGwdMmj0xY4MgRAZwcjgMYQWSkAjF8d7lXXaUEM4ky77bGMWwvP8tz7q/ZsvjhkiDlcQOX3I7cZLYUA3qtNQZqkZ8WH+pI79QVWyIVvcUcPlQp9Dpc6gnuxLxcBq3Face9L3R7AEna6bcr59bN1KzZgE1ki6sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902396; c=relaxed/simple;
	bh=v0a/7qFS9sIlK7DVv/NdHNmKGqhl7V17GuaMI3E5AJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWeTpLUC63+Elr5/cb24YMPJAeEdKvWCmWx9kNL1GF+HAiwiCLTmtdGQ8UIAzblnQdhomH2kQzy0mCkoeMvN/kXJtKD6yWCGL5pOsYr5wWb7PiLfTddRhUSFC2Fvm8J/yawsdVeWfco2UvrhD9NaHDUoo9FA6YlBpiunIqJcToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSZcEthU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSZcEthU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511651F000E9;
	Wed, 27 May 2026 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779902394;
	bh=LPVgkqUHjE+500Acen/8asZSlnpj1x2izgw/0y9I4Ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSZcEthUiLCVrAW8eDtb3d3YJrN6UFFaQkE54gB80A5vu3tpRftwUC+nZbw89z9+4
	 HFVTa62dIWqROi+MxPYRsKur/I+Qv1NG/TXhIWH5UUp2JO2ni3uxpGegkVHjHyweLM
	 3DubJlHgKYhKjmo9xQlvKfjbuNO2Lj1Tnz7la22diCG8Fn4ggWrrns+ishg26MgM6k
	 rR65yKuqFJBkHo26r/W8CUtj9X+CRP4kybJKfhylsuhtOFggIouwFKx5pC2kCu2jFt
	 +1m0J84gg7Me4zYqArqKVYxHkOlpV6w1pw9X6UxstEdIscwS3+REX6QalAPrcxuohX
	 4puhutQ2v85Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] mm: enable CONFIG_ANON_VMA_LAZY on arm64 and
 x86_64
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-16-tao.wangtao@honor.com>
References: <20260527110147.17815-16-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 17:19:53 +0000
Message-Id: <20260527171954.511651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dereferencing mm_struct in folio_resolve_anon_vma_lazy() cause=
s a use-after-free because SLAB_TYPESAFE_BY_RCU allows the VMA to be recycl=
ed without pinning the new mm_struct.
- [Critical] Unbalanced refcount drop in vma_prepare_anon_vma() error path =
causes an underflow and premature freeing of the root anon_vma.
- [High] Toggling the sysctl anon_vma_lazy at runtime causes Use-After-Free=
 and VM_BUG_ON_VMA crashes due to flawed structural state checks.
- [High] Unmapping the root of a split lazy anon VMA clears its anon_vma po=
inter, permanently breaking reverse mapping for folios in the remaining chi=
ld VMAs.
--

commit 6ca138075f0d0c3a8eba3846297fc8cdfbebaa40
Author: tao <tao.wangtao@honor.com>

mm: enable CONFIG_ANON_VMA_LAZY on arm64 and x86_64

All prerequisites are in place, so enable CONFIG_ANON_VMA_LAZY for
arm64 and x86_64.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943b..9517883f0aaf2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
[ ... ]
> @@ -81,6 +81,7 @@ config ARM64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
> +	select ARCH_SUPPORTS_ANON_VMA_LAZY
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select ARCH_SUPPORTS_RT
>  	select ARCH_SUPPORTS_SCHED_SMT
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f3f7cb01d69d0..cc3430eaa7b41 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
[ ... ]
> @@ -28,6 +28,7 @@ config X86_64
>  	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
> +	select ARCH_SUPPORTS_ANON_VMA_LAZY
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select HAVE_ARCH_SOFT_DIRTY
>  	select MODULES_USE_ELF_RELA
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b3bebb58e3597..4edf3311b1ae0 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
[ ... ]
> @@ -168,7 +168,7 @@ static struct kmem_cache *anon_vma_chain_cachep;
>   *        covering both regular anon_vma and lazy anon_vma mappings.
>   */
> =20
> -bool anon_vma_lazy_enable;
> +bool anon_vma_lazy_enable =3D true;

[Severity: Critical]
This is a pre-existing issue, but enabling this by default exposes a potent=
ial
use-after-free when dereferencing the mm_struct in
folio_resolve_anon_vma_lazy().

During an RCU reverse mapping walk, folio_resolve_anon_vma_lazy() reads
mm =3D vma->vm_mm locklessly. Because VMAs are allocated with
SLAB_TYPESAFE_BY_RCU, the vma can be recycled and reallocated to a different
process during the walk.

The function calls vma_get() to increment the VMA refcount, but fails to pin
the foreign mm_struct via mmgrab(). If the foreign process exits concurrent=
ly,
its mm_struct is freed. The subsequent vma_lookup(mm, addr) dereferences
mm->mm_mt, resulting in a use-after-free.

Should the foreign mm_struct be stabilized with mmgrab() before performing
the lookup?

[Severity: Critical]
This is a pre-existing issue, but enabling this by default exposes an
unbalanced refcount drop in the vma_prepare_anon_vma() error path.

When attempting to upgrade a lazy anon_vma, a new anon_vma may be allocated.
If this thread loses a race and the VMA is already upgraded by another thre=
ad,
the likely(!vma->anon_vma || is_lazy) check evaluates to false, skipping
get_anon_vma(anon_vma->root).

However, the cleanup path unconditionally calls put_anon_vma(allocated).
Inside __put_anon_vma(), the root's refcount is decremented. Since it was
never incremented by this thread, this causes a refcount underflow and
premature freeing of the root anon_vma. This can lead to a use-after-free
for all other VMAs mapped to it.

Could the cleanup path be adjusted to only decrement the refcount if it was
successfully incremented?

[Severity: High]
This is a pre-existing issue, but enabling this by default exposes crashes
and memory issues if anon_vma_lazy_enable is toggled at runtime.

Disabling anon_vma_lazy_enabled() at runtime causes structural inconsistenc=
ies
for existing lazy VMAs. In anon_vma_fork(), the lazy fork path is skipped,
falling through to anon_vma_clone(), which calls vma_link_anon_vma_lazy_roo=
t().
This triggers VM_BUG_ON_VMA(vma->vm_mm !=3D src->vm_mm, vma), which will cr=
ash
the kernel.

Furthermore, SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT() becomes a no-op,
meaning a pre-existing lazy root VMA being merged is deleted instead of
preserved. Reverse mapping walkers will later dereference this freed VMA via
folio->mapping, leading to a use-after-free.

Is it safe to toggle this sysctl at runtime while lazy VMAs already exist in
the system?

[Severity: High]
This is a pre-existing issue, but enabling this by default exposes a
regression when unmapping the root of a split lazy anon VMA.

When a lazy anon VMA is split, anon_vma_clone() links the new child VMA to
the root VMA by holding a reference to the root. If the root VMA is later
unmapped, unlink_anon_vmas() clears root_vma->anon_vma =3D NULL.

However, the child VMA remains alive, and its anonymous folios still point =
to
the root VMA via folio->mapping. During a reverse mapping walk,
folio_resolve_anon_vma_lazy() discovers !vma->anon_vma and aborts early.

This permanently breaks reverse mapping for the folios in the child VMA,
preventing them from being unmapped, migrated, or swapped out.

Does clearing root_vma->anon_vma need to account for surviving child VMAs to
avoid breaking reverse mapping?

>  #endif
> =20
>  static inline struct anon_vma *anon_vma_alloc(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D15
