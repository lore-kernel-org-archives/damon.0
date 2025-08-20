Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0012848AA
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679560; cv=none; b=qw+emr/D3dsjpbLVQcHp28p0qT+vDJHIctfGUK1OkNXwg+IvVmg9wE5DkSckt+iVWV+yS9CjMGfey4EIz1GaKIeYcRAOXoy6EuNb9H234C0HcjBjy7M5Fz2l9YhGS+SISwv+MCm8GHqa7Uw7ClqNIvMsVRvK2a8/BfbC2HYH3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679560; c=relaxed/simple;
	bh=MXuw4esMj67WhiLUcyRR/JYk+Ij3H1a9//JPdAF8nkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e7UoKhBZzRY+LZkG69qc7i1sKX3gPbIew0zQLuwpwnqfX4/Bo4ktyW6MGjAfyrFoVbfGWF5vKUzW9DRuEBWekeyG2ocCQzZ3c+fwFD1mONzHFU7AKz3BNc2Ajasrh0gu2hGbf+JedRqvaWVR1bP7CMhxON13ORvjCkdrTxm5cGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c6Kg41xqNzPqZQ;
	Wed, 20 Aug 2025 16:41:20 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AD2F14011A;
	Wed, 20 Aug 2025 16:45:56 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 16:45:55 +0800
Message-ID: <6d054831-054f-446a-a82f-239913a9deaa@huawei.com>
Date: Wed, 20 Aug 2025 16:45:54 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 13/16] mm/damon/sysfs: ensure valid addr_unit
 setting in damon_sysfs_apply_inputs()
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250813170224.6128-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250813170224.6128-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/14 1:02, SeongJae Park 写道:
> On Wed, 13 Aug 2025 13:07:03 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> By calling damon_sysfs_turn_damon_on(), the execution of damon_commit_ctx()
>> can be bypassed. Therefore, it is necessary to prevent ctx->addr_unit from
>> being set to 0 in damon_sysfs_apply_inputs() and update min_region to avoid
>> potential issues.
> Nice catch!
>
>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>> ---
>>   mm/damon/sysfs.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
>> index bea782b0a711..122824776c1d 100644
>> --- a/mm/damon/sysfs.c
>> +++ b/mm/damon/sysfs.c
>> @@ -1422,7 +1422,8 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
>>   	err = damon_select_ops(ctx, sys_ctx->ops_id);
>>   	if (err)
>>   		return err;
>> -	ctx->addr_unit = sys_ctx->addr_unit;
>> +	ctx->addr_unit = sys_ctx->addr_unit ? : 1;
> So this is fixing a bug of the seventh patch ("mm/damon/sysfs: implement
> addr_unit file under context dir") of this series, right?  It is better to not
> add a broken patch, and then fixing it in the same series.  Let's squash the
> fix of the problem into the patch.  Don't forget adding your Signed-off-by on
> the patch.
>
> Also, since sys_ctx->addr_unit is initialized as 1, the value being zero is
> user's wrong input.  Let's return -EINVAL instead of making it silently
> success.

Thank you for the kind reminder! The relevant changes have been integrated into
patch #7 of the v2 series[1]. It's worth noting that we've already prevented users
from inputting 0 at the source, therefore "ctx->addr_unit = sys_ctx->addr_unit;"
has been retained in the v2 version.

[1] https://lore.kernel.org/all/20250820080623.3799131-8-yanquanmin1@huawei.com/

>> +	ctx->min_region = max(DAMON_MIN_REGION / ctx->addr_unit, 1);
> Seems this is a fix of an issue in the 12th patch ("mm/damon: add
> damon_ctx->min_region and damon_target->min_region") of this series?  Let's fix
> it on the patch.

This set of changes has been integrated into patch #11 of the v2 series[2].

[2] https://lore.kernel.org/all/20250820080623.3799131-12-yanquanmin1@huawei.com/

Thanks,
Quanmin Yan

