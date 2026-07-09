Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C72D594F
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609014; cv=none; b=GN77ZszpMF50nHxoCCxbGBFK2q7aGJXHOIScZa0ee186SRswMWSFRRJx6EQpmLFU0oKM/AQLQg+efa/w+tU4X0ZLxhyoYFS5swD3qgNKjGOdFPXhPQH8Z88Gai7bLPDFIjt/PkzhQlY2dGNFCgTLBF+9Ft2CGUrv3kFYQ90tX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609014; c=relaxed/simple;
	bh=dadUAVPKdYitmjozmhPCCIcvogFxpvxpwlJeQgNkisM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRdUBpoz6L3KAUKizr5ZbiOlOnEuLiDEuYvwan8nQBVO+44iz8Shiq0IjgLMqG9Dt4idveg2njsYalnmsdYoINnM/V237GoosbpAb4rcR4UB4nkEnZwARzXBHVkwtFFIc3s+g7HzQWzebfKrvT8z63xoPUh2vcCPi9uOkGWY3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khvl2A2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khvl2A2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7CC1F000E9;
	Thu,  9 Jul 2026 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609012;
	bh=T/qHUIAtoT6rFUPPnDlAkE6V03ZvQmTMgCd8kYyIhv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khvl2A2jKYlx5xVsYASILAOFGU7noW72hsYif4Vm9Bx9l0onGpVeNzuFH8gSA7K+X
	 jSjVQ2Wter5m0EGWrlu6Gpw5M3ClSTzh68/y/USPoqPws5zyYAEeKG4pBOeAbuSD0Q
	 MwrFSgermd9VGaIy/jNGoNxnak61nC1LgUh6jEPyzWK2dvNpXp0uoVj9pMXP1hNFvy
	 JPmpPRh19QR5ZJFgKs1d1y9+6khyG25xci8z5ImzIa0UwxZChXmjQbyiSHsFmovTlZ
	 LsWC3nB9Fde6p0qWBeohBGiOHu6jicmf5C7SNopYU6b2Uy88LXwvaYJozN1gabqwu0
	 MjpqYM3wDuZLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 15/19] mm/damon/core: implement
 damon_has_probe_weight()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-16-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:56:52 +0000
Message-Id: <20260709145652.BD7CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Enabling probe weights for DAMON operations that do not implement =
`apply_probes` (e.g., VADDR and FVADDR) silently disables memory monitoring=
 and region aggregation.
--

--- Patch [15]: [RFC PATCH v1.2 15/19] mm/damon/core: implement damon_has_p=
robe_weight() ---
commit 13bb6c9724d49615512e0e4f353c5d02210d2c11
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_has_probe_weight()

This commit completes the implementation of damon_has_probe_weights()
to return true if any probe has a non-zero weight. This allows DAMON
to detect probe weights and use them for monitoring.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 12c66edecd783..6661d4bfab5b9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
> =20
>  static bool damon_has_probe_weights(struct damon_ctx *c)
>  {
> +	struct damon_probe *p;
> +
> +	damon_for_each_probe(p, c) {
> +		if (p->weight)
> +			return true;
> +	}

[Severity: High]
Does this silently break monitoring for operation sets that do not implement
apply_probes?

When this function returns true, access_check_disabled evaluates to true in
kdamond_fn():

mm/damon/core.c:kdamond_fn() {
    ...
    bool access_check_disabled =3D damon_has_probe_weights(ctx);
    ...
    if (!access_check_disabled && ctx->ops.prepare_access_checks)
        ctx->ops.prepare_access_checks(ctx);
    ...
    if (!access_check_disabled && ctx->ops.check_accesses)
        max_merge_score =3D ctx->ops.check_accesses(ctx);

    if (ctx->ops.apply_probes) {
        ...
    }
    ...
}

If a user configures probe weights for operation sets that lack apply_probe=
s,
all access checks are skipped. Since apply_probes is NULL, no memory access
information is gathered at all. This causes regions to endlessly report 0
accesses and incorrectly merge up to the maximum limit.

Should __damon_commit_ctx() or damon_valid_probe_params() validate that
ctx->ops.apply_probes is non-NULL when probe weights are used, returning
-EINVAL to prevent this failure?

>  	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D15
