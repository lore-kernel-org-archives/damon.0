Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88252946A
	for <damon@lists.linux.dev>; Thu, 21 May 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376058; cv=none; b=RlXAtfWRSm/bsmmUppcbNd84epxANpMS3MEl5lf9I0N70TK82U2drf5orB1muAyDAHgxBsOKFswMtgwsNcbAEaXy92lExLnJ0a76IHgN08cHnjLzzGyO6Vat1+pU9eb/+88fpsvltA/t2KqFDw1EYnAbwzZkvYS3V4lRntAjl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376058; c=relaxed/simple;
	bh=FSRFoW1TPp9HE7vJl/AIsNZ0QRWYI8fjzaskZ6CEILE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hgm8UXonizcNravFmfMkzDCXv3Q0g+/sL3B5tewegiBoa0oqsfPpKemWaIlT1Cr6Wq7hxTC6vA+AginJespcCvuMeFCZ0iWxbMz66Om/8ArQqpcz02E5GZ1InSOLCQFMC6Dyp4GEy4xm7wTk3Vj1BOo5ZocSpZWsD9w+ChowRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OzXHkt8/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OzXHkt8/"
Message-ID: <26baec2e-bc11-4042-8f61-0b3f7fe1c3b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779376054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t6U7sUbXLLnWSWD5bzxxa4WJ3Sz2EB6kaUosLO82z7w=;
	b=OzXHkt8/saWAnsi37FSdploeeEyPoMcveshhbWPKLruHntyC5aLMOX3HJ+Y+faUU8ZUZI4
	WJCRftUkm3QvqyRc9/555m/0HgP0Nt3EdYUEXDSqAq1qxu7gEAsrFSgZT0WDa0AmEmZ1Hc
	of1KG9Ch+mGDwYuIH01nniroLDpJorY=
Date: Thu, 21 May 2026 23:07:11 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] mm/damon/core: detect internal variation above
 max_nr_regions/2
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Shu Anzai <shu17az@gmail.com>, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Quanmin Yan <yanquanmin1@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260521143049.82745-1-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521143049.82745-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi SJ,

Thanks for taking a look.  Quick replies inline.


On 5/21/26 10:30 PM, SeongJae Park wrote:
> Hello Jiayuan,
>
> On Thu, 21 May 2026 12:52:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>> kdamond_split_regions() bails out early when nr_regions is already
>> above max_nr_regions / 2.  A large region that picks up new internal
>> variation after that point never gets split, so we lose visibility
>> into its hot/cold structure.
>>
>> We hit this with damon-paddr on hugepage workloads and damon-vaddr
>> on processes that mmap a large anonymous range.
>>
>> On our production tree we added a current_nr_regions counter (no
>> good upstream home for it yet, so it's not in this series).  We saw
>> nr_regions never getting close to max_nr_regions, and the picture of
>> the access pattern was too coarse.
> Is 'current_nr_regions' somewhat showing the number of DAMON regions?  If so,
> you could also get the information from nr_regions field of damon_aggregated
> tracepoint.  I'm wondering if you considered using that but found a problem
> that made you have to implement the internal change.
>
> I will be happy to help removing such downstream changes.


Yes, same data as the nr_regions field in damon_aggregated.  The downstream

counter was just for convenience -- easier to cat a sysfs file than to wire

up tracing.  Even the tracepoint covers it, It's cost to much for 
Grafana to just get

a metrics by tracepoint.


>> Example with max_nr_regions == 1500.  A target ends up with 799
>> small hot/cold regions plus one big region (an earlier merge
>> collapsed a uniformly-accessed range into a single piece):
>>
>> H:hot
>> C:cold
>>
>>        r1     r2     r3                 r800
>>      HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|
>>
>>      nr_regions = 800  >  max_nr_regions / 2 = 750
>>
>> Now a cold subarea shows up inside r800:
>>
>>        r1     r2     r3                 r800
>>      HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|
>>
>> The small regions can't merge with each other (their access counts
>> differ), so budget never frees up.  r800 can't be split because
>> nr_regions > max_nr_regions / 2 returns early.  The cold subarea
>> stays invisible.
> I agree this corner case could theoretically happen.  But, would the small
> regions have the current pattern forever?  On real world systems having dynamic


I agree with the point that this is a corner case. But it's not 
transient for us.

On a production setup with max_nr_regions = 20000, nr_regions sits at 
11k-12k

for extended periods. There are occasional bursts (e.g. from offline 
pods), then things settle

back without ever reclaiming the budget.


> access pattern, I guess those small regions may not keep the shape forever, and
> give chance for the large region to be split.  Am I missing something?
>
> My theory also implies that this kind of situation could happen at least
> sometimes for temporal periods.  In other words, it could happens too
> frequently and too long to be problematic.  But, in the case, maybe the user
> could mitigate the issue by increasing the max_nr_regions.  I'm curious if you
> considered that direction and found a problem that I don't expect for now.
>
>> Patch 1 lets this path still split regions that just changed
>> (age == 0),
> Why 'age == 0' means it is a good candidate to split?  Because it means its
> access frequency is anyway unstable?  Or are there other reasons?  More
> clarification would be helpful.


Yes, age == 0 means the region's access count drifted past the merge 
threshold in
the last aggregation -- the strongest signal it just changed internally.
Regions with age > 0 are stable; splitting them tends to oscillate (the next
merge cycle pulls the halves back together and we waste the budget).

>
>> up to whatever budget is left under max_nr_regions.
>> If a split turns out useless, the next merge cycle undoes it.
> I'm again curious why the user cannot just increase max_nr_regions.

It works as a workaround, but it isn't free: higher max means more sampling
work and more memory, and 20000 is the ceiling we actually want to live
with.  Bumping to 30000 just so the splitter has room to make progress
between max/2 and max is wasteful -- we don't actually want to spend the
resources for 30000 regions.

The real issue isn't budget waste, it's that once nr_regions crosses max/2
the splitter has no recovery path -- it returns immediately even when 
there's
variation worth refining, and merges don't help because the small regions
have different access counts.  nr_regions just sits between max/2 and max,
and new variation inside a large region goes undetected.  The patch gives
that path a way to keep refining within whatever budget remains, instead of
asking users to over-provision max.


>> Patch 2 adds a KUnit test for the case where nr_regions is already
>> above max_nr_regions / 2.
> Adding tests for new features is always nice, thank you!
>
> I will review each patch in detail after the above high level questions are
> answered.
>
>
> Thanks,
> SJ
>
> [...]
