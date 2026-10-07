Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88F40E8E1
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388723; cv=none; b=GGXxKXZGLLqqhFDeYtKaYQFepLieTlLXtsdH/qHz0ATO2WNKq06DE2A/zyqfpn8KLYrA0JUaInAcZ/w6EXFDX6C4FnURRbt3VZAd0DIyYOywzaOFWMwi+yQQwpP6ziLquMtRIPAWyXVOPBekihiV5xjL96JTTilJoP0O3IQPzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388723; c=relaxed/simple;
	bh=KOLw0Kxh6TOz5mPcHyDkZLKYskt/Yx+EBtBLaAGQA5M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KUFgqwFlDWvrAeq+evUciPzRA9W8up85QCu94A5+BP3seSQ2vKjupOUEtoSPP2qO3a2HcxsCENgcMxGxVdxZWeFw+sDwwc0tmbY0m1NdoIioCmqd6Y0KuqfkeNK1K3oVep0fnuesdAFs4qdRfo0s/Aolat2SWXcTGaolCZY7iLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOWEs7W0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOWEs7W0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D841F000FF;
	Wed,  7 Oct 2026 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791388722;
	bh=6ywviX/oIOHWU+vdYd4MSi/oWrJ6G+uBItTdV6JjQ/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOWEs7W0xGAIVfxTljD4qPICzMrFkFnxP8JVa4Zbt8zs/3uSJXG8IJW14KcBKeTpr
	 ZpnF+h2CQOdWptKGYD1h0FJfVxV98SJiPIfUvWRSJkmjzNFf6gjFrgEj4F/EJwjXv/
	 Cw/ubb7VlHASRBZQQppeYx+OH/HVpvs1hOxUol9DtZBnt6eT7V2oukU96FYauHbRDF
	 72vbciEM7fZxItEA2lsjZf6LB4v08DwLNOI+KOpUvUzcS/ynN/uG1pllZ0k2EH3g33
	 Tq7JKFiwFDXsfpLtvscBAYeb6rTd7WUywDk8kE6fjkgUUYqAZzyRpj6O3v07QYmYzX
	 caMYPrDhhPhWQ==
Message-ID: <sashiko-outbox-163177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: Use only installed probe in
 damon_merge_two_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261007154851.45368-2-suhaas@s-joshi.in>
References: <20261007154851.45368-1-suhaas@s-joshi.in>
 <20261007154851.45368-2-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 15:58:41 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: memory leak of ctx on r2 allocation failure in damon_test_me=
rge_two()
--

commit ade902b9c0636f895031124ead4ff579818b8169
Author: Suhaas Joshi <suhaas@s-joshi.in>

mm/damon/core: Use only installed probe in damon_merge_two_regions()

While merging 2 regions, we iterate over the entire probe_hits[] array,
whose size is determined by the DAMON_MAX_PROBES macro. It is possible,
however, that we have fewer probes installed than DAMON_MAX_PROBES. In such
cases, we end up making redundant iterations. Therefore, to remedy this,
iterate over the list of installed probes instead of iterating over the
entire array. For doing this, start accepting a struct damon_ctx in
damon_merge_two_regions(), and update calling functions to pass this
argument.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index ef146ca2ae8aa..bea17b68f13c6 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -182,13 +182,27 @@ static void damon_test_merge_two(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r, *r2, *r3;
> +	struct damon_probe *p;
> +	struct damon_ctx *ctx;
>  	int i;
> =20
> +	p =3D damon_new_probe();
> +	if (!p)
> +		kunit_skip(test, "probe alloc fail");
> +	ctx =3D damon_new_ctx();
> +	if (!ctx) {
> +		damon_destroy_probe(p);
> +		kunit_skip(test, "context alloc fail");
> +	}
> +	damon_add_probe(ctx, p);
>  	t =3D damon_new_target();
> -	if (!t)
> +	if (!t) {
> +		damon_destroy_ctx(ctx);
>  		kunit_skip(test, "target alloc fail");
> +	}
>  	r =3D damon_new_region(0, 100);
>  	if (!r) {
> +		damon_destroy_ctx(ctx);
>  		damon_free_target(t);
>  		kunit_skip(test, "region alloc fail");
>  	}

[Severity: Medium]
Is there a missing call to damon_destroy_ctx(ctx) if the allocation for
the second region (r2) fails?

Looking at damon_test_merge_two(), if r2 fails to allocate:

	r2 =3D damon_new_region(100, 300);
	if (!r2) {
		damon_free_target(t);
		kunit_skip(test, "second region alloc fail");
	}

Does this code leak the newly allocated ctx and its contained probe on this
error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007154851.4536=
8-2-suhaas@s-joshi.in?part=3D1
