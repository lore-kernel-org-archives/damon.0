Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807050;
	b=bGqx4gzl4+VOq53oc/WqYibASgdKWCziAnSUN4tCPENTZHKSu/ADxv3SnAB3AxYF8POT
	 Vedeeutw05UFWQFyhAdtyacitxoQCOYwn8MqHHQNq/w3rUrkgXgE0cW9w8AmQNG0KkggD
	 HKLkiuXq9NlIw6rBORMpA/T/RxsNvrVwDBdgTTQodXDXyZ9eEbsJMdCrf3gS9ZYkC397B
	 ylW6VRdE38TsxOW6Rk8CTz08mwPMEykVUqRvIxHjL/XjAweHIkB4PNls2SVr1tKWY3CsM
	 p/FlWzJmzxuPa8P7eu9X44XqlSFHXJzauWxv0OCcuBwzZHhw0uRDnkD4yzvKFvIeGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pJp2+YzSERpK0Un25SgLeLNyefYf/shVUPYZJLrSfq8=;
	b=XXnlBocH/lC1AvI2w5DHmejEm4RFUSLlT0wd5v23zjyhyr01OL2aLMCbf+V2nntghCQN
	 MQc/ogUvow50pL4inORjsSQAitzM4x5eOtC54QkgargSyaIukKdM7FR/GO/4F4r+8yzkJ
	 4F7jYEoDaz1xZWExlyh9WIB5ZLgG8EkrFQmtmKg1iT816ETcCwXVPyWKiz06+b7M0V5nH
	 6u1qq6E7Gx63aAmJlEoXfBfrme2z+egfC3Y8BBGkxez1rADJoEAU5dMl6FLnkpf3C2gRX
	 w+sNTV6R3UE+60Iwdg5uAfJp7pqoHctptfaVRpSXieRl3oKWhD9dG7hLUE7OpmHrRrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9Yi3SVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A75606A326
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9Yi3SVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CD61F000C1;
	Wed,  4 Nov 2026 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807049;
	bh=pJp2+YzSERpK0Un25SgLeLNyefYf/shVUPYZJLrSfq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9Yi3SVwOGJ3TRWVqeFXN7NE7C3ObGLDThYNox677k/5H4CyGiQm+Fycvz2b1/kr3
	 J5diTkcky6pqt4EtTXb6V07N5gihfujFE20GM1fE78WMcVq05a1LgdHhfqYg00qSYO
	 AiUAdfFhgxqNxHaBa2oxj6yIuuqQaAuft032t1kHfjNoWbmeyegw9z8jHIpogDYCJ3
	 a+HNeh7wjMcKIS2LvmzoBmmnDX+B/oQcKmYJ6jiINl+aNk1esYzQUQhBBsWlH3pps1
	 BREqstvuF1+Rl3TBKjEOp5PUNwqligbm5x7fIFnS4FKi8zOCc+OlMFt3OJ/HszjJju
	 JU8ewrTr08XMQ==
Message-ID: <sashiko-outbox-197530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261104153645.82945-2-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
 <20261104153645.82945-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:44:08 +0000
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
- [Medium] mm/damon/core: 32-bit overflow calculating age_ms in damos_filte=
r_match()
--

commit 8785e74923668744015c21ff7266b94722501bbc
Author: SJ Park <sj@kernel.org>

mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS

This commit adds a new DAMOS core filter type, DAMOS_FILTER_TYPE_AGE_MS,
allowing schemes to filter target regions by age in milliseconds using
damos_filter->range_min and damos_filter->range_max.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d36823f4d0928..d631863b034db 100644
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
> @@ -2594,6 +2596,11 @@ static bool damos_filter_match(struct damon_ctx *c=
tx, struct damon_target *t,
>  		matched =3D filter->range_min <=3D wsum &&
>  			wsum <=3D filter->range_max;
>  		break;
> +	case DAMOS_FILTER_TYPE_AGE_MS:
> +		age_ms =3D r->age * ctx->attrs.aggr_interval / USEC_PER_MSEC;
> +		matched =3D filter->range_min <=3D age_ms &&
> +			age_ms <=3D filter->range_max;
> +		break;

[Severity: Medium]
Can the multiplication r->age * ctx->attrs.aggr_interval in
damos_filter_match() overflow on 32-bit architectures?

Since r->age is unsigned int and ctx->attrs.aggr_interval is unsigned long
(in microseconds), the multiplication is evaluated in 32-bit unsigned long
on 32-bit platforms before dividing by USEC_PER_MSEC. Once a region's age
exceeds ULONG_MAX microseconds (about 4,295 seconds, or r->age >=3D 42,950 =
at
the default 100,000 us aggr_interval), the intermediate product wraps around
and misclassifies old regions with a small age_ms value.

By comparison, damon_hot_score() in mm/damon/ops-common.c casts r->age to
u64 and uses div_u64() to avoid this 32-bit overflow:

	age_in_sec =3D div_u64((u64)r->age * c->attrs.aggr_interval,
			     USEC_PER_SEC);

Should damos_filter_match() similarly use div_u64((u64)r->age *
ctx->attrs.aggr_interval, USEC_PER_MSEC)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104153645.8294=
5-1-sj@kernel.org?part=3D1
