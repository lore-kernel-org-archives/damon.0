Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E5386C39
	for <damon@lists.linux.dev>; Mon, 25 May 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717210; cv=none; b=AsOFSLXHjqNjW1TfQhjXLlQ/s1oCvd1zR08rNsTOKEyMIGgeKRY1xlnmEMbT4lVNbPUIYpI6pQzIdsDn6fO0JAcfXJPHHsreHFdz2yiNsbZ/ZNiA1Ed/nYoHdgHWqhrcB29EQ8gFoc6BhT54qMcuTohLlYIA9MsfLtNx/IWfCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717210; c=relaxed/simple;
	bh=mgrDKq0kXj0LPie0ajpXVqMcZtnkX/h4GjHWKXQpysQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mix8vgfoPKJpsRuZOwOFuO0T4Jp21grhfeoIZuzm/c2kG70/hGn4RMu4VeucnGuBWLeq3xj3TnGnu7AhczCjmp0qngco/ADH4xTKhRf+du9krRd6RSjJiDocmsPE+1F1U8M843J+GvNgVdgRSc+zMtltBLwhME3Kmf86yRr9c1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gPHPp4rvVzJ46DH;
	Mon, 25 May 2026 21:52:30 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 28FA540570;
	Mon, 25 May 2026 21:53:19 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 16:53:18 +0300
Message-ID: <a746583d-af0e-401a-b1f8-d4a0e60d5cc3@huawei-partners.com>
Date: Mon, 25 May 2026 16:53:17 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] mm/damon: Introduce a huge page collapsing
 mechanism using auto tuning
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260523171710.88918-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260523171710.88918-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 5/23/2026 8:17 PM, SeongJae Park wrote:
> On Fri, 22 May 2026 14:55:14 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Overview
>> ========
>>
>> This patch set introduces a new autotuning which allows to collapse
>> hot regions into hugepages.
> [...]
>> Solution
>> ========
>>
>> DAMON has now a way to autotune some of the variables and adjust quotas
>> automatically, so that DAMON is fired only under the right circumstances.
>> It would be nice to have something similar, but for huge pages.
> 
> Agree.
> 
>>
>> A new autotuning quota goal[2], damos_get_used_hugepage_mem_bp,
> 
> Is the name correct?  I think 'get_used_' may better to be dropped.
Let me change it for the next RFC version.
> 
>> is
>> introduced, which checks the huge page consumption to total anonymous
>> memory consumption. This new quota mechanism reuses current autotuning
>> architecture.
>>
>> A new module is introduced to demonstrate the use of huge pages
>> collapse autotuning. The goal is to collapse hot regions of a given
>> process into huge pages. The module launches a kdamond thread for a 
>> certain task provided by the user through monitored_pid module argument.
>> Hugepage goal autotuning will automatically adjust the aggressiveness
>> of hot region collapses.
> 
> Having a module for the demonstration purpose sounds good.  But, for the
> demonstration purpose, as I previousoly commented, making it as a sample module
> (put under /samples/damon/) or just drop when you drop RFC tag would be better.
> 
> Let me know if this module is aimed to be as is even after you drop RFC tag.
I'll move it to samples. I'll keep the RFC in the next version still,
so I make sure that the major details are polished before I drop RFC tag.
> 
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
>> The goal was to achieve 10% of the total memory used as hugepage.
>>
>> The table below shows the memory consumption over time. Gaps in the
>> timestamp means that no changes in the hugepage consumption happened
>> over that period of time.
>>
>> +-----------+----------------+---------------+----------------------+
>> | timestamp | anon_memory_mb | huge_pages_mb | percentage hugepage  |
>> +-----------+----------------+---------------+----------------------+
>> | 0         | 2159.761719    | 0             | 0%                   |
>> | 28        | 2177.574219    | 4             | 0%                   |
> [...]
>> | 283       | 2224.601563    | 434           | 20%                  |
>> | 284       | 2224.632813    | 450           | 20%                  |
>> +-----------+----------------+---------------+----------------------+
> 
> Thank you for sharing the test.  What about the performance?  Could you also do
> comparison of the numbers against the module disabled case, and THP disabled
> case?
Will do it.
>>
>> Eventually, the amount of huge pages reached 20%. This is consistent
>> with how quota goals autotuning work. We are more aggresive when the
>> quota is less than 10%, and less aggresive when the quota is higher.
>> At some point, the aggressiveness just fades and no more collapses
>> occur.
> 
> You are correct.  If the behavior disturbs your test, please note that we
> introduced 'temporal' quota tuner [1] to make it easier.  It is merged into
> 7.1-rc1.
> 
>>
>> TODO
>> ====
>> - Support page splitting for cold hugepages.
> 
> Sounds good!  By using two DAMOS schemes that doing collapsing and splitting, I
> think we can make more complete access-aware THP system.
My thought was to add cold page splitting as a separate RFC in the future.
>>
>> Patches Sequence
>> ================
>> Patch 1 -> damon_modules_new_vaddr_ctx_target
>> Patch 2 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
>> Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
>>            and the new VADDR ctx creation
>> Patch 4 -> Documentation
> 
> Patch 1 is only for Patch 3, right?  Let's put it just before patch 3.
> 
> [1] https://lkml.kernel.org/r/20260310010529.91162-2-sj@kernel.org
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

