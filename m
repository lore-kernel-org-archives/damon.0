Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6A369975
	for <damon@lists.linux.dev>; Wed, 11 Feb 2026 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809386; cv=none; b=e4mZlxOHlCeb4329ld+3TA7vLVVRztwa0jskTIFFTmrPbo1uHBSYWPaj3UVqq6as3TD+MgGgRH9rx+QjvrbOLoFk98qqhJH/VmToBC89N+VjDGf2f4CRiY++qqqGQD67knF8twDjfgZXwF6Pp0Q4ACxh9fF80hNVW7p0ZVjLCYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809386; c=relaxed/simple;
	bh=qQ75dao/8QP8y6BEUCKfJE5b7K7qx2V4n5yfWytwK9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fXYMk6UCSwunGbzeyrrv5cKVOkXDsl8kn+qoZbfcDZ8kTvu0ejOEfU65NIVPX/VxJteoAlpATpzTtNfVkv9Jb3QbZczTAoKz5mU48gO1CZwne35Zx93rZiE9G0Nt4wsbCaLiQ5LjXzDmfF5A1AGwe/jy90CwtQTfJRWsxf22rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f9x5P4Dc3zJ46Zy;
	Wed, 11 Feb 2026 19:28:41 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 04EC94056A;
	Wed, 11 Feb 2026 19:29:42 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Feb 2026 14:29:41 +0300
Message-ID: <e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com>
Date: Wed, 11 Feb 2026 14:29:41 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260211065914.68174-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260211065914.68174-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SeongJae,

On 2/11/2026 9:59 AM, SeongJae Park wrote:
> On Mon, 2 Feb 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Overview
>> ----------
>>
>> This patch set introduces a new dynamic mechanism for detecting hot applications
>> and hot regions in those applications.
>>
>> Motivation
>> -----------
>>
>> Currently DAMON requires the system administrator to provide information about
>> which application needs to be monitored and all the parameters. Ideally this
>> should be done automatically, with minimal intervention from the system
>> administrator.
>>
>>
>> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
>> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
>> fragmentation and memory waste. For this reason, most application guides and
>> system administrators suggest to disable THP.
>>
>> We would like to detect: 1. which applications are hot in the system and 2.
>> which memory regions are hot in order to collapse those regions.
>>
>>
>> Solution
>> -----------
>>
>>      ┌────────────┐           ┌────────────┐
>>      │Damon_module│           │Task_monitor│
>>      └──────┬─────┘           └──────┬─────┘
>>             │         start          │
>>             │───────────────────────>│
>>             │                        │
>>             │                        │────┐
>>             │                        │    │ calculate task load
>>             │                        │<───┘
>>             │                        │
>>             │                        │────┐
>>             │                        │    │ sort tasks
>>             │                        │<───┘
>>             │                        │
>>             │                        │────┐
>>             │                        │    │ start kdamond for top 3 tasks
>>             │                        │<───┘
>>      ┌──────┴─────┐           ┌──────┴─────┐
>>      │Damon_module│           │Task_monitor│
>>      └────────────┘           └────────────┘
>>
>>
>> We calculate the task load base on the sum of all the utime for all the threads
>> in a given task. Once we get total utime, we use the exponential load average
>> provided by calc_load. The tasks that become cold, the kdamond will be stopped
>> for them.
>>
>> In each kdamond, we start with a high min_access value. Our goal is to find the
>> "maximum" min_access value at which point the DAMON action is applied. In each
>> cycle, if no action is applied, we lower the min_access.
>>
>> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
>> collapse synchronously and avoid polluting khugepaged and other parts of the MM
>> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
>> which needs the correct vm_flags_t set.
>>
>> Benchmark
>> -----------
>>
>> Asier Gutierrez (4):
>>    mm/damon: Generic context creation for modules
>>    mm/damon: Support for synchrounous huge pages collapse
>>    mm/damon: New module with hot application detection
>>    documentation/mm/damon: Documentation for the dynamic_hugepages 
>> module
>>
>>  .../mm/damon/dynamic_hugepages.rst (new)      | 173 ++++++
>>  include/linux/damon.h                         |   1 +
>>  mm/damon/Kconfig                              |   7 +
>>  mm/damon/Makefile                             |   1 +
>>  mm/damon/dynamic_hugepages.c (new)            | 579 ++++++++++++++++++
>>  mm/damon/lru_sort.c                           |   6 +-
>>  mm/damon/modules-common.c                     |   7 +-
>>  mm/damon/modules-common.h                     |   5 +-
>>  mm/damon/reclaim.c                            |   5 +-
>>  mm/damon/vaddr.c                              |   3 +
>>  10 files changed, 778 insertions(+), 9 deletions(-)
>>  create mode 100644 Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
>>  create mode 100644 mm/damon/dynamic_hugepages.c
> 
> By the way, I proposed [1] an LSF/MM/BPF session for access-aware THP today.  I
> also mentioned this patch series on the proposal as one of potential discussion
> topics, and Cc-ed Asier.
> 
> I just wanted to make sure that the proposal is never a sort of implicit
> request to hold the progress of this patch series.  Please continue discussions
> and revisioning of this patch series regardless of the proposed LSF/MM/BPF
> session.
> 
> [1] https://lore.kernel.org/20260211050729.69719-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Yes, I keep working on this, I haven't given up.

I was thinking about your comments and about the overall idea. When you
mentioned goals and autotuning, were you referring to DAMOS_QUOTA_USER_INPUT?
The idea was to adjust the min_nr_accesses for region and I haven't found a way
to adjust the damos_access_pattern using goals and quotas. If there is a way to
do it, it may be a good idea to reuse already existing components.

Also, I thought about moving part of the logic to user space. What do you think
if we leave the hot application detection mechanism in the user space and we
keep the THP part and autotuning in the kernel? Maybe this way we can move
forward easier and eventually merge it in the mainstream.

-- 
Asier Gutierrez
Huawei

