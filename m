Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B81A9F9B
	for <damon@lists.linux.dev>; Fri, 22 Aug 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826151; cv=none; b=LSWtKe+hMGeWQ/WRjBD+nhDi3BiitvTwFX38wdJpRxDo9xv/izaNiIlo0Lv4lOnXphiwbnBxTFXdvmFqwPsS061OgjYg3nXLNGoULBo0v9LTxCwtXyHnDkt+kxSp7k3y7qEWOYY8lxUYuJQfGsm1JmhVFV8MqTESGByQ3BkWiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826151; c=relaxed/simple;
	bh=2ylFmxJx6uNEESak0nHQ8CPl0SoS2b/Sc/aQYqeFj4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ffb4avz8qeAcxgB9x7nKhpjY44GHKbVNGpRgvdHRsVFJnEz6n/WEcMrNbCc+UI7hHzPXIoK3BJoY2Ky//I2fnsv9WDnOCxBQCT9sS5S2edsUvRV7MgQcWmqTMLibqYX4eeNoZjFLfQqjTQs7klJ4uu5wfrDEh3JtNztxcIYDSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c7N0h06xzz27jH6;
	Fri, 22 Aug 2025 09:30:12 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D1E71A016C;
	Fri, 22 Aug 2025 09:29:06 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 09:29:05 +0800
Message-ID: <8b3f1571-6510-453f-96d4-f365eb10d02d@huawei.com>
Date: Fri, 22 Aug 2025 09:29:04 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] mm/damon: add damon_ctx->min_region
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250821173320.82616-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250821173320.82616-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/22 1:33, SeongJae Park 写道:
> On Thu, 21 Aug 2025 18:51:59 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
>> bytes and cause data alignment issues[1].
>>
>> Add damon_ctx->min_region to change DAMON_MIN_REGION from a global
> s/min_region/min_sz_region/ ?
>
>> macro value to per-context variable.
>>
>> [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com
>>
>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>> ---
>>   include/linux/damon.h        |  4 ++-
>>   mm/damon/core.c              | 67 ++++++++++++++++++++----------------
>>   mm/damon/sysfs.c             |  8 +++--
>>   mm/damon/tests/core-kunit.h  | 21 ++++++-----
>>   mm/damon/tests/vaddr-kunit.h |  2 +-
>>   mm/damon/vaddr.c             |  2 +-
>>   6 files changed, 61 insertions(+), 43 deletions(-)
> [...]
>> @@ -1248,6 +1253,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>>   	}
>>   	dst->ops = src->ops;
>>   	dst->addr_unit = src->addr_unit;
>> +	dst->min_sz_region = max(DAMON_MIN_REGION / src->addr_unit, 1);
> Can't we set this as src->min_sz_region?
>
> I asked a same question[1] to the previous version but seems it was missed.

I apologize for the issues caused by my misunderstanding and carelessness.
I will make adjustments and release the v2 version as soon as possible, and I
will not make similar mistakes again in the future.


Best regards,
Quanmin Yan

>
> [...]
>
> Other parts look good to me.
>
> [1] https://lore.kernel.org/20250820215612.86678-1-sj@kernel.org
>
>
> Thanks,
> SJ
