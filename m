Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6231E82A
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224862; cv=none; b=qz7ryOOKWZdyPMMDn5GUszIDRJDl+rxOBjog2fLuSAZfwyz1SNY7+8tJWnPWEsBwI+NHnZScloB7CW0zFHFYVuvalkPiyPRTrlfXNgNH3BUGvbPGNJNLHWbGYBPPBkL/pBNVB6cfbhMWFDIfyBJTpB3Zal+Flsa52uHglOruQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224862; c=relaxed/simple;
	bh=+7XHpZ+dghvF86JFRUN4GhsNHwMq8+BJxDyKO2Gkm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ0+3A9uKRTh52BU8PPLdYjD3w+06aTA4K34qiA/Fb3yLU6RjsVTo4g7+HjlZbG3O/4P2b4Fwp3R4cdf3nG8ZFTyiu3zxICvVq+e6J2BXaEOTJU3TePzvbt3zNpcYSPgy+3V+wfaa2Ixm85VbV32l3qvViHNyMMMbNqDBDaZDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsmcg5Jp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsmcg5Jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDB9C19424;
	Wed, 15 Apr 2026 03:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224861;
	bh=+7XHpZ+dghvF86JFRUN4GhsNHwMq8+BJxDyKO2Gkm3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsmcg5JpQfC88hNfYuGl7FuWFpCRZlIQijSZSBuAm9OUdtWc0AnSQ2UEmGO1WSeGX
	 /cBvl1SeSzNPl0Ug5WcRosKZYTdGTPs+aQinOIjb2HLw4JL+oG+foyki+qBuQpjP74
	 fE+TICtda9Hxao05nN2bkgFnBH4VwXz3ViLXW+qcfjmToiFlnypW+2X/2fUNlkBw6m
	 8+DbiU+ErkzuDPqzBHU72/qQ03TsoeGNXLtHda0ICU0o4wFCQ2b4gmKET7LvYfB/kS
	 yAcbWv/OEUaSlRF0Pju5SwMH/vKOpd9oiUOgksDZ1Uzc7z13VTvvsG6BJ8vkP0EbB8
	 SBERbS89/bsQA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/7] mm/damon/reclaim: cover all system rams
Date: Tue, 14 Apr 2026 20:47:32 -0700
Message-ID: <20260415034734.83189-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415015830.5F43DC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 01:58:29 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 3 potential issue(s):
> - [High] Unbounded iteration over physical memory holes causes severe scheduling latency and soft lockups.
> - [High] Inclusion of physical holes permanently exhausts DAMOS quotas and starves actual memory reclaim.
> - [High] Bounding box over sparse memory dilutes sampling accuracy and traps RAM in cold regions.

I don't think none of these are real issues for this patch.  See below for more
detailed answers.

> --
> 
> commit 1ebe17b8690373c96bc931bcacccad9cbc735e44
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: cover all system rams
> 
> This commit changes the default DAMON_RECLAIM monitoring region from the
> biggest System RAM resource to a single bounding box that spans all System
> RAM resources on the system.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..2a2343d751f3e 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> [ ... ]
> > @@ -242,11 +244,9 @@ static int damon_reclaim_apply_parameters(void)
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
> When using a single bounding box that covers all System RAM, does this
> introduce large physical address holes (like PCIe MMIO gaps) into the
> monitored region? On sparse NUMA topologies, these holes can be terabytes
> in size.
> 
> If operations like DAMOS_PAGEOUT iterate linearly over the region
> page-by-page, will they process these massive holes? For physical holes,
> damon_get_folio() will return NULL, and the loop might continue without
> yielding:
> 
> damon_pa_pageout() {
>     ...
>     while (addr < end) {
>         ...
>         folio = damon_get_folio(PHYS_PFN(addr));
>         if (!folio) {
>             addr += PAGE_SIZE;
>             continue;
>         }
>         ...
>     }
> }
> 
> Since cond_resched() is often placed outside or after such loops, could this
> continuous iteration over unbacked holes trigger soft lockups and severe
> scheduling latency?

Theoretically that's possible.  But I believe damon_get_folio() should be
lighweight enough to not cause such problems in common cases.  Also, we allow
users to manually set the monitoring regions for special cases.

So unless this cause such real issues in common cases, I think this patch is
good to go as is.

> 
> How does the inclusion of massive physical holes interact with DAMOS quotas?
> 
> In damos_apply_scheme(), the scheme's charged size is incremented by the
> evaluated region size (quota->charged_sz += sz). If regions span terabytes of
> unbacked holes, evaluating them will quickly exhaust the quota (e.g., 128
> MiB/sec for DAMON_RECLAIM) without reclaiming any actual pages.
> 
> Could this starve actual memory reclaim and inflate the sz_tried statistics?

Yes, this could exhaust the quota.  But, again, users can manually set the
regions if this becomes a real problem on their setup.  We are also working on
the action failed regions quota charge ratio [1], which could also help the
corner case.

> 
> Does the bounding box approach also affect sampling accuracy?
> 
> DAMON samples a random address within a region using
> damon_rand(r->ar.start, r->ar.end). If the region is mostly composed of
> physical holes, the sample will frequently land in unbacked space and return
> zero accesses.
> 
> Since the region will continuously appear cold, could
> damon_merge_two_regions() merge it with adjacent valid RAM regions? This
> might trap valid RAM inside massive cold regions, diluting the sampling
> probability for actual memory.

Adaptive regions adjustment should avoid things going on such extreme case.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260415012048.76508-1-sj@kernel.org?part=2

[1] https://lore.kernel.org/20260412161957.82835-1-sj@kernel.org


Thanks,
SJ

[...]
