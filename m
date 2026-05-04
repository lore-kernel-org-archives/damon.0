Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C023DE424
	for <damon@lists.linux.dev>; Mon,  4 May 2026 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902773; cv=none; b=DwzQLokw6U/Y4tmhewpnJsl1sv12pe3/AasWLJDcWfq+Ie4bE6dLLcNlHVnqN9xclxC20e0b6vW91te9cy8/8RkD/3bLYdmcNo9vd4rIF0zX6gsGVLTaVAGsKAccgsseULMIPhQI2EbGWTY4dcZLSTT62j7YjlX+QhEJ7xzWWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902773; c=relaxed/simple;
	bh=cm2zwqx6hUsVELYl12wsgn/9Nrr6WcZjgIxSRDK5XRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8DvDBjo6Kpr/V74s8gVKz7n9RLd2OFjcPel3OjFy+tan90kwK3xZLc0XiUrDCrSL2wRCtsfNifsTxi3wgaq3Y4r1QgLU4rB/NhkJHLs2IWi6QvjP7+21TE9E4w32nlXWIg1d5p0cTRMrJ6DbtCQWFxXgNSBJ61Q0fr3zEDGZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g8NNZ2MJyzHnH2l;
	Mon,  4 May 2026 21:51:42 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 21B2640570;
	Mon,  4 May 2026 21:52:36 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 May 2026 16:52:02 +0300
Message-ID: <2446b1e8-2b9a-4621-bbb3-ccec0f1aa604@huawei-partners.com>
Date: Mon, 4 May 2026 16:52:01 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Introduce a huge page collapsing
 mechanism using auto tuning
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260501004148.78873-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260501004148.78873-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 5/1/2026 3:41 AM, SeongJae Park wrote:
> Hello Asier,
Hi, sorry for the delayed answer.
> 
> On Thu, 30 Apr 2026 13:41:35 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Overview
>> ================
> 
> Let's align the length of underline with the text.
> 
>>
>> This patch set introduces a new autotuning which allows to collapse
>> hot regions into hugepages.
>>
>> Motivation
>> ================
>>
>> Since TLB is a bottleneck for many systems, a way to optimize TLB
>> misses (or hits) is to use huge pages. Unfortunately, using "always"
>> in THP leads to memory fragmentation and memory waste. For this reason,
>> most application guides and system administrators suggest to disable THP.
> 
> I think the motivation should further explain why existing DAMOS features
> (access pattern-based targetting and quota auto-tuning with existing quota
> goals) are insufficient.  If that makes the text too long, I think the
> explanation for well-known THP benefit and problems can be reduced or skipped.
OK, I will elaborate it in further series.
> 
>>
>> Solution
>> ================
>>
>> A new autotuning quota goal[1], damos_get_used_hugepage_mem_bp, is
>> introduced, which checks the huge page consumption to total anonymous
>> memory consumption. This new quota mechanism reuses current autotuning
>> architecture.
> 
> The idea makes sense to me.
> 
> The name sounds bit redundant, though.  How about DAMOS_QUOTA_HUGEPAGE_BP for
> the enum, and hugeapge_bp for sysfs input?
Agree. In fact, DAMOS_QUOTA_HUGEPAGE_BP would make sense to keep it
consistent with the quota naming.
> 
>>
>> A new module is introduced to demonstrate the use of huge pages
>> collapse autotuning. The module launches a kdamond thread for a 
>> certain task provided by the user through monitored_pid module argument.
> 
> If it is only for demonstration, I think it is more fit to be a sample module
> (placed under samples/damon/).
We are testing this in a bare metal MySQL server. Maybe the description
was not the most accurate.
>>
>> This module also has a user autotuning knob which allows the user to
>> adjust the aggressiveness of page collapsing.
>>
>> Benchmarks
>> ================
>> In progress, will add them in the next RFC series.
> 
> Looking forward to!
> 
> I may request not that much test results for the quota goal.  If the module is
> not just a sample but for a real world use case, I may hope somewhat reasonable
> test resulsts.
OK, will do it.
>>
>> TODO
>> ================
>>
>> - Since DAMOS_COLLAPSE is not in upstream and this is just a
>>   RFC, I have used DAMOS_HUGEPAGE instead. This will change
>>   to DAMOS_COLLAPSE in future series.
> 
> It is now in mm-new and it is recommended to use it as a baseline for DAMON
> patches.  So please feel free to use DAMOS_COLLAPSE from the next version,
> unless there is a reason to worry if DAMOS_COLLAPSE will be dropped from
> mm-new.
Thanks.
>>
>> Patches Sequence
>> ================
>> Patch 1 -> damon_modules_new_vaddr_ctx_target
>> Patch 2 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
>> Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
>>            and the new VADDR ctx creation
>> Patch 4 -> Documentation
>>
>> [1] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com
> 
> Adding more context about what this link is would be nice.  I can find the link
> marker from the above text, but I was unable to expect what this is without
> opening the link.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

