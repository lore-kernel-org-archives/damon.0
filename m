Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582171C84A0
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350127; cv=none; b=iSb4HUAiWRmHsGD/juIiac7r7Hq/phBizyYbfUVr1jVovi+uK4eCUud4twhVMjByioti6rXQ37eSM9z6BDQw7pvYpe5OWWUlxZzHLTYCfeN3uQMOu5WAZhL1FTyuAoktfyYHKXsIDJ0xOHPHFnU0ckmxe+nG+MDFydPlXtl2NFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350127; c=relaxed/simple;
	bh=AfaoIEpFB1OL8Zi0zFRQT8Il6iiDUFK1DiLdWuy1jbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjyQlnyqO/vLJKtv9vijVaX2uKEtMfnYUwLKc9OOrtbZ5dVqqtLlHXOALx5E7IoZIonyzFr1b+m/7/2/xglAX0zy5eCEZGpMf3PcZRa3niKcwH7F3BTfONH/m2KcR5rw+4fGG4G/ORCtvxakUQWUO4KeyAUK7ldmuc7d9l+vqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj14hyuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj14hyuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07DC1F000E9;
	Mon,  6 Jul 2026 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350126;
	bh=qrjLVVgDeR84RePIjAOcA3QiJ6QX0auB5qxZMf2w58I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qj14hyuX6AUySlKFbgdJzjbFDHqPNPrakp6OKHrwoyos6qwcP8zFvNsvfSvN2LJKZ
	 LO9mj8EiPFELfQLeGPeSxwDmmDM9g5mWjqx0HxbE5SPtY8Wfq2Y4gcyOQlgv6ePDPh
	 q7vuZ4YK4MKeCWVUyhF8qR+UAMiwowMGjQz7l5aYcOMXzSM5ITs7vLHd7zuG6Sd/C3
	 Q/4PkZ9ncT/+RNnmHpDBh+5n2dRN9pQk7ByzkifBrR2gRLug1GgkyH9O/3ESy5k1UU
	 brxC1UdpU3cw4+/ghnO/KvDZJOPcHM63EHk08KLtMgFxupEPbCvoWvfpQ56gTj6c8g
	 JetH6zvUtvPlg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 09/16] mm/damon/core: set samples in
 apply_probes() if probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-10-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:02:05 +0000
Message-Id: <20260706150205.D07DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Region merging loop bound `max_thres` is incorrectly scaled when p=
robe weights are used, causing premature loop termination and permanent vio=
lation of `max_nr_regions` limits.
--

commit cc6e72a3b37a62b24190b0e42f141fba6caab8fc
Author: SJ Park <sj@kernel.org>

mm/damon/core: set samples in apply_probes() if probe weights are set

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset.  Ask
apply_probes() to set those together in the case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a2f768bd07223..5311aa689c8e7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3727,7 +3727,8 @@ static int kdamond_fn(void *data)
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);
>  		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, false, false);
> +			ctx->ops.apply_probes(ctx, access_check_disabled,
> +					false);

[Severity: High]
Does enabling probe weights here introduce a regression with the region
merging loop bound in kdamond_merge_regions()?

Later in the series, a commit ("mm/damon/core: get merge threshold from
probe hits when weights are set") derives the merge threshold from weighted
sums when probe weights are used. However, the loop bound max_thres in
kdamond_merge_regions() remains tied to the raw access frequency:

mm/damon/core.c:kdamond_merge_regions() {
	...
	max_thres =3D c->attrs.aggr_interval /
		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
	do {
		nr_regions =3D 0;
		damon_for_each_target(t, c) {
			damon_merge_regions_of(t, threshold, sz_limit, c);
			nr_regions +=3D damon_nr_regions(t);
		}
		threshold =3D max(1, threshold * 2);
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
}

If a large weighted sum is used as the initial threshold, it seems the loop
will exit immediately on the first iteration without merging enough regions
because threshold / 2 will already exceed the raw max_thres.

Can this permanently violate the max_nr_regions limits?

> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D9
