Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E1347FC4
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778967223; cv=none; b=nhlMGP4wJOOnKY/+vwCS1JwjboUOAfjjdKxHid9k45YgkATIkA3ty7y/NvSqagRVYqsU6efvHWU2XNKCU4uPL2aZMIamJ59OSbZnIDHWA4zdn0vjGcMDqnL8m9cZg5kNt6t3JfIaAE9wYaR4brEZfKfHMzcscWNd8el6BFQkh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778967223; c=relaxed/simple;
	bh=pD5He9C2mKKqb/QX0WFzqPTfdXtrKaoSi5bBs4Odj7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9eB0lFfikWrAqUmWpvgwtUtlLrtX0rIHJDrvLaI8pwiWngg1GIuLqv+miLKS0irl1LX1/Fwl2h2GGO7PXcnS/vK2rheeLb/+eX3DuW8jeT1b7puCnkjT4MrNVgOzfe0XL5DsrR9rdLMMponcunrqf23yzjQZr6TwUiJ3ag7hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta801Qlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta801Qlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C41C19425;
	Sat, 16 May 2026 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778967223;
	bh=pD5He9C2mKKqb/QX0WFzqPTfdXtrKaoSi5bBs4Odj7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ta801QlhB6U/r4vI2Oi7Mbt3oe9PCSAiM9EaMj0fAQ45GRdx/EfxzEzrAqCW9RVLg
	 twiOHaN3J3Wt0zqR+UkPui+8lzz5mpYEc6Ug6rKVRFWc0LiUPPLNSkPp6N/4QBACRa
	 hM+QILa12SghFLYRVdV6AvLxXgHH3zO6TJECSS0zJRSd0KKOTVaKqLXmb2fx1iFhEK
	 MWkP1RYF/JQ9FdSurQQ6NjIiR23qypIeq3jHPoE/aMWsmI3qxTJvMlNr8rCRPn/Hd9
	 +FsWBl6Yh7soj8J2biXpHDmhc/zDQBJ3s8t2XSTWtkxwzxltNXWlkhnE1s8QWQlo0v
	 LcS4i1ebWXSXw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 07/28] mm/damon/core: do data attributes monitoring
Date: Sat, 16 May 2026 14:33:27 -0700
Message-ID: <20260516213329.3083-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516190011.77604C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 19:00:10 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] The `probe_hits` array counters can silently overflow, yielding corrupted monitoring results.
> - [High] DAMON dynamically merges regions based strictly on `nr_accesses`, which corrupts the spatial granularity of `probe_hits`.
> - [High] If DAMON is run without `check_accesses`, all regions will be aggressively merged up to `sz_limit`, neutralizing data attribute monitoring.
> - [High] Size-weighted average calculations for `probe_hits` overflow `unsigned long` on 32-bit systems.
> --
> 
> commit 55dcc5294b4ee96c9d7e5a24e9dcdb0d798c401d
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do data attributes monitoring
> 
> Implement the data attributes monitoring execution.  Update kdamond to
> invoke the probes application callback, and reset the aggregated number
> of per-region per-probe positive samples for every aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e5667660b4cd9..dde3c8d8fef89 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1886,10 +1886,14 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
> >  		struct damon_region *r;
> >  
> >  		damon_for_each_region(r, t) {
> > +			int i;
> > +
> >  			trace_damon_aggregated(ti, r, damon_nr_regions(t));
> >  			damon_warn_fix_nr_accesses_corruption(r);
> >  			r->last_nr_accesses = r->nr_accesses;
> >  			r->nr_accesses = 0;
> > +			for (i = 0; i < DAMON_MAX_PROBES; i++)
> > +				r->probe_hits[i] = 0;
> 
> Can probe_hits overflow here?
> 
> The probe_hits array is defined as unsigned char, which has a maximum value
> of 255.
> 
> The number of samples per interval is user-configurable and can legitimately
> exceed 255 (e.g., a 1000ms aggregation with a 1ms sample interval yields 1000
> samples).
> 
> If a probe matches continuously under such configurations, could the counter
> silently overflow and wrap around, corrupting the monitoring results?

No blocker, as I previously explained [1].

> 
> >  			damon_verify_reset_aggregated(r, c);
> >  		}
> >  		ti++;
> > @@ -3179,6 +3183,8 @@ static int kdamond_fn(void *data)
> >  
> >  		if (ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> > +		if (ctx->ops.apply_probes)
> > +			ctx->ops.apply_probes(ctx);
> 
> If DAMON is configured strictly for data attribute monitoring where
> check_accesses is NULL but apply_probes is set, max_nr_accesses and all
> regional nr_accesses persistently evaluate to 0.
> 
> Will this cause all adjacent regions to have a calculated difference
> threshold of 0, resulting in all regions merging indiscriminately up to
> sz_limit during the subsequent kdamond_merge_regions() call?
> 
> Additionally, damon_merge_regions_of() merges adjacent regions by evaluating
> only nr_accesses:
> 
> abs(prev->nr_accesses - r->nr_accesses) <= thres
> 
> Since this merge condition ignores probe_hits, could two contiguous regions
> with identical access frequencies but vastly different data attributes be
> incorrectly merged?

Correct, and that's the intended behavior.  Data attributes are just additional
information.  Data access pattern, specifically nr_accesses, is the primary
information that drives region splits and merges.  I'm planning to let users
set the primary information in future, though.

> 
> Does calculating the size-weighted average for probe_hits risk overflowing on
> 32-bit systems?
> 
> When damon_merge_two_regions() calculates averages using:
> 
> (metric * sz_l + metric * sz_r) / (sz_l + sz_r)
> 
> Both sz_l and sz_r are evaluated in bytes as unsigned long. On 32-bit
> systems where ULONG_MAX is roughly 4 GB, a 200 MB region with 25 probe_hits
> yields an intermediate product of 5,000,000,000.
> 
> Does this silently overflow the 32-bit unsigned long and corrupt the region
> metrics?

I previously answered [1] this.  32-bit arch users could use addr_unit to avoid
this issue.

> 
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516183712.81393-1-sj@kernel.org?part=7

[1] https://lore.kernel.org/20260516003559.141476-1-sj@kernel.org


Thanks,
SJ
