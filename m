Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FE63C8
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 19:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D63C433EF;
	Tue, 27 Dec 2022 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672170606;
	bh=FnLHSvVqgEAsCniz6ZqgGXCpSfgkd5gE3MacTYKAtlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/3HAtGuMoQH2rbtqczomrrsFPYFBCWKniAHAX2fa6+SROOMuo0aWsOa994SzbHcM
	 yZU48+/dqzrJZKdG/NeaiYwKjWkY0OFSogHe5WA1z0uIS4xHqYONBL64PCz05F8iUP
	 hYUivkf3x1xGIb59epXgSs3yv8zy/D/2/8DL8bEsiChjHRzFFuNoo6T6IZzkzqju9T
	 lDXPe87HPrESSG6G26xPOCjX1Rx1gPPOE18wUj3vlqRr9QTU/mkWhQZ+YsrUUBHzNk
	 T7ctDetbxnsIiFDLFzTNOMtSjclpqOUurhu+CSQxNxkH6JSluOw2/aIF2y4iIxS20N
	 hIs7/cahI42Sg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	david@redhat.com,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH -next v2 4/7] mm: damon: paddr: convert damon_pa_*() to use folios
Date: Tue, 27 Dec 2022 19:50:04 +0000
Message-Id: <20221227195004.2809-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227122714.161224-5-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,

> With damon_get_folio(), let's convert all the damon_pa_*() to use folios.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/paddr.c | 59 +++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6334c99e5152..728a96c929fc 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -33,17 +33,15 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
>  
>  static void damon_pa_mkold(unsigned long paddr)
>  {
> -	struct folio *folio;
> -	struct page *page = damon_get_page(PHYS_PFN(paddr));
> +	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
>  	struct rmap_walk_control rwc = {
>  		.rmap_one = __damon_pa_mkold,
>  		.anon_lock = folio_lock_anon_vma_read,
>  	};
>  	bool need_lock;
>  
> -	if (!page)
> +	if (!folio)
>  		return;
> -	folio = page_folio(page);
>  
>  	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
>  		folio_set_idle(folio);
> @@ -58,7 +56,6 @@ static void damon_pa_mkold(unsigned long paddr)
>  
>  	if (need_lock)
>  		folio_unlock(folio);
> -

Seems unnecessary change?

>  out:
>  	folio_put(folio);
>  }
> @@ -122,8 +119,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
>  
>  static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
>  {
> -	struct folio *folio;
> -	struct page *page = damon_get_page(PHYS_PFN(paddr));
> +	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
>  	struct damon_pa_access_chk_result result = {
>  		.page_sz = PAGE_SIZE,
>  		.accessed = false,
> @@ -135,9 +131,8 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
>  	};
>  	bool need_lock;
>  
> -	if (!page)
> +	if (!folio)
>  		return false;
> -	folio = page_folio(page);
>  
>  	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
>  		if (folio_test_idle(folio))
> @@ -203,18 +198,18 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
>  }
>  
>  static bool __damos_pa_filter_out(struct damos_filter *filter,
> -		struct page *page)
> +		struct folio *folio)
>  {
>  	bool matched = false;
>  	struct mem_cgroup *memcg;
>  
>  	switch (filter->type) {
>  	case DAMOS_FILTER_TYPE_ANON:
> -		matched = PageAnon(page);
> +		matched = folio_test_anon(folio);
>  		break;
>  	case DAMOS_FILTER_TYPE_MEMCG:
>  		rcu_read_lock();
> -		memcg = page_memcg_check(page);
> +		memcg = page_memcg_check(folio_page(folio, 0));
>  		if (!memcg)
>  			matched = false;
>  		else
> @@ -231,12 +226,12 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
>  /*
>   * damos_pa_filter_out - Return true if the page should be filtered out.
>   */
> -static bool damos_pa_filter_out(struct damos *scheme, struct page *page)
> +static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
>  {
>  	struct damos_filter *filter;
>  
>  	damos_for_each_filter(filter, scheme) {
> -		if (__damos_pa_filter_out(filter, page))
> +		if (__damos_pa_filter_out(filter, folio))
>  			return true;
>  	}
>  	return false;
> @@ -245,33 +240,33 @@ static bool damos_pa_filter_out(struct damos *scheme, struct page *page)
>  static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  {
>  	unsigned long addr, applied;
> -	LIST_HEAD(page_list);
> +	LIST_HEAD(folio_list);
>  
>  	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> -		struct page *page = damon_get_page(PHYS_PFN(addr));
> +		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
>  
> -		if (!page)
> +		if (!folio)
>  			continue;
>  
> -		if (damos_pa_filter_out(s, page)) {
> -			put_page(page);
> +		if (damos_pa_filter_out(s, folio)) {
> +			folio_put(folio);
>  			continue;
>  		}
>  
> -		ClearPageReferenced(page);
> -		test_and_clear_page_young(page);
> -		if (isolate_lru_page(page)) {
> -			put_page(page);
> +		folio_clear_referenced(folio);
> +		folio_test_clear_young(folio);
> +		if (folio_isolate_lru(folio)) {
> +			folio_put(folio);
>  			continue;
>  		}
> -		if (PageUnevictable(page)) {
> -			putback_lru_page(page);
> +		if (folio_test_unevictable(folio)) {
> +			folio_putback_lru(folio);
>  		} else {
> -			list_add(&page->lru, &page_list);
> -			put_page(page);
> +			list_add(&folio->lru, &folio_list);
> +			folio_put(folio);
>  		}
>  	}
> -	applied = reclaim_pages(&page_list);
> +	applied = reclaim_pages(&folio_list);
>  	cond_resched();
>  	return applied * PAGE_SIZE;
>  }
> @@ -282,14 +277,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  	unsigned long addr, applied = 0;
>  
>  	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> -		struct page *page = damon_get_page(PHYS_PFN(addr));
> -		struct folio *folio;
> +		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
>  
> -		if (!page)
> +		if (!folio)
>  			continue;
> -		folio = page_folio(page);
>  
> -		if (damos_pa_filter_out(s, &folio->page)) {
> +		if (damos_pa_filter_out(s, folio)) {
>  			folio_put(folio);
>  			continue;
>  		}
> -- 
> 2.35.3


Thanks,
SJ
