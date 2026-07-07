Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6223AFCE3
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418372; cv=none; b=FvbzWPnRw/ex+NnpDqnCw26KGHdIZ4M+YkpI9AnEhuvHrSZ2mYiz+0EqHuQm2xyM7vsm8lORJh3VQ3ksFQsGkdkmpU923BwY+dzr8/OziJGkFSt+bwsuRtZ/ttwPFkgZhWWMTvlg9FPQnAd6Z70fWevT+lXQZqkvmsPqEJDXXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418372; c=relaxed/simple;
	bh=ZCFo42Iwg0vLbDrQMZHLTp5WxN2Es72id7/bllGfCD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J9OqebRMOsGxWfM1i+tWAJCm0VvcMLPYLnaqSYmJ0ZQDGmm8GAcw5o6tBlGPqJ/wZygj3rfDGwTkrpCweRKYFgRiPT38cNMNyGqceQDm7d03Zo290VPKeiS1rnkXcABD5U37St8FFlLech34j/vRwbLGZqopHYkeOO//lNpJw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPbMk+Ok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPbMk+Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9016B1F000E9;
	Tue,  7 Jul 2026 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783418370;
	bh=32HMmQSYAFl6paubujuckhE3azdO6y3u/teHEllkCvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPbMk+OkToNDHUOuNAPAT35qgy81nlC36TQU7cPBKnv8PAjxlZ4gBQ4CgmYDsTnuX
	 s5M3z8AIxlF6gPC+MZAbJsegycDlHDEeisiCXF/e/w9T6YaRg4swogL3PX3/KmuMa1
	 oYmJxkn/J0t718pbu+SxFrXJuUg9OjIAVdHVjfup8y4sKIMN/m0+zZPeSey/fmddLY
	 A6pt0GthaZMeKE+J0yKQ2mgQ/lcOzNxw7mKMxg8O19uKugf2rrwym2FtLb2JgWSexu
	 pdnY4GmGmhvqdU6t5XsG+CFiRO1mpPfjB0UKqCc6S1YYeoc8gdedtkKnW2OOaAGbIb
	 3+Iz1zZU8INYQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 12/13] mm: shared semaphores for ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-13-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-13-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:59:29 +0000
Message-Id: <20260707095930.9016B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Lockless RCU readers access freed `anon_semaphore` memory because =
`anon_sema_cachep` lacks `SLAB_TYPESAFE_BY_RCU`.
- [High] Direct writers and `vm_lock` callers experience TOCTOU races and s=
tate loss due to dynamic semaphore upgrades without pointer re-verification.
- [High] An untracked `anon_node` with children retains a dangling `node->m=
m` pointer to an unmapped VMA's freed `mm_struct`, which KSM rmap walks der=
eference.
--

--- Patch [12]: [RFC PATCH v2 12/13] mm: shared semaphores for ANON_VMA_FRA=
CTAL ---
commit 415add0f8800d6a7589361c22fc91f31e4dab44c
Author: tao <tao.wangtao@honor.com>

mm: shared semaphores for ANON_VMA_FRACTAL

This commit introduces shared semaphores for anon_node to reduce memory
overhead, reusing the root anon_node's unused parent pointer to store a
dedicated semaphore. It also adds logic to revalidate locks in rmap paths
and uses rwsem_is_write_locked to reduce contention.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0967ba2d2a466..196af0ef07ef5 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
[ ... ]
> @@ -600,10 +662,16 @@ void __init anon_vma_init(void)
>  		.freeptr_offset =3D offsetof(struct anon_node, fractal_list),
>  		.ctor =3D anon_node_ctor,
>  	};
> +#ifdef CONFIG_ANON_VMA_SHARED_SEMS
> +	int i;
> =20
> +	for (i =3D 0; i < ANON_NODE_RMAP_SEMS_COUNT; i++)
> +		anon_sema_init(&anon_node_root_semas[i]);
> +#endif
>  	anon_node_cachep =3D kmem_cache_create("anon_node",
>  			sizeof(struct anon_node), &args,
>  			SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT);
> +	anon_sema_cachep =3D KMEM_CACHE(anon_semaphore, SLAB_PANIC|SLAB_ACCOUNT=
);
>  }

[Severity: High]
Can lockless RCU readers access freed memory here?

When an anon_node is destroyed, anon_root_sema_free() immediately returns
the semaphore to anon_sema_cachep. Because anon_sema_cachep is created
without SLAB_TYPESAFE_BY_RCU (unlike anon_node_cachep), the memory is
instantly available for reallocation.

If a concurrent lockless RCU reader in folio_lock_anon_vma_read() obtains a
pointer to root_anon_sema just before it is freed:

CPU1
anon_node_free()
  anon_root_sema_free()

CPU2
folio_lock_anon_vma_read()
  root_rwsem =3D anon_root_rmap_sem(root_anon_vma);
  if (down_read_trylock(root_rwsem)) { ... }

Could CPU2 execute down_read_trylock() on reallocated memory and cause
corruption?

[ ... ]
> @@ -758,8 +837,22 @@ static int anon_node_add_child(struct anon_node *ano=
n_nod,
>  	struct rw_semaphore *rmap_sem =3D anon_node_rmap_sem(root);
>  	struct anon_node *rbc_ch =3D anon_nod, *next;
> =20
> -	if (root->depth =3D=3D 0)
> +	if (root->depth =3D=3D 0) {
> +#ifdef CONFIG_ANON_VMA_SHARED_SEMS
> +		struct anon_semaphore *root_sema =3D anon_root_sema_alloc();
> +
> +		if (!root_sema)
> +			return -ENOMEM;
> +		down_write(rmap_sem);
> +		if (cmpxchg(&root->root_anon_sema, NULL, root_sema) !=3D NULL)
> +			anon_root_sema_free(root_sema);
> +		root->depth =3D 1;
> +		up_write(rmap_sem);

[Severity: High]
Are direct writers vulnerable to a TOCTOU race when the semaphore is
upgraded?

This block upgrades the node to use a dedicated semaphore under the shared
write lock.=20

If a tree modifier like unlink_anon_vmas() or vma_pre_update_rmap_base()
evaluates anon_node_rmap_sem() and gets the shared semaphore pointer, but
blocks before acquiring it, it might wake up after this upgrade completes.=
=20

Since those paths do not appear to re-verify the pointer like
anon_node_lock_rmap_and_verify() does, will they mistakenly modify the tree
while holding the old shared lock, allowing concurrent modifications from
other threads using the new dedicated lock?

[ ... ]

[Severity: High]
Does this leave a dangling mm pointer on untracked nodes?

When a VMA is unmapped and unlink_anon_vmas() untracks the node,
anon_node_untrack_rmap_locked() skips clearing the mm pointer if the node
still has children.

If the process then exits and frees the mm_struct, could a later KSM rmap
walk pass a non-zero addr to anon_node_lookup_vma(), bypass the untracked
safeguard, and dereference the freed mm_struct in vma_lookup()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D12
