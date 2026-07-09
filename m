Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73799282F35
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609334; cv=none; b=a0W1MXwoTAnD7dkZdNK1ieEEK3fU80t0Cz+YJtoj5verJRDY3QWAS92peYPDKHhwZaMmM0S2KXaKQ0TB+Dfq+4skhWCruh/FBiKcdahPdx3NnYgWlti8AeyfMEcOR5A68Cm+X/cKgpzZuDXq5vymS8kTl98OkS0TqqHlXwv+9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609334; c=relaxed/simple;
	bh=cPUzIeQWltcnBLaFJGE0p46k/zl1NygGhUIJVgB9gp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLbgmMvAypIQUnd355MdPjAHHcclqbMFILM1tbo/6aEmE9IapU6R65GfNI9IaQMpBYz/KRJ2AuIFGBMj2J1bXNOePmhW00UY3BYNvwK9g8BZ3dhi2+CzLCY7EWIIiDHkgLhF7Q6aNJh+np1LFNF3Bg9OK9MRMxvDV/D18SdXkBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVLYaacQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVLYaacQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5721F000E9;
	Thu,  9 Jul 2026 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609333;
	bh=Zug130bXTobM5HlKZPI3NCDDmvJeUsF8foBFBGGU2jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVLYaacQ8KLNeu5YPNdX/cbb0y8NBrsNHFHRm+qZe2q5g5vM/oDrNLKj+mYK2BPuu
	 c0Mwa3fWTHnTfx56PESRwmR+VmjZEMc9p+qJOLmO3jNixGol1/PR3QXxFVyrDfUHm3
	 oiSqnxxao0ulSPM+pFIPq3hwkejLoLH5C/8LKVlh4ytEAULmmG76DFq2HIT0odYhV5
	 jhLOYHMydFFpccXPqj4UzC1g4g2o/oZKrQ6TM8dGRtU29fXzYrtjGhOReD92f6GQe9
	 jFtejwgcuLXvpeMW8YJmOmKUrgQXsp3twFlOq/GbVSqzNDbO1ta0meZ7Mc2T288dl3
	 I6BGQALlOoKcw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 14/19] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Thu,  9 Jul 2026 08:02:03 -0700
Message-ID: <20260709150204.97055-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709144901.96D8C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:49:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing validation for `apply_probes` callback when probe weights are configured leads to complete DAMON region collapse.
> --
> 
> --- Patch [14]: [RFC PATCH v1.2 14/19] mm/damon/core: get merge threshold from probe hits when weights are set ---
> commit a4d0e22d5d4d741ec6086d8f49fefbab2c3b57bd
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: get merge threshold from probe hits when weights are set
> 
> When probe weights are set, DAMON merges regions based on their probe
> hits weighted sum.  But the merge threshold is calculated based on the
> access frequency.  Update it to retrieve the maximum probe hits weighted
> sum in the snapshot from apply_probes() ops callback, and generate the
> threshold based on it.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 8837b2129baa6..12c66edecd783 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
> >  
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_merge_score = ctx->ops.check_accesses(ctx);
> > -		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx, access_check_disabled,
> > -					false);
> > +		if (ctx->ops.apply_probes) {
> > +			if (time_after_eq(ctx->passed_sample_intervals,
> > +						next_aggregation_sis) &&
> > +					access_check_disabled)
> > +				get_max_wsum = true;
> > +			else
> > +				get_max_wsum = false;
> > +			max_wsum = ctx->ops.apply_probes(ctx,
> > +					access_check_disabled, get_max_wsum);
> > +			if (get_max_wsum)
> > +				max_merge_score = max_wsum;
> > +		}
> 
> [Severity: High]
> If a configuration has probe weights enabled (so access_check_disabled is
> true) but the active operations do not implement the apply_probes callback
> (like vaddr or fvaddr), does max_merge_score remain 0 here?
> 
> It appears that skipping both check_accesses() and apply_probes() leaves
> max_merge_score at 0. Later, when kdamond_merge_regions() is called with a
> threshold of 0, and all regions have 0 probe hits, damon_merge_regions_of()
> would see a difference of 0 between adjacent regions.
> 
> Could this lead to aggressive merging of all regions up to sz_limit,
> effectively collapsing the fine-grained region layout?
> 
> Should there be a validation check in damon_valid_probe_params() to reject
> configurations where probe weights are set but ctx->ops.apply_probes is
> missing?

No, this is an intentional design.  The user should correctly config DAMON.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=14


Thanks,
SJ
