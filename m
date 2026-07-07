Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4B23183F
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 04:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399722; cv=none; b=pnMDnCqH9lN10FOkanL6gTGrBz74r9wmvfeAYVvQw3+nb4cUtolUsnlvukhHPKfvXTGnIrY1XA1aLAr/50z5nUVNcfTW0QvzX+TbYQbOMxWss88X73CvVqSJkSJATpMvbzoypiYjOsreFA9/G8eyXakjO+2lj4j63BRyr/Hbt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399722; c=relaxed/simple;
	bh=JRctYFFukFHeP+OhgcBN1TZp72ilVFnIrecgGQw6Nzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qsojMTrtJaXLNUkpChe3k+jWDp8o6IbbI/0pwDcR4sdrAWT+zDfaudURH/77xDgvfWIxudxU0H1VUsetybFctx+IotEyBE59T8lJthRWXH+HmMWwKkpVbXgNlLr/Az/AKVAunhdltNVBOb+tt0LYbAWHbQSCT7dVDTS7OoiBGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWtmCmp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWtmCmp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBC61F000E9;
	Tue,  7 Jul 2026 04:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399721;
	bh=5afSFr9OS/Sicqt0AkEQv2EABRunNSdOsThkJswwKWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWtmCmp150CrotfacL3etu+m2e8/uSCgnMU+WvSEQgMnjf24+sbGcuKA2ATgsF3gu
	 ht4IgMU92SlkpIcBRF/tI4yVaq/PBvsLUNkB3sqcV779gWx1ETGLsR9+4k/Lj9tAK+
	 bbejoI3N4QDUspi0vkC6fy1hqNX306XEBhjfCHmipPh2uQ5TLQvZZH8/EoOXFqjdNk
	 +dj6QL9qb2QaOLUj8lf+VmO/TO8H+/9iJ5OmrSFBZ9fcJ/poOMK+dgRowR956dMRvo
	 n+ECcBJc/k3oY1UGTyf70uLjVVCUuaZipmx1wUnQMaNykbKK4GD7F/A28GtF+orOEU
	 yrdoZyM/F7WbQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] mm/damon/core:
 s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707043828.97900-2-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
 <20260707043828.97900-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:48:40 +0000
Message-Id: <20260707044841.3BBC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiplication overflow in DAMON access rate calculations due to 3=
2-bit arithmetic.
--

--- Patch [1]: [RFC PATCH 1/6] mm/damon/core: s/damon_max_nr_accesses()/dam=
on_nr_samples_per_aggr()/ ---
commit 928ef68b58766df0da13e507ad449f7ba9d5c79d
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/

This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
to better describe that it returns the number of samples DAMON checks for
each region per aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 390e00b3685ef..e710e2789085e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -880,7 +880,7 @@ static unsigned int damon_age_for_new_attrs(unsigned =
int age,
>  static unsigned int damon_accesses_bp_to_nr_accesses(
>  		unsigned int accesses_bp, struct damon_attrs *attrs)
>  {
> -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;

[Severity: High]
This isn't a bug introduced by this patch, but can this multiplication in
damon_accesses_bp_to_nr_accesses() overflow 32-bit arithmetic?

If the sample interval is configured to a small value and the aggregation
interval to a large value, damon_nr_samples_per_aggr() can return a large
number. Multiplying accesses_bp by this large number wraps around modulo
2^32 since both operands are 32-bit unsigned integers, resulting in an
incorrectly reduced access count.

>  }
> =20
>  /*
> @@ -893,7 +893,7 @@ static unsigned int damon_accesses_bp_to_nr_accesses(
>  static unsigned int damon_nr_accesses_to_accesses_bp(
>  		unsigned int nr_accesses, struct damon_attrs *attrs)
>  {
> -	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> +	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));

[Severity: High]
This is a pre-existing issue, but does the use of mult_frac() in
damon_nr_accesses_to_accesses_bp() also suffer from a 32-bit overflow?

When nr_accesses is sufficiently large, the internal calculation in
mult_frac() overflows 32-bit arithmetic.

>  }
> =20

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
This isn't a bug introduced by this patch, but does this calculation in
damon_lru_sort_apply_parameters() overflow on 32-bit architectures?

Multiplying the sample count by hot_thres_access_freq overflows 32-bit
arithmetic on 32-bit systems when the sample count is large.

>  	hot_scheme =3D damon_lru_sort_new_hot_scheme(hot_thres);
>  	if (!hot_scheme)

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
This is a pre-existing issue, but could this calculation in
damon_hot_score() result in a 32-bit overflow?

Multiplying r->nr_accesses by DAMON_MAX_SUBSCORE (which is 100) overflows
32-bit arithmetic if the number of samples is near UINT_MAX. This might
cause hot memory to be incorrectly identified as cold.

> =20
>  	age_in_sec =3D (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
>  	if (age_in_sec)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707043828.9790=
0-1-sj@kernel.org?part=3D1
