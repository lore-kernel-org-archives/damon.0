Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637A1847
	for <damon@lists.linux.dev>; Tue, 17 May 2022 15:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64429C385B8;
	Tue, 17 May 2022 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652802258;
	bh=3JSsXFST9KyoIwls6TvVF+LwrCQkhOldDosferXWQ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=jyCOSe3sU2KM84gZWi0Cr0liF05JQ9Vs2NENC6Cy8KJUyEM6GbI+TbhJnS+4mSeu2
	 rZn05+rg0iOX2y+CNgnmqUpLmByMKy9SoL++HGXhzppm24/3THyBuIv6/N8B4R+gFU
	 SOYtSRCLZgEoAxEFe0PX63ZN7bSMKzrfGHW+7xwbqUfnLOhzDU9+DFSpnlmBSDv+pn
	 KMmTYEvlRzrAPNljiJf1sdG772Fu6aJ1hmPvllxErNfuGrlXMYf7ruoLC+5MHYGS2P
	 qCKv7LwRhj2MgTMKOh3t29vq1mDBiCO+ATHxCG71Dzyw5evXlcJQ/bvaUFULOCwmqg
	 4CQxHry6eaQXA==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: damon: Use HPAGE_PMD_SIZE
Date: Tue, 17 May 2022 08:44:16 -0700
Message-Id: <20220517154416.32646-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517145120.118523-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi Kefeng,

On Tue, 17 May 2022 22:51:20 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Using HPAGE_PMD_SIZE instead of open code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/ops-common.c | 3 +--
>  mm/damon/paddr.c      | 2 +-
>  mm/damon/vaddr.c      | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index e346cc10d143..10ef20b2003f 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -73,8 +73,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
>  	}
>  
>  #ifdef CONFIG_MMU_NOTIFIER
> -	if (mmu_notifier_clear_young(mm, addr,
> -				addr + ((1UL) << HPAGE_PMD_SHIFT)))
> +	if (mmu_notifier_clear_young(mm, addr, addr + HPAGE_PMD_SIZE))
>  		referenced = true;
>  #endif /* CONFIG_MMU_NOTIFIER */
>  
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 21474ae63bc7..b40ff5811bb2 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -106,7 +106,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
>  			result->accessed = pmd_young(*pvmw.pmd) ||
>  				!folio_test_idle(folio) ||
>  				mmu_notifier_test_young(vma->vm_mm, addr);
> -			result->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
> +			result->page_sz = HPAGE_PMD_SIZE;
>  #else
>  			WARN_ON_ONCE(1);
>  #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 9a56ff60f244..5767be72c181 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -443,7 +443,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		if (pmd_young(*pmd) || !page_is_idle(page) ||
>  					mmu_notifier_test_young(walk->mm,
>  						addr)) {
> -			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
> +			*priv->page_sz = HPAGE_PMD_SIZE;
>  			priv->young = true;
>  		}
>  		put_page(page);
> -- 
> 2.35.3
