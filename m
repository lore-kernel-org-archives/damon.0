Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356D188CC9;
	Wed, 11 Mar 2026 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190687; cv=none; b=Vr0SspPAEt+OXWpHWgUkVpIkpaq5ifBglo+q3UBwvZZe5f5JSAaxZ7jhiIlo/5YYbw1xpc28L5qRqUL7oiM/i2gZYjAntlAnDoH6r4nr95lNaGCaJ/OEs/A2UewQoZgpNWT02tpkvxLeWlUyZN4NpNz/rXTR2IdKSE4RHj4Cfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190687; c=relaxed/simple;
	bh=jyg5ElLYxunJ9I3b0E/TajPaalo5BRYveddxz/HEQK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyMna8jDs/2BIgRVnlfKhpnWf1dxqUOC0F/jiY9KUDk8EzxZs32yreQjpNFgqSoQVPbKMUWg1ydR2XGogcmxYBgN96CDDF+6Vg5ZxNu2J5GqCBqNIFk0ZLdDjUppbBwczABBrWSXfGq5aQGU3WKvaWydai72wQHDqF0WsVDVqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh99KE/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh99KE/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4997C19423;
	Wed, 11 Mar 2026 00:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190687;
	bh=jyg5ElLYxunJ9I3b0E/TajPaalo5BRYveddxz/HEQK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fh99KE/DhqnrDJho6eon65biSO44MQZEs0C3Ky4ulaN/ck1bLEcEXZKqU8CUvb0K2
	 eTumhiImvvduF9CQizkpz4Vg+2r/1MGAX90yLGY82Z6TFHXU03jyTk5ZELr5p5PX5Z
	 Y+swA5AryIcvp+s+HOyzNNrWSG3SjFiImhdbKODKjNYSAzM7MVfFxoPixD3bGzykAk
	 RHSHceifRiZOwbRxdM1GlCGMlEGleeNw6acQ6HNj8yEcJFY3dMqc7qAaZrgEAgKxg7
	 ZYEhOSJG7b+AG+pcmMKAK8gZPTCgYK+kNfRP3yAmhQZ9uaP35yld8XDi+Tdv4VUBtW
	 KFg0AFeycYz9Q==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] mm/damon: Generic context creation for modules
Date: Tue, 10 Mar 2026 17:57:58 -0700
Message-ID: <20260311005759.90440-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310162420.4180562-2-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Mar 2026 16:24:17 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> It is more elegant to have a generic version of new context creation
> which receives the mode as a parameter.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> ---
>  mm/damon/lru_sort.c       | 5 +++--
>  mm/damon/modules-common.c | 6 +++---
>  mm/damon/modules-common.h | 4 ++--
>  mm/damon/reclaim.c        | 5 +++--
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 7bc5c0b2aea3..143ee0b21da6 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -287,7 +287,8 @@ static int damon_lru_sort_apply_parameters(void)
>  	unsigned int hot_thres, cold_thres;
>  	int err;
>  
> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
> +				DAMON_OPS_PADDR);

I like the name of the function is becoming shorter.  But I'm not happy with
the fact the resulting calling code becomes longer.

I understand you are doing this extension because you want a version of the
function for vaddr.  What about introducing another dedicated function, say,
damon_modules_new_vaddr_ctx_target() ?

And you can avoid duplicates between damon_modules_new_{p,v}addr_ctx_target()
by implementing internal function, say, damon_modules_new_ctx_target() that
receives the damon_ops_id.  And damon_modules_new_{P,v}addr_ctx_target() will
just wrappers of damon_modules_new_ctx_target().

>  	if (err)
>  		return err;
>  
> @@ -479,7 +480,7 @@ static int __init damon_lru_sort_init(void)
>  		err = -ENOMEM;
>  		goto out;
>  	}
> -	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
> +	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);

Ditto.

>  	if (err)
>  		goto out;
>  
> diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
> index 86d58f8c4f63..ae50b2fa3a86 100644
> --- a/mm/damon/modules-common.c
> +++ b/mm/damon/modules-common.c
> @@ -14,8 +14,8 @@
>   * @ctxp:	Pointer to save the point to the newly created context
>   * @targetp:	Pointer to save the point to the newly created target
>   */
> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
> -		struct damon_target **targetp)
> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
> +		struct damon_target **targetp, enum damon_ops_id mode)

Nit.  I'd suggest 'ops_id' as the parameter name, instead of 'mode'.

>  {
>  	struct damon_ctx *ctx;
>  	struct damon_target *target;
> @@ -24,7 +24,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
> +	if (damon_select_ops(ctx, mode)) {
>  		damon_destroy_ctx(ctx);
>  		return -EINVAL;
>  	}
> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
> index f103ad556368..379b49c6a617 100644
> --- a/mm/damon/modules-common.h
> +++ b/mm/damon/modules-common.h
> @@ -45,5 +45,5 @@
>  	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>  			0400);
>  
> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
> -		struct damon_target **targetp);
> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
> +		struct damon_target **targetp, enum damon_ops_id mode);
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 43d76f5bed44..24786a58683a 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -197,7 +197,8 @@ static int damon_reclaim_apply_parameters(void)
>  	struct damos_filter *filter;
>  	int err;
>  
> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
> +				DAMON_OPS_PADDR);
>  	if (err)
>  		return err;
>  
> @@ -381,7 +382,7 @@ static int __init damon_reclaim_init(void)
>  		err = -ENOMEM;
>  		goto out;
>  	}
> -	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
> +	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);
>  	if (err)
>  		goto out;
>  
> -- 
> 2.43.0


Thanks,
SJ
