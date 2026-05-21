Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED332332EA7
	for <damon@lists.linux.dev>; Thu, 21 May 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345288; cv=none; b=IFYJkRS0cO7YNXCTOFyQlWXKwFRB35KhIIYBMNBwcouhQggz8nlsJr1Swu+WyFgqY/eEiBlm3JJp6O4+T+K9yeyl3jRx8/k6RifS97p/gkrnnhzrTOpZJxyz6r5mAtFWKduC2bOA/RBKci79YaDP9Sh8xq/faDsqj4QpMSwtBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345288; c=relaxed/simple;
	bh=+WnB4n4d/R1k2+qjt1OPGPT5HCgsSMuOU/gcsBuFqLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES4RcDyMkKjbCyNfxt91WsrDXdq7Qta/qdqzpJgmpxDXATvpqt+p583XV7Z3f8kbG56tYNQlgzHS46sIusVmAehp3AIFbUCePcLTxyPEXRjHvZPJNXJ/MyVN0dqnSFxrZqb4WhmOLNNxWcfGuK1zNUivfJkpXqxX5g8A0Znbjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DzN9bGCy; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DzN9bGCy"
Message-ID: <c0476675-61d9-41f7-ba65-ae34235c8ce2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779345285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur89ku75ZWJKmpVTbs86U9XLWjlrnH1BZ/d5NAIk62s=;
	b=DzN9bGCyqIn3EqOGMgIQBd6Kw3MHrY/eD2/tFw/OeXk2bdIVn6KbE0LSi5lizi3AoXDrbf
	Bht7ks9jsFgO8hq0gk+F+sE3VV9RbLJ6o8f+gVUNR9C+X1HXgUCLXH6ifXhMTULVtSOBf+
	/s6/JIJR7zB7J9YuU90CHpJnRM06FcA=
Date: Thu, 21 May 2026 14:34:29 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/damon/core: split age==0 regions when nr_regions
 exceeds max/2
To: sashiko-reviews@lists.linux.dev
Cc: damon@lists.linux.dev
References: <20260521045236.115749-2-jiayuan.chen@linux.dev>
 <20260521052207.F01821F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521052207.F01821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/21/26 1:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `damon_split_zero_age_regions` function processes targets and regions sequentially, potentially starving later targets if the budget is exhausted early.
> - [Medium] The calculation of `sz_sub` can overflow on 32-bit architectures for large regions, resulting in incorrect sub-region sizes or failing to split.
> --
>
> commit 8c8f86e64dc7143fb89435db427efa2adca6f33c
> Author: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> mm/damon/core: split age==0 regions when nr_regions exceeds max/2
>
> This commit modifies the region splitting logic to handle scenarios where
> the region count exceeds half the maximum limit. Instead of returning early,
> it now splits regions whose access pattern has just changed (age == 0) up
> to the remaining budget, which helps discover internal access variations in
> large regions.
>
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
> [ ... ]
>
>> +static void damon_split_zero_age_regions(struct damon_ctx *ctx,
>> +					 unsigned long budget)
>> +{
>> +	struct damon_target *t;
>> +	struct damon_region *r, *next;
>> +
>> +	damon_for_each_target(t, ctx) {
>> +		damon_for_each_region_safe(r, next, t) {
>> +			unsigned long sz_region, sz_sub;
>> +
>> +			if (!budget)
>> +				return;
> [Severity: Medium]
> Will this sequential processing potentially starve later targets if the
> budget is exhausted early?
>
> Since budget is a context-wide limit shared across all targets, a highly
> active first target with many zero-age regions could consume the entire
> available split budget.
>
> This might permanently prevent subsequent targets in the same context from
> refining their monitoring resolution under dynamically changing access
> patterns. Could a round-robin or proportionate distribution be used here
> instead to ensure uniform monitoring fidelity?



The budget here is not meant to be an internal fairness mechanism;
it exists so that this helper honours the operator's max_nr_regions
configuration.  max_nr_regions is the contract: under it, this
helper tries to use whatever room is left.  It does not try to
re-allocate that room across targets, and DAMON's existing
per-target split/merge loops do not do that either.

If a multi-target deployment is hitting the budget cap with
unsatisfied age==0 candidates left over, that is information about
the configuration -- max_nr_regions is undersized for the workload
the operator wants to observe -- rather than something the helper
should silently work around with a fairness policy.

Just like I mention in cover letter, we actually need expose some
metrics for observability like nr_regions


>> +			if (r->age != 0)
>> +				continue;
>> +			sz_region = damon_sz_region(r);
>> +			if (sz_region < 2 * ctx->min_region_sz)
>> +				continue;
>> +
>> +			sz_sub = ALIGN_DOWN(damon_rand(ctx, 1, 10) *
>> +					sz_region / 10, ctx->min_region_sz);
> [Severity: Medium]
> Can the calculation for sz_sub overflow on 32-bit architectures for large
> regions?
>
> Since unsigned long is 32 bits on those architectures, if sz_region is
> large (e.g., > 477 MB), multiplying it by a random value up to 9 could
> wrap around ULONG_MAX.
>
> This overflow would result in drastically smaller sub-region sizes. If the
> wrapped product divided by 10 is smaller than min_region_sz, ALIGN_DOWN
> evaluates to 0. This would trigger the blank region check below and skip
> the split entirely.
>
> Should the division occur before the multiplication to prevent this?


Well, same style as damon_split_regions_of() and we use 'if (sz_sub == 0 
|| sz_sub >= sz_region)' to protect it.

>> +			/* Do not allow blank region */
>> +			if (sz_sub == 0 || sz_sub >= sz_region)
>> +				continue;
>> +
>> +			damon_split_region_at(t, r, sz_sub);
>> +			budget--;
>> +		}
>> +	}
>> +}
