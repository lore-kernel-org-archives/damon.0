Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570F3AB267;
	Fri, 12 Jun 2026 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294422; cv=none; b=KcDqsoZylyhJmzNefnh0iVsk4sxFW0Z5fk5AI6U7lGL1LL1I6DT+tOFarqesOEg8oyoQvpvBV+E8LYDvF1ByZybf1rHAgRyP9slt+gz26mfMADLxMIdyAQPCa1tmVMYKLScpWLvg/tuDk3VGsl64zFmwtoD+tHLxtr68ypfQNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294422; c=relaxed/simple;
	bh=Vwd6Bpp2iMv0g/e8Cte5HQWGKykVYjskVEu2vbyddHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tLr9xxpPw3F70wvM6uT/hacnMK3yzCbQ1ukUldet+U7GV8oXD6hovI+zx2D1v9TmrAIXFpxLirOELmdJOyb0jlyf6camFa74EIyOGj+dGelkh+BttLTYsn2G19qWS4+en4cJ6dbplzRQ3E5Hiyq1HxY7mOgErLy21mILzGeUgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcVjd4GYXzHnGhH;
	Sat, 13 Jun 2026 04:00:05 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F49640584;
	Sat, 13 Jun 2026 04:00:14 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 23:00:13 +0300
Message-ID: <e7f3909a-06c5-40cf-b82f-e1dc571d476d@huawei-partners.com>
Date: Fri, 12 Jun 2026 23:00:13 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] mm/damon/sysfs: support hugepage_mem_bp quota
 goal metric
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260611150244.3454699-4-gutierrez.asier@huawei-partners.com>
 <20260611152418.E4C3D1F00893@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260611152418.E4C3D1F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/11/2026 6:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Missing zero check for total memory before calling `mult_frac()` can cause a division by zero kernel panic.
> - [Medium] Calculation of hugepage basis points in `damos_hugepage_mem_bp()` can overflow on 32-bit architectures.
> - [Low] The metric `DAMOS_QUOTA_HUGEPAGE_MEM_BP` erroneously copies its `current_value` from sysfs, resulting in a dead store and misleading initialization.
> - [Low] `samples/damon/hugepage.c` fails to compile on configs without `TRANSPARENT_HUGEPAGE` due to `HPAGE_PMD_SIZE`.
> --
> 
> commit 6648426483c20398b6f6fd9f51731549de51d36d
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> 
> Add the "hugepage_mem_bp" to the sysfs-schemes interface. Also handle
> DAMOS_QUOTA_HUGEPAGE_MEM_BP when constructing quota goals.
> 
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
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
> 
> [Severity: High]
> Can total be zero here, leading to a division by zero exception?
> 
> The total variable is calculated as totalram_pages() -
> global_zone_page_state(NR_FREE_PAGES). On a newly booted system or due to
> vm_stat per-CPU counter drift, NR_FREE_PAGES could temporarily equal
> totalram_pages(), making total exactly 0.
> 
> If total is 0, passing it to mult_frac() will trigger a division by zero
> exception and panic the kernel, since mult_frac(x, n, d) evaluates x / d.
> 
> Could a safeguard like if (!total) return 0; be added to prevent this?
This is a sample module, which will be enabled after the system is fully
loaded. Total will not be 0 at that time.
> 
>> +	return mult_frac(thp, 10000, total);
> 
> [Severity: Medium]
> Will this calculation overflow on 32-bit architectures?
> 
> The macro mult_frac(x, n, d) executes (x % d) * n / d, which evaluates to
> thp * 10000 / total. Since thp and 10000 are unsigned long, this
> multiplication occurs in 32-bit arithmetic on 32-bit architectures.
> 
> NR_ANON_THPS stores the number of base pages that are PMD-mapped. If the
> system has more than 429,496 THP pages (approx 1.63 GB of memory, which is
> possible on 32-bit architectures like ARM with LPAE), the multiplication
> thp * 10000 overflows unsigned long.
> 
> This wrap-around results in an incorrect, artificially small value being fed
> to the DAMON quota tuner, leading to erratic auto-tuning behavior.
As mentioned with SJ before, it is unlikely to have those systems using
THP. In case we find users with this issue, we can patch it.[1]
> 
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>> --- a/mm/damon/sysfs-schemes.c
>> +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
>> @@ -2877,6 +2881,9 @@ static int damos_sysfs_add_quota_score(
>>  		case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
>>  			goal->nid = sysfs_goal->nid;
>>  			break;
>> +		case DAMOS_QUOTA_HUGEPAGE_MEM_BP:
>> +			goal->current_value = sysfs_goal->current_value;
> 
> [Severity: Low]
> Does this erroneously copy the current value from sysfs?
> 
> Because DAMOS_QUOTA_HUGEPAGE_MEM_BP is an auto-calculated system metric
> rather than a user-provided one, the DAMON core unconditionally overwrites
> goal->current_value during the first evaluation interval in
> damos_set_quota_goal_current_value().
> 
> This assignment appears to be dead code that breaks the pattern of other
> system metrics which correctly fall through to the default case.
I will remove it.
>> +			break;
>>  		default:
>>  			break;
>>  		}
> 
> [ ... ]
> 
>> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
>> --- a/samples/damon/Kconfig
>> +++ b/samples/damon/Kconfig
>> @@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
>>  
>>  	  If unsure, say N.
>>  
>> +config SAMPLE_DAMON_HUGEPAGE
>> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HUGEPAGE)"
>> +	depends on DAMON && DAMON_VADDR
> 
> [Severity: Low]
> Will this cause build failures on configurations without huge page support?
> 
> The Kconfig option SAMPLE_DAMON_HUGEPAGE does not depend on
> TRANSPARENT_HUGEPAGE. When CONFIG_PGTABLE_HAS_HUGE_LEAVES is not set (which
> happens when huge page support is disabled), HPAGE_PMD_SIZE resolves to
> (1UL) << ({ BUILD_BUG(); 0; }).
> 
> This could lead to compile errors in samples/damon/hugepage.c since it uses
> HPAGE_PMD_SIZE to calculate huge page counts.
As with the previous patch, we can make the module depend on TRANSPARENT_HUGEPAGE
>> +	help
>> +	  This module monitors a certain PID provided by the user through
> 
> [ ... ]
> 
>> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/samples/damon/hugepage.c
> [ ... ]
>> +static int damon_sample_hugepage_damon_call_fn(void *data)
>> +{
>> +	struct damon_ctx *c = data;
>> +	struct damon_target *t;
>> +
>> +	damon_for_each_target(t, c) {
>> +		struct damon_region *r;
>> +		unsigned long hugepages = 0;
>> +
>> +		damon_for_each_region(r, t) {
>> +			if (r->nr_accesses > 0)
>> +				hugepages += r->ar.end - r->ar.start;
>> +		}
>> +		hugepages = hugepages / HPAGE_PMD_SIZE;
> 
> [Severity: Low]
> Does this use HPAGE_PMD_SIZE without verifying huge page support is available?
> 
> As mentioned above, if TRANSPARENT_HUGEPAGE is not enabled, this macro will
> trigger a BUILD_BUG() and break the compilation.
Same as the previous issue.
>> +		pr_info("hugepage: %lu\n", hugepages);
>> +	}
>> +	return 0;
>> +}
> 


[1] https://lore.kernel.org/all/20260609145240.69552-1-sj@kernel.org/
-- 
Asier Gutierrez
Huawei

