Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE03546F0
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104275; cv=none; b=UkVHyppVM2DlZTPiPE9HO1xECGdL/fHbdvlAaMJuT0YBBn64XEUGTf8UGd3fL+2rASYaPS+XzVurjtyaXX/y5rC2pai1Xcx08onGydHef8SFSnwfZouvQjkD5bSsycd+bgc59VNIU+xTNlQkerHBe8E9/WsZXXKYMYhYA1Yt+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104275; c=relaxed/simple;
	bh=h8QjiN9O5mFkNKFKq74vPGcfKi1QMj//U0OEGJ/Pr08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mvPASV6GIaZ/eIzLdS8opyxoGVLD8Yb5wJnq3F8CpHBu9iOL79PP4/lOILvhaFgJf9nVqOEfGpdN8gAvphcV4WctfV/mYruBfBB6Bf9wkgmAUbMRX75IgMNtrmP+hVsIK50I3opA55QgQPlPT2xd1+eToTKaY6D0a73xlGdQRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX9RZq0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX9RZq0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF281F000E9;
	Mon, 22 Jun 2026 04:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782104274;
	bh=wF6D3x+f+5H971hSx2kC6BBYnMcerkyx2keYHcTcrBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eX9RZq0uLycHfQo82peV527xKL48qJIprsPjn40X07pM19l0Eh1bK2UY/e1TACEfR
	 37uctx4V0308KnvFskvH1LG8kAU/Jfo8Oe/jCzgAmdDFNUV1BM0d2+LWLhJJTtmMiz
	 TEQuNpbRxlbeqc8aHT+NOXJVG9sNdFm65EAx7taPGmEZ4ae/fOv12rDSj4HsEyAWRA
	 X+JuMTaYv+4eSrCj1OisfFMQUwZqxiOYIL6KL4WAt/4Db2qS5c2C+HxgXHMmRvew6m
	 sSpHJgH0zw4CgEkNqyJ5oy1gDOsDViAmmstuY0G0K5LP+U9OlddlzBi0cfYEgTAcXB
	 Kw7hFabjEVIxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] mm: Use mutable list iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, damon@lists.linux.dev, tj@kernel.org
In-Reply-To: <20260622041529.30643-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <20260622041529.30643-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:57:53 +0000
Message-Id: <20260622045753.CDF281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] An unused `folio2` pointer was mistakenly added to `struct rmap_wal=
k_arg`.
--

commit 8a79df314e3109d54ebea51144ac490e11160cb4
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

mm: Use mutable list iterators

This patch mechanically converts mm users of safe list iterators to new mut=
able=20
helpers. It drops temporary cursor variables that are no longer explicitly=
=20
needed by the calling loops.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index d9b23909d716c..acc7925d1d1b8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
[ ... ]
> @@ -336,7 +335,7 @@ static bool try_to_map_unused_to_zeropage(struct page=
_vma_mapped_walk *pvmw,
>  }
> =20
>  struct rmap_walk_arg {
> -	struct folio *folio;
> +	struct folio *folio, *folio2;
>  	bool map_unused_to_zeropage;
>  };

[Severity: Low]
Is folio2 actually used anywhere in struct rmap_walk_arg? It looks like thi=
s=20
was mistakenly added as a leftover artifact of a mechanical search-and-repl=
ace=20
when cleaning up the local cursor variables in nearby functions.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622040533.2982=
4-1-kaitao.cheng@linux.dev?part=3D3
