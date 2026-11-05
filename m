Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854518;
	b=k3Z0SjIDhTTH5Kqsv1h2XnosZsSfrkksKJfPwf0n3+BTVwPnAAzGAKmaS/lONmoCYPez
	 ztrLXBLmc0dBsTaggioVzo13b8jHsn4fmfgOpN5Kxap66kydS5ZkmPHlONqgZnz/tjkOW
	 Ev7UqWzVTyLBMx9uloMa4akIa1L75c4/8I2JkznMn7VGfRwVvkoCX0XDUf85vjJw/baQJ
	 qyal+ffa6yyKuIVK/I4vS5wrkeQ0RW4xQaNBSFTpiY/ZhFqButDmbBaRgp/B4UqBsKxUs
	 Il1aKCahLYLcyrdyiXZW+rwGxyRwwngYyCwNbojrieVj3RUN++36iYznUTf0ec9ky6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854518;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MqA1v6U9I7VtulcS+AOn9l6cfVQac8Bgf0Fd+CPq7D8=;
	b=2qGRhopuHRV8emhkjDPevv6CNCeuHQj1GKXioUUbUGXrMbkRuhj+q9XwqNYMjUVy7xJO
	 CV7I37Ys+GClG1NNqqGG4FBb0zXY15hGczZ/Nm29tyMFAjuM9LH42jdgjFuYJye2Ig9ly
	 BHhgm+sdd+5x5ko1NELY7FNzSlmmj4I5BL0VRu1zyk5XMbNjGGWmec5b75CiBre8ZCihn
	 n8BqUFFuQ3ltYQLVVfhu3lqLEx4Wcc0zpKBkVzyKzcjxDjX9aJOzWuicZG+BnMrKd2LyO
	 SpW5XXj+OvfsBbEgTXQ4/+H9ZrzMukhBSu3oRiE1tuGh6zK5praQYevGzcfFx0Nxvwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KjKHYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718B606A31B
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KjKHYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907821F000C1;
	Thu,  5 Nov 2026 04:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854517;
	bh=MqA1v6U9I7VtulcS+AOn9l6cfVQac8Bgf0Fd+CPq7D8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9KjKHYkLFtNg94b3bFsLOzRkcieNXJ3km+2Uh5pRlyHHDi2BjkqzuEkf8uf60GJp
	 puJntGXpoVnSTV749phc6j/wSpVuJdY2ZnKuTSmD7Kojj0MbSG7hH2OZNiLNa2jorM
	 QGALskc4xjgWvHs5MQT6YZt2miKq8DiCus4KxMkeqBuDQAbj1hdv0fTJLdkGa+INRM
	 5dBrimHzj9+jHg3ZcssZPZIYCH6juuk708yjwPIMx6mHsl9BuF23J9W48o2EM98MiN
	 3nRu9wBMjMIJC+KEBtuj/gxbJeR6mDSfd9GfjRrjIJ3JWSKLfDE7EalA1ZQeawP6mC
	 a6Lkrc/UlbXrg==
Message-ID: <sashiko-outbox-198571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261105044425.87142-2-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
 <20261105044425.87142-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:55:17 +0000
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
- [Medium] mm/damon: 64-to-32-bit truncation of age_ms in damos_filter_matc=
h()
--

commit 2459402d4dc794f740b6a5720a69fe4a1a61ae62
Author: SJ Park <sj@kernel.org>

mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS

This commit introduces DAMOS_FILTER_TYPE_AGE_MS in the DAMON API and core
layer to allow filtering DAMOS target regions by age in milliseconds. It
converts the region age from aggregation intervals to milliseconds using
div_u64() and compares the result against damos_filter->range_{min,max}.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d36823f4d0928..0a056949604f9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2552,7 +2554,7 @@ static bool damos_filter_match(struct damon_ctx *ct=
x, struct damon_target *t,
>  	bool matched =3D false;
>  	struct damon_target *ti;
>  	int target_idx =3D 0;
> -	unsigned long start, end, wsum;
> +	unsigned long start, end, wsum, age_ms;
> =20
>  	*err =3D 0;
>  	switch (filter->type) {
> @@ -2594,6 +2596,12 @@ static bool damos_filter_match(struct damon_ctx *c=
tx, struct damon_target *t,
>  		matched =3D filter->range_min <=3D wsum &&
>  			wsum <=3D filter->range_max;
>  		break;
> +	case DAMOS_FILTER_TYPE_AGE_MS:
> +		age_ms =3D div_u64((u64)r->age * ctx->attrs.aggr_interval,
> +				USEC_PER_MSEC);
> +		matched =3D filter->range_min <=3D age_ms &&
> +			age_ms <=3D filter->range_max;
> +		break;

[Severity: Medium]
In damos_filter_match(), age_ms is declared as unsigned long. On 32-bit
architectures, unsigned long is 32 bits wide, so storing the u64 return val=
ue
of div_u64() into age_ms truncates the upper 32 bits whenever the region age
in milliseconds exceeds ULONG_MAX (about 49.7 days, or for example
r->age >=3D 42,949,673 at the default 100,000 us aggr_interval, and
proportionally earlier when aggr_interval is larger).

When that happens during kdamond_apply_schemes() -> damon_do_apply_schemes()
-> damos_apply_scheme() -> damos_filter_out() -> damos_core_filter_out() ->
damos_filter_match(), age_ms wraps modulo 2^32 and can misclassify old
regions as young regions or fail to match old-region filters.

By comparison, damon_hot_score() in mm/damon/ops-common.c stores the result
of div_u64() in a u64 variable (as fixed in commit 0284dff76e87 ("mm/damon/
ops-common: fix 64-bit division in damon_hot_score()")):

mm/damon/ops-common.c:damon_hot_score() {
	...
	u64 age_in_sec;
	...
	age_in_sec =3D div_u64((u64)r->age * c->attrs.aggr_interval,
			     USEC_PER_SEC);
	...
}

Should age_ms be declared as u64 (or saturated to ULONG_MAX before storing =
into
age_ms so filters with range_max =3D=3D ULONG_MAX on 32-bit continue to mat=
ch) to
avoid truncating the quotient on 32-bit systems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105044425.8714=
2-1-sj@kernel.org?part=3D1
