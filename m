Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A163939CE
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352099; cv=none; b=iomKc7sqG2VsziL+f3B8vyOA7XxfjXzpZaHQKdrYXxc4FjnADmMQ4u3DQB5w8/H2Mk/eW5eJNYQ6vn7iowE8+6Hdf+doLrC2zlmpJfqJT7R1qLzPVY7oOJyGZ6GBQN/udbmU7vOAvZ3lxYAzEhE87G8i3EKe1otcUPn3CYGfsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352099; c=relaxed/simple;
	bh=y0O/dW7n6fkValxbAsbrP64PaNrSg2M9CCD1DgSIVAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pzt8RL6FPeSDMMSwAuzk50opWe2TD9/utTuWeL7c2MUetObpI3rAHfCztDUTqpZbcJ2/A+v7R8I7pGjxB7QrWWzPNsy7vocGkcZz134H8bNgmKgtFpmonZH0Wn09bz4z8nCEM8CseHhzoYIpwvXoq42ehN2Bgb1S2mj5uVmHFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntJrCqIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntJrCqIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ED51F00A3F;
	Mon,  6 Jul 2026 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783352097;
	bh=+I9bXJrN+Dv0aKubqOH8y1SpQM1gX3uC+IpiD8grmfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntJrCqIb6JGBBbJkMjlhOw8RQYeV4Eiuna/Cp5yeUZPVEPDTqxRWtCIUlm/E2UfxP
	 amWVswLKqOFM0mgJxcyd6men3Kx5Ig4CX4frZtvKOjfFD6YqkdjvCBJg5MXguXmqFb
	 sfL4XdNmlkqZt2peEKRoEpyE9hAaciwjAyVCnuqwtGYxvUVGlid0RZq+LHfccwWx2Q
	 Pbn0/Wq0Bt9ZenxCnbn/QppmzwYzRFKH1JM5XxGgXoMN/OX0uRMHc/TVXciZ821fml
	 0vDx7H48IS6vJaj4oWkS4p8nJ69IIpP9XHxJekSVx+VF6kth0FB+y1vuaiqlR9i4D8
	 zA9/xLTf0vM8g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 14/16] Docs/mm/damon/design: document
 attrs-only monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-15-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:34:57 +0000
Message-Id: <20260706153457.B0ED51F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Multiplication and accumulation in `damon_probe_hits_wsum()` can s=
ilently overflow a 32-bit `unsigned int`.
- [High] Silently disables all monitoring if probe weights are configured f=
or operations sets that lack probe support (e.g., `vaddr`).

Pre-existing issues:
- [High] The `abs()` macro behaves incorrectly for large `unsigned int` dif=
ferences, breaking region adjustment logic.
- [High] The `probe_hits` array relies on 8-bit `unsigned char`, leading to=
 silent wraparound during long aggregation intervals.
--

commit 61ffda736cfeed6cc995344cdd1d753a189751a8
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: document attrs-only monitoring

This patch series introduces Attributes-only Monitoring for DAMON, adding
probe weights to dictate memory management scoring. When weights are
configured, data access monitoring is disabled and regions are evaluated
based on weighted probe hits instead.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3c5a46e1c079a..6e5a029989a0c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -389,6 +401,30 @@ static bool damon_is_last_region(struct damon_region=
 *r,
>  	return list_is_last(&r->list, &t->regions_list);
>  }
> =20
> +/**
> + * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
> + * @r:		region to get the weigted sum of.
> + * @last:	if the request is for last-window agggregated probe hits.
> + * @ctx:	context of &r.
> + *
> + * Return: the weighted sum of probe hits of the region.
> + */
> +unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
> +		struct damon_ctx *ctx)
> +{
> +	struct damon_probe *probe;
> +	unsigned int sum =3D 0;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(probe, ctx) {
> +		if (last)
> +			sum +=3D r->last_probe_hits[i++] * probe->weight;
> +		else
> +			sum +=3D r->probe_hits[i++] * probe->weight;

[Severity: High]
Does sum need protection against integer overflow here?

If a user configures a large priority weight for a probe via sysfs, this
multiplication can silently overflow the 32-bit unsigned int sum (for
example, 255 * 4294967295).

Could this integer overflow wrap around the score metric, making heavily
weighted regions incorrectly appear as "cold" regions and corrupting the co=
re
memory management data?

[Severity: High]
This is a pre-existing issue, but since Attributes-only Monitoring makes
probe hits the primary metric, could probe_hits overflow its 8-bit limit?

In include/linux/damon.h, the array is defined as an 8-bit value:

struct damon_region {
	...
	unsigned char probe_hits[DAMON_MAX_PROBES];
	...
};

If a user configures an aggregation window that encompasses more than 255
samples, the counter increment in damon_pa_apply_probes():

	r->probe_hits[i]++;

will repeatedly wrap around, destroying the statistical data and corrupting
the region scoring.

> +	}
> +	return sum;
> +}

[ ... ]

> @@ -3211,24 +3259,37 @@ static void damon_merge_two_regions(struct damon_=
target *t,
>   * sz_limit	size upper limit of each region
>   */
>  static void damon_merge_regions_of(struct damon_target *t, unsigned int =
thres,
> -				   unsigned long sz_limit)
> +		unsigned long sz_limit, struct damon_ctx *ctx)
>  {
>  	struct damon_region *r, *prev =3D NULL, *next;
> +	bool use_probe_hits =3D damon_has_probe_weights(ctx);
> =20
>  	damon_for_each_region_safe(r, next, t) {
> -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> +		unsigned int score, last_score;
> +
> +		score =3D damon_merge_score(r, false, ctx, use_probe_hits);
> +		last_score =3D damon_merge_score(r, true, ctx, use_probe_hits);
> +
> +		if (abs(score - last_score) > thres)

[Severity: High]
This is a pre-existing issue, but it seems exacerbated now that arbitrary
weight multipliers are introduced. Does abs() behave correctly for large
unsigned int differences?

The abs() macro implicitly casts its arguments to signed int. If the
absolute difference between score and last_score exceeds INT_MAX, it
will overflow and be evaluated incorrectly as a smaller positive number.

Because weights can now easily push scores past INT_MAX, will this cause
damon_merge_regions_of() to improperly ignore large score differences?

>  			r->age =3D 0;
> -		else if ((r->nr_accesses =3D=3D 0) !=3D (r->last_nr_accesses =3D=3D 0))
> +		else if ((score =3D=3D 0) !=3D (last_score =3D=3D 0))
>  			r->age =3D 0;

[ ... ]

> @@ -3658,25 +3718,38 @@ static int kdamond_fn(void *data)
>  		unsigned long next_aggregation_sis =3D ctx->next_aggregation_sis;
>  		unsigned long next_ops_update_sis =3D ctx->next_ops_update_sis;
>  		unsigned long sample_interval =3D ctx->attrs.sample_interval;
> +		bool access_check_disabled =3D damon_has_probe_weights(ctx);
> +		unsigned int max_merge_score =3D 0, max_wsum;
> +		bool get_max_wsum;
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
> -			max_nr_accesses =3D ctx->ops.check_accesses(ctx);
> -		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx);
> +		if (!access_check_disabled && ctx->ops.check_accesses)
> +			max_merge_score =3D ctx->ops.check_accesses(ctx);
> +		if (ctx->ops.apply_probes) {

[Severity: High]
If a user configures probe weights via sysfs for an operations set that
doesn't implement apply_probes (e.g., DAMON_OPS_VADDR), will this silently
disable all monitoring?

Because access_check_disabled becomes true unconditionally when weights are
present, default access checking is skipped. Without ctx->ops.apply_probes,
no probes are applied either, effectively breaking the DAMON monitoring thr=
ead
for that operations set.

> +			if (time_after_eq(ctx->passed_sample_intervals,
> +						next_aggregation_sis) &&
> +					access_check_disabled)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D14
