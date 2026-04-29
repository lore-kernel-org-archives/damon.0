Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01CD344052
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440172; cv=none; b=bvcMZQu+2tDxiKTwn6w/lSChfZEuHkKuI6km1YI4EoPu+LbjAnJawfxhUosu+AbxqpduWjQzaFH0Fb97P2q1KnINm/K1ePbGc220fvhek9oY72Pm9MZzch8s3CmpCi2mLpKpISPZNMiXNJfWAVq7Q+16405EbmACcAgGo+d2NNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440172; c=relaxed/simple;
	bh=bMbmXzkT63ML8sO/ItL5rRMIgfDYMQMWyNSS2jfvaqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFQGJYKiHT2tYYZjRs7p/qtAp1TBS69PaTaAKI7Jnz9uznPeyCeRTm9FhnQLFc1/LhQoltSXYd3dfEWqwokinwMyOrSDD1q5j/JswK8D3P+vIQ8JfDz6aVkGKERxfMb6bahPUtfZKs5vJqm3pKRqq8wbLYSIQhi5Ssv6IcSsUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxcSs1T8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxcSs1T8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A9FC19425;
	Wed, 29 Apr 2026 05:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777440172;
	bh=bMbmXzkT63ML8sO/ItL5rRMIgfDYMQMWyNSS2jfvaqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxcSs1T8U+j++G7+yo7Kwv1w/RMsUFlB5DW+a74KFEu5XkC5ES5H4o4UD0WX8j2xW
	 EBQqGkSRQBP1BsdDvAXsvQIuiNi5Z8miGJ3EznoinxjlCWECxNynaANMVE9HEDsJKh
	 f6DZ52aXZzJ6CXiR/7oU9M3KGumqQ76xlv+V+1+8wdIy0RPTm/iq2cJImoH5+DguF2
	 BCDNV051QRnnBNrJEIkHSwr0vcJbAwxcQhp5QzqdhXKUdRAIXq+Z0A0R+gQPvkHJRC
	 ufF62K4ZEfOi78JN9TeSKmrp84dkUi6CC/1WoY60DB36v4KcV4H3g10i9hUEs1wPKh
	 nRB6QB/Lpc7+Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/7] mm/damon: introduce damon_set_region_system_rams_default()
Date: Tue, 28 Apr 2026 22:22:48 -0700
Message-ID: <20260429052249.91279-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429043902.E8FFDC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 04:39:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The default region setup creates a single contiguous bounding box encompassing all System RAM resources, incorrectly including unpopulated memory holes.
> - [High] Integer overflow during physical address boundary calculation (`arg.res.end + 1`) can cause DAMON initialization to fail.

Both are not a blocker of this patch in my opinion.  Please read below for
details.

> --
> 
> commit cd855b0d7d334ccf9a13e1331105a3281e5b0aeb
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: introduce damon_set_region_system_rams_default()
> 
> Introduces a default target setup for DAMON that sets a physical address
> range covering all System RAM resources when the caller doesn't specify
> a region.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 05e4bef367db..980a31cd3498 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > +static bool damon_find_system_rams_range(unsigned long *start,
> > +		unsigned long *end, unsigned long addr_unit)
> > +{
> > +	struct damon_system_ram_range_walk_arg arg = {};
> > +
> > +	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
> > +	if (!arg.walked)
> > +		return false;
> > +	*start = damon_res_to_core_addr(arg.res.start, addr_unit);
> > +	*end = damon_res_to_core_addr(arg.res.end + 1, addr_unit);
> 
> Can arg.res.end + 1 overflow here?
> 
> If a 32-bit system has physical memory extending to the end of the address
> space, arg.res.end will be the maximum representable value. Adding 1 would
> overflow to 0, making *end 0. The subsequent check if (*end <= *start)
> would then evaluate to true, causing the function to silently return false
> and abort initialization with -EINVAL.

Yes, such corner case could exist.  But, similar overflow-caused initialization
could happen even before this patch, if the biggest System RAM's end address is
same to the U32T_MAX.  And even in the corner case, failing initialization
shouldn't cause a real problem.  The user could manually set the monitoring
regions and work.

So, not a blocker of this patch.

> 
> > +	if (*end <= *start)
> > +		return false;
> > +	return true;
> > +}
> [ ... ]
> > +int damon_set_region_system_rams_default(struct damon_target *t,
> > +			unsigned long *start, unsigned long *end,
> > +			unsigned long addr_unit, unsigned long min_region_sz)
> > +{
> > +	struct damon_addr_range addr_range;
> > +
> > +	if (*start > *end)
> > +		return -EINVAL;
> > +
> > +	if (!*start && !*end &&
> > +		!damon_find_system_rams_range(start, end, addr_unit))
> > +		return -EINVAL;
> > +
> > +	addr_range.start = *start;
> > +	addr_range.end = *end;
> > +	return damon_set_regions(t, &addr_range, 1, min_region_sz);
> 
> Does this create a single bounding box encompassing all System RAM resources,
> including unpopulated memory holes?
> 
> On systems with sparse physical memory layouts, this combined range will
> encompass massive memory holes. Because DAMON uses uniform random sampling
> within a region to estimate access frequencies, samples landing in the gaps
> will inherently register as unaccessed, diluting the perceived access rates
> and preventing effective adaptive region splitting and merging.

As also answered to the same previous questions, DAMON's adaptive regions
adjustment mechanism should solve this accuracy issue.

So, not a blocker for this patch.

> 
> Could the implementation instead construct an array of multiple ranges,
> one for each distinct System RAM resource, and pass them to
> damon_set_regions()?

When the number of such distinct areas is high, because distict regions cannot
be merged, it will degrade the accuracy.  So, no.  Like vaddr, adding a finite
number of biggest gaps might make sense.  But, it wouldn't be late to revist
after such problematic real use case is found.


Thanks,
SJ

[...]
