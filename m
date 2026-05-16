Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAE34BA5B
	for <damon@lists.linux.dev>; Sat, 16 May 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958012; cv=none; b=eNEeGyIxNxlhEFIxULn4Ar+y90uUhwIQN1jTF8Zm+/ShU+Tz4oXW4HMnaxjjPripOincASdwYSoK1iXOUQbbAXkCN7LFthaZdHy66jTbLGLmvBJ+tE2lbTBEtkNhcDUnFWTYYDvavp5rWVumslrIcSos6vQV/EreTezhIIwutSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958012; c=relaxed/simple;
	bh=OWEkr8mTxkjdRenl1nj4RzH3/E4SD1DqYoXjqfjfGXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XWEzdGSdDDeB2Tu64/yw02TAhn6OF7lFD94/7KqxySROGf4Biks8GeAqZHytqBXCcfrA6yyOfHSuMarRQZnxgMP7RXDZ3luJjuk/2mr3gpSmi9404eeiujQdl9rLuhR3dUtsiaRuYVTUV1MUcpU+Bw5uTtYTd1or4ch3Toj5SBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lfz9nEXd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lfz9nEXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77604C19425;
	Sat, 16 May 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958011;
	bh=OWEkr8mTxkjdRenl1nj4RzH3/E4SD1DqYoXjqfjfGXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Lfz9nEXdui6595cg33lFAxP1ACPAWA3lIeBLMz0mu1O88D9qmyX693ETyURkKnLOd
	 wVSpcV10NGLdIxevS0Ad84nGj/8y9ifCy54TVq7IbZWgxsTOKmZa0lNEimJPLBuyAe
	 MW2GO2wtwrFEgPxjIuhO7RHBZKcBKzcm5H/ISch25W1zmfVtE7ddiFo3xh6hgrA3Le
	 H3I2Xwf8mc/f5/uEBS3wioOgcNZ4tDu08jlk5YaPAEbS/p6Ui0C7/aXnMtVZuwUK/S
	 Q+HD/JhsK6+QfP50FcjxVigjkvJr5FhY0ZZbb2W9/TRAqGN67kxV5rNUFjBhwwNKzA
	 OJxzEWHW+2azA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 07/28] mm/damon/core: do data attributes
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516183712.81393-8-sj@kernel.org>
References: <20260516183712.81393-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 19:00:10 +0000
Message-Id: <20260516190011.77604C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `probe_hits` array counters can silently overflow, yielding co=
rrupted monitoring results.
- [High] DAMON dynamically merges regions based strictly on `nr_accesses`, =
which corrupts the spatial granularity of `probe_hits`.
- [High] If DAMON is run without `check_accesses`, all regions will be aggr=
essively merged up to `sz_limit`, neutralizing data attribute monitoring.
- [High] Size-weighted average calculations for `probe_hits` overflow `unsi=
gned long` on 32-bit systems.
--

commit 55dcc5294b4ee96c9d7e5a24e9dcdb0d798c401d
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do data attributes monitoring

Implement the data attributes monitoring execution.  Update kdamond to
invoke the probes application callback, and reset the aggregated number
of per-region per-probe positive samples for every aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e5667660b4cd9..dde3c8d8fef89 100644
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

Can probe_hits overflow here?

The probe_hits array is defined as unsigned char, which has a maximum value
of 255.

The number of samples per interval is user-configurable and can legitimately
exceed 255 (e.g., a 1000ms aggregation with a 1ms sample interval yields 10=
00
samples).

If a probe matches continuously under such configurations, could the counter
silently overflow and wrap around, corrupting the monitoring results?

>  			damon_verify_reset_aggregated(r, c);
>  		}
>  		ti++;
> @@ -3179,6 +3183,8 @@ static int kdamond_fn(void *data)
> =20
>  		if (ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);
> +		if (ctx->ops.apply_probes)
> +			ctx->ops.apply_probes(ctx);

If DAMON is configured strictly for data attribute monitoring where
check_accesses is NULL but apply_probes is set, max_nr_accesses and all
regional nr_accesses persistently evaluate to 0.

Will this cause all adjacent regions to have a calculated difference
threshold of 0, resulting in all regions merging indiscriminately up to
sz_limit during the subsequent kdamond_merge_regions() call?

Additionally, damon_merge_regions_of() merges adjacent regions by evaluating
only nr_accesses:

abs(prev->nr_accesses - r->nr_accesses) <=3D thres

Since this merge condition ignores probe_hits, could two contiguous regions
with identical access frequencies but vastly different data attributes be
incorrectly merged?

Does calculating the size-weighted average for probe_hits risk overflowing =
on
32-bit systems?

When damon_merge_two_regions() calculates averages using:

(metric * sz_l + metric * sz_r) / (sz_l + sz_r)

Both sz_l and sz_r are evaluated in bytes as unsigned long. On 32-bit
systems where ULONG_MAX is roughly 4 GB, a 200 MB region with 25 probe_hits
yields an intermediate product of 5,000,000,000.

Does this silently overflow the 32-bit unsigned long and corrupt the region
metrics?

> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516183712.8139=
3-1-sj@kernel.org?part=3D7
