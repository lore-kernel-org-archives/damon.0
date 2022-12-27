Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451863A5
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jTX+e2bHnTWVg1lIt3/StkB7a4hRyyJe5D+VdzEszUM=; b=BehAW4tNChWqBE7akCDh7QWsLr
	jW2Lo6FLtVBlv0UrzRHvV2g/WQ5wo0k/GnlnUlGHbPBA/eSAdh7jEeOvcGDhTXprlAsokfo2BGWeu
	zvb3felpXEWRknvmy3sVkMka9rw8MHeMPyto3GXdOR0xMJArnWb2ABRKzomFDJ3bKpLXJd09YoDCB
	5GCoFt5Yki5ZEQoPRr2zz03ukle5ScTRFSYyP8dRVbaAMmb0L8nNbBGMWXVI3c9iqa9/zNoTgJmAz
	NJ1NfDHReHsQdv5el7zBESHpc8ajeAHBjiWlBwRzXoc0aCPMqpK538rAQIFax6HlVpyPXhHxlE4AO
	m2KIM55A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAETV-008CqJ-0f; Tue, 27 Dec 2022 18:14:53 +0000
Date: Tue, 27 Dec 2022 18:14:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, vishal.moola@gmail.com, david@redhat.com
Subject: Re: [PATCH -next v2 1/7] mm: page_idle: Convert page idle to use
 folios
Message-ID: <Y6s2HPjrON2Sx/gr@casper.infradead.org>
References: <20221227122714.161224-1-wangkefeng.wang@huawei.com>
 <20221227122714.161224-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227122714.161224-2-wangkefeng.wang@huawei.com>

On Tue, Dec 27, 2022 at 08:27:08PM +0800, Kefeng Wang wrote:
> -static struct page *page_idle_get_page(unsigned long pfn)
> +static struct folio *page_idle_get_folio(unsigned long pfn)
>  {
>  	struct page *page = pfn_to_online_page(pfn);
> +	struct folio *folio;
>  
> -	if (!page || !PageLRU(page) ||
> -	    !get_page_unless_zero(page))
> +	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
>  		return NULL;

Mmmm, no.  PageLRU hides a compound_head() call.  Try doing this instead:

	if (!page || PageTail(page))
		return NULL;
	folio = page_folio(page);
	if (!folio_test_lru(folio) || !folio_try_get(folio))
		return NULL;
	if (page_folio(page) != folio || !folio_test_lru(folio)) {
		folio_put(folio);
		folio = NULL;
	}

	return NULL;

