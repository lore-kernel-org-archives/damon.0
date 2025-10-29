Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43621FF26
	for <damon@lists.linux.dev>; Wed, 29 Oct 2025 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703387; cv=none; b=m2TQ79OSNA7wS5vDdLZhLrNO11mIqUiPt6vyYSeRLR8RCGqM05h9/k0KeQQYTkqiNKq0jtOqForBEfldeG3dQEaUNXnJFsFY0UsT5z7lJJAO3356xK1FHMMBSAfJ+gYZHUgQ/7fBrrepk9zJ2xydXMTVzB9w/Mlvkbcy33NLTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703387; c=relaxed/simple;
	bh=g/fvQ8NZZJPX0GUAoJn3gUUXjyoM7DA3e77ObOIxp70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FFPJS/QgS+cXuPRvc/oQ52yozNVWrk4wB+spFF0LMYHSsmtfn3lQu1hIl1RUX5n2+OafCy5G+5IzCDTG86au0I/0Jt42TL5eFVwsbM2BI2/+pVkgrZwhg8kqOBkbr7Q5AqJ8qX2BBJm9kIr54pQg3hMr6um8F3RG43jJOUnisFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ykAmuVZh; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ykAmuVZh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+eK4vDSuRTOhJF4MJ84IKuDsgIzYi81R9gWmu7j/t3U=;
	b=ykAmuVZhMSyM5Iky45LoxzvpXZJ3wHa2hOshvGtKHvA2nQyir2aHEYnSo1IehVSuXBgb7m4Ew
	QChnPxMkYaJStFl+t5lShcqGvdSKsYce4XNF/VuOJiWpx+jtbDPn8J7Q/MpQDTjS9JWZWFPh1Eb
	4cm+bG+sHj81lHDuPuyQGjQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cx9Tx4Cxsz1T4HJ;
	Wed, 29 Oct 2025 10:01:57 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E4F6180B67;
	Wed, 29 Oct 2025 10:03:01 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 10:03:00 +0800
Message-ID: <75364faa-4cce-4e0b-ae43-dc725e6918da@huawei.com>
Date: Wed, 29 Oct 2025 10:02:59 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/stat: set last_refresh_jiffies to jiffies at
 startup
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20251029013038.66625-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20251029013038.66625-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/10/29 9:30, SeongJae Park 写道:
> On Tue, 28 Oct 2025 07:32:49 -0700 SeongJae Park <sj@kernel.org> wrote:
>
>> On Tue, 28 Oct 2025 07:19:14 -0700 SeongJae Park <sj@kernel.org> wrote:
>>
>>> On Tue, 28 Oct 2025 14:19:27 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>>>
>>>> In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
>>>> avoid unnecessarily frequent stat update.
>>>>
>>>> On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
>>>> jiffies wrap bugs appear earlier. However, this causes time_before_eq()
>>>> in DAMON_STAT to unexpectedly return true during the first 5 minutes
>>>> after boot on 32-bit systems (see [1] for more explanation, which fixes
>>>> another jiffies-related issue in DAMON). As a result, DAMON_STAT does not
>>>> update any monitoring results during that period, which can be more
>>>> confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.
>>>>
>>>> Fix it by setting last_refresh_jiffies to jiffies at startup.
>>> Nice catch, thank you for this patch!
>>>
>>>> [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
>>>>
>>>> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
>>>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>>>> ---
>>>>   mm/damon/stat.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
>>>> index 6c4503d2aee3..6dc3e18de910 100644
>>>> --- a/mm/damon/stat.c
>>>> +++ b/mm/damon/stat.c
>>>> @@ -132,6 +132,9 @@ static int damon_stat_damon_call_fn(void *data)
>>>>   	struct damon_ctx *c = data;
>>>>   	static unsigned long last_refresh_jiffies;
>>>>   
>>>> +	if (unlikely(!last_refresh_jiffies))
>>>> +		last_refresh_jiffies = jiffies;
>>>> +
>>> How about doing the initialization together with the declaration?  E.g.,
>>>
>>>   static int damon_stat_damon_call_fn(void *data)
>>>   {
>>>          struct damon_ctx *c = data;
>>> -       static unsigned long last_refresh_jiffies;
>>> +       static unsigned long last_refresh_jiffies = jiffies;
> Please ignore the above suggestion.  It will even not build, like below...
>
> .../mm/damon/stat.c: In function ‘damon_stat_damon_call_fn’:
> .../mm/damon/stat.c:133:53: error: initializer element is not constant
>    133 |         static unsigned long last_refresh_jiffies = jiffies;
>        |                                                     ^~~~~~~
>
>> Actually, a similar issue can happen again if DAMON_STAT is stopped and
>> restarted by user.  That is, if user stops DAMON_STAT just after
>> last_refresh_jiffies is updated, and restart it after 5 seconds or more, the
>> time_before_eq() on damon_call_fn() will return true, so stat updates will
>> happen earlier than expected.  Shouldn't be a real problem, but better to avoid
>> if possible.
>>
>> How about making last_refresh_jiffies a global variable and initialize it on
>> damon_stat_start()?  To avoid unnecessary name conflicts, the variable name
>> would also better to be changed, e.g., damon_stat_last_refresh_jiffies.
> But, please consider the above one.
>
> And I just realized a similar issue exist for next_update_jiffies in
> mm/damon/sysfs.c file.  Please feel free to send a patch for that if you
> willing to.
>
OK, I’ll review all these issues and send a new patch set once everything
is ready.🙂

Thanks,
Quanmin Yan

[...]

