Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474EB1A268
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645712; cv=none; b=q4VxI7GMD1qGWGse1b5KIXzn1HK7zDeG707ZYVU6tKpF9rJObQV40o+uwpjWbffwOgLz9aBlqXMDt8rVTx5I6HJHpSXpb0tZy/tdUjB1V+yrUD76ia8n2pWdtQy6fK2uCAfqyybvMNAUccXmvdDwt4R2MPV898Q9zloLvLwLCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645712; c=relaxed/simple;
	bh=DLhNQDF44EQaJg8dZzgekawOlilRRuGFIOAhMei+X1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMA5uK6o/i5D1RnL/7b+ZAtzvVcPLI9dif/2HR6mBVzkGHaZrfyjDRksSvBxDRtmWoO+DJ8D/+rJ3XGMgjhmpZb7ZnW7ryOUzX0XZejdOk9OxdSJue4QqkwS4xSv4f7zRgk3ntDVMPADzJQGp1LmwUXCXvrmLkCNpILIJVR2eWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSEbjmna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSEbjmna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B21F000E9;
	Fri, 10 Jul 2026 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783645710;
	bh=zGTX93OE1rrJBE/aE8PpiJAJbjH3AIwcw1LPRnFdqpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hSEbjmnaHtmzD+Mt7jRgDk+DxS2MlHeyX7q16Ml+aWc1Wb91ATh0VXzKU+VYv37Fn
	 d1CgHTIKTsxR0Rg3HC0Ua0LrFLtYvX0uc/HVF+HyuqtsWYu+W3WZLWRV+8sbcqi+7/
	 Ywq9RUq1w9rQ3qvgH8jd2+7Juf/nqiFRgvB+YCVwGVM3OHZlqJHBerjkKxAjxty9KY
	 HvuCuFYtG5qswH/Ni1JhY6EbqB9RJOBFyPrrzI9R2ITIXWnV546UH2FgN/lYERjVPg
	 tXt1L+ZPoRFtnvhB218ZyykHBDZqxWH+i9Kem39DMJWaimxkIaBtz0re0UGKJ/O2IE
	 6bYm8xP6WTLsA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 11/19] mm/damon/core: disable access monitoring when probe weights are set
Date: Thu,  9 Jul 2026 18:08:21 -0700
Message-ID: <20260710010822.112874-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710004327.054C31F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 00:43:26 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Skipping `check_accesses()` leaves `max_nr_accesses` stale or zero, permanently breaking the region merging heuristic and causing unbounded region growth.
> - [Medium] Skipping `prepare_access_checks()` leaves `r->sampling_addr` uninitialized, leading to arbitrary physical memory reads.
> - [Medium] Configuring probe weights on operations that do not support them (e.g., VADDR) breaks the monitoring context completely.
> --
> 
> --- Patch [11]: [RFC PATCH v1.3 11/19] mm/damon/core: disable access monitoring when probe weights are set ---
> commit 156f6c878eae64d06c0b181a333eb7acd3bfbbf6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: disable access monitoring when probe weights are set
>     
> When users set probe weights, they are interested in the data
> attributes.  Not necessarily they are interested in data access
> patterns.  Disable the data access monitoring in the case.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index a0e6a5129fbf3..65f91e3b58d2e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3763,17 +3763,18 @@ static int kdamond_fn(void *data)
> >  		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
> >  		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
> >  		unsigned long sample_interval = ctx->attrs.sample_interval;
> > +		bool access_check_disabled = damon_has_probe_weights(ctx);
> >  
> >  		if (kdamond_wait_activation(ctx))
> >  			break;
> >  
> > -		if (ctx->ops.prepare_access_checks)
> > +		if (!access_check_disabled && ctx->ops.prepare_access_checks)
> 
> [Severity: Medium]
> Does skipping ctx->ops.prepare_access_checks() leave the sampling_addr
> field uninitialized?
> 
> If access_check_disabled evaluates to true, prepare_access_checks() is
> skipped. The region object allocated by damon_new_region() leaves this
> field uninitialized:
> 
> mm/damon/core.c:damon_new_region() {
>     ...
>     region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
>     if (!region)
>         return NULL;
> 
>     region->ar.start = start;
>     region->ar.end = end;
>     region->nr_accesses = 0;
>     ...
> }
> 
> Then apply_probes(ctx, false, false) is called below with set_samples as
> false. Could damon_pa_apply_probes() read the uninitialized sampling_addr
> to generate a physical address, leading to arbitrary physical memory reads?

No issue.  access_check_disabled is always false for now.

> 
> >  			ctx->ops.prepare_access_checks(ctx);
> >  
> >  		kdamond_usleep(sample_interval);
> >  		ctx->passed_sample_intervals++;
> >  
> > -		if (ctx->ops.check_accesses)
> > +		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> 
> [Severity: Medium]
> Will skipping check_accesses() leave max_nr_accesses stale or zero?
> 
> If access_check_disabled is true, check_accesses() is skipped, and
> apply_probes is called with return_max_wsum as false, so its return value
> is ignored. Could this pass a stale max_nr_accesses into
> kdamond_merge_regions(), preventing adjacent regions evaluated by large
> weighted sums from ever merging and causing runaway region fragmentation?

No issue.  access_check_disabled is always false for now.

> 
> 
> [Severity: Medium]
> What happens if probe weights are configured for operations that do not
> support them?
> 
> If access_check_disabled evaluates to true because probe weights are set,
> this skips check_accesses(). Because ctx->ops.apply_probes would be NULL
> for operations like vaddr, it is also skipped.
> 
> Does damon_valid_probe_params() need to reject configurations where
> ctx->ops.apply_probes is NULL to prevent the context from silently
> skipping all data gathering?

No issue.  access_check_disabled is always false for now.  Even if it can be
true, that is the intended behavior.

> 
> >  		if (ctx->ops.apply_probes)
> >  			ctx->ops.apply_probes(ctx, false, false);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710002349.111414-1-sj@kernel.org?part=11


Thanks,
SJ
