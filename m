Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088FD2BDC28
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692313; cv=none; b=j9Uo1qmHmxauxk9la/E4l+5mUzbt01D9F76BjQKmNW9eCpTdd8aLPCJpq91xIgG9n0n+3yW4S+61nYnFsyauk6cPbQ5dFXagpiPG2ofUg0DyQ1snOi4TRT82EL6w202oA8onjHhmMcTc7JdqTBN1mb6AmgOVPQTmiJPFQunrwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692313; c=relaxed/simple;
	bh=BhcPc8Dv8Eg5lRZCU4aTx3MMW7Qgd7tNcV+I0f3cEoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LAcvCCaxGaryuxBzHrcBg2gBM2rU2Zu5ruFHv8Iio+2K4RVEVXMesJVFBM1zfmV0X4U48BpInyF5aGobCi6nBvgb7BgLHAri2YARu5NpmcneR/oCbZGFJRj6S24DdVsdyWrOz/mrPTT9GMNHGkLcWFniqZ6lxyttVhp4I7ab0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZagLeFBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZagLeFBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666D91F00A3A;
	Fri, 10 Jul 2026 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692311;
	bh=OMQ8+fsMXpavWYkSuGU73Y6tlTPnmsLi0AilmYHRkjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZagLeFBfgZcDU3vOPTTK8y4TB372HMbMGkStYh9b7VZHgQFCtmO3jVdrHoLfNpOx/
	 j0kRoMSqUReCOL6DKNxz9IAXxBVv+JnTc/jrUCemNyTKyG2YcN3OUMIrxPxl88zY+a
	 zMrnmDzK4846ykCOYce7ydxHB5BQF0M4F4BtMUhGTx9sEuWgCjyokqtlFAP1gbrgH4
	 svQy1U14jYtX85B4lsGLd59Ac0nb2lzDktdnRwSFhO3uL1zmQKXyPPD0wE0aMkie4T
	 M6CA++8epailmB3CY9eBXDfWSvaYvFrl/SqFt8+VPlN4+h0V0rM66S6sZfSmQltMGw
	 Lb0ZlOgYDh9lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/19] mm/damon/core: get merge threshold from probe
 hits when weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-15-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:05:10 +0000
Message-Id: <20260710140511.666D91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Silent monitoring failure when probe weights are set on operatio=
ns lacking apply_probes.
- [Medium] kdamond_merge_regions loop termination condition still uses unwe=
ighted access frequency as max_thres.
--

--- Patch [14]: [PATCH 14/19] mm/damon/core: get merge threshold from probe=
 hits when weights are set ---
commit 0b09a73e4b353610f5bc3d4f305131a2f9d7fea8
Author: SJ Park <sj@kernel.org>

mm/damon/core: get merge threshold from probe hits when weights are set
   =20
When probe weights are set, DAMON merges regions based on their probe
hits weighted sum.  But the merge threshold is calculated based on the
access frequency.  Update it to retrieve the maximum probe hits weighted
sum in the snapshot from apply_probes() ops callback, and generate the
threshold based on it.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f7782c69037da..91964336ce31e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_merge_score =3D ctx->ops.check_accesses(ctx);
> -		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, access_check_disabled,
> -					false);
> +		if (ctx->ops.apply_probes) {

[Severity: Medium]
If a user configures a DAMON context with ops that lack apply_probes
(such as vaddr), adds a probe with a weight, and starts monitoring,
could this result in a silent monitoring failure?

Since damon_valid_probe_params() allows this configuration:

mm/damon/core.c:damon_valid_probe_params() {
...
	return true;
}

access_check_disabled will be true, causing check_accesses() to be
skipped. With ctx->ops.apply_probes being NULL, no monitoring data
would be collected and max_merge_score would remain 0.

> +			if (time_after_eq(ctx->passed_sample_intervals,
> +						next_aggregation_sis) &&
> +					access_check_disabled)
> +				get_max_wsum =3D true;
> +			else
> +				get_max_wsum =3D false;
> +			max_wsum =3D ctx->ops.apply_probes(ctx,
> +					access_check_disabled, get_max_wsum);
> +			if (get_max_wsum)
> +				max_merge_score =3D max_wsum;
> +		}
> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

[Severity: Medium]
When kdamond_merge_regions() is called with this new max_merge_score based
on weighted probe hits, could the fallback loop terminate prematurely?

mm/damon/core.c:kdamond_fn() {
...
			kdamond_merge_regions(ctx,
					max_merge_score / 10,
					sz_limit);
...
}

Looking at kdamond_merge_regions(), max_thres is hardcoded to the
unweighted maximum access frequency:

mm/damon/core.c:kdamond_merge_regions() {
	max_thres =3D c->attrs.aggr_interval /
		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
	do {
...
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
}

If a user sets a probe weight such that max_merge_score / 10 > max_thres * =
2,
the loop condition threshold / 2 < max_thres will evaluate to false immedia=
tely,
failing to enforce the max_nr_regions limit during region merging.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D14
