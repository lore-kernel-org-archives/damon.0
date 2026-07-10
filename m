Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DD126C03
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643922; cv=none; b=B6N5ZKRX5FCMIHqKkX0vloAOmzaKx1sDQTAXfpL6pd2srb8KjqMwkAnmPrV2RqND7Da/gryAJZLwrCpoBf1LX1JkflMduYPMuceGyTt/LL1nWGayfrZ6eBeeQAsb6WrCpMCXqYuJK58qEj46bpDt9pbXamvXgSGUFS7YPWaVbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643922; c=relaxed/simple;
	bh=MRy77QGrND2554YMUENmxj/lPiZ7zRQqGbmDONGmEIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uw2uQ2aWUuYw1QJGdMGqU1ibKkWJGSFcnG+f7wkhjr3A+asUyqN1gjSk6kYUJuyRCM7fV6pY//27X1s0OSiR98JPC0fyu4bdhnmRy+eTbtMdEE6VumbyGIvxfAT51QG3YezEtSDIHDGY9ZZ10jLA6E5UPuy6d3+KjPXzxwyx1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaeiIcPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaeiIcPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C011F000E9;
	Fri, 10 Jul 2026 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643921;
	bh=+G04pCWY+esYk0J/NLaXsz8/1+FMwIigX+hAOv/JPfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jaeiIcPVUQ3U8Z2q0SyLpthbj62PrhoY3QQKQF5U/FhRI5qQPkBUW/S9FklNeLNgo
	 5GJE4Lu/Qoh7vSoxPjvENXoMmi8zYTrHmKOetD2HlXQf0nj8qmXWzHr1AaLfCCaZkM
	 YipfTZ0HKh/IcTuZ95hgxI5l2zpydUlWgpsLuWWxHHAiWdyL+eKfje63jRCl0stAiQ
	 qBIiUOC32tN62h09KS5WUIN9J7t9DqUWtPADjjgjJHBXpi7YldI2T6th7ftciu0c09
	 tx1O+T+3Kk1gJyFpSfhbmS/6Tqu1Pg81I61mbaGONQ+Kt+bE5OtawQKtc8p6ytBG/W
	 lOP+K2ddkw9VQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 14/19] mm/damon/core: get merge threshold from
 probe hits when weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710002349.111414-15-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
 <20260710002349.111414-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:38:39 +0000
Message-Id: <20260710003840.32C011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature termination of regions merging when using probe weights,=
 breaking `max_nr_regions` enforcement.
--

--- Patch [14]: [RFC PATCH v1.3 14/19] mm/damon/core: get merge threshold f=
rom probe hits when weights are set ---
commit c2e77863ffba068b4f2b7db5f45690d846ec2ad7
Author: SJ Park <sj@kernel.org>

mm/damon/core: get merge threshold from probe hits when weights are set

This commit updates DAMON to calculate the merge threshold based on the
maximum probe hits weighted sum when probe weights are used. It updates
kdamond_fn() to retrieve this max sum via the apply_probes() callback.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f7782c69037da..91964336ce31e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_merge_score =3D ctx->ops.check_accesses(ctx);
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
Does this regression break the max_nr_regions enforcement in
kdamond_merge_regions()?

When probe weights are set, max_merge_score is derived from the user-provid=
ed
probe weights and passed as the initial threshold to kdamond_merge_regions(=
):

mm/damon/core.c:kdamond_merge_regions() {
    ...
    max_thres =3D c->attrs.aggr_interval /
        (c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
    do {
        ...
        threshold =3D max(1, threshold * 2);
    } while (nr_regions > c->attrs.max_nr_regions &&
            threshold / 2 < max_thres);
    ...
}

However, max_thres is hardcoded to the maximum unweighted access frequency.

If the dynamically weighted max_wsum is large enough, the initial threshold
passed to kdamond_merge_regions() could exceed max_thres * 2.

If that happens, wouldn't the loop terminate prematurely on the first pass
even when nr_regions > max_nr_regions, allowing the number of regions to
grow unboundedly?

> +		}
> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710002349.1114=
14-1-sj@kernel.org?part=3D14
