Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91F3CE0B8
	for <damon@lists.linux.dev>; Wed, 27 May 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884967; cv=none; b=X1IjFZY4G9lTA9qPBrzbPho+3QU7KQBJTFoSRhvZvaGztTizYRGSPbhJTNyIJ+I4pew+wNNp69LjCIH/zTfC1QD3iRb0M3t0S3PsTTbynuycQIb/+ga+oT/vV62h9CUj/gXXIXoHPpM2Ib6IjgTkuTTmuNACQDy74OFlc10ygOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884967; c=relaxed/simple;
	bh=Ac1STWrCRJFIp1fMC1UC4YGbY9ersuoTMmewRvjl1+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXUXNP5Axibtn6QThqPazAT6J99yRhX0Nhz7BN3LM7Yas1WAZ7QOOLl9fyypgjZZl3AObMznUcmihPumGvaz3d1ttKMWoQyZbJg6asPeufCxt9aGNXgx0I9Y3HdU4rPnc5hH1Slg0yDvLrZwpGMpJH6QCPWKMlmckwRAeMBQ28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRgpt+yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRgpt+yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DADA1F00A3A;
	Wed, 27 May 2026 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779884966;
	bh=yhGpZXMBRuNeUcvyj921Xam738jkgnawbAyZiJI6S9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PRgpt+yCBwxon84iJg/htsyTL6lUPqsXL+JS5gMgx9guwHaBqmfMbJnyjlup0zKqG
	 gSsf/QkFeMc0Jkn3IIBe4IVs/u3GFHCMhqEuAVCHQSLUGzfLGdgjeyMeqFTnKz4JQM
	 vgGpfYQPgpD8l1/ol3PE5KPfAuw4G1gizHQZLCRv79yMQfaq2l97fqF5wXhcqjyjv5
	 Xdr60dVv5IXcHzj4ngYMu6J09gDoZbB6kahDygERyZgDRG2PasvrarFqS+iWyBnsHH
	 bUrHBKyyR1BpcJ+0rIwXtBdRr+OIh1gdTw+G5a3/seS082sk54sk3VFd2y1fLUrhNV
	 YOMgigrce+w0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] mm: defer anon_vma creation with ANON_VMA_LAZY
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-11-tao.wangtao@honor.com>
References: <20260527110147.17815-11-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:29:25 +0000
Message-Id: <20260527122926.3DADA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional increment of the root anon_vma refcount when reusing=
 an existing anon_vma causes a memory leak.
--

commit e7b82bf7c91f9ff13c87c5b6d44b365dcfcf93c5
Author: tao <tao.wangtao@honor.com>

mm: defer anon_vma creation with ANON_VMA_LAZY

This commit defers anon_vma creation until fork by marking VMAs as
ANON_VMA_LAZY to reduce allocation overhead. During fork, lazy VMAs are
upgraded to establish the sharing topology, and child VMAs are created
without allocating a new anon_vma.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12693c6897120..59848e1aaf531 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> @@ -282,19 +393,30 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
> =20
>  	anon_vma =3D find_mergeable_anon_vma(vma);
>  	allocated =3D NULL;
> -	if (!anon_vma) {
> +	/* If parent_anon_vma exists, mergeable anon_vma root must match it. */
> +	if (!anon_vma ||
> +		(parent_anon_vma && anon_vma->root !=3D parent_anon_vma->root)) {
>  		anon_vma =3D anon_vma_alloc();
>  		if (unlikely(!anon_vma))
>  			goto out_enomem_free_avc;
> -		anon_vma->num_children++; /* self-parent link for new root */
>  		allocated =3D anon_vma;
> +		if (parent_anon_vma) {
> +			anon_vma->root =3D parent_anon_vma->root;
> +			anon_vma->parent =3D parent_anon_vma;
> +		}
>  	}
> =20
>  	anon_tree =3D make_anon_vma_tree(anon_vma);
> +	if (upgrade_lazy)
> +		is_lazy =3D vma_unlink_anon_vma_lazy(vma, anon_tree);
>  	anon_vma_tree_lock_write(anon_tree);
>  	/* page_table_lock to protect against threads */
>  	spin_lock(&mm->page_table_lock);
> -	if (likely(!vma->anon_vma)) {
> +	if (likely(!vma->anon_vma || is_lazy)) {
> +		if (anon_vma->root !=3D anon_vma)
> +			get_anon_vma(anon_vma->root);

[Severity: High]
Does this code leak the root anon_vma when reusing an existing anon_vma?

When find_mergeable_anon_vma() finds a compatible anon_vma to reuse,
allocated is left as NULL. However, the code proceeds to unconditionally
call get_anon_vma(anon_vma->root) as long as anon_vma->root !=3D anon_vma.

The root's refcount tracks the number of child anon_vma structs, not the
number of VMAs sharing the child anon_vma. Because a new anon_vma was not
allocated, the root's refcount was already correctly incremented when the
existing child anon_vma was originally created.

When the VMAs are later unmapped and the child anon_vma's interval tree
becomes completely empty, __put_anon_vma() is called exactly once for the
child anon_vma, which decrements the root's refcount exactly once. Since the
root's refcount is incremented every time a VMA reuses the child anon_vma
but only decremented once when the child is freed, it seems the extraneous
references will permanently leak root anon_vma structures.

> +		if (allocated)
> +			anon_vma->parent->num_children++;
>  		vma->anon_vma =3D anon_tree;
>  		anon_vma_chain_assign(vma, avc, anon_vma);
>  		anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D10
