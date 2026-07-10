Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8223597B
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644208; cv=none; b=oRcCRB9w3BpWWaXjjEVUMU4jXUuJRFXzPuJPbdkUtv/HgQOzSDSVKJ8WE1FL8l749OKoskrgPunEi+GJlmoUqDrQkWYqYxMfzmVWVXRmSJ9icVxZayR4f+ckCXRdKp5Ky3OtGMekHzVU2mOJoxeFYpty7V/QP5mpsq41NQQZQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644208; c=relaxed/simple;
	bh=BHaO2KwKACDrsAlP90ZBpOklT7qUyJ6sir3gB2n/UnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xvlcjqc2yPCKY7OsS4jO7ltBHWR4/E0U7mIG93mk9nNxOwXT9BRfVOZ1wu2I92pqL+n8mLj8eglzoaDceS/pX/15MwQ/plH+mO1oD/SByhvZY0dzU/iuCgslgkinhSDMBJJX1vUPa/doTRp6T0EpJqvWT8e82982MAP3wEY4mI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3hlbICd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3hlbICd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054C31F000E9;
	Fri, 10 Jul 2026 00:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644207;
	bh=touVI007jSFE3NF+lkF4m539nTXJIwWWETvZSV9rSbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3hlbICd38fUwDuUtYHbuSaLsfyOBwK8rIvxaylJ9MBr+Pfd7Y3yOxTMDYSK40amC
	 Opg7bL+6IEgZJbEK/8KdUcHNS7kEDs8Cf4DBPfceeK+JVrcOzr59M2cxAfutXRFJkv
	 qkXeyf24ZpWjS3UZ7oYor1Y3N+TGgBpXKhJrJkjNJ/xTCJZjq00sx8aGBkGCe3/31k
	 +ZQXuO68VcTNpLIly3yTdHKjnoAjv8+HW0qFLQO0JdODFEBDCFvlhuVLovxjXwehBO
	 VaUasHtK753PTaQCxwjEz6J27kqIZE9BkxHF/cbszJKYPgfsV4fn1g2mvJYyzgOKLx
	 Xo84GrYFdC+vQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 11/19] mm/damon/core: disable access monitoring
 when probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710002349.111414-12-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
 <20260710002349.111414-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:43:26 +0000
Message-Id: <20260710004327.054C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Skipping `check_accesses()` leaves `max_nr_accesses` stale or ze=
ro, permanently breaking the region merging heuristic and causing unbounded=
 region growth.
- [Medium] Skipping `prepare_access_checks()` leaves `r->sampling_addr` uni=
nitialized, leading to arbitrary physical memory reads.
- [Medium] Configuring probe weights on operations that do not support them=
 (e.g., VADDR) breaks the monitoring context completely.
--

--- Patch [11]: [RFC PATCH v1.3 11/19] mm/damon/core: disable access monito=
ring when probe weights are set ---
commit 156f6c878eae64d06c0b181a333eb7acd3bfbbf6
Author: SJ Park <sj@kernel.org>

mm/damon/core: disable access monitoring when probe weights are set
   =20
When users set probe weights, they are interested in the data
attributes.  Not necessarily they are interested in data access
patterns.  Disable the data access monitoring in the case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a0e6a5129fbf3..65f91e3b58d2e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3763,17 +3763,18 @@ static int kdamond_fn(void *data)
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

[Severity: Medium]
Does skipping ctx->ops.prepare_access_checks() leave the sampling_addr
field uninitialized?

If access_check_disabled evaluates to true, prepare_access_checks() is
skipped. The region object allocated by damon_new_region() leaves this
field uninitialized:

mm/damon/core.c:damon_new_region() {
    ...
    region =3D kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
    if (!region)
        return NULL;

    region->ar.start =3D start;
    region->ar.end =3D end;
    region->nr_accesses =3D 0;
    ...
}

Then apply_probes(ctx, false, false) is called below with set_samples as
false. Could damon_pa_apply_probes() read the uninitialized sampling_addr
to generate a physical address, leading to arbitrary physical memory reads?

>  			ctx->ops.prepare_access_checks(ctx);
> =20
>  		kdamond_usleep(sample_interval);
>  		ctx->passed_sample_intervals++;
> =20
> -		if (ctx->ops.check_accesses)
> +		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);

[Severity: Medium]
Will skipping check_accesses() leave max_nr_accesses stale or zero?

If access_check_disabled is true, check_accesses() is skipped, and
apply_probes is called with return_max_wsum as false, so its return value
is ignored. Could this pass a stale max_nr_accesses into
kdamond_merge_regions(), preventing adjacent regions evaluated by large
weighted sums from ever merging and causing runaway region fragmentation?


[Severity: Medium]
What happens if probe weights are configured for operations that do not
support them?

If access_check_disabled evaluates to true because probe weights are set,
this skips check_accesses(). Because ctx->ops.apply_probes would be NULL
for operations like vaddr, it is also skipped.

Does damon_valid_probe_params() need to reject configurations where
ctx->ops.apply_probes is NULL to prevent the context from silently
skipping all data gathering?

>  		if (ctx->ops.apply_probes)
>  			ctx->ops.apply_probes(ctx, false, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710002349.1114=
14-1-sj@kernel.org?part=3D11
