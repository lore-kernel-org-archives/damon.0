Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7834AAF6
	for <damon@lists.linux.dev>; Tue,  3 Feb 2026 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123864; cv=none; b=edmMS/MO+eev6YxmZw4ghxeshwtRzdQCxZ1NCT7HexZrdzhNiJ1XbT0mbaijj6QWjUqcZHuQdqRQyTFxZxTWnaNxs8r4x2hjmvt1m8T6Pt/oXqEud7exawQ5Rnsr/vHWdToddfdbhkg6HxXoWSYjngX/IVqlv+vZG2jAjvtxZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123864; c=relaxed/simple;
	bh=ZAkdo5+gAo4UDlpAU+My8dIXcxnqRPiVlM+6unQPRF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JvL+wW0MzhXTMKIQ6uCq4S1FwERplTgcmTg0WSgqAf0Xf4hcY8z8xVy1KmX5lx4o3Ij5He/IKzsRnCr8OtoYkEblmrMU6RkH2z6xLAsdl/oXZHUsS1Z8EIMsCoGpb7NgEbC7c/Ewj3T+AGNixF/TD8ZPg3/giinCK0acnES4vFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f53ZK1mvqzHnGdW;
	Tue,  3 Feb 2026 21:03:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A41F40572;
	Tue,  3 Feb 2026 21:04:20 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Feb 2026 16:04:20 +0300
Message-ID: <38d2f33e-03c1-4b33-8e0e-1a38ebbf3305@huawei-partners.com>
Date: Tue, 3 Feb 2026 16:04:19 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] mm/damon: Generic context creation for modules
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260203011633.67532-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260203011633.67532-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 2/3/2026 4:16 AM, SeongJae Park wrote:
> Let's use 'mm/damon/modules-common:' as the commit subject prefix.
> 
> On Mon, 2 Feb 2026 14:56:46 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Damon_modules_new_paddr_ctx_target. This works  only for physical contexts.
> 
> Let's be case-sensitive.  s/Damon_/damon_/ ?

OK, will do it.

> 
>> In case of virtual addresses, we should  duplicate the code.
>>
>> It is more elegant to have a generic version of new context creation which
>> receives the mode as a parameter.
> 
> Makes sense to me.
> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
>> ---
>>  mm/damon/lru_sort.c       | 6 ++++--
>>  mm/damon/modules-common.c | 7 ++++---
>>  mm/damon/modules-common.h | 5 +++--
>>  mm/damon/reclaim.c        | 5 +++--
>>  4 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
>> index 49b4bc294f4e..ac34b02dace8 100644
>> --- a/mm/damon/lru_sort.c
>> +++ b/mm/damon/lru_sort.c
>> @@ -201,7 +201,8 @@ static int damon_lru_sort_apply_parameters(void)
>>  	unsigned int hot_thres, cold_thres;
>>  	int err;
>>  
>> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
>> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
>> +				DAMON_OPS_PADDR);
>>  	if (err)
>>  		return err;
>>  
>> @@ -375,7 +376,8 @@ static int __init damon_lru_sort_init(void)
>>  		err = -ENOMEM;
>>  		goto out;
>>  	}
>> -	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
>> +	err = damon_modules_new_ctx_target(&ctx, &target,
>> +				DAMON_OPS_PADDR);
> 
> You could put the above line on the line before that without violating the 80
> columns limit :)

Sure, will correct it.

> 
>>  	if (err)
>>  		goto out;
>>  
>> diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
>> index 86d58f8c4f63..5ba24e0ad9a1 100644
>> --- a/mm/damon/modules-common.c
>> +++ b/mm/damon/modules-common.c
>> @@ -14,8 +14,9 @@
>>   * @ctxp:	Pointer to save the point to the newly created context
>>   * @targetp:	Pointer to save the point to the newly created target
>>   */
>> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>> -		struct damon_target **targetp)
>> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
>> +				struct damon_target **targetp,
>> +				enum damon_ops_id mode)
> 
> You should also update the kernel-doc comments for the new parameter.
> 
>>  {
>>  	struct damon_ctx *ctx;
>>  	struct damon_target *target;
>> @@ -24,7 +25,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>>  	if (!ctx)
>>  		return -ENOMEM;
>>  
>> -	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
>> +	if (damon_select_ops(ctx, mode)) {
>>  		damon_destroy_ctx(ctx);
>>  		return -EINVAL;
>>  	}
>> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
>> index f103ad556368..87d8058d7d85 100644
>> --- a/mm/damon/modules-common.h
>> +++ b/mm/damon/modules-common.h
>> @@ -45,5 +45,6 @@
>>  	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>>  			0400);
>>  
>> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>> -		struct damon_target **targetp);
>> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
>> +				struct damon_target **targetp,
>> +				enum damon_ops_id mode);
>> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
>> index 36a582e09eae..b64fb810e096 100644
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
>> @@ -379,7 +380,7 @@ static int __init damon_reclaim_init(void)
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
> Overall, looks good for RFC.
> 
> 
> Thanks,
> SJ
> 

-- 
Asier Gutierrez
Huawei

