Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AB27E07E
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605681; cv=none; b=p/7z9I60HsglAdtiJvQeIQ/BySn1fbQBRsR/FlPpNbC+3n8P8OouskghLvbpcaTpJKZ6SX4hdaFILH8bl1KI3JVFPEHL+8XQ5f7bLM/gvkGRmZhmXd1HVVfhiXBlpAYR97nT4tQUagZ1oZnM8f6JDiMxGGHnAtfcFHWRk9Hogzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605681; c=relaxed/simple;
	bh=w8fkZ4m8COBMt7xKSQnlruVS1vWzws4FjgbVQXws4p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP1+en2lqTArvkFrzTZMOSN7bJ5q6nLMtb3z33NLwAsDpQMh3jKqL6DJfC1oQrPFufCBUbpXIr05NdKqEgbzIUsImOw3Oxv751FccFKRbRj10hAPHtOUhWexUZqAVHvKYv0PzwNtb6lOu8K/VvqZn+hN/o8uSenjrc8sK+0EhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLm4bVOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLm4bVOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC701F000E9;
	Tue, 21 Jul 2026 03:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784605679;
	bh=GFyNJy6gukeRDs7GsixC0VHnRsNXr+LNvHI3smy1tGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLm4bVOYaYWm2Dc+nIxFIw2J5kEMIsOQJs9Rz3yt6S/bn3h22GlmbnjlUPbxm1s+x
	 YpEDIuR7oFd5V8ZroQaRL0hdKyN3CO1qBKyz+1/nLq7/RmoeD6pxuGq03r8h2AF2TG
	 3jbtR02Q7rQDZHPNSaWK3DjyFPoa2sABKl0B5dcZWKMLIRlXAa/CBqji5Xo2jHsteV
	 UyqBHdxZywYkl+2j+WmXR3iQBHmbU0MJ32q4JlCuOcla0k9KP49nrG2r5dMW+Icc57
	 rkQUAN6LGeKsUFcxsxifQHxHn1asx3EuI7MKL1uQ1ve7tbjxqcB6c4NFQ1g8OLB5hZ
	 YAsH6+0NMz+hQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	gutierrez.asier@huawei-partners.com,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Mon, 20 Jul 2026 20:47:54 -0700
Message-ID: <20260721034756.147011-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720121658.0AFC01F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 12:16:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Unsigned underflow in `total` bypasses the division-by-zero guard, causing `damos_hugepage_mem_bp` to return 0 instead of the intended safeguard `INT_MAX`.
> - [Medium] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is missing from the sysfs parser mapping array, rendering the feature completely inaccessible to userspace.
> - [Medium] 32-bit integer overflow in `mult_frac()` yields drastically incorrect ratios when the number of huge pages exceeds ~1.7GB.
> 
> Pre-existing issues:
> - [High] Preexisting division by zero in `damos_get_in_active_mem_bp` when LRU lists are empty.
> --
> 
> --- Patch [1]: [PATCH v3 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning ---
> commit 8d24f093924a5075fd67c8f7808eada2166af60d
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
> 
> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning and add a new DAMOS
> quota goal metric to measure huge page consumption. Add a guard to avoid
> division by 0 when vmstat lags.
> 
> Link: https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -167,6 +168,7 @@ enum damos_quota_goal_metric {
> >  	DAMOS_QUOTA_ACTIVE_MEM_BP,
> >  	DAMOS_QUOTA_INACTIVE_MEM_BP,
> >  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> > +	DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> 
> [Severity: Medium]
> Is this feature accessible from userspace?
> 
> If a user writes hugepage_mem_bp to the target_metric sysfs file,
> target_metric_store() iterates over the damos_sysfs_qgoal_metric_names
> array to find a match.
> 
> Because DAMOS_QUOTA_HUGEPAGE_MEM_BP is missing from that array in
> mm/damon/sysfs-schemes.c, will the kernel always reject the user's input
> with -EINVAL?

No issue.  The next patch will make it accessible.

> 
> >  	NR_DAMOS_QUOTA_GOAL_METRICS,
> >  };
> >  
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3007,6 +3007,24 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  	return mult_frac(inactive, 10000, total);
> 
> [Severity: High]
> This is a pre-existing issue, but can this divide by zero?
> 
> In damos_get_in_active_mem_bp(), total is used as the divisor without a zero
> check. If all memory is forced onto the unevictable list (e.g. via
> mlockall()), or if the system is completely idle with only kernel allocations,
> active + inactive can be zero.
> 
> If DAMOS_QUOTA_ACTIVE_MEM_BP is used in such a state, would mult_frac()
> trigger a hardware divide-by-zero exception and panic the system?

No blocker of this patch.

I will work on this.

> 
> >  }
> >  
> > +static unsigned int damos_hugepage_mem_bp(void)
> > +{
> > +	unsigned long thp, total;
> > +
> > +	thp = global_node_page_state(NR_ANON_THPS) +
> > +				global_node_page_state(NR_SHMEM_THPS) +
> > +				global_node_page_state(NR_FILE_THPS);
> > +	total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> > +
> > +	/*
> > +	 * vmstat may lag in idle systems and lead to free pages equaling to
> > +	 * the total RAM in the system.
> > +	 */
> > +	if (!total)
> > +		return INT_MAX;
> 
> [Severity: High]
> Can total underflow here?
> 
> Because global_zone_page_state(NR_FREE_PAGES) relies on vmstat, which uses
> per-CPU caching, the global NR_FREE_PAGES counter can temporarily exceed
> totalram_pages() if some CPUs have flushed frees while others have pending
> allocations.
> 
> If this happens, total (which is unsigned long) underflows to a value near
> ULONG_MAX. Could this bypass the !total guard and pass a massive integer
> to mult_frac(), which then incorrectly returns 0?

Maybe better to address correctly.  But the user impact is too trivial to block
this patch.  No blocker in my opinion.

> 
> > +	return mult_frac(thp, 10000, total);
> 
> [Severity: Medium]
> Will this overflow on 32-bit architectures?
> 
> mult_frac() evaluates the intermediate multiplication using the types of its
> arguments. Since thp is an unsigned long, evaluating thp * 10000 uses 32-bit
> arithmetic on 32-bit systems like ARM LPAE.
> 
> If the system has more than 429,496 base pages of THP (approximately 1.7GB),
> will this silently wrap around and yield drastically incorrect quota goal
> ratios?

No blocker.  Known low priority issue.

> 
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260720120140.881468-1-gutierrez.asier@huawei-partners.com?part=1
> 


Thanks,
SJ
