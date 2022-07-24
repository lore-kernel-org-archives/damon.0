Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CD7E
	for <damon@lists.linux.dev>; Sun, 24 Jul 2022 07:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E2C341C0;
	Sun, 24 Jul 2022 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1658647135;
	bh=cilKIlwRX04/ZKOXRDFJP5xqs9Q3uNUGrabQaZJDLLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3WH1Wi1dbsD67j89JBDezOse91s5xYCoDwsT6nHSrW4o7eLNPdwJoMEVL9XYG44E
	 v+peqz/qnKjCwVbrSC6aUeMO3x8XiHy44MncJU6eieR2h4MxGWAsXbaQlWjS1y6Jax
	 uwbP74TrDuvey7rGo+63ttT9Ma+huBfPZD7pTpbo=
Date: Sun, 24 Jul 2022 09:18:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: fix potential memory leak in
 damon_reclaim_init()
Message-ID: <YtzyXCR/OCLYRSPx@kroah.com>
References: <20220724065224.2555966-1-niejianglei2021@163.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724065224.2555966-1-niejianglei2021@163.com>

On Sun, Jul 24, 2022 at 02:52:24PM +0800, Jianglei Nie wrote:
> damon_reclaim_init() allocates a memory chunk for ctx with
> damon_new_ctx(). When damon_select_ops() fails, ctx is not released, which
> will lead to a memory leak.
> 
> We should release the ctx with damon_destroy_ctx() when damon_select_ops()
> fails to fix the memory leak.
> 
> Fixes: 4d69c3457821 ("mm/damon/reclaim: use damon_select_ops() instead of damon_{v,p}a_set_operations()")
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  mm/damon/reclaim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 4b07c29effe9..0b3c7396cb90 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -441,8 +441,10 @@ static int __init damon_reclaim_init(void)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
> +	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
> +		damon_destroy_ctx(ctx);
>  		return -EINVAL;
> +	}
>  
>  	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
>  	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
> -- 
> 2.25.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
