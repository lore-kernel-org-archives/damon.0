Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85B2556E
	for <damon@lists.linux.dev>; Sat, 16 May 2026 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892405; cv=none; b=gXfCF2uqfWZCkFnSPV41cwMkEDYGxwGipHFq5WhwitwfAVBmJgk5eHIxyBrzX9wtoVtx03uZkcOU89DX13+GS8UpWp+LEQwI85nvUxHuPb1+FDIJZ6rRYWoBv5vB+zWWqtAeALDtknbecjY7rY1vmGmCKaslkGjOrqr37pclLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892405; c=relaxed/simple;
	bh=hchLybwpI52hC+4QyFARqZnBDHCdGjUKNEJdAnwUcq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7YD4h5bD8Fj3ci6CiXESlrdy8FFXRINclImnJKmfIikHLyQjQ/Y64LupId2WzyjdixZZVE8wb9BTAiZi0zPElB4BqBpGA/K2CaYq6DMYiXJV4EYHwi6ihZXxNsmsI6+GnIVQlex4ifXZY86n9xEjr7eMEX+Kws/yzy27tDEqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8X5G1MT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8X5G1MT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD3AC2BCB7;
	Sat, 16 May 2026 00:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778892405;
	bh=hchLybwpI52hC+4QyFARqZnBDHCdGjUKNEJdAnwUcq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8X5G1MTBpEKCHaG3IboQ70ANc+DQSSxBYP9QbhxKyfBA+GwlqDHleN5xpCxDkpDd
	 mDQJS15pnl9l/AYdRUi+32N/62aQqfiPq2Vyx2T6fUM2iqyeKx0pR1IVBTi6urx7IF
	 hyREspNga/2VY2GIhyhX47dLkJBKI2XmWupxt95hNQ71v/8+9UFy+pH+Wnaxy9ypbK
	 iKS6jcjFS5gaBrHNS+mrk+GmPs1ot/SXbVZfE8Dg9n1yPOqKIkg5RKIXIq9+WdrSAe
	 a2Rcru3FWyqPx+0Cl78aV6EIEcxDl/qb7+slpMPA9DQnIRTamuPPrzjboduwsd9WUA
	 ZDXF/+WRqBJBg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 07/28] mm/damon/core: do data attributes monitoring
Date: Fri, 15 May 2026 17:46:29 -0700
Message-ID: <20260516004630.142039-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515010501.3ECFAC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:05:00 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `probe_hits` statistics are dropped or corrupted when DAMON regions are merged or split.
> - [Medium] The `probe_hits` array is defined as `unsigned char` and is susceptible to integer overflow.
> --
> 
> commit b280c3cfd980db677209be247ad602d23aa561f9
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do data attributes monitoring
> 
> Implement the data attributes monitoring execution.  Update kdamond to
> invoke the probes application callback, and reset the aggregated number
> of per-region per-probe positive samples for every aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f6b4beb4b8ecd..1c9d2fb69f98d 100644
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
> Is it possible for the probe_hits array values to wrap around?
> 
> The probe_hits array is defined as unsigned char in struct damon_region. It
> holds the count of positive probe hits over an aggregation interval, and gets
> incremented every sample interval.
> 
> Since the maximum number of samples per aggregation is dictated by
> attrs.aggr_interval / attrs.sample_interval, and this is fully configurable by
> users, what happens if the number of samples per aggregation exceeds 255?
> 
> Could the unsigned char array elements overflow and wrap around, yielding
> truncated hit counts for high-frequency sampling configurations?

Yes, but no problem as I previously replied [1] to the same question.
> 
> [ ... ]
> 
> > @@ -3172,6 +3176,8 @@ static int kdamond_fn(void *data)
> >  
> >  		if (ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> > +		if (ctx->ops.apply_probes)
> > +			ctx->ops.apply_probes(ctx);
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> Does this miss updating probe_hits when regions are merged or split?
> 
> Looking at damon_merge_two_regions(), it averages nr_accesses and age when
> merging adjacent regions, but ignores the probe_hits array. This leaves the
> left region's array unmodified and discards the right region's hits.
> 
> Similarly, damon_split_region_at() creates a new sub-region but does not
> appear to copy the probe_hits from the parent, leaving the newly split
> right half initialized to zero.
> 
> Since splitting and merging execute at the end of an aggregation interval,
> will the probe_hits statistics be under-reported or corrupted?

Correct, and I will fix those as I previous replied [1] to the same question.

[1] https://lore.kernel.org/20260516003559.141476-1-sj@kernel.org


Thanks,
SJ

[...]
