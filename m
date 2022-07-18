Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134347E9
	for <damon@lists.linux.dev>; Mon, 18 Jul 2022 04:48:40 +0000 (UTC)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LmTtR3xvKzjX0R;
	Mon, 18 Jul 2022 12:45:51 +0800 (CST)
Received: from [10.174.179.110] (10.174.179.110) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 12:48:32 +0800
Message-ID: <250ec3d9-6fec-a051-6d9a-24b265fa0a57@huawei.com>
Date: Mon, 18 Jul 2022 12:48:12 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] mm/damon/reclaim: fix 'enabled' is incorrectly set
 because 'system_wq' is not initialized
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220715170736.126498-1-sj@kernel.org>
From: songyuanzheng <songyuanzheng@huawei.com>
In-Reply-To: <20220715170736.126498-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.110]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected

Hello SJ,

Thank you very much for your reply, through your reply let me understand 
this principle, so please ignore this patch.

Thanks,

Yuanzheng

On 2022/7/16 1:07, SeongJae Park wrote:
> Hello Yuanzheng,
>
>
> On Fri, 15 Jul 2022 06:16:09 +0000 Yuanzheng Song <songyuanzheng@huawei.com> wrote:
>
>> The 'enabled' will be incorrectly set because the 'system_wq'
>> might not initialized yet. This results in 'enabled=true',
>> but the 'damon_reclaim_timer' is inactive. So fix it by moving
>> the judgment logic of the 'damon_reclaim_initialized' to the
>> start position of the enable_store().
> Thank you for this patch!
>
> In the case, however, 'damon_reclaim_init()' will activate
> 'damon_reclaim_timer', which will check the 'enabled' and start DAMON later.
> So 'enabled' will inconsistently set while DAMON_RECLAIM is not really enabled
> for a moment, but those will eventually be consistent.  This patch could reduce
> the duration of the inconsistent state.
>
> However, this would break boot-time DAMON_RECLAIM enabling, which adds
> 'damon_reclaim.enabled=true' to the kernel parameter, as this change will set
> 'enabled' as 'false' in the early 'damon_reclaim_enabled_store()', so that the
> later 'damon_reclaim_initialized()' activated 'damon_reclaim_timer' shows
> 'enabled' as 'false' and therefore doesn't start DAMON.
>
> If there is anything I'm missing, please let me know.
>
>
> Thanks,
> SJ
>
>> Fixes: 294928293813 ("mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized")
>> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
>> ---
>>   mm/damon/reclaim.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
>> index e69b807fefe4..b13d5a02bf2e 100644
>> --- a/mm/damon/reclaim.c
>> +++ b/mm/damon/reclaim.c
>> @@ -374,13 +374,14 @@ static bool damon_reclaim_initialized;
>>   static int damon_reclaim_enabled_store(const char *val,
>>   		const struct kernel_param *kp)
>>   {
>> -	int rc = param_set_bool(val, kp);
>> -
>> -	if (rc < 0)
>> -		return rc;
>> +	int rc;
>>   
>>   	/* system_wq might not initialized yet */
>>   	if (!damon_reclaim_initialized)
>> +		return -EINVAL;
>> +
>> +	rc = param_set_bool(val, kp);
>> +	if (rc < 0)
>>   		return rc;
>>   
>>   	schedule_delayed_work(&damon_reclaim_timer, 0);
>> -- 
>> 2.25.1
> .
