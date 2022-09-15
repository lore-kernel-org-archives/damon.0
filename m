Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C294432
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 12:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC6FC433C1;
	Thu, 15 Sep 2022 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663246679;
	bh=soVQFcFVYD22JcFsKPqxSh2D+yi5kfsMORSJ4osgWnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFvnsFypCQ+nKYq4C1tQX808TfU3RLcLyao8AFEUSgw4dWyXvmheoARG1kQ1SEdFm
	 gWXydTaTVxy4oslYoZlNYbSUnr2RoJjJuDjUKg2jq245n1n1RTV27tiEGyxdH0gbAD
	 +I+0uLbpeNi7+/rXd8pzVlw7nUmk+IrTijFVdcns/UBKFdbj5HDq4VZ8sxziR7zWRE
	 Y1NZ0rg97lvYJx4d291EYdaBTsI7xcDuWhjdPmjis+v9hj3Ad2ys3AgeGWFHfGGedk
	 uXDSLjcAD1+PusNI7ZxzCg3VD/r9YfYYH4LtwD19GEVjJIOHO5tq76GqfEjkOMYzDi
	 vC4wmy79NIsYQ==
From: SeongJae Park <sj@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	sj@kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH -next 2/2] mm/damon/lru_sort: change damon_lru_sort_wmarks to static
Date: Thu, 15 Sep 2022 12:57:57 +0000
Message-Id: <20220915125757.58988-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915021024.4177940-2-yangyingliang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Sep 2022 10:10:24 +0800 Yang Yingliang <yangyingliang@huawei.com> wrote:

> damon_lru_sort_wmarks is only used in lru_sort.c now, change it to static.
> 
> Fixes: 189aa3d58206 ("mm/damon/lru_sort: use watermarks parameters generator macro")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/lru_sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 07a0908963fd..46e7c0738bc5 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -77,7 +77,7 @@ static struct damos_quota damon_lru_sort_quota = {
>  };
>  DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_lru_sort_quota);
>  
> -struct damos_watermarks damon_lru_sort_wmarks = {
> +static struct damos_watermarks damon_lru_sort_wmarks = {
>  	.metric = DAMOS_WMARK_FREE_MEM_RATE,
>  	.interval = 5000000,	/* 5 seconds */
>  	.high = 200,		/* 20 percent */
> -- 
> 2.25.1
