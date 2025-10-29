Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3D2D8771
	for <damon@lists.linux.dev>; Wed, 29 Oct 2025 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701564; cv=none; b=qR7fkpoHqNAC0kewNvcaC4ZVBWLJOfsP/HFGOZYPsghGV9O8k5vMN2j+Rxc7TQ8TVgm0fclPcWvU7ST5T+ozov9gVn2EVOLSIaV8dmNirKnpkouXOh2sAkY6EN25mnzRsEat1lSmFMa+iYfQ7G1+56B70KScSZF6ELRYeod0+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701564; c=relaxed/simple;
	bh=7De9SBYm15KXwyrkKwlgtLCo2LaAcIHptYv1y34QZWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OcIo0fEAaDRO7KlrqA2BDx5Oq8YTC6sITWsIb79XNC84bUsg2YKtleEH6II2UTtS7se6UYmnZlUwGKNrSM2spcW2ndvPZ18pUsTAh4LgOMRRtO0RCY2ZbceL5qSCJnNEKpVqxEBe9jG2X5hStlo7JebbuC3cqxH53X8Zi9rZL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BiChO3hh; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BiChO3hh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a3RjBt8zeIPQKLHLasDxZWnu3ZJLAQippsYalBaaCdQ=;
	b=BiChO3hhDBOjuIKhCpJghRePDqtttnYUvUpE52W8IFnSvPGwZhRJnTtdpVy0kOmulbf/qnd0D
	nrBjV4OmRCd1q0MsXF6n5bSUS9osinJi8dQQl+cTt0JjmbtK/lkGco3ZCv22akfkjlI4lQkYxFm
	+X0RQNoSUqwIZeQgzWscvZE=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cx8qb2VKxzmV6g;
	Wed, 29 Oct 2025 09:32:11 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id F06FF1A0188;
	Wed, 29 Oct 2025 09:32:39 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 09:32:39 +0800
Message-ID: <19e22163-39b4-42f8-99b8-1be9ffb1589b@huawei.com>
Date: Wed, 29 Oct 2025 09:32:38 +0800
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
References: <20251028141915.49989-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20251028141915.49989-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf200018.china.huawei.com (7.185.36.31)

在 2025/10/28 22:19, SeongJae Park 写道:

> On Tue, 28 Oct 2025 14:19:27 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
>> avoid unnecessarily frequent stat update.
>>
>> On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
>> jiffies wrap bugs appear earlier. However, this causes time_before_eq()
>> in DAMON_STAT to unexpectedly return true during the first 5 minutes
>> after boot on 32-bit systems (see [1] for more explanation, which fixes
>> another jiffies-related issue in DAMON). As a result, DAMON_STAT does not
>> update any monitoring results during that period, which can be more
>> confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.
>>
>> Fix it by setting last_refresh_jiffies to jiffies at startup.
> Nice catch, thank you for this patch!
>
>> [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
>>
>> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>> ---
>>   mm/damon/stat.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
>> index 6c4503d2aee3..6dc3e18de910 100644
>> --- a/mm/damon/stat.c
>> +++ b/mm/damon/stat.c
>> @@ -132,6 +132,9 @@ static int damon_stat_damon_call_fn(void *data)
>>   	struct damon_ctx *c = data;
>>   	static unsigned long last_refresh_jiffies;
>>   
>> +	if (unlikely(!last_refresh_jiffies))
>> +		last_refresh_jiffies = jiffies;
>> +
> How about doing the initialization together with the declaration?  E.g.,
>
>   static int damon_stat_damon_call_fn(void *data)
>   {
>          struct damon_ctx *c = data;
> -       static unsigned long last_refresh_jiffies;
> +       static unsigned long last_refresh_jiffies = jiffies;
>
Thank you for your suggestion. Well, I actually tried that before, but
found that jiffies is not a compile-time constant,|it| is set at runtime,
while static initializers must use constant expressions, that's why the
current patch is modified this way.


Thanks,
Quanmin Yan

[...]

