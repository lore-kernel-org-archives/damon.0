Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B391405F7
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409970; cv=none; b=izQQ6VJETJ6T200TYq27D3AJ73VDz55KU8XG2Kds5yoGX+abU0WX8pPIGW79gQ69/Zcw9USkKZX/Q6VfuZlAEkMt/vVq69cjyzrI/fGCupJ7hyBLqRs+cH0uLzuUe+UJI2N8SqfOdkvb+JUZwSlbkBotcJIlTfxhib8pQiGZpOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409970; c=relaxed/simple;
	bh=6Szhevt3OKtyNSn8aw3FMpnrEOSo/Mx+cGNQ19Qfc3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N29ZBWxyborgOen1tuBMp5gp/wtEPhk9LbNLp0rz9D4aCP7NUaJesXlpOSv6MUciprtZuOKljvuBUVk2+/xlhzVzESGd18v6nvqFSx+KmS/i/jIuzw6Uk5zg54wcUxSusmGM+/nxhv7XJnfSNoXJPsxG1WZGV4Zao++hLSS5q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpmWeUCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpmWeUCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046021F000E9;
	Tue,  7 Jul 2026 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409969;
	bh=QPxylN4V9wXsK9/bnox9AY5+x/CmP3AU8kivmf0wN94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpmWeUCaG13/0z7qdkNSQhvPus9fl4lb3A3vV/0HMvC8B+rSHirwNwzXOSNZ7Knuc
	 zWNPFMH1wkEtxopYvbUQqtoxis7E0eLRt5+KzXfgGd5fYogl2kKcCPplXeLZ7n7Yfx
	 iA+VPu2mAWEJCp5VXntLODqaa3e0f/MgeNrPipV71D6Ry2/Y6DeZ9r9RaxPaq9fJm9
	 CQSWhQINrGhEm8CpY2C25Uc7X7idDi7jEQepIYHpOiYy+sgnJN09CaGMcGs7GOl5IH
	 ZGeXc4Y9TjUwpBGAsAvVxI+RxkRkz0zyVbuGf5+gJamra/nd25+RQd7SPgI7aReqx0
	 nfNVacCx39SVA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/13] mm: implement __anon_node_prepare for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-4-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-4-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:39:28 +0000
Message-Id: <20260707073929.046021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] `__anon_node_prepare` casts a `struct anon_node *` to a `struc=
t anon_vma *` and assigns it to `vma->anon_vma`, resulting in severe type c=
onfusion.
--

--- Patch [3]: [RFC PATCH v2 03/13] mm: implement __anon_node_prepare for A=
NON_VMA_FRACTAL ---
commit 1ab3065664fb86573b65c2ad490a2b4e7c508707
Author: tao <tao.wangtao@honor.com>

    mm: implement __anon_node_prepare for ANON_VMA_FRACTAL

This commit introduces anon_node APIs corresponding to existing anon_vma
operations for the ANON_VMA_FRACTAL feature. It currently implements
__anon_node_prepare() to attach an anon_node to a VMA.

> diff --git a/mm/rmap.c b/mm/rmap.c
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

[ ... ]

> +int __anon_node_prepare(struct vm_area_struct *vma)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +	unsigned long rmap_base =3D vma_rmap_base(vma);
> +	struct anon_node *anon_nod;
> +	struct anon_vma *anon_old =3D NULL, *anon_new;

[ ... ]

> +	anon_nod =3D anon_node_alloc(vma, NULL, false);
> +	if (unlikely(!anon_nod))
> +		return -ENOMEM;
> +
> +	anon_new =3D (struct anon_vma *)anon_nod;
> +	/* maybe prepared by another thread */
> +	if (!try_cmpxchg(&vma->anon_vma, &anon_old, anon_new)) {

[Severity: Critical]
Will this cause memory corruption for existing reverse mapping and page fau=
lt
paths that expect a standard anon_vma?

Because struct anon_node and struct anon_vma have significantly different
memory layouts, storing an anon_node pointer into vma->anon_vma will cause
type confusion. For instance, anon_node places vm_lock_ref at the exact
memory offset where anon_vma expects refcount.=20

When standard VMA operations (like folio_lock_anon_vma_read() or
unlink_anon_vmas()) access vma->anon_vma->refcount, won't they read and wri=
te
the wrong fields, corrupting vm_lock_ref and permanently leaking the anon_n=
ode
since its actual refcount is never decremented?

> +		try_untrack_rmap(anon_nod, rmap_base, &test_empty);
> +		put_anon_node(anon_nod);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D3
