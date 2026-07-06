Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E701F8AC5
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381945; cv=none; b=d/vEBd/nGjbv2jdUhpkNOt/fYYdK0mRNqe2F2PglzYErLG1HBRwd9A7iatWotRBuK9yU+RX/uATHu0mB8VlBMa3t9aaOf3G5jYame1AHP7OA6gnr5oBiCzkVUg+ZXWkJhqZCBE6lRb7v4DClnT+NmGCWAkHCLNS4bzdzA1DhVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381945; c=relaxed/simple;
	bh=Lhcp6jK/Uz1L5DcN0mDB9VTg2AZCkvPDY4b4um5DUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+xFnc/WWPMMYGXWmzvpW5/2+PjKtDzoIb1RDuhEpZOjUcuWcGwtxjnHWlV4HmLKxdX0tkr0eh4dtYjwa+Yb+zRLxf3rHkc5maiZMApX6rx9oS6eW9MSuUmYzHtV/Zzgpq03dpU5Eb4C9CCtzIoIX6tWETCrStZQPszrXQYXLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqApdey4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqApdey4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3784B1F000E9;
	Mon,  6 Jul 2026 23:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381944;
	bh=qsBn+YOGXH2d1o/G3Bl3NtZcTPbeAzx5cLVY/2E4YZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqApdey4TQ3KuOR0I7WpuZnfVMFsLEhzyFO0CI1B72VhxuaqeVj2e04bHpgR51q1F
	 z6/M/xUefmLc/1UPsHTCexrVULOjRhOLHOuQoY7njb341FFE66GrqRHeZtj7ATqJN6
	 ZlyWyZ1abykYMGXPJtUwHBZJc/eT9F4eXOJI27nRkcUaoIsM7ikjYEaRwrqidlwLey
	 yRpk9Dgk+o2fSC0+Hf7SDwiHbAb+qRRklmFOooJ2ILW1KjhRlbD6JHNtr9CcOxiXIk
	 C8JaQcs/UalEz3YjMMLsAL58/xDp4wyT+W4oiF7UOePeh7GcTH6EdBZoy/ybN7nVHx
	 nSVHc2WF5czQQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 07/16] mm/damon/core: extend merge function to work with probe hits
Date: Mon,  6 Jul 2026 16:52:00 -0700
Message-ID: <20260706235215.97085-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706145538.DF9291F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 14:55:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] API Misuse / Silent Overflow: Using `abs()` on the difference of two large unsigned integers causes incorrect results.
> - [High] Integer Overflow: `damon_probe_hits_wsum()` wraps around the 32-bit boundary when large weights are used.
> --
> 
> commit b2b82783307a6d10c78010502dd30f5168036627
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: extend merge function to work with probe hits
> 
> When probe weights are set, this commit extends damon_merge_regions_of() to
> work with the weighted sum of probe hits. It also introduces a placeholder
> detection function to allow safe incremental changes.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 42f27849af722..7aff741d43bd4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3230,6 +3235,16 @@ static void damon_merge_two_regions(struct damon_target *t,
> >  	damon_destroy_region(r, t);
> >  }
> >  
> > +static unsigned int damon_merge_score(struct damon_region *r, bool last,
> > +		struct damon_ctx *ctx, bool use_probe_hits)
> > +{
> > +	if (use_probe_hits)
> > +		return damon_probe_hits_wsum(r, last, ctx);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Does this code wrap around the 32-bit boundary when large weights are used?
> 
> Looking at damon_probe_hits_wsum(), it accumulates probe_hits[i] * probe->weight
> into a 32-bit unsigned int sum:
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
>     return sum;
> }
> 
> If a user configures a large weight (e.g., > 16,843,000) for a probe via
> sysfs, this could wrap around (e.g., 255 hits * 40,000,000 weight = 10.2
> billion, which wraps to ~1.6 billion).
> 
> Could this break the scoring mechanism, causing damon_merge_regions_of() to
> merge active and inactive regions incorrectly?

Known low priority issue.  No blocker.

> 
> > +	if (last)
> > +		return r->last_nr_accesses;
> > +	return r->nr_accesses;
> > +}
> > +
> 
> [ ... ]
> 
> > @@ -3238,24 +3253,37 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
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
>                    ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Can this call to abs() cause incorrect results due to silent overflow?
> 
> Since score and last_score are unsigned integers, abs(score - last_score)
> casts the unsigned difference to a signed int.
> 
> If the actual difference exceeds the maximum signed integer value, it wraps
> to a negative value, which abs() then negates into a smaller positive value.
> 
> Could this falsely small difference cause the threshold check > thres to fail
> incorrectly, allowing vastly different regions to be merged and affecting the
> accuracy of the monitor?

Same issue exists for the above abs() call.  User impact is minor and I'm
separately working [1] on it.

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
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Does this second use of abs() on the unsigned difference of the merge scores
> suffer from the exact same signed-integer overflow vulnerability?

Ditto.

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
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=7

[1] https://lore.kernel.org/20260705211101.F2F061F000E9@smtp.kernel.org


Thanks,
SJ

[...]
