Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A02202C5B
	for <damon@lists.linux.dev>; Thu, 10 Apr 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266512; cv=none; b=UsLQhcwLT9zwQMS2WWYxpBQ/5qhJG7ilgy+Eex34pTYV5OoyZok7lX22eoCe3nUOC5G4O9+/9X2LB8QOdMxQdOCvGqp2OS2yI+ZQGmKi7DfLlkgsL1rh8ToPXiQgA9WxeIyU1DmzLt7rLd7DdZEcov4mbJ+f5wLVmdpLGtE15+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266512; c=relaxed/simple;
	bh=wu/5OuYPREY9BZRVqMZP9wpH3SajxVHHMxqej2cdKfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S/xyRZegkgqXmaiPUuqaljcAF4rlAgWJj1sW77bddUwTwDpEPPv5Ucp76ujdSt2MClRxpnjr/y8IFjBeJB5quIuIRpWIrtRg3he6YTpn78ZGabxuk6zzrG/ZVIY9qNzO5tVJpCi2Qoxhhut4t0CHLOfZhi66zSI7heTs95CqqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZY8rt4Mr8z1f1vX;
	Thu, 10 Apr 2025 14:23:26 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F9E5140109;
	Thu, 10 Apr 2025 14:28:25 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 14:28:24 +0800
Message-ID: <75e5f32d-a824-44de-b9b0-a2d58dc2c45b@huawei.com>
Date: Thu, 10 Apr 2025 14:28:23 +0800
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
References: <20250409173639.52133-1-sj@kernel.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <20250409173639.52133-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2025/4/10 1:36, SeongJae Park 写道:
> On Wed, 9 Apr 2025 15:01:39 +0800 zuoze <zuoze1@huawei.com> wrote:
> 
>>
>>
>> 在 2025/4/9 10:50, SeongJae Park 写道:
>>> Hi Ze,
>>>
>>> On Tue, 8 Apr 2025 15:55:53 +0800 Ze Zuo <zuoze1@huawei.com> wrote:
>>>
>>>> Previously, DAMON's physical address space monitoring only supported
>>>> memory ranges below 4GB on LPAE-enabled systems. This was due to
>>>> the use of 'unsigned long' in 'struct damon_addr_range', which is
>>>> 32-bit on ARM32 even with LPAE enabled.
>>>
>>> Nice finding!
>>
>> Thank you for the kind words!
>>
>>>
>>>>
>>>> This patch modifies the data types to properly support >4GB physical
>>>> address spaces:
>>>> 1. Changes 'start' and 'end' in 'struct damon_addr_range' from
>>>>      'unsigned long' to 'unsigned long long' (u64)
>>>> 2. Updates all related arithmetic operations and comparisons
>>>> 3. Adjusts print formats from %lu to %llu where needed
>>>> 4. Maintains backward compatibility for non-LPAE systems
> [...]
>>>
>>> But, this doesn't seem like a very small and simple change.  I think we can
>>> find the best approach together, by understanding impact of this change for
>>> short term and long term.  For that, could you please also share how prevalent
>>> 32-bit ARM machines with LPAE are, and what would be your expected usage of
>>> physical address space monitoring on such machines, in both short term and long
>>> term?
>>>
>>
>> Thank you for your feedback. I agree this isn’t a simple change, and
>> the current approach might not be optimal. Let’s work together to find
>> the best solution.
>>
>> As for the prevalence of 32-bit ARM machines with LPAE, these devices
>> are still widely used in our product application. The main goal for
>> enabling DAMON on these devices is to optimize memory usage. During
>> usage, we identified this optimization point, as well as overflow issues
>> with bytes* and other reclaim statistics interfaces.
>>
>> These devices are still in frequent use, and given their large installed
>> base, they are unlikely to be replaced in the short term.
> 
> Thank you for kindly sharing these!  And I agree the devices could still be
> actively used and wouldn't be replaced in the short term.  I believe making
> DAMON supports those devices is really important.
>
> DAMON aims to support multiple address spaces that not limited to only virtual
> address spaces and physical address space but any imaginable case.  I hence
> prefer keeping DAMON core layer independent of the underlying hardware as much
> as possible.  I therefore still hope to continue using 'unsigned long'.
> 
> Of course, 'unsigned long' wouldn't fit all cases.  32-bit ARM with LPAE is a
> great real example, and there might be crazy future use case.  In other words,
> this could be identified as an issue of the operations set layer, which
> directly deals with the given address space.
> 
> I think another approach for this issue is adding a DAMON parameter, say,
> address_unit.  It will represent the factor value that need to be multiplied to
> DAMON-address to get real address on the given address space.  For example, if
> address_unit is 10 and the user sets DAMON monitoring target address range as
> 200-300, it means user wants DAMON to monitor address range 2000-3000 of the
> given address space.  The default value of the parameter would be 1, so that
> old users show no change.  32bit ARM with LPAE users would need to explicitly
> set the parameter but I believe that shouldn't be a big issue?

Regarding the address_unit approach, I have some concerns after checking
the code:

1. Scaling Factor Limitations - While the scaling factor resolves the
damon_addr_range storage issue, actual physical addresses (PAs) would
still require unsigned long long temporaries in many cases.  Different
system with varying iomem regions may require different scaling
factors, making deployment harder than a fixed maximum range.

2. Significant Code Impact & Overhead - Implementing this would require
significant changes with every PA traversal needing rescaling, which
introduces computational overhead. That said, there remains a necessity
to use unsigned long long to store certain variables in structures, such
as sampling_addr in the damon_region structure and sz_tried in the
damos_stat structure.

If I'm misunderstanding any points, please correct me, and feel free to
add any additional concerns.

As an alternative, we could adopt a pattern similar to other subsystems
(e.g., memblock, CMA, resource), which define their own address types.
For example:

  #ifdef CONFIG_PHYS_ADDR_T_64BIT
	typedef unsigned long long damon_addr_t;
  #else
	typedef unsigned long damon_addr_t;
  #endif

This approach would avoid scaling complexity while maintaining
consistency with existing mm code.

What do you think? SJ, I'm happy to help test any approach or discuss
further.

> 
> What do you think about the rough idea, Ze?  If you don't mind, I could
> implement the idea on my own and get your review/tests, or help you
> implementing it on your own.  I don't care who implements it but eagerly want
> to make DAMON supports the real use case well.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 
