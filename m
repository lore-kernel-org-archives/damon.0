Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553701;
	b=Gh3vPvMCcMqYCkY6SfykvR+2Kv/d0SPjJyO6/WZytS4aL/fgAHPYIL9fqhqoPYMD4uKV
	 nFe4L4ApgbuzxQczdgWdm9jD8VlO9PPRKIZGGznblvZrD8vnzr4HVVZ1BNh/QP7rivCan
	 zzMKjrZxebp261jf6uxejxT0/VxfvHCWN49GcnmfC9UatD3rLEQGIluwV2A8bqFjtgcLH
	 Jv1Pe/ND/NJvrBhmw6lvP+pfzOuxtqhNvdkU12TL8RdnbWEHz6fBfEt+wPxj8VZMlC7ow
	 BeGUnnJOjYEicmjP94w5Ed7GKcPxRjlFbbuvz+ETwTrBHTnh20a8o6+DsWu+xIC50Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JPRODuptNXZdkhl8l76yddILf9I1UG9LWBNv7LQOJiw=;
	b=PaZgCXTGrJFNyA8UA3duAQsEAmN49nxAxpXmu4FySCS5oFGj1LhEUyKmD+qlva64suJw
	 PXu5EkVXmt5BXu/7s7rbseXxAp0CDPk4CqiggILkdzJkz+csA8UjR55iYK7SH+DheZkTc
	 CH1IuM8ylxFz67muB3WF8QaW+Fm8DLIY+YTensDpgQSDF0D6aBIOf5Li9d8rCCYOKLHhL
	 sDXNONBQhIKabe8wk5wpED7qIVGOAzyNP9jEp/xKuSEjAa3RQ9VAbe9gXdAnuV/NO+rqi
	 IbyBM7Q9SSK0Eoed77Rar4MRLWN0Wpjf/Ys7BCn1cCcGzcJG5Iw406nHsv5qS51EGqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqNC3NC1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E16606A325
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqNC3NC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F53B1F000C1;
	Sun,  1 Nov 2026 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553700;
	bh=JPRODuptNXZdkhl8l76yddILf9I1UG9LWBNv7LQOJiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqNC3NC1Slcf+zh8YkkZd/uNePiYEwCworQXME2nbDCX7OBbTK9iOcjAhilllCwD5
	 s9zefvdtNGzLbliOtAFp3pLnoBu/usJ2sQAm5wGu+ppvAekmOnhmEs3Iob/tkQZdwM
	 c37GCRXB7ecvmOIR+Ge2qIGO2B3cwH1ictAg0/G4TWjCAeZRbyu0zZ9ttuxUDXtr3q
	 9MnTiAwUy+/d/12v867/N4015Zh0BmezkeN8kYCbETilBqeM+H5bDakj17OVLs2JiJ
	 o0QqSz73m6vT/g0JB+XbB9ae3f8WplHlrLJpqeh/mkWGH46nO3TNeMWsH09kSuPnle
	 a4RFXSV55hMwA==
Message-ID: <sashiko-outbox-192523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/6] mm/damon/vaddr: implement sz_filter_passed
 for migrate_{hot,cold} action
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261101171630.81477-4-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
 <20261101171630.81477-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:21:39 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm/damon/vaddr: undeclared dests in damos_va_migrate_pmd_entry()
--

commit 7670e03c4d866e7e831b34d6066cefe5b658b73a
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action

This commit adds sz_filter_passed accounting to the DAMON_VADDR
migrate_hot and migrate_cold actions by passing the counter through
damos_va_migrate_private and accumulating the size of folios that pass
ops filters in damos_va_migrate_pmd_entry().

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b1d7bcf7305bb..6fd0e07b60705 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -846,7 +847,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
>  	struct damos_va_migrate_private *priv =3D walk->private;
>  	struct list_head *migration_lists =3D priv->migration_lists;
>  	struct damos *s =3D priv->scheme;
> -	struct damos_migrate_dests *dests =3D &s->migrate_dests;
> +	unsigned long *sz_filter_passed =3D priv->sz_filter_passed;
>  	struct folio *folio;
>  	spinlock_t *ptl;
>  	pte_t *start_pte, *pte, ptent;
> @@ -865,6 +866,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
>  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
>  			goto huge_out;
>  		s->last_applied =3D folio;
> +		*sz_filter_passed +=3D folio_size(folio);
>  		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
>  				migration_lists);

[Severity: Low]
Was the declaration of dests in damos_va_migrate_pmd_entry() removed by
accident when adding sz_filter_passed?

Both the transparent hugepage path above and the PTE loop below in
damos_va_migrate_pmd_entry() still pass dests to
damos_va_migrate_dests_add(), which causes mm/damon/vaddr.c to fail to
compile with an undeclared identifier error when CONFIG_DAMON_VADDR is
enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101171630.8147=
7-1-sj@kernel.org?part=3D3
