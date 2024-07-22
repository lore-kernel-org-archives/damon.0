Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C316EB58
	for <damon@lists.linux.dev>; Mon, 22 Jul 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669802; cv=none; b=tOQHNKkj+M2nPagVK299qr/NlW8sZwJZFRHBBjXWdmTYlBxqU2voxqEnFGR66ghPfCqLuDOtvT4FzEn+oE8C4ZzXK+UUDFniQyS4xd7/sttvfl96/9wIvujEGAWQzbgWrYd4lXxXLnDNcJ1YQIHuAeW37idmRswuVI88Hk/N7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669802; c=relaxed/simple;
	bh=t4OYvXxpGDNpOWZwR6WXOqyG0BXa9H36Sv8zqFWKB80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+KeaWn8vtgFEr5AutXNTcx3dJm8B8y8/QAh+Os3dEPctiazLH3fKoekKIxdeuwSkxgBbS/x364Ipub8k/GzJKZqCDJBgCICNzJeHZfAmef3opmHlr4iYRc7Wfr/TW5RuDEMYRalD6OUQGh2HF5tdp8PDuDuzbiIrfBW/LOlyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXasLMDM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXasLMDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19629C116B1;
	Mon, 22 Jul 2024 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721669801;
	bh=t4OYvXxpGDNpOWZwR6WXOqyG0BXa9H36Sv8zqFWKB80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXasLMDMeH3mwpREBTXtP5zagUH4ISrLuzCKip1uxwMQpySCEPs3Y8tPD80+AqFgc
	 HKpcnRekFRTNgD9kiJf+RjtSpDD9JWChfjKAxU3Mx/jC1eAJEKYW9T10q1QITcXEC2
	 LCTQSUdBNjfck8cMkjqN8TKkZ9JsfVEWOYVDf9HN2CryEHXdzcf996LEEZIFzsbL6H
	 MqQ9wfDl+WnieoWy9tGZAWEqhf5kPji2UJNULQEdFyh3vi3xknzO5Xinztq5qNvr/Y
	 anM2AvywmfmZRfGl2zJjs4HtmrWRzYjPygbCJ48S0v9LC/LIwzecqDORWCPWiRzwJV
	 /5YxBPAUercdw==
From: SeongJae Park <sj@kernel.org>
To: flyingpenghao@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH v4]  mm/damon/lru_sort: adjust local variable to dynamic allocation
Date: Mon, 22 Jul 2024 10:36:38 -0700
Message-Id: <20240722173638.361530-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722053033.92453-1-flyingpeng@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peng,


On Mon, 22 Jul 2024 13:30:33 +0800 flyingpenghao@gmail.com wrote:

> From: Peng Hao <flyingpeng@tencent.com>
> 
> When KASAN is enabled and built with clang:
>     mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds
> limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
>     static int damon_lru_sort_apply_parameters(void)
>                ^
>     1 error generated.
> 
> This is because damon_lru_sort_quota contains a large array, and
> assigning this variable to a local variable causes a large amount of
> stack space to be occupied.
> 
> So adjust local variable to dynamic allocation.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  v3 -> v4: adjust release point, tweak format, etc.
>  v2 -> v3: don't change histgram array in damon_quota, dynamically 
>            allocating local variables 
>  v1 -> v2: don't modify global variables and change the histgram array in
>            damon_quota to dynamic allocation

To help people finding the previous versions easy, I'd suggest adding
lore.kernel.org links for the versions here together.  For an example, you
could refer to https://lore.kernel.org/20240621163626.74815-1-sj@kernel.org

> 
>  mm/damon/lru_sort.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

This patch cannot cleanly applied on latest mm-unstable tree.  Could you please
rebase this to it and send again?

> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 3de2916a65c3..57bcb3b531ff 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -148,12 +148,18 @@ static struct damon_target *target;
>  static struct damos *damon_lru_sort_new_scheme(
>  		struct damos_access_pattern *pattern, enum damos_action action)
>  {
> -	struct damos_quota quota = damon_lru_sort_quota;
> +	struct damos *damos;
> +
> +	struct damos_quota *quota = kmemdup(&damon_lru_sort_quota,
> +				    sizeof(damon_lru_sort_quota), GFP_KERNEL);

I don't think we need the above empty space between two variables definitions.

> +
> +	if (!quota)
> +		return NULL;
>  
>  	/* Use half of total quota for hot/cold pages sorting */
> -	quota.ms = quota.ms / 2;
> +	quota->ms = quota->ms / 2;
>  
> -	return damon_new_scheme(
> +	damos = damon_new_scheme(
>  			/* find the pattern, and */
>  			pattern,
>  			/* (de)prioritize on LRU-lists */
> @@ -161,9 +167,11 @@ static struct damos *damon_lru_sort_new_scheme(
>  			/* for each aggregation interval */
>  			0,
>  			/* under the quota. */
> -			&quota,
> +			quota,
>  			/* (De)activate this according to the watermarks. */
>  			&damon_lru_sort_wmarks);
> +	kfree(quota);
> +	return damos;
>  }
>  
>  /* Create a DAMON-based operation scheme for hot memory regions */
> -- 
> 2.27.0

Other than above comments, looks good to me overall.


Thanks,
SJ
