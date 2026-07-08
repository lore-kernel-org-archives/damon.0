Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417303B19AB
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479500; cv=none; b=TUulNlJEgucLeMrww/ipxupDXETB11UFDlstruJaD1dCeRBjPUcjMIKZzg/iRsRdTsLxpo3xYptMqGF2IT6ZjmU29n0JxPNw/ilt9qpaXqqLMgZTuBSVmbVvyl+RV3eTy78LKrqzj5XLtmY8JQyDCYPq2SNyCJix8RgaLFrnalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479500; c=relaxed/simple;
	bh=n/80jTFIiSL0JxPnqAkBtf6KT15/emWq9pXEeGyXVqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsgRxWYGFQ/paFigjOqA1bXG5tinXmwaLt/RdM8Gv7cbvLnsux1bq6RJ5yinwWy843ayntosE4g8KBgJ6DMVBBaZmUUppdI6nrSpY34IzgMgHzXWIKvIfhWNNrI8XoOr2+/ULUqzasbLox0zXnaQEdYgMsWqMK9Gx1JSt5iWg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLFcTeqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLFcTeqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9701F000E9;
	Wed,  8 Jul 2026 02:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783479498;
	bh=pPyOYbsRjvPCtHaEtadWIDQFTmcXS71rUkei1sQyWlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLFcTeqWWTEV3/Cx9Qp9YVq0G5MyMmgFBMjUtJeoiMu/eUIUEHioi2gzNAN7RtqQd
	 b46N9bU0bWW5wi0ai+iZ2B0kVISKvkkSCLuPylL8IwIPt+Ytv8xj+Lr8OXEMD8mWix
	 nko7yNG2cr52kIwmidzaEKC+t6zZK/NNt6QlsxkI1LTFv6wEEztha59boHFtPJiK7K
	 /jb8mmHT0DtVj+rA6Zilfe3XICE/rDfCCDuAzIlhIfto57vO6Z6P4UkpmdelH0+63q
	 MRhcBm1FcYsY7S0eyNml80sfN8f2QhIBeRKNRGqIQH4D/2zC38ajEyi2VSIcpurDuw
	 g5YuSIUwqv8mA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 2/7] mm/damon/core:
 s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708024855.116614-3-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
 <20260708024855.116614-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:58:18 +0000
Message-Id: <20260708025818.BD9701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Arithmetic overflow in DAMON access frequency calculations for lar=
ge sample counts.
--

--- Patch [2]: [RFC PATCH v1.3 2/7] mm/damon/core: s/damon_max_nr_accesses(=
)/damon_nr_samples_per_aggr()/ ---
commit f4e38af8a3753be681be346a7474a71c5bfadd23
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/

This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
to better describe that it returns the number of samples DAMON checks for
each region per aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a15005db82899..177e5abc981ef 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -880,14 +880,14 @@ static unsigned int damon_age_for_new_attrs(unsigne=
d int age,
>  static unsigned int damon_accesses_bp_to_nr_accesses(
>  		unsigned int accesses_bp, struct damon_attrs *attrs)
>  {
> -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
>  }

[Severity: High]
This is a pre-existing issue, but does multiplying accesses_bp by
damon_nr_samples_per_aggr() overflow 32-bit arithmetic?

If the total samples exceed ~429,496 (e.g., by configuring a large ratio
between the aggregation interval and sample interval), this calculation
seems to wrap around, leading to a drastically lower access count threshold.

>  /* Convert nr_accesses to access ratio in bp (per 10,000) */
>  static unsigned int damon_nr_accesses_to_accesses_bp(
>  		unsigned int nr_accesses, struct damon_attrs *attrs)
>  {
> -	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> +	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this use of mult_frac()
overflow?

The mult_frac macro internally multiplies the remainder of nr_accesses by
10000, which appears to overflow 32-bit math for large interval
configurations.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index e8c389ad3226f..7e077084cb03a 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -303,7 +303,7 @@ static int damon_lru_sort_apply_parameters(void)
>  		goto out;
> =20
>  	err =3D -ENOMEM;
> -	hot_thres =3D damon_max_nr_accesses(&attrs) *
> +	hot_thres =3D damon_nr_samples_per_aggr(&attrs) *
>  		hot_thres_access_freq / 1000;

[Severity: High]
This is a pre-existing issue, but does this calculation overflow hot_thres?

Multiplication of the samples by hot_thres_access_freq (typically hundreds)
looks like it overflows a 32-bit integer when calculating the hot threshold
if samples exceed ~8.5 million.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 6bdd1cfd3863a..89c694f6e4fa8 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

> @@ -112,7 +112,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,
>  	int hotness;
> =20
>  	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
> -		damon_max_nr_accesses(&c->attrs);
> +		damon_nr_samples_per_aggr(&c->attrs);

[Severity: High]
This isn't a bug introduced by this patch, but could this multiplication
cause an integer overflow?

The r->nr_accesses variable is multiplied by DAMON_MAX_SUBSCORE, which is
100. If nr_accesses exceeds ~42.9 million, it overflows a 32-bit integer,
resulting in a drastically lower or zeroed hotness score. This could lead to
miscalculating region hotness and erroneously reclaiming actively used page=
s.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708024855.1166=
14-1-sj@kernel.org?part=3D2
