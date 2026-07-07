Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB13E5568
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409000; cv=none; b=pCQJnP/+B8Uf+ch3McALb4Bv4ajaeTYVFx7flj2XgAZOq2Vo8zIZP5Kz5hE11BlIGJvnNdoMmNGg/oGlCXMqez54QfP4Cj+B/Ujf7ON76H+8fs3UyombGDBH7CIW6GioMSDMtAxHoptgioiCWf5jBXJs/tApmnkEfI1yAaVAtTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409000; c=relaxed/simple;
	bh=Cfj/oa+7h0mI3kb0aNPCbufEOQdkxAqGP3J0ImXV7t0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIRW6M5MHiKOZB+UldM18JLcuqV5sBSn3is8JkCjkllW54bnQJyLYouYtK/u1vURFv9NKleGm7oxkGAXeBOQKnw7ECS+Jna/P8BrWCiMrFwHLm78h3R7pqfT1JJ2gkL/ktONG0iaFpOtKdsvzZ098FtzSxMCCVfEInH7bmscJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvUaFY96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvUaFY96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700451F000E9;
	Tue,  7 Jul 2026 07:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408989;
	bh=s7I7tVpHzIz6IVPH2q3wEcj1155NdsLO5orGen9PjnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvUaFY96IDRoKiF9xBh/AdmS68dwsGgdan1ulJpqXoTc7rhOOm8y1baaV3uR2PU/T
	 SbaHXcK/8OMp/TCeqGNOADkA6Mgb0+GailpAoLMkjK7G/Qc5fu82LlsMI1q1aOMkb8
	 qvrANFmDyWNq/q7B6kDw44uoqxoTta5bTol1A30jRvHgauHtg5YfhBp/rtjLIj5b1l
	 2sWFAqVHlXxg/GzYAcl8q4i2H2Rd5LXydk+BHksahn2Ostx0sygQVFHlaga4vD8hQ4
	 EvEAk4bPFOP/NGnh137UoaJg51+5+n8iJlg+Hecezv+3bKccYocna56YOdUZO8WYWR
	 E7BBh9G4HPX0Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/13] mm: implement helpers for ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-3-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-3-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:23:09 +0000
Message-Id: <20260707072309.700451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `anon_node_alloc()` fails to take a reference on the intermediate =
`parent` node, leading to premature freeing and dangling parent pointers.
- [High] `anon_vma_fractal_init()` is defined but never called, leaving `an=
on_node_cachep` uninitialized.
- [Medium] The `anon_node` structure caches a raw pointer to an `mm_struct`=
 without holding a reference, which can lead to a Use-After-Free.
- [Low] Unconditional access to conditionally compiled fields `rwsem` and `=
vm_lock_ref` breaks the build when `CONFIG_ANON_VMA_SHARED_SEMS` is enabled.
--

--- Patch [2]: [RFC PATCH v2 02/13] mm: implement helpers for ANON_VMA_FRAC=
TAL ---
commit 353e80074df4a13790b7dd27f2e9eb1a62294b38
Author: tao <tao.wangtao@honor.com>

mm: implement helpers for ANON_VMA_FRACTAL
   =20
Implement basic helpers.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 9939400e77c79..54c5ccfee6813 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
[ ... ]
> @@ -558,6 +558,95 @@ void __init anon_vma_init(void)
>  			SLAB_PANIC|SLAB_ACCOUNT);
>  }
> =20
> +#ifdef CONFIG_ANON_VMA_FRACTAL
> +
> +static struct kmem_cache *anon_node_cachep;
> +
> +static inline struct rw_semaphore *anon_node_rmap_sem(struct anon_node *=
node)
> +{
> +	return &node->root->rwsem;
> +}
> +
> +static inline atomic_t *anon_node_vm_lock_ref(struct anon_node *node)
> +{
> +	return &node->root->vm_lock_ref;
> +}
> +
> +static void anon_node_ctor(void *data)
> +{
> +	struct anon_node *anon_nod =3D data;
> +
> +	init_rwsem(&anon_nod->rwsem);
> +	atomic_set(&anon_nod->vm_lock_ref, 0);
> +	atomic_set(&anon_nod->refcount, 0);
> +}

[Severity: Low]
Does this cause a build failure when CONFIG_ANON_VMA_SHARED_SEMS is enabled?

The rwsem and vm_lock_ref fields in struct anon_node are conditionally
compiled out when this config is set, but they are accessed unconditionally
here in anon_node_ctor() and anon_node_rmap_sem().

> +
> +static inline void anon_vma_fractal_init(void)
> +{
> +	struct kmem_cache_args args =3D {
> +		.use_freeptr_offset =3D true,
> +		.freeptr_offset =3D offsetof(struct anon_node, fractal_list),
> +		.ctor =3D anon_node_ctor,
> +	};
> +
> +	anon_node_cachep =3D kmem_cache_create("anon_node",
> +			sizeof(struct anon_node), &args,
> +			SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT);
> +}

[Severity: High]
Is anon_vma_fractal_init() ever called?

It doesn't appear to be hooked up to anon_vma_init() or anywhere else, which
would leave anon_node_cachep uninitialized and result in a null pointer
dereference crash on the first allocation.

[ ... ]
> +static inline struct anon_node *anon_node_alloc(struct vm_area_struct *v=
ma,
> +		struct anon_node *parent, bool is_fork)
> +{
> +	struct anon_node *anon_nod;
> +
> +	anon_nod =3D kmem_cache_alloc(anon_node_cachep, GFP_KERNEL);
> +	if (!anon_nod)
> +		return NULL;
> +
> +	anon_nod->root =3D parent ? parent->root : anon_nod;
> +	anon_nod->parent =3D parent;
> +	atomic_set(&anon_nod->refcount, 1);
> +	anon_nod->depth =3D 0;
> +	if (parent) {
> +		get_anon_node(parent->root);
> +		anon_nod->depth =3D parent->depth + (1 << is_fork);
> +	}

[Severity: High]
Does this code leave the intermediate parent node vulnerable to being freed?

We assign anon_nod->parent =3D parent but only take a reference on parent->=
root.
If the intermediate parent is freed while this node is still alive,
anon_nod->parent becomes a dangling pointer.

> +	anon_nod->nr_children =3D 0;
> +	INIT_LIST_HEAD(&anon_nod->fractal_list);
> +	anon_nod->mm =3D vma->vm_mm;

[Severity: Medium]
Should we acquire a reference to the mm_struct using mmgrab() here?

A process exiting will free its mm_struct. If child processes keep the
parent's root anon_node alive via get_anon_node(parent->root), the
anon_node->mm pointer could become a dangling pointer, leading to a
use-after-free during lockless rmap walks.

> +	atomic_long_set(&anon_nod->rbc, vma_rmap_base(vma) + 1);
> +	return anon_nod;
> +}
> +
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D2
