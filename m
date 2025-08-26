Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C942E1753
	for <damon@lists.linux.dev>; Tue, 26 Aug 2025 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183900; cv=none; b=ci30VcJefxYGEdpI2hkUFAwtg9KysjXyrnYqov6kLIWM3Qj6jmutpb/48l5hSt3ETrU04QBpwckHnNys0VC2l6NKN3tgmnbrHTk7OmZblqaT3/qX7YoPdwNzzsti74lFJ9yTLwaNAChuIvCU1AA5mQhQ7+ThGpKcYixC2roWHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183900; c=relaxed/simple;
	bh=TOzkz+3eBj6nlOwHuRm3lefgkGtuc/V//QAGyw+ywYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uTokIxIL3V+CuHzIIP4MKjwWAc2aV2Re7uR3hPuZXj/llsvWuEw0tmjsAKkvZT9qEiIYXNxl7+4O37+KPoSOZYcquUQfmCBhbJf3IhsGIy33BbP00W8HvPZaq1zYKCU4JW164xEHJaAoaL275VkSGXELfXiovEmFt9QUqzxJ7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c9w9p20mBzdcDr;
	Tue, 26 Aug 2025 12:46:54 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id CB6621402E9;
	Tue, 26 Aug 2025 12:51:19 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 12:51:18 +0800
Message-ID: <464f9f46-6ed5-4a78-8e06-878869f2afc4@huawei.com>
Date: Tue, 26 Aug 2025 12:51:17 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for
 DAMOS_PAGEOUT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>, <kernel-team@meta.com>,
	kernel test robot <lkp@intel.com>
References: <20250826032144.49491-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250826032144.49491-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/26 11:21, SeongJae Park 写道:
> [...]
>
>>> ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
>>>   From hackermail Thu Jan  1 00:00:00 1970
>>> From: SeongJae Park <sj@kernel.org>
>>> To: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: SeongJae Park <sj@kernel.org>
>>> Cc: damon@lists.linux.dev
>>> Cc: kernel-team@meta.com
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Date: Mon, 25 Aug 2025 07:41:33 -0700
>>> Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
>>>            return value
>>>
>>> Otherwise, __udidi3 linking problem happens on certain configs.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> ---
>>>    mm/damon/paddr.c | 14 +++++++++++++-
>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>> index 5fad2f9a99a0..09c87583af6c 100644
>>> --- a/mm/damon/paddr.c
>>> +++ b/mm/damon/paddr.c
>>> @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
>>>    	return false;
>>>    }
>>>    
>>> +/* convert physical address to core-layer address */
>>> +static unsigned long damon_pa_core_addr(phys_addr_t pa,
>>> +		unsigned long addr_unit)
>>> +{
>>> +#ifdef __i386__
>> Can we use the following condition instead?
>>
>> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
> To my understanding, this issue happens only on i386, not every 32bit
> architectures.  So I think i386 specific condition is better.

I understand. However, the aforementioned general condition is essential,
and we should propose a new patch to address this. After introducing addr_unit,
any 32-bit architecture should support monitoring of 64-bit phys_addr_t.

What do you think should be our next step? Looking forward to your reply.


Thanks,
Quanmin Yan

[...]

