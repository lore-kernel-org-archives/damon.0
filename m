Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7E3191BA
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695097; cv=none; b=nN7XoxCRPAW+ojP0ljU85xXyWRycGVqXBeid50fyqt4u1cVpJgPhVCm/5uoMiTuRnJ7/Nta8I//CP/ibamm0kCxSk+mqYHAdM837Y/kCL1tbdNig78cF3Ya3wTdsFP1Ca6pxmjkf8NLt0mU0Wws/09JflOYirKsQl0zbh0uclOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695097; c=relaxed/simple;
	bh=YbNt5dVz9rcs1qKE1Fws8s36lQPZnfT82wO5VvU0+LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOi6XIFlMWxiZgHn23zTkiLnLPYfYLUzJSGTA0G6D0E4SFKoP8aVNmGAm1hbu2tY+jbhGrKrG8HCFz6/lPuDkMCKZfZ+Oc242T1WVot7CMBKYVlcH8qpO3LQA7yAQDzEhaA1O6OG7JPdWNVWnM5isya/Dm2knQiN2naZYefMuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4U/cKRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4U/cKRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0471F000E9;
	Fri, 10 Jul 2026 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695094;
	bh=JrZKDUKAufruqBmR8eCRlyYp6vvQIW+2MKEJz43JlKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4U/cKRWguWwUYVhUIHoL7rpkC6IJ4AhlpG9QdMQIaHpJml/BFk50vVDipkWP7bhR
	 BNttusrcEQAc7IE7wmzCstB4PRaKEUWKKot7iNGI7LJ/rfwgujuMWuwT69dEaNjnvp
	 AYrjHkQC5Vsc7qv+VjPlxPG+2JTpiKIXEEATT3hNhJAdA91AvExo7OpTZ3hsmWcePF
	 ppPUsCVBl7zx9jkoulHm43i3vAZWCBiQMfWtRMd7AAuqoDHUidpbGwrfgzeLtlIgAl
	 BOHEPGbW/adSz3qChxxOri44kHU4RCR2kfU63fZHcHp3arqKKpD6W2LPh9hpqDEjqP
	 wYiMlvDNKjaNA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 10/19] mm/damon/core: validate params for probe hits weighted sum overflow
Date: Fri, 10 Jul 2026 07:51:26 -0700
Message-ID: <20260710145127.27137-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710140743.A469F1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:07:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Pre-existing integer overflow in `damon_merge_two_regions()` during weighted average calculations.
> - [High] Pre-existing integer overflows in `damon_sample_bp_to_count()` and `damon_sample_count_to_bp()`.
> --
> 
> --- Patch [10]: [PATCH 10/19] mm/damon/core: validate params for probe hits weighted sum overflow ---
> commit 74455514643a15cd1b70c8a9afa3237ba4226d34
> Author: SJ Park <sj@kernel.org>
> Date:   Fri Jul 10 13:46:39 2026 +0000
> 
>     mm/damon/core: validate params for probe hits weighted sum overflow
> 
> This commit adds parameter validation to prevent integer overflows in probe
> hits weighted sum calculations. It ensures that user-configured probe weights
> do not cause the weighted sum of probe hits to exceed the maximum possible
> value during monitoring.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4f1425e56950b..a0e6a5129fbf3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1335,6 +1335,9 @@ static void damos_set_filters_default_reject(struct damos *s)
> >  static bool damon_valid_probe_params(struct damon_ctx *ctx)
> >  {
> >  	unsigned long sample_interval;
> > +	unsigned char max_probe_hits;
> > +	struct damon_probe *probe;
> > +	unsigned int wsum, wsum_to_add;
> >  
> >  	if (!damon_has_probe_weights(ctx))
> >  		return true;
> > @@ -1342,6 +1345,18 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
> >  	sample_interval = ctx->attrs.sample_interval ? : 1;
> >  	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
> >  		return false;
> > +
> > +	/* invalid if probe hits weighted sum can overflow */
> > +	max_probe_hits = damon_nr_samples_per_aggr(&ctx->attrs);
> > +	wsum = 0;
> > +	damon_for_each_probe(probe, ctx) {
> > +		if (probe->weight > UINT_MAX / max_probe_hits)
> > +			return false;
> > +		wsum_to_add = probe->weight * max_probe_hits;
> > +		if (UINT_MAX - wsum < wsum_to_add)
> > +			return false;
> > +		wsum += wsum_to_add;
> > +	}
> >  	return true;
> >  }
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but does damon_merge_two_regions() suffer from an
> unsigned long overflow during average calculations?
> 
> mm/damon/core.c:damon_merge_two_regions() {
> 	...
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
> 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
> 	...
> }
> 
> During the calculation of the merged region metrics, if a region size reaches
> 1GB and nr_accesses is just 4, their product is 4,294,967,296. On 32-bit
> architectures where unsigned long is 32 bits, this will instantly overflow.
> 
> Additionally, on 64-bit architectures, the age variable could grow indefinitely
> and overflow if a region becomes very large over a long uptime. Can this lead
> to corrupted statistics and misfiring of memory management actions?

Known low priority issue.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential integer overflow in
> damon_sample_bp_to_count() and damon_sample_count_to_bp():
> 
> mm/damon/core.c:damon_sample_bp_to_count() {
> 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> }
> 
> mm/damon/core.c:damon_sample_count_to_bp() {
> 	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> }
> 
> Can these calculations overflow? The functions perform 32-bit multiplication of
> bp (or the remainder in mult_frac) and the max samples using unsigned int
> arithmetic.
> 
> If max_samples (aggr_interval / sample_interval) exceeds 429,496, which is
> possible with a high aggregation interval compared to the sampling interval
> (e.g., 5s aggregation and 10us sample intervals), the result could exceed
> UINT_MAX (4,294,967,295) and silently overflow. Could this corrupt monitoring
> region access counts during dynamic DAMON attribute updates?

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=10


Thanks,
SJ
