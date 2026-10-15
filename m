Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99751422E2E
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089282; cv=none; b=UFLJPM2cZ3xC2JUro4w4HpWx6X7Em73t8Gl/mFXIcj3hxKXxDdw33NlTuEiEiaeOfmB4ha+YZGDSxBxSWD0rRg/27C2jtgAK7SllSUW6eBMLuDUr9KEQ8xLvKAHdng7FNyyvNcvsIwXTutF43bMcyJZaz2Zr6qlGzTr1sAOfn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089282; c=relaxed/simple;
	bh=z1ixg32ZEPHFd37cqzMIZLrkeyk33bcMDzWp2dQifNc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z65SS8ehQJYq2tfXNuipEdIuxijgXP91WFli4FELmDZ8/c6AVVVHe/ONqYgLqr9Sh9UG/29Ncaw4ZfVoqU1p9pxzfBBhn36vmrYF7XZxgwJutUm+K4ioErKti+rKAOohS3VJXuCqYcq65vqkZCbGOh64tF2AAT7UJXyurLky3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q15M4mTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q15M4mTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D791F000C5;
	Thu, 15 Oct 2026 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089273;
	bh=pcmUmrz1rUkqtyhdYuyAgKeecrwh9HsMbOL9tz2mDGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q15M4mTyXgr+CeKL5oZCtYnYXaCPoOoT4Xcts0UoE5DQGlanrLewuONggZnIdNegm
	 Y910xxd5m2x8tsRtNBFQOYmmJbjOpXVoX8DGSxfp2c+fdA0iFZr2MJtTJ31jCuQJ5Y
	 HpeKivKOMQLU762AFcaQspdlPz1JD2lHwf2k1wSfydx2TP0BXj778g6CcxfRlosI84
	 zmdDzKvHtbJ+pmXOxo10rwnl9PlKb6PD5ZqpJOpR7LqSseu6nLBNsC7aSYb2T9itnL
	 bGm1+/jUZGvnzh6g+gv7d4QRn0vxoLLKKWixY8puN/b6oUjn2jCHo5YhXoEZxRq2Of
	 a9/cM4rKC43jA==
Message-ID: <sashiko-outbox-173305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/17] mm/mglru: folio LRU refs based active/inactive
 number accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261016-mglru-fg-v4-13-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-13-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:34:32 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: MGLRU tier bits (LRU_REFS_FLAGS) not cleared when updating L=
RU_GEN_MASK
--

commit 97ee7d2a683879e87f8e211218beb97d5cbbba1b
Author: Kairui Song <kasong@tencent.com>

mm/mglru: folio LRU refs based active/inactive number accounting

This commit updates the active/inactive LRU size tracking to use
per-folio referenced counts instead of the generation window. Folios
are now accounted as active once their references reach LRU_REFS_ACTIVATED.

> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6c9510002754b..41c2e9150c709 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
[ ... ]
> @@ -374,7 +373,7 @@ static inline bool lru_gen_add_folio(struct lruvec *l=
ruvec, struct folio *folio,
>  	struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> =20
>  	BUILD_BUG_ON(BIT(LRU_GEN_WIDTH - 1) !=3D MAX_NR_GENS);
> -	VM_WARN_ON_ONCE_FOLIO(gen !=3D -1, folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_lru_gen(folio) !=3D -1, folio);
> =20
>  	if (folio_test_unevictable(folio) || !lrugen->enabled)
>  		return false;
> @@ -383,10 +382,12 @@ static inline bool lru_gen_add_folio(struct lruvec =
*lruvec, struct folio *folio,
>  	gen =3D lru_gen_from_seq(seq);
>  	flags =3D (gen + 1UL) << LRU_GEN_PGOFF;
>  	/* see the comment on MIN_NR_GENS about PG_active */
> -	set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK | BIT(PG_active), fla=
gs);
> +	flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK | BIT(PG_ac=
tive), flags);

[Severity: Medium]
Should LRU_REFS_FLAGS be included in the mask cleared by set_mask_bits() he=
re?

When a folio is added to a generation and LRU_GEN_MASK is modified, leaving
stale tier bits (LRU_REFS_FLAGS) intact can allow them to persist. This
could inadvertently inflate access counts and distort future eviction track=
ing.

> +	/* use the refs from the atomic snapshot to avoid raced update */
> +	refs =3D lru_get_refs_flags(flags);
> =20
>  	lru_gen_update_size(lruvec, folio, -1, gen);
[ ... ]
> @@ -402,24 +403,31 @@ static inline bool lru_gen_add_folio(struct lruvec =
*lruvec, struct folio *folio,
>  static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio=
 *folio, bool reclaiming)
>  {
>  	unsigned long flags;
> -	int gen =3D folio_lru_gen(folio);
> +	int gen, refs;
>  	int zone =3D folio_zonenum(folio);
>  	int delta =3D folio_nr_pages(folio);
>  	enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_FILE;
> +	unsigned long max_seq =3D READ_ONCE(lruvec->lrugen.max_seq);
> =20
> +	flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, 0);

[Severity: Medium]
Could this mask also be missing the LRU_REFS_FLAGS bit clear?

Similar to the addition path above, when isolating a folio and clearing
LRU_GEN_MASK, the tier tracking bits might also need to be explicitly
cleared so they are not improperly carried over.

> +	gen =3D lru_get_gen_flags(flags);
> +	refs =3D lru_get_refs_flags(flags);
>  	if (gen < 0)
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D13
