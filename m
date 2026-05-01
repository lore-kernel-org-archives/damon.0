Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625319C546
	for <damon@lists.linux.dev>; Fri,  1 May 2026 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599045; cv=none; b=q421VHLRVqwuubkZrx0qI/sHibHJiGPVnMOzRop2DdLrr5mcNeMMiuy0wvkBQ1fdKlSY4GMAM8kJrb80YP+nOUees/uIt81liYHVR0Vtkn+kg8MoRvx8SvIVI1HPLmTlxNSzQnmpkBDGIFWCplLczwGfiElBMmHA5d0zROsFdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599045; c=relaxed/simple;
	bh=ViM1ZQ8gfiqaD38mQIKbUuONAEYWCwV/oywJdI+ig4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fGmQ3Qp378fxIvXF1kWgeptSSzovbkIn+9kz/P3x0QG0gkkNuGK60BlGMmJ+y/+UFRcS6VeZdaCKct8ZWUDroY0NqUlrWBkEpB1YFvI05Zyfuhpfc7Q9vuUFtxdhkKlbM6pJCLGC/u0uhEqeVnESwFdcD41a+9FKrOpqPxSe0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssy1mNVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssy1mNVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC96C2BCB3;
	Fri,  1 May 2026 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777599044;
	bh=ViM1ZQ8gfiqaD38mQIKbUuONAEYWCwV/oywJdI+ig4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ssy1mNVlJOJccNovLk3pVYJ5Al/f5dly2P8Tp3DLSmCgarW5qJvhq7cKPOoVm+3VY
	 5M8nF6UMjXsIkM3+TR3vcMvZCNpbrxvHhXpvDGwndcLH4rbj2WutDRnjFNEy8NWC5v
	 m8zSOL30yG/vKwtzSqN+qpdazKIMsr2I7+M3wvsaIUavfqjt2ZfIRkb+DmeKpW15xl
	 Z4wAuLLojKHjjayXLmOZNTTYPsAkO1p6IdpZ7wLLLzak07bu5Cezl3DqaP8q5KivcN
	 xTL4ow7ANynP2MZKaQhOHkLynFrWZI9Vj8ZBov4ZS0vaHbabrl1QibmiqqsqPKP+bH
	 cmRApI53Wq91w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/reclaim: add autotune_monitoring_intervals
 parameter
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260501011740.81988-2-sj@kernel.org>
References: <20260501011740.81988-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 01:30:43 +0000
Message-Id: <20260501013044.7DC96C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Validation check on `damon_reclaim_mon_attrs.aggr_interval` premat=
urely rejects configurations when autotuning is enabled, and exposes a TOCT=
OU divide-by-zero panic.
--

commit 34f815f9177f234892c1b9608e13d2fc0957697e
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: add autotune_monitoring_intervals parameter

This commit adds a module parameter for utilizing DAMON's auto-tuning
feature with suggested default setups. When enabled, this feature
overrides manually entered monitoring intervals to capture a meaningful
amount of access events per snapshot.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index a60ee800d63e9..7126d47fb8b2f 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> @@ -201,12 +215,21 @@ static int damon_reclaim_apply_parameters(void)
>  		goto out;
>  	}
> =20
> -	err =3D damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
> +	attrs =3D damon_reclaim_mon_attrs;
> +	if (autotune_monitoring_intervals) {
> +		attrs.sample_interval =3D 5000;
> +		attrs.aggr_interval =3D 100000;
> +		attrs.intervals_goal.access_bp =3D 40;
> +		attrs.intervals_goal.aggrs =3D 3;
> +		attrs.intervals_goal.min_sample_us =3D 5000;
> +		attrs.intervals_goal.max_sample_us =3D 10 * 1000 * 1000;
> +	}

In the existing code just above this diff, there is a validation check:

    if (!damon_reclaim_mon_attrs.aggr_interval) {
        err =3D -EINVAL;
        goto out;
    }

If autotune_monitoring_intervals is enabled, could this check prematurely
reject the configuration if damon_reclaim_mon_attrs.aggr_interval is 0?
The auto-tuning override happens right below the check.

Additionally, because this check evaluates the global module parameter
directly instead of a local copy, could a concurrent sysfs write cause a
divide-by-zero panic?=20

If a user sets the global interval to 0 right after this check passes:

    if (!damon_reclaim_mon_attrs.aggr_interval) {
        // passes
    }
   =20
    // concurrent sysfs write sets damon_reclaim_mon_attrs.aggr_interval =
=3D 0
   =20
    attrs =3D damon_reclaim_mon_attrs;

If autotune_monitoring_intervals is false, attrs.aggr_interval becomes 0
and is passed to damon_reclaim_new_scheme(), which performs:

    .min_age_region =3D min_age / aggr_interval,

Would moving this check to evaluate the local attrs.aggr_interval after
the auto-tuning block prevent both of these scenarios?

> +	err =3D damon_set_attrs(param_ctx, &attrs);
>  	if (err)
>  		goto out;
> =20
>  	err =3D -ENOMEM;
> -	scheme =3D damon_reclaim_new_scheme();
> +	scheme =3D damon_reclaim_new_scheme(attrs.aggr_interval);
>  	if (!scheme)
>  		goto out;
>  	damon_set_schemes(param_ctx, &scheme, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501011740.8198=
8-1-sj@kernel.org?part=3D1
