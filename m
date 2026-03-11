Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936C234984
	for <damon@lists.linux.dev>; Wed, 11 Mar 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234623; cv=none; b=eVRzGa5oDuK7QlmTEUTbqx4dGIfTQ81GBB1PI6L5nhBPoD8bee6ZRmLR7aElps45XgDxVLZbyaPozhxryGkRSZyPfLnhXQMpAiNQTwElk8DrIPOlt7MrB+eVCqBfsRsVySVktbuZKQykIPLP2DjgvEkbFnl9Aj3tDWjylDuiwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234623; c=relaxed/simple;
	bh=jIpyGIsoDG1lT3TfEg7FFWUaB6UwY+KVWFGPdQhSK4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nBjz04HQNXZi8MOry9hSOLwEEwJ5BLPpRIzXg+LZqGU6gFWdK5xX0XhjFk5kE3SCV85dTzRnrCLxGUeokWIonK4ndMSNte8If11DegiKQ4qFiaYlmZUKXMUvP6ZTpiZGbhBI8yV/RCjVUWXiUNUDS9aYIF/mfrcqayp6bXjM/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWB1c3Kw7zHnGcW;
	Wed, 11 Mar 2026 21:10:12 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F04F4056E;
	Wed, 11 Mar 2026 21:10:20 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 16:10:19 +0300
Message-ID: <013c9fcd-bdeb-4508-8495-9ce9cd65b578@huawei-partners.com>
Date: Wed, 11 Mar 2026 16:10:19 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] mm/damon: Generic context creation for modules
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260311005759.90440-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260311005759.90440-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 3/11/2026 3:57 AM, SeongJae Park wrote:
> On Tue, 10 Mar 2026 16:24:17 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> It is more elegant to have a generic version of new context creation
>> which receives the mode as a parameter.
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
>> ---
>>  mm/damon/lru_sort.c       | 5 +++--
>>  mm/damon/modules-common.c | 6 +++---
>>  mm/damon/modules-common.h | 4 ++--
>>  mm/damon/reclaim.c        | 5 +++--
>>  4 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
>> index 7bc5c0b2aea3..143ee0b21da6 100644
>> --- a/mm/damon/lru_sort.c
>> +++ b/mm/damon/lru_sort.c
>> @@ -287,7 +287,8 @@ static int damon_lru_sort_apply_parameters(void)
>>  	unsigned int hot_thres, cold_thres;
>>  	int err;
>>  
>> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
>> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
>> +				DAMON_OPS_PADDR);
> 
> I like the name of the function is becoming shorter.  But I'm not happy with
> the fact the resulting calling code becomes longer.
> 
> I understand you are doing this extension because you want a version of the
> function for vaddr.  What about introducing another dedicated function, say,
> damon_modules_new_vaddr_ctx_target() ?
> 
> And you can avoid duplicates between damon_modules_new_{p,v}addr_ctx_target()
> by implementing internal function, say, damon_modules_new_ctx_target() that
> receives the damon_ops_id.  And damon_modules_new_{P,v}addr_ctx_target() will
> just wrappers of damon_modules_new_ctx_target().

Sure, I will do it.

Since this is some generic code not related to the module I am working on,
maybe I can move this to a different patch set that we can upstream. What do
you think?

> 
>>  	if (err)
>>  		return err;
>>  
>> @@ -479,7 +480,7 @@ static int __init damon_lru_sort_init(void)
>>  		err = -ENOMEM;
>>  		goto out;
>>  	}
>> -	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
>> +	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);
> 
> Ditto.
> 
>>  	if (err)
>>  		goto out;
>>  
>> diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
>> index 86d58f8c4f63..ae50b2fa3a86 100644
>> --- a/mm/damon/modules-common.c
>> +++ b/mm/damon/modules-common.c
>> @@ -14,8 +14,8 @@
>>   * @ctxp:	Pointer to save the point to the newly created context
>>   * @targetp:	Pointer to save the point to the newly created target
>>   */
>> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>> -		struct damon_target **targetp)
>> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
>> +		struct damon_target **targetp, enum damon_ops_id mode)
> 
> Nit.  I'd suggest 'ops_id' as the parameter name, instead of 'mode'.
> 
>>  {
>>  	struct damon_ctx *ctx;
>>  	struct damon_target *target;
>> @@ -24,7 +24,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>>  	if (!ctx)
>>  		return -ENOMEM;
>>  
>> -	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
>> +	if (damon_select_ops(ctx, mode)) {
>>  		damon_destroy_ctx(ctx);
>>  		return -EINVAL;
>>  	}
>> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
>> index f103ad556368..379b49c6a617 100644
>> --- a/mm/damon/modules-common.h
>> +++ b/mm/damon/modules-common.h
>> @@ -45,5 +45,5 @@
>>  	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>>  			0400);
>>  
>> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>> -		struct damon_target **targetp);
>> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
>> +		struct damon_target **targetp, enum damon_ops_id mode);
>> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
>> index 43d76f5bed44..24786a58683a 100644
>> --- a/mm/damon/reclaim.c
>> +++ b/mm/damon/reclaim.c
>> @@ -197,7 +197,8 @@ static int damon_reclaim_apply_parameters(void)
>>  	struct damos_filter *filter;
>>  	int err;
>>  
>> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
>> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
>> +				DAMON_OPS_PADDR);
>>  	if (err)
>>  		return err;
>>  
>> @@ -381,7 +382,7 @@ static int __init damon_reclaim_init(void)
>>  		err = -ENOMEM;
>>  		goto out;
>>  	}
>> -	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
>> +	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);
>>  	if (err)
>>  		goto out;
>>  
>> -- 
>> 2.43.0
> 
> 
> Thanks,
> SJ
> 

-- 
Asier Gutierrez
Huawei

