Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F08F51
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 23:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3nhWzv5kOP+18jCYMyraj01yZ+JzMJWApOTFLI0bTRQ=; b=FydI6eJmQWybADU8AzYClMtvWI
	SnV3+4iqHL0dfU3JsO4kIyiOIzhsBjCoIDcDB9ZU8kq+/6jqiV873YLqBv20a+QNvSp3gufk52pXJ
	n5hz2ZaCEa1kRf2XVtabRlFLisEWFTkg8ZQ4k5/a25kZd0ypoghg4ZyGkg6Oo51UpDIL+eRL7rCA0
	FIDfahjK0fo9IWnsqv7tY6tEt0+/b4tJK2L9WR6L0pPmOKVdM7Bm/1ORVWMsYEZYTeruKLWswHKbN
	+MZJPOhdIoHKVATjNIopJBJtTCi0S/7moEs4YRGj02+5eHtVV5hXaW7Pt/oy1kO/k8eo2R/oHNJAG
	/wrO69pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p33Zo-006IWy-KV; Wed, 07 Dec 2022 23:11:44 +0000
Date: Wed, 7 Dec 2022 23:11:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH v2 3/3] mm/swap: Convert deactivate_page() to
 folio_deactivate()
Message-ID: <Y5EdsKDGFEvVVKkZ@casper.infradead.org>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
 <20221207230152.22938-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207230152.22938-4-vishal.moola@gmail.com>

On Wed, Dec 07, 2022 at 03:01:52PM -0800, Vishal Moola (Oracle) wrote:
> +++ b/include/linux/swap.h
> @@ -409,7 +409,7 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> -extern void deactivate_page(struct page *page);
> +extern void folio_deactivate(struct folio *folio);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);

Using 'extern' on function prototypes is now unfashionable; you can drop
it if you respin this patch.

