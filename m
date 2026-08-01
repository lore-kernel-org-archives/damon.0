Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6336B931
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615532; cv=none; b=FARgPRTKowdZMXcSFTpkELU+vkG4/gi+ZXHQ8IjXwYaw0ktu6rK/SRp/Y+lPgc/ZFRHf6rMggCVJfs6qZR3CQxEKXQ3eavpHL0TyFNyc/YZsTIwZjEEIwztII1a1ZeejeciVs5Ir5Ma7JFvyITAI9HZbq5Tr8BUU9kSebqZU19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615532; c=relaxed/simple;
	bh=2FPe1KOXgdZ/rW764ykM2JOoyfzzLgL4yP9ae/bMkuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLH8UiXE87pCxUB+cgrr53pYJgpty1xHBNLUIYTA85DPMTAurRvmtCtecC5OpmkEdhYe4t1WW8AY7+EhWtdMAA72rungtNsYEmlWK5StJdvkflefiBtGOEDFo2SrS29LFSHKluwwX7iZ/zFLYmGhlbvUGGBtVmbqMcCsrkbUq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KolzjpEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KolzjpEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489FE1F00AC4;
	Sat,  1 Aug 2026 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785615530;
	bh=Hi1bDhCgpWcC+5p6SoeZC3iIfSLX7qU90sgV6JAyZSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KolzjpEe9c8TD7gO2P7Ab8gIlVkULvsTqJHtBL1029zHVh0tfpcGxoMCd5R1LhnTG
	 9TOQDbqJp8DUMWTfcSiVhR2bevMiDyPuh0UTT73Ev7BDervGMNU4/dYP0XoTrobAHC
	 brolYC5KdaBUgLbpPGaAuPJwfDqW4QBC4qxgTlizaldshTnPQXKZ+1b2QnIzkb6Mih
	 mH+ynU5hxFIMBKn3ZSSsFktrwNDJV79q3SCGdhQmM/9mHwM4yWXA/Sc1Vau1usuB1Z
	 Bam6irM3aLpuJ8+XMCZMYea7zjKwPbbu7S+bF9LkwsX9ZLjHJ+pzi9j13NNrBahf45
	 PknO+Rr2Zj9jQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Sat,  1 Aug 2026 13:18:40 -0700
Message-ID: <20260801201842.116790-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801191130.D56091F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 19:11:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Falsely reporting 100% memory utilization for an empty node due to a flawed division-by-zero fix.
> 
> Pre-existing issues:
> - [High] Potential integer underflow when evaluating `i.totalram - i.freeram` due to lockless vmstat reads.
> - [High] The patch fixes a potential divide-by-zero in `damos_get_node_mem_bp()`, but fails to apply the same fix to `damos_get_node_memcg_used_bp()`.
> - [High] Multiplication overflow in basis-point calculation on 32-bit architectures.
> - [High] Potential divide by zero in `damos_get_in_active_mem_bp()` if the system has no active or inactive LRU pages.
> --
> 
> --- Patch [7]: [RFC PATCH 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp() ---
> commit 0e2bb1b3ade5000769644aa674efbcfec5b43152
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
> 
> In an extreme and unlikely situation, si_meminfo_node() might let the caller
> show zero total ram. That could cause a divide by zero in
> damon_get_node_mem_bp(). Fix it by setting the totalram one byte in the case.
> 
> Link: https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2816,6 +2816,8 @@ static __kernel_ulong_t damos_get_node_mem_bp(
> >  	}
> >  
> >  	si_meminfo_node(&i, goal->nid);
> > +	if (!i.totalram)
> > +		i.totalram = 1;
> > +	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
> > +		numerator = i.totalram - i.freeram;
> 
> [Severity: Medium]
> Does setting totalram to 1 artificially inflate the utilization for an empty
> node?
> 
> If si_meminfo_node() returns 0 for both totalram and freeram, numerator
> becomes 1 - 0 = 1. This would result in 100 percent used memory (10000 basis
> points), which contradicts the fallback logic that reports 0 percent for an
> empty node. Will this trigger DAMOS quota actions erroneously?

I think this is fine.  Just different perspectives, and no real problem in real
life.  We can later revisit for consistent interpretation of this extreme
situations.

> 
> [Severity: High]
> This is a pre-existing issue, but can this subtraction underflow?
> 
> Because si_meminfo_node() computes freeram via lockless zone stats, per-CPU
> stat lag can temporarily cause freeram to exceed totalram. If freeram >
> totalram, the unsigned long numerator will underflow to a massive value.
> 
> If we force totalram to 1 here and freeram is greater than 0, doesn't it
> guarantee this underflow will occur?

Good point, I will fix in the next version.

> 
> > +	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but does the same divide-by-zero happen in the
> adjacent damos_get_node_memcg_used_bp() function?
> 
> mm/damon/core.c:damos_get_node_memcg_used_bp() {
>         ...
>         si_meminfo_node(&i, goal->nid);
>         ...
>         return mult_frac(numerator, 10000, i.totalram);
> }
> 
> Since si_meminfo_node() can return 0 for totalram, wouldn't this also cause
> a divide-by-zero here if i.totalram isn't validated?

A later patch in this series will fix it.

> 
> [Severity: High]
> This is a pre-existing issue, but can the basis-point calculation overflow
> on 32-bit architectures?
> 
> mm/damon/core.c:damos_get_node_mem_bp() {
>         ...
>         return mult_frac(numerator, 10000, i.totalram);
> }
> 
> Since mult_frac(numerator, 10000, denom) computes the remainder times 10000,
> if the remainder exceeds roughly 429,496, won't this overflow a 32-bit
> unsigned long and produce an incorrect result?

Known low priority issue.

> 
> [Severity: High]
> This is a pre-existing issue, but is there a potential divide-by-zero here
> if the system has no active or inactive LRU pages?
> 
> mm/damon/core.c:damos_get_in_active_mem_bp() {
>         ...
>         total = active + inactive;
>         if (active_ratio)
>                 return mult_frac(active, 10000, total);
>         return mult_frac(inactive, 10000, total);
> }
> 
> If all memory is mlocked or purely kernel-allocated, both active and
> inactive could be 0, making total 0. Will mult_frac() panic when dividing
> by total?

A later patch in this series will fix it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=7


Thanks,
SJ
