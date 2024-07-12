Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65EE17C79
	for <damon@lists.linux.dev>; Fri, 12 Jul 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805255; cv=none; b=gD6zZB/rDcZhfZOip3Jkl12aQTDHUJdHr9MJdLrv6cECgHmS6uBxccJ1GRYsHSl8oWAY34rk+pn4bm+xWMXbXSpB6k3o0McYnak4sGR/s0mmJgQ/Yod6rXAl22MqbgqqmOub0tO5zIXYxNvzU40jN2O5PtDAQ5qgLPB7YHV0AyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805255; c=relaxed/simple;
	bh=7waMwwNK8MYf+jpgfhqNF3xyWHGhNY0MK7uo9wOHPCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZpBbTXAIumpNzL7NaZfZ0Mkb1OkA2QPUUoUP2RveVOysPKIQjzhljzxCdzLIASsk3N1w1xq1UZJXC/9dkMKzrrKbaA67c2fX5VhQtnto/gsdPmqQc7vkgE1eQBaRH1ubs2+LTr0cPL2xXxnpcOmlH7yLC1VFgzRM1VDbIGRLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANo4p/cf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANo4p/cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B582AC32782;
	Fri, 12 Jul 2024 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720805255;
	bh=7waMwwNK8MYf+jpgfhqNF3xyWHGhNY0MK7uo9wOHPCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANo4p/cfHrfeF1qdKgI7qS0eo/0/NmxUhEotj9otTMP/T9k6u5XkW4sBLgCgbXdWl
	 6YsQorbI5vjbaa+UjAFNoKPprYRm8lsza20IPfiMVQyRr6d/3F3GoqlvJGorFoqVhu
	 QyUYA7ZrBeKBvOKCqW99LwV54hkyUkXzVw6coXMTb8znkCxLJZFp3uxc1vawP0I/LZ
	 WMYrCLcYNEaCw4d1fA+FdLeqSsFb3QMFTYtxP7cqHsy52VcJhkKP6l95wthhLZlpGD
	 jKD533gSQqXWVE94+SlVcXR4jjXSHQKDP0JVS5c98tJP0NunjSj3QVcREu0sh+/z0y
	 F7RDphXt2Zj/A==
From: SeongJae Park <sj@kernel.org>
To: flyingpenghao@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH v2]  damon: adjust large arrays to dynamic allocation
Date: Fri, 12 Jul 2024 10:27:31 -0700
Message-Id: <20240712172731.78545-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712010742.26180-1-flyingpeng@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peng,

On Fri, 12 Jul 2024 09:07:42 +0800 flyingpenghao@gmail.com wrote:

> From: Peng Hao <flyingpeng@tencent.com>
> 
> When KASAN is enabled and built with clang:
>     mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
>     static int damon_lru_sort_apply_parameters(void)
>                ^
>     1 error generated.
> 
> This is because damon_lru_sort_quota contains a large array, and
> assigning this variable to a local variable causes a large amount of
> stack space to be occupied.

Is this a successor of a patch[1] that you sent yesterday?  If so, could you
please explain what's the change from the version and why such changes have
made?

[1] https://lore.kernel.org/20240711081051.66560-1-flyingpeng@tencent.com

> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  include/linux/damon.h | 2 +-
>  mm/damon/core.c       | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f7da65e1ac04..8ba0457ab538 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -229,7 +229,7 @@ struct damos_quota {
>  	unsigned long charge_addr_from;
>  
>  	/* For prioritization */
> -	unsigned long histogram[DAMOS_MAX_SCORE + 1];
> +	unsigned long *histogram; //size:DAMOS_MAX_SCORE + 1;
>  	unsigned int min_score;
>  
>  	/* For feedback loop */
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6392f1cc97a3..0614b49fbc35 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -358,6 +358,10 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  {
>  	struct damos *scheme;
>  
> +	unsigned long *histogram = kmalloc(DAMOS_MAX_SCORE + 1, GFP_KERNEL);
> +	if (!histogram)
> +		return NULL;
> +
>  	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
>  	if (!scheme)
>  		return NULL;

Some code allocate damos_quota objects without damon_new_scheme().  For
example, damon_lru_sort_quota.  I think such code should also be updated, to
get this change?  I think it is simpler to keep the histogram as an array as
is and change the stack-allocations as I suggested on the v1, though.

> @@ -375,6 +379,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  	INIT_LIST_HEAD(&scheme->list);
>  
>  	scheme->quota = *(damos_quota_init(quota));
> +	cheme->quota.histogram = histogram;

I think this should s/cheme/scheme/?  Have you checked if this can be compiled?

>  	/* quota.goals should be separately set by caller */
>  	INIT_LIST_HEAD(&scheme->quota.goals);
>  
> @@ -408,6 +413,7 @@ static void damon_del_scheme(struct damos *s)
>  
>  static void damon_free_scheme(struct damos *s)
>  {
> +	kfree(s->quota.histogram);
>  	kfree(s);
>  }
>  
> @@ -1246,7 +1252,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  		return;
>  
>  	/* Fill up the score histogram */
> -	memset(quota->histogram, 0, sizeof(quota->histogram));
> +	memset(quota->histogram, 0, sizeof(*quota->histogram) * (DAMOS_MAX_SCORE + 1));
>  	damon_for_each_target(t, c) {
>  		damon_for_each_region(r, t) {
>  			if (!__damos_valid_target(r, s))
> -- 
> 2.27.0


Thanks,
SJ
