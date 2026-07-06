Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9807383C95
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351084; cv=none; b=gof1WyptTYdxOeYI5de5cXhfJqyRwJGvHKkxsZMY969Ow3ka3P9qUPY8JDm1X5QLqRffNcg0fk6lUiKTICCBBeruohQY8Op6frDIZLtSGimjEKkzhTZMjrOzlkQTQE3MxVGj6jWN3LRVRebS5UXMsiGf/kEHgP/RBeZstViqe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351084; c=relaxed/simple;
	bh=MlAfvNwQl5uPkyuKcDX7LeNjs1zJQqltwV6u1AVDuxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWhsFSuez+shVWKXgp2cGyKbL8HItMJM2BSx1edUL5xQktBY8dj0+0QPAoNZLCM+TJw8lnOQWUvX7sBWXOlII/Lsij7pgp4yqRMyKgl88/6yzHiabUb1LCmMSfX2myc61TgK/mQ3dtilFqEvhUiQyrOytmArZp/lSUWHR8rRKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XimjzZky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XimjzZky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AF71F000E9;
	Mon,  6 Jul 2026 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783351082;
	bh=c1ozC0LvLppseOD+yq4DT8Ex5QZl6OkTMA8pE84tNpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XimjzZkyLzJExpxtCIGgLzzBlgCOQDMI8zeYhiNT3INlp/ff6mAReWcDayWajgxtB
	 mzuJedU9UYPwX5kpRE3pIO20syWczVY9yQxiukdrHEktDjjE95qFL2qch8igWqf6Gf
	 9ahFrJDbNzTcYiQfbyTReRTcpbR0633mIz110VL6xgz7UpQywomlMWTouWVq+dLT6S
	 5D68pkS3KVRKQm1YCWAUYBRYdUYgol/vy3tADRYzKXFNheNS3arUiHxYCjcDrgDv5f
	 AhhGjP3eiodCGyEG4zflKoVdCbu4KeT7ldDflGgLx0wZ7TzfZw7gohAa0zcI1UADBj
	 jPHNb++A/Lpgg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 11/16] mm/damon/core: get merge threshold from
 probe hits when weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-12-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:18:01 +0000
Message-Id: <20260706151802.28AF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Region merge loop terminates prematurely because `max_thres` is un=
scaled for probe hit weighted sums, causing a failure to respect `max_nr_re=
gions`.
- [High] Adding probe weights to contexts using operations without `apply_p=
robes` (e.g., `vaddr`) silently breaks all monitoring.
--

commit f896f3e81bf75b446b16cb4f79f6673a154b512b
Author: SJ Park <sj@kernel.org>

mm/damon/core: get merge threshold from probe hits when weights are set
   =20
When probe weights are set, DAMON merges regions based on their probe
hits weighted sum.  But the merge threshold is calculated based on the
access frequency.  Update it to retrieve the maximum probe hits weighted
sum in the snapshot from apply_probes() ops callback, and generate the
threshold based on it.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index be026c86384e4..fa78d8d592aa3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3726,9 +3727,18 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_merge_score =3D ctx->ops.check_accesses(ctx);

[Severity: High]
Does setting probe weights on a context that lacks an apply_probes callback
(like vaddr) silently break monitoring here?

If a user sets probe weights via sysfs, access_check_disabled will be true.
This skips check_accesses(), but since apply_probes is NULL, neither callba=
ck
runs. The accesses are never updated, and all memory appears completely col=
d.

> -		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, access_check_disabled,
> -					false);
> +		if (ctx->ops.apply_probes) {
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

[Severity: High]
Can this cause kdamond_merge_regions() to fail to reduce the number of
regions below max_nr_regions?

When kdamond_fn() later passes this max_wsum / 10 as the initial threshold
to kdamond_merge_regions(), the merge loop termination condition compares
it against an unscaled max_thres:

mm/damon/core.c:kdamond_merge_regions() {
	...
	max_thres =3D c->attrs.aggr_interval /
		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
	...
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
}

Since a user-defined weighted sum can be vastly larger than the unweighted
max_thres, will the loop condition fail prematurely, leading to an
unbounded growth of memory regions?

> +		}
> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D11
