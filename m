Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD626CE39
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286343; cv=none; b=Dj+Lceqz3IapTwCImiSkiDjBTHYtjMjjx0MyBL1XC2ofvuRVHbPAwyUpppBFcSRMQF7S8Y6gjTgQ3qSm7ozYHvACZjr1hhWfDCLBW+MRiuAMzIJdXwHFx/l45nfyISoZknBaQ0qvP0X27W7P9hpWJsa92P/lhsEHgcyTXrS4rZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286343; c=relaxed/simple;
	bh=S2x4lDpS9L4fdPBKEmDotvFG89fSqLydmiHZQeTspH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMqDn+Efrt6N+bzveC8piD1vzRZcDEAcv3QPiCyQOjREUnvOTih8dxNPReYNsgFRWDiH6/7q9Eiy3jWWOTh8xbKEaLyCCESDw6oHWcnxyuhcHl44yBv4CaiAJYh8t+L1SCzULRvseXeiQhadxmNFeEGzoc8lWHS8vtmpsutfSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBmLeLxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBmLeLxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5291F000E9;
	Sun,  5 Jul 2026 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783286341;
	bh=2ZU6zI4SpyE/QTZ/MXH2zEbvqLgjgo9pfMCW0CMcvWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBmLeLxTfOi9Ikn2yNR3jHV5n2d5EpYiNlnSs+8X6izbrhMTlrhQ98/FL0KvbKl1v
	 iOyfcmR3Ibi8B6xvHy9uqUxF5vgYUnKwCuJpwQPAfwTtCApr09ADEG9ATrzD20vWUC
	 Zww1kE7UrsMrUwE2bAdGwV/V0GZpgh/rMIpIZbYbYW/Ux0kCgzoZCypQegb9Wysqq2
	 fn8A0tTCtfYStdbqtQpQYMdUShLhS72ZKKhWBWfJB9R9xX2at5E5I3Zut5KXCdqMmM
	 HYzzjWZj9KNzBqKgNHjF4mo2xaDboMMqDQZ8ABEEj6eViQN0kYcQwEy8xiizGL382p
	 1e7c7kNlZusMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/16] mm/damon/core: disable access monitoring when
 probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-9-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:19:00 +0000
Message-Id: <20260705211901.7A5291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] kdamond_merge_regions loop terminates prematurely because max_thre=
s is capped by access count limit, breaking the scaling of threshold for pr=
obe hits.
- [High] Silent breakage of vaddr/fvaddr monitoring when probe weights are =
configured via sysfs.

Pre-existing issues:
- [High] Unbounded integer overflow of probe_hits array elements in struct =
damon_region.
--

commit 6a6c230b9f6562af956ffa250fd34b615f031ce5
Author: SJ Park <sj@kernel.org>

mm/damon/core: disable access monitoring when probe weights are set
   =20
When users set probe weights, they are interested in the data
attributes.  Not necessarily they are interested in data access
patterns.  Disable the data access monitoring in the case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f6e03746b170e..db4e404f95bd1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3670,17 +3670,18 @@ static int kdamond_fn(void *data)
>  		unsigned long next_aggregation_sis =3D ctx->next_aggregation_sis;
>  		unsigned long next_ops_update_sis =3D ctx->next_ops_update_sis;
>  		unsigned long sample_interval =3D ctx->attrs.sample_interval;
> +		bool access_check_disabled =3D damon_has_probe_weights(ctx);
> =20
>  		if (kdamond_wait_activation(ctx))
>  			break;
> =20
> -		if (ctx->ops.prepare_access_checks)
> +		if (!access_check_disabled && ctx->ops.prepare_access_checks)
>  			ctx->ops.prepare_access_checks(ctx);
> =20
>  		kdamond_usleep(sample_interval);
>  		ctx->passed_sample_intervals++;
> =20
> -		if (ctx->ops.check_accesses)
> +		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);

[Severity: High]
If a user configures a DAMON context with vaddr or fvaddr operations,
and creates a probe via sysfs with a weight, will this bypass check_accesses
without a fallback?

It appears that damon_has_probe_weights() will return true and
access_check_disabled will become true.

This unconditionally bypasses ctx->ops.check_accesses(ctx).

However, if vaddr and fvaddr operations do not currently implement
apply_probes (leaving it NULL), it seems no sampling will occur at all.

Does this silently leave the context without any functional monitoring for
virtual address spaces?

>  		if (ctx->ops.apply_probes)
>  			ctx->ops.apply_probes(ctx, false, false);

[Severity: High]
Could this change cause the loop in kdamond_merge_regions() to exit
prematurely when using probe weights?

When probe weights are enabled, kdamond_merge_regions() starts its
region merging loop with an initial threshold scaled by the maximum
probe hit weighted sum.

However, the loop's upper bound cap, max_thres, remains capped by the
maximum possible access counts:

mm/damon/core.c:kdamond_merge_regions() {
    ...
    } while (nr_regions > c->attrs.max_nr_regions &&
             threshold / 2 < max_thres);
}

Because a probe hit weighted sum can easily exceed the access-based max_thr=
es
by orders of magnitude, the loop condition can fail on the very first
iteration.

Will this force the loop to exit prematurely without adequately
doubling the threshold, leaving nr_regions exceeding max_nr_regions?


[Severity: High]
This isn't a bug introduced by this patch, but there is an unbounded
integer overflow of the probe_hits array elements in struct damon_region.

Running DAMON with a large aggregation interval relative to the sample
interval can cause the unsigned char probe_hits counter to wrap around.

In damon_pa_apply_probes(), the counter is incremented without bounds
checking:

mm/damon/paddr.c:damon_pa_apply_probes() {
    ...
    if (damon_pa_filter_pass(pa, folio, p))
        r->probe_hits[i]++;
    ...
}

Since probe_hits is defined as an unsigned char (max 255) in
struct damon_region:

include/linux/damon.h {
    ...
    unsigned char probe_hits[DAMON_MAX_PROBES];
    ...
}

If a region satisfies a probe for more than 255 sampling intervals within
a single aggregation window, the counter will wrap around to 0 multiple
times.

Might this feed arbitrary garbage values to damon_probe_hits_wsum(),
corrupting the metric that region merging and scheme application rely on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D8
