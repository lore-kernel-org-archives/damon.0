Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9932C302;
	Tue, 16 Jun 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638071; cv=none; b=hZvEegkzMWr/7WQRd3+Jg+AVpIZKhq2YzoPTKxEijixYVpj/NighZ1cwdNRcz2Gz0E0zV6nVucVBoncPMWmF1CG6sCV9TYjH4zdVoB9xiulQfo5/Mjrkb0mVsRXOzqa9uTQsMyFqHxrn0YvjH92m3wV7naPQd/6/efdzZ7YnIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638071; c=relaxed/simple;
	bh=HaN5x81W4hL11Cl5zzBn+hU2pb8iUZvJxCIMAEA0/eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h7gqmdH9m9axOz95KswpzGUeGN+spsch2usQ9wMPwSoHVzOjZk+dJ7c1yz9qY8BYua8UQFa9CzIfuPjhJEGhHRZRY7IFNS6TTZ06uCY/s8drbbOQZpFG2cOln8N9hKeZ1yALbs6j6uuIagCjPS+7HSbPIHZRnYDCRmh32AR2+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gfxnz3HrrzJ46DY;
	Wed, 17 Jun 2026 03:27:19 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 44F9840572;
	Wed, 17 Jun 2026 03:27:43 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 22:27:42 +0300
Message-ID: <308b6783-a1cc-4f57-94d2-7421fd4362e9@huawei-partners.com>
Date: Tue, 16 Jun 2026 22:27:41 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region
 hugepage collapsing
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
 <20260616152139.9648D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260616152139.9648D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/16/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The `DAMOS_QUOTA_USER_INPUT` goal tuner feedback mechanism is statically stuck because `current_value` is never dynamically updated.
> - [Medium] The scheme applies the DAMOS_COLLAPSE action to all regions including completely cold ones, contradicting the patch description.
> - [Low] The module cannot be compiled due to a naming mismatch between the Kconfig symbol and the Makefile variable.
> --
> 
> commit 7e15caa860a55beb8439fc6bb5f299c5c42fb138
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
> 
> This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> which collapses hot regions into huge pages. The module monitors
> a specific task using DAMON-based sampling and applies collapsing
> based on memory usage.
> 
>> diff --git a/samples/damon/Makefile b/samples/damon/Makefile
>> index 72f68cbf422aa..a348dc74ddcb1 100644
>> --- a/samples/damon/Makefile
>> +++ b/samples/damon/Makefile
>> @@ -3,3 +3,4 @@
>>  obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
>>  obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
>>  obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
>> +obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE) += hpage.o
> 
> [Severity: Low]
> Does this prevent the module from building? 
> 
> The Kconfig file defines the configuration option as SAMPLE_DAMON_HPAGE, 
> but the Makefile evaluates CONFIG_SAMPLE_DAMON_HUGEPAGE. This mismatch 
> means the build system might silently skip compiling hpage.o.
Yes, my bad when moving around code from different branches. Will
be fixed in v2.
>> diff --git a/samples/damon/hpage.c b/samples/damon/hpage.c
>> new file mode 100644
>> index 0000000000000..ebbe5e1be1a1d
>> --- /dev/null
>> +++ b/samples/damon/hpage.c
> 
> [ ... ]
> 
>> +	scheme = damon_new_scheme(&(struct damos_access_pattern) {
>> +				.min_sz_region = HPAGE_PMD_SIZE,
>> +				.max_sz_region = ULONG_MAX,
>> +				.min_nr_accesses = 0,
>> +				.max_nr_accesses = UINT_MAX,
> 
> [Severity: Medium]
> Will this apply the collapse action to completely cold regions? 
> 
> The commit message states this module collapses "hot regions", but setting 
> min_nr_accesses to 0 instructs DAMON to apply the action to all regions 
> that meet the age threshold, including those with no accesses at all. 
> 
> Should this be set to a value strictly greater than 0 to only target 
> heavily accessed regions?
Good catch. I will update it to 1.
> [ ... ]
> 
>> +	if (quota_autotune_feedback) {
>> +		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
>> +		if (!goal) {
>> +			damon_destroy_ctx(ctx);
>> +			return -ENOMEM;
>> +		}
>> +		goal->current_value = quota_autotune_feedback;
>> +		damos_add_quota_goal(&scheme->quota, goal);
>> +	}
> 
> [Severity: Medium]
> Is there a missing mechanism to dynamically update this feedback value?
> 
> Since the module parameter is assigned to current_value exactly once at 
> startup, without a dynamic update path while running, the auto-tuner will 
> receive a constant error value. 
> 
> Won't this continuously push the quota aggressiveness in one direction 
> until it hits the limits, rather than forming a proper feedback loop?
> 
This is a sample module. There is no commit mechanism as in the usual
DAMON modules. It should be set up before enabling the module.

I will document this behaviour in the documentation.

-- 
Asier Gutierrez
Huawei

