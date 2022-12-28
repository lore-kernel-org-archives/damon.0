Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F096FB7
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XL10/pjowk7U3jR2rv9cbZaUtm0mwuuRNllBNzFqaII=; b=M6PfG+L4ygjn28y4p7aUdbMTS3
	0iT8RPH3p+g8auyqhqDnP4eHm4HB2dFriZ18X49v+3NrflfgFhrCHbMY/AFZUkxvsNRjJcvPZfWFj
	n5TNlBSzQNip7c9fS4uekn8yWOs4HxUimkSKnhHvmsPOC3Rn80MQXT+MmWfEY0a5al6cD66cH80QV
	A95BVwrcn/9PjnwHOsKy9O3CIpLK56WbpX/gwe1sbeTFYCnWsV5pwKuvCs9YmVXXEEM0/q9A1JzQt
	okBob28q2Rwbn5IyteXjGlyB+VAsAEjbOU/E84BU4jTtkED0PXMEmOFtGJzNBo+rMd+y1gpQ10Po4
	HYFa4Dew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAf24-009R8A-8c; Wed, 28 Dec 2022 22:36:20 +0000
Date: Wed, 28 Dec 2022 22:36:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, vishal.moola@gmail.com, david@redhat.com
Subject: Re: [PATCH -next v3 2/7] mm/damon: introduce damon_get_folio()
Message-ID: <Y6zE5DsGU1CRpWS2@casper.infradead.org>
References: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
 <20221228113413.10329-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228113413.10329-3-wangkefeng.wang@huawei.com>

On Wed, Dec 28, 2022 at 07:34:08PM +0800, Kefeng Wang wrote:
> +static inline struct page *damon_get_page(unsigned long pfn)
> +{
> +	struct folio *folio = damon_get_folio(pfn);
> +
> +	/* when folio is NULL, return &(0->page) mean return NULL */
> +	return &folio->page;

I really don't think this comment is needed.  This is the standard idiom
for converting from a folio to its head page.
