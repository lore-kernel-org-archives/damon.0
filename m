Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEA42465E
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350191; cv=none; b=KvmRg5PTfs6wUVdi/npKHpZVthUEjr6Ri6XNgDW7FBsL+J5LW5t+S4sVxRQyLM76v2Jn3LU4HEAfdQoyfRzbP5UdaOrRFtGgA7BVVbHZElPU7skBi2IFyL+dWJWAt1F9NQbxcwTxNhbSaOc/n/w2ZlU24rjlO2a6LsV5J4OnTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350191; c=relaxed/simple;
	bh=64UVMToA+BInLqDHRu3dOHcuKwNwMmsJOTCxiIPV4mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOcb3OjRv2ahMHUQ2xibQeWH7L4YXuQxeEcFtUCaMswbA30WJMGDMMXRVKXYrci374vhDMJkfeV+HljSTkI/DRMtlyU3jTnlc2Qauw9B1D2ZBFVpMRgvpWDLU8TZD2SljIC/YAOa+FpF+DSn5EN6ReJruoFpO7r67pr9UlZ1Alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da2KijdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da2KijdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5272F1F00A3F;
	Mon,  6 Jul 2026 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350189;
	bh=stlz6vry7h1DPNQwbV4/bLNQSZ0r71dyiPCXtzwPla4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=da2KijdDbOjWuJhZfdU2hn1WXTw28cd61hpKfzzKGMhEM9lPFxvKucJrXk3K9tQVU
	 n/9r0JONWuQHQkuYD6Vn/P79kEb2rFPDgsx+l3p1fvLEjyAAww31ETQeyC4aKRUxx0
	 SnKTgi3D1swpP03CpCFJj6ZZAgPhZyj4n7R8t8ySOnLci0ui7VDT/krFTJ2vL5x3+1
	 pwzDiw5KPmneFPY1Ck089iEq4sXgHgCPtl1GaIZ33PwcN1SjwAD27bXe7zoosCDmRD
	 xYCJcBxPJN/Z3pNzrBEC3dQ6pTEeXMSi+xFH2nsptRzAIailk8m8aqllXYzpJUltvD
	 VaUyDqQ3NxF9w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 08/16] mm/damon/core: disable access monitoring
 when probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-9-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:03:08 +0000
Message-Id: <20260706150309.5272F1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The region merging loop termination condition is incompatible with=
 weighted probe hits, leading to unbounded region growth.
- [High] Unconditionally disabling access checks forces `nr_accesses` to 0,=
 breaking access-based DAMOS schemes and interval auto-tuning.
--

commit d9de5e6aadab2e17a0c4428844dec0cfc05d08ef
Author: SJ Park <sj@kernel.org>

mm/damon/core: disable access monitoring when probe weights are set

When users set probe weights, they are interested in the data attributes
rather than data access patterns. This commit disables data access
monitoring when probe weights are set.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7aff741d43bd4..a2f768bd07223 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3713,17 +3713,18 @@ static int kdamond_fn(void *data)
>  		unsigned long next_aggregation_sis =3D ctx->next_aggregation_sis;
>  		unsigned long next_ops_update_sis =3D ctx->next_ops_update_sis;
>  		unsigned long sample_interval =3D ctx->attrs.sample_interval;
> +		bool access_check_disabled =3D damon_has_probe_weights(ctx);

[Severity: High]
Can configuring probe weights lead to unbounded region growth during mergin=
g?

When damon_has_probe_weights(ctx) is true, the region merging loop in
kdamond_merge_regions() compares a threshold scaled with weighted probe hits
against max_thres:

mm/damon/core.c:kdamond_merge_regions() {
	...
	max_thres =3D c->attrs.aggr_interval /
		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
	do {
		...
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
}

Since max_thres is hardcoded to the maximum unscaled accesses
(aggr_interval / sample_interval) and doesn't account for probe weights, the
loop could terminate prematurely.

If weighted probe hits result in score differences exceeding this unscaled =
cap,
wouldn't this prevent regions from merging back down below the user-configu=
red
max_nr_regions limit?

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
Does disabling the access checks here break DAMOS schemes and interval
auto-tuning?

By preventing ctx->ops.check_accesses from running when probe weights are
configured, r->nr_accesses will remain 0.

Since damon_nr_accesses_mvsum() consumes these 0s, it seems this would cause
interval auto-tuning to exponentially increase the sampling interval until =
it
hits the maximum allowed value.

Additionally, wouldn't this force all regions to instantly match any DAMOS
scheme configured to target low-access memory?

>  		if (ctx->ops.apply_probes)
>  			ctx->ops.apply_probes(ctx, false, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D8
