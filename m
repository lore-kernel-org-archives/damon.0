Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF863C8
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 19:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9CEC433EF;
	Tue, 27 Dec 2022 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672170179;
	bh=ndjXj2bFtuxWHzxqZ4f5g2WLfiRgnsCCho8XX+smju4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL7Y/uW0ufuRhI2qSL8vBNIinxHyVNaX2ReqyuVJ7ofv6RHJY7pKJ4aBVc3gKYeaW
	 eV1XrvbEvYdCZpNYN3bfvA34ofWB2egHg5uXobavgpja2mNIz0CcUmn6QDtdcdI7Lb
	 CwZjj69zHX47/kuBe40TpHopBsCBSDbroU+eyeL4YqgvCNQnJtmM/iEk8GmopFksW9
	 0w4T9W1TGmqtmElNip/rWadXJYYWYzx8pUGj8wPNati6RcUoFILZKTHcn//0f2QYab
	 XY9b4LfdXlmHx3bGmP0Fz+4W40mhOatzSHGn9lp3zdtg7MaYOLqa9RUXgRpcG/pF6j
	 D3a1bC0K7Yh/w==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	david@redhat.com
Subject: Re: [PATCH -next v2 2/7] mm: damon: introduce damon_get_folio()
Date: Tue, 27 Dec 2022 19:42:57 +0000
Message-Id: <20221227194257.2744-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227122714.161224-3-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,

Could we use 'mm/damon:' prefix instead of 'mm: damon:' for the patch subjects?

On Tue, 27 Dec 2022 20:27:09 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Introduce damon_get_folio(), and the temporary wrapper function
> damon_get_page(), which help us to convert damon related function
> to use folios, and it will be droped once the conversion is completed.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/ops-common.c | 14 ++++++++------
>  mm/damon/ops-common.h |  8 +++++++-
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 75409601f934..ff38a19aa92e 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -16,21 +16,23 @@
>   * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
>   * NULL.
>   *
> - * The body of this function is stolen from the 'page_idle_get_page()'.  We
> + * The body of this function is stolen from the 'page_idle_get_folio()'.  We
>   * steal rather than reuse it because the code is quite simple.
>   */
> -struct page *damon_get_page(unsigned long pfn)
> +struct folio *damon_get_folio(unsigned long pfn)
>  {
>  	struct page *page = pfn_to_online_page(pfn);
> +	struct folio *folio;
>  
>  	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
>  		return NULL;
>  
> -	if (unlikely(!PageLRU(page))) {
> -		put_page(page);
> -		page = NULL;
> +	folio = page_folio(page);
> +	if (unlikely(!folio_test_lru(folio))) {
> +		folio_put(folio);
> +		folio = NULL;
>  	}

I think Matthew's comment for 'page_idle_get_folio()'[1] could applied here?


[1] https://lore.kernel.org/damon/Y6s2HPjrON2Sx%2Fgr@casper.infradead.org/

> -	return page;
> +	return folio;
>  }
>  
>  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 8d82d3722204..4ee607813981 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -7,7 +7,13 @@
>  
>  #include <linux/damon.h>
>  
> -struct page *damon_get_page(unsigned long pfn);
> +struct folio *damon_get_folio(unsigned long pfn);
> +static inline struct page *damon_get_page(unsigned long pfn)
> +{
> +	struct folio *folio = damon_get_folio(pfn);
> +
> +	return &folio->page;

I think we should check if folio is NULL before dereferencing it?

> +}
>  
>  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
>  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
> -- 
> 2.35.3
> 
