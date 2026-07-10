Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A76430CF0
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694989; cv=none; b=oHkab09UWIHbIWioGMHNpm61Rm9W1kUZHoVp2w6fmgNJH59chn/I4FqS8jmxwVYNzQV1Lz2pWQLghs0TOSnZTUSWCAvHkTSDPzABDHFxJJCgUCOdDRChsW0E4ElHrf0vlGEYKeCDjIRttCAjhqrD8KBRHYy7JLEuWRpe6ubtAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694989; c=relaxed/simple;
	bh=1lC56BQ7vxCaPilSjiY15slyI53eAWJYtaTdNZc1voU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rs6ajIJRGUx+6otmaL7etPAJn9fne/4OiWwxYE8k214BnR0//dhR11o9FPL5CX5xZCfZxYPODm3DbYcem7NKHeTHaYaffskAps52YZ3HpV+kXcb14oP8x4V6SePTst4LzQVEZtEYkp4i7t0H45hjSWq+eZhHzMtNnOM45OV6B0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGMxx1ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGMxx1ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497BB1F000E9;
	Fri, 10 Jul 2026 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694981;
	bh=+v4cD8CebAFwtan+IFPJcPhzSzv9MNC1h0Y5xwO0Iqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fGMxx1ip8buIa68HmhjWfFszt60CrNpf5ACbxIgHL4OGeZiFvM/UabH12P2r76gAH
	 WMaQJS3EGcFKuzBICaCBFFamRah1vt0GXyofgpc+V8bW8bTjyvfOMaCR1goygSR1yg
	 xDfQZSEB7pbKOFKi2TL+eAFEiT4gNxf2rzkuDNM8USjUU+qwRkm47T2xO7sKn6reWE
	 hijJ7Tf8rUgGSMit3fxp0MqTLNfwN0KSABVmV61tbtmGluelPNrQwLLs2BIvCPnp2K
	 Y6d+5xzLpPGYYHQF/R/MF0P2inYzDlyZevmID4U+ADm5MkCp7r5FkjLmJPserucSi5
	 GY86U5vJy/RBA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 08/19] mm/damon/core: extend merge function to work with probe hits
Date: Fri, 10 Jul 2026 07:49:36 -0700
Message-ID: <20260710144937.26981-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710140532.2A38F1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:05:31 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Unscaled merge threshold breaks region merging when using weighted probe hits.
> - [Medium] Potential 32-bit integer overflow in `damon_probe_hits_wsum()` when accumulating weighted sums.
> 
> Pre-existing issues:
> - [High] Region ages are evaluated and mutated inside a retry loop, leading to age corruption.
> - [High] Calculations for merged regions' weighted averages overflow on 32-bit architectures.
> - [Medium] Test NULL pointer dereference in `damon_test_merge_regions_of`.
> --
> 
> --- Patch [8]: [PATCH 08/19] mm/damon/core: extend merge function to work with probe hits ---
> commit 5e9a094bb8d36feea59f27615cb45bcbce00e4c3
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
> > index 4c7e8a12a9b67..7d49420ea26c4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3248,6 +3253,16 @@ static void damon_merge_two_regions(struct damon_target *t,
> [Severity: High]
> This is a pre-existing issue, but can the calculations for merged regions'
> weighted averages overflow on 32-bit architectures?
> 
> mm/damon/core.c:damon_merge_two_regions() {
>     unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
>     ...
>     l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>                      (sz_l + sz_r);
>     l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
>     ...
> }
> 
> Since sz_l and sz_r are unsigned long (32 bits on 32-bit architectures),
> multiplying them by a 32-bit unsigned int produces a 32-bit intermediate
> product. For large region sizes, this might wrap around UINT_MAX prior to
> division, leading to incorrect page reclaim decisions.

Known low priority issue.  No blocker.

> 
> >  	damon_destroy_region(r, t);
> >  }
> >  
> > +static unsigned int damon_merge_score(struct damon_region *r, bool last,
> > +		struct damon_ctx *ctx, bool use_probe_hits)
> > +{
> > +	if (use_probe_hits)
> > +		return damon_probe_hits_wsum(r, last, ctx);
> [Severity: Medium]
> Can accumulating the weighted sums in damon_probe_hits_wsum() overflow a
> 32-bit integer?
> 
> mm/damon/core.c:damon_probe_hits_wsum() {
>     ...
>     unsigned int sum = 0;
>     ...
>         if (last)
>             sum += r->last_probe_hits[i++] * probe->weight;
>         else
>             sum += r->probe_hits[i++] * probe->weight;
>     ...
> }
> 
> If user space configures a large weight, multiplying it by the probe hits
> across multiple probes might easily exceed UINT_MAX, causing silent
> overflow. This wrapped around value would then corrupt the region merging
> heuristic.

No issue.  Nobody calls this function at the moment.  A later patch in this
series will prevent such user input before this can be really used.

> 
> > +	if (last)
> > +		return r->last_nr_accesses;
> > +	return r->nr_accesses;
> > +}
> > +
> >  /*
> >   * Merge adjacent regions having similar access frequencies
> >   *
> > @@ -3256,24 +3271,38 @@ static void damon_merge_two_regions(struct damon_target *t,
> >   * sz_limit	size upper limit of each region
> >   */
> >  static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
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
> [Severity: Medium]
> When probe weights are enabled and use_probe_hits is true, score and
> last_score are scaled by probe->weight via damon_probe_hits_wsum().
> However, kdamond_merge_regions() calculates the initial threshold using
> unweighted access metrics. Will comparing this unscaled threshold against
> the newly scaled weighted scores prevent region merges and force the retry
> loop to inappropriately scale the threshold?

No issue.  damon_has_probe_weights() always return false.  A later patch in
this series will change that before damon_has_probe_weights() can return true.

> 
> >  			r->age = 0;
> > -		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> > +		else if ((score == 0) != (last_score == 0))
> >  			r->age = 0;
> >  		else
> >  			r->age++;
> [Severity: High]
> This is a pre-existing issue, but does mutating the region age inside this
> retry loop corrupt the age metric?
> 
> In kdamond_merge_regions(), damon_merge_regions_of() is called inside a
> do-while loop that repeats if nr_regions > max_nr_regions. Every time
> damon_merge_regions_of() executes, it unconditionally mutates r->age for
> every region based on the current threshold. Because the outer loop
> doubles the threshold and retries, r->age might be artificially inflated or
> repeatedly reset to 0 multiple times per aggregation interval.

Known issue.  I'm working on this.

> 
> [ ... ]
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index d97280270c27b..6ad73559dd8ea 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
> > @@ -258,6 +266,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
> >  	}
> [Severity: Medium]
> This is a pre-existing issue, but could this test cause a NULL pointer
> dereference and leak test resources?
> 
> If the internal damon_merge_regions_of logic unexpectedly merges too many
> regions, damon_nr_regions(t) might fall below 6. The KUNIT_EXPECT_EQ check
> logs a failure but does not halt the test.
> 
> The subsequent loop executes 6 times regardless:
> 
> mm/damon/tests/core-kunit.h:damon_test_merge_regions_of() {
>     ...
>     for (i = 0; i < 6; i++) {
>         r = __nth_region_of(t, i);
>         KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>     ...
> }
> 
> This would cause __nth_region_of() to return NULL, which is immediately
> dereferenced in the KUNIT_EXPECT_EQ macro without validation.

Good catch.  No blocker, though.  I will separately work on this.

> 
> >  	damon_free_target(t);
> > +	damon_destroy_ctx(ctx);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=8


Thanks,
SJ
