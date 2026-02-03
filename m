Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFB34AB01
	for <damon@lists.linux.dev>; Tue,  3 Feb 2026 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123791; cv=none; b=FeBZu1G2wnKTs/rHxcZ2u0JZNJ+P5jdIN84rHYNKoFqokZwICDIRJG1j4SbY/CNxo/mYhdQYQ0Y+7buPpJqUTTs0+tECyIWg7XT9rGuqy7dI5HyzPff8F4nxN2NL6R/nKk/Q0TAUzpCRIXA+C4NPMZtMfClhYPZtTzHoyeiWxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123791; c=relaxed/simple;
	bh=6Oyyazb7UMzqSjIoCCcZxomuGZ6XwbJDY/r/bryd1c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kCqLdsYZ6FI2pj4tU0n/fGTz5fj852XVOZFbZgUpd4pFlaFzdBFCPDjoqMloqNwqucJ5kn+WNqamxDfWprq65QWJ7tDR40T0IJ8e0XmnOR7ZOuQRkhSx6fplMxnMzRB8TaZWUuPkEp2OxNFCuXR2WcBj+VZz/r2JXJLdq2Fqxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f53Y64lVFzJ46bg;
	Tue,  3 Feb 2026 21:02:18 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 11ECF40571;
	Tue,  3 Feb 2026 21:03:06 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Feb 2026 16:03:05 +0300
Message-ID: <56e9d735-d728-445d-9d5d-f044c9fe53b2@huawei-partners.com>
Date: Tue, 3 Feb 2026 16:03:04 +0300
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
References: <20260203011020.67357-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260203011020.67357-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SeongJae!

On 2/3/2026 4:10 AM, SeongJae Park wrote:
> Hello Asier,
> 
> 
> Thank you for sharing this nice RFC patch series!
> 
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
> 
> Sounds interesting, and this high level idea makes sense to me. :)
> 
> I'd like to further learn a few things.  Is there a reason to think the top 3
> tasks are enough number of tasks?  Also, what if a region was hot and
> successfully promoted to use huge pages, but later be cold?  Should we also
> have a DAMOS scheme for splitting such no-more-hot huge pages?

No specific reason. This was just for the RFC. We could move this to a parameter
somehow.

In case of a region turning cold, I haven't worked on it. In turning hot means
that we collapse the hot region, we should do the opposite (split) in case the
area turns cold. I haven't thought about it, but that a good catch. Thanks!

>>
>> In each kdamond, we start with a high min_access value. Our goal is to find the
>> "maximum" min_access value at which point the DAMON action is applied. In each
>> cycle, if no action is applied, we lower the min_access.
> 
> Sounds like a nice auto-tuning.  And we have DAMOS quota goal for that kind of
> auto-tuning.  Have you considered using that?
> 
>>
>> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
>> collapse synchronously and avoid polluting khugepaged and other parts of the MM
>> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
>> which needs the correct vm_flags_t set.
>>
>> Benchmark
>> -----------
> 
> Seems you forgot writing this section up.  Or, you don't have benchmark results
> yet, but only mistakenly wrote the above section header?  Either is fine, as
> this is just an RFC.  Nevertheless, test results and your expected use case of
> this patch series will be very helpful.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Sure, will add the benchmark results in the next RFC version.

-- 
Asier Gutierrez
Huawei

