Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758B30E832
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775199; cv=none; b=NxUlW/xUsWMVMxpb8gfZ5nDAw510AgQqztsB8legGIVg97b+91TtApOzQlePn1HXgpbx3YJlpMHufWBWFD9LsUcqBTU2FLd0MFG2qgiNSHVrl/A88g1Gfvk6HFROki7cgNqUPR71KGHBt2+7VPMC4Z4b7RSLI7/ZypQ5W5N5j6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775199; c=relaxed/simple;
	bh=zN5pZ1JqN69ANCMfbfg0AWPyJkONstkCs9JawSAoc4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FWR1/VbpuVDmi6GgE72t1uZnfHmUH++dc6NPilB4lILTrRmZ5Woi2zlKOc/pOIrnfoCXuXgLmF01kk2YejEX/2/A7EduuKwL9wQuaaaGNKHuZyBgmUDWgy1Jz/I3UO5ZgDo2cpSPpv3Yn94ADtn4shIZDJS1dKNKwcg6fXG5Pmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c717V6LmHz14MTn;
	Thu, 21 Aug 2025 19:19:50 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F296180B57;
	Thu, 21 Aug 2025 19:19:55 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 19:19:54 +0800
Message-ID: <1463effc-bb59-418a-ad9a-8c30784279df@huawei.com>
Date: Thu, 21 Aug 2025 19:19:53 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH mm-next v2 00/12] mm/damon: support ARM32 with LPAE
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250820222302.88000-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250820222302.88000-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/21 6:23, SeongJae Park 写道:
> On Wed, 20 Aug 2025 16:06:10 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> Previously, DAMON's physical address space monitoring only supported
>> memory ranges below 4GB on LPAE-enabled systems. This was due to
>> the use of 'unsigned long' in 'struct damon_addr_range', which is
>> 32-bit on ARM32 even with LPAE enabled[1].
>>
>> To add DAMON support for ARM32 with LPAE enabled, a new core layer
>> parameter called 'addr_unit' was introduced[2]. Operations set layer
>> can translate a core layer address to the real address by multiplying
>> the parameter value to the core layer address. Support of the parameter
>> is up to each operations layer implementation, though. For example,
>> operations set implementations for virtual address space can simply
>> ignore the parameter. Add the support on paddr, which is the DAMON
>> operations set implementation for the physical address space, as we have
>> a clear use case for that.
>>
>> [1]https://lore.kernel.org/all/20250408075553.959388-1-zuoze1@huawei.com/
>> [2]https://lore.kernel.org/all/20250416042551.158131-1-sj@kernel.org/
>>
>> Changes in v2:
> It would be nice if you can also add the link to the previous version, e.g.,
> like the revisions history of
> https://lore.kernel.org/20250819193404.46680-1-sj@kernel.org
>
>> - set DAMOS_PAGEOUT, DAMOS_LRU_[DE]PRIO, DAMOS_MIGRATE_{HOT,COLD} and
>>    DAMOS_STAT stat in core address unit.
>> - pass ctx->min_region value to replace the original synchronization.
>> - drop the DAMOS stats type changes, keep them as 'unsigned long' type.
>> - separate add addr_unit support for DAMON_RECLAIM and LRU_SORT from
>>    this patch series.
> Thank you for continuing this work!
>
>> Quanmin Yan (2):
>>    mm/damon: add damon_ctx->min_region
>>    mm/damon/core: prevent unnecessary overflow in
>>      damos_set_effective_quota()
> I left a few comments.  In essense, let's rename min_region to min_sz_region,
> and separate the last fix from this series.
>
> Other than above, looks good overall.  I think you can drop RFC tag from the
> next version.
>
>
> Thanks,
> SJ
>
Thank you for your guidance on my work. I have published a new patch series,
please review it at [1].

[1] https://lore.kernel.org/all/20250821105159.2503894-1-yanquanmin1@huawei.com/


Best regards,
Quanmin Yan

