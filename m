Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035E63C8
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 19:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pVnXHGauFdIWkz2AYNCrthY0xOqFEzowHdaTmnFiu8o=; b=QnpTdHLskeNHIACjZjyEt8eO1l
	wyF6Mxhcmbw+pb+Uvgi9kQSDnDImwrvzhlzDbnfqRnJtKuAPxGOl7ev6CvNuQCRqWbyhgBg6NYcag
	AHpZE8JErWaQthBCTq4hw34impclldmGt8Gek7c0kOhAamfy9Cif+AzS2usTSzH2mOlttxefgthv6
	XlyrHQUPlFT7eari/Jgn8rkPnigpaDjKEsCQMeAc3OoBg6aKJkG6bWlKuFF1m1QCDtHxGNI9lDvj+
	J5tHSg2Qzu/bW2KXpkAScIkXSbllfiOG5dTjfZ33ayO0UOhn8lxMPsFeEw8CcqD6nbPJlJ/YJKYYj
	y97nMudQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAFxU-008Gel-II; Tue, 27 Dec 2022 19:49:56 +0000
Date: Tue, 27 Dec 2022 19:49:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, vishal.moola@gmail.com, david@redhat.com
Subject: Re: [PATCH -next v2 2/7] mm: damon: introduce damon_get_folio()
Message-ID: <Y6tMZNvTF4ZsoQEq@casper.infradead.org>
References: <20221227122714.161224-3-wangkefeng.wang@huawei.com>
 <20221227194257.2744-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227194257.2744-1-sj@kernel.org>

On Tue, Dec 27, 2022 at 07:42:57PM +0000, SeongJae Park wrote:
> > +static inline struct page *damon_get_page(unsigned long pfn)
> > +{
> > +	struct folio *folio = damon_get_folio(pfn);
> > +
> > +	return &folio->page;
> 
> I think we should check if folio is NULL before dereferencing it?

&folio->page does not dereeference folio.
