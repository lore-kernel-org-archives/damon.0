Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E84683
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 14:06:37 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPtLYHP_1663250787;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPtLYHP_1663250787)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 22:06:28 +0800
Message-ID: <f5bceffb-3168-8a5b-4987-d71eed0c6f93@linux.alibaba.com>
Date: Thu, 15 Sep 2022 22:06:27 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v4] mm/damon: simplify scheme create in lru_sort.c
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220915133041.71819-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220915133041.71819-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

Thanks.

在 2022/9/15 下午9:30, SeongJae Park 写道:
> From: Xin Hao <xhao@linux.alibaba.com>
>
> In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
> they have so much in common, so we can combine them into a single
> function, and we just need to distinguish their differences.
>
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> changes from v3
> (https://lore.kernel.org/damon/20220915023655.41923-1-xhao@linux.alibaba.com/)
> - Cosmetic cleanups
>
> Changes from v2
> (https://lore.kernel.org/linux-mm/20220914113859.37637-1-xhao@linux.alibaba.com/)
> - Add static global 'struct damos_access_pattern' stub variable
>
>   mm/damon/lru_sort.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 46e7c0738bc5..abfaf471e3e9 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -132,6 +132,18 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
>   		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
>   		cold_quota_exceeds);
>   
> +struct damos_access_pattern damon_lru_sort_stub_pattern = {
> +	/* Find regions having PAGE_SIZE or larger size */
> +	.min_sz_region = PAGE_SIZE,
> +	.max_sz_region = ULONG_MAX,
> +	/* no matter its access frequency */
> +	.min_nr_accesses = 0,
> +	.max_nr_accesses = UINT_MAX,
> +	/* no matter its age */
> +	.min_age_region = 0,
> +	.max_age_region = UINT_MAX,
> +};
> +
>   static struct damon_ctx *ctx;
>   static struct damon_target *target;
>   
> @@ -157,36 +169,19 @@ static struct damos *damon_lru_sort_new_scheme(
>   /* Create a DAMON-based operation scheme for hot memory regions */
>   static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>   {
> -	struct damos_access_pattern pattern = {
> -		/* Find regions having PAGE_SIZE or larger size */
> -		.min_sz_region = PAGE_SIZE,
> -		.max_sz_region = ULONG_MAX,
> -		/* and accessed for more than the threshold */
> -		.min_nr_accesses = hot_thres,
> -		.max_nr_accesses = UINT_MAX,
> -		/* no matter its age */
> -		.min_age_region = 0,
> -		.max_age_region = UINT_MAX,
> -	};
> +	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
>   
> +	pattern.min_nr_accesses = hot_thres;
>   	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
>   }
>   
>   /* Create a DAMON-based operation scheme for cold memory regions */
>   static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>   {
> -	struct damos_access_pattern pattern = {
> -		/* Find regions having PAGE_SIZE or larger size */
> -		.min_sz_region = PAGE_SIZE,
> -		.max_sz_region = ULONG_MAX,
> -		/* and not accessed at all */
> -		.min_nr_accesses = 0,
> -		.max_nr_accesses = 0,
> -		/* for min_age or more micro-seconds */
> -		.min_age_region = cold_thres,
> -		.max_age_region = UINT_MAX,
> -	};
> +	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
>   
> +	pattern.max_nr_accesses = 0;
> +	pattern.min_age_region = cold_thres;
>   	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
>   }
>   
