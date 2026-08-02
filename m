Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B22931E2
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693001; cv=none; b=NnLxqzQGSs1qzpsGF6W2f+OCLuFWZqrpslvT8ECbVqSKm4AAUDhHu8G3MbnuC7jhpGcM+UTjaCx8KYzdvEzrTpneyOLr+5b5k3SzjyBVKPoQB20cfu/uelw/hm7q3WF4iRfGfXkbaAv8DvSh0Hpl1ULKlfwXXanW2miy/rOR3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693001; c=relaxed/simple;
	bh=fLwIyH3NXukzQIlAspjVF1uwMZr0+TReYpG4CzHQRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCvJIu/rwX9BTrQG8CnxgzxROG9pM5gYME50l5jt2ouwL0PjOtyUFLfITwVh4gKF+VWBnCU1PUlMy0FC1aJrtI1Xs2G8n8je9N6XMshCltnjPaWuhHSGgTRbL/cYGVRlpHTN9lUjIQObl50vuNKvjE5Ra7LEITqYGCZiQGtORFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGIeQKgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGIeQKgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6901F000E9;
	Sun,  2 Aug 2026 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692999;
	bh=HFC1ZfZVQgA1k64Or0Q2cVLjt0oIoWc8r5/i4oOGR2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGIeQKgMMSaKgOhrTuX7yy7rh0f5r25nrAZT4eZ8MuXKUSVoBUvZNrOyzx+loTJM5
	 RvC2+RBBEwlQ3HOHEQejXwqei3eNVWA7ALkEWcszLHKfMPob3+wmh4HhbOWVj5se/N
	 LB8E8zVCDbnd15RwotnEQDd3CqCOopF7OK1QbH/UK6edv8U1fQ/mFraBE4nQO2yUqu
	 Of+Choiv6neJieIMYw/cRAQRVv2Lbby18Pv0WPd63cKG9aRVPvek9+NftakuRDd8ag
	 jtahwiJfKvRrA6Qkzl2MnnjSQPOJgYokd9uGBY94TJCTmGYa+CkHNt1ucIxKEaTmoc
	 pQHr3SY1bJsjw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Sun,  2 Aug 2026 10:49:50 -0700
Message-ID: <20260802174951.1878-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802163545.31CC11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:35:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Returning 0 for DAMOS_QUOTA_NODE_MEM_FREE_BP when freeram > totalram incorrectly forces maximum scheme aggressiveness instead of reporting 100% free memory.
> - [Medium] The commit message contradicts the implementation, and the unconditional return of 10000 for zero totalram breaks metric semantics.
> 
> Pre-existing issues:
> - [High] Unhandled integer underflow in MEM_USED_BP and MEMCG_FREE_BP calculations when counters drift.
> - [High] The patch fixes a potential divide-by-zero in damos_get_node_mem_bp() but misses identical unvalidated divisions in related functions.
> --
> 
> --- Patch [7]: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp() ---
> commit 05d27d4d51952669ff23ec9285ccb83a273556ad
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
> 
> In an extreme and unlikely situation, si_meminfo_node() might let the
> caller show zero total ram. That could cause a divide by zero in
> damon_get_node_mem_bp(). Fix it by setting the totalram one byte in the
> case.
> 
> Link: https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
> 
> > In an extreme and unlikely situation, si_meminfo_node() might let the
> > caller show zero total ram.  That could cause a divide by zero in
> > damon_get_node_mem_bp().  Fix it by setting the totalram one byte in the
> > case.
> 
> [Severity: Medium]
> The commit message states "Fix it by setting the totalram one byte in the
> case."
> 
> However, the implementation actually bypasses the metric type check and returns
> 10000. 
> 
> Does this unconditional return contradict the intent documented in the commit
> message?

Good catch, I will update the commit message.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3bdbf4fbf7147..e3f3ee75a3d33 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2816,10 +2816,16 @@ static __kernel_ulong_t damos_get_node_mem_bp(
> >  	}
> >  
> >  	si_meminfo_node(&i, goal->nid);
> > -	if (goal->metric = DAMOS_QUOTA_NODE_MEM_USED_BP)
> > +	if (!i.totalram)
> > +		return 10000;
> 
> [Severity: Medium]
> If the metric is DAMOS_QUOTA_NODE_MEM_FREE_BP, shouldn't it report 0% free
> rather than 100% free if the memory is absent (which is what totalram=1,
> freeram=0 would yield)?
> 
> Does returning 10000 here break the semantic constraint that used + free = 100%?

I made mistakes at revisioning.  I will fix this.

> 
> > +	if (goal->metric = DAMOS_QUOTA_NODE_MEM_USED_BP) {
> >  		numerator = i.totalram - i.freeram;
> 
> [Severity: High]
> This is a pre-existing issue, but if counter drift results in
> freeram > totalram, does this subtraction silently underflow, producing a
> massive unsigned value?
> 
> If this is passed to mult_frac(), could it generate a huge metric value,
> leading the auto-tuner to mistakenly act as if the memory is massively
> overused?
> 
> An identical unhandled underflow also appears to exist in
> damos_get_node_memcg_used_bp() when evaluating DAMOS_QUOTA_NODE_MEMCG_FREE_BP
> if used_pages exceeds totalram:
> 
> mm/damon/core.c:damos_get_node_memcg_used_bp() {
>     ...
>     numerator = i.totalram - used_pages;
>     ...
> }

The intention of this revision was handling this, but I made a complete
mistake.  I will fix.

> 
> > -	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> > +	} else {
> > +		/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> > +		if (i.totalram < i.freeram)
> > +			return 0;
> 
> [Severity: High]
> When counter drift causes freeram > totalram, the node effectively has
> ~100% free memory. 
> 
> By returning 0 (0% free memory) in this scenario, doesn't the DAMON quota
> auto-tuning feedback loop interpret this as severely under-achieving the free
> memory goal, causing it to wastefully and drastically increase the reclamation
> budget (e.g., pageout/demotion) on a node that is already completely free?
> 
> Should this return 10000 (100% free) instead?

That depends on the perspective.  I think 0% makes sense.

> 
> >  		numerator = i.freeram;
> > +	}
> >  	return mult_frac(numerator, 10000, i.totalram);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but while this patch addresses a potential
> divide-by-zero when si_meminfo_node() reports totalram = 0, does the same
> unvalidated division exist in related functions?
> 
> For example, damos_get_node_memcg_used_bp() divides by i.totalram without a
> zero-check:
> 
> mm/damon/core.c:damos_get_node_memcg_used_bp() {
>     ...
>     si_meminfo_node(&i, goal->nid);
>     ...
>     return mult_frac(numerator, 10000, i.totalram);
> }
> 
> Similarly, damos_get_in_active_mem_bp() divides by total (active + inactive)
> via mult_frac() without checking if total is zero:
> 
> mm/damon/core.c:damos_get_in_active_mem_bp() {
>     ...
>     if (goal->metric = DAMOS_QUOTA_SOME_MEM_USED_BP)
>         return mult_frac(active, 10000, total);
>     return mult_frac(inactive, 10000, total);
> }

Later patches in this series fix those.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=7
> 


Thanks,
SJ
