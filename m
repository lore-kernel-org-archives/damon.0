Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4A3DA7C2;
	Tue, 16 Jun 2026 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638526; cv=none; b=FAmUS2JnNXkUblIwNkEwEGT5tolriyddiEMclUPIJM1SqC7wGlsgrXdPsFFfyE1vOX+FUlF68YlwovWwySpp/KQoeqBin9RR6kanXuFCFPSJbzDSxnYCFcXneznM9hUhU8cxfhQSml3X86fBCUa8xl2baEM61ARCnMq1JhueZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638526; c=relaxed/simple;
	bh=PuimfJia3CSDx6hoNhV2fWNsfOlEYjF8E5z2Xqcf7GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xz0QUBMu+Oo5555NQa6k45105IEeGEUf2qNN96JtqXAW5aSmm7KYyKwV/nzqvi6N3hyQCAKm7GmXA/IZaV3QCMw9xqDncisQbxEEPzD5B12M9KluLVdYN7OPDTV9T/oRRpxHCkAff4q/GNrNdLYepNh29JcHw7zMIHBLRhouYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gfxyp5DLJzJ467y;
	Wed, 17 Jun 2026 03:34:58 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 8967840584;
	Wed, 17 Jun 2026 03:35:22 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 22:35:22 +0300
Message-ID: <6a2a30eb-2fd8-4ade-988e-9a9c93c09fe6@huawei-partners.com>
Date: Tue, 16 Jun 2026 22:35:21 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota goal
 metric
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260616150316.580819-4-gutierrez.asier@huawei-partners.com>
 <20260616152153.6F75F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260616152153.6F75F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/16/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Low] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is exposed via sysfs but lacks required documentation updates.
> 
> Pre-existing issues:
> - [Critical] Potential divide-by-zero in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` due to an unhandled zero denominator.
> - [High] 32-bit integer overflow in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` when calculating memory ratios.
> --
> 
> commit be304699fb94d4d73bd979237fb4d7b08b7216f7
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> 
> DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
> This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.
> 
>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>> index 329cfd0bbe9f3..4b5429a5b4158 100644
>> --- a/mm/damon/sysfs-schemes.c
>> +++ b/mm/damon/sysfs-schemes.c
>> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
>>  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>>  		.name = "node_eligible_mem_bp",
>>  	},
>> +	{
>> +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
>> +		.name = "hugepage_mem_bp",
>> +	},
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but exposing this metric directly
> to userspace makes a potential divide-by-zero triggerable by users
> configuring DAMON quotas.
> 
> In mm/damon/core.c:damos_hugepage_mem_bp(), the denominator is computed as:
> 
>     total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> 
> Due to per-CPU vmstat lag or an idle system, the free pages counter can equal
> totalram_pages(), resulting in total being 0. This is then passed to
> mult_frac():
> 
>     return mult_frac(thp, 10000, total);
> 
> This inherently computes thp / total, causing a strict division by zero and a
> kernel panic. The same issue exists in damos_get_in_active_mem_bp() where
> total = active + inactive, which can be 0 if the LRU lists are empty.
> 
> Should a zero-check on total be added before performing the division?
DAMON is enabled after the system is fully loaded. total will not be 0 by then.
> [Severity: High]
> This is a pre-existing issue, but exposing this metric also surfaces a 32-bit
> integer overflow in mm/damon/core.c:damos_hugepage_mem_bp().
> 
> The mult_frac(x, n, d) macro performs the multiplication (x % d) * n. Here x
> is thp, which is an unsigned long.
> 
> On 32-bit systems, if thp exceeds ~429,496 pages (around 1.75 GB),
> (thp % total) * 10000 will silently overflow the 32-bit unsigned long type.
> 
> This wrap-around yields an erroneously low ratio instead of the correct value.
> The same overflow applies to damos_get_in_active_mem_bp() if the active or
> inactive pages exceed 1.75 GB.
> 
> Could this be fixed by casting the first argument to u64 to prevent the
> overflow?
As described in this patch set, this will be the default behaviour in that
case.
> [Severity: Low]
> Does this patch also require an update to the authoritative DAMON sysfs
> documentation?
> 
> Documentation/mm/damon/design.rst explicitly lists all valid string values
> for the target_metric sysfs file, but does not include hugepage_mem_bp.
> Without documenting the new metric, it may remain undiscoverable for users.
I will update the documentation. 
>>  };
>>  
>>  static ssize_t target_metric_show(struct kobject *kobj,
> 

-- 
Asier Gutierrez
Huawei

