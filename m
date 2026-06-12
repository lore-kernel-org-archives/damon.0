Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890711D63F0;
	Fri, 12 Jun 2026 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293548; cv=none; b=dq0MDNntMJHowOgkgPfAWjp6ipsxhYW7igtsb+Y/5P5eqIkeqqlvLbTAaFG5Rh88DhUz0o/c6lygP/CppGQ34IB5z7aiAEsLaBdF+wmSomOZ6YY+4GdbRt/u2feNmp+s8teI4y83mLj1SxmP10AnmUi4JFcAbjWRzdm0HXic4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293548; c=relaxed/simple;
	bh=Uptc1znnkqIVNzzrlnTPT7XrafihUzcfbFmx9UmPX6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cm8TPtkdFylHlbOY03JhbnWKEykDj80ovuBipjzggvJSkHwhEY5ZgnGLdUp0CIu1nyXyPzOC8AWWjtcfP0ouPeLbwrXZs4nNl76aImHCC4+PxN3IeeHLRcnsjl39w+SePjMqLSoPCE5FTkoD3pq8EUQlfMi7SVGq/i8+AhUHvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcVNl1WX0zJ46C2;
	Sat, 13 Jun 2026 03:45:27 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CC8C40575;
	Sat, 13 Jun 2026 03:45:44 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 22:45:43 +0300
Message-ID: <75a96ceb-f785-4b7a-a2e8-17b8ef3250eb@huawei-partners.com>
Date: Fri, 12 Jun 2026 22:45:43 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>, SeongJae Park <sj@kernel.org>
References: <20260611150244.3454699-3-gutierrez.asier@huawei-partners.com>
 <20260611152146.AD2821F00898@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260611152146.AD2821F00898@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/11/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Mismatch between commit message documentation and actual module parameter name for the target PID.
> - [Low] Missing Kconfig dependency causes build failure on architectures/configs without huge page leaf support.
> 
> Pre-existing issues:
> - [High] Potential divide-by-zero kernel panic in `damos_hugepage_mem_bp` when total memory evaluates to zero.
> --
> 
> commit 4d499570cf03bd13f013e3c89938e2739ead1edf
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
> 
> This patch introduces the SAMPLE_DAMON_HUGEPAGE module to monitor a task
> and collapse hot memory regions into huge pages. It adds the necessary
> Kconfig, Makefile, and sample code implementation.
> 
>>     SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
>>     specific task. The user is expected to supply the PID of the task
>>     that is going to be monitored through the monitored_pid module
>>     variable.
> 
> [Severity: Medium]
> Is this module variable name accurate? The commit message documents that users
> should supply the PID via the monitored_pid module variable, but the Kconfig
> and C code below actually define and register it as target_pid.
As mentioned to SJ, I will correct this.
>> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
>> index cbf96fd8a8bf9..512f150aaabba 100644
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
> Does this require an explicit dependency on TRANSPARENT_HUGEPAGE or
> PGTABLE_HAS_HUGE_LEAVES?
> 
> If huge page leaves are not supported on the target architecture,
> HPAGE_PMD_SHIFT evaluates to a BUILD_BUG() expression. Because
> SAMPLE_DAMON_HUGEPAGE evaluates this unconditionally below, configuring a
> kernel without huge page support will result in an immediate compile-time
> failure.
SJ, should we use make this module depend on TRANSPARENT_HUGEPAGE?
>> +	help
>> +	  This module monitors a certain PID provided by the user through
>> +	  monitored_pid attribute. Hot regions are determined by DAMON-based
> 
> [ ... ]
> 
>> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
>> new file mode 100644
>> index 0000000000000..2c7fd213a8db1
>> --- /dev/null
>> +++ b/samples/damon/hugepage.c
>> @@ -0,0 +1,207 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> [ ... ]
> 
>> +static int damon_sample_hugepage_start(void)
>> +{
>> +	int err;
>> +	struct damon_target *target;
>> +	struct damos *scheme;
>> +	struct damos_quota_goal *goal;
> 
> [ ... ]
> 
>> +	scheme = damon_new_scheme(&(struct damos_access_pattern) {
>> +				.min_sz_region = HPAGE_PMD_SIZE,
> 
> [Severity: Low]
> This is where HPAGE_PMD_SIZE is evaluated unconditionally, which will trigger
> the BUILD_BUG() if the Kconfig dependencies are not updated.
Same as before, should make this module depend on TRANSPARENT_HUGEPAGE?
> [Severity: High]
> This isn't a bug introduced by this patch, but can this feature trigger a
> divide-by-zero kernel panic?
> 
> This problem was introduced by a preceding patch in the same series
> ('mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning'), and it appears to
> remain unfixed at the end of the series.
> 
> Looking at damos_hugepage_mem_bp() in mm/damon/core.c:
> 
> mm/damon/core.c:damos_hugepage_mem_bp() {
>     ...
>     total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
>     return mult_frac(thp, 10000, total);
> }
> 
> Due to the nature of per-CPU counter caches,
> global_zone_page_state(NR_FREE_PAGES) can drift. In extreme edge cases,
> such as when nearly all managed pages are free, the free pages count can
> equal or temporarily exceed totalram_pages(), causing total to evaluate to 0.
> 
> Would passing total == 0 to mult_frac() trigger a division-by-zero
> exception?
> 
There can't be 0 total used pages in the system.


-- 
Asier Gutierrez
Huawei

