Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D93DB96B
	for <damon@lists.linux.dev>; Mon, 25 May 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696597; cv=none; b=ULbsLcXNzMpv3ZqPxBkFb5xBaiWLPO9RxJLAsQ2QnAmbEW1ko/AyHFJCtzAhRnySOmH4DTd1XkdvpmL3HvXHIKg6c54lvLCXFaCOg6nxK/GmS+m2vGxjIkXnlMvPADBhwiuyncbcmA3k6aPayYJu69IEbC4zIAmT4TPUNvfdb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696597; c=relaxed/simple;
	bh=Zh+F/Dvi7hqNMiYRpK6WtHeCQpYOBCTpLQnPvTwmLRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TltfdlNSRLjH4NjrW/rEIFmMGSuAmcad6H/V2bssmEwqpbWorpohU7OObZo80FpmpLVqNVdSWBnvyG/rc0OoP3kGrA9oWHr0D3IiG8XiTxmia6iPzqQgKefYQxAYw7GWwqfKz1ex8xWidixcWK39I6lsbWQs3iLYU5iDwL2+w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFU6eKPR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFU6eKPR"
Message-ID: <9cc396ae-da42-48ad-97d7-213208884ee5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779696593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTqKsYwKaaxYN0lSg5PLMZrGDCSmNNUCPODxwx2NeGo=;
	b=JFU6eKPRx2oxsT8Y/3a5OO+5MrgUWrWm+e7a7D+Fq3FSLTw6JCM2fbeLFJKErLr5hkwwq4
	nrP+dP4Mhon3H20MTYm7jGkur7r+xHPycPfQueaBd0XttEgtasaYiPZFdhXzzEOPisLJDn
	14xIC1g4WDNo8L0nAdYoUgmuoIBe1uE=
Date: Mon, 25 May 2026 16:09:42 +0800
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
References: <20260523014303.86907-1-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260523014303.86907-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/23/26 9:43 AM, SeongJae Park wrote:
> On Fri, 22 May 2026 23:11:47 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>> Hi, SJ
>>
>> On 5/22/26 10:42 AM, SeongJae Park wrote:
>>> On Thu, 21 May 2026 23:07:11 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>
>>>> Hi SJ,
>>>>
>>>> Thanks for taking a look.  Quick replies inline.
>>>>
>>>>
>>>> On 5/21/26 10:30 PM, SeongJae Park wrote:
>>>>> Hello Jiayuan,
>>>>>
>>>>> On Thu, 21 May 2026 12:52:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> [...]
>>>> counter was just for convenience -- easier to cat a sysfs file than to wire
>>>>
>>>> up tracing.  Even the tracepoint covers it, It's cost to much for
>>>> Grafana to just get
>>>>
>>>> a metrics by tracepoint.
> Out of the scope of this patch series, but I'm interested in how you connect
> DAMON outputs to Grafana.  I believe that could be useful for many people who
> willing to get some fleet wide access pattern.  Maybe worthy to present to
> wider audiences, like System monitoring microconf [1] at LPC?

Honestly it's nothing fancy -- we just export nr_regions as a Prometheus 
metric because it's a

performance-relevant signal.


Vsualizing access patterns is a real pain point.  I have a small 
AI-written script that pulls region

data and turns it into a webpage I can open in the browser.  It's not 
live like Grafana -- I just run it when I

want to look at the data.  I don't think Grafana has a component for 
this kind of view anyway.


>>> Makes sense.  And I think this deserves to be upstreamed.  Some minor
>>> modifications might be needed to your current implementation, though.  Please
>>> feel free to send a patch to start the discussion, if you want.
>>
>> On the sysfs counter -- agreed, same data as the tracepoint. I'll
>> look into a suitable location.
> Maybe /sys/.../schemes/<S>/tried_regions/nr_regions ?

It sounds reasonable.


>
> [...]
>>>> Yes, age == 0 means the region's access count drifted past the merge
>>>> threshold in
>>>> the last aggregation -- the strongest signal it just changed internally.
>>>> Regions with age > 0 are stable; splitting them tends to oscillate (the next
>>>> merge cycle pulls the halves back together and we waste the budget).
>>> Thank you for confirming this.  Yes, that sounds good approach to me.  But
>>> because this is a core behavior, I'd like to be careful more than usual.  I
>>> will spend more time at thinking if I'm missing something, and if this is the
>>> best approach.  If you have measurements that I asked above and can share, that
>>> will also be helpful.
>>
>> We considered selecting regions randomly past max/2 (which is what our
>> downstream tree does).
> Interesting.  Actually I was thinking something like this as a suggestion.
>
> And I understand that you had to develop and carry your downstream patches
> because DAMON was not supporting your use case.  I know carrying downstream
> patches is painful.  Sorry for the inconvenience and thank you for making this
> voice.  I'm here for users, and I will be happy to help you removing the
> downstream change.
Appreciated -- this is exactly why we want to upstream it !

>> Random selection converges to higher
>> nr_regions faster.  We picked age == 0 for upstream because:
>>
>> - It's DAMON's own signal that the region's nr_accesses just
>>     crossed the merge threshold -- i.e. the access pattern is
>>     currently unstable.  Splitting an unstable region is more likely
>>     to reveal new internal structure than splitting a stable region
>>
>> - It's selective by design, so it leans conservative on a core
>>     code path.  In our tests it still reaches the effective
>>     refinement we need (e.g. 160-180 at max_nr_regions = 200), just
>>     more gradually than random selection would.
>>
>> We thought a selective, signal-based filte.
> I understand that you concern about the increased number of regions, which
> would make the overhead greater?  I think the concern and your filtering
> approach make sense.  But the age threshold value feels like a heuristic that
> may not be good for someone.  I also think age != 0 might not always be a good
> signal for distinguising the regions.  I feel temptation to keep using the
> power of the chaos (randomness) in the regions adjustment.
>
> So I was thinking below as a suggestion.
>
> The basic idea is, choosing the number of regions to split based on the
> remaining budget (max_nr_regions - nr_regions).  I'd prefer making this simple
> and lightweight.  So suggesting something like below.
>
> void kdamond_split_regions()
> {
> 	static unsigned char rndseed;
>
> 	budget = max_nr_regions - current_nr_regions()
> 	if (budget > max_nr_regions / 2)
> 		split_step = 1
> 	elif (budget > max_nr_regions / 3)
> 		split_step = 2
> 	...
>
> 	idx = rndseed++ % split_step;
> 	for (; idx < current_nr_regions(), idx += split_step)
> 		split_region(nth_region(idx));
> }
>
> I think this might be similar to your downstream change, but what do you think,
> Jiayuan?


Yes, this is close to what we do downstream.  Roughly:

   void kdamond_split_regions()
   {
       budget = max_nr_regions - current_nr_regions()
       if (budget == 0)
           return

       split_step = current_nr_regions() / budget

       for_each_region(r)
           if (get_random_u32_below(split_step) == 0)
               split_region(r)
   }

And I like your version better -- the step formula (max/budget) leaves
a margin so it approaches max more smoothly. I'll try your approach first

and test it in our env.


> I'm also bit concerned about the fact that it would increase the number of
> regions.  However, DAMON never promised the usual number of regions will be
> around max_nr_regions / 2.  More technically speaking, the current behavior is
> that once the number of regions exceeds max_nr_regions / 2, it only slowly
> decrease.  Anyway, it is not a documented behavior.
>
> Yes, maybe some users rely on the current behavior and changing that could make
> them sad.  But I haven't heard any voice from such users.  Meanwhile Jiayuan
> and their friends are apparently being suffered by the behavior and making this
> voice.
>
> And we repeatedly told DAMON does its random evolution based on "selfish
> voices" from users.  So I think we should move based on the Jiayuan's "selfish
> voice" here.  If it really makes someone sad and if they make thier different
> "selfish voice", that's when we can discuss on different direction.  The
> someone could simply reduce max_nr_regions, or work together to make another
> knob for making the new behavior opt-in or opt-out, depending on their loudness
> of the voice.  If you rely on the current behavior, this is the best time to
> make your voice.
>
> I hope this doesn't make people get us wrong.  We care quiet users.
> Nonetheless in this case, the behavior is somewhat not documented.


Thanks for raising this openly on the list.


> [...]
>> Our downstream paddr has per-cgroup tweaks,
> Interesting!  Please consider sharing that on some conferences and/or
> upstreaming that for the community and yourself!  No push, though.
>
>> so I don't think those
>> numbers would be that meaningful for upstream review.  Here's a clean
>> upstream-paddr reproducer instead.
> [...]
>> After running for an hour:
>> 1.Without this series: nr_regions stays at ~100 (max/2), doesn't recover
>> 2.With this series:    nr_regions stays at 160-180
> Data from the real workload would be really interesting.  But this artificial
> test results also helpful.  Thank you for conducting the test and sharing
> these.
>
>> In real production this is actually pretty common.  Workloads keep
>> changing state and creating new access patterns, so nr_regions
>> naturally tends to live above max/2 most of the time -- which is
>> exactly where the corner case kicks in.  On our production box with
>> max_nr_regions = 20000, nr_regions sits at 11k-13k for long stretches
>> without ever clearing.
> Thanks for sharing these, I believe you.
>
>> ﻿Without this series the effective ceiling is just max/2.  Set max=200,
>> you cap at ~100.  Set max=400, you cap at ~200.
>>
>>
>> The 1-hour reproducer above is admittedly a bit of a toy -- I set
>> max=200 to force the corner case without having to scale up the
>> workload -- but it shows the same pattern: once nr_regions crosses
>> max/2 it just stays there.
>>
>>
>> The offline-pod example I mentioned earlier is just one workload that
>> hits this.  The mechanism isn't specific to that workload: any new
>> access pattern that shows up inside an existing region after
>> nr_regions crosses max/2 will stay invisible until something else
>> lowers nr_regions, which may never happen.
> Yes, makes sense.
>
> [1] https://lpc.events/event/20/contributions/2327/
>
>
> Thanks,
> SJ
>
> [...]
