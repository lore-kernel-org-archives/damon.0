Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30633DA7C2;
	Tue, 16 Jun 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638393; cv=none; b=LdcRMMJ7aTD0XeByj7nKJxG31lknxGcuAa+j461BB2H/uROvIZuqPvpD4CGYBKDf2bqHroEz1pQfFsWnwItIBv1IldQQThjbBeDlGLSMqAHEbobkSZevSD/48ejUTCqt9Dm1HnnmITL+i4oUfES1i9Lr9owmtaAd3oMW7wSFYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638393; c=relaxed/simple;
	bh=wIOxoc/nrkfZr/8S6olxHLEIfSdjlm+rnSfn4jUDNoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pk7C53/0C3Phw9bjAT3JMVRkPUNwlf2I11yOrZuNWID2qz4lzWhDHTdqIXYN1VfEURmI13qQSDoFZM8Xx7UcQjW05hWWss5aLchXZaOSQfmE56EaWaKq/fDYtIAc4jpjv01hSL2UZ3DbaS1JIn82bcxdRoOJh1FRAfw0e6kv30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gfxwF0NJZzJ46Zy;
	Wed, 17 Jun 2026 03:32:45 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D419740569;
	Wed, 17 Jun 2026 03:33:08 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 22:33:08 +0300
Message-ID: <cfb6b106-dacb-4735-9a5b-472c3dcf11f0@huawei-partners.com>
Date: Tue, 16 Jun 2026 22:33:07 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260616150316.580819-2-gutierrez.asier@huawei-partners.com>
 <20260616152017.29E1C1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260616152017.29E1C1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/16/2026 6:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The `mult_frac(thp, 10000, total)` macro call silently overflows `unsigned long` on 32-bit architectures, yielding incorrect DAMOS quota metrics.
> 
> Pre-existing issues:
> - [Critical] The `damos_get_in_active_mem_bp()` function can trigger a divide-by-zero exception if there are no active and inactive LRU pages.
> --
> 
> commit 812a9d3523a15be0a409c86d1076f2098e299808
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
> 
> This commit introduces a new DAMOS quota goal metric to measure the amount
> of huge page consumption to total memory consumption ratio.
> 
> [ ... ]
> 
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 7e4b9affc5b06..b001f80681b12 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>>  	return mult_frac(inactive, 10000, total);
> 
> [Severity: Critical]
> This is a pre-existing issue, but can this divide by zero if there are no
> active and inactive LRU pages?
> 
> If a system has no active or inactive anonymous/file LRU pages (for example,
> immediately after early boot before userspace populates the LRU), total
> evaluates to exactly 0. The mult_frac macro performs division by total,
> which would trigger a divide-by-zero hardware exception.
As described in a previous patch set[1], total will never be 0, since
the module will only be enabled after the system is fully loaded.
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
> 
> [Severity: High]
> Does this calculation silently overflow unsigned long on 32-bit
> architectures?
> 
> The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Because
> thp is always less than or equal to total, thp / total evaluates to 0,
> leaving (thp * 10000) / total.
> 
> Both thp and 10000 evaluate as 32-bit unsigned long on 32-bit systems, so
> the intermediate multiplication thp * 10000 will wrap around if thp exceeds
> roughly 1.75 GB (429,496 pages). This would cause the metric to under-report
> hugepage usage.
As discussed before, we will leave this behaviour as it is.[2]
>> +}
> 

[1] https://lore.kernel.org/all/20260611152146.AD2821F00898@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260609145240.69552-1-sj@kernel.org
-- 
Asier Gutierrez
Huawei

