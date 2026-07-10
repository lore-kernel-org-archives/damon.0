Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97C21CFE0
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692465; cv=none; b=lFhAawNlcrG/QdCQDDckoG8Dn5LoO/UpYCp5SnAiEuRwc11yxniFxQuUb1yutj7XGzqOnsyr5hFMnIZWKd+fa/RJkj3k48v4EpF55z3oem8AxP/lPdM2rxk81P9zE+aXPWo1DkMwqY6J1MAZJoZeg9qhJ/hFibtzgLd2sWyRfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692465; c=relaxed/simple;
	bh=JeRrpM5YK3FMhuMY1LAmgX3h4o4qVgeruBCAVIRIjMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZGhBcOR4BHMNPm2mh/K0LkePtH51NV3JaBTd5Rg+QPWrsngXiMZb3ayH9eNmdBnPAcL2WPm+aNDr/NghRo2U9L3dtYd3H0S2bRnIg0olv3oeS5469z9QCqw0BirOftFSiJOHiRrX6k26RuyMWjoMVg3e7MU4sbQtmDCseh+e/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Unab5Bi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unab5Bi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A469F1F000E9;
	Fri, 10 Jul 2026 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692463;
	bh=kfVCGLJSVNTKpaveR3bUpenQWqGHa2SaYVI0W3e0qsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Unab5Bi8JFpcTdU982G+1x9JAvonq6JjYSpW6C6QWrURLh3SZuYeAsS2Z3eyE6Dn9
	 vc43V7t0mmvkDk2tRr6/ks7TcjpYfEvgzqFwXANzXEM7dGt27KUxu3f7R11xpPsiBU
	 LQqpap+SEttJ8fEBsZv8M/YiheZYt6VyXOpKyrr5Pt6BvAdV/s7ZSZL6q4pZ02kZh9
	 y4Qe3/mJnSmEnKw3zslT+pz27VKODMbGBVPxehXMDuhakYQ/THHE4FL0j8wYU9Rp8E
	 hPojQI1ftXttlz33PIIvCloBeEY7X5jWjSGP5ETO+4LRpmVseULXZAi+pfdAwW/esn
	 x4ultszscoKcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/19] mm/damon/core: validate params for probe hits
 weighted sum overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-11-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:07:43 +0000
Message-Id: <20260710140743.A469F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing integer overflow in `damon_merge_two_regions()` durin=
g weighted average calculations.
- [High] Pre-existing integer overflows in `damon_sample_bp_to_count()` and=
 `damon_sample_count_to_bp()`.
--

--- Patch [10]: [PATCH 10/19] mm/damon/core: validate params for probe hits=
 weighted sum overflow ---
commit 74455514643a15cd1b70c8a9afa3237ba4226d34
Author: SJ Park <sj@kernel.org>
Date:   Fri Jul 10 13:46:39 2026 +0000

    mm/damon/core: validate params for probe hits weighted sum overflow

This commit adds parameter validation to prevent integer overflows in probe
hits weighted sum calculations. It ensures that user-configured probe weigh=
ts
do not cause the weighted sum of probe hits to exceed the maximum possible
value during monitoring.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4f1425e56950b..a0e6a5129fbf3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1335,6 +1335,9 @@ static void damos_set_filters_default_reject(struct=
 damos *s)
>  static bool damon_valid_probe_params(struct damon_ctx *ctx)
>  {
>  	unsigned long sample_interval;
> +	unsigned char max_probe_hits;
> +	struct damon_probe *probe;
> +	unsigned int wsum, wsum_to_add;
> =20
>  	if (!damon_has_probe_weights(ctx))
>  		return true;
> @@ -1342,6 +1345,18 @@ static bool damon_valid_probe_params(struct damon_=
ctx *ctx)
>  	sample_interval =3D ctx->attrs.sample_interval ? : 1;
>  	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
>  		return false;
> +
> +	/* invalid if probe hits weighted sum can overflow */
> +	max_probe_hits =3D damon_nr_samples_per_aggr(&ctx->attrs);
> +	wsum =3D 0;
> +	damon_for_each_probe(probe, ctx) {
> +		if (probe->weight > UINT_MAX / max_probe_hits)
> +			return false;
> +		wsum_to_add =3D probe->weight * max_probe_hits;
> +		if (UINT_MAX - wsum < wsum_to_add)
> +			return false;
> +		wsum +=3D wsum_to_add;
> +	}
>  	return true;
>  }
> =20

[Severity: High]
This is a pre-existing issue, but does damon_merge_two_regions() suffer fro=
m an
unsigned long overflow during average calculations?

mm/damon/core.c:damon_merge_two_regions() {
	...
	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
	l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
	...
}

During the calculation of the merged region metrics, if a region size reach=
es
1GB and nr_accesses is just 4, their product is 4,294,967,296. On 32-bit
architectures where unsigned long is 32 bits, this will instantly overflow.

Additionally, on 64-bit architectures, the age variable could grow indefini=
tely
and overflow if a region becomes very large over a long uptime. Can this le=
ad
to corrupted statistics and misfiring of memory management actions?


[Severity: High]
This is a pre-existing issue, but I noticed a potential integer overflow in
damon_sample_bp_to_count() and damon_sample_count_to_bp():

mm/damon/core.c:damon_sample_bp_to_count() {
	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
}

mm/damon/core.c:damon_sample_count_to_bp() {
	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
}

Can these calculations overflow? The functions perform 32-bit multiplicatio=
n of
bp (or the remainder in mult_frac) and the max samples using unsigned int
arithmetic.

If max_samples (aggr_interval / sample_interval) exceeds 429,496, which is
possible with a high aggregation interval compared to the sampling interval
(e.g., 5s aggregation and 10us sample intervals), the result could exceed
UINT_MAX (4,294,967,295) and silently overflow. Could this corrupt monitori=
ng
region access counts during dynamic DAMON attribute updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D10
