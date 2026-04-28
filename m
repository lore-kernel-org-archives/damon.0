Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDE299A87
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345259; cv=none; b=ZaR7pwa34YtncCbhKTYtpZyQIPNVa1cmJpGuCxX0q1z9MKTajdWyLcvX7XSS/iXMPg77YR/M8ZG/WhmwFk7Znl63kL3f3EDHsSNDCUERxTDFW+YM7K3A/3Uh6NeUa18c5scrzcEAYpF9O7/mx/GfMvnwSxITCoF0ye71bGEYSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345259; c=relaxed/simple;
	bh=TdV7mEAz33B7HIla61psVr/01tzPR0TOD+fISQFE4sI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L+cnRYCYn3ReTPwIKbHEO3Ge7uX6L0DLWNKH8rilyvZs6pKGj1Qtb7UcawyOsnDkC94UbVtWnnMwAs0dumZT+DtJzg+RVwCbbz+s0Rl2dZoSdBHUfNUdV2Gh2bqgfe95oTicUF2QtJLmOwqqnfbIS6iHA0/uAd523RTaTCZGIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOLchEq0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOLchEq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A2EC19425;
	Tue, 28 Apr 2026 03:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777345259;
	bh=TdV7mEAz33B7HIla61psVr/01tzPR0TOD+fISQFE4sI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HOLchEq0l+XNvx4LFJS7E/WKOQFAWK7Cm2lgSMqRjBGdvAAUEF9A757hE1hOGGtMW
	 Z6IToTeuUYp2PMjbqM6EmJadpgOFihXJxhAomytiZf612A3lcgBrkRO98NFCifukHy
	 9pskVSFdwTWa3AIGPHYfQZPXvOZeObNkULvNqoiahHfnTWfcOtRviB3CMkp+TaLl61
	 K1KeTlu3V3uiKD0VOP1Bh1VURZOIWhe36bsAYv4ILAIliRvqIjECt+xDmaStC2QoJe
	 ftVzKK7D3RzA5QO2/6onO85AmeykWzaBwX5z6ScM7/SeHMtS6oJiGr8RUl9Igqcknn
	 5iReMveFVCwZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] mm/damon/core: introduce failed region quota
 charge ratio
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260428013402.115171-4-sj@kernel.org>
References: <20260428013402.115171-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 03:00:58 +0000
Message-Id: <20260428030059.18A2EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 2 potential issue(s):
- [High] Pathological region fragmentation causing catastrophic CPU overhea=
d when actions fail.
- [Medium] Silent 32-bit integer overflow in `mult_frac()` for unbounded ch=
arge ratio parameters.
--

commit 4805d0ecef06fc0ab3681758cf2d692b37ed9b70
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce failed region quota charge ratio

This commit introduces a mechanism to charge action-failed memory at a
different ratio than action-successful memory. It allows API callers to
specify the ratio flexibly by setting a numerator and denominator for the
failed region charge rate.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 19ec9919b5ca..87cd4f0d14f3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2046,6 +2048,23 @@ static void damos_walk_cancel(struct damon_ctx *ct=
x)
>  	mutex_unlock(&ctx->walk_control_lock);
>  }
> =20
> +static void damos_charge_quota(struct damos_quota *quota,
> +		unsigned long sz_region, unsigned long sz_applied)
> +{
> +	/*
> +	 * sz_applied could be bigger than sz_region, depending on ops
> +	 * implementation of the action, e.g., damos_pa_pageout().  Charge only
> +	 * the region size in the case.
> +	 */
> +	if (!quota->fail_charge_denom || sz_applied > sz_region)
> +		quota->charged_sz +=3D sz_region;
> +	else
> +		quota->charged_sz +=3D sz_applied + mult_frac(
> +				(sz_region - sz_applied),
> +				quota->fail_charge_num,
> +				quota->fail_charge_denom);

Can this silently overflow on 32-bit architectures?

The mult_frac(x, n, d) macro evaluates (x / d) * n + (x % d) * n / d. Since
sz_region is unsigned long, on 32-bit systems the intermediate remainder
(x % d) is a 32-bit integer. The variables fail_charge_num and
fail_charge_denom are declared as unsigned int and could be set to
arbitrarily large values (up to UINT_MAX) without bounds checking.=20

If large inputs are provided, does the (x % d) * n multiplication silently
wrap around before division, causing an incorrectly small charged amount
and undermining the quota enforcement?

> +}
> +

[ ... ]

> @@ -2116,7 +2135,7 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  		ktime_get_coarse_ts64(&end);
>  		quota->total_charged_ns +=3D timespec64_to_ns(&end) -
>  			timespec64_to_ns(&begin);
> -		quota->charged_sz +=3D sz;
> +		damos_charge_quota(quota, sz, sz_applied);

Could this cause pathological region fragmentation and massive CPU overhead
if the action fails?

Earlier in damos_apply_scheme(), if the remaining quota is small, the
region is split to fit:

	if (damos_quota_is_set(quota) &&
			quota->charged_sz + sz > quota->esz) {
		sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz,
				c->min_region_sz);
		if (!sz)
			goto update_stat;
		damon_split_region_at(t, r, sz);
	}

If the action then fails, sz_applied could be 0. When damos_charge_quota()
is called, if fail_charge_num is also small or 0, charged_sz doesn't
increase by sz. This leaves the remaining quota unchanged.=20

In the next iteration, the remainder of the previously split region is
processed. Since the remaining quota is exactly the same, it calculates the
same sz and splits the region again. This process repeats, dividing the
entire remaining address space into tiny min_region_sz chunks, potentially
triggering millions of loops and pegging the kdamond thread at 100% CPU.

>  		if (damos_quota_is_full(quota, c->min_region_sz)) {
>  			quota->charge_target_from =3D t;
>  			quota->charge_addr_from =3D r->ar.end + 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428013402.1151=
71-1-sj@kernel.org?part=3D3
