Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B23E5ED0
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337849; cv=none; b=C9aIHKi4EuRHAtDIUNdRodhFC0YnOfqY7eJrSCd3EXR5jw8t4tqwTVrVv/W9uqhxYk3UWCVzudFVnufR5GDR5eE2Df4k68vu+PNwowcqah5k2iX62LEApql5kEOqLD6ld0q/xq7Gy7QRoS6NjXpF2p8hCu3NclqgSbrIU6N0Mf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337849; c=relaxed/simple;
	bh=/pz2eJYz05HgaYa6/cDgTwSYa6SMcvNPW1V/Z87d3j0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8/PQd0CTzkB+8H4kC6UNYVibIj7KK5RTVhm+yZEl2p1UPiwBaVtuKGFe0mP0FvQGPBdGJw437iQ5d7okActQcrynLv0s++ifL+Iearxm+/RzNYwtrZ8NCPsdjwDJGazgKeAYrO2OvweI2GdMWLdOWCTRvMOK+/dfwhQ0oYSYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/rnV4GD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/rnV4GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4081F000E9;
	Wed,  2 Sep 2026 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337847;
	bh=M8TR2+wpPCr7dG78RAFKGGeJHDRB2hV9j8NpNhZyjvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/rnV4GDfZmoHVW3UHC3/OyknYDvkjVAnadOMwEsq/VcgWH1AXhakJzmxM9CwiOdp
	 gn9H8H5sS7CDtM/rUHIS6Ytfw18G62dQJAgHhqUOzFQPpnCREuvIwM8X2ZdAvxGQni
	 DZt6lYrPBID0VSFNJI8Y8wMagOhPEn9yinq8TpdkhLfjZh/6chcE74Ph5Suf6Mfhbp
	 twxeeX0ysjGj2bYTuV6hc8TJS9CZs5ZFyBYbCTopnY4fSBzeWw0xpUumhahC+ffJOy
	 IA7Iyf8yMPskQc3uff7+EfdRAVU3q+O3GY1hmJOaEL7nIAV+d4s5RPE/r4BuRnDg+U
	 w6nnlYfY5ddWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902082050.19566-1-aethernet65535@gmail.com>
References: <20260902082050.19566-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:30:46 +0000
Message-Id: <20260902083047.6D4081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks purely time-based quotas by unconditionally zeroi=
ng the effective size quota (`esz`) for DAMOS schemes without goals.
--

commit 34629844ff11daf28855cce5457468ad8bc08c73
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: allow esz to be set to zero

This commit updates damos_set_effective_quota() to allow the effective quota
to be set to zero when the temporal quota goal tuner achieves its goal.
Previously, the quota was clamped to min_region_sz, preventing it from
reaching zero.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index df22621765911..73dc9a70fb12b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3251,6 +3251,9 @@ static void damos_set_effective_quota(struct damon_=
ctx *ctx, struct damos *s)
>  	if (quota->sz && quota->sz < esz)
>  		esz =3D quota->sz;
> =20
> +	if (!quota->esz_bp)
> +		esz =3D 0;
> +

[Severity: High]
Could this cause a regression for schemes that use purely time-based quotas?

If a scheme is configured with a time-based quota (quota->ms > 0) but has no
quota goals (list_empty(&quota->goals)), quota->esz_bp remains at its defau=
lt
initialization value of 0.

While damos_set_effective_quota() correctly computes esz from the throughput
and quota->ms, this unconditional check will then force esz to 0 because
quota->esz_bp is 0. An esz of 0 causes damos_quota_is_full() to always retu=
rn
true, effectively breaking schemes relying only on time-based quotas.

>  	quota->esz =3D esz;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902082050.1956=
6-1-aethernet65535@gmail.com?part=3D1
