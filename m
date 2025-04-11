Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AA1F0996
	for <damon@lists.linux.dev>; Fri, 11 Apr 2025 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353047; cv=none; b=ciZWWBY6I0Gmm56DFSXbAauU0seJu86H7hgHnhry2ApBiILvLdFvXzXswk0fSfzT2jq5K2hNpTxUh1f0XQ0x9BLoVSz0bDWNBnDpyGrDsBkBoViNKoD0h+F95Dw2Ra1IL0V9590Rlh6eWLJgwzIzfglMPiWLDGpA87LKHPtm084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353047; c=relaxed/simple;
	bh=br543M2/Kkr8Q0pkNJEFCwZRRP621m11fua0HpagYuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WbM62GHjreESvSsB6fu6JktU3v0vHsBObMcy8tpO84XUFlS7noWTLDCZiUMwUjLmyQC3ow91ukgPoZnTGt9D2IGP3yBPO7QsyqwXiPRrIbJTJVWjbnvEjNxhLQnl0L50kDNm6yDONHMtJBjzUv8d2olPakglK5mOVaDcC15SXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZYmxy3Q8yz1d0sk;
	Fri, 11 Apr 2025 14:29:58 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 97D291800FE;
	Fri, 11 Apr 2025 14:30:41 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 14:30:40 +0800
Message-ID: <b937014a-66ef-4648-a61d-87c61dcdb836@huawei.com>
Date: Fri, 11 Apr 2025 14:30:40 +0800
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
References: <20250410222507.56911-1-sj@kernel.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <20250410222507.56911-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2025/4/11 6:25, SeongJae Park 写道:
> On Thu, 10 Apr 2025 14:28:23 +0800 zuoze <zuoze1@huawei.com> wrote:
> 
>>
>>
>> 在 2025/4/10 1:36, SeongJae Park 写道:
>>> On Wed, 9 Apr 2025 15:01:39 +0800 zuoze <zuoze1@huawei.com> wrote:
>>>
>>>>
>>>>
>>>> 在 2025/4/9 10:50, SeongJae Park 写道:
>>>>> Hi Ze,
>>>>>
>>>>> On Tue, 8 Apr 2025 15:55:53 +0800 Ze Zuo <zuoze1@huawei.com> wrote:
>>>>>
>>>>>> Previously, DAMON's physical address space monitoring only supported
>>>>>> memory ranges below 4GB on LPAE-enabled systems. This was due to
>>>>>> the use of 'unsigned long' in 'struct damon_addr_range', which is
>>>>>> 32-bit on ARM32 even with LPAE enabled.
> [...]
>>> I think another approach for this issue is adding a DAMON parameter, say,
>>> address_unit.  It will represent the factor value that need to be multiplied to
>>> DAMON-address to get real address on the given address space.  For example, if
>>> address_unit is 10 and the user sets DAMON monitoring target address range as
>>> 200-300, it means user wants DAMON to monitor address range 2000-3000 of the
>>> given address space.  The default value of the parameter would be 1, so that
>>> old users show no change.  32bit ARM with LPAE users would need to explicitly
>>> set the parameter but I believe that shouldn't be a big issue?
>>
>> Regarding the address_unit approach, I have some concerns after checking
>> the code:
>>
>> 1. Scaling Factor Limitations - While the scaling factor resolves the
>> damon_addr_range storage issue, actual physical addresses (PAs) would
>> still require unsigned long long temporaries in many cases.
> 
> The current behavior, which is using 'unsigned long' as the type of the real
> address on DAMON operations set for physical address space (paddr), was just a
> wrong approach.  'paddr' operations set should use proper type for physical
> address, namely phys_addr_t.
>

Agreed. Using phys_addr_t for paddr is the right approach—unsigned long
was incorrect for physical addresses.

>> Different
>> system with varying iomem regions may require different scaling
>> factors, making deployment harder than a fixed maximum range.
> 
> I was thinking the user space could set the proper scaling factor.  Would it be
> challenging?
> 

Since memory ranges vary across systems, different scaling factors would
be needed. This could increase maintenance complexity.


>>
>> 2. Significant Code Impact & Overhead - Implementing this would require
>> significant changes with every PA traversal needing rescaling, which
>> introduces computational overhead.
> 
> Right, no small amount of code change will be required.  But those will be
> mostly isolated in operations set layer.
> 
> For the computational overhead, I don't expect it woudl be significant, given
> region-based controlled and minimum overhead design.
> 
> But, obviously doing some prototyping and testing first woudl give us a better
> picture >

Agreed. Some prototype testing would be helpful to evaluate overhead,
especially in extreme cases with large numbers of regions.

>> That said, there remains a necessity
>> to use unsigned long long to store certain variables in structures, such
>> as sampling_addr in the damon_region structure and sz_tried in the
>> damos_stat structure.
> 
> I want the core layer to continue using its own concpetual address type
> (unsigned long).  sampling_addr and sz_tried are core layer's concepts, so
> should continu using 'unsigned long', while operations set should convert those
> appropriately.
>  >>
>> If I'm misunderstanding any points, please correct me, and feel free to
>> add any additional concerns.
>>
>> As an alternative, we could adopt a pattern similar to other subsystems
>> (e.g., memblock, CMA, resource), which define their own address types.
> 
> The example cases directly deal with the specific address space, so their
> approaches make sense to me.  Also DAMON's operations set layer implmentation
> should also learn from them.
> 

Glad you found them helpful!

>> For example:
>>
>>    #ifdef CONFIG_PHYS_ADDR_T_64BIT
>> 	typedef unsigned long long damon_addr_t;
>>    #else
>> 	typedef unsigned long damon_addr_t;
>>    #endif
> 
> But in case of DAMON's core layer, it should deal with arbitrary address
> spaces, so I feel that might not necessarily be the only approach that we
> should use.
>

You're right, this method is not the only option.

>>
>> This approach would avoid scaling complexity while maintaining
>> consistency with existing mm code.
>>
>> What do you think? SJ, I'm happy to help test any approach or discuss
>> further.
> 
> So I still don't anticipate big problems with my proposed approach.  But only
> prototyping and testing would let us know more truth.  If you don't mind, I
> will quickly write and share a prototype of my idea so that you could test.
> 

Sounds good! Please share the prototype when ready - happy to test and
help improve it.

> 
> Thanks,
> SJ
> 
> [...]
> 
