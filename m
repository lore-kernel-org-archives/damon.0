Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432B2F8EB4
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412558; cv=none; b=TPh0gGSB51No3ANbRoQ1fIJp3bQ0rsRO/Gt8yui2Hj21rWCcRqMIeva3Y8C+UJDaLs6fDrOJsKEBk4fq54XotLH6MC6Wd7lcTI8rJSWRPj5J5KU2Av0Xv6i7kPaj1M5iaxAfH7jUnLVILw9CZNnrTmZsa8SqKyxoSNLGrLHRqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412558; c=relaxed/simple;
	bh=W9ibZ60YhjBLhhr43cujQGaEtdWSDaORXCtVjXG2nnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jbi0f3eIp2V/UMB9gH+CgzknKlMAjV2t6R7DQbato7e5h3R61+wlG2sM1eLeJ/putKoi9/3cFrrDBaTHtooyijZW+QGXv0Qb9bkt0gohhSAwSjMUTt8T7UpAchYuvUoTrgEwwuMKPPqpbUvUu2HE1UN7KvLINBj+MUcwFrU+pp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcPytoAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcPytoAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E437D1F000E9;
	Tue,  7 Jul 2026 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412557;
	bh=7I++CT2TnydnvaoBZDQ+80UkLeH8CL/7+iQY40CfTd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcPytoAlaYnKtlrL3jl6O1b40ec29aKxBdC8CKZqsalq5sxwS/1vKdYtY6P855Y2m
	 LEGzShPpSMFB5YtcnZfZQEzj/PaNgb07zjnJ11TjpIPtOr+w9VCsdoRVB5DKn3PEo2
	 uLuy3pLbxHVzW10vZDVt9nmfZHUNVRG1UCZQ1Les/aknrr8FLpdT6K5JVdwFvHU94Q
	 82BrpeYLGcq8FQz3kNoFIr/nOeMKMdojdf7exwHB05QA8ZF4aTQzMvUrnq9pMAs+bo
	 GNCh4DMJhHAwTBxlA7FSb/U3m0aAEqB8E2qVJe3egaIXZ1d7HQ8AugJc5SidyzYrmb
	 JVuoB+ERJgguw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/13] mm: implement anon_node_fork_with_prev for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-6-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-6-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:22:36 +0000
Message-Id: <20260707082236.E437D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing child-to-parent reference pinning allows parent `anon_=
node`s to be freed while descendants retain dangling pointers.
- [Critical] Reusing an ancestor `anon_node` for a fork child VMA breaks th=
e reverse mapping hierarchy, preventing shared pages from being unmapped.
- [High] Lockless update of `node->mm` in `fork_reuse_ancestor()` creates a=
 data race with concurrent page table walkers, leading to Use-After-Free.
- [High] Child `anon_node`s are never unlinked from `fractal_list`, causing=
 `anon_node_free()` to trigger `VM_BUG_ON` and leaving dangling pointers.
- [High] Missing `unlink_anon_nodes` implementation results in a permanent =
memory leak of all `anon_node` structs.
--

--- Patch [5]: [RFC PATCH v2 05/13] mm: implement anon_node_fork_with_prev =
for ANON_VMA_FRACTAL ---
commit 24cea8e5be0b7dbc9e5d9160c41d3819f2dc0c2e
Author: tao <tao.wangtao@honor.com>

mm: implement anon_node_fork_with_prev for ANON_VMA_FRACTAL

Fork handling introduces two additional parameters to help child VMAs
clone anon_node. The logic follows three cases:
1) Fast path: clone the anon_node with the previous VMA.
2) Reuse an empty anon_node from an ancestor.
3) Allocate a new anon_node and insert it into fractal_list.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 9dc82e7438b00..9e86f64ea9e53 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> @@ -788,6 +799,67 @@ int anon_node_clone(struct vm_area_struct *vma,  str=
uct vm_area_struct *src,
>  	return anon_node_track_rmap(anon_nod, vma);
>  }
> =20
> +static struct anon_node *fork_reuse_ancestor(struct anon_node *parent,
> +		struct vm_area_struct *vma)
> +{
> +	struct anon_node *root =3D parent->root;
> +	struct anon_node *node;
> +	unsigned long new_rbc =3D vma_rmap_base(vma) + 1;
> +	/* At least N anon_nodes between parent and root: P -> a1 .. aN -> R */
> +	const unsigned int ANON_DEPTH_REUSE_THRESHOLD =3D 1 + (5 << 1);
> +
> +	if (parent->depth < ANON_DEPTH_REUSE_THRESHOLD)
> +		return NULL;
> +
> +	/* Release from leaf only; parent is stable, no lock needed. */
> +	for (node =3D parent; node !=3D root; node =3D node->parent) {

[Severity: Critical]
Does this traverse upwards using the unpinned node->parent pointer?

It looks like anon_node_alloc() pins the root but fails to increment the
refcount of its immediate parent:

mm/rmap.c:anon_node_alloc() {
    ...
    anon_nod->parent =3D parent;
    anon_nod->depth =3D parent->depth + (is_fork ? 2 : 1);
    get_anon_node(parent->root);
    ...
}

If all VMAs attached to the parent are unmapped, the parent node's refcount
could drop to 0 and be freed. Could this regression result in a use-after-f=
ree
when this loop traverses node =3D node->parent?

> +		if (READ_ONCE(node->nr_children) > 1)
> +			continue;
> +		/* Replace with the new_rbc atomically. */
> +		if (!try_reuse_anon_node(node, new_rbc))
> +			continue;
> +
> +		node->mm =3D vma->vm_mm;

[Severity: High]
Can updating node->mm locklessly after try_reuse_anon_node() cause a
use-after-free regression?

try_reuse_anon_node() atomically updates rbc, which publishes the node as a=
ctive
to concurrent rmap walkers traversing the fractal_list.

Since node->mm is updated after this atomic operation, could a concurrent
rmap walk observe the active node via rbc but read the old, potentially fre=
ed
node->mm pointer before the assignment completes?

> +		vma_set_anon_node(vma, node, false);
> +		return node;

[Severity: Critical]
Does reusing an ancestor anon_node for a fork child VMA break the reverse
mapping hierarchy?

The reverse mapping algorithm relies on traversing downwards from the anon_=
node
where a page was faulted to find all descendant VMAs sharing the page.

If an empty ancestor node is assigned to the fork child without relocating =
it
in the tree, shared pages mapped by the parent before the fork will point to
the parent's anon_node.

When rmap_walk starts at the parent, will it completely miss the child VMA
because its node (the ancestor) is structurally above the parent?

> +	}
> +
> +	return NULL;
> +}
> +
> +/* Clone an anon_node from prev or fork one from the parent pvma. */
> +int anon_node_fork_with_prev(struct vm_area_struct *vma,
> +	struct vm_area_struct *pvma, struct vm_area_struct *prev,
> +	struct vm_area_struct *pvma_prev)
> +{

[ ... ]

> +	/* 3) Fork a new anon_node. */
> +	return anon_node_add_child(parent, vma, true);
> +}

[Severity: High]
Are child anon_nodes ever unlinked from fractal_list?

In anon_node_add_child(), new child nodes are added to their parent's
fractal_list:

mm/rmap.c:anon_node_add_child() {
    ...
    list_add(&child->fractal_list, &rbc_ch->fractal_list);
    ...
}

However, there doesn't seem to be a corresponding list_del() for when the n=
ode
is destroyed. When a node is ultimately freed, won't anon_node_free() trigg=
er
its VM_BUG_ON(!list_empty(&anon_nod->fractal_list)), or leave a dangling po=
inter
in the parent's list?


[Severity: High]
Is the implementation of unlink_anon_nodes() missing from this patchset?

mm/internal.h declares unlink_anon_nodes() to handle VMA teardown:

mm/internal.h:
    void unlink_anon_nodes(struct vm_area_struct *vma);

But the function doesn't seem to be implemented or invoked. Additionally,
vma_set_anon_node() does not add entries to vma->anon_vma_chain.

Without a teardown hook executing, won't the anon_node refcounts never be
decremented, resulting in a permanent memory leak regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D5
