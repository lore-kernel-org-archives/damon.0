Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D23F8704
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881564; cv=none; b=PYqJZVBx591jyusGCyx4OOlKzyOR5sE5hpgrJ0kGdhx9dgjXhqO+ddUV9PYg7lWkJoiayFXq6Rq5TQtlbVtKJDyIJNmE2Em2sxq/YWDrX9C7Yz0tREDFkBVCPQe7jjJPL9RWT3/IBl4lrzzSQSHNhhY1zC4Pi9aGBBObgUqUaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881564; c=relaxed/simple;
	bh=dSWsUeyESjcZYMHhKHSsxAyTSiOt8EQlrU45mmDu/IM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JIA52rpjK1BH8QmCnl9ZKXUPIsrKuEZhD6XARfWTiSHNLleM8YchDERwPzneUZqOovq5358T+q24Mt/l8P50Qmi+JdkWoEqxShRFwUEctBOkyrYI9/QGJDz66d+ZEtJs7tUO4TQNB5KnkJR72CImNsEjVh9aRvAeVRRUkovMF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnT48kEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnT48kEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2AF1F000E9;
	Wed, 27 May 2026 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881542;
	bh=y/iorp4MB0CFR9WqD7WS3Fpc0t/kcljKcMckaT6bOB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnT48kEavlE16yV47nl2xn0x1Pa48wZsSgKErflSwgW5Ld614cCOyyxaCjqGQl1M6
	 WNr4uFc3YzadKp4yDiLHNyrHYAmDNJgtk7eiToornqis5kq7sRvpgCdV6hpl3VPf94
	 ut8HOZ/gwjgaQmODOzK8QKEPuiy4CtHuD6FUwih+CyNfDzri2DydTrudjCRK7PoGj6
	 zA8ptF7pOXjw8PddbY8ORNF5hVGj3806nTBjFWm5y0KlZROGxJVRumecPCKx6pWPRr
	 IFvm98DFc5ZXXh314bCpAMb4C0SwYk0dbEt6aypHtaqoyp4IHM5T4YeKtprqFbtPHJ
	 jWHJSOUg9Jupw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] mm/rmap: introduce anon_rmap APIs for anonymous
 folios
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-2-tao.wangtao@honor.com>
References: <20260527110147.17815-2-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:32:21 +0000
Message-Id: <20260527113222.3B2AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Lockless reads of anon_vma->root in folio_maybe_same_anon_vma() la=
ck READ_ONCE(), causing data races.
- [High] The anon_rmap_t API lacks a NULL validation helper and its cleanup=
/lock functions crash on ANON_RMAP_NULL.
- [Medium] vma_get_anon_rmap() incorrectly uses mmap_assert_locked(vma->vm_=
mm) instead of vma_assert_locked(vma).
- [Medium] The anon_rmap_foreach_vma macro evaluates the anon_rmap argument=
 multiple times, creating an API hazard.
--

commit d698495fb94a40d2764331cdf26a351a9f9a97a3
Author: tao <tao.wangtao@honor.com>

mm/rmap: introduce anon_rmap APIs for anonymous folios
   =20
This patch adds a set of anon_rmap APIs to operate on the reverse mappings
of anonymous folios. It introduces anon_rmap_for_each_vma() as a wrapper
around the interval tree to prepare for RCU-based lockless rmap traversal.

> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 8dc0871e5f001..c42314ea43622 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
[ ... ]
> @@ -969,6 +1007,36 @@ void rmap_walk_locked(struct folio *folio, struct r=
map_walk_control *rwc);
>  struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
>  					  struct rmap_walk_control *rwc);
> =20
> +bool folio_maybe_same_anon_vma(const struct folio *folio,
> +	const struct vm_area_struct *vma);
> +anon_rmap_t folio_get_anon_rmap(const struct folio *folio);
> +anon_rmap_t folio_lock_anon_rmap_read(const struct folio *folio,
> +	struct rmap_walk_control *rwc);
> +
> +static inline struct vm_area_struct *anon_rmap_iter_first_vma(
> +	anon_rmap_t anon_rmap, unsigned long start, unsigned long last,
> +	struct anon_vma_chain **avc)
> +{
> +	struct anon_vma *anon_vma =3D anon_rmap_to_anon_vma(anon_rmap);
> +
> +	*avc =3D anon_vma_interval_tree_iter_first(&anon_vma->rb_root, start, l=
ast);
> +	return *avc ? (*avc)->vma : NULL;
> +}
> +
> +static inline struct vm_area_struct *anon_rmap_iter_next_vma(
> +	anon_rmap_t anon_rmap, unsigned long start, unsigned long last,
> +	struct anon_vma_chain **avc)
> +{
> +	if (!*avc)
> +		return NULL;
> +	*avc =3D anon_vma_interval_tree_iter_next(*avc, start, last);
> +	return *avc ? (*avc)->vma : NULL;
> +}
> +
> +#define anon_rmap_foreach_vma(vma, avc, anon_rmap, start, last) 	   \
> +	for (vma =3D anon_rmap_iter_first_vma(anon_rmap, start, last, &avc); \
> +	     vma; vma =3D anon_rmap_iter_next_vma(anon_rmap, start, last, &avc))

[Severity: Medium]
Can this macro cause unintended side effects if a caller passes an expressi=
on
like folio_get_anon_rmap(folio) as the anon_rmap argument?

It appears the argument is evaluated on every single loop iteration in the
update step, which could result in repeatedly executing any side effects.

Should the anon_rmap parameter be removed from the anon_rmap_iter_next_vma
call, as it seems to be unused there?

> +
>  #else	/* !CONFIG_MMU */
> =20
>  #define anon_vma_init()		do {} while (0)
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 99e1b3dc390b7..bbfd08ffae3db 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -701,6 +701,79 @@ struct anon_vma *folio_lock_anon_vma_read(const stru=
ct folio *folio,
>  	return anon_vma;
>  }
> =20
> +anon_rmap_t vma_get_anon_rmap(struct vm_area_struct *vma)
> +{
> +	mmap_assert_locked(vma->vm_mm);

[Severity: Medium]
Will this trigger a lockdep warning or BUG if reached from a per-VMA locked
path?

Since this API is intended for generic anonymous rmap operations, should it
use vma_assert_locked(vma) instead to properly support per-VMA locking?

> +	VM_BUG_ON(!vma->anon_vma);
> +	get_anon_vma(vma->anon_vma);
> +	return anon_vma_to_anon_rmap(vma->anon_vma);
> +}
> +
> +void put_anon_rmap(anon_rmap_t anon_rmap)
> +{
> +	put_anon_vma(anon_rmap_to_anon_vma(anon_rmap));
> +}

[Severity: High]
What happens if a caller passes ANON_RMAP_NULL to this function, or to the
locking functions like anon_rmap_lock_write()?

Since ANON_RMAP_NULL resolves to a NULL pointer, passing it to put_anon_vma=
()
or anon_vma_lock_write() would immediately trigger a NULL pointer dereferen=
ce.

Because anon_rmap_t is a struct, standard C idioms like if (!rmap) cannot be
used to check for errors.

Would it make sense to provide an anon_rmap_valid() helper and handle NULL
handles explicitly in these paths?

[ ... ]
> +void anon_rmap_unlock_read(anon_rmap_t anon_rmap)
> +{
> +	anon_vma_unlock_read(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +bool folio_maybe_same_anon_vma(const struct folio *folio,
> +	const struct vm_area_struct *vma)
> +{
> +	struct anon_vma *anon_vma;
> +	struct anon_vma *tgt_anon_vma =3D vma->anon_vma;
> +	bool same =3D false;
> +
> +	rcu_read_lock();
> +	anon_vma =3D folio_anon_vma(folio);
> +	if (anon_vma && tgt_anon_vma)
> +		same =3D anon_vma->root =3D=3D tgt_anon_vma->root;

[Severity: High]
Does this lockless read of anon_vma->root need to use READ_ONCE()?

Because anon_vma =3D folio_anon_vma(folio) is called under rcu_read_lock()
without incrementing the refcount, and anon_vma objects are allocated with
SLAB_TYPESAFE_BY_RCU, could the object be freed and recycled?

A plain C read of anon_vma->root might race with concurrent initializations=
 of
the recycled object.

> +	rcu_read_unlock();
> +	return same;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D1
