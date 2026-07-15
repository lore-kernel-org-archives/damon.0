Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E623128D4;
	Wed, 15 Jul 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126867; cv=none; b=lgVCiCoURr+mqdQwsmCf8adLY3CWVJs8aAHc+H9IcO7E6CvEQMhUwZY3YSn3HDZmF67ClptDQMF9lARUUKSXwm46OHgGxEKt2PTmrzq3Ej4x1S7i/oKhHniv6qKfS/l43681aJhjif+pbjIkw3Q6wlQF+58L+3uvp/UQFzczIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126867; c=relaxed/simple;
	bh=x0lcUkul7tihSU3b5qaGDxIMmKGpWftsYVj9fVGBKQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j0Auv6kFvOC96OOuLA7RnUpYIk+AE9pOHzjnkKxXPweQ6pizHkGuV9sj5N0tQmLk0MH5Pt5ADvfS5TekQ8IoDcQ0qQE8t3Le5iksRcf8S021ahJuwAvFqTdkqrX/iOazaZ6iUi7PRVBvjmPDnpYM78EtkeY6BeAoBWih7hIVj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=rx1Hlkrm; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="rx1Hlkrm"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gjLK+4kwLRvrkEFIk57WCJlsRt2hY3FiQ2tDrAjGOos=;
	b=rx1Hlkrmouz7/BB9Iojhd95DZuNSg/QtW0RdYUzK5NcGwkPDX8G0S8Era3C6aCVlra6f23lgR
	VW2oZn+jrd9VeQWjdHCzmxr1gj/QMw2AIV6HhS+fUwhNdO6KHjMS+U2tWDsZ39Lng9ShtgbniPm
	NhYf+yQjdFmD8JctaNgj5pQ=
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h0fCg30DPzHnH4s;
	Wed, 15 Jul 2026 22:47:27 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D03A440577;
	Wed, 15 Jul 2026 22:47:39 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jul 2026 17:47:39 +0300
Message-ID: <ad2caf50-0352-451e-bbfa-94df2280acc9@huawei-partners.com>
Date: Wed, 15 Jul 2026 17:47:38 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota goal
 metric
To: SeongJae Park <sj@kernel.org>
CC: <sashiko-reviews@lists.linux.dev>, <damon@lists.linux.dev>
References: <20260617041515.98906-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260617041515.98906-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 6/17/2026 7:15 AM, SeongJae Park wrote:
> On Tue, 16 Jun 2026 22:35:21 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>>
>>
>> On 6/16/2026 6:21 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [Low] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is exposed via sysfs but lacks required documentation updates.
>>>
>>> Pre-existing issues:
>>> - [Critical] Potential divide-by-zero in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` due to an unhandled zero denominator.
>>> - [High] 32-bit integer overflow in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` when calculating memory ratios.
>>> --
>>>
>>> commit be304699fb94d4d73bd979237fb4d7b08b7216f7
>>> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>
>>> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
>>>
>>> DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
>>> This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.
>>>
>>>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>>>> index 329cfd0bbe9f3..4b5429a5b4158 100644
>>>> --- a/mm/damon/sysfs-schemes.c
>>>> +++ b/mm/damon/sysfs-schemes.c
>>>> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
>>>>  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>>>>  		.name = "node_eligible_mem_bp",
>>>>  	},
>>>> +	{
>>>> +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
>>>> +		.name = "hugepage_mem_bp",
>>>> +	},
>>>
>>> [Severity: Critical]
>>> This isn't a bug introduced by this patch, but exposing this metric directly
>>> to userspace makes a potential divide-by-zero triggerable by users
>>> configuring DAMON quotas.
>>>
>>> In mm/damon/core.c:damos_hugepage_mem_bp(), the denominator is computed as:
>>>
>>>     total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
>>>
>>> Due to per-CPU vmstat lag or an idle system, the free pages counter can equal
>>> totalram_pages(), resulting in total being 0. This is then passed to
>>> mult_frac():
>>>
>>>     return mult_frac(thp, 10000, total);
>>>
>>> This inherently computes thp / total, causing a strict division by zero and a
>>> kernel panic. The same issue exists in damos_get_in_active_mem_bp() where
>>> total = active + inactive, which can be 0 if the LRU lists are empty.
>>>
>>> Should a zero-check on total be added before performing the division?
>> DAMON is enabled after the system is fully loaded. total will not be 0 by then.
> 
> Could you please further clarify what "system is fully loaded" means, reaards
> to what Sashiko is claiming, particularly the per-CPU vmstat lag?
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

What I meant is the system already initialized after booting. The thing
is that by the time the sysadmin sets up DAMON, vmstat should show at
least some memory usage, not 0. That was my guess, but I may be wrong.

If my initial thought was wrong, I can just add a guard there.


-- 
Asier Gutierrez
Huawei

