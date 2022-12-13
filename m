Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94E33D2
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bp1NI5NxRf5KPduMUan4tguo3EwGdbgGIpn9oy21c2M=; b=Z9y1G33QX5Kj1ZxByLC52j2sGN
	t/6SEShZ/322yWKWHyaUh1MxwCUY7jL8NnetYR/Xs30mEgxSsMIfdbnc/kIx6/4sN4LFygtPjW4AG
	hvedfDFbtVQGaeH7S1fkBKv4y1c3c0aqesi5yxUK9HTKPvKGHYO/24pRLfLcEySQJcREDVC6FYN1q
	3HJlIUofmcFw/kJojLFvMuhhWR/IKO1Bz6pofhWoyYQAZPU6PH6Fp0MTDmfUN8njxQfYEfsxhs/9/
	N5ONc6nOw92WqGncQ8iciGN1uUMMJuKFx6+zVuvSRjXJOjtOLkqiSrDvpXzgQO5WeoEgAe1EpBAgS
	OQZdpXbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p56Mq-00CIsd-V2; Tue, 13 Dec 2022 14:34:49 +0000
Date: Tue, 13 Dec 2022 14:34:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	damon@lists.linux.dev, vishal.moola@gmail.com
Subject: Re: [PATCH -next 2/8] mm: page_idle: Convert page idle to use folios
Message-ID: <Y5iNiNUoNlupyhow@casper.infradead.org>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213092735.187924-3-wangkefeng.wang@huawei.com>

On Tue, Dec 13, 2022 at 05:27:29PM +0800, Kefeng Wang wrote:
> -static struct page *page_idle_get_page(unsigned long pfn)
> +static struct folio *folio_idle_get_folio(unsigned long pfn)
>  {
> -	struct page *page = pfn_to_online_page(pfn);
> +	struct folio *folio = pfn_to_online_folio(pfn);
>  
> -	if (!page || !PageLRU(page) ||
> -	    !get_page_unless_zero(page))
> +	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
>  		return NULL;

You've changed the semantics here, and I suspect will cause breakage
as a result.  Before if you called page_idle_get_page() on a tail page,
you got a NULL pointer returned.  Now you get the folio that contains
that tail page.

I think you have to continue to call pfn_to_online_page() and do
the conversion to folio manually in this function.  By all means
convert this function to return the folio, but you need to take a
little more care.

