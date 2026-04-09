Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26223101B8
	for <damon@lists.linux.dev>; Thu,  9 Apr 2026 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719232; cv=none; b=YTX9nvSX5qseo4IjD+pQEAGGOhpwv7wmFC9PhbZtAgUFZvQOFiEd+BQHRn2gE27hL/DU9takkMztwoBusaopllJFihUSkfIEb8Npc1hxE1mvYTGAWIMZjBZ0lipwo32UkOe1hsBCkug1WZ86gMGdZlcU3Kl4XGs20uNGQW0dSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719232; c=relaxed/simple;
	bh=mCb6vAH1hf5nZVjjoPlD588myyubEctjoXr1Inp3H78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X8SdB1UEI682j9123GYgI5xzRBGX2FQaSE2Jhqzein5Cg5REqeTe/dK092+Q33QGTISbXiVNIHOalDlwVQCB5z1F+pu0GiQnYO8ua7mryn2TGQsx7allLUJXDVTAppemJlZ5zKwI3p/mrhCB16KMSj2OlGxCVKDWLO8GktpLEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NZacqqes; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NZacqqes"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HYqV+HwLz8zoQmcesOVkUB8rczTiyU8XEXIOxFTDGIQ=;
	b=NZacqqesoAM96BvKsOd69w6m/mAYUmCK3ZsL3LnBBOnlXU92taxpSQbQNf8qn49FPweyzAxJJ
	eCPJPEJumr3lVd7XwYN9jgdT/P5npYGHgabtpK1WAJS/q87XzQ5hM8JfMUFlKGn/Befd+qNfWca
	864bCtUxzjAkJQ2ugl7JCoE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4frrlN1KPMz1K9D3;
	Thu,  9 Apr 2026 15:14:08 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BA4B402AB;
	Thu,  9 Apr 2026 15:20:20 +0800 (CST)
Received: from [10.174.177.52] (10.174.177.52) by
 dggpemf500012.china.huawei.com (7.185.36.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 15:20:19 +0800
Message-ID: <1b340c6e-4e21-42c3-a1b1-d07813b8b8b7@huawei.com>
Date: Thu, 9 Apr 2026 15:20:10 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: support freeze kdamond
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <chenjun102@huawei.com>,
	<tongtiangen@huawei.com>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260408140708.89729-1-sj@kernel.org>
From: "linruifeng (A)" <linruifeng4@huawei.com>
In-Reply-To: <20260408140708.89729-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500012.china.huawei.com (7.185.36.8)

Hello SJ，

Thank you for your reply. Based on my current knowledge, I think this can be
described from three aspects:

1、kdamond monitors physical/virtual addresses and performs certain 
actions based
on the monitoring results to improve system/process efficiency. When the 
system
undergoes suspend/resume, most user-space processes are in a suspended 
state.
kdamond may therefore perform operations such as PAGEOUT / 
MADV_NOHUGEPAGE, but
these are not true data monitoring results. This may cause changes in 
the efficiency
of certain processes after system resume. Therefore, I believe that 
continuing to
run kdamond during suspend is meaningless and may even have negative 
effects.

2、When performing hibernate, most of the used memory in the system is 
swapped out to
disk. When memory is large, this is time-consuming. If kdamond does not 
sleep, it may
affect hibernate efficiency.

3、As discussed in [1]: "The principal reason is to prevent filesystems 
from being damaged
after hibernation. At the moment we have no simple means of 
checkpointing filesystems, so if
there are any modifications made to filesystem data and/or metadata on 
disks, we cannot bring
them back to the state from before the modifications. At the same time 
each hibernation image
contains some filesystem-related information that must be consistent 
with the state of the on
disk data and metadata after the system memory state has been restored 
from the image (otherwise
the filesystems will be damaged in a nasty way, usually making them 
almost impossible to repair).
We therefore freeze tasks that might cause the on-disk filesystems' data 
and metadata to be modified
after the hibernation image has been created and before the system is 
finally powered off. The majority
of these are user space processes, but if any of the kernel threads may 
cause something like this to
happen, they have to be freezable." During suspend/resume, processes 
involving I/O operations should
be frozen.

Based on the above reasons, I believe it is reasonable to support 
freezing kdamond. If there are any
errors in my thinking, please point them out.

Thans,
Lin Ruifeng

在 2026/4/8 22:07, SeongJae Park 写道:
> Hello Lin,
>
>
> Thank you for sharing this patch.
>
> On Wed, 8 Apr 2026 16:06:52 +0800 Lin Ruifeng <linruifeng4@huawei.com> wrote:
>
>> During suspend and resume, the data monitored by kdamond is
>> no longer meaningful. Meanwhile, since kdamond may involve
>> I/O operations, it is necessary to freeze it.
> I'm not used to PM freezer, and maybe because of that, I'm not fully
> understanding the motivation of this patch.  Could you please elaborate the
> existing problem and how this patch is fixing or improving it?
>
>
> Thanks,
> SJ
>
>> Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
>> ---
>>   mm/damon/core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 3e1890d64d06..5cd1f0aed66b 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   #include <linux/string_choices.h>
>> +#include <linux/freezer.h>
>>   
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/damon.h>
>> @@ -2753,6 +2754,7 @@ static int kdamond_fn(void *data)
>>   
>>   	complete(&ctx->kdamond_started);
>>   	kdamond_init_ctx(ctx);
>> +	set_freezable();
>>   
>>   	if (ctx->ops.init)
>>   		ctx->ops.init(ctx);
>> @@ -2774,6 +2776,8 @@ static int kdamond_fn(void *data)
>>   		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
>>   		unsigned long sample_interval = ctx->attrs.sample_interval;
>>   
>> +		try_to_freeze();
>> +
>>   		if (kdamond_wait_activation(ctx))
>>   			break;
>>   
>> -- 
>> 2.43.0
