Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062D2EC09F
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693574; cv=none; b=pZu4HouHb9fYdEKam6bcwsjoZCspxZrrDYlweUTGuqSYRbatkB9RkbGr7JZKoRt33B+R48Skp1aTxKx3bQE4YLO0pTlrL46tneW7XGRRiETM511OSkaEeVqlcT+u3T3pHImnZAGBKc/xT0r1p417vPTbyAZ9zfG4Egg8b0oCtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693574; c=relaxed/simple;
	bh=lX/O0NXOInzEJHxZq6YbEAGFxLVp2t4BmIghAei1m5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaHlXnoHbLBEcJHKO2vh5uoRcjUqv8thjIjU/YREcixC0U0Kk8xIBsmUg584JzyXcj/tF4rzYLxupW5FJvvDU5+V6QFWPRv8tt8ojHId/9oRISp0sMU1NlZ+ldn4uZzr10vMMPHQHVB+Ttin/kjyWM42DjBP9ZS6zoseq0cL0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkEKRVoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkEKRVoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06821F00A3A;
	Sun,  2 Aug 2026 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693573;
	bh=KPapDAP1xjxuvjGIOsmBz2qOjlPcOsVIwkg3Vh5nMTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mkEKRVoaYHvoiDTof3qL4OzRuE+Qs2bwAEVC2+X91soR0NtM3hh0wBOGxCmwBZ3eO
	 /HpYdBYemWNvb0Misg4nRLu4MJr545FY91vdTV6FbvPMfilpCqeUrY2c+mXciLa0HT
	 cErv1amarxGy6+xCw8/7JfNSAV1qofDj5zS/6ny0goiTGV7y9mEDzDsUgdh82sxlUO
	 FvFoI4EZR27A5EhysTuG0wtKXNXXq20y26aG+zpbdV4Y0Io253gcAYtH+Qg3hvio9d
	 mb85ch2a0o+UCPUr5qbqlCSuLe+VWku3LEWi6UZnjX/UHX+Tz+6uWLkzUQxnutR8WZ
	 IBKB45XxyhV6A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Sun,  2 Aug 2026 10:59:24 -0700
Message-ID: <20260802175926.2322-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802174951.1878-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun,  2 Aug 2026 10:49:50 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 02 Aug 2026 16:35:44 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] Returning 0 for DAMOS_QUOTA_NODE_MEM_FREE_BP when freeram > totalram incorrectly forces maximum scheme aggressiveness instead of reporting 100% free memory.
> > - [Medium] The commit message contradicts the implementation, and the unconditional return of 10000 for zero totalram breaks metric semantics.
> > 
> > Pre-existing issues:
> > - [High] Unhandled integer underflow in MEM_USED_BP and MEMCG_FREE_BP calculations when counters drift.
> > - [High] The patch fixes a potential divide-by-zero in damos_get_node_mem_bp() but misses identical unvalidated divisions in related functions.
> > --
> > 
> > --- Patch [7]: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp() ---
> > commit 05d27d4d51952669ff23ec9285ccb83a273556ad
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
> > 
> > In an extreme and unlikely situation, si_meminfo_node() might let the
> > caller show zero total ram. That could cause a divide by zero in
> > damon_get_node_mem_bp(). Fix it by setting the totalram one byte in the
> > case.
> > 
> > Link: https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
> > 
> > > In an extreme and unlikely situation, si_meminfo_node() might let the
> > > caller show zero total ram.  That could cause a divide by zero in
> > > damon_get_node_mem_bp().  Fix it by setting the totalram one byte in the
> > > case.
> > 
> > [Severity: Medium]
> > The commit message states "Fix it by setting the totalram one byte in the
> > case."
> > 
> > However, the implementation actually bypasses the metric type check and returns
> > 10000. 
> > 
> > Does this unconditional return contradict the intent documented in the commit
> > message?
> 
> Good catch, I will update the commit message.
> 
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 3bdbf4fbf7147..e3f3ee75a3d33 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2816,10 +2816,16 @@ static __kernel_ulong_t damos_get_node_mem_bp(
> > >  	}
> > >  
> > >  	si_meminfo_node(&i, goal->nid);
> > > -	if (goal->metric = DAMOS_QUOTA_NODE_MEM_USED_BP)
> > > +	if (!i.totalram)
> > > +		return 10000;
> > 
> > [Severity: Medium]
> > If the metric is DAMOS_QUOTA_NODE_MEM_FREE_BP, shouldn't it report 0% free
> > rather than 100% free if the memory is absent (which is what totalram=1,
> > freeram=0 would yield)?
> > 
> > Does returning 10000 here break the semantic constraint that used + free = 100%?
> 
> I made mistakes at revisioning.  I will fix this.

And this semantic gap exist in the next patch, too.  I will fix it together.

> 
> > 
> > > +	if (goal->metric = DAMOS_QUOTA_NODE_MEM_USED_BP) {
> > >  		numerator = i.totalram - i.freeram;
> > 
> > [Severity: High]
> > This is a pre-existing issue, but if counter drift results in
> > freeram > totalram, does this subtraction silently underflow, producing a
> > massive unsigned value?
> > 
> > If this is passed to mult_frac(), could it generate a huge metric value,
> > leading the auto-tuner to mistakenly act as if the memory is massively
> > overused?
> > 
> > An identical unhandled underflow also appears to exist in
> > damos_get_node_memcg_used_bp() when evaluating DAMOS_QUOTA_NODE_MEMCG_FREE_BP
> > if used_pages exceeds totalram:
> > 
> > mm/damon/core.c:damos_get_node_memcg_used_bp() {
> >     ...
> >     numerator = i.totalram - used_pages;
> >     ...
> > }
> 
> The intention of this revision was handling this, but I made a complete
> mistake.  I will fix.
> 
> > 
> > > -	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> > > +	} else {
> > > +		/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> > > +		if (i.totalram < i.freeram)
> > > +			return 0;
> > 
> > [Severity: High]
> > When counter drift causes freeram > totalram, the node effectively has
> > ~100% free memory. 
> > 
> > By returning 0 (0% free memory) in this scenario, doesn't the DAMON quota
> > auto-tuning feedback loop interpret this as severely under-achieving the free
> > memory goal, causing it to wastefully and drastically increase the reclamation
> > budget (e.g., pageout/demotion) on a node that is already completely free?
> > 
> > Should this return 10000 (100% free) instead?
> 
> That depends on the perspective.  I think 0% makes sense.
> 
> > 
> > >  		numerator = i.freeram;
> > > +	}
> > >  	return mult_frac(numerator, 10000, i.totalram);
> > >  }
> > 
> > [Severity: High]
> > This is a pre-existing issue, but while this patch addresses a potential
> > divide-by-zero when si_meminfo_node() reports totalram = 0, does the same
> > unvalidated division exist in related functions?
> > 
> > For example, damos_get_node_memcg_used_bp() divides by i.totalram without a
> > zero-check:
> > 
> > mm/damon/core.c:damos_get_node_memcg_used_bp() {
> >     ...
> >     si_meminfo_node(&i, goal->nid);
> >     ...
> >     return mult_frac(numerator, 10000, i.totalram);
> > }
> > 
> > Similarly, damos_get_in_active_mem_bp() divides by total (active + inactive)
> > via mult_frac() without checking if total is zero:
> > 
> > mm/damon/core.c:damos_get_in_active_mem_bp() {
> >     ...
> >     if (goal->metric = DAMOS_QUOTA_SOME_MEM_USED_BP)
> >         return mult_frac(active, 10000, total);
> >     return mult_frac(inactive, 10000, total);
> > }
> 
> Later patches in this series fix those.
> 
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=7
> > 
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
