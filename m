Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC623D7C
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 14:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58531C433D6;
	Wed, 14 Sep 2022 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663165372;
	bh=Y6zycBhsCZgK5WNKVxWPiDaovSEbTGuLy5Mn5r3GsUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSQ3uaCOQMXH5jgxiHuNWDm6VdOWemg6XW+G1Vy3ZYbVuw2sIw8YCmbISVy9JAqmT
	 CpeIudTMBBSxMJmpIrVYJIf8BtfAIy3hWNwK2eDf9czR7E3uW2YV9uNWFy05ie01Rw
	 z2joeyvRn2/CqeQTtkQcyVgdMhhuN08mFc+RLO+zCTHdP9kjnc3nygzFekLx3pnZ8r
	 s8OAYMDrh2Ai3nZY82CdapbTIBNK0JeP0V3PMbcELbfs+mmo7fTrVsEBXzHVJi5jFR
	 RZDowiWJX4V8McliiljPdIFDwhdUphEbtw9lGj5ECobJXwp6JnGJApdU14+tMzmGWl
	 OrBWUZpvbG3AA==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon: simplify scheme create in lru_sort.c
Date: Wed, 14 Sep 2022 14:22:50 +0000
Message-Id: <20220914142250.1269-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914113859.37637-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Wed, 14 Sep 2022 19:38:59 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
> they have so much in common, so we can combine them into a single
> function, and we just need to distinguish their differences.

Thank you again for patiently waiting for my changes and reworking on this!

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/lru_sort.c | 57 ++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 07a0908963fd..2eac907e866d 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -135,17 +135,40 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
>  static struct damon_ctx *ctx;
>  static struct damon_target *target;
>  
> -static struct damos *damon_lru_sort_new_scheme(
> -		struct damos_access_pattern *pattern, enum damos_action action)
> +static struct damos *damon_lru_sort_new_scheme(unsigned int thres,
> +					       enum damos_action action)
>  {
> +	struct damos_access_pattern pattern = {
> +		/* Find regions having PAGE_SIZE or larger size */
> +		.min_sz_region = PAGE_SIZE,
> +		.max_sz_region = ULONG_MAX,
> +		/* and accessed for more than the threshold */

This comment would be better to be written again?

> +		.min_nr_accesses = 0,
> +		.max_nr_accesses = 0,

If we're gonna set above two fields anyway later, we could simply remove above
three lines.

> +		/* no matter its age */
> +		.min_age_region = 0,
> +		.max_age_region = UINT_MAX,
> +	};
>  	struct damos_quota quota = damon_lru_sort_quota;
>  
>  	/* Use half of total quota for hot/cold pages sorting */
>  	quota.ms = quota.ms / 2;
>  
> +	switch (action) {
> +	case DAMOS_LRU_PRIO:
> +		pattern.min_nr_accesses = thres;
> +		pattern.max_nr_accesses = UINT_MAX;
> +		break;
> +	case DAMOS_LRU_DEPRIO:
> +		pattern.min_age_region = thres;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +

This switch-case makes me wondering if the 'default' case really possible case.
I think it would be clearer to set these from caller.

IMHO, it might be clearer and shorter to define a static global 'struct
damos_access_pattern' stub variable, and make the
damon_lru_sort_new_{hot,cold}_scheme() copies it to their local variable,
update the relevant fields, and pass that to 'damon_new_scheme()'.  What do you
think?

>  	return damon_new_scheme(
>  			/* find the pattern, and */
> -			pattern,
> +			&pattern,
>  			/* (de)prioritize on LRU-lists */
>  			action,
>  			/* under the quota. */
> @@ -157,37 +180,13 @@ static struct damos *damon_lru_sort_new_scheme(
>  /* Create a DAMON-based operation scheme for hot memory regions */
>  static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>  {
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
> -
> -	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
> +	return damon_lru_sort_new_scheme(hot_thres, DAMOS_LRU_PRIO);

If we follow what I suggested above, we could make this like below:

	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;

	pattern.min_nr_accesses = hot_thres;
	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);


>  }
>  
>  /* Create a DAMON-based operation scheme for cold memory regions */
>  static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>  {
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
> -
> -	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
> +	return damon_lru_sort_new_scheme(cold_thres, DAMOS_LRU_DEPRIO);

And similarly here.

>  }
>  
>  static int damon_lru_sort_apply_parameters(void)
> -- 
> 2.31.0
> 
> 


Thanks,
SJ
