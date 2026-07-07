Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC33C2E
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382618; cv=none; b=eURtt+2Zj0toGUKz064Ab8trjltuXwV6ib09v0AMxznHWAOCFaEWObLlTSfev4wuDrIw+NcVsODuxObmRU97gSK6RRU+vue22Q5WltP6Wqhgdhc9LvAPP9hbmN5KIoGxEAZyd69ktF2FnwyIiuFmDf69jCIQHaYNZQk+XNmqT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382618; c=relaxed/simple;
	bh=8ekxJehryUl5ZUac+qU0P5MEZQEjx5Ku+yxBWKwv8wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGdNm99bYihcj5YukKDHdOktsYAWKpwUv2LUk1BktoZqIJAfFPngVJLe9WpYVOnVHAgwSGQJIa6sqaGQf/1YIAk7EVIwfarI2Ty/C1RyCJHAeL3+MfqFv+z6UetJbAb/CZogbIoDJzV9vrU6wGTTSZmx/V0Xw3VE/OBXjxtepQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC9pjE/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC9pjE/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2A91F000E9;
	Tue,  7 Jul 2026 00:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382617;
	bh=RaOE3qqGJDfP+OdODQJuy9chYhb4AEe/GQFQ4E9WbkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dC9pjE/b8z+E1rNWU/9QiOwHBBTGkn9LuHCWN6jnHCO9VzlGAZd0IBV3LakG6sEl2
	 ePJ7f60A+GMzd1Z3OAGnA/3mi/5RKyo18MmqShtrarTsmBuGdXw4ACfFeZ7h6B2JCl
	 xvFknp94LPZ1S7cvixAevj/myirpFlMMHwZ+FUEnY6OgvrM+ev/UwRBajBR8pH6oB8
	 qB2CQ8HPA4Mu9OAqpsVk6MQpZ2I8N1ivTER9a+hU/zyEfl1pM/FEwsbXKdtALxr0S6
	 92LGT/IxZpSx5u7uZjFZ2uUAq0m6grcmUs2ut3+CuJP9WOeJPSQsCkHhbvHKBY3GJ8
	 lW6hgA/WfTyJQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 11/16] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Mon,  6 Jul 2026 17:03:28 -0700
Message-ID: <20260707000330.97519-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706151802.28AF71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 15:18:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Region merge loop terminates prematurely because `max_thres` is unscaled for probe hit weighted sums, causing a failure to respect `max_nr_regions`.
> - [High] Adding probe weights to contexts using operations without `apply_probes` (e.g., `vaddr`) silently breaks all monitoring.
> --
> 
> commit f896f3e81bf75b446b16cb4f79f6673a154b512b
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
> > index be026c86384e4..fa78d8d592aa3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3726,9 +3727,18 @@ static int kdamond_fn(void *data)
> >  
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_merge_score = ctx->ops.check_accesses(ctx);
> 
> [Severity: High]
> Does setting probe weights on a context that lacks an apply_probes callback
> (like vaddr) silently break monitoring here?
> 
> If a user sets probe weights via sysfs, access_check_disabled will be true.
> This skips check_accesses(), but since apply_probes is NULL, neither callback
> runs. The accesses are never updated, and all memory appears completely cold.

I was initially thinking this is no blocker.  But, since the core layer params
validation patch series is merged into mm-new, fixing this should be simple,
and we don't really need to rush for this series.  I will fix this in the next
spin.


> 
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
> 
> [Severity: High]
> Can this cause kdamond_merge_regions() to fail to reduce the number of
> regions below max_nr_regions?
> 
> When kdamond_fn() later passes this max_wsum / 10 as the initial threshold
> to kdamond_merge_regions(), the merge loop termination condition compares
> it against an unscaled max_thres:
> 
> mm/damon/core.c:kdamond_merge_regions() {
> 	...
> 	max_thres = c->attrs.aggr_interval /
> 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> 	...
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> }
> 
> Since a user-defined weighted sum can be vastly larger than the unweighted
> max_thres, will the loop condition fail prematurely, leading to an
> unbounded growth of memory regions?

Yes, but only for one aggregation interval.  I don't think that's an issue.

> 
> > +		}
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=11


Thanks,
SJ

[...]
