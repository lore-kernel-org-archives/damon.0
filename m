Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BF381B0B
	for <damon@lists.linux.dev>; Thu, 12 Mar 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326564; cv=none; b=DDGCenXHlkKsI6Apd1D1919vEcQofBtqC/V2Kff5HNIPcjKyXWES7KlLYbFQf4Q3r/B0M0WcME5qozqpNBU2oq5ZnTvyeGPGSRD046INxRz7vQaClzWro7ItvkKQjCNRuSWPnSPO3efg8XVoo/69iVdag3j0RQ6WzPEdnUS+P3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326564; c=relaxed/simple;
	bh=0UpLhWykjm10D/Ar7bOuz4aptpQru8rZuqJHD6OldOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b+Kj0OSeRmN7CkGWJGtiroD2Gnn4Mu3clkeoE1gAJSt/fg1JeI3VfJV7GTKiLFA/9Mln8yt01RAZfIBJVoa2lesp+2HiFcQtI1Ob5YRJSIiJs4k59MArgW1OrvzYDV+uQk1hkspvxGIQBRJFeJJiV80xaSMNLkzevclqVWkr0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWr1b0B1FzHnGd2;
	Thu, 12 Mar 2026 22:42:27 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D017E4056B;
	Thu, 12 Mar 2026 22:42:36 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Mar 2026 17:42:36 +0300
Message-ID: <2a6c346e-6604-407b-9d52-1cbe15486b66@huawei-partners.com>
Date: Thu, 12 Mar 2026 17:42:35 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] mm/damon: Support hot application detections
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260311143912.96834-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260311143912.96834-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 3/11/2026 5:39 PM, SeongJae Park wrote:
> On Wed, 11 Mar 2026 16:08:56 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>> Hi SeongJae,
>>
>> On 3/11/2026 8:07 AM, SeongJae Park wrote:
>>> Hello Asier,
>>>
>>>
>>> Thank you for continuing this work!
>>>
>>> On Tue, 10 Mar 2026 16:24:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:
>>>
>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>>
>>>> Overview
>>>> ----------
>>>
>>> Let's make the legnth of the subject and the length of the underline same.
>>>
>>>>
>>>> This patch set introduces a new dynamic mechanism for detecting hot applications
>>>> and hot regions in those applications.
>>>
>>> Seems now you offload the hot applications detection to the user space.  If I'm
>>> not wrong, you should remove "hot applications and" on the above sentence.
>>
>> You're right. I was not sure whether changing the RFC subject was right or not.
>> I will change it for the next RFC version.
> 
> It's fine to change the subject.  Please feel free to do so in the next version
> :)
> 
>>
>>>>
>>>> Motivation
>>>> -----------
>>>>
>>>> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
>>>> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
>>>> fragmentation and memory waste. For this reason, most application guides and
>>>> system administrators suggest to disable THP.
>>>>
>>>>
>>>> Solution
>>>> -----------
>>>>
>>>> A new Linux kernel module that uses DAMON to detect hot regions and collapse
>>>> those regions into huge pages. The user supplies a set of PIDs using a module
>>>> parameter,
>>>
>>> This sounds reasonable to me.
>>>
>>>> and then, the module launches a new kdamond thread to monitor each
>>>> of the tasks.
>>>>
>>>> In each kdamond, we start with a high min_access value. Our goal is to find the
>>>> "maximum" min_access value at which point the DAMON action is applied. In each
>>>> cycle, if no action is applied, we lower the min_access.
>>>
>>> So, this patch series introduces a sort of auto-tuning of the hugepages
>>> collapse hotness threshold, that implemented in the new module.
>>>
>>> We already have a sort of DAMOS auto-tuning feature, namely goal-based DAMOS
>>> quota auto-tuning [1].  Have you considered using that?  Of course, it might
>>> not be able to be used as is.  Some extensions, e.g., introduction of new goal
>>> metric, may be needed.
>>>
>>> Yet another approach would be implementing the auto-tuning in the user-space.
>>> Because DAMON parameters can be updated online, updating the min_access from
>>> the user space should be doable?  Given the fact the module anyway require
>>> user-space control for feeding the list of applications to apply access-aware
>>> huge pages collapsing, I find no problem at user space driven auto-tuning.
>>>
>>> If the goal-based DAMOS quota auto-tuning or the user-space based auto-tuning
>>> are feasible, all the controls can be done using DAMON sysfs interface.
>>> Introduction of the new kernel module might not really be needed in the case.
>>>
>>> We have DAMON modules in addition to DAMON sysfs interface for users who want
>>> to use DAMON for a given specific use case with only minimum or near-zero
>>> user-space control.  In this case, because it is already aimed to ask the
>>> user-space to feed the list of applications to apply DAMOS-based hugepages
>>> collapsing, it seems a new module is not really needed, to me.
>>>
>>> But I guess your use case might have some special restrictions that really
>>> require use of the module instead of offloading the auto-tuning to the
>>> user-space or DAMON core.  Is that the case?  If so, can you share more details
>>> about it?
>>
>> I haven't figured out how I can use goal autotune to change the min_access.
> 
> Indeed, it is not a very straightforward feature.
> 
>> Your suggestion about moving this to the user space sound good.
> 
> If it works for you, maybe that is best for you :)
> 
>>
>> The idea was to stop lowering the min_access as soon as collapses occur,
>> since we don't want to lower so much that we start collapsing regions that
>> are not very hot.
>>
>> Maybe you can suggest a better way to do it. Maybe with autotuning.
> 
> I will add more detailed suggestion soon, by tomorrow or a day after.
> 
>>
>>>
>>>>
>>>> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
>>>> collapse synchronously and avoid polluting khugepaged and other parts of the MM
>>>> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
>>>> which needs the correct vm_flags_t set.
>>>
>>> This makes sense to me.  I expect DAMOS_COLLAPSE to have some advantages over
>>> DAMOS_HUGEPAGE for some use cases, similar to MADV_COLLAPSE vs MADV_HUGEPAGE.
>>>
>>> From my perspective, this patch series is introducing three things.
>>> 1) hugepage collapsing hotness threshold auto-tuning, 2) the module for running
>>> the auto-tuning, and 3) DAMOS_COLLAPSE.  To me, it is unclear if the first two
>>> changes are really needed.  I will wait your answer.
Yes, I tried to introduce those 3 things. The problem is that I initially found
goal autotuning quite confusing, so I kind of implemented something that behaves
like autotuning, but doesn't use DAMON's core algorithm. 
> 
>>>
>>> Meanwhile, the third change seems reasonable and not necessarily need to be
>>> blocked for the other two changes.  I think separating the third change from
>>> this patch series and upstreaming it first could also be a path forward.
>>> Because the change is simple and sound, convincing me would be easy.  I'd be
>>> convinced if at least some reasonable test results can be shown.  I'm not
>>> saying we should drop the other two changes.  We can keep discussing those in
>>> parallel.  Rather, upstreaming the third change first could help finding real
>>> benefits of the other two changes, since the testing will be easier.  The
>>> decision is up to Asier, of course.  I'm just sharing my two cents.
> 
> I'm also curious what you think about this.

Sure, we can upstream the third change. I will prepare a new patch for with just
that diff.

> 
> Thanks,
> SJ
> 
> [...]
> 

The use case that I had in mind is pretty simple. Few admins use huge pages in
production, since it leads to memory fragmentation and waste. On the other hand,
amount of memory increases faster than entries in the TLB, which means more
TLB misses and more cycles waste. My goal is to balance this. Improve performance
in applications while keeping the amount of memory waste due to fragmentation to
a minimum.

Imagine a database server. The sysadmin would like to collapse only hot regions
of the database task, improving CPU utilization but without wasting too much
memory.


Today I sat down and review the damon code. Given all your feedback, I think
this I didn't use the right approach or I didn't understand you initially.
My suggestions:

1. Implement a new goal type for autotuning that uses huge pages.
2. Implement a module that uses this new goal type.

Would this make sense to you?

-- 
Asier Gutierrez
Huawei

