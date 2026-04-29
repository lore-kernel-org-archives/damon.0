Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF3154425
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441303; cv=none; b=irwQjnWsOLiBx1Kl4bK8PygxOB/WqIt7jN2TxJ7qo9B+b00f3qDH7fAHGVB3D212r42T7Ak99CpxmEvs8XQyWkHrsC1QthO3ojzaa7ZWQQM9swgap4+q+EKl8rvuHy+hZVe76PyPjNytFGtLQP7fsJJPD3GuaDhryJMM6BvFN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441303; c=relaxed/simple;
	bh=LmZgz+NDbQcsO8X5k/AgOcKCYhmb1oJSGC4Wri+UGSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLAnNdxYJNN5fQ6ppyDH7tYl0d7qJZ3K+fCozs+8GOkGvx1e3UlN5WEC+XxyiP4vsiRo1bm5q9jlXhKnzWzSHwRfyqQqq8KwTrsd693rbDepqc6w1hAJQ0zyJjiBrwhgvdGNcwjbJIpk3wsgjfaFK0hhGdZgWgRYph0xw7bETdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdsm/o90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdsm/o90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13008C19425;
	Wed, 29 Apr 2026 05:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777441303;
	bh=LmZgz+NDbQcsO8X5k/AgOcKCYhmb1oJSGC4Wri+UGSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdsm/o90ptqXhMJnWqIgOgEvJvtycg43xPgRlAlWHm3rmoYYzwataODvxLrh2VHBz
	 4cvcne0YSfZfVBc+nWPIUkRZGpNLrQVN4eKFRGmh5U9ckSumCEGwi0wCD9zCcaaAPW
	 vwfLqGFl6rFKOFxd84xsnKtX3Q1M9ww8zQDqLKGvyeu72VLmeDZXXDa4YH7GYJd/UQ
	 /rtvTS0EYidjdegqKMnsU099XcDQgFx45IoTKXH7x1kjh8s7+AT4uakRMl3IeBaoBU
	 rTJ7UAS0J2SzIwqpjTr2aMMn9qAZWZaKIoWQxqoxd8I7XRyZgrbcH69hqpN98mP83V
	 NNnp73RaAwMPg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/7] mm/damon/reclaim: cover all system rams
Date: Tue, 28 Apr 2026 22:41:35 -0700
Message-ID: <20260429054135.91515-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429052317.4BE6BC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 05:23:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Massive single DAMON region spanning physical address holes causes CPU soft lockups and quota starvation.
> - [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in damon_set_region_system_rams_default() leads to infinite loop and OOM panic.

No blocker of this patch in my opinion.  Pleae read below for more details.

> --
> 
> commit 179df0c96a01c49e5644b5cc1a9154fb63368993
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: cover all system rams
> 
> This commit changes DAMON_RECLAIM to monitor the entire system RAM by
> default, rather than just the biggest System RAM region, to cover all
> available memory.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index b330ff169590..a60ee800d63e 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -232,11 +234,9 @@ static int damon_reclaim_apply_parameters(void)
> >  		damos_add_filter(scheme, filter);
> >  	}
> >  
> > -	err = damon_set_region_biggest_system_ram_default(param_target,
> > -					&monitor_region_start,
> > -					&monitor_region_end,
> > -					param_ctx->addr_unit,
> > -					param_ctx->min_region_sz);
> > +	err = damon_set_region_system_rams_default(param_target,
> > +			&monitor_region_start, &monitor_region_end,
> > +			param_ctx->addr_unit, param_ctx->min_region_sz);
> 
> Can monitor_region_start and monitor_region_end be modified concurrently
> via sysfs module parameters while this code is executing?

No.

The function can be invoked in three places.

1. damon_reclaim_init()
2. enabled parameter write callback
3. commit_inputs parameter write callback

Because init function is called before users can write to sysfs, path 1 cannot
race with paths 2 and 3.  Because parameter write callbacks are protected by
kernel_param_lock, paths 2 and 3 cannot race each other.

> 
> Looking at damon_set_region_system_rams_default(), the pointers are
> dereferenced multiple times:
> 
> mm/damon/core.c:damon_set_region_system_rams_default() {
> 	if (*start > *end)
> 		return -EINVAL;
> 
> 	if (!*start && !*end &&
> 		!damon_find_system_rams_range(start, end, addr_unit))
> 		return -EINVAL;
> 
> 	addr_range.start = *start;
> 	addr_range.end = *end;
> 	return damon_set_regions(t, &addr_range, 1, min_region_sz);
> }
> 
> If a concurrent sysfs write alters the values between the initial check and
> the subsequent assignment, could this result in an inverted range where start
> is greater than end?
> 
> If an inverted range is passed to damon_set_regions(), the size calculation
> (end - start) could underflow to a massive value. When the thread later
> executes damon_apply_min_nr_regions(), it might enter an infinite loop trying
> to split the underflowed region, endlessly allocating damon_region objects.

So, such an issue cannot happen.

> 
> Additionally, could damon_find_system_rams_range() create a single bounding
> box that spans massive unpopulated physical address holes on sparse memory
> systems?
> 
> Since DAMON applies schemes by linearly looping over the region page-by-page,
> would spinning over terabytes of holes without calling cond_resched() cause
> CPU soft lockups?

Answered on RFC.  To repeat, operations for the holes should be lightweight
enough, since we will just see it is hole and move to next page.  Users can
manually set the monitoring regions.

> 
> Furthermore, because these holes are never accessed, they might perfectly match
> PAGEOUT schemes. Could the massive region size (including holes) be incorrectly
> charged against the reclaim quota, instantly depleting it and preventing actual
> RAM from being reclaimed?

Also answered on RFC.  Users can manually set the regions for this kind of
extremem corner case.

> 
> Would it be better to dynamically populate multiple regions (one for each
> RAM block) instead of using a single bounding box?

I answered this on the review to the first patch of this series.


Thanks,
SJ

[...]
