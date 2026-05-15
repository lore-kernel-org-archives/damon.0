Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A532459CF
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807101; cv=none; b=bnCUaYl48JDvJhymN4sLvrZLZYfRZ8FpWUozTZVm3IO8qWp7g0hjMDv0NcxNI45pprGmloYcyvo8+W6IQGu18qjg5Jjv4fY8va+nE0hFQWCufVU/GiWIq++D/cv0Ofu/Awk1TROPZyl1duaHyEtC4GRfKv2BCtDZefVvNuGU4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807101; c=relaxed/simple;
	bh=fwyDYuYkJQRWP6po36WWC8VOYWgJif4Nh22aK9EKS/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cG8opBN5dOtXEDmhaqlxDOiGILiUVHsQ66MOqZiuiaAklIbMORc0roScKtL0gssw48h7ZebrR5wSHXYheTU7AiokJ9xEuaNoWgw86OX/buZRAp4B/j+OUxHRcqpPVBCTtV04uqzqrV56SEWAuZLo+BW+t0R6FNo/qotVB05224s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTSPPXmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTSPPXmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECFAC2BCB3;
	Fri, 15 May 2026 01:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807101;
	bh=fwyDYuYkJQRWP6po36WWC8VOYWgJif4Nh22aK9EKS/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KTSPPXmHiyJQDZlQqMmRaQyMhQlvklvMcqjZ+13VMaSLG/qlU6NYlpvj6PLSvkIZO
	 x7e2WbsNJ/JCS1h9TlvGapyOC3xBSnxiAsVlCfu5wFggmv3e1R3Gb3TGvstWHYSiks
	 eYsPGhY+BGbFA8/fNPzmq2jSrd+C6B4RF02CjLS3kHd385YRVKC8eZjJ5Obe/rzm4Z
	 Ku/SvtAeGcin6A/KSeJ1ey1r2Wh2G/N/EXAdIPmYAbW91xl2cEzntWkpXK+nVMgK7G
	 2T53AjqrZ/fcD57EEtp6DUK6OUUawhtW2U2n4jCbW1of1EfgBgP8iXu5pUIhzeFdQ3
	 0PF5mhL3TubOA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 07/28] mm/damon/core: do data attributes
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-8-sj@kernel.org>
References: <20260515004433.128933-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:05:00 +0000
Message-Id: <20260515010501.3ECFAC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `probe_hits` statistics are dropped or corrupted when DAMON =
regions are merged or split.
- [Medium] The `probe_hits` array is defined as `unsigned char` and is susc=
eptible to integer overflow.
--

commit b280c3cfd980db677209be247ad602d23aa561f9
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do data attributes monitoring

Implement the data attributes monitoring execution.  Update kdamond to
invoke the probes application callback, and reset the aggregated number
of per-region per-probe positive samples for every aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f6b4beb4b8ecd..1c9d2fb69f98d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1886,10 +1886,14 @@ static void kdamond_reset_aggregated(struct damon=
_ctx *c)
>  		struct damon_region *r;
> =20
>  		damon_for_each_region(r, t) {
> +			int i;
> +
>  			trace_damon_aggregated(ti, r, damon_nr_regions(t));
>  			damon_warn_fix_nr_accesses_corruption(r);
>  			r->last_nr_accesses =3D r->nr_accesses;
>  			r->nr_accesses =3D 0;
> +			for (i =3D 0; i < DAMON_MAX_PROBES; i++)
> +				r->probe_hits[i] =3D 0;

Is it possible for the probe_hits array values to wrap around?

The probe_hits array is defined as unsigned char in struct damon_region. It
holds the count of positive probe hits over an aggregation interval, and ge=
ts
incremented every sample interval.

Since the maximum number of samples per aggregation is dictated by
attrs.aggr_interval / attrs.sample_interval, and this is fully configurable=
 by
users, what happens if the number of samples per aggregation exceeds 255?

Could the unsigned char array elements overflow and wrap around, yielding
truncated hit counts for high-frequency sampling configurations?

[ ... ]

> @@ -3172,6 +3176,8 @@ static int kdamond_fn(void *data)
> =20
>  		if (ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);
> +		if (ctx->ops.apply_probes)
> +			ctx->ops.apply_probes(ctx);
> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

Does this miss updating probe_hits when regions are merged or split?

Looking at damon_merge_two_regions(), it averages nr_accesses and age when
merging adjacent regions, but ignores the probe_hits array. This leaves the
left region's array unmodified and discards the right region's hits.

Similarly, damon_split_region_at() creates a new sub-region but does not
appear to copy the probe_hits from the parent, leaving the newly split
right half initialized to zero.

Since splitting and merging execute at the end of an aggregation interval,
will the probe_hits statistics be under-reported or corrupted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D7
