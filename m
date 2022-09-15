Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09774432
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 12:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E612DC433C1;
	Thu, 15 Sep 2022 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663246617;
	bh=0YYhlVZr51ds6IDmxe96b/4kNh0ebUmNgb2g/5RzZd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ho5gilAnV1TCQPX4nx3XVupNriNZWIdMId6CgbvJ4Cku2Dv62CdWbN/37LiIfRLFb
	 qxCxVstAm+asx6KA5oBOVSeEtVykuLnR2POdjuvURklrwBwEmFHJFsUEpFrYxJBbEG
	 4OUgOQR/kUeAzNz0PrJDszzBlUvCVKdGicXoQf4S0g1FZHnHJ5ZY1f812F3LtMuYHa
	 ltf6UcuBqxxDr4iEVJlf6f0IfjSu+TufQ9EFqlzYcJak5sD6tKlCo3FHwa1/I2KGum
	 TfBQSdJk7pYZYRBT0M9j8ewWcwmg6f0BexRf4IwiBl8+DFm5zWKpY4llMTwe2kthVp
	 0AgnO0ArHxZqA==
From: SeongJae Park <sj@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	sj@kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH -next 1/2] mm/damon/reclaim: change damon_reclaim_wmarks to static
Date: Thu, 15 Sep 2022 12:56:55 +0000
Message-Id: <20220915125655.53157-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915021024.4177940-1-yangyingliang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yang,

On Thu, 15 Sep 2022 10:10:23 +0800 Yang Yingliang <yangyingliang@huawei.com> wrote:

> damon_reclaim_wmarks is only used in reclaim.c now, change it to static.
> 
> Fixes: 89dd02d8abd1 ("mm/damon/reclaim: use watermarks parameters generator macro")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/reclaim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 1acf808e1624..039fa55e0ae9 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -64,7 +64,7 @@ static struct damos_quota damon_reclaim_quota = {
>  };
>  DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_reclaim_quota);
>  
> -struct damos_watermarks damon_reclaim_wmarks = {
> +static struct damos_watermarks damon_reclaim_wmarks = {
>  	.metric = DAMOS_WMARK_FREE_MEM_RATE,
>  	.interval = 5000000,	/* 5 seconds */
>  	.high = 500,		/* 50 percent */
> -- 
> 2.25.1
> 
> 
