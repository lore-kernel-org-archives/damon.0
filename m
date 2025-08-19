Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBD27AC21
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615546; cv=none; b=o6LXvsMy0hM9+Dcua3d5qc3+990pUjQtiFs6XixCRuVpMw7A/pODvZH77VDpqL41mW5LLxn02MrkheaNG97BB+b0rMmKcyQLZwI3uYicwivJvslQAtpGRXHShG+ZxlmXw24Q3C/5M8zuUwe2FL1Jn7GG6kNinUiYy34Qc4QSqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615546; c=relaxed/simple;
	bh=xxXsRPI9FAskc5Q+IFNvMYLDM6NvAykf0JwNJGOsF70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WLchSNuE7ZaxNi+0ODnwzRqehAlzcUbaxNZGqQ9HSli1QYEPZGqLKeQN6WMmNBab2HGXiVC1+q583kNK0VYuC0Cp+rincrFVgnJD5Q/KyMo0AjeeVGCAgYzF4yM/0R98oYJeIaNr+BejKuodn71yMyWWrhG2v8OQ5+wSqRQV9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c5t1F5lW5z13NB8;
	Tue, 19 Aug 2025 22:55:29 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 158C61402E9;
	Tue, 19 Aug 2025 22:59:02 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 22:59:01 +0800
Message-ID: <f609350c-2cfe-4cbe-98ad-a154a858fe4d@huawei.com>
Date: Tue, 19 Aug 2025 22:59:00 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 11/16] mm/damon: add addr_unit for DAMON_RECLAIM
 and LRU_SORT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250814161125.67602-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250814161125.67602-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/15 0:11, SeongJae Park 写道:
> On Thu, 14 Aug 2025 20:59:04 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> 在 2025/8/14 0:36, SeongJae Park 写道:
>>> On Wed, 13 Aug 2025 13:07:01 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>>>
>>>> In module DAMON_RECLAIM and DAMON_LRU_SORT, the damon_ctx is
>>>> independent of the core, necessitating dedicated addr_unit
>>>> integration for these features.
>>>> Additionally, if the input monitor_region_start and monitor_region_end
>>>> are both 0 while addr_unit is set to a non-zero valuethe default
>>>> system RAM range should be divided by addr_unit.
>>> Do you plan to, and need to use DAMON_RECLAIM and DAMON_LRU_SORT on LPAE-ARM32
>>> environments?  Can't you use DAMON sysfs interface instead?  If need to use the
>>> modules, this change looks good to me in high level.  But if not, I'd like to
>>> skip this change, and wait until someone requests it.
>>>
>>> I'll review the code change in depth after the above question is answered.
>>>
>> Hi SJ,
>>
>> Yes, we need to use these modules in an LPAE-ARM32 environment. The modular
>> approach often provides more flexibility in our workflow, so we would greatly
>> appreciate it if you could take some time to review the code!🙂
> Thank you for clarifying.  Ok, I understand this change is really required.
>
> However, I think reviewing and revising this part may take time.  Meanwhile,
> seems this part is not an essential one of this patch series, and has no
> problem at be separated and merged after the essential parts.
>
> So, could we separate this part from this patch series?  That is, let's work on
> the essential part first.  After the work on the essential part is done, you
> could post this part as another patch series, and then we can work together
> again on it.

You are right, let's focus on the essential part first.

Thanks,
Quanmin Yan

>
> Thanks,
> SJ
>
> [...]
