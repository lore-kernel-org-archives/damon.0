Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC95245005
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691770; cv=none; b=pP3rUNXD3mSFYW68v+9dymKKhtGUQdsrZmx3f5+GXfxeeLy1sGiFVYHHIXrNgBsLWTPxu/yAtocrV5VlJBCQIL5fFOhPsfWuTjWaIezndJaFMk1yTHMaSAxNSWDE8/i20cS/8NFssjVUolAm+6kxG5GukLVqveA0fWiuMyF+a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691770; c=relaxed/simple;
	bh=AYRa1TpBEm7kfgsQ5mCumYWtn30KamEE0jtiLQ3A74g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EN4LDDD3ghQGO/MHyAWeYKlrQ1AG0ed19Lu1sbXZnrBWXjOx6M895OENVwsj9cVSqXzGfAPQkwxstCvhGIijxbyv+1IDTctDJCUyxc7+5S7t6d0iZk6BzAzmumovCG1uORitGdVOeedzlDXbl2BH60rrQyfKS7yc+Le180MKYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atoA1ZaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atoA1ZaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D627A1F000E9;
	Fri, 10 Jul 2026 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691769;
	bh=2rrWMBnASdQoV5Cr7DZzEZnBwrw1Q6DZEqnVom1lR/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atoA1ZaGeHJhVEKAfyFCxZNHGptjRTlIDH+0EnXjIBIdh3Qhjtn1LpXyIAh9UaP84
	 BoS3tV34wkI+qngvI+JDZDeP3/JGDlVF0CDBz7rW231K1k4HKK1g/eYW+kJWRm/kOa
	 qOA/4/y5s6lbOFrzZweWS4AW/2HhGUJ7Ut2MG1W1mV9y57xWGWn4D8sUAS3SMNN3wf
	 J99TfFKrP1shM1vFp/ChB3UKVnsibCo1oQK1Vhm2AaebhKblAmZZgUeeZg1uFrLuNl
	 B51wKxzpvuOWiK4InmCR6Micb1G9VsQUvwuUOL8swWxS4hM3p9SF9fr1hUdBNVWhkW
	 HVfXP7FqnhO3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/19] mm/damon/core: ask apply_probes() ops callback to
 set sampling address
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-3-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 13:56:08 +0000
Message-Id: <20260710135608.D627A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `damon_pa_apply_probes` callback fails to implement the newl=
y added `set_samples` parameter, violating the updated API operations contr=
act.
--

--- Patch [2]: [PATCH 02/19] mm/damon/core: ask apply_probes() ops callback=
 to set sampling address ---
commit 2da9028945951622496aef07a601ae5bfba7972a
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probes() ops callback to set sampling address

This commit updates the DAMON ops callback apply_probes() to accept a
set_samples boolean parameter. The parameter allows the callback to setup
the sampling address per region to minimize unnecessary regions iteration.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index d8251c83e6e55..aee28b05acc6c 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -647,7 +647,8 @@ enum damon_ops_id {
>   * It should also return max number of observed accesses that made as a =
result
>   * of its update.  The value will be used for regions adjustment thresho=
ld.
>   * @apply_probes should apply the data attribute probes to each region a=
nd
> - * accordingly update the probe hits counter of the region.
> + * accordingly update the probe hits counter of the region.  It should a=
lso
> + * set &damon_region->sampling_addr of each region if ``set_samples`` is=
 true.
>   * @get_scheme_score should return the priority score of a region for a =
scheme
>   * as an integer in [0, &DAMOS_MAX_SCORE].
>   * @apply_scheme is called from @kdamond when a region for user provided

[ ... ]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6172464981730..b13bf7c6eade3 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -166,7 +166,7 @@ static bool damon_pa_filter_pass(phys_addr_t pa, stru=
ct folio *folio,
>  	return pass;
>  }
> =20
> -static void damon_pa_apply_probes(struct damon_ctx *ctx)
> +static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_sample=
s)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;

[Severity: Medium]
Will callers passing set_samples=3Dtrue end up using stale sampling address=
es?

The documentation in include/linux/damon.h states that apply_probes should
set &damon_region->sampling_addr if set_samples is true.

However, the updated damon_pa_apply_probes() does not seem to handle the
new parameter:

mm/damon/paddr.c:damon_pa_apply_probes() {
    ...
		damon_for_each_region(r, t) {
			int i =3D 0;
			phys_addr_t pa;
			struct folio *folio;

			pa =3D damon_pa_phys_addr(r->sampling_addr,
					ctx->addr_unit);
    ...
}

It reads the existing r->sampling_addr without generating a new random addr=
ess
when set_samples is true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D2
