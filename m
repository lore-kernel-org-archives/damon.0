Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8C126C03
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643610; cv=none; b=Q9uY+Nr8DZ/Lxch2LU5HUXOxKbKMngM3mZa+j6lPoY8VhbDxkbYJzkT1xZoWsJFBLL6I6Oxcm7VqcV4H8MaQv8ocVRHns5cir7ctd7G66w4MPYANSsaCs3n6nh0/1f+V4JF+bTZJ7dc34FubfE+ccqdW7pyBa7spQ3zTh3jQ3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643610; c=relaxed/simple;
	bh=m+5ERFL9aGB5aTY0F18FS41Z/R2zb4Cv8tf6Pzn3mus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtNxgXWXtAz12CczKQnRdvtuu6mHDWoHXyHyqErN8cJZMpbHLAPF8Camy3O2arLInV3dkfn62Zoaq9+EhIlKAKNfY4qdpta46BPtGY0jrOD3ivbDDoDHtTvy/kQgv850XDkkUQYaV3KEv6rKnHwzp8VYhekf5RoUFzT51BCVL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+DRJl4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+DRJl4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B831F00A3A;
	Fri, 10 Jul 2026 00:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643609;
	bh=XEJSas62ssgL6wL2BDeXAowRolhExHpgpmIOv7gTn+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+DRJl4ojHgsnTAY2rBzR0hK4/bBZzP+PzH4WJFlZ7A6rHTVKo8sUfoPTVwhTrxw2
	 RR7wMkeKrmNpNHRLNIfzqZUYvyVjmRzhrzETV7ljqchXJRozOcIAk3VEhxHueGj6Zi
	 iZdsLGcaN6TvzBZ9NyuTn6evstf2rfZAbGRizNkThzW3eEdcwyPhPeMXfjsI5a5oX2
	 2hrhvRwQqm7UrGlrvFGuxoZjMtZWjx5u1GpuAz72OMA06nNyvJS2RhP6cJktlBI6Ex
	 y6wToqQir3vWAX5HSaNuTjpu9n9+8qktT/PlgFVEy2rlYQxUDlUEdXvOlxS/Rf4gIe
	 g5HIG7qF/I9AQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 02/19] mm/damon/core: ask apply_probes() ops
 callback to set sampling address
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710002349.111414-3-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
 <20260710002349.111414-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:33:27 +0000
Message-Id: <20260710003328.23B831F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `set_samples` parameter in `damon_pa_apply_probes()` is igno=
red, failing to set `r->sampling_addr` when requested.
--

--- Patch [2]: [RFC PATCH v1.3 02/19] mm/damon/core: ask apply_probes() ops=
 callback to set sampling address ---
commit 5855b0123b327412c4065a90363e8586c4bafda9
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probes() ops callback to set sampling address

This commit updates the protocol for the DAMON apply_probes callback to
accept a boolean set_samples argument. It updates the callback signatures
so it can handle sampling address setup in the future to minimize region
iteration.

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

[ ... ]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6172464981730..b13bf7c6eade3 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
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
Does this implementation actually use the new set_samples parameter?

The updated documentation in include/linux/damon.h states that apply_probes
should set the region's sampling_addr when set_samples is true, but it
appears this parameter is ignored in damon_pa_apply_probes() in
mm/damon/paddr.c.

While it is currently called with false from kdamond_fn(), if future code
passes true as the docstring suggests is possible, could this result in
using a stale or uninitialized address because the API contract is not
fulfilled here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710002349.1114=
14-1-sj@kernel.org?part=3D2
