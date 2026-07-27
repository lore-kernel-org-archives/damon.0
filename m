Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E63F8EA7
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150292; cv=none; b=R2iF4oBsTZ8uRm+sFNdc9zzqXrbjB0h1xaDbMk2cZoK9rJOp94PD32YLIyahai+4LfWwgGWHC3EWMwCd5dIJiOU/i3Pbo1wWZIX28cx2QO/Webvd7SLCqT5UPsc8WKUYw4bcfSJcGgcVdvA/K0ca2dYsyfEUh93fxt5iHS5Df0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150292; c=relaxed/simple;
	bh=xKTo3Nec+pj52L6yrojEcbysD2JrhxNHrJK2sZp1ssk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bD1KnyBy48F8+L6rIEJHBEABK69LDzniDZAHiRpd+yXc1C4cp29UokSfc/vAyPcMAtaqlVFC87hdNXb7psZ2DNejx/GKug7oQSVzkGt2HrRqnLATzXpUXFL7PPnVtmjIE3oA1LG+7GAleYyIL1xcwFxQ9Vc8awEobSO8+ZcWHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cfdt6Sfy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cfdt6Sfy"
Message-ID: <ca868252-8643-48de-81db-a6f6505397a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785150287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sU/EA2UJXc22ZXfuwye3gfRjPgT+tpcOl8bz1cl04W0=;
	b=Cfdt6SfyqnbCYVTeFucLmXg50LS30IT5+jiTd+NSeDOp2RckJKE1LGv4pzT9LlqP2Xav8L
	8ysoYKQwPxVBF6FSOguVrE51+o9OOZ7XeyiP2X19lmRgqoeJKGSupoSvIjj4xcIBNZSFX/
	bYUWay5mAfjKpCH4tedaAm9950b2oM0=
Date: Mon, 27 Jul 2026 19:04:32 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with
 per-range regions
To: sashiko-reviews@lists.linux.dev
Cc: damon@lists.linux.dev
References: <20260727095429.143527-1-jiayuan.chen@linux.dev>
 <20260727100731.BC8B01F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260727100731.BC8B01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/27/26 6:07 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Time-of-check to time-of-use (TOCTOU) race condition in `damon_find_system_rams()` leads to a heap out-of-bounds write during concurrent memory hotplug.
> - [High] DAMON initialization fails with `-EINVAL` on systems with sub-page System RAM gaps due to alignment overlap in `damon_set_regions()`.
> --
>
> --- Patch [1]: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with per-range regions ---
> commit 20fb01bf6e8e4cefc6016dfc073fb77c95ca3511
> Author: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> mm/damon/core: cover discrete System RAM areas with per-range regions
>
> This commit changes how DAMON sets default monitoring regions for System RAM.
> Instead of a single region covering all RAM (and the holes between), it now
> creates separate regions for each discrete System RAM area. This excludes
> large memory holes from being monitored.
>
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 644daf5a16560..365c43271c0c6 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
> [ ... ]
>
>> +static int damon_find_system_rams(struct damon_addr_range **ranges_out,
>> +				  unsigned long addr_unit)
>> +{
>> +	struct damon_system_ram_range_walk_arg arg = { .addr_unit = addr_unit };
>> +	struct damon_addr_range *ranges;
>>   
>> +	/* First pass: count the coalesced ranges. */
>>   	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
>> -	if (!arg.walked)
>> -		return false;
>> -	*start = damon_res_to_core_addr(arg.res.start, addr_unit);
>> -	*end = damon_res_to_core_addr(arg.res.end + 1, addr_unit);
>> -	if (*end <= *start)
>> -		return false;
>> -	return true;
>> +	if (!arg.nr_ranges)
>> +		return 0;
>> +	ranges = kvmalloc_objs(*ranges, arg.nr_ranges, GFP_KERNEL);
>> +	if (!ranges)
>> +		return -ENOMEM;
>> +	/* Second pass: fill in the coalesced ranges. */
>> +	arg.ranges = ranges;
>> +	arg.nr_ranges = 0;
>> +	arg.has_prev = false;
>> +	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
> [Severity: High]
> Can this race with memory hotplug events and cause an out-of-bounds write?
>
> walk_system_ram_res() is called twice without holding memory hotplug locks.
> If a new System RAM region is hotplugged between or during the second pass,
> the number of visited regions could exceed the allocated buffer size.
>
> If that happens, damon_system_ram_walk_fn() would write past the end of the
> kvmalloc-allocated buffer:
>
> mm/damon/core.c:damon_system_ram_walk_fn() {
> 	...
> 	if (a->ranges) {
> 		a->ranges[a->nr_ranges].start = start;
> 		a->ranges[a->nr_ranges].end = end;
> 	}
> 	a->nr_ranges++;
> 	...
> }

You're right. The two walk_system_ram_res() calls should be wrapped with

get_online_mems()/put_online_mems() so the resource set cannot change

between the counting and filling passes.



>> +	*ranges_out = ranges;
>> +	return arg.nr_ranges;
>>   }
> [ ... ]
>
>> @@ -3984,14 +4021,25 @@ int damon_set_region_system_rams_default(struct damon_target *t,
>>   			unsigned long addr_unit, unsigned long min_region_sz)
>>   {
>>   	struct damon_addr_range addr_range;
>> +	struct damon_addr_range *ranges;
>> +	int nr_ranges, err;
>>   
>> -	if (!*start && !*end &&
>> -		!damon_find_system_rams_range(start, end, addr_unit))
>> -		return -EINVAL;
>> +	if (*start || *end) {
>> +		addr_range.start = *start;
>> +		addr_range.end = *end;
>> +		return damon_set_regions(t, &addr_range, 1, min_region_sz);
>> +	}
>>   
>> -	addr_range.start = *start;
>> -	addr_range.end = *end;
>> -	return damon_set_regions(t, &addr_range, 1, min_region_sz);
>> +	nr_ranges = damon_find_system_rams(&ranges, addr_unit);
>> +	if (nr_ranges < 0)
>> +		return nr_ranges;
>> +	if (!nr_ranges)
>> +		return -EINVAL;
>> +	*start = ranges[0].start;
>> +	*end = ranges[nr_ranges - 1].end;
>> +	err = damon_set_regions(t, ranges, nr_ranges, min_region_sz);
> [Severity: High]
> Could this fail with -EINVAL during initialization on systems with sub-page
> memory gaps?
>
> If the system has System RAM fragmented by small non-RAM holes (like sub-page
> BIOS or EFI reserved regions), damon_system_ram_walk_fn() will create separate
> discrete regions.
>
> When these regions are passed to damon_set_regions(), it aligns the boundaries
> to min_region_sz (typically PAGE_SIZE):
>
> mm/damon/core.c:damon_set_regions() {
> 	for (i = 0; i < nr_ranges; i++) {
> 		...
> 		start = ALIGN_DOWN(ranges[i].start, min_region_sz);
> 		end = ALIGN(ranges[i].end, min_region_sz);
> 		if (start >= end)
> 			return -EINVAL;
> 		if (i > 0 && last_end > start)
> 			return -EINVAL;
> 		last_end = end;
> 	}
> 	...
> }
>
> If the gap between two RAM areas is smaller than PAGE_SIZE, the ALIGN of the
> first region's end will evaluate to a higher address than the ALIGN_DOWN of
> the second region's start. Does this cause the strictly-ascending overlap
> check (last_end > start) to trigger and reject valid configurations?


this is a real issue. I overlooked the case where System RAM boundaries 
are not page-size aligned


>> +	kvfree(ranges);
>> +	return err;
>>   }
