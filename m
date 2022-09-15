Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713444683
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 14:03:45 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPtHaYT_1663250614;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPtHaYT_1663250614)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 22:03:35 +0800
Message-ID: <fa354d0a-c997-7e21-2b35-22554a33ecdc@linux.alibaba.com>
Date: Thu, 15 Sep 2022 22:03:34 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V3] mm/damon: simplify scheme create in lru_sort.c
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220915132506.65586-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220915132506.65586-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/15 下午9:25, SeongJae Park 写道:
> Hi Xin,
>
> On Thu, 15 Sep 2022 10:36:55 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
>> they have so much in common, so we can combine them into a single
>> function, and we just need to distinguish their differences.
>>
>> Suggested-by: SeongJae Park <sj@kernel.org>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> Changes from v2
>> (https://lore.kernel.org/linux-mm/20220914113859.37637-1-xhao@linux.alibaba.com/)
>> - Add static global 'struct damos_access_pattern' stub variable
> Chagelog should not be in the commit message area,
>
>> ---
> but here.
>
>>   mm/damon/lru_sort.c | 41 +++++++++++++++++++----------------------
>>   1 file changed, 19 insertions(+), 22 deletions(-)
>>
>> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
>> index 07a0908963fd..6a26c5822286 100644
>> --- a/mm/damon/lru_sort.c
>> +++ b/mm/damon/lru_sort.c
>> @@ -132,6 +132,18 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
>>   		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
>>   		cold_quota_exceeds);
>>
>> +struct damos_access_pattern damon_lru_sort_stub_access_pattern = {
>> +	/* Find regions having PAGE_SIZE or larger size */
>> +	.min_sz_region = PAGE_SIZE,
>> +	.max_sz_region = ULONG_MAX,
>> +	/* and accessed for more than the threshold */
> This comment looks inappropriate.  How about 'no matter its access frequency'?
>
>> +	.min_nr_accesses = 0,
>> +	.max_nr_accesses = UINT_MAX,
>> +	/* no matter its age */
>> +	.min_age_region = 0,
>> +	.max_age_region = UINT_MAX,
>> +};
>> +
>>   static struct damon_ctx *ctx;
>>   static struct damon_target *target;
>>
>> @@ -157,17 +169,9 @@ static struct damos *damon_lru_sort_new_scheme(
>>   /* Create a DAMON-based operation scheme for hot memory regions */
>>   static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>>   {
>> -	struct damos_access_pattern pattern = {
>> -		/* Find regions having PAGE_SIZE or larger size */
>> -		.min_sz_region = PAGE_SIZE,
>> -		.max_sz_region = ULONG_MAX,
>> -		/* and accessed for more than the threshold */
>> -		.min_nr_accesses = hot_thres,
>> -		.max_nr_accesses = UINT_MAX,
>> -		/* no matter its age */
>> -		.min_age_region = 0,
>> -		.max_age_region = UINT_MAX,
>> -	};
>> +	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;
> More than 80 columns.  Renaming stub_access_pattern into stub_pattern might
> make sense.
>
>> +
>> +	pattern.min_nr_accesses = hot_thres;
>>
>>   	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
>>   }
>> @@ -175,17 +179,10 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>>   /* Create a DAMON-based operation scheme for cold memory regions */
>>   static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>>   {
>> -	struct damos_access_pattern pattern = {
>> -		/* Find regions having PAGE_SIZE or larger size */
>> -		.min_sz_region = PAGE_SIZE,
>> -		.max_sz_region = ULONG_MAX,
>> -		/* and not accessed at all */
>> -		.min_nr_accesses = 0,
>> -		.max_nr_accesses = 0,
>> -		/* for min_age or more micro-seconds */
>> -		.min_age_region = cold_thres,
>> -		.max_age_region = UINT_MAX,
>> -	};
>> +	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;
> More than 80 columns.
>
>> +
>> +	pattern.max_nr_accesses = 0;
>> +	pattern.min_age_region = cold_thres;
>>
>>   	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
>>   }
>> --
>> 2.31.0
> Other than the trivial things, look good.  As my comments are only for trivial
> cosmetic things, I will make the change and post v4 on my own.
Ok,  thank you very much for such a detailed review.
>
> Thanks,
> SJ
