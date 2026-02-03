Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F2219A8E;
	Tue,  3 Feb 2026 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081401; cv=none; b=bQicp03luMapUoHPWp8RepuInF90W7stiovzenNPyVcDJpaYDYFsZFMywVlVbEIAqJwMTVdSwlyAuOHVHQB6z04wUUtd3nTbdi+84EveIXnovDZVyc6Tzs9A3OFWqSlOz/B5jL1JTj5UidKtoKraH6zu+U5BnLNfmtp57JRp8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081401; c=relaxed/simple;
	bh=kn7H58JeQWh7SXTUCnPWTlVxHhs2VbysDeSgAogieX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAlVrvc4jSpdj33sFGxQsvVRL+NhDMLrIkrDWJPEFnXyxiE97eq8ydk4mwwgvqjSJ37nQC+Y0JMOTe25r8bQ7d4NUihKJrtGHggD2HFkUGRa9UYjKRpJ44fpaat+1g32DwOIPZqOnAbWuuNxx8lLFoq9x/tiJW9z7vqMktcq1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSBJQWqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSBJQWqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B6C116C6;
	Tue,  3 Feb 2026 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081400;
	bh=kn7H58JeQWh7SXTUCnPWTlVxHhs2VbysDeSgAogieX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSBJQWqgZx9ncZ+q8r6q9LJjjl4q0vDNw41PBdMO8QBPcPsMzZsx8EtAva8NeJIRC
	 WQy3Tm4VK30PCyeOJJG/CQNA8FoMa++mWavvypEk0I3ZeGno4ryTSZ/7b9yfmF0KZA
	 4b+dY9TgPx94dsqp3V7WNSA/k+0spV4u73C3DGpA+I3lKLpKrjfuw9WPEwYB7v+aZS
	 pbrs96S4ZRAY3bJRxRWGdo/HbJF/NdKz0J+JyAK8NDF8JuzXcnS5iTRo5YJhUD4qZ9
	 IYPAKQ3+jCNXSj9rmFNGUYbliYxsvaJehpBkIRoxj7gdCLeYByVRxF/3NxhvAE5Ioi
	 GPigfEExHFgQw==
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
Subject: Re: [RFC PATCH v1 1/4] mm/damon: Generic context creation for modules
Date: Mon,  2 Feb 2026 17:16:32 -0800
Message-ID: <20260203011633.67532-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202145650.1795854-2-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use 'mm/damon/modules-common:' as the commit subject prefix.

On Mon, 2 Feb 2026 14:56:46 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Damon_modules_new_paddr_ctx_target. This works  only for physical contexts.

Let's be case-sensitive.  s/Damon_/damon_/ ?

> In case of virtual addresses, we should  duplicate the code.
> 
> It is more elegant to have a generic version of new context creation which
> receives the mode as a parameter.

Makes sense to me.

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> ---
>  mm/damon/lru_sort.c       | 6 ++++--
>  mm/damon/modules-common.c | 7 ++++---
>  mm/damon/modules-common.h | 5 +++--
>  mm/damon/reclaim.c        | 5 +++--
>  4 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 49b4bc294f4e..ac34b02dace8 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -201,7 +201,8 @@ static int damon_lru_sort_apply_parameters(void)
>  	unsigned int hot_thres, cold_thres;
>  	int err;
>  
> -	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
> +				DAMON_OPS_PADDR);
>  	if (err)
>  		return err;
>  
> @@ -375,7 +376,8 @@ static int __init damon_lru_sort_init(void)
>  		err = -ENOMEM;
>  		goto out;
>  	}
> -	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
> +	err = damon_modules_new_ctx_target(&ctx, &target,
> +				DAMON_OPS_PADDR);

You could put the above line on the line before that without violating the 80
columns limit :)

>  	if (err)
>  		goto out;
>  
> diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
> index 86d58f8c4f63..5ba24e0ad9a1 100644
> --- a/mm/damon/modules-common.c
> +++ b/mm/damon/modules-common.c
> @@ -14,8 +14,9 @@
>   * @ctxp:	Pointer to save the point to the newly created context
>   * @targetp:	Pointer to save the point to the newly created target
>   */
> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
> -		struct damon_target **targetp)
> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
> +				struct damon_target **targetp,
> +				enum damon_ops_id mode)

You should also update the kernel-doc comments for the new parameter.

>  {
>  	struct damon_ctx *ctx;
>  	struct damon_target *target;
> @@ -24,7 +25,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
> +	if (damon_select_ops(ctx, mode)) {
>  		damon_destroy_ctx(ctx);
>  		return -EINVAL;
>  	}
> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
> index f103ad556368..87d8058d7d85 100644
> --- a/mm/damon/modules-common.h
> +++ b/mm/damon/modules-common.h
> @@ -45,5 +45,6 @@
>  	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>  			0400);
>  
> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
> -		struct damon_target **targetp);
> +int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
> +				struct damon_target **targetp,
> +				enum damon_ops_id mode);
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 36a582e09eae..b64fb810e096 100644
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
> @@ -379,7 +380,7 @@ static int __init damon_reclaim_init(void)
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

Overall, looks good for RFC.


Thanks,
SJ
