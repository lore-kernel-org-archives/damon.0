Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA21C5F1B
	for <damon@lists.linux.dev>; Sat, 27 Jun 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581050; cv=none; b=K3kzXZJ87O39ibHaxCpKfg/sFx8uk/Zdq+66aBYnpKcIqzk2qKrCZ/y8Lz2+9hKlK4hiCSstZM7iHzLhgAnAP1rLk9qCdvbADS5V7VdqdUAbvc6EZnFtmOiBZLGA8QFliwfosG17Q++2Z6lYGttnUy8UIcEcV2nfmIGe4MhspZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581050; c=relaxed/simple;
	bh=iYdLC02S4etbBwAYpk8wMivdQ3WF7ZgehYA4vmHp+Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9aTzMAEUKOFpvjSHPwoQtmMxTMOIxNyaNvn7XeElfUjREfiyVfyiae0Hx1SbYFCe5dREuAVbmiVAPBVYwSSOV2K0ElVhwI6cHyjj/ecBbbLg0tnwt7KDBkdhZNnystY4L9765Fow3THyWyrQsy1gMxW0LfeeEP7dmTdz/LrYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOmE+H7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOmE+H7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BAA1F000E9;
	Sat, 27 Jun 2026 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782581048;
	bh=3/whHgLTWKZeIz5GkFXSrC49l6nXdX8YGMbI104GaYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOmE+H7HohuButecJuqpJKQVENn0lByo3L0afVF1e+zbW5Raxyh7sxOh18nPjXow6
	 f4YbX+WBvN2fdMPb06B8TjvBFYi5GPFDc3TEIqwBg0rOp6lRT5gUhRvcM+RB4kABBI
	 LabB8nkmtJLnmTKDdzAYhkKD5wyzvDGMZmgYpgXYmxupcx4N8Kq+uKpSUyzZLSbnR+
	 v/V+7wbJENOuZae1KJGGWVbx1I6X1plWWmTiztPfyXmoP5XCXZ9ujIDg/WY/jm2AN8
	 +L2ITbE2koTcG9GxzWPNw1Y7px1OgI8DP1xz1COJ3i6zATNgNbddgVBppZcSWG2+zt
	 pX9Vwzx7Q9qMg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 10:24:05 -0700
Message-ID: <20260627172406.3794-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627171911.1A7181F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 17:19:10 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The validation check to prevent empty regions is bypassed due to integer overflow in ALIGN(), leaving the divide-by-zero vulnerability unpatched.
> - [High] Memory allocation failure during region updates leaves the running DAMON context with a corrupted, partially updated region list.
> --
> 
> commit e67b2388e5d46f77944a06f1bd1d3d550638fade
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: validate ranges in damon_set_regions()
> 
> This patch updates damon_set_regions() to validate ranges and reject
> inputs where the start address is greater than or equal to the end
> address. This aims to prevent zero-length regions which can cause
> divide-by-zero errors in damon_merge_two_regions().
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7e4b9affc5b06..b3100d7fa5596 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -358,6 +358,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  	unsigned int i;
> >  	int err;
> >  
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		if (ranges[i].start >= ranges[i].end)
> > +			return -EINVAL;
> > +	}
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this validation check 
> sufficiently protect against overflow when the regions are aligned later?
> 
> If a user supplies a region where the end address is ULONG_MAX,
> ALIGN(ULONG_MAX, min_region_sz) will wrap around to 0.
> 
> Since this validation check uses unaligned inputs, ULONG_MAX passes
> the check here. Later, during allocation:
> 
> damon_set_regions() {
>     ...
>     r = damon_new_region(
>             ALIGN_DOWN(ranges[i].start, min_region_sz),
>             ALIGN(ranges[i].end, min_region_sz));
>     ...
> }
> 
> This creates a region with a wrapped and inverted size. If the adjacent
> regions sum to a size of 0, for example 4096 + (ULONG_MAX - 4095),
> can this lead to a divide-by-zero crash in damon_merge_two_regions()
> when the sizes are added together?
> 
> damon_merge_two_regions() {
>     ...
>     l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>             (sz_l + sz_r);
>     ...
> }

Nice catch.  The next revision will do the validation with the aligned
addresses.

> 
> [Severity: High]
> This is also a pre-existing issue, but what happens to the region list if
> memory allocation fails after existing regions are destroyed?
> 
> In damon_set_regions(), existing regions not in the new ranges are
> destroyed. If a subsequent damon_new_region() fails and returns -ENOMEM:
> 
> damon_set_regions() {
>     ...
>     if (!r)
>         return -ENOMEM;
>     damon_add_region(r, t);
>     ...
> }
> 
> The error rollback path in damon_revert_target_commits() does not restore
> the regions_list state:
> 
> damon_revert_target_commits() {
>     ...
>     damon_for_each_target(target, dst) {
>         if (target == failed)
>             return;
>         put_pid(target->pid);
>     }
> }
> 
> Will this transient allocation failure permanently leave the running damon
> context with a corrupted or partially updated region list, silencing
> reclamation daemons?

No issue.  The caller should destroy the context in the case.


Thanks,
SJ

[...]
