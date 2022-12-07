Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B302102
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CTE6dIt+WJ+vgyPZslBvBPKrvguQdijjejJhRQWzhfU=; b=EUFd0ueIKCe4OzBKsVkD5N/fXz
	zwYytj69x7Hr59S7QSGQsQSA+T1HqUFvBOKCsad7up1f0y/tAYobcGbBquBO//IxTqDd8/83rbM5f
	oMJQil/xQa+zCfr+zoJGoo+TEtmcN0JfTEyDDo7ioFjPFKU6jvOQNHZcLzimZSyxjNGNHpvOrpmcB
	DS1gDSXEQdPNoyynfUmEsD9UJJQWkBkGEqJMa5EUwvkqr8sY12DkAtcVBU3Gsn8x3dvkpG00kSqYX
	euP/95Xn8boTEWKaeoJpazyT3dSNNcrqPwl195NolKfPR9FFTu8yoFzcGEwMvq8vq9cbrmaps1VBy
	0j8HXGYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2x7v-005z8C-WC; Wed, 07 Dec 2022 16:18:32 +0000
Date: Wed, 7 Dec 2022 16:18:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH 3/3] swap: Convert deactivate_page() to deactivate_folio()
Message-ID: <Y5C814+q1QAtKvRW@casper.infradead.org>
References: <20221207002158.418789-1-vishal.moola@gmail.com>
 <20221207002158.418789-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207002158.418789-4-vishal.moola@gmail.com>

On Tue, Dec 06, 2022 at 04:21:58PM -0800, Vishal Moola (Oracle) wrote:
>  /*
> - * deactivate_page - deactivate a page
> - * @page: page to deactivate
> + * deactivate_folio - deactivate a folio
> + * @folio: folio to deactivate
>   *
> - * deactivate_page() moves @page to the inactive list if @page was on the active
> - * list and was not an unevictable page.  This is done to accelerate the reclaim
> - * of @page.
> + * deactivate_folio() moves @folio to the inactive list if @folio was on the
> + * active list and was not an unevictable page. This is done to accelerate

... and was not unevictable.  This ...

> + * the reclaim of @folio.
>   */
> -void deactivate_page(struct page *page)
> +void deactivate_folio(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>  	    (folio_test_active(folio) || lru_gen_enabled())) {
>  		struct folio_batch *fbatch;
> -- 
> 2.38.1
> 
> 
