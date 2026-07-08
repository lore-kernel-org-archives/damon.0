Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10637C912
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475117; cv=none; b=QqJ4THXlTEa+72ldlJPWlonld/WGP5Bbh0zfQbBoiJRkJQmM0WyJGwRA592U3A3KSokcQ9loBwSKSTPuYV14NA7rcOxsicXDhmTpHyZJ4xV1pFgYf0Y9BSnzkJMOUu7k4rdlU5wCAsZgTHmStOoY2BL74VLnqMrK4bSW9HQC6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475117; c=relaxed/simple;
	bh=jeVckiFMytKQT4K+/xq7+x1tST11jDZnMpYDeYkVevc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qYy1pNPLzIYtnUQ73+/Tvy0r2OV3gD+bZDuqhB6Eo0dQZ/Ok4n1H1Hrf0Ambm9BCZ3eOVmTZIZ8ixaNUYNp+L3cpsdqLYFzEynte5bGUr36n26mYKWuOEUPiyh3OBq5hGMgn2r9gE4StGE6fGQH8MfoQDeff4+/spzRyJImapyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nppzljoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nppzljoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320731F000E9;
	Wed,  8 Jul 2026 01:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783475116;
	bh=9gRm337Ks5qzebCBTvt/xiN7+G7Ov2uyjQIbo3GHACc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nppzljoc3AG83bpmTQ9Icj/rUWuKaRq6u+XkYB1SD31nyMj7qF78Mr+ryAJWFYNST
	 yJQoydlbKH/Op1BQs36/b8BJjjNySFp2cIVsNFK30IVQVh3ZPmLIkgCZL99izv1ahz
	 YCCzfIITryCL3JlbHgFo3FwTgULNBTSHgLpfscoPj3B+RwbBqiBn8eIJcfUFiFvZyL
	 boznan8Y7ginojjOmJ3jRicuk13TY3AcgIsZDXMOwSn4taW/fpIYXEjS2eQhclNdb6
	 /D4dCPhSPT+hcM/hQB7XuwWwXKVTYdZMZ7cyQAzEgVc0HPnQxa3BbuU9Hm1Tqv+Ufx
	 /i6OZpaunXwFA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 2/7] mm/damon/core:
 s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708013252.95888-3-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
 <20260708013252.95888-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:45:15 +0000
Message-Id: <20260708014516.320731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The KUnit tests fail to build because they still use the deleted fu=
nction name `damon_max_nr_accesses()`. Furthermore, the test function uses =
an incorrect pass-by-value argument and is missing from the test cases arra=
y.

Pre-existing issues:
- [High] Multiplication involving `damon_nr_samples_per_aggr()` can easily =
overflow a 32-bit unsigned integer.
--

--- Patch [2]: [RFC PATCH v1.2 2/7] mm/damon/core: s/damon_max_nr_accesses(=
)/damon_nr_samples_per_aggr()/ ---
commit 41a943f324d729eeccaf0110b19b34cddf7fa203
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/

This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
to better describe its actual behavior returning the number of samples per
aggregation interval.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 19b7e839bde0b..63f596957c1f1 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1056,15 +1056,17 @@ static inline bool damon_target_has_pid(const str=
uct damon_ctx *ctx)
>  	return ctx->ops.id =3D=3D DAMON_OPS_VADDR || ctx->ops.id =3D=3D DAMON_O=
PS_FVADDR;
>  }
> =20
> -static inline unsigned int damon_max_nr_accesses(const struct damon_attr=
s *attrs)
> +/* Returns number of samples per aggregation interval */
> +static inline unsigned int damon_nr_samples_per_aggr(
> +		const struct damon_attrs *attrs)

[Severity: Low]
Does this rename break the KUnit tests?=20

In mm/damon/tests/core-kunit.h, the damon_test_max_nr_accesses() test still
references the old damon_max_nr_accesses() name and passes attrs by value
instead of as a pointer.=20

Furthermore, it appears damon_test_max_nr_accesses() is missing from the
damon_test_cases array.

>  {
>  	unsigned long sample_interval;
> -	unsigned long max_nr_accesses;
> +	unsigned long nr_samples;
> =20
>  	sample_interval =3D attrs->sample_interval ? : 1;
> -	max_nr_accesses =3D min(attrs->aggr_interval / sample_interval,
> +	nr_samples =3D min(attrs->aggr_interval / sample_interval,
>  			(unsigned long)UINT_MAX);
> -	return max_nr_accesses ? : 1;
> +	return nr_samples ? : 1;
>  }

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a15005db82899..177e5abc981ef 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -880,14 +880,14 @@ static unsigned int damon_age_for_new_attrs(unsigne=
d int age,
>  static unsigned int damon_accesses_bp_to_nr_accesses(
>  		unsigned int accesses_bp, struct damon_attrs *attrs)
>  {
> -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
>  }

[Severity: High]
This is a pre-existing issue, but can this multiplication overflow a
32-bit unsigned integer?

Since damon_nr_samples_per_aggr() can return a large value (up to UINT_MAX),
multiplying it by accesses_bp (which can be up to 10000) could cause an
intermediate overflow wrap-around before the division.

For example, a 35-minute aggregation interval with a 5ms sampling interval
yields about 420,000 samples. Multiplying this by 10,000 exceeds 4.2
billion, which wraps around a 32-bit unsigned integer.

[ ... ]

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index e8c389ad3226f..7e077084cb03a 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -303,7 +303,7 @@ static int damon_lru_sort_apply_parameters(void)
>  		goto out;
> =20
>  	err =3D -ENOMEM;
> -	hot_thres =3D damon_max_nr_accesses(&attrs) *
> +	hot_thres =3D damon_nr_samples_per_aggr(&attrs) *
>  		hot_thres_access_freq / 1000;

[Severity: High]
This is also a pre-existing issue, but does this multiplication have the
same 32-bit overflow risk?

If the aggregation interval is sufficiently large, multiplying
damon_nr_samples_per_aggr() by hot_thres_access_freq could similarly wrap
around before the division.

>  	hot_scheme =3D damon_lru_sort_new_hot_scheme(hot_thres);

[ ... ]

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 6bdd1cfd3863a..89c694f6e4fa8 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -112,7 +112,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,
>  	int hotness;
> =20
>  	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
> -		damon_max_nr_accesses(&c->attrs);
> +		damon_nr_samples_per_aggr(&c->attrs);

[Severity: High]
This is another pre-existing issue, but could this multiplication also
overflow?

Multiplying r->nr_accesses by DAMON_MAX_SUBSCORE (100) will overflow a
32-bit unsigned integer if the region has accumulated more than
42,949,672 accesses.

> =20
>  	age_in_sec =3D (unsigned long)r->age * c->attrs.aggr_interval / 1000000;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708013252.9588=
8-1-sj@kernel.org?part=3D2
