Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DCE3C26
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57CBC433C1;
	Tue, 13 Sep 2022 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663089408;
	bh=Uo0FmKOIOqO2xt98KZDO75WMovCewe/BPwr12WzqD+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAlGN2bbSywVp6ZYPZdCV+CdkaorThXnHVupWVu4TBqYco2iF+6ffjoU204Ci59xD
	 QYVctAzw25geHyf0q6pAXfz06rbQk2VZUv9nk6rUhCdG72swQ+NTHuQedhHAFwXnqU
	 IF/lpEivXclmgCb/wuCpAzd6fi4BtKrZsIsQR6wiXTYvkGHlodvO9LRQylSKEgfssc
	 XUdPM18I8xWqEMkAWVCTaSyxWDYNTcQmonggXcRUrOCZiaqGLdvKkpQeH+LJs0X2vo
	 CtPlfprzSMSNhql2Z5OvJh2J6PtKhdNHeSFgLRmhoe6K/tL5axr4CwUmdSVVai4dN3
	 EJ89jtbcc9gJA==
From: SeongJae Park <sj@kernel.org>
To: Dawei Li <set_pte_at@outlook.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Creating kmem cache for damon regions by KMEM_CACHE()
Date: Tue, 13 Sep 2022 17:16:46 +0000
Message-Id: <20220913171646.47472-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <TYCP286MB23233778395A18052E578387CA479@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Sep 2022 00:21:58 +0800 Dawei Li <set_pte_at@outlook.com> wrote:

> Damon regions are dynamic objects which can be created and destroyed
> frequently, a dedicated slab cache is created by KMEM_CACHE(), as
> suggested by akpm.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  mm/damon/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0b1eb945c68a..20163c3c9aa7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1283,8 +1283,7 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
>  
>  static int __init damon_init(void)
>  {
> -	damon_region_cache = kmem_cache_create("damon_region_cache", sizeof(struct damon_region),
> -		0, 0, NULL);
> +	damon_region_cache = KMEM_CACHE(damon_region, 0);

I was about to say about the 80 columns limit, and this fixes it as well.
Thank you, Andrew and Dawei!

>  	if (unlikely(!damon_region_cache)) {
>  		pr_err("creating damon_region_cache fails\n");
>  		return -ENOMEM;
> -- 
> 2.25.1
> 

For this fixup and the initial patch[1],
Reviewed-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/damon/TYCP286MB2323DA1894FA55BB9CF90978CA449@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/


Thanks,
SJ
