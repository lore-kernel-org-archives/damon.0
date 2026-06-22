Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D03B3883
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138580; cv=none; b=QtjMdL+0/9768CFVrbVv/FXp0SYHL0Oz2inABEIWeRc6O8gJdeYrsCxzOEnc31YjczAH6DL5zNnb9rdnwsyS9EiN0q5VwWlyRmpZpVMuqZPv3vM4f1Q2p8Q89UALaBfwywq/8m/1S8+hmq9FAUU+zFHQMMLRjpMPD//otd1mtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138580; c=relaxed/simple;
	bh=tzusP0Z/YMtZ5M83At6Qj4sX4M1mwvoW4aClEw7WV4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uFkzdBZQ82772TGPzDtE8bo6Uabg9y4zOh+kaEGN3jZsd/g1NNI2UQnY9Mc3c02fzcwtIC2OnabJLSaWlmQlnr3/iPUqUB/Clm2YE65gBE7DS5zzvHjpJxgdMleBqYHLfx75R1VSwqHiBEo+4PwF7pAw3+un0EfKhUbrMa+oIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4KkbIT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4KkbIT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579571F000E9;
	Mon, 22 Jun 2026 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138577;
	bh=qxAmUp25kyaZwzY4yd8q3Exikud7qkIeK7kSyNj6Rto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4KkbIT6fpHdDHGuYMMUzW1+OIqDlZR3lwlzPPbPgczYlbJQNoXMbkVHZ2RpMk6pu
	 4kFDepVpaLwWV6g8o/8tIHMqrhMLIFAo9yHWWjI0vTkoRRWvZxjCC7Av/+mw0oF6Ai
	 erzf6dzUyQMhLqMxpLO0AJvSwz9flHLlyfe//YsYUrD3cBG3TxwJi8LtJeZfXIpzaN
	 pAlySYfwbF15crLUfb91X9Mf/pt8H+XtWYtGomNe4S9SbTHgPmsVBEK5AwvFMYj0AM
	 blW1BeoqN2pK4RT6v9yPYBXg+ETuEe3G3g2VFIptKri/7OrBGpH9QpJ2gTZ6u8/uG8
	 9Sj0GpUgJagtQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 1/2] mm/damon/core: handle zero intervals in
 damon_max_nr_accesses()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622141027.29145-2-sj@kernel.org>
References: <20260622141027.29145-1-sj@kernel.org>
 <20260622141027.29145-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:29:36 +0000
Message-Id: <20260622142937.579571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer underflow and state corruption in `nr_accesses_bp` calcula=
tion when `sample_interval =3D=3D 0`.
- [High] 32-bit integer overflow in access rate scaling and hotness scoring=
 silently breaks region statistics for long aggregation intervals.
--

commit 4e734fc35404d39d1209a202d1c72aa4e9ef543f
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: handle zero intervals in damon_max_nr_accesses()

This commit addresses a divide-by-zero error in damon_max_nr_accesses()
by forcing a denominator of 1 when the sampling interval is zero. It also
ensures the function always returns at least 1.

Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef9..888570f55b416 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const stru=
ct damon_ctx *ctx)
> =20
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attr=
s *attrs)
>  {
> -	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> +	unsigned long sample_interval;
> +	unsigned long max_nr_accesses;
> +
> +	sample_interval =3D attrs->sample_interval ? : 1;
> +	max_nr_accesses =3D min(attrs->aggr_interval / sample_interval,
>  			(unsigned long)UINT_MAX);
> +	return max_nr_accesses ? : 1;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while this commit fixes the
zero interval handling inside damon_max_nr_accesses(), there is a bypass in
mm/damon/core.c that still relies on sample_interval:

mm/damon/core.c:damon_update_region_access_rate()
	if (attrs->sample_interval)
		len_window =3D damon_max_nr_accesses(attrs);

When sample_interval is 0, this bypass circumvents the properly fixed
damon_max_nr_accesses() function, locking len_window at 1. During the
next aggregation window, damon_moving_sum() recalculates the moving
average. Because len_window is stuck at 1, the entire nomvsum is
subtracted from a smaller mvsum.

Will this cause nr_accesses_bp to massively underflow its unsigned int
type and wrap around, corrupting the region's access metrics?

[Severity: High]
This is also a pre-existing issue, but does damon_update_monitoring_result()
suffer from a 32-bit integer overflow for long aggregation intervals?

When a long aggregation interval and short sample interval are configured,
the accesses can be quite large:

mm/damon/core.c:damon_update_monitoring_result()
	r->nr_accesses_bp =3D r->nr_accesses * 10000;

If nr_accesses is very high, does this 32-bit unsigned int arithmetic
silently wrap around, heavily corrupting nr_accesses_bp?

A similar overflow appears in damon_hot_score():

mm/damon/ops-common.c:damon_hot_score()
	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
			damon_max_nr_accesses(&c->attrs);

Does the numerator multiplication overflow the 32-bit bounds before
the division, resulting in an artificially skewed, low hotness score?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622141027.2914=
5-1-sj@kernel.org?part=3D1
