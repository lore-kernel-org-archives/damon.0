Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0733195E4
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776225144; cv=none; b=P8YGDVFs7DUHv74WSI8QfR5dji7iar1fHE2Jf0ya+XPZRYRLi7JFn+PQYRKaDxbVbfaOo9jQFQ/eDtecMG8Lo5fpRS28z6/Rr5okvVsnHOgxgfnUl/do2yCuD0KPe5d5L/jPABjdg6WAC4uAjjQ1VS737mmbBEgbjZnEHUPpXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776225144; c=relaxed/simple;
	bh=YPuPPaT8hgkQyQUnxUT4sqZBUB5nn/lSJnfvkD8C5s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5tjw6/aQBttnPKETmIgs2No6kaxT7o4oFqx91a9lDU2wPfqp+BVmMEYmXg+2zmcV0QXcGZ/OjwWyMLqpPJyjydjccxRUD7JlEb/ATYkyfzyHSLuQD1z2TKiGcXfRPEQiNOCmlrdx01lciY+IuBMHrjy0w1qpRmiB7QCRX4uGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv0swCIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv0swCIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D53AC19424;
	Wed, 15 Apr 2026 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776225144;
	bh=YPuPPaT8hgkQyQUnxUT4sqZBUB5nn/lSJnfvkD8C5s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fv0swCIb7ERGLWBii/efwNqmtjAh6R9KjeoSmLyJE0u+h5EsatePNQ3q8bypw/uQa
	 xvcujxSb4OACnOLZgV84pQ3zV/Ju65Q8jPDVFCq6strmOUG8xqrccw/cYqlX/AheJs
	 l32fkx/LQxQT25ynu1QL8MNbgWadxPrRhCeOZmqlWR10V1isWeOVPWSsHecYxm0/jj
	 uHhE1P52batA4sRJbn2cJ8i8TYUr/q9hO2wBu+FLIgKv6ve2Jv7JMo+4OPoomeh//S
	 avtYEoGxMOX82+dmAKjeot3XaA28cM+Ub6HeFyw3V7fs7mA5+c0Br+Lh8qUBWwE0Gg
	 4L/fmEw3wHG0g==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/7] mm/damon/lru_sort: cover all system rams
Date: Tue, 14 Apr 2026 20:52:18 -0700
Message-ID: <20260415035220.83337-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415023628.DDFC8C2BCB5@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 02:36:28 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 3 potential issue(s):
> - [High] Monitoring the bounding box of all System RAM resources encompasses massive physical address holes, fundamentally breaking DAMON's sampling-based access check on sparse memory systems.
> - [High] Applying schemes to the newly-enlarged bounding box can cause a soft lockup panic due to unbounded page iteration without yielding.
> - [Low] Misspelled 'phyiscal' in module parameter documentation.

Other than the typo, no real issues in my opinion.  Read below for more
detailed answers.

> --
> 
> commit 11d2e4765abf8999777a27c53c055f1c43ca53bf
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/lru_sort: cover all system rams
> 
> This commit updates DAMON_LRU_SORT to cover all system RAM instead of
> just the biggest System RAM resource. The default monitor region start
> and end parameter descriptions and initializations are modified to
> reflect the entire physical memory space.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d729760..7f8c26890ffb2 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -140,7 +140,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_lru_sort_mon_attrs);
> >   * Start of the target memory region in physical address.
> >   *
> >   * The start physical address of memory region that DAMON_LRU_SORT will do work
> > - * against.  By default, biggest System RAM is used as the region.
> > + * against.  By default, the system's entire phyiscal memory is used as the
> 
> This isn't a bug, but there is a typo (phyiscal) here.

Nice catch, I will fix this in the next revision.

> 
> > + * region.
> >   */
> >  static unsigned long monitor_region_start __read_mostly;
> >  module_param(monitor_region_start, ulong, 0600);
> > @@ -149,7 +150,8 @@ module_param(monitor_region_start, ulong, 0600);
> >   * End of the target memory region in physical address.
> >   *
> >   * The end physical address of memory region that DAMON_LRU_SORT will do work
> > - * against.  By default, biggest System RAM is used as the region.
> > + * against.  By default, the system's entire phyiscal memory is used as the
> 
> There is another typo (phyiscal) here as well.

I will fix this in the next revision.

> 
> > + * region.
> >   */
> >  static unsigned long monitor_region_end __read_mostly;
> >  module_param(monitor_region_end, ulong, 0600);
> 
> [ ... ]
> 
> > @@ -336,7 +338,7 @@ static int damon_lru_sort_apply_parameters(void)
> >  	if (err)
> >  		goto out;
> >  
> > -	err = damon_set_region_biggest_system_ram_default(param_target,
> > +	err = damon_set_region_system_rams_default(param_target,
> >  					&monitor_region_start,
> >  					&monitor_region_end,
> >  					param_ctx->addr_unit,
> 
> Will monitoring the bounding box of all System RAM resources encompass massive
> physical address holes on sparse memory systems?
> 
> Because DAMON estimates access frequency by sampling uniformly at random from
> the region:
> 
> r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
> 
> If the bounding box spans across terabytes of address gaps between NUMA nodes,
> would the overwhelming majority of samples hit unpopulated holes?
> 
> Since sampling a hole returns no folio, does this artificially dilute the
> apparent access frequency of valid hot RAM within the region and misidentify
> it as cold?

Adaptive regions adjustment should avoid this issue.

> 
> Can this also cause soft lockups during scheme application?
> 
> When applying a scheme, the region is iterated page-by-page. For unpopulated
> gaps, the folio check is skipped and the address is incremented:
> 
> while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
>     folio = damon_get_folio(PHYS_PFN(addr));
>     if (damon_pa_invalid_damos_folio(folio, s)) {
>         addr += PAGE_SIZE;
>         continue;
>     }
>     ...
> 
> Since there is no cond_resched() inside this tight loop, and because valid
> folios are not found (meaning quota variables don't increment to abort early),
> could iterating over terabytes of unpopulated gaps trigger the soft lockup
> watchdog on PREEMPT_NONE or PREEMPT_VOLUNTARY kernels?

As I replied to the previous patch review, though it is theoretically possible,
I don't think such cases are common.  Also if it is really such a corner cases,
users can manually set the monitoring regions.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260415012048.76508-1-sj@kernel.org?part=3


Thanks,
SJ
