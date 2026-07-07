Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499D30BBB9
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414897; cv=none; b=I2XaJdw9USdz9RnRaCjI/RQNe57s5AxyAMjBUeEPOqhJgiu+pUqi+Kjd/iGwNzAu6JwNC6IXnaGcCgVvnlkRh6oc85KOkg3mXymme3VOQ5IAcUuxKfp3kebZ9qSxyrG/FeGyRaBzBD3GHdIxVOAkU0i5wKCmj7t8pSA74g0CDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414897; c=relaxed/simple;
	bh=JncV5Gg9u/UL+BvWUUQdIcQ8h8uSWAsneBqexz12G9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M7WfKw9Hzkhia95RmbSzd/8YFSBxO8Vi5lqRNwSkEO8RDNnyJeAwLM2vZ1Vs0mS+V3n+fDzVrkf6nWqpa01KtQvZc9H6lnnLNPB6R0vkzRQnCxhFS1f9/vhMfSE1ab7OdYqyTwFxai3fzThzDJvMdpYGrKzWvWmUNtx2xRZoBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctwp0LHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctwp0LHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433031F000E9;
	Tue,  7 Jul 2026 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414895;
	bh=HbfHVGYc2aCL07UusjiOMRWADXPEMDrtnAEvcPT5tVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ctwp0LHW4dKQDcc+AlTfKjRQf4ajtuKIfz+Fp89bT/+YnN9/QLxJ+ov7JimSNvaIX
	 WyBA0EVPl7+2t7ZmGTvJfHQBUB+HUGLh2cZI0NUPaGhvjn1Hrt1uN3h2xrPA6IExFE
	 /U2FTj3sAxTGcg6CIjpiyxjL/BB9RS2dz1I1HS2CTX3/zDQ2nfIFXoWLFnQFXU2N9m
	 W4dLA1XCW3e37kEXliI2OyvMMJHQ45RBv/hlPCJE+r7aKkAmOg4TbueL77fjRFoKyn
	 p0U0Q2SGyYi8WsewRQhVkzVdxozrsx5Mq8DLOl7VsSMkpulYJg5AodFUgY8hbVaxYA
	 QU201+/Ue3rIg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/13] mm: implement anonymous folio rmap for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-9-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-9-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:01:34 +0000
Message-Id: <20260707090135.433031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Accessing a dangling `mm_struct` pointer in `anon_node_lookup_vma`=
 causes Use-After-Free (UAF) on the `mm_struct` or its maple tree.
- [High] Lockless access to a `SLAB_TYPESAFE_BY_RCU` VMA after RCU is dropp=
ed in `anon_node_lookup_vma` causes Use-After-Free.
- [Medium] ANON_RMAP_FOREACH_VMA macro causes an infinite loop if the calle=
r uses a `continue` statement.
- [Medium] Using 0 as a sentinel address breaks legitimate VMAs mapped at a=
ddress 0x0.
--

--- Patch [8]: [RFC PATCH v2 08/13] mm: implement anonymous folio rmap for =
ANON_VMA_FRACTAL ---
commit 6798bdd36311c3a484df289386e32cf89ecdeba9
Author: tao <tao.wangtao@honor.com>

mm: implement anonymous folio rmap for ANON_VMA_FRACTAL

This commit adds the ANON_RMAP_FOREACH_VMA() macro to encapsulate rmap
traversal. It traverses the folio's own anon_node and its descendants, using
VMA updates to advance the page offset. For KSM, the VMA is located directly
using the supplied address.

> diff --git a/mm/internal.h b/mm/internal.h
> index 12473ac84fa4e..5f96b15246bf9 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h

[ ... ]

> @@ -303,6 +303,55 @@ static inline unsigned long anon_node_rmap_count(str=
uct anon_node *anon_nod)
>  	return atomic_long_read(&anon_nod->rbc) & ANON_RMAP_BASE_COUNT_MAX;
>  }
> =20
> +static inline unsigned long anon_node_rmap_address(struct anon_node *ano=
n_nod,
> +		unsigned long pgoff)
> +{
> +	if (!anon_node_rmap_count(anon_nod))
> +		return 0;
> +	return anon_node_rmap_base(anon_nod) + (pgoff << PAGE_SHIFT);
> +}
> +
> +static inline struct vm_area_struct *anon_node_lookup_vma(
> +	struct anon_node *anon_nod, unsigned long addr, unsigned long pgoff)
> +{
> +	struct vm_area_struct *vma;
> +
> +	if (!addr)
> +		addr =3D anon_node_rmap_address(anon_nod, pgoff);
> +	if (!anon_nod->mm || !addr)

[Severity: Medium]
Will this silently ignore valid mappings at address 0x0?

If mmap_min_addr is configured to 0, it seems a valid anonymous VMA could be
explicitly mapped at virtual address 0x0. If this happens, addr will be 0, =
and
this check will return NULL, causing the valid VMA to be hidden from rmap w=
alks.

> +		return NULL;
> +
> +	vma =3D vma_lookup(anon_nod->mm, addr);

[Severity: High]
Could anon_nod->mm be a dangling pointer here?

When a VMA is unmapped, if unlink_anon_nodes() skips clearing the mm pointer
for the root anon_node, and the anon_node remains alive because folios are =
in
the swap cache or pinned by GUP, its mm pointer might dangle after the proc=
ess
exits and its mm_struct is freed.

If ANON_RMAP_FOREACH_VMA() is called later during reclaim, will it derefere=
nce
the freed mm_struct here when calling vma_lookup()?

> +	return (vma && vma->anon_vma =3D=3D (void *)anon_nod) ? vma : NULL;

[Severity: High]
Is it safe to access vma->anon_vma without RCU protection?

vma_lookup() delegates to mtree_load(), which acquires and then releases th=
e RCU
read lock internally. Since the caller of anon_node_lookup_vma() doesn't ho=
ld
the mmap_lock (only the anon_node lock), and no outer RCU critical section =
is
held, the returned VMA pointer appears to be unprotected.

Because the VMA cache is SLAB_TYPESAFE_BY_RCU, its backing memory can be
unmapped and freed by a concurrent unmap outside of an RCU critical section.
Will dereferencing vma->anon_vma here result in a use-after-free?

> +}
> +
> +void vm_lock_anon_node(struct mm_struct *mm, struct anon_node *anon_nod);
> +void vm_unlock_anon_node(struct anon_node *anon_nod);
> +int anon_node_trylock_rmap(struct anon_node *anon_nod);
> +void anon_node_lock_rmap(struct anon_node *anon_nod);
> +void anon_node_unlock_rmap(struct anon_node *anon_nod);
> +
> +#define ANON_RMAP_FOREACH_VMA(anon_vma, addr, start, last, rmap_proc_vma=
) \
> +do { \
> +	struct vm_area_struct *vma =3D NULL; /* must be named vma */ \
> +	struct anon_node *_anon_nod =3D (void *)(anon_vma); \
> +	struct anon_node *_nod =3D _anon_nod; \
> +	unsigned long _pgoff =3D (start); \
> +	unsigned long _nr =3D 0, _total =3D 1; \
> +	\
> +	while (_nod) { \
> +		vma =3D anon_node_lookup_vma(_nod, (addr), _pgoff); \
> +		if (vma) \
> +			(rmap_proc_vma); \

[Severity: Medium]
What happens if the caller provides a block for rmap_proc_vma that contains=
 a
continue statement?

Because the loop advancement logic:

		_pgoff =3D vma ? vma->vm_pgoff + vma_pages(vma) : _pgoff + 1;
		...
		_nod =3D anon_node_next_descendant(_anon_nod, _nod);

is located after the execution of rmap_proc_vma, a continue statement insid=
e the
caller's block would jump straight to the while (_nod) condition.

Will this skip the advancement of _nod and _pgoff, causing the macro to inf=
inite
loop on the same node?

> +		_pgoff =3D vma ? vma->vm_pgoff + vma_pages(vma) : _pgoff + 1; \
> +		if (!(addr) && _pgoff <=3D (last)) \
> +			continue; \
> +		_pgoff =3D (start); \
> +		BUG_ON(++_nr > (_total +=3D _nod->nr_children)); \
> +		_nod =3D anon_node_next_descendant(_anon_nod, _nod); \
> +	} \
> +} while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D8
