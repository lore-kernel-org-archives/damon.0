Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07152387588
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608874; cv=none; b=LQT3+1daezhpRoOxDz932wAdcodtZ59d4442ElCOXiDtS5a9LMQxEejeZb5IAX7C7aMt/EakgML4bc31o/8wxCVQLhzRj+qU6mPIWJuYnSwjOYB//5bDiKWExEeovDyCx37hsFBPkCujBkvYJ0FXiJ65rD/2Ph+K4WVCQZBOre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608874; c=relaxed/simple;
	bh=1BvtdUc0F6kUV2rCN5AYhOIMgb8CUQ0DEzJj7BQALC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSPjeig5GTDO2ywGWcaInw5PblQk9CYSwSBBHuvd+290DxySI8hP6Nv93Dz5t88AyPl5Y7IcW8WN3YaaYcnURNe5eiinGs3GNX6giD3nZl13cMxV2k73bFt+uzP0JC/kZ1yvrnQv/b/IeyZlXdAOjGFfCSU+J1McntFwkzEN+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leKn+eub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leKn+eub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045D71F000E9;
	Thu,  9 Jul 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608872;
	bh=2hZAFqECFOXR/m3JatuLv55wkCtJhn5zQA2d08cZW3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=leKn+eub/F6zZhilcoIx4V6x5ZDYn2ai54iIRVhDg81Fbwha3GX04X2JM+/NyKa6A
	 EkScD7iaK3LfDCwOT/Jg+5VEEv/jfa0vmS1LlCHDkD+osrojgS13m363FbuRxhYOi3
	 LkiqGBqpFL6Of4pl7PEMggTRCO/31ORHSpVtAkNOYGxbQEW/DvGMgtco6iiOkFzZhQ
	 AuWjeCxbFwTx/1fhl5KpT7yWy/kP+8erQGqOPUti5r1nwCIiIMe9ykLfiddwPp7M2J
	 mj8t4UQhgGEVqeWCWeBHs65ZT+h7mSNxC3DbgTrCDp9X++qbjXkfckumiEYoqoT7zp
	 CG1MSKcNT+wOw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 07/19] mm/damon/core: use abs_diff() instead of abs()
Date: Thu,  9 Jul 2026 07:54:23 -0700
Message-ID: <20260709145425.96247-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709143210.84EB51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:32:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Potential integer overflow in weighted average calculations within `damon_merge_two_regions()` on 32-bit architectures.
> - [High] Infinite loop in `kdamond_merge_regions()` causing soft lockup when `aggr_interval` is large.
> - [High] Multiple erroneous `r->age` updates per aggregation interval during region merging.
> --
> 
> --- Patch [7]: [RFC PATCH v1.2 07/19] mm/damon/core: use abs_diff() instead of abs() ---
> commit f6ab818d018c3ba8c682c6e198e98ba7a8a69b83
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: use abs_diff() instead of abs()
> 
> Use of abs() in damon_merge_regions_of() could cause a silent integer
> overflow. This patch replaces it with abs_diff().
> 
> Link: https://lore.kernel.org/20260705213817.100841-1-sj@kernel.org/
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index fea97399b5754..4c7e8a12a9b67 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3261,7 +3261,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> >  	struct damon_region *r, *prev = NULL, *next;
> >  
> >  	damon_for_each_region_safe(r, next, t) {
> > -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> > +		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
> >  			r->age = 0;
> >  		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> >  			r->age = 0;
> > @@ -3269,7 +3269,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> >  			r->age++;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this logic apply multiple
> age updates per aggregation interval if damon_merge_regions_of() is called
> multiple times?
> 
> The function damon_merge_regions_of() is called inside a do-while loop in
> kdamond_merge_regions():
> 
> mm/damon/core.c:kdamond_merge_regions() {
> 	...
> 	do {
> 		nr_regions = 0;
> 		damon_for_each_target(t, c) {
> 			damon_merge_regions_of(t, threshold, sz_limit);
> 			nr_regions += damon_nr_regions(t);
> 		}
> 		threshold = max(1, threshold * 2);
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> 	...
> }
> 
> Since last_nr_accesses isn't updated until after this loop completes, if
> merging fails to reduce nr_regions sufficiently, the loop repeats. Could this
> cause the same access counts to be evaluated repeatedly, artificially aging or
> resetting memory multiple times within a single aggregation interval?

Sounds making sense.  Apparently not fit to be fixed in this series, though.  I
will further check and separately work on this.

> 
> [Severity: High]
> This is a pre-existing issue, but can the loop in kdamond_merge_regions() run
> infinitely if max_thres is extremely large?
> 
> Looking at the same snippet above, max_thres is an unsigned int calculated
> from aggr_interval. If max_thres is >= 2,147,483,648 (for example, due to a
> large aggr_interval), doubling threshold will eventually overflow a 32-bit
> unsigned int to 0.
> 
> Then max(1, 0) resets it to 1. Since threshold / 2 (which is 0) will always
> be less than max_thres, could this cause a soft lockup of the kdamond thread?
> 
> >  
> >  		if (prev && prev->ar.end == r->ar.start &&
> > -		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
> > +		    abs_diff(prev->nr_accesses, r->nr_accesses) <= thres &&
> >  		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
> >  			damon_merge_two_regions(t, prev, r);

Seems a good finding.  Not related to this series, as  Sashiko also says.  I
will further check separatelt work on this.

> 
> [Severity: High]
> This is a pre-existing issue, but can the size-weighted average calculations
> in damon_merge_two_regions() overflow on 32-bit architectures?
> 
> mm/damon/core.c:damon_merge_two_regions() {
> 	...
> 	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
> 
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
> 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
> 	...
> }
> 
> If sz_l is large (e.g., 100 MB or ~104,857,600 bytes) and nr_accesses or age
> is moderate (e.g., 50), their product (~5.24 billion) exceeds the maximum
> 32-bit unsigned integer value (~4.29 billion).
> 
> Since unsigned long is 32 bits on those systems, could this silently overflow
> and irreversibly corrupt the merged region's statistics?

Known low priority issue.

> 
> >  		else
> >  			prev = r;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=7


Thanks,
SJ
