Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125C38425B
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785383865; cv=none; b=M/7Pn/oMGOrVLAPJ2TrRP5MdEwUaYvrJWqqydpGgdlnSpdsI8zA6Ii6Yu+XZNteAdBcFkcpzvk9TG8ImFlmxLavL7x5ZwvogqVDOBWaJF4pBXRZmrNcZm2a63mSbbZthk4oeHAIgtWdfg2K/+NiWwx79FQKSmOPU8YIK2DTwTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785383865; c=relaxed/simple;
	bh=+m8EQJqvLkZyBh1K0I17dGYihEHW8tZBm78h8WkpRTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGFweUqFGH/6AKBRq5cXomJ+k/Jp8E9fhZGfzzMzhVWzhwRsgHrhbVva8Ft7/G/FWNs/p+jBg1yNvbUW04uDJw/jgjNiHyC2rX8k+dzbsw9b560OAQMq9mPoa/1wRKcGday+9MFp6EvJowRk+XJUwjOhYN4m5cLAmUfa+pcp0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmlZ1Jrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmlZ1Jrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803CD1F000E9;
	Thu, 30 Jul 2026 03:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785383863;
	bh=dlrpJKkspfExWjO3e/JcFQpmWUDaCEy7KMU+NP52r0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmlZ1JrzuPsYvdRZukh/ah7ASQGvIJDye97dQ3t0VXUv8N1e8dPwH+juLYswqIwcD
	 p/+mgxTnhW6GalewIcs2PCIiKb3zPuyzbnvCulZVp+e1xVTlwrsKHO5EJisEQr5PFR
	 l8iUNqMtK+u1ZEY7v8X0Qid3XM3M2xTdwHP63NQJB138xP5hkvWeRcTjbqE3515tTy
	 KORDZnS5WY9COTf/3EDbMLdTihFUqJDepxjCjIqP/zsaT2IzK3qARG0HMSaX4Qzl6h
	 oEba+iZvgtde2KVSieBkj3Aut207yLXO577IV19p8ep9J27Hk9Oznyt87RpDEo7dRj
	 im5BYCCpKbVpw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Wed, 29 Jul 2026 20:57:33 -0700
Message-ID: <20260730035735.140509-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730011554.972251F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 01:15:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The newly added validation check incorrectly uses alignment macros, allowing unaligned zero-length or inverted regions to silently bypass validation.
> - [Medium] The validation check unconditionally rejects valid monitoring ranges ending near the top of the address space due to an integer overflow in the ALIGN macro.
> 
> Pre-existing issues:
> - [High] Alignment rounding combined with a flawed iteration loop creates overlapping monitoring regions from valid, non-overlapping user inputs.
> --
> 
> --- Patch [1]: [PATCH 6.12.y] mm/damon/core: validate ranges in damon_set_regions() ---
> commit b519271ef73c8bbed5092bcf809ea6bc504693b6
> Author: SJ Park <sj@kernel.org>
> Date:   Thu Jul 30 00:56:39 2026 +0000
> 
> mm/damon/core: validate ranges in damon_set_regions()
>     
> This commit attempts to validate regions in damon_set_regions() to reject 
> zero length monitoring target regions, which could previously trigger a 
> divide-by-zero or WARN_ONCE.
> 
> Link: https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7911599c37f22..7217bb2ef51ec 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -214,6 +214,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  	unsigned int i;
> >  	int err;
> >  
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=
> > +				ALIGN(ranges[i].end, DAMON_MIN_REGION))
> > +			return -EINVAL;
> > +	}
> > +
> 
> [Severity: High]
> Does this validation logic allow unaligned zero-length or inverted regions
> to bypass the check?
> 
> If a user configures an unaligned empty region (e.g., start = 4097, 
> end = 4097) via sysfs, ALIGN_DOWN evaluates to 4096 and ALIGN evaluates to
> 8192. The condition 4096 >= 8192 evaluates to false, which completely 
> bypasses the rejection of the invalid region.

Yes, and no problem.  That's the intended behavior.

> 
> [Severity: Medium]
> Will this check unconditionally reject valid monitoring ranges ending near the
> top of the address space?
> 
> If a caller specifies a monitoring region ending near ULONG_MAX, the
> ALIGN(ranges[i].end, DAMON_MIN_REGION) operation could wrap around to 0.
> This would cause the unsigned comparison ALIGN_DOWN(start) >= 0 to always
> evaluate to true, resulting in a false positive -EINVAL rejection.

Too weired user setup.  I will ignore this unless someone reports different
opinions.

> 
> [Severity: High]
> This is a pre-existing issue, but does alignment rounding combined with the
> iteration loop create overlapping monitoring regions from valid,
> non-overlapping user inputs?
> 
> mm/damon/core.c:damon_set_regions() {
>     ...
>     if (!first) {
>         /* no region intersects with this range */
>         newr = damon_new_region(
>                 ALIGN_DOWN(range->start,
>                     DAMON_MIN_REGION),
>                 ALIGN(range->end, DAMON_MIN_REGION));
>         if (!newr)
>             return -ENOMEM;
>         damon_insert_region(newr, damon_prev_region(r), r, t);
>     } else {
>     ...
> }
> 
> If a user configures adjacent, non-overlapping unaligned ranges (e.g., 
> start = 0, end = 4097 and start = 4098, end = 8192), ALIGN_DOWN and ALIGN 
> expand these to [0, 8192] and [4096, 8192], which overlap.

In the case, the overlapping regions check at the beginning of the function
should returned an error.

> 
> Furthermore, because the loop cursor is not reset, intersection checks are 
> skipped for subsequent ranges once the list end is reached. Could this cause 
> these overlapping regions to be blindly inserted, potentially corrupting 
> core data structures?

So this couldn't happen.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260730005639.108842-1-sj@kernel.org?part=1


Thanks,
SJ
