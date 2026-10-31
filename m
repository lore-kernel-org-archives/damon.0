Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479003;
	b=PL05OHDS5Tsef4u7jsMUuUbaD0s++SDgTr+vXTyGz4+9Af1dmyt/Ropgd9953wCzr2I+
	 aJAfsEXK89E0Lngp7P23RJI4z9juhUPdDOEAPy5S5qn0k9Cx/pITgOlVoRHTux9bNYMZ/
	 qjVP1bE9+INnYf4zBQoYnSJjvdIWAKeJDQb8qr7HfDdlps9hsor/CTKlunqIGkvnvFhcO
	 2Kl5evZrQaVfmhgh9dgox5ZkslhONTaeG1zMM0WE/hwFEnRIHJJboM0Xg5ss3ieRvqfN7
	 JEegqQYDDDLc+Y4UoKRpRxDbWaLNBayk1ZvDWdr8tlKG1WdWzw+0DGY4JxUWV33cxQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q1FLDEmGnWMRgBUd/62r3WuYHm0P7ulS+ZFGuHNlRhs=;
	b=BLRDLO9Jo4hm6XDy9Sve7mlhyFRQ9V/Pv7GBs+Qtm2/5gx5yMrMTOWlsDK3bgeCvrPPq
	 vomudeAKdA7vIgxB5VtWDkRpMFpwSrwJcmjt7Ew7CsP5LWdRUIUx0ur0j/5p6iWNwbOkr
	 apXXDH6Cy5da9W1rMrkzVevARFG+Bc3Oi7ISlN7T6pkew6B7SRT22O7zDJXUpLlVVSgeS
	 CpSV5BxxScFuGM+3BijaZoY8Cpwm4YizTjfdE+GcLwa/rQ0o0637SzlJT/osRbk8Zui3G
	 v6ayuNMQYZK0IUgqwwitZGd6XQtvk6TCvdMf3GCmY0j14Sk9rb/Ew4V+8II8lnRAFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBkXbKm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A1606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBkXbKm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4FE1F000C1;
	Sat, 31 Oct 2026 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793479002;
	bh=Q1FLDEmGnWMRgBUd/62r3WuYHm0P7ulS+ZFGuHNlRhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBkXbKm0ggNaVdYj3PLU457vdE8DIw4WdjhJH7utu9m9MiI2gHhu5DoA5F2ozLy3H
	 obgcQknCpoL9hjk9AKez74ZHsER4E5uouIY2eyc4sshTDmSphMrIcesMIlqE9YmXeL
	 7tGytCPZgt/MuuJj1WdEth1PnVua4sidm6Am/rxmsb8lTze0EweEPsgi7MdyHtaYXe
	 O47UkGmOQAmL105q33xrAYpzxhRlaXdnKB/cCNqOm01S4/jPRoONubrmTgN/mHhe7A
	 HoZWfM66k+gW4Yglj+0UduQUU4ZXUJuZomdQ8AQikjm30R94Miz2StRk5BEUnn987G
	 Wl38HzVtqMBiw==
Message-ID: <sashiko-outbox-192119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] mm/damon/vaddr: implement sz_filter_passed for
 migrate_{hot,cold} action
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261031202614.96036-4-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
 <20261031202614.96036-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:36:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] mm/damon/vaddr: uninitialized priv.sz_filter_passed in damos_v=
a_migrate()
- [Medium] mm/damon/vaddr: double-counted sz_filter_passed in damos_va_migr=
ate_pmd_entry()
--

commit 872d2945863aba3a6ac672128498f5d65dbc8d40
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action

This commit adds sz_filter_passed accounting to the DAMON virtual address
space implementation of the migrate_hot and migrate_cold DAMOS actions by
accumulating folio sizes in damos_va_migrate_pmd_entry().

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index c271b6d63c027..112095c2d53fd 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -776,6 +776,7 @@ static bool damos_va_filter_out(struct damos *scheme,=
 struct folio *folio,
>  struct damos_va_migrate_private {
>  	struct list_head *migration_lists;
>  	struct damos *scheme;
> +	unsigned long *sz_filter_passed;
>  };
> =20
>  /*
> @@ -840,6 +841,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
>  	struct damos_va_migrate_private *priv =3D walk->private;
>  	struct list_head *migration_lists =3D priv->migration_lists;
>  	struct damos *s =3D priv->scheme;
> +	unsigned long *sz_filter_passed =3D priv->sz_filter_passed;

[Severity: Critical]
Is priv.sz_filter_passed ever initialized before the page walk runs?

In damos_va_migrate(), struct damos_va_migrate_private priv is declared on
the stack without an initializer, and only priv.scheme and
priv.migration_lists are set before calling damon_va_walk_page_range():

mm/damon/vaddr.c:damos_va_migrate() {
	...
	struct damos_va_migrate_private priv;
	...
	priv.scheme =3D s;
	priv.migration_lists =3D kmalloc_objs(*priv.migration_lists, nr_dests);
	if (!priv.migration_lists)
		return 0;

	for (int i =3D 0; i < nr_dests; i++)
		INIT_LIST_HEAD(&priv.migration_lists[i]);


	mm =3D damon_get_mm(target);
	if (!mm)
		goto free_lists;

	damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
	...
}

When damon_va_apply_scheme() invokes damos_va_migrate() for DAMOS_MIGRATE_H=
OT
or DAMOS_MIGRATE_COLD and damos_va_migrate_pmd_entry() encounters a present
folio that passes damos_va_filter_out(), won't *sz_filter_passed +=3D
folio_size(folio) dereference an uninitialized stack pointer?

>  	struct damos_migrate_dests *dests =3D &s->migrate_dests;
>  	struct folio *folio;
>  	spinlock_t *ptl;
> @@ -858,6 +860,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
>  			goto huge_out;
>  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
>  			goto huge_out;
> +		*sz_filter_passed +=3D folio_size(folio);
>  		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
>  				migration_lists);
>  huge_out:
> @@ -885,6 +888,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
>  		nr =3D folio_nr_pages(folio) - page_idx;
>  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
>  			continue;
> +		*sz_filter_passed +=3D folio_size(folio);

[Severity: Medium]
Can *sz_filter_passed double-count a large folio that spans across multiple
adjacent damon_region ranges?

In damos_va_stat_pmd_entry(), the walk checks damos_va_invalid_folio(folio,=
 s)
and records s->last_applied =3D folio so that a PMD-mapped THP or PTE-mapped
large folio overlapping more than one damon_region is only counted once per
scheme application pass:

mm/damon/vaddr.c:damos_va_stat_pmd_entry() {
		...
		if (damos_va_invalid_folio(folio, s))
			goto huge_unlock;

		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
			*sz_filter_passed +=3D folio_size(folio);
		s->last_applied =3D folio;
		...
}

In damos_va_migrate_pmd_entry(), s->last_applied is neither checked nor
updated on either the THP path or the PTE loop path. If a large folio spans
multiple regions and is not migrated during the first region's walk (for
example, because folio_nid(folio) already matches the target node in
damos_va_migrate_dests_add(), or because isolation or migration fails),
walking the next overlapping damon_region will encounter the same folio and
add the full folio_size(folio) to *sz_filter_passed again.

Should damos_va_migrate_pmd_entry() also check damos_va_invalid_folio(folio,
s) and update s->last_applied =3D folio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031202614.9603=
6-1-sj@kernel.org?part=3D3
