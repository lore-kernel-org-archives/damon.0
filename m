Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189EA5394
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 18:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389CCC43146;
	Thu,  8 Sep 2022 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662661173;
	bh=aee4JNf2/VYGOCDPghmyN52gAudyIcfjOCVDKC8FJiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CwNjTNPHUhcDrGFA2uUnSgAqSFruE21XwMo3AUf53fKBP1RyYyczjM/QiRwJW0Ajt
	 IFFq6CXln828CLg6pnfwSh5u+ZHKLgJnMkH5bu4BnDwT8Z16nWYmES6aqsfx9/4r8+
	 CQik5tQL4ThXyTgCD7yf0KSON/8tfSZEyvn9j7O4mSyQvILm6iqN+syouLFtDz3ds7
	 EZit3N9joK5yIOInBuGdfrZT7XkoMTE7mQGq/EsLt8RhJt3HSR5leyP0JnuQoefC7s
	 VUsbr/hMmVK0sopjDUaxPbzm6rGWSfA3fqDZegSDYq8oz/rrkxgy5Kg9jzCnWn4+jF
	 pmtUs3v8t4cGg==
From: SeongJae Park <sj@kernel.org>
To: xhao@linux.alibaba.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/damon: Remove duplicate get_monitoring_region() definitions
Date: Thu,  8 Sep 2022 18:19:31 +0000
Message-Id: <20220908181931.91994-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908022553.70745-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,


Thanks for your efforts!  But, please answer to some more comments below.

> In lru_sort.c and reclaim.c, they are all defining get_monitoring_region()
> function, there is no need to define it separately.
> 
> BTW, this patch removes two struct 'damon_lru_sort_ram_walk_arg' and
> 'damon_reclaim_ram_walk_arg', though the two structs are removed, if we
> want to add more fields to these structs for other purposes later, it will
> not too late for us to use them again.
> For example:
>     struct damon_reclaim_ram_walk_arg {
> 	struct damon_addr_range raw_walk;
> 	xxx  A;
> 	xxx  B;
>     }
>     struct damon_lru_sort_ram_walk_arg {
> 	struct damon_addr_range raw_walk;
> 	xxx  A;
> 	xxx  B;
>     }

Sorry, seems I didn't make my words clear enough.  What I'm concerning[1] is,
any possible future change to 'struct damon_addr_range', not to
'struct damon_{reclaim,lru_sort}_ram_walk_arg'.

Also, after all, as mentioned before, the purpose of 'struct damon_addr_range'
is not saving the 'start' and 'end' fields of 'struct resource'.  Let's use
different types for different purposes to avoid any unneeded dependencies.

[1] https://lore.kernel.org/damon/20220907172712.61006-1-sj@kernel.org/

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 28 ++++++++++++++++++++++++++++
>  mm/damon/lru_sort.c   | 37 ++-----------------------------------
>  mm/damon/reclaim.c    | 37 ++-----------------------------------
>  4 files changed, 33 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 7b1f4a488230..f27b92e5afc2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -500,6 +500,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
>  void damon_destroy_region(struct damon_region *r, struct damon_target *t);
>  int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  		unsigned int nr_ranges);
> +bool damon_get_sram_monitoring_region(unsigned long *start, unsigned long *end);
> 
>  struct damos *damon_new_scheme(
>  		unsigned long min_sz_region, unsigned long max_sz_region,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7d25dc582fe3..05a2d1b9d03d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -276,6 +276,34 @@ struct damos *damon_new_scheme(
>  	return scheme;
>  }
> 
> +static inline int walk_system_ram(struct resource *res, void *arg)

We will pass pointer to this function.  I guess 'inline' makes no sense?

> +{
> +	struct damon_addr_range *a = arg;
> +
> +	if (a->end - a->start < resource_size(res)) {
> +		a->start = res->start;
> +		a->end = res->end;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Find biggest 'System RAM' resource and store its start and end address in
> + * @start and @end, respectively.  If no System RAM is found, returns false.
> + */
> +bool damon_get_sram_monitoring_region(unsigned long *start, unsigned long *end)

We should avoid too verbose name, so 'sram' looks nice, but it might be able to
be more clear to let readers know what it does.  For an example, how about
'damon_find_biggest_system_ram()'?

Below parts all look good.


Thanks,
SJ

[...]
