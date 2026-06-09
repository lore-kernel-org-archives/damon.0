Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EEC2BEC3F;
	Tue,  9 Jun 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002880; cv=none; b=hUru8ieCyc0xsLBKVqPBadC44X0obyL4pyf3WaHqwV08ALCjjfxCjSbmIiovf/skKM2K306gdE1hK5gwlUmBKh/Sz5aIUvYk+Hchh4xCnNd89kQpLAisRX4PUnaX9exHPUdLA9Uqqe4KxkO2MiEbjYoRgq+/VkcChRDi2Ji6Dfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002880; c=relaxed/simple;
	bh=RZBYwrYtz1ZhUaHDuQL4FQaIli0urWjjZhSS75oZurs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gfPM/8iLpBuBHkpFJKaLAUjEiD5+meLm4ErcxGR0cp+sk65sVHgaFWohRLT19rWQZ4qMbeBEnLfBvJM734mNHbhcNKnRaQKhu9vTIJrB3Ng8L0yCdLC35roaKJNBT9R5dbLQKCYMVt6Y4A/9+3wwaJb2860YjYeLFsH53llxvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gZQtx1XkkzJ46cJ;
	Tue,  9 Jun 2026 19:00:57 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id DBB724058B;
	Tue,  9 Jun 2026 19:01:08 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 14:01:08 +0300
Message-ID: <a834e981-c292-43c1-8f02-d581a0d0b4bc@huawei-partners.com>
Date: Tue, 9 Jun 2026 14:01:07 +0300
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
CC: <sashiko-reviews@lists.linux.dev>, <damon@lists.linux.dev>
References: <20260606001209.88310-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260606001209.88310-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/6/2026 3:12 AM, SeongJae Park wrote:
> On Fri, 5 Jun 2026 13:57:47 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>>
>>
>> On 6/4/2026 6:19 PM, sashiko-bot@kernel.org wrote:
> [...]
>>> [Severity: High]
>>> This is a pre-existing issue, but can this cause a divide by zero kernel
>>> panic?
>>>
>>> If there are no active or inactive pages, or if per-CPU vmstat counter drift
>>> evaluates total to 0, mult_frac() will divide by zero.
>> Not a bug. The system can never have 0 consumed memory.
> 
> Makes sense.
> 
>>>> +static unsigned int damos_hugepage_mem_bp(void)
>>>> +{
>>>> +	unsigned long thp, total;
>>>> +
>>>> +	thp = global_node_page_state(NR_ANON_THPS) +
>>>> +				global_node_page_state(NR_SHMEM_THPS) +
>>>> +				global_node_page_state(NR_FILE_THPS);
>>>> +	total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
>>>> +	return mult_frac(thp, 10000, total);
>>>
>>> [Severity: High]
>>> Can mult_frac() divide by zero here?
>>>
>>> If the system is highly idle or due to per-CPU vmstat counter drift, total
>>> could evaluate to exactly 0.
>> No, total can never be 0.
>>> [Severity: Medium]
>>> Is there a risk of a 32-bit overflow in this calculation?
>>>
>>> On 32-bit architectures, mult_frac() preserves types, and computing
>>> thp * 10000 could exceed the maximum unsigned long value if there are
>>> more than ~1.7 GB of THPs, producing an arbitrarily small quota target.
>>>
>> Good catch! I will cast 10000 to unsigned long to preserve the types.
> 
> But still it is 'unsigned long' that has only 32 bits on 32-bit architectures?
> So it shouldn't make any change here.  Or, am I missing something?
How about just a warning? Something like

WARN_ONCE(!IS_ENABLED(CONFIG_64BIT),
	"In 32bit systems DAMOS_QUOTA_HUGEPAGE_MEM_BP may not be accurate!\n");

> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

