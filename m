Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DFA460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 21:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FEDC433D2;
	Thu,  8 Dec 2022 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670536590;
	bh=bFNu3vNOxRzISUHbhrcGwqprv78edRC0TLjOn0yrO78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgg7917lyxodDm1WbIW+2Tx+zBacForxyiPmNzhfg6WQBEX9JAXM3Jn46tHhaTcAN
	 C9rOtlO1PHDlbL1jjSAjp52xrx+axl9hp2KyZk4HoWiLFh3pQbYlo+A8aeDuKfc7o6
	 mw6cxE6S5wGxkZmJmkPX7FUjSXHlxgZ1EOxoo6lqkbTsrzEyKrj/3dlenhdGtrT5VD
	 FMeANQ2guYHBdQO2BTsXk0yr4wm47pskJ0vHDor432z2HK4mrJvHRSmropCawyGgyu
	 z4ebrnz/2eDrxvNSHX93Q5702Hi/IW8Eyj2qBqwaimluETtvYXYYgNdKhT9yT33yel
	 Yz/2RyOIlKVkQ==
From: SeongJae Park <sj@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org
Subject: Re: [PATCH v3 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
Date: Thu,  8 Dec 2022 21:56:27 +0000
Message-Id: <20221208215627.116940-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208203503.20665-5-vishal.moola@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Dec 2022 12:35:03 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> Deactivate_page() has already been converted to use folios, this change
> converts it to take in a folio argument instead of calling page_folio().
> It also renames the function folio_deactivate() to be more consistent
> with other folio functions.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/swap.h |  2 +-
>  mm/damon/paddr.c     |  2 +-
>  mm/madvise.c         |  4 ++--
>  mm/swap.c            | 14 ++++++--------
>  4 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a18cf4b7c724..6427b3af30c3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -409,7 +409,7 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> -extern void deactivate_page(struct page *page);
> +void folio_deactivate(struct folio *folio);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);
>  
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 73548bc82297..6b36de1396a4 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -247,7 +247,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  		if (mark_accessed)
>  			folio_mark_accessed(folio);
>  		else
> -			deactivate_page(&folio->page);
> +			folio_deactivate(folio);
>  		folio_put(folio);
>  		applied += folio_nr_pages(folio);
>  	}
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2a84b5dfbb4c..1ab293019862 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -396,7 +396,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  					list_add(&folio->lru, &folio_list);
>  			}
>  		} else
> -			deactivate_page(&folio->page);
> +			folio_deactivate(folio);
>  huge_unlock:
>  		spin_unlock(ptl);
>  		if (pageout)
> @@ -485,7 +485,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  					list_add(&folio->lru, &folio_list);
>  			}
>  		} else
> -			deactivate_page(&folio->page);
> +			folio_deactivate(folio);
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> diff --git a/mm/swap.c b/mm/swap.c
> index 955930f41d20..9cc8215acdbb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -720,17 +720,15 @@ void deactivate_file_folio(struct folio *folio)
>  }
>  
>  /*
> - * deactivate_page - deactivate a page
> - * @page: page to deactivate
> + * folio_deactivate - deactivate a folio
> + * @folio: folio to deactivate
>   *
> - * deactivate_page() moves @page to the inactive list if @page was on the active
> - * list and was not an unevictable page.  This is done to accelerate the reclaim
> - * of @page.
> + * folio_deactivate() moves @folio to the inactive list if @folio was on the
> + * active list and was not unevictable. This is done to accelerate the
> + * reclaim of @folio.
>   */
> -void deactivate_page(struct page *page)
> +void folio_deactivate(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>  	    (folio_test_active(folio) || lru_gen_enabled())) {
>  		struct folio_batch *fbatch;
> -- 
> 2.38.1
> 
