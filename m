Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6C221F2F
	for <damon@lists.linux.dev>; Thu, 21 May 2026 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345881; cv=none; b=vCtz0NCj9aGVi/QP2gqusTGE47TiIvo8a4Y/+dse11gZ6OH8ippywG6LCNVI9HIOLWKpmkd/Dnbo22Qm3BFINs8U5AKk6vFdYXNrqpTNI/ZLCh1+rnZIriPGpeWm57UlJc5GwT7vGoH8CxRyVt5EojQjck2NApdJ8w1Xd/NGDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345881; c=relaxed/simple;
	bh=lc1YMNzoNMjCbx/5Iz/c0krE5xhhcoSlEGWo0pils1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAKOAVNHLaIaJ6m6ONYVsSWR7bpuh65Q8BtPLtguGgLviQXYId4oLXrfeaGdNBTmPscliHl+7iMZdEEAAZs0tnXkKN2aWaH+uGLKpE3Nn7ZNAgWS5zGJqtdz3FmX8qWfl//ZlX8THbnL1nPP4FXaig/Ngx3VMld3LHx4d0/EtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UQw3oCY9; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQw3oCY9"
Message-ID: <45d1800d-11ef-45bd-b1b8-5fe47dd43ee9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779345867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOG8RWXrmsyOzil0GaVKiYcE6XqHAvwUEfaPsSdr8is=;
	b=UQw3oCY9hTWn6MebhcLepoIs+UXz8MEJN2XXnkEntLT758mqXphPzUvfmujaGoDgkrYfCD
	MhL3qlQdLrG8Co0FFs7gu7f84hhCQT6/u2cley8dcLy8vsaPs4caEckystQPYe8JKSmhIC
	gXbumgf8DATEat9qQ5AR/8B1l3279Tk=
Date: Thu, 21 May 2026 14:44:24 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test split above
 max_nr_regions/2
To: sashiko-reviews@lists.linux.dev
Cc: damon@lists.linux.dev
References: <20260521045236.115749-3-jiayuan.chen@linux.dev>
 <20260521054113.AFDC61F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521054113.AFDC61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/21/26 1:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The new unit test `damon_test_split_above_half_progresses` fails to effectively test its target logic and introduces architecture-dependent flakiness due to relying on default page sizes.
> --
>
> commit 41d857e275ff50ce39c3b59f85362709927d922a
> Author: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> mm/damon/tests/core-kunit: test split above max_nr_regions/2
>
> This commit adds a kunit test to exercise kdamond_split_regions() when the
> total region count is already above max_nr_regions / 2. It asserts that the
> function can still produce new regions without overshooting the maximum
> region limit.
>
>> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
>> index 866f716e5760d..c87933c58785b 100644
>> --- a/mm/damon/tests/core-kunit.h
>> +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
>> +static void damon_test_split_above_half_progresses(struct kunit *test)
>> +{
>> +	struct damon_ctx *c;
>> +	struct damon_target *t;
>> +	struct damon_region *r, *big;
>> +	unsigned long start;
>> +	unsigned int nr_before, nr_after, i;
>> +	const unsigned int nr_small = 799;
>> +	const unsigned long small_sz = 10;
>> +	const unsigned long big_sz = 1000000;
>> +
>> +	c = damon_new_ctx();
> [Severity: Medium]
> Does this introduce a test regression on architectures with large page sizes?
>
> Because damon_new_ctx() sets c->min_region_sz to the default PAGE_SIZE,
> this test might become flaky or fail on architectures with larger pages.
>
> For example, on architectures with a 256KB page size, the random split math
> could calculate a sub-region size that aligns down to 0, which would skip
> the split. On architectures with 1MB pages, the test would deterministically
> fail because the big region size (1,000,000) is smaller than
> 2 * min_region_sz.
>
> Will this cause the KUNIT_EXPECT_GT(test, nr_after, nr_before) assertion
> below to randomly or deterministically fail since no regions will be split?
>
> [ ... ]
>> +	nr_after = damon_nr_regions(t);
>> +	KUNIT_EXPECT_GT(test, nr_after, nr_before);
>> +	KUNIT_EXPECT_LE(test, (unsigned long)nr_after,
>> +			c->attrs.max_nr_regions);
> [Severity: Medium]
> Does this test actually exercise the budget constraint logic to ensure the
> region limit isn't overshot?
>
> Since the setup only provides a single splittable "big" region, and
> damon_split_zero_age_regions() skips newly inserted regions during its
> traversal, wouldn't this only ever produce at most 1 new region before
> terminating?
>
> If it can only split once, it seems structurally impossible for the test to
> reach or exceed the remaining budget of 700 regions, which might defeat the
> stated purpose of checking if the function overshoots the limit.
>
>> +
>> +	damon_destroy_ctx(c);
>> +}


Both are valid, thanks.  I'll fold them into the respin once the series 
has been reviewed by the maintainer.

