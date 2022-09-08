Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21B7C
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 01:49:22 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VP.zpTy_1662601430;
Received: from 30.240.97.117(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VP.zpTy_1662601430)
          by smtp.aliyun-inc.com;
          Thu, 08 Sep 2022 09:43:52 +0800
Message-ID: <c0a1e773-7dcf-0e27-95d8-beda673baac7@linux.alibaba.com>
Date: Thu, 8 Sep 2022 09:43:50 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH] mm/damon: Remove duplicate get_monitoring_region()
 definitions
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220907205911.62483-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220907205911.62483-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/8 上午4:59, SeongJae Park 写道:
> On Wed, 7 Sep 2022 17:27:12 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> [...]
>>> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
>>> index b1335de200e7..01938f33038d 100644
>>> --- a/mm/damon/ops-common.c
>>> +++ b/mm/damon/ops-common.c
>>> @@ -172,3 +172,31 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>>>
>>>   	return hotness;
>>>   }
>>> +
>>> +static inline int walk_system_ram(struct resource *res, void *arg)
>>> +{
>>> +	struct damon_addr_range *a = arg;
>>> +
>>> +	if (a->end - a->start < resource_size(res)) {
>>> +		a->start = res->start;
>>> +		a->end = res->end;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Find biggest 'System RAM' resource and store its start and end address in
>>> + * @start and @end, respectively.  If no System RAM is found, returns false.
>>> + */
>>> +bool get_monitoring_region(unsigned long *start, unsigned long *end)
>>> +{
>>> +	struct damon_addr_range arg = {};
>>> +
>>> +	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
>>> +	if (arg.end <= arg.start)
>>> +		return false;
>>> +
>>> +	*start = arg.start;
>>> +	*end = arg.end;
>>> +	return true;
>>> +}
>> 'ops-common.c' is for code that common in monitoring operations
>> implementations.  I'd prefer to have yet another source file for the DAMON
>> modules including reclaim and lru_sort, say, 'modules-common.c'.
> Or, putting it in damon/core.c might make more sense.
Ok,  i will fix them in my next patch, thanks.
>
>
> Thanks,
> SJ
>
> [...]
