Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB926FD9B
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411230; cv=none; b=tZkIb7zIoAgmjLBu6XLjYCu8Mjr8PckJ+MNobi/vPJ2KMIli/uecDh30kQ2Hm02rtcztSZgZaGN5iwMI2yzwv6OqzQj8BRMYAdY4xah2yXuQhgKY2nwa9NQ4ed1/S++HYcmvjwPcwMGnGmeX44Tkas7wgFR5Adm4oqYq7631oIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411230; c=relaxed/simple;
	bh=5ZENWkygTzFD3hztF/bn3gr7fEKGN0LMOncEihdN95M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AOmMwsgHu2Q3ophioimRYYelH13HjBPVumJMfsLaCabc0dsbBSsHMoFoZrcZ0cvjJdCwieFps87UQY0USO79aFMFshOKaY0NlE75K+jA5QRFlEu3nO1QG+Omjtq1ziLvNHZqzuWmAHnU46EFV547Jer/QpsD+t+iickxLDjcwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5uaXW3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5uaXW3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22E31F000E9;
	Tue,  7 Jul 2026 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411228;
	bh=1QvXgqJfe6++NpusLiuvFU6UqaFL16UqwdjktIm6lNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5uaXW3BTnYr9XFUs6rupJwqgcASs8IOC5vxVX0I61vDTI+iNCzHwq2+jYjmYN1q5
	 Uyk3tbJpNSDel0gToQEX5IXwbn4viqMrE4yiVlOfQazuCL7P80VfIfxAlFC6Q7SGGM
	 lcmIWX321yCYcUO5SFicCqAUwcpkK/xEDOwwMculs8+wmjSS2Mg6jqlQZQX506nYzV
	 wJzrO8LI3WEm8ytlm3o1ituqGUr8gAsscY+v6uo/5c/kj/KS7XJIP9MRwQQGi+lTNB
	 CYN4QgFMfzCstkh5ofM+x8mpuGX0gdXX4RhkoEQZSSGJza5UkYGQp2EEzYThz1d3o8
	 uqTJCcMAyV1eA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/13] mm: implement anon_node_clone for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-5-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-5-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:00:28 +0000
Message-Id: <20260707080028.C22E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Flattening the fractal tree into a single list corrupts child =
iteration when children have their own descendants, permanently severing th=
e tree structure.
- [Critical] VMA unlinking unconditionally casts anon_node to anon_vma and =
overwrites mismatched fields.
- [High] Unsynchronized read-modify-write of root->depth causes data races =
and structural corruption of the fractal tree.
- [High] Newly allocated anon_node objects are permanently leaked because t=
heir reference counts are never decremented during VMA teardown.
- [High] anon_node objects are never removed from fractal_list, leading to =
a Kernel BUG and Use-After-Free.
- [High] Intermediate anon_node structures can be freed while they still ha=
ve children in their fractal_list, leading to a VM_BUG_ON panic or Use-Afte=
r-Free.
- [High] anon_node slab objects allocated in anon_node_track_rmap() with is=
_fork=3Dfalse are permanently leaked because ownership is never transferred=
 to a VMA.
- [Medium] Missing state re-validation after lock upgrade in anon_node_trac=
k_rmap() leads to duplicate child node insertions.
--

--- Patch [4]: [RFC PATCH v2 04/13] mm: implement anon_node_clone for ANON_=
VMA_FRACTAL ---
commit d6053627649639aa9d6f587172befdbc0e783aed
Author: tao <tao.wangtao@honor.com>

mm: implement anon_node_clone for ANON_VMA_FRACTAL

This commit implements anon_node_clone for ANON_VMA_FRACTAL. It creates
a child anon_node when the VMA is remapped or when the VMA count exceeds
the maximum trackable limit. Newly created nodes are inserted at the tail
of the rbc children list.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 55074ee931967..9dc82e7438b00 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> +static inline void vma_set_anon_node(struct vm_area_struct *vma,
> +		struct anon_node *anon_nod, bool is_locked)
> +{
> +	struct rw_semaphore *rmap_sem =3D anon_node_rmap_sem(anon_nod);
> +
> +	if (is_locked) {
> +		vma->anon_vma =3D (struct anon_vma *)anon_nod;
> +		return;
> +	}
> +	down_write(rmap_sem);
> +	vma->anon_vma =3D (struct anon_vma *)anon_nod;

[Severity: Critical]
Does this type cast corrupt the anon_node structure during teardown?

During teardown, the standard unlink_anon_vmas() flow operates on this poin=
ter
and executes active_anon_vma->num_active_vmas--. Since anon_node has a
different layout and lacks num_active_vmas, won't this unconditionally write
out of bounds and corrupt the anon_node fields?

> +	up_write(rmap_sem);
> +}
> +
> +static int anon_node_add_child(struct anon_node *anon_nod,
> +	struct vm_area_struct *vma, bool is_fork)
> +{
> +	struct anon_node *child;
> +	struct anon_node *root =3D anon_nod->root;
> +	struct rw_semaphore *rmap_sem =3D anon_node_rmap_sem(root);
> +	struct anon_node *rbc_ch =3D anon_nod, *next;
> +
> +	if (root->depth =3D=3D 0)
> +		root->depth =3D 1;

[Severity: High]
Can this unsynchronized read-modify-write cause data races?

root->depth is being modified outside of any locks. Could a concurrent thre=
ad
allocating a node via anon_node_alloc() read an incorrect parent->depth of 0
instead of 1? Because tree traversals require accurate depths, won't an
incorrectly initialized branch permanently break the tree structure?

> +	child =3D anon_node_alloc(vma, anon_nod, is_fork);

[Severity: High]
Are these newly allocated anon_node objects permanently leaked?

anon_node is allocated with a refcount of 1. During VMA teardown,
unlink_anon_vmas() relies on iterating vma->anon_vma_chain to call
put_anon_vma(). However, since anon_node logic never populates anon_vma_cha=
in,
won't the iteration loop silently skip over it and leak the memory?

[Severity: High]
Does anon_node_alloc() fail to pin the direct parent node?

In anon_node_alloc(), the logic increments the refcount of the root node but
doesn't increment the refcount of the direct parent. If an intermediate par=
ent
node is unmapped, won't its refcount drop to 0 and get freed while it still
has children in its fractal_list? This could lead to a VM_BUG_ON panic or a
use-after-free for the children.

> +	if (!child)
> +		return -ENOMEM;
> +
> +	rmap_sem =3D anon_node_rmap_sem(root);
> +	down_write(rmap_sem);
> +	/* Add new child to the tail of rbc children. */
> +	while ((next =3D anon_node_next_rbc_child(anon_nod, rbc_ch)) !=3D NULL)=
 {
> +		rbc_ch =3D next;
> +	}
> +	list_add(&child->fractal_list, &rbc_ch->fractal_list);

[Severity: Critical]
Does inserting the new child here corrupt the contiguous list iteration?

The iterator macro anon_node_next_rbc_child() strictly expects contiguous
children and returns NULL when node->depth !=3D parent->depth + 1:

mm/internal.h:anon_node_next_rbc_child() {
    ...
    return node->depth =3D=3D anon_nod->depth + 1 ? node : NULL;
}

If an existing child has its own descendants, those descendants interrupt t=
he
contiguous sequence. The loop above stops prematurely at the first child wi=
th
descendants. By inserting the new child via list_add() immediately after th=
at
child, won't the new sibling be placed before the descendants? This would
break the depth check for both anon_node_next_rbc_child() and
anon_node_next_descendant(), permanently severing all subsequent subtrees.

[Severity: High]
Are anon_node objects ever removed from fractal_list during teardown?

Nodes are added to the list here, but it doesn't appear there is a
corresponding list_del() anywhere in the teardown logic. If anon_node_free()
were reached, wouldn't it assert VM_BUG_ON(!list_empty(&anon_nod->fractal_l=
ist))?
Furthermore, freeing a node without removing it from the list would leave
dangling list pointers in its parent and siblings, causing a use-after-free
on the next tree traversal.

> +	++anon_nod->nr_children;
> +
> +	if (is_fork)
> +		vma_set_anon_node(vma, child, true);

[Severity: High]
Are anon_node objects allocated with is_fork=3Dfalse permanently leaked?

When anon_node_track_rmap() expands tracking by calling anon_node_add_child=
()
with is_fork=3Dfalse, the vma_set_anon_node() call here is skipped. Because=
 the
newly allocated child node is never attached to a VMA, is there any mechani=
sm
to track or decrement its initial reference count when the VMA is ultimately
unmapped?

> +	up_write(rmap_sem);
> +	return 0;
> +}
> +
> +/* Returns 0 on success, non-zero on failure. */
> +static int anon_node_track_rmap(struct anon_node *anon_nod,
> +		struct vm_area_struct *vma)
> +{
> +	struct rw_semaphore *rmap_sem =3D anon_node_rmap_sem(anon_nod);
> +	unsigned long rmap_base =3D vma_rmap_base(vma);
> +	struct anon_node *rbc_ch =3D anon_nod;
> +
> +	if (try_track_rmap(anon_nod, rmap_base))
> +		return 0;
> +
> +	down_read(rmap_sem);
> +	while ((rbc_ch =3D anon_node_next_rbc_child(anon_nod, rbc_ch)) !=3D NUL=
L) {
> +		if (try_track_rmap(rbc_ch, rmap_base))
> +			break;
> +	}
> +	up_read(rmap_sem);
> +	if (rbc_ch)
> +		return 0;
> +
> +	return anon_node_add_child(anon_nod, vma, false);

[Severity: Medium]
Should the state be re-validated after acquiring the write lock?

anon_node_track_rmap() searches for a capable child node under a read lock.
If it fails, it drops the read lock and calls anon_node_add_child(), which
takes a write lock to unconditionally allocate and append a node.

Could concurrent threads that fail the read check queue up on the write lock
and blindly append redundant tracking nodes for the exact same rmap_base?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D4
