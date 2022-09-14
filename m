Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D7F
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 09:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DA3C433D7;
	Wed, 14 Sep 2022 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663149128;
	bh=ET7xbCmKy/wqjVqLOdaW4rsp6pDFPXzpeLtwj+QaumI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esymQ/kJqQsK2cqJ9IZ7oY0Clu6YyLsT78uqOUlEhaCBDCgX6jFu9XKPrNZbryLiu
	 6gH+q1Ov9/ZtXtPZHp5CXJ8+gqf9OR2vxM2tGKcXBIv5MrUVfvPcPEd7EEeOtAzzhh
	 VGkQH+tmS7nOCtRVn1ZIva/jZ1xxnVoHpaCsIzjTiTgwO7iMeUzZHFMYYABRplL7kY
	 ltnM6yGDX236aK+iETeMDt4t6S949SL/zDISOkTUvkR4hUs+v332jQK1b3fGt9mKGr
	 Tf5l+kJt69JuC/mWYDTZQIdPnopU0XjHgk39Chm+IRi5H1Bev35sWWFW2JRxAplCal
	 fCBGBjgBXBQnQ==
From: SeongJae Park <sj@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	sieberf@amazon.com,
	shakeelb@google.com,
	foersleo@amazon.de,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix missing damon_del_region()
Date: Wed, 14 Sep 2022 09:52:06 +0000
Message-Id: <20220914095206.70459-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093636.1184590-1-yajun.deng@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yajun,

On Wed, 14 Sep 2022 17:36:36 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> It should be called damon_del_region() before free each region, so use
> damon_destroy_region() instead of damon_free_region().

What 'damon_del_region()' does is deleting the region from target's regions
linked list so that nobody references it later after its freed.  However, as
each region is linked to one target, and as we will free the target here, the
list will also be freed.  Therefore, we don't need to worry about future
references to the region.

Anything I'm missing?


Thanks,
SJ

> 
> Fixes: f23b8eee1871 (mm/damon/core: implement region-based sampling)
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0b1eb945c68a..e62e7ebf4b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -361,7 +361,7 @@ void damon_free_target(struct damon_target *t)
>  	struct damon_region *r, *next;
>  
>  	damon_for_each_region_safe(r, next, t)
> -		damon_free_region(r);
> +		damon_destroy_region(r, t);
>  	kfree(t);
>  }
>  
> -- 
> 2.25.1
