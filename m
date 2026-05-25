Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573382E424F
	for <damon@lists.linux.dev>; Mon, 25 May 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721471; cv=none; b=E8bpOZSBLR/WjoRsHuO5enkST0UkAKb2yy7BaYwsGmLK7X7wUICQL6lHPS9UV4DamKCroxZtEcpZ2jz1+RRW7kJ+y51q+A+avZw0sIZCMCI1rVyA/gAkmusHx7yIP0gsx/7+0dj7RFttCZBFMvocWEbisEaFB3Pf6wHXqJ1OD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721471; c=relaxed/simple;
	bh=aNGtIik+/l1QV/Wd1Tyz33U2dax+TVVlZnmWBsQQ5G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qf8i5RcV4+Oij+N9OF62FP+T8I0MrSUWpNTnB+MMHzM4Fk+aRCEK1Jjz4RIEreaEr0IuPEZYTdwGTBS7Rd9CXjxMHSu/PESlMLyeOfoAbpwXtFrMGQoYkqjZYCJANHwScnPaW9fqtvPoqnLtvXg/RJ8ab5Y7ASBe0WrB+pyeyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gPJzs6bxRzJ467l;
	Mon, 25 May 2026 23:03:37 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 7889A4058B;
	Mon, 25 May 2026 23:04:26 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 18:04:25 +0300
Message-ID: <fd55452e-8c4c-4983-a403-bd1ab7ac73f6@huawei-partners.com>
Date: Mon, 25 May 2026 18:04:25 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260523172725.89221-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260523172725.89221-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 5/23/2026 8:27 PM, SeongJae Park wrote:
> On Fri, 22 May 2026 14:55:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
> 
> I'd suggest to rename it to DAMOS_QUOTA_HUGEPAGE_BP for consistency.
> 
> Also, you missed the ending period after 'tuning'.
> 
>> metric to measure the amount of huge page consumption to total
>> anonymous memory consumption ratio.
> 
> Why against anonymous memory only?
Well, that was my first approach. All the projects that I have done
recently were related to anonymous memory. I'll test it with total
THP user vs total memory consumption and see if everything works
in the same way.
> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> ---
>>  include/linux/damon.h |  1 +
>>  mm/damon/core.c       | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index c7a31572689b..8e15a674e893 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -177,6 +177,7 @@ enum damos_quota_goal_metric {
>>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>> +	DAMOS_QUOTA_HUGEPAGE,
>>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>>  };
> 
> Before you drop RFC tag, please ensure to add kernel-doc comment for tyhe new
> value.
I will do it. Thanks for the reminder.
>>  
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 9f38deddcb30..1f1cf10aa241 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2536,6 +2536,18 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>>  	return mult_frac(inactive, 10000, total);
>>  }
>>  
>> +/*
>> + * Returns anon hugepage memory to total anon memory use ratio.
>> + */
>> +static unsigned int damos_get_used_hugepage_mem_bp(void)
>> +{
>> +	unsigned long used_hugepages, total_used;
>> + 
>> +	used_hugepages = global_node_page_state(NR_ANON_THPS);
>> +	total_used = global_node_page_state(NR_ANON_MAPPED);
>> +	return mult_frac(used_hugepages, 10000, total_used);
> 
> So this function returns anon THP to total anon pages ratio.  Why only anon
> THP?  Also as I asked above, why only total anon?
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

