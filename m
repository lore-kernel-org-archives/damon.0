Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C213201
	for <damon@lists.linux.dev>; Thu, 29 Dec 2022 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RokMjtqMjewWNdkAge9DNv5vn/LF3fp1QserzHEAYNU=; b=elyq7n35ZXguK6nHFKSxpNOkHO
	S6LUqru5U0/By72R5eacy0P/1LvjlrSfVd4iVRZy5uJGQN1JUQVF2D4dokhMXP87zp2i58ZiajVT5
	aqjAChGiUGH4FryZAC4tVMLACZHSLzDFvMvQuFAPEDH3OXmp1Pz46uH/LdhFN0b//r0vcPRhYXuFP
	e0nFeIbbiBs7RWhtOQOLnHSC7J2HqYcya92F8IfOywBXtJ+QyfuG/aytQbL6YoFYafHhWNdFQekY6
	fellKYINkEwEqTOodEgxAyHP4rQ0rbRLT96ZT07IdRVlxBTg+sqNM3K7V5Memw+V30v1C2qKMwJsx
	Axy2LZeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB06O-00A7H2-Ao; Thu, 29 Dec 2022 21:06:12 +0000
Date: Thu, 29 Dec 2022 21:06:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, vishal.moola@gmail.com, david@redhat.com
Subject: Re: [PATCH -next v3 5/7] mm/damon/vaddr: convert
 damon_young_pmd_entry() to use folio
Message-ID: <Y64BRAL90fZA7gIe@casper.infradead.org>
References: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
 <20221228113413.10329-6-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228113413.10329-6-wangkefeng.wang@huawei.com>

On Wed, Dec 28, 2022 at 07:34:11PM +0800, Kefeng Wang wrote:
> -		if (pmd_young(*pmd) || !page_is_idle(page) ||
> +		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
>  					mmu_notifier_test_young(walk->mm,
>  						addr)) {
>  			*priv->page_sz = HPAGE_PMD_SIZE;

hmm ...

>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	if (!pte_present(*pte))
>  		goto out;
> -	page = damon_get_page(pte_pfn(*pte));
> -	if (!page)
> +	folio = damon_get_folio(pte_pfn(*pte));
> +	if (!folio)
>  		goto out;
> -	if (pte_young(*pte) || !page_is_idle(page) ||
> +	if (pte_young(*pte) || !folio_test_idle(folio) ||
>  			mmu_notifier_test_young(walk->mm, addr)) {
>  		*priv->page_sz = PAGE_SIZE;

hmm ...

So why aren't we doing '*priv->page_sz = folio_size(folio)'?  What does
DAMON want to do when encountering folios that are neither PAGE_SIZE
nor HPAGE_PMD_SIZE?
