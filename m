Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E83AFAF9
	for <damon@lists.linux.dev>; Fri, 22 May 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462729; cv=none; b=ErEzGwnWPWsiW8eLPOSKPkIo3WlFnHEO2JVO+ejdmcbvlFyNhTztzInz1CG6KF7f/FUTDE/8q0b/5MMeYz6cRY5kODh72nRPTrjoeVu1WPrahvJO3Mbc5R8v+6peg1YfwhknhdnfHkJ8NzkXnKsTKPX2cb9L++rev0NI3fXNCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462729; c=relaxed/simple;
	bh=SlDDJdiEJzmIVPw/n9o7nd8rvPadQ2IdGw6tNLiZglQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNu/brXW2dK3SHMgMAyQoTk3nKgJxhftMh2dElyCXN5nWNsvzhvlDaYT1PGE6MYl5TxH5GWna9DAez2kzjUd7+6G7aPO2Aiht1xVPqA89SeSdq2IIMi70nB92uBRXEmAMXiBc02r0eW9K86gkj+btbxQPzsZanW77ukW1dh5FOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j2w0GEj9; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j2w0GEj9"
Message-ID: <ddc3eb87-e34f-400f-a1d1-b807b340ff33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779462721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUXJwgDldc0m2qgpCH106bKsw/W7QUvZVpUyUS1MkV0=;
	b=j2w0GEj9MyWztok5/mQWcess+NUWYjTQCjB43C6jMiiUfM6P1Cnic7q8Ggz5tGFEXtiOLd
	790HyN18nng7Kyu5sS1abWTkzlJOcoBY22HNOEvRcVq9bcpEMC4OzkSUWNXE88LzdfV543
	KapCoIvcbiia8xOD4n4LAyDTW6yiHgA=
Date: Fri, 22 May 2026 23:11:47 +0800
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
References: <20260522024228.87328-1-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260522024228.87328-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, SJ

On 5/22/26 10:42 AM, SeongJae Park wrote:
> On Thu, 21 May 2026 23:07:11 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>> Hi SJ,
>>
>> Thanks for taking a look.  Quick replies inline.
>>
>>
>> On 5/21/26 10:30 PM, SeongJae Park wrote:
>>> Hello Jiayuan,
>>>
>>> On Thu, 21 May 2026 12:52:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>
>>>> kdamond_split_regions() bails out early when nr_regions is already
>>>> above max_nr_regions / 2.  A large region that picks up new internal
>>>> variation after that point never gets split, so we lose visibility
>>>> into its hot/cold structure.
>>>>
>>>> We hit this with damon-paddr on hugepage workloads and damon-vaddr
>>>> on processes that mmap a large anonymous range.
>>>>
>>>> On our production tree we added a current_nr_regions counter (no
>>>> good upstream home for it yet, so it's not in this series).  We saw
>>>> nr_regions never getting close to max_nr_regions, and the picture of
>>>> the access pattern was too coarse.
>>> Is 'current_nr_regions' somewhat showing the number of DAMON regions?  If so,
>>> you could also get the information from nr_regions field of damon_aggregated
>>> tracepoint.  I'm wondering if you considered using that but found a problem
>>> that made you have to implement the internal change.
>>>
>>> I will be happy to help removing such downstream changes.
>>
>> Yes, same data as the nr_regions field in damon_aggregated.  The downstream
>>
>> counter was just for convenience -- easier to cat a sysfs file than to wire
>>
>> up tracing.  Even the tracepoint covers it, It's cost to much for
>> Grafana to just get
>>
>> a metrics by tracepoint.
> Makes sense.  And I think this deserves to be upstreamed.  Some minor
> modifications might be needed to your current implementation, though.  Please
> feel free to send a patch to start the discussion, if you want.


On the sysfs counter -- agreed, same data as the tracepoint. I'll
look into a suitable location.


>>
>>>> Example with max_nr_regions == 1500.  A target ends up with 799
>>>> small hot/cold regions plus one big region (an earlier merge
>>>> collapsed a uniformly-accessed range into a single piece):
>>>>
>>>> H:hot
>>>> C:cold
>>>>
>>>>         r1     r2     r3                 r800
>>>>       HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|
>>>>
>>>>       nr_regions = 800  >  max_nr_regions / 2 = 750
>>>>
>>>> Now a cold subarea shows up inside r800:
>>>>
>>>>         r1     r2     r3                 r800
>>>>       HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|
>>>>
>>>> The small regions can't merge with each other (their access counts
>>>> differ), so budget never frees up.  r800 can't be split because
>>>> nr_regions > max_nr_regions / 2 returns early.  The cold subarea
>>>> stays invisible.
>>> I agree this corner case could theoretically happen.  But, would the small
>>> regions have the current pattern forever?  On real world systems having dynamic
>>
>> I agree with the point that this is a corner case. But it's not
>> transient for us.
> Thank you for sharing this nice information.
>
>> On a production setup with max_nr_regions = 20000, nr_regions sits at
>> 11k-12k
>>
>> for extended periods. There are occasional bursts (e.g. from offline
>> pods), then things settle
>>
>> back without ever reclaiming the budget.
> Could you please clarify a little bit more?  What is the occasional bursts, and
> how offline pods contribute to that?  What "reclaiming the budget" means?
>
> Also, do you have some measurements that shows this problem and how much of it
> is removed by this series?
>
>>
>>> access pattern, I guess those small regions may not keep the shape forever, and
>>> give chance for the large region to be split.  Am I missing something?
>>>
>>> My theory also implies that this kind of situation could happen at least
>>> sometimes for temporal periods.  In other words, it could happens too
>>> frequently and too long to be problematic.  But, in the case, maybe the user
>>> could mitigate the issue by increasing the max_nr_regions.  I'm curious if you
>>> considered that direction and found a problem that I don't expect for now.
>>>
>>>> Patch 1 lets this path still split regions that just changed
>>>> (age == 0),
>>> Why 'age == 0' means it is a good candidate to split?  Because it means its
>>> access frequency is anyway unstable?  Or are there other reasons?  More
>>> clarification would be helpful.
>>
>> Yes, age == 0 means the region's access count drifted past the merge
>> threshold in
>> the last aggregation -- the strongest signal it just changed internally.
>> Regions with age > 0 are stable; splitting them tends to oscillate (the next
>> merge cycle pulls the halves back together and we waste the budget).
> Thank you for confirming this.  Yes, that sounds good approach to me.  But
> because this is a core behavior, I'd like to be careful more than usual.  I
> will spend more time at thinking if I'm missing something, and if this is the
> best approach.  If you have measurements that I asked above and can share, that
> will also be helpful.


We considered selecting regions randomly past max/2 (which is what our
downstream tree does).  Random selection converges to higher
nr_regions faster.  We picked age == 0 for upstream because:

- It's DAMON's own signal that the region's nr_accesses just
   crossed the merge threshold -- i.e. the access pattern is
   currently unstable.  Splitting an unstable region is more likely
   to reveal new internal structure than splitting a stable region

- It's selective by design, so it leans conservative on a core
   code path.  In our tests it still reaches the effective
   refinement we need (e.g. 160-180 at max_nr_regions = 200), just
   more gradually than random selection would.

We thought a selective, signal-based filte.


>>>> up to whatever budget is left under max_nr_regions.
>>>> If a split turns out useless, the next merge cycle undoes it.
>>> I'm again curious why the user cannot just increase max_nr_regions.
>> It works as a workaround, but it isn't free: higher max means more sampling
>> work and more memory,
> It would depend on the real number of distinct access patterns.  I understand
> the number is really high on your use case.  Again, if you have measurements
> and could share, that will be very helpful.
>
>> and 20000 is the ceiling we actually want to live
>> with.  Bumping to 30000 just so the splitter has room to make progress
>> between max/2 and max is wasteful -- we don't actually want to spend the
>> resources for 30000 regions.
> Makes sense.
>
>> The real issue isn't budget waste, it's that once nr_regions crosses max/2
>> the splitter has no recovery path -- it returns immediately even when
>> there's
>> variation worth refining, and merges don't help because the small regions
>> have different access counts.  nr_regions just sits between max/2 and max,
>> and new variation inside a large region goes undetected.  The patch gives
>> that path a way to keep refining within whatever budget remains, instead of
>> asking users to over-provision max.
> Yes, I agree.  Nonetheless, as I mentioned above a couple of times, if you have
> and could share measurements that showing how big the problem is and how much
> of it this change can solve will be very helpful.
>

Our downstream paddr has per-cgroup tweaks, so I don't think those
numbers would be that meaningful for upstream review.  Here's a clean
upstream-paddr reproducer instead.

paddr config:
```shell
ADMIN=/sys/kernel/mm/damon/admin

echo 1 > $ADMIN/kdamonds/nr_kdamonds
echo 1 > $ADMIN/kdamonds/0/contexts/nr_contexts
CTX=$ADMIN/kdamonds/0/contexts/0
echo paddr > $CTX/operations

# Using stress-ng for hot memory.  Walking a 256M chunk takes around
# sample=50ms, aggr=1000ms, update=1s
echo 50000     > $CTX/monitoring_attrs/intervals/sample_us
echo 1000000   > $CTX/monitoring_attrs/intervals/aggr_us
echo 1000000  > $CTX/monitoring_attrs/intervals/update_us

# Without any cap nr_regions usually settles around 300+ on this
# workload, so max=200 makes the corner case easy to hit.
echo 10   > $CTX/monitoring_attrs/nr_regions/min
echo 200 > $CTX/monitoring_attrs/nr_regions/max


echo 1 > $CTX/targets/nr_targets
echo 1 > $CTX/targets/0/regions/nr_regions
echo 0 > $CTX/targets/0/regions/0/start
# 32C 16G machine
echo $((16 * 1024 * 1024 * 1024)) > $CTX/targets/0/regions/0/end

echo 0 > $CTX/schemes/nr_schemes

echo on > $ADMIN/kdamonds/0/state
```


Workload -- cold producer first, then a few hot producers right after,
so cold and hot pages get interleaved across physical memory:
```shell
# Cold: 4 GiB mmap, touch every page once, then sleep
python3 -c '
import mmap, time
size = 4 * 1024**3
m = mmap.mmap(-1, size, mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS)
for i in range(0, size, 4096):
     m[i] = 1
print("cold allocated, sleeping")
time.sleep(86400)
' &

# Hot: 7 stress-ng instances, different vm-methods so the hot
# regions don't all look identical and merge into one
for m in walk-0a walk-1a walk-0d walk-1d incdec rand-set zero-one; do
   stress-ng --vm 4 --vm-bytes 256M --vm-method $m --vm-keep --timeout 0 &
done

```


After running for an hour:
1.Without this series: nr_regions stays at ~100 (max/2), doesn't recover
2.With this series:    nr_regions stays at 160-180

In real production this is actually pretty common.  Workloads keep
changing state and creating new access patterns, so nr_regions
naturally tends to live above max/2 most of the time -- which is
exactly where the corner case kicks in.  On our production box with
max_nr_regions = 20000, nr_regions sits at 11k-13k for long stretches
without ever clearing.

﻿Without this series the effective ceiling is just max/2.  Set max=200,
you cap at ~100.  Set max=400, you cap at ~200.


The 1-hour reproducer above is admittedly a bit of a toy -- I set
max=200 to force the corner case without having to scale up the
workload -- but it shows the same pattern: once nr_regions crosses
max/2 it just stays there.


The offline-pod example I mentioned earlier is just one workload that
hits this.  The mechanism isn't specific to that workload: any new
access pattern that shows up inside an existing region after
nr_regions crosses max/2 will stay invisible until something else
lowers nr_regions, which may never happen.

Thanks,
Jiayuan


> Thanks,
> SJ
>
> [...]
