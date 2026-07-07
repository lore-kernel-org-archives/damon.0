Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518D3C0A1C
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408317; cv=none; b=Izkh3I9YM3+XMOY+Rgdgk7gmjIUJ+Wnf8oDvFrSk+iDYdEQc1zYR2wEgA/bgaQO/F8s8tDjoybhEZWh4Pq1Nk0P5iTyJkiOQ5o2Y+FA3k9COWrwbgo53Co3FRjZkACUZzT6dqFeHqX/QjkYIxuR6jv7iqRBT4xPItJeP9cUXtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408317; c=relaxed/simple;
	bh=E8N/V9lMWzZDSqohtcyNcBNozpGRuDf5r746E3WkGag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aw/3MOrrslcCjTXL7FK6sLrDlQS3bWp3Nh82W+x62p/pSKfLzYGB8f+YRmIAjBajui/7YLLY505NF4fv9DcM+W4ddjR4yoTKwJ5JwCm8wIHDfksxQBtJEDAw6oq0jMLHDCvs6A/wAzuaUEEKDSg4A6uCPw1sEpHdb8Y+tdFmGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+N9TnQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+N9TnQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EAF1F01558;
	Tue,  7 Jul 2026 07:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408312;
	bh=hum5V8dDiOMOai48JL72cxCWR7Ua5LDeCVYLbNZQD3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+N9TnQ+UyojOQi0zK5iS4/9774W91OFm4EnQA2iwggbdQb3mFksryJHmccLf/DQS
	 ptSt6rkObHDzGcJUiok0fsF0J6eDc6ZVuBcPHkiwEkA5yIqSYXpfO79U4NsjZUGcL8
	 pjTbltN5pCAkjQC6LGP8GnEg7ydZgjjPbWnRlPJTKl/4irORDY156/a/kOBgsgOAnr
	 yi37G4bga1I1QhuGUvVIg+RUVoWPPvAG3tdoNAY5yQzEHhseD9D/j04CADwogdpLLu
	 2ESzi/1tfPv55VQjw45rVa+1PeGoPZ7QM+B0zOr0KG6Uu79gcbChLMD61dzvIrgikW
	 dLtR9644kXP8w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/13] mm: add CONFIG_ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-2-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-2-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:11:51 +0000
Message-Id: <20260707071152.20EAF1F01558@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Pre-order tree traversal iterators are broken due to heterogen=
eous depth increments, causing cross-process memory corruption and missed V=
MAs during reverse mapping.
- [Medium] PAGE_SIZE-dependent VMA sharing limit causes severe memory bloat=
 and arbitrary lock contention scaling.
- [Low] Duplicate and conflicting type directives for ANON_VMA_FRACTAL.
--

--- Patch [1]: [RFC PATCH v2 01/13] mm: add CONFIG_ANON_VMA_FRACTAL ---
commit 7f3f3b3fc54ea6c9180e3a0f624b7af6752d7ca5
Author: tao <tao.wangtao@honor.com>

mm: add CONFIG_ANON_VMA_FRACTAL

This commit adds the CONFIG_ANON_VMA_FRACTAL option to replace the
anon_vma_chain. It uses vma_rmap_base to compute page addresses and
organizes anon_vmas into a fractal list based on fork depth.

> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 8dc0871e5f001..75738f4ede1f6 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
[ ... ]
> @@ -67,6 +67,54 @@ struct anon_vma {
[ ... ]
> +/* Create rbc child anon_node on VMA remap or when count exceeds MAX. */
> +#define ANON_RMAP_BASE_COUNT_MASK	(PAGE_SIZE - 1)
> +#define ANON_RMAP_BASE_COUNT_MAX	(ANON_RMAP_BASE_COUNT_MASK)
> +
> +/*
> + * Allow VMAs to share an anon_node only if the number of VMAs attached
> + * is below this limit; keep it small to reduce lock contention.
> + */
> +#define ANON_NODE_SHARE_LIMIT	(ANON_RMAP_BASE_COUNT_MAX / 1000)

[Severity: Medium]
Since ANON_RMAP_BASE_COUNT_MAX relies on PAGE_SIZE, does this create an
artificially low sharing limit on 4K systems?

On a system with 4K pages, ANON_RMAP_BASE_COUNT_MAX would evaluate to 4095.
Dividing by 1000 means ANON_NODE_SHARE_LIMIT becomes 4, which would force a
new anon_node allocation very frequently and could cause memory bloat.

> +
> +#endif
> +
>  /*
>   * The copy-on-write semantics of fork mean that an anon_vma
>   * can become associated with multiple processes. Furthermore,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f794a341d7422..e0a1e96c6835a 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1451,6 +1451,34 @@ config LOCK_MM_AND_FIND_VMA
>  	bool
>  	depends on !STACK_GROWSUP
> =20
> +config ANON_VMA_FRACTAL
> +	bool "anon_vma fractal list"
> +	def_bool n

[Severity: Low]
This isn't a bug, but using both a bool prompt and def_bool together
conflicts with standard Kconfig syntax. Could we just use bool and
default n instead?

> +	depends on MMU
> +	help
> +	  This option uses vma_rmap_base(vma) during rmap to compute the page
[ ... ]
> diff --git a/mm/internal.h b/mm/internal.h
> index 841c27611627e..694d3194a6baf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
[ ... ]
> @@ -252,6 +262,24 @@ static inline void anon_vma_unlock_read(struct anon_=
vma *anon_vma)
>  	up_read(&anon_vma->root->rwsem);
>  }
> =20
> +#ifdef CONFIG_ANON_VMA_FRACTAL
> +
> +static inline struct anon_node *anon_node_next_rbc_child(
> +		struct anon_node *anon_nod, struct anon_node *node)
> +{
> +	node =3D list_next_entry(node, fractal_list);
> +	return node->depth =3D=3D anon_nod->depth + 1 ? node : NULL;
> +}

[Severity: Critical]
Will this iteration abort prematurely if the next entry in the list is a
descendant of the RBC child?

If an RBC child has its own descendants, they would immediately follow it in
the list. Since anon_node_next_rbc_child() in mm/internal.h strictly expects
the very next list entry to have depth =3D=3D anon_nod->depth + 1, it appea=
rs it
would return NULL and stop iteration early, potentially missing VMAs.

> +
> +static inline struct anon_node *anon_node_next_descendant(
> +		struct anon_node *anon_nod, struct anon_node *node)
> +{
> +	node =3D list_next_entry(node, fractal_list);
> +	return node->depth > anon_nod->depth ? node : NULL;
> +}

[Severity: Critical]
Could this traversal yield unrelated siblings as descendants when depth
increments are mixed?

Since RBC children increment depth by 1 and fork children increment by 2, a
process calling mremap (creating an RBC child) followed by fork (creating a
fork child) will create mixed increments.

If we iterate descendants of an RBC child (depth P+1),
anon_node_next_descendant() in mm/internal.h would continue as long as
node->depth > anon_nod->depth. A sibling fork child with depth P+2 would
satisfy this condition and incorrectly be yielded as a descendant,
potentially leading to cross-process memory corruption during rmap
traversals.

> +
> +#endif
> +
>  struct anon_vma *folio_get_anon_vma(const struct folio *folio);
> =20
>  /* Operations which modify VMAs. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D1
