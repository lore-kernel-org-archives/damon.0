Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823A315785
	for <damon@lists.linux.dev>; Fri, 12 Jun 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292984; cv=none; b=qY00XI7+AV/1Hm6xlsdmi+jwLOwwu5u/PZOPsICIAfaFdf5oW9Wpj9I2TnitukBAgpClmNWCmwJgpnk/Eh2WqV2pJON48dHUV9I4QAT1ZjS9G3qw/nfXhR9IQoQSC/APp7sTxs6vWRC5bU3vg7OHzzh95JpyTaRgcDBknn7s8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292984; c=relaxed/simple;
	bh=GlaP0P3AfV0LQbmpyjHKjMGcGwWbq/hS1UH96/1CJFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ddd5MjdZeJD09J7EFs4jlKAUsoB25ws5vQRyK97rRqbSzuiKxA477RhhnzV24NdP/rABQqdW/ffjieW9mDUMbANx2yjJz1d6g5nPhrkNfoc6tbD5GzE0wdJTiT4DUDgre2tUDCwj66Vm43TIcyDe5IdcyrhWNeP1S0hfkx1ldes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcV9l70Z2zJ4678;
	Sat, 13 Jun 2026 03:35:55 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 31BFB40570;
	Sat, 13 Jun 2026 03:36:13 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 22:36:12 +0300
Message-ID: <abc8acca-5145-4c16-aeb7-4127da234a62@huawei-partners.com>
Date: Fri, 12 Jun 2026 22:36:11 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/4] mm/damon: Introduce a huge page collapsing
 mechanism using auto tuning
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260612005631.83964-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260612005631.83964-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 6/12/2026 3:56 AM, SeongJae Park wrote:
> Hello Asier,
> 
> On Thu, 11 Jun 2026 15:02:40 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Overview
>> ========
>>
>> This patch set introduces a new autotuning which allows to collapse
>> hot regions into hugepages.
>>
>> Motivation
>> ==========
>>
>> Since TLB is a bottleneck for many systems[1], a way to optimize TLB
>> misses (or hits) is to use huge pages. Unfortunately, using "always"
>> in THP leads to memory fragmentation and memory waste. For this reason,
>> most application guides and system administrators suggest to disable THP.
>>
>> Currently DAMON has DAMOS_HUGEPAGE, DAMOS_NONHUGEPAGE and DAMOS_COLLAPSE.
>> However, there is no way to tune the settings. It will collapse all the
>> hot regions that meet the access pattern. If the server is a bare metal
>> database or big data server, this will also lead to eventual fragmentation.
>>
>> Additionally, currently THP is set globally. Ideally, there should be a
>> way to control which tasks can use huge pages.
>>
>> Solution
>> ========
>>
>> DAMON has now a way to autotune some of the variables and adjust quotas
>> automatically, so that DAMON is fired only under the right circumstances.
>> It would be nice to have something similar, but for huge pages.
>>
>> A new autotuning quota goal[2], damos_hugepage_mem_bp, is introduced,
>> which checks the huge page consumption to total memory consumption. This
>> new quota mechanism reuses current autotuning architecture.
>>
>> A new module is introduced to demonstrate the use of huge pages
>> collapse autotuning. The goal is to collapse hot regions of a given
>> process into huge pages. The module launches a kdamond thread for a
>> certain task provided by the user through monitored_pid module argument.
>> Hugepage goal autotuning will automatically adjust the aggressiveness
>> of hot region collapses.
>>
>> This module also has a user autotuning knob which allows the user to
>> adjust the aggressiveness of page collapsing.
>>
>> Benchmarks
>> ==========
>>
>> Huge page collapse autotuning was tested in a physicial machine with
>> MariaDB 10.5.29 and sysbench as the benchmark framework.
>>
>> The hugepage module was set up in the following way:
>>
>> # echo 1000 > min_age
>> # echo 1000 > quota_percentage_hugepage
>> # echo $(pidof mariadbd) > monitored_pid
>> # echo on > enabled
>>
>> The goal was to achieve 5% of the total memory used as hugepage.
>> Since the database was not very big, we may not be able to achieve
>> high amount of huge pages per total memory consumption ratio.
>>
>> The table below shows the memory consumption over time. Gaps in the
>> timestamp means that no changes in the hugepage consumption happened
>> over that period of time in MB.
>>
>> +-----------+----------------+----------------+----------------------+
>> | timestamp | total mem used | huge page used | percentage hugepage  |
>> +-----------+----------------+----------------+----------------------+
>> | 0         | 3044.988281    | 0              | 0%                   |
>> | 22        | 3160.207031    | 2              | 0.06%                |
>> | 30        | 3250.90625     | 4              | 0.12%                |
>> | 69        | 3781.238281    | 6              | 0.16%                |
>> | 71        | 3822.226563    | 8              | 0.21%                |
>> | 72        | 3846.578125    | 10             | 0.26%                |
>> | 73        | 3852.402344    | 12             | 0.31%                |
>> | 74        | 3868           | 14             | 0.36%                |
>> | 75        | 3881.84375     | 104            | 2.68%                |
>> | 275       | 4194.175781    | 106            | 2.52%                |
>> +-----------+----------------+----------------+----------------------+
>>
>> After second 275, no more pages are collapsed into hugepages
>>
>> Performance:
>> Baseline -> 18,124.1 transactions per second
>> Hugepage autotune -> 18,163.64 transactions per second
>>
>> TODO
>> ====
>> - Support page splitting for cold hugepages.
>>
>> Patches Sequence
>> ================
>> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
>> Patch 2 -> Module that demonstrates how to use
>>            DAMOS_QUOTA_HUGEPAGE_MEM_BP and DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
>> Patch 3 -> Support for DAMOS_QUOTA_HUGEPAGE_MEM_BP in sysfs-schemes
>> Patch 4 -> Documentation
>>
>> Changes from previous versions
>> ==============================
>> RFC 3[3] -> RFC 4
>>   - Simplified the module
>>   - Removed unnecessary parameters
>>   - Renamed DAMOS_QUOTA_HUGEPAGE_MEM_BP to unify the
>>     naming style
>>   - Switched to DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
>>   - Updated the documentation
>>   - Removed new interface for context creation with
>>     DAMON_OPS_VADDR
> 
> Thank you for keep revisioning this patch series!
> 
> I think now we are aligned on the overall direction of this series.  Let's add
> the new metrics with the sample module.  The sample module's overall shape and
> size looks reasonable to me.
> 
> So I think now is the time to start making this series be more seriously get
> ready for the landing.  I find some parts in commit messages and cover letter
> that not correctly updated for my feedbacks on last revision.  Particularly
> tests and future work parts,  and sample module name are not addressing my
> previous feedback.  I therefore skipping review of quite details in this
> revision instead of adding same comments again.  That could be ok for early
> stage RFC series, but let's move to the next stage.
> 
> From the next revision, could you please take more time on addressing all my
> previous comments and updating everythings including comments be consistent?
> If you have a reason to keep some of my previous comments not yet addressed for
> the next revision, it is toally fine but please clarify.
> 
> Also, I'm not sure if I asked this same question before, but ...  Could you
> please share your future plans for this specific series?  What change you want
> to further make before dropping RFC?
I will review once again all your comments.

Since we are aligned, I plan to drop the RFC tag for the next revision.

In the future, once this patch set lands in upstream, I plan to submit a new
patch set to add cold page split in the sample module, so that we can have a
full THP support.

Thanks a lot for your patience!

> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

