Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86223287503;
	Thu, 30 Apr 2026 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579599; cv=none; b=Yr7wOPAzbj9HE1oicJVtvBMOMA2fDTWgNOSembtlL6wZ6B1BjF09aQQsPSy7WuNuXMpT0S3HMcDLP6h7dtb86LzDJiSWpEWB4bFpTA2R5j6sIz2gOAOlQ3kQ2E3o9IjZHeTm+IAh2axdQsEMtP/jU7B7oi/4It1wq6y7toUH1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579599; c=relaxed/simple;
	bh=zNoxBTCburXCS9d/AdmfHkXW0p2pj234d135Sizl9mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRXoKNRGM7+bp31uzp17QWfOZAGrx9U1KZ3Pe0fH+Zd77i1vvwNiaCE/OO0hKJihEIRjCfPMKnMSoCHavkhdIs/DjQK43mUPAyiCrrtZjrFt3JERlIaDVGUPg6pfFz3ob6vYcL6ahLqo13BjzhbES+kxpMaZxfmGH2S84Z9u42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g64t31MWhzHnGcs;
	Fri,  1 May 2026 04:05:47 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ECE740569;
	Fri,  1 May 2026 04:06:33 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 23:06:32 +0300
Message-ID: <532603f1-4fb9-4821-ae32-cce3284c8398@huawei-partners.com>
Date: Thu, 30 Apr 2026 23:06:32 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
To: <sashiko@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260430134139.2446417-3-gutierrez.asier@huawei-partners.com>
 <20260430143108.8EEFCC2BCB3@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260430143108.8EEFCC2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/30/2026 5:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Divide-by-zero panic in damos_get_used_hugepage_mem_bp() when no anonymous memory is mapped.
> - [Medium] Missing sysfs string mapping for DAMOS_QUOTA_HUGEPAGE renders the metric unconfigurable via userspace.
> --
> 
> commit 46bdbb5e7c05e4c06aea38af1c50ac5407f8b9c3
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
> 
> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
> metric to measure the amount of huge page consumption to total anonymous
> memory consumption ratio.
> 
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 143d024fec845..ee937b3892c68 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -174,6 +174,7 @@ enum damos_quota_goal_metric {
>>  	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
>>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>> +	DAMOS_QUOTA_HUGEPAGE,
> 
> Is there a missing update to the string mapping array in sysfs for this new
> metric?
Good catch. I will fix it in the next version.
> 
> If damos_sysfs_qgoal_metric_names in mm/damon/sysfs-schemes.c isn't updated
> to include DAMOS_QUOTA_HUGEPAGE, wouldn't configuring this metric from
> userspace fail and return -EINVAL?
> 
>>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>>  };
> 
> [ ... ]
> 
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 1af84e0ac1dd4..63cbf30288d53 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
> 
> [ ... ]
> 
>> @@ -2320,6 +2320,18 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
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
> Can total_used be zero here?
> 
> If there is no anonymous memory mapped in the system (for example, right
> after boot or on a system running purely file-backed workloads), total_used
> would evaluate to 0.
> 
> Since mult_frac() directly performs division and modulo without
> zero-checking the denominator, wouldn't passing 0 as total_used trigger a
> divide-by-zero exception and crash the kernel?
>
No, the number of anonymous memory mapped in the system is always
greater than 0.
 

-- 
Asier Gutierrez
Huawei

