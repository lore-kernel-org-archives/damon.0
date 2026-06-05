Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87D4C77CE;
	Fri,  5 Jun 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657077; cv=none; b=tykmao76N5eXa4cdTCNcXvgYwcZGka2aLnJyxuMwFcyy1GbZDdG5v3ELrEww0bhH9IYxs9a1XxGeafB/dJlknivsjv6KSIebwVxNPxeXsWyK1oyXWpykam/zf1sA34ymGkyNgdl861+/wTcEtx+/mv3nHeVqgtSmuZZLjC2/JOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657077; c=relaxed/simple;
	bh=aCv7GgXhK/6RiM3+Z0K8/ByaZk2fg9SXCuds31gdm8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=srxeRDLgHDmXlxq8MC1N73aVb96BDrVlTcieeWz4XmYHRoP0TrNE5DmrTvQK+68VjZM8aPqLtbUnNx1rz4uTK0bJ0voL43XRPGJbdpqzqWY6BdSm3Bq5f+z8QkzDCu0Ygc1eBpHAiTduRiECWhYZq5BuIjRCrL9XvVJ3uZVQjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWz05051lzHnH4p;
	Fri,  5 Jun 2026 18:56:53 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A8FB40584;
	Fri,  5 Jun 2026 18:57:48 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 13:57:47 +0300
Message-ID: <2a4665b3-ac61-4ea2-b360-5cc6c21a6606@huawei-partners.com>
Date: Fri, 5 Jun 2026 13:57:47 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260604150338.501128-2-gutierrez.asier@huawei-partners.com>
 <20260604151932.93C431F00893@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260604151932.93C431F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/4/2026 6:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] A potential division by zero in damos_hugepage_mem_bp() can cause a kernel panic if the total non-free RAM pages evaluate to 0.
> - [Medium] The new DAMOS_QUOTA_HUGEPAGE metric is inaccessible from userspace because it was not added to the sysfs mapping array damos_sysfs_qgoal_metric_names.
> - [Medium] The implementation calculates the ratio of all THP memory to total used memory, directly contradicting the commit message's claim that it measures huge page consumption relative to total anonymous memory.
> - [Medium] The calculation in mult_frac() can silently overflow a 32-bit unsigned long, resulting in arbitrarily small, incorrect quota targets.
> 
> Pre-existing issues:
> - [High] The pre-existing DAMOS_QUOTA_ACTIVE_MEM_BP and INACTIVE_MEM_BP metric computation can trigger a kernel panic via division by zero.
> --
> 
> commit 1f37bbf7381e392f999f133e0444c2faad754df9
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
> 
> This commit introduces a new DAMOS quota goal metric, DAMOS_QUOTA_HUGEPAGE,
> which is intended to measure the ratio of huge page consumption against
> total anonymous memory.
Right, the commit is outdated. I will update it to reflect the
last changes.
>> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a
>> new DAMOS quota goal metric to measure the amount of huge
>> page consumption to total anonymous memory consumption
>> ratio.
> 
> [Severity: Medium]
> Does this description match the implementation?
> 
> The commit message states this measures huge page consumption against total
> anonymous memory, but the code in damos_hugepage_mem_bp() calculates the sum
> of all transparent huge pages relative to total used memory.
As mentioned, I will update the commit message.
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 6f7edb3590ef9..d840b0bc0b953 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
> [ ... ]
>> @@ -176,6 +176,7 @@ enum damos_quota_goal_metric {
>>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>> +	DAMOS_QUOTA_HUGEPAGE,
> 
> [Severity: Medium]
> Does this new metric need to be added to damos_sysfs_qgoal_metric_names[]
> in mm/damon/sysfs-schemes.c?
> 
> Without adding it to the string mapping array, it appears this metric cannot
> be configured from userspace via sysfs.
> 
I had it a local branch. I forgot to add it to the patch series. I will do it.

>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 265d51ade25bf..71c8699bdd476 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2756,6 +2756,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>>  	return mult_frac(inactive, 10000, total);
>>  }
> 
> [Severity: High]
> This is a pre-existing issue, but can this cause a divide by zero kernel
> panic?
> 
> If there are no active or inactive pages, or if per-CPU vmstat counter drift
> evaluates total to 0, mult_frac() will divide by zero.
Not a bug. The system can never have 0 consumed memory.
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
> Can mult_frac() divide by zero here?
> 
> If the system is highly idle or due to per-CPU vmstat counter drift, total
> could evaluate to exactly 0.
No, total can never be 0.
> [Severity: Medium]
> Is there a risk of a 32-bit overflow in this calculation?
> 
> On 32-bit architectures, mult_frac() preserves types, and computing
> thp * 10000 could exceed the maximum unsigned long value if there are
> more than ~1.7 GB of THPs, producing an arbitrarily small quota target.
> 
Good catch! I will cast 10000 to unsigned long to preserve the types.
-- 
Asier Gutierrez
Huawei

