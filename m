Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE27462
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 16:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D890C433D6;
	Tue, 20 Sep 2022 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663692760;
	bh=Oh2dl9d4nX47VYSB8qPNmpq1Zk2XZIiNPnT0V++Qr88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4tmSnx++nKzK93WeJaV1LJZTXiy04Vj/m2fiS4zMjVm3fdUmiE3hOrgYsh1xagPC
	 7vzBqiG3MDNCUgU5sZkuwB9NG7ycZuyej3zkymiFHt/Stmjr0io6cnFghApGfA+56v
	 g5XZP9SHiZhxWEKic4knqIFLCBKw7DDYWrJ41GVuf8mI3h7ikRx/wwt4SLvJQdlssf
	 5aAMwzfdblmpOpadJnKcg1I2AiJ0NWDqiNmOQx7kVYbP/3wZCWFQxxSo4dGrg9eod+
	 N43K7tq8t+bJPZuFk1lRee1oM+WI9y0L7dRZ34P3Ee6RQgKeWOC5RFl5Dj3ZBWoOJd
	 U/HnolC7c05Bg==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
Date: Tue, 20 Sep 2022 16:52:38 +0000
Message-Id: <20220920165238.59328-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663645461-21084-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Sep 2022 11:44:21 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The bodies of damon_{reclaim,lru_sort}_apply_parameters() contain
> duplicates. This commit add a common function
> damon_set_region_biggest_system_ram_default() to removes the
> duplicates.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> Suggested-by: SeongJae Park <sj@kernel.org>
> ---
> v2:
>  -change the common function name and add kernel comment.
> 
>  include/linux/damon.h |  3 ++-
>  mm/damon/core.c       | 35 ++++++++++++++++++++++++++++++++++-
>  mm/damon/lru_sort.c   | 13 +++----------
>  mm/damon/reclaim.c    | 13 +++----------
>  4 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index e7808a84675f..ed5470f50bab 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>  
> -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
> +int damon_set_region_biggest_system_ram_default(struct damon_target *t,
> +				unsigned long *start, unsigned long *end);
>  
>  #endif	/* CONFIG_DAMON */
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9c80c6eb00c2..9e96cb9fb5db 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1245,7 +1245,8 @@ static int walk_system_ram(struct resource *res, void *arg)
>   * Find biggest 'System RAM' resource and store its start and end address in
>   * @start and @end, respectively.  If no System RAM is found, returns false.
>   */
> -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
> +static bool damon_find_biggest_system_ram(unsigned long *start,
> +						unsigned long *end)
>  
>  {
>  	struct damon_system_ram_region arg = {};
> @@ -1259,6 +1260,38 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
>  	return true;
>  }
>  
> +/*

We also need to add one more asterisk here to make this a valid kerneldoc
comment.

> + * damon_set_region_biggest_system_ram_default() - Set the region of the given
> + * monitoring target as requested, or biggest 'System RAM'.
> + * @t:		The monitoring target to set the region.
> + * @start:	The pointer to the start address of the region.
> + * @end:	The pointer to the end address of the region.
> + *
> + * This function sets the region of @t as requested by @start and @end.  If the
> + * values of the two pointers are pointing to are zero, however, this function
> + * finds the biggest 'System RAM' resource and set the region to cover the
> + * resource.  In the latter case, this function saves the start and end address
> + * of the resource in @start and @end, respectively.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_set_region_biggest_system_ram_default(struct damon_target *t,
> +			unsigned long *start, unsigned long *end)
> +{
> +	struct damon_addr_range addr_range;
> +
> +	if (*start > *end)
> +		return -EINVAL;
> +
> +	if (!*start && !*end &&
> +		!damon_find_biggest_system_ram(start, end))
> +		return -EINVAL;
> +
> +	addr_range.start = *start;
> +	addr_range.end = *end;
> +	return damon_set_regions(t, &addr_range, 1);
> +}
> +
[...]

Thanks,
SJ
