Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525E4C9014
	for <damon@lists.linux.dev>; Fri,  5 Jun 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657214; cv=none; b=E2vFc5xPxxoOnj/sG/fX/Y7WUV9uCGw+WndNtcVurfdvRs4kVKo+ouh4Jlaw6YjaTx8pUPAJpORrULqKJphqQydrN4n9dV9jrvbvqPNU55fHoF/P6Wpu/NkG2nh2+iF1xJ+4NOLMUmvI71Z6J6JrvRS/+lxT+E5e2t2YKB3Wjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657214; c=relaxed/simple;
	bh=X/T2gYpVQ9y+HxPv6YfBMjeGAigeiWLAELaTH967MLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hWUnnUULudhX5bIJl6Uv5qNfGwuEJOvlNjwGAbCtnbrnZoTGAP6PCu9AbK3cvAbOq0cgLmvEADCTi4PC2B1dYMZ/AFusO2mTtG9H0U8+h+vS/RsiCLu6WM1MDoKeE+YSX37x/+9SEGl0dYPXvkyyth3323LwAwqXXYHxUdOAgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWz2q2BFtzHnGkQ;
	Fri,  5 Jun 2026 18:59:15 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id A38BC40584;
	Fri,  5 Jun 2026 19:00:10 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 14:00:10 +0300
Message-ID: <cc60cd6b-d841-4b5f-b3f8-b5dd39ea5808@huawei-partners.com>
Date: Fri, 5 Jun 2026 14:00:09 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260605004422.82568-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260605004422.82568-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/5/2026 3:44 AM, SeongJae Park wrote:
> On Thu, 4 Jun 2026 15:03:34 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a
>> new DAMOS quota goal metric to measure the amount of huge
>> page consumption to total anonymous memory consumption
>> ratio.
> 
> s/anonymous// ?
> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> ---
>>  include/linux/damon.h |  1 +
>>  mm/damon/core.c       | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+)
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
> 
> On the previous revision, I suggested renaming this to
> DAMOS_QUOTA_HUGEPAGE_MEM_BP for consistency, but it didn't got your reply.
> Could I ask your opinion?
> 
> Also, I asked you to add the kernel-doc comment before dropping RFC.  I know
> you didn't drop RFC tag yet, but could you consider adding it from the next
> revision?
Sorry, missed it. I will change it.
>>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>>  };
>>  
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 9f38deddcb30..7fc7477a353a 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2536,6 +2536,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>>  	return mult_frac(inactive, 10000, total);
>>  }
>>  
>> +static unsigned int damos_hugepage_mem_bp(void)
>> +{
>> +	unsigned long thp, total;
>> +
>> +	thp = global_node_page_state(NR_ANON_THPS) +
>> +				global_node_page_state(NR_SHMEM_THPS) +
>> +				global_node_page_state(NR_FILE_THPS);
>> +	total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
>> +	return mult_frac(thp, 10000, total);
>> +}
> 
> As Sashiko also [1] commented, let's avoid divide by zero by checking if total
> is zero, before calling mult_frac().
> 
> I wouldn't mind ignoring Sashiko's 32-bit concern, but do you have any opinion?
I just answered. I can cast 10.000 to unsigned long. I don't think many people
using 32 bit systems will use over 1.6GB of huge pages, but it makes sense to
be safe anyway.
>> +
>>  static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>>  		struct damos *s, struct damos_quota_goal *goal)
>>  {
>> @@ -2567,6 +2578,9 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>>  		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
>>  				goal->nid);
>>  		break;
>> +	case DAMOS_QUOTA_HUGEPAGE:
>> +		goal->current_value = damos_hugepage_mem_bp();
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> -- 
>> 2.43.0
> 
> Other than the above comments, looks good to me overall.
> 
> [1] https://lore.kernel.org/20260604151932.93C431F00893@smtp.kernel.org
> 
> 
> Thanks,
> SJ
> 

-- 
Asier Gutierrez
Huawei

