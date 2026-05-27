Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F2280318
	for <damon@lists.linux.dev>; Wed, 27 May 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886953; cv=none; b=qUl83dECIruXllmOLsW7yE4sUBrvyURq9Vlmvv0HtaxcbbztSBiloaY1cOl9k0KrDAmcxuzBMIHG6H1JoCQEE0Md+m/N18N3do747icqofbScbokzkCp0m1VfgkRN6exGZ+WLiemSQ7/nKmJ7xxygQWKRk5Kkk5pYrcDy64gstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886953; c=relaxed/simple;
	bh=inLAp7/uEJY5jTbJ8m+5t4XAfLhoaazjiX3pgbvzDOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gCZF7mNoCT/d06VY3YmyEfn650Th5RdnxuNF0EOutNTgyM4BZtMtaPXKqV+Xx2IaaeCyEz+mix7ktdu1JIznviXePch+MmQc7HOOGH8E5zsWoOmGOEkkVDCPpqWKpdc7J2aaku64saN0JeEQZZ0KuLm0hFwijtiEQ+BSXoJ31vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XabAHfeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XabAHfeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48871F000E9;
	Wed, 27 May 2026 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886951;
	bh=6hOy9dJFAWa+JK1IUNBR38kChVdOn+rmdMmX32BaVGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XabAHfeBaYViWEMIeM1QmjaL5uim0++g4rVtR+U+9DHUrawZLW+IEs/elVTIdkD+I
	 nB6/O3CptjHueb//PEQSnKV33+YH10wlaT4/DO1BuG+S5VqhkXSdgICMLV9m6CDjV1
	 xBR3pJGBVd/u/80vY4ZI1WeS/Knl/4lqmr8vtfNhq5wUcvZxqL8+VX4tOTmwI8Zc2E
	 aradmsC20kCavuZ4P1oLsFXhmAaBHUgbGiJglVz4Sy5KD7DrPWWayRGmh1VMrYzTv2
	 EeNeIS4il17edd0+HdEskR8PTmdWAH1GhmbwF4G2zRFWAhVL9K3ra06+SFOwx7MTDF
	 Hh1Gomj/88fGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] mm: support setup and upgrade of ANON_VMA_LAZY
 folios
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-14-tao.wangtao@honor.com>
References: <20260527110147.17815-14-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 13:02:31 +0000
Message-Id: <20260527130231.B48871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Dereferencing `vma->vm_mm` before taking the VMA reference cau=
ses a Use-After-Free on the `mm_struct`.
- [Critical] Upgrading a VMA leaves dangling pointers in `folio->mapping`, =
leading to Use-After-Free.
- [High] rmap_walk_anon() silently aborts instead of retrying when a lazy m=
apping is concurrently upgraded.
- [High] Toggling the `anon_vma_lazy` sysctl at runtime causes `fork()` to =
crash with `VM_BUG_ON_VMA`.
- [High] Large anonymous folios spanning split VMAs break rmap traversal be=
cause only one VMA updates the folio mapping.
- [High] TOCTOU race in `__folio_rmap_sanity_checks()` causes a kernel pani=
c when a folio mapping is concurrently upgraded.
--

commit a797e29fa9a2081d4af94616e5d30308d998bb4d
Author: tao <tao.wangtao@honor.com>
Subject: mm: support setup and upgrade of ANON_VMA_LAZY folios

This commit introduces ANON_VMA_LAZY folios setup and upgrade mechanisms
across mapping, duplicating, and rmap walk paths.

> rmap_walk_anon() detects ANON_VMA_LAZY upgrades and retries
> the walk to ensure the mapping is handled correctly.

[Severity: High]
The commit message mentions that rmap_walk_anon() retries the walk if it
detects an ANON_VMA_LAZY upgrade. Is this accurate?

It appears there is no retry loop. If folio_lock_anon_vma_lazy_read()
returns NULL because the mapping was upgraded concurrently,
rmap_walk_anon_lock() returns ANON_RMAP_NULL and rmap_walk_anon()
immediately aborts.

Could this cause reverse mapping operations like try_to_unmap() to silently
skip the folio, leading to memory leaks and failed migrations?

> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -392,6 +392,14 @@ static __always_inline void __folio_rmap_sanity_chec=
ks(const struct folio *folio
>  		unsigned long mapping =3D (unsigned long)folio->mapping;
>  		struct anon_vma *anon_vma;
> =20
> +		if (folio_test_anon_vma_lazy(folio)) {
> +			struct vm_area_struct *root_vma =3D
> +				(void *)(mapping - FOLIO_MAPPING_ANON_VMA_LAZY);
> +
> +			VM_WARN_ON_FOLIO(!rcuref_read(&root_vma->vm_rcuref), folio);
> +			return;
> +		}
> +
>  		anon_vma =3D (void *)(mapping - FOLIO_MAPPING_ANON);
>  		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) =3D=3D 0, folio);

[Severity: High]
Is there a TOCTOU race here when a folio mapping is concurrently upgraded?

The code reads folio->mapping into the local mapping variable, then
folio_test_anon_vma_lazy() re-reads folio->mapping. If the mapping is
upgraded to a regular anon_vma between these reads, the test returns false,
falling through to evaluate anon_vma using the first read which still has
the lazy tag.

This would yield an unaligned pointer (root_vma + 2), and dereferencing it
in atomic_read() would panic the kernel.

[ ... ]

> @@ -431,6 +439,31 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm=
_area_struct *,
> +static inline void folio_upgrade_anon_vma_lazy(struct folio *folio,
> +					       struct vm_area_struct *vma)
> +{
> +	unsigned long anon_tree =3D (unsigned long)vma->anon_vma;
> +
> +	VM_BUG_ON_VMA(!anon_tree || !IS_ALIGNED(anon_tree, sizeof(long)), vma);

[Severity: High]
What happens if the anon_vma_lazy_enabled() sysctl is toggled to false at
runtime?

If anon_vma_fork() skips upgrading the parent VMA's lazy mapping, later in
fork(), copy_page_range() calls folio_try_dup_anon_rmap() which then
invokes folio_upgrade_anon_vma_lazy() here.

Since src_vma->anon_vma was never upgraded and holds a tagged
ANON_VMA_TREE_VMA pointer, wouldn't this IS_ALIGNED assertion fail and
panic the kernel?

> +	anon_tree =3D anon_tree + FOLIO_MAPPING_ANON;
> +	WRITE_ONCE(folio->mapping, (struct address_space *)anon_tree);
> +}

[Severity: High]
Can large anonymous folios spanning split VMAs break rmap traversal here?

When an ANON_VMA_LAZY VMA is split, a large folio can span both resulting
VMAs. During fork(), the first VMA is upgraded to a regular anon_vma and
updates folio->mapping. When the second VMA is processed,
folio_test_anon_vma_lazy() is already false, so the folio's mapping isn't
updated to reflect the second VMA.

Will future rmap walks traverse the first VMA but miss the second,
stranding PTEs and leaking memory?

[Severity: Critical]
Does upgrading a VMA leave dangling pointers in folio->mapping?

When a lazy VMA is upgraded to a regular anon_vma (for example, via
vma_upgrade_anon_vma_lazy() during khugepaged operations or mprotect), it
seems the VMA drops its reference to root_vma, but the page tables aren't
walked to update folio->mapping for existing folios.

These folios would retain the old root_vma + FOLIO_MAPPING_ANON_VMA_LAZY
pointer. When the root_vma is eventually freed, could any rmap walk on
these folios dereference the dangling pointer, causing a use-after-free on
the freed VMA slab object?

[Severity: Critical]
While not explicitly in the provided diff context, can dereferencing
vma->vm_mm before taking the VMA reference cause a use-after-free on the
mm_struct?

In folio_resolve_anon_vma_lazy(), the code reads mm =3D vma->vm_mm before
calling vma_get(anon_lazy_root). Because the VMA is allocated from a
SLAB_TYPESAFE_BY_RCU cache, it can be freed and recycled to a completely
different process concurrently.

The read mm pointer may point to a freed mm_struct. Calling
vma_lookup(mm, addr) subsequently dereferences this stale mm pointer,
leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D13
