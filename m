Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0692F27
	for <damon@lists.linux.dev>; Fri, 16 Sep 2022 08:57:38 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPwbJYY_1663318648;
Received: from 30.240.97.224(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPwbJYY_1663318648)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 16:57:29 +0800
Message-ID: <11a3021e-860b-e00e-8289-45831feed2e4@linux.alibaba.com>
Date: Fri, 16 Sep 2022 16:57:27 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V1 1/2] mm/damon/sysfs: avoid call damon_target_has_pid()
 repeatedly
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220916084251.105360-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220916084251.105360-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/16 下午4:42, SeongJae Park 写道:
> On Thu, 15 Sep 2022 22:22:36 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon_sysfs_destroy_targets(), we call damon_target_has_pid() to
>> check whether the 'ctx' include a valid pid, but there no need to call
>> damon_target_has_pid() to check repeatedly, just need call it once.
> Good eyes, nice finding!
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/sysfs.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
>> index 1fa0023f136e..966ea7892ccf 100644
>> --- a/mm/damon/sysfs.c
>> +++ b/mm/damon/sysfs.c
>> @@ -2143,9 +2143,13 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
>>   static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
>>   {
>>   	struct damon_target *t, *next;
>> +	bool has_pid = false;
>> +
>> +	if (damon_target_has_pid(ctx))
>> +		has_pid = true;
> How about doing more simple and short like below?
>
>      bool has_pid = damon_target_has_pid(ctx)
Yes, Do like this, make code look more clean. but this patch has been 
merged into,  i send a new one to fix it ?
>
> Other than this,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
>>   	damon_for_each_target_safe(t, next, ctx) {
>> -		if (damon_target_has_pid(ctx))
>> +		if (has_pid)
>>   			put_pid(t->pid);
>>   		damon_destroy_target(t);
>>   	}
>> --
>> 2.31.0
