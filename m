Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12672F7EFF
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287506; cv=none; b=EeBS2mLh6HxOZKbF4cRWEFp4ctSLKN39PeR4eSEkURa5ykzwDQlfELRLVkue6zV55H+pU//7okqfE16aDci5OwpX5Y1r5BNuaYwXErA9Jvq8HHUhBygO1iwrgD1zIt1exHfUk3uqrP2y8RftXygZvksADLYi3dv1vm0Pmct/CNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287506; c=relaxed/simple;
	bh=D+G7pw3qewbWnFi4/EOcNisMEmFeJc2d6Y4YgDDkmh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnpxpZa4bwGLOclh2h/NnWQq2dIhvgXiH+C1PEpCuqvq6K5TDDvOv8MSOSjvKTa58t42HUWeYrbNf/+3IEybm+uzRcx7X/+MGe0lcmCyoMLz8ws7RD2j10uWlYP7mw/AIRJaO3AOlJmb9k8/9J36j6kzi4Dmw8WfjG3rZJtoIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3Po9rC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3Po9rC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6507E1F000E9;
	Sun,  5 Jul 2026 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783287504;
	bh=Iw8qNGT9Q0aDHkvVpA95HkjA77dF5uiA5DQLT6ylDkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3Po9rC7XvEvcXnUiNHbDIEBSG/72opuLEgao0CiSvIga+TiEDIjkWg8Z99yKZ8oc
	 oHDfUsoNPa2u9VAta3IpueNEIZZxr2n4/aSCDQ5lzYnaHjUommALuHB6wtIR5h6CnM
	 xrfVyk9wp0jkrwpTfFSy8lNjdLuNzTdcUZ+SfnLGmArMBnrBpaUABF8ZJOuTQfIEPE
	 IUjC+dkiRi9gjJwpgSbmd4tre/FxMz6P/wZhcGCU3zGMmtD8/vTEqR0YAlQCR8gDyv
	 rTq23e7wF8uhTOmEkT1VcQxHpn1AY0YTigin0JkDbWkHxRam3rMOk7yCgirNEJVkJT
	 S6Dya60l63Wfg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 07/16] mm/damon/core: extend merge function to work with probe hits
Date: Sun,  5 Jul 2026 14:38:16 -0700
Message-ID: <20260705213817.100841-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705211101.F2F061F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:11:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Incompatible scale and domain mismatch between weighted scores and unweighted merge thresholds.
> - [High] Unsafe use of `abs()` macro on large unsigned integer score differences causes silent signed integer overflow.
> - [Medium] Calculating the weighted sum of probe hits in `damon_probe_hits_wsum` can easily overflow a 32-bit `unsigned int`.
> 
> Pre-existing issues:
> - [High] Weighted average calculations in `damon_merge_two_regions` silently overflow 32-bit `unsigned long` on 32-bit architectures.
> --
> 
> commit 54d6e0bb9900e63a1a016ffee9632b6aa602175b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: extend merge function to work with probe hits
> 
> This commit extends damon_merge_regions_of() to consider the weighted sum
> of probe hits when calculating regions to merge, introducing
> damon_has_probe_weights() and modifying the scoring logic to use these weights.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c370eaff5795d..f6e03746b170e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3187,6 +3192,16 @@ static void damon_merge_two_regions(struct damon_target *t,
> >  	damon_destroy_region(r, t);
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can the weighted average
> calculations in damon_merge_two_regions() silently overflow a 32-bit
> unsigned long on 32-bit architectures?
> 
> On 32-bit architectures, sz_l is a 32-bit unsigned long.
> 
> If the region size is large (e.g., hundreds of megabytes), multiplying sz_l
> by nr_accesses or probe_hits could exceed the 4.29B maximum of a 32-bit
> integer, corrupting the merged region's statistics.
> 
> mm/damon/core.c:damon_merge_two_regions() {
> ...
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
> ...
> 	for (i = 0; i < DAMON_MAX_PROBES; i++)
> 		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
> 				* sz_r) / (sz_l + sz_r);
> ...
> }

This doesn't cause a critical consequenes like kernel crash.  Knnown low
priority issue.

> 
> > +static unsigned int damon_merge_score(struct damon_region *r, bool last,
> > +		struct damon_ctx *ctx, bool use_probe_hits)
> > +{
> > +	if (use_probe_hits)
> > +		return damon_probe_hits_wsum(r, last, ctx);
> 
> [Severity: Medium]
> Can the multiplication in damon_probe_hits_wsum() overflow a 32-bit
> unsigned int?
> 
> probe->weight is an unsigned int.
> 
> If users supply a large weight, multiplying it by r->probe_hits[i] (which can
> be up to 255) might exceed UINT_MAX, causing the sum to wrap around and yield
> artificially small scores for highly active regions.
> 
> mm/damon/core.c:damon_probe_hits_wsum() {
> ...
> 		if (last)
> 			sum += r->last_probe_hits[i++] * probe->weight;
> 		else
> 			sum += r->probe_hits[i++] * probe->weight;
> ...
> }

No critical consequence like kernel crash.  Known low priority issue.

> 
> > +	if (last)
> > +		return r->last_nr_accesses;
> > +	return r->nr_accesses;
> > +}
> > +
> >  /*
> >   * Merge adjacent regions having similar access frequencies
> >   *
> > @@ -3195,24 +3210,37 @@ static void damon_merge_two_regions(struct damon_target *t,
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
> > -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> > +		unsigned int score, last_score;
> > +
> > +		score = damon_merge_score(r, false, ctx, use_probe_hits);
> > +		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
> > +
> > +		if (abs(score - last_score) > thres)
> 
> [Severity: High]
> Does the use of abs() here cause a silent signed integer overflow for large
> unsigned differences?
> 
> The macro abs() implicitly casts an unsigned int to a signed int.
> 
> If the mathematical difference between score and last_score exceeds INT_MAX
> (which might happen with large user-defined probe weights), the cast wraps to
> a negative number.
> 
> The abs() macro then negates it into an artificially small positive integer,
> which could cause the code to incorrectly bypass the > thres check and merge
> regions with vastly different access profiles.

Pre-existing issue.  I will fix this separately.

> 
> [Severity: High]
> Is there a domain mismatch between the weighted score differences and the
> unweighted thres parameter?
> 
> When use_probe_hits is true, the score is a weighted sum derived from probe
> hits and user-defined weights. However, thres operates in the unweighted access
> frequency domain.
> 
> This mismatch appears to carry over to kdamond_merge_regions(), where max_thres
> is also scaled in the unweighted domain (aggr_interval / sample_interval).
> 
> Because weighted scores operate in a different numerical domain, could they
> easily exceed max_thres, forcing the merge loop in kdamond_merge_regions() to
> terminate prematurely?
> 
> mm/damon/core.c:kdamond_merge_regions() {
> ...
> 	max_thres = c->attrs.aggr_interval /
> 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> 	do {
> ...
> 		threshold = max(1, threshold * 2);
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> ...
> }

Yes, and that will be fixed by the later commit of this series.

> 
> >  			r->age = 0;
> > -		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> > +		else if ((score == 0) != (last_score == 0))
> >  			r->age = 0;
> >  		else
> >  			r->age++;
> >  
> > -		if (prev && prev->ar.end == r->ar.start &&
> > -		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
> > -		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
> > -			damon_merge_two_regions(t, prev, r);
> > -		else
> > -			prev = r;
> > +		if (!prev)
> > +			goto set_prev_continue;
> > +		if (prev->ar.end != r->ar.start)
> > +			goto set_prev_continue;
> > +		if (abs(damon_merge_score(prev, false, ctx, use_probe_hits) -
> > +					score) > thres)
> 
> [Severity: High]
> Does this abs() usage also suffer from the same silent signed integer overflow
> as mentioned above when comparing large unsigned score differences?

Pre-existing issue.  I will separately work on this.

> 
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
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=7


Thanks,
SJ
