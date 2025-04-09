Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0469219A9E
	for <damon@lists.linux.dev>; Wed,  9 Apr 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182112; cv=none; b=gaSQDJhLluXtNE2rhZZ5hNg2KWgnSLEqYHJTcG44BwsbRmeyG7g/8zMTlUn5c4EbG7EPf7wZysgTPt7ChvK2twEddQgFd2FMa/YqJ5UMmJy8eq33XP1KSIualYvGngD5fz+K26ucxBtmPnRcQLzOyX07Iry2J+OHGcgHmT885qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182112; c=relaxed/simple;
	bh=qEXyDpV8WgexzCCVxuJ0THUirxo+mq5+vfSEG0UPfPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H2dlS3P3OwwO15dv2OE8wUsHSbvSf3vtiM+mJ+11sXtGvnRQh171xeaERhAPEDcvUuL/5Ed+D3MaoKO6GFaCvPV/nq1jXeHohlzHr/vYyPg8o45VQ4gyv2ToGr7Oi/J3xbBl8KU3ATFxNf9BuNfk5LOCpbzJZ1Hh065mqgxeXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZXYkq556jz13LQv;
	Wed,  9 Apr 2025 15:01:07 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DA5D180B4A;
	Wed,  9 Apr 2025 15:01:48 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 15:01:40 +0800
Message-ID: <0e82b335-09ce-4a0d-809e-f55405ac7953@huawei.com>
Date: Wed, 9 Apr 2025 15:01:39 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring
 above 4GB
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>
References: <20250409025036.70633-1-sj@kernel.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <20250409025036.70633-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2025/4/9 10:50, SeongJae Park 写道:
> Hi Ze,
> 
> On Tue, 8 Apr 2025 15:55:53 +0800 Ze Zuo <zuoze1@huawei.com> wrote:
> 
>> Previously, DAMON's physical address space monitoring only supported
>> memory ranges below 4GB on LPAE-enabled systems. This was due to
>> the use of 'unsigned long' in 'struct damon_addr_range', which is
>> 32-bit on ARM32 even with LPAE enabled.
> 
> Nice finding!

Thank you for the kind words!

> 
>>
>> This patch modifies the data types to properly support >4GB physical
>> address spaces:
>> 1. Changes 'start' and 'end' in 'struct damon_addr_range' from
>>     'unsigned long' to 'unsigned long long' (u64)
>> 2. Updates all related arithmetic operations and comparisons
>> 3. Adjusts print formats from %lu to %llu where needed
>> 4. Maintains backward compatibility for non-LPAE systems
>>
>> Since the overhead of always using u64 is negligible on 32-bit systems,
>> should we prefer this simplified approach over the conditional typedef?
>>
>> Alternative implementation approaches to consider:
>>
>> 1. Introduce damon_addr_t that adapts to CONFIG_PHYS_ADDR_T_64BIT
>> 2. Convert all DAMON address operations to use this type
>>
>> Just like implementation:
>>   #ifdef CONFIG_PHYS_ADDR_T_64BIT
>>      typedef unsigned long long damon_addr_t;
>>   #else
>>      typedef unsigned long damon_addr_t;
>>   #endif
>>
>> This method could potentially cause minor issues with print formatting
>> and division operations. We'd appreciate any suggestions for better
>> approaches. Thank you for your input.
>>
>> The patch change allows DAMON to work with:
>> - 32-bit ARM with LPAE (40-bit physical addresses)
>> - 64-bit ARM systems
>> - x86_64 physical address monitoring
>> while preserving existing behavior on 32-bit systems without LPAE.
> 
> Again, nice finding and good improvement.  Thank you so much for sharing this
> nice patch.
> 
> But, this doesn't seem like a very small and simple change.  I think we can
> find the best approach together, by understanding impact of this change for
> short term and long term.  For that, could you please also share how prevalent
> 32-bit ARM machines with LPAE are, and what would be your expected usage of
> physical address space monitoring on such machines, in both short term and long
> term?
> 

Thank you for your feedback. I agree this isn’t a simple change, and
the current approach might not be optimal. Let’s work together to find
the best solution.

As for the prevalence of 32-bit ARM machines with LPAE, these devices
are still widely used in our product application. The main goal for
enabling DAMON on these devices is to optimize memory usage. During
usage, we identified this optimization point, as well as overflow issues
with bytes* and other reclaim statistics interfaces.

These devices are still in frequent use, and given their large installed
base, they are unlikely to be replaced in the short term.

Thanks again for your insights. I look forward to working together to
find the best solution.


> 
> Thanks,
> SJ
> 
> [...]
> 
