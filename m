Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3C34EEFD
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728293; cv=none; b=HEHK7Wq/xJvA8YmMdcDb0aocN37Dd1fib0UUgNuCMuhXrHAPtfsOrpPlx8n6lXR/FvBllDEsOeIK07oc//SaZB5Ya5NxxmCMJobwGSZCwGEyh8LCdn5xyk39EURv2H0BwbQcGg8btZWRPiEc7WK8jKDmhklkJg3BLtW66KVQyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728293; c=relaxed/simple;
	bh=8+HP9PEqzlEUXNnNu0syfmWVlPtWerkcOBTp7USQPUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYznr4naFjVqZXEiR+A3XUMepOwhTZzBoOTvxmJOe+keFdE3Ok9l2vOw1B/zMfWCMnxU4+NCRq+DyAdk26k4fnGJZ0+f/ffqs2FnFSGzNPbRJ7O6wM7BXVpPBcmNgI6JsWgOxX0jLDcgHGuLehPswf5zHXPmxKUvA8nqElIvqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=bIPv4Yo2; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="bIPv4Yo2"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6VjUgTdKBXVgimfk1nhh4m7/ifjPlF14ARVQofuTq48=;
	b=bIPv4Yo2UJ4eD73IPWp/UrYfPa//ToDrTZ/AviRgkhfrLp9amqoqK+KZK8J76wrqkz9pnKzaw
	FbzKAZE9AEaDfaWWFxu2weGowjur8nTBM3ljFerX7WJJhz/BIc9xrtgmuxpQUyyIN1kj15Pq6B9
	rmTlxHJhNw+0VC305nkZ0ag=
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4wdD6N55zHnH3s;
	Wed, 22 Jul 2026 21:50:56 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 3188540572;
	Wed, 22 Jul 2026 21:51:23 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jul 2026 16:51:22 +0300
Message-ID: <1d91aa7f-1601-4cd9-8ef5-8599983bc42f@huawei-partners.com>
Date: Wed, 22 Jul 2026 16:51:22 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] mm/damon: Introduce a huge page collapsing
 mechanism using auto tuning
To: SJ Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260722134523.87856-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260722134523.87856-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 7/22/2026 4:45 PM, SJ Park wrote:
> On Mon, 20 Jul 2026 20:58:47 -0700 SJ Park <sj@kernel.org> wrote:
> 
>> Hello Asier,
>>
>> On Mon, 20 Jul 2026 12:01:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:
>>
>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>
>>> Overview
>>> ========
>>> This patch set introduces a new autotuning which allows to collapse
>>> hot regions into hugepages.
>>
>> Thank you for making this series well done like this!
>>
>> [...]
>>> Patches Sequence
>>> ================
>>> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
>>> Patch 2 -> sysfs support for the new quota goal
>>> Patch 3 -> Document hugepage_mem_bp parameter
>>
>> I'd prefer handling 'total' underflow and returning 10,000 instead of INT_MAX
>> from damos_hugepage_mem_bp() corner cases.  But definitely that is no blocker.
>> For the series,
>>
>> Reviewed-by: SJ Park <sj@kernel.org>
>>
>> This series is applied to damon/next [1] tree.  If this series is not added to
>> mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
>> to pick this.  In the case, I will update patch 1 to do what I mentioned as
>> preferred change if you don't mind.  So, no action from your side is needed for
>> now.  If it seems I also forgot doing that or you cannot wait for my action,
>> please feel free to directly ask that to Andrew.
> 
> We (mm community) now want to focus on making mm.git more stabilized and
> therefore ready for the next merge window, rather than adding more changes that
> are not really urgent.  I agree and want to help [1] that.  For the reason,
> unless Andre pick this first, I will request adding this to mm.git only after
> next -rc1 release.  Let me know if you think this is really urgent.
> 
> [1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

No problem at all. I am fine with it.

-- 
Asier Gutierrez
Huawei

