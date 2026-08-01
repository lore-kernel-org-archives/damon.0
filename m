Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990723BD1B
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785616027; cv=none; b=N2RWESRt+wQQtg8bQZolmN2PlylnYWJXKO7wd6amNdsFvphposNy1n24VPV4nw5vlV0FNPvhViovpeUp/hV97ranSycapEinM0EZd6f2+z3OyhcRjXkJ/kXZVJPMF7bODjw+mmC1MDHZ/hI9sCr8q+Cza8aTiULHWy322HUmgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785616027; c=relaxed/simple;
	bh=jwKAQjFLss0x3UM2OKPhR7ExXmTrcNLwgdHUqNv6U1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COuaoBysWq3UzLxv5U59GCiXJW21uQC9MEQQMcY2H8D87vIw0aloCU/VxY8F8BGGY8c+gwEH9Q0H2mB9R5r4I/AxrJb8qbclSJ1UPMPKbg1nHP2jI8h887nYwEkS8AOBymE0dBWQhPPpeXGgYlPrbqqEQjUAsBKHaX3SVjMnI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqhhPnZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqhhPnZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE951F00AC4;
	Sat,  1 Aug 2026 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785616025;
	bh=rphniPmD4xeq7Ey3oVprTN5/JukRobFgH0rQjm58wYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqhhPnZW7WOt8AMaLehBz8SZfzQgads9cxGQU2hOKjbJh74/kpR8S5ECT/QmSOlfU
	 snDzM9/CZE3/n+TBnUKqj+PS73AUZ8AvdtjDIinjL/Ullin8ih8iels/LLFLpnrcxh
	 eTqbz5+Cj+5nTExk6Rj0zjLWzhvGV6xYZ0EOyhonCXDF977GeC94LW8RjxuyLFZMAr
	 jHSkVlpaIazWY5sD/zFwlh0FM3qoRlFDy4ufypKGkboTvcuPJHpIEvUNQ3iAyNauK5
	 3datgGKI0Jye7C2EGXmoBUhcGA9YZpWxkdb7LzMOeq5ojgPyJiaaWARG3ZxxrvY0yd
	 EyLB7V2Xy4UdQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 8/9] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Sat,  1 Aug 2026 13:26:56 -0700
Message-ID: <20260801202657.117135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801193101.E8AA11F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 19:31:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Fallback values for invalid nodes and missing memcgs incorrectly encourage aggressive scheme application instead of throttling.
> - [High] Division by zero in `damos_get_in_active_mem_bp()` when total LRU memory is zero.
> - [High] Division by zero in `damos_quota_score()` when a quota goal has a `target_value` of 0.
> --
> 
> --- Patch [8]: [RFC PATCH 8/9] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp() ---
> commit 7261d4dd3fd172b597cdefa3462cc680deabe142
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
> 
> This commit adds fallback logic to handle extreme situations where total 
> memory is zero, or when lruvec_page_state() returns used memory larger 
> than total memory. It returns 100% and 0% respectively to avoid division 
> by zero or underflow in damos_get_node_memcg_used_bp().
> 
> Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 269865eb8fbfa..76764a2056f7c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2858,10 +2858,16 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	mem_cgroup_put(memcg);
> >  
> >  	si_meminfo_node(&i, goal->nid);
> > -	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> > +	if (!i.totalram)
> > +		return 10000;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but returning 0 in other fallback 
> paths for missing memcgs or invalid nodes incorrectly encourages aggressive 
> scheme application. 
> 
> In the DAMOS quota auto-tuner (damon_feed_loop_next_input()), a metric score
> of 0 evaluates as severe under-achievement, causing the tuner to aggressively
> maximize the quota. To safely halt a scheme for invalid targets, the metric
> getter should probably return a value that yields a high score (e.g., 10000).
> 
> However, multiple pre-existing fallback paths incorrectly return 0:
> 
> mm/damon/core.c:damos_get_node_memcg_used_bp()
> 	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> 		return 0;
> 
> mm/damon/core.c:damos_get_node_mem_bp()
> 	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> 		numerator = i.freeram;
> 	return mult_frac(numerator, 10000, i.totalram);
> (when !totalram, this evaluates to 0)
> 
> mm/damon/core.c:damos_get_node_mem_bp()
> 	static __kernel_ulong_t damos_get_node_mem_bp(
> 			struct damos_quota_goal *goal)
> 	{
> 		return 0;
> 	}
> 
> Could these fallbacks cause the auto-tuner to unleash maximum operations and
> lead to severe over-reclaim or wasted CPU when a node becomes invalid or a
> memcg is destroyed?

This is an intended behavior.

> 
> > +	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP) {
> >  		numerator = used_pages;
> > -	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +	} else {
> > +		/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +		if (i.totalram < used_pages)
> > +			return 0;
> >  		numerator = i.totalram - used_pages;
> > +	}
> >  	return mult_frac(numerator, 10000, i.totalram);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue with a similar root cause, but does this same
> division by zero problem exist in damos_get_in_active_mem_bp()?
> 
> mm/damon/core.c:damos_get_in_active_mem_bp()
> 	if (active_ratio)
> 		return mult_frac(active, 10000, total);
> 	return mult_frac(inactive, 10000, total);
> 
> If the system has 0 pages on the LRU (e.g., during early boot, in extremely
> constrained environments, or if all memory is unevictable), total evaluates
> to 0. Would this result in a kernel panic when passed to mult_frac()?

A later patch in this series will fix it.

> 
> 
> [Severity: High]
> This is another pre-existing issue, but does damos_quota_score() also suffer
> from a division by zero when a quota goal has a target_value of 0?
> 
> mm/damon/core.c:damos_quota_score()
> 	highest_score = max(highest_score,
> 		mult_frac(goal->current_value, 10000,
> 			goal->target_value));
> 
> While the sysfs interface drops goals with a 0 target value, the core
> allocation function damos_new_quota_goal() does not validate it. The mtier
> sample module exposes these as module parameters:
> 
> samples/damon/mtier.c:damon_sample_mtier_build_ctx()
> 	quota_goal = damos_new_quota_goal(
> 		promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
> 		DAMOS_QUOTA_NODE_MEM_FREE_BP,
> 		promote ? node0_mem_used_bp : node0_mem_free_bp);
> 
> If an administrator or privileged user writes 0 to the parameter and enables
> the module, would this immediately crash the kernel when the DAMOS worker
> thread evaluates the quota?

Good catch, I will work on this separately or as a part of this series.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=8


Thanks,
SJ
