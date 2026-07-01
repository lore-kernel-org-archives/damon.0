Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034F348C75
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920579; cv=none; b=YGCAYb+EvwL292JxNATvoDa/cttYPDbgVNrgbY22qCGmq6JPjQzos9M3cWre/VtOD1CrzOHq8SIsbY05yOH/zWD7oRUO4Z3TdTz50pm8HI7w1D5GxVA22kUSxA8nQIPk7ykgibeWxEGvdlD6qK/yFBUTq9H+g6hYU4KJTs9J3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920579; c=relaxed/simple;
	bh=BpdCtIhR4FwXN27Lb14IWjPCmvwh6gQthZliui8DXGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PBlmj4HxwVs5iPlKePB4B4AoUSzhxLnrugN/cWZ+6TBkRLGpLU2ZjKqSHajeGcn0Iigxh7lS1EAyeYQfEBZbkZkrbl9fcELxlK9VAvgkUNY736WJ0PRYLJtubB6S7SsI1IGzcXftxa7ChRk3oDrqkKwt3dr2r50owJPffxPwcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsUA3XLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsUA3XLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191FD1F000E9;
	Wed,  1 Jul 2026 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920578;
	bh=lk0duhjOz+r/K0rPsyV12v1jp7WBHD7SQCflbc7BbEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BsUA3XLrYWx3aCo48gci8g1kB2o8r5xVFleAXltes8zRjmsnh8TpJzDnWItv4mkAi
	 f7bUf7FvBZ15GqLg3JdRRskjuEArgVhG98DLleq01ycjLPFqLKaD/PhjsMUpCEEuXj
	 AvjtrcBBwG7sAsY+7E2EO0iV6bwIoORb2RKRPjYGhnpVHh4ri9KM0c9SiM5RRB9RX6
	 AgRCxqIuNwBTmA6F1U1qD2qqE91wgg2w9dzYsrUHdN4uDQOEjA0FQbj9RkWJqHfWsJ
	 3Gw7e8fP4AfEIau2NNuzQoKwLi6qGc2n9S1IhEXNXBP7ONboK0q1j0XAGUh1SJIYFn
	 faNlPJ0TDsk8g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] mm/damon/reclaim: remove duplicated
 min_region_sz power of 2 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-5-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 15:42:57 +0000
Message-Id: <20260701154258.191FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the early `is_power_of_2()` check allows invalid `min_reg=
ion_sz` inputs to reach `damon_commit_ctx()`, which exposes a bug introduce=
d earlier in this series that corrupts the live context and silently termin=
ates the DAMON background thread.
--

commit f5d47eadcc06079427c142dd59c5a8aa8721caec
Author: SJ Park <sj@kernel.org>

mm/damon/reclaim: remove duplicated min_region_sz power of 2 check

DAMON_RECLAIM validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the duplicate.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 11b70d0a9a6f0..6469b25cc34f9 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
>  	param_ctx->addr_unit =3D addr_unit;
>  	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> =20
> -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> -		err =3D -EINVAL;
> -		goto out;
> -	}

[Severity: High]
Does removing this early check expose a bug introduced earlier in this seri=
es?

If the user provides an invalid addr_unit (e.g., 3), min_region_sz will not=
 be
a power of 2. By removing the check here, this invalid parameter is passed
to damon_commit_ctx().

Due to an issue in damon_commit_ctx() (from "mm/damon/core: safely validate
src on damon_commit_ctx()"), the dry-run validates dst instead of src:

mm/damon/core.c:damon_commit_ctx() {
	...
	err =3D __damon_commit_ctx(test_ctx, dst);
	if (err)
		goto out;
	err =3D __damon_commit_ctx(dst, src);
	...
}

When __damon_commit_ctx() is called with the live dst and invalid src, it
sets dst->maybe_corrupted before returning -EINVAL:

mm/damon/core.c:__damon_commit_ctx() {
	...
	dst->maybe_corrupted =3D true;
	if (!is_power_of_2(src->min_region_sz))
		return -EINVAL;
	...
}

Could this cause the background kdamond thread to see maybe_corrupted as tr=
ue
on its next iteration and permanently terminate, silently turning a simple
configuration error into a denial of service for the subsystem?

> -
>  	if (!damon_reclaim_mon_attrs.aggr_interval) {
>  		err =3D -EINVAL;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D4
