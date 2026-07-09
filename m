Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06A384CE1
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608981; cv=none; b=etexoiRlX+wt/asfCOdvYgU4NPa01cijHGEPRjRmFBiAK7pWAgY034kaoijbvvBpfoQV/EyKXqJOOfyePmkmoD01xQAdIzdAZRGVWbdk/hcfd9ucgZHJRWti2jB+7Sg65zGBS0Ql2d3ih2Tijm+0CNigNL+DdGxLLZL0/t2MDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608981; c=relaxed/simple;
	bh=5ErhQwzw7vp1Bs9aEU2DXOpTH+SON51TQPO5qx3qwgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UC+DKZn/YWY/k16OnV/wPMuPUpev9XyWGD6kBDOZNEqJoiarIcqQKMJml5YWUhKDCdnMx6mXOt0dEOW2fKDFDIMzFeg0Gdq4haaGfGaFjxrVLwRz6lsxkN1iV+DGole5IqEMm8neiSXex/Z6qFaKsFyJO0nDUGJOQUMgRObunv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkfB+nWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkfB+nWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3BC1F000E9;
	Thu,  9 Jul 2026 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608980;
	bh=B2/vdk2fbWk0S1XmDNeBAfaMMX3wnBNoPle/pF2ptVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkfB+nWqvNWGcAowdZbEzUGlsUoyL9r4No24CjstzATIANTVIaH1B4iOOHSJ2JPV5
	 Z2+g9KlnyByIkHmlQqsU0yD0avxaOJvUdqVm3rori//M/XSggmN9l+GVA4KK/CGXRS
	 /Tw2saP8ZhuGYRDkOsIFzMXmC5gv8+9MtslFt7vEyQLlvn4Lc84TiKf482o1M0/Yjg
	 yNV9O0rRS+wnUi4dATrPfINy/GCHJBOk8lZId5rgHMC7SUDZeBYlUcLLuumOy4UifA
	 wS4hSXyLKn3YBU4iBXKhABcZ5YBNug+Sg9MBGk4nOZnGY5a8+iPNKzIyXAN1OFGxyF
	 lm089ZdPBYpuw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 08/19] mm/damon/core: extend merge function to work with probe hits
Date: Thu,  9 Jul 2026 07:56:11 -0700
Message-ID: <20260709145612.96391-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709143216.39DF61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:32:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Region `age` is incorrectly updated multiple times per aggregation interval and evaluated against a stale `last_score` when the `kdamond_merge_regions` retry loop is triggered.
> --
> 
> --- Patch [8]: [RFC PATCH v1.2 08/19] mm/damon/core: extend merge function to work with probe hits ---
> commit 938ea22fc6c1fec3c909339503398aa70ea047c8
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: extend merge function to work with probe hits
> 
> When probe weights are set, users may want DAMON monitoring results to
> be optimized for the weights.  For that, regions adjustment should work
> for the weighted sum of probe hits.  Extend damon_merge_regions_of() to
> detect if the weights are set, and work with probe hits in the case.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3256,24 +3271,38 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> > -				   unsigned long sz_limit)
> > +		unsigned long sz_limit, struct damon_ctx *ctx)
> >  {
> >  	struct damon_region *r, *prev = NULL, *next;
> > +	bool use_probe_hits = damon_has_probe_weights(ctx);
> >  
> >  	damon_for_each_region_safe(r, next, t) {
> > -		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
> > +		unsigned int score, last_score, diff;
> > +
> > +		score = damon_merge_score(r, false, ctx, use_probe_hits);
> > +		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
> > +
> > +		if (abs_diff(score, last_score) > thres)
> >  			r->age = 0;
> > -		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> > +		else if ((score == 0) != (last_score == 0))
> >  			r->age = 0;
> >  		else
> >  			r->age++;
> 
> [Severity: High]
> This is a pre-existing issue, but does this logic in damon_merge_regions_of()
> incorrectly increment or reset r->age multiple times per aggregation interval?
> 
> When the number of regions exceeds max_nr_regions, kdamond_merge_regions() 
> repeatedly calls damon_merge_regions_of() with doubled thresholds. During 
> these retries, r->age is incremented multiple times within a single 
> aggregation interval.
> 
> Furthermore, because damon_merge_two_regions() updates the current 
> nr_accesses and probe_hits but fails to merge their historical counterparts 
> (last_nr_accesses and last_probe_hits), these values become stale.
> 
> On subsequent iterations of the retry loop, damon_merge_score() computes 
> last_score using these stale unmerged values. This can cause 
> abs_diff(score, last_score) to spuriously exceed the threshold, resetting 
> r->age to 0 inappropriately.
> 
> Could this cause DAMOS age-based schemes to trigger prematurely or fail to 
> trigger entirely?

I already promised to separately work on this.

> 
> > -		if (prev && prev->ar.end == r->ar.start &&
> > -		    abs_diff(prev->nr_accesses, r->nr_accesses) <= thres &&
> > -		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
> > -			damon_merge_two_regions(t, prev, r);
> > -		else
> > -			prev = r;
> > +		if (!prev)
> > +			goto set_prev_continue;
> > +		if (prev->ar.end != r->ar.start)
> > +			goto set_prev_continue;
> > +		diff = abs_diff(score, damon_merge_score(prev, false, ctx,
> > +					use_probe_hits));
> > +		if (diff > thres)
> > +			goto set_prev_continue;
> > +		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
> > +			goto set_prev_continue;
> > +		damon_merge_two_regions(t, prev, r);
> > +		continue;
> > +set_prev_continue:
> > +		prev = r;
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=8


Thanks,
SJ
