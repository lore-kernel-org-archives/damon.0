Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537474432
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 13:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756F3C433C1;
	Thu, 15 Sep 2022 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663248309;
	bh=Gb5oZy6RnTceRQbOziJ4KgVxczFZF2fhx7aQxPEvhXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nu1Lnhz+MHfX9ihuQXhpnvk9r8SPYmXjWoD4InARYOYcDGZ70ZW27t3Fu+N8NrMgc
	 0ZE52QoyDTxPsWEhRS0C2jALhePjZloSMDdd/iGbm4UMPcGI71jPV3W9IKOlsNEXvY
	 hTe9ixJsDVyRVhjtY2CArgwgk0Z7R10Fz2wA2lKrwYW1LaN3HbTsW2VB8psPe9tqrX
	 XfrGfz5BWkwCBAAKNDdhfkGSJ59XoWsp0bjwWFFbQomFQtcgqUl4aVADA+UJ0jOHgd
	 V4GopiM8LDfZ3E7yW6AqV/6aBn/vzh6OOJO0CriIcLFDolbSUu+RAZqkMkk99ILWre
	 EUHLYjKdDEv9Q==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/damon: simplify scheme create in lru_sort.c
Date: Thu, 15 Sep 2022 13:25:06 +0000
Message-Id: <20220915132506.65586-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915023655.41923-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Thu, 15 Sep 2022 10:36:55 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
> they have so much in common, so we can combine them into a single
> function, and we just need to distinguish their differences.
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Changes from v2
> (https://lore.kernel.org/linux-mm/20220914113859.37637-1-xhao@linux.alibaba.com/)
> - Add static global 'struct damos_access_pattern' stub variable

Chagelog should not be in the commit message area,

> ---

but here.

>  mm/damon/lru_sort.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 07a0908963fd..6a26c5822286 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -132,6 +132,18 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
>  		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
>  		cold_quota_exceeds);
> 
> +struct damos_access_pattern damon_lru_sort_stub_access_pattern = {
> +	/* Find regions having PAGE_SIZE or larger size */
> +	.min_sz_region = PAGE_SIZE,
> +	.max_sz_region = ULONG_MAX,
> +	/* and accessed for more than the threshold */

This comment looks inappropriate.  How about 'no matter its access frequency'?

> +	.min_nr_accesses = 0,
> +	.max_nr_accesses = UINT_MAX,
> +	/* no matter its age */
> +	.min_age_region = 0,
> +	.max_age_region = UINT_MAX,
> +};
> +
>  static struct damon_ctx *ctx;
>  static struct damon_target *target;
> 
> @@ -157,17 +169,9 @@ static struct damos *damon_lru_sort_new_scheme(
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
> +	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;

More than 80 columns.  Renaming stub_access_pattern into stub_pattern might
make sense.

> +
> +	pattern.min_nr_accesses = hot_thres;
> 
>  	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
>  }
> @@ -175,17 +179,10 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
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
> +	struct damos_access_pattern pattern = damon_lru_sort_stub_access_pattern;

More than 80 columns.

> +
> +	pattern.max_nr_accesses = 0;
> +	pattern.min_age_region = cold_thres;
> 
>  	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
>  }
> --
> 2.31.0

Other than the trivial things, look good.  As my comments are only for trivial
cosmetic things, I will make the change and post v4 on my own.


Thanks,
SJ
