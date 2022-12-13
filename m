Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6779C9
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 19:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6C6C433EF;
	Tue, 13 Dec 2022 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670959133;
	bh=TnGFtpo/Gv6B9vWS/Wf+h/ZzAKUAJ0Ui+Kiqz4jbn+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWAKTsGuzWZbpFnlq/Ya+YL1ixTLq31LqywtwQUjkK1tyhWceH4KXHLwdQoa1ss6F
	 JR766RqxBcp3uYEOZjSRggwmyJUciPFnsK7DeH9uCOD2H7y8Pp5a5rGI1f7/9sRwTj
	 btehXRDmlEJZWxCf82CkB1n1OSY0GHxC0an+2zobCA4R81RK97DMM2TrTSBYpqgxry
	 c6eLSdg69Y46jZaoEgP78R44IofwHRJU9CNPIPvR6knuUlAessUYZ9L8zHOByJETQa
	 2Yins9gTJyEfS+Ml7zQJbCxTI5ism0KQBlPrEaKcTFwZlx8p4OS7sGXYwpIUQ7WAiz
	 g2RxbaBH+etyw==
From: SeongJae Park <sj@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	vishal.moola@gmail.com
Subject: Re: [PATCH -next 4/8] mm: damon: add temporary damon_get_folio()
Date: Tue, 13 Dec 2022 19:18:51 +0000
Message-Id: <20221213191851.138660-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y5iO6VSsyDiQQ2mk@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Dec 2022 14:40:41 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 13, 2022 at 05:27:31PM +0800, Kefeng Wang wrote:
> > -struct page *damon_get_page(unsigned long pfn)
> > +struct folio *damon_get_folio(unsigned long pfn)
> >  {
> > -	struct page *page = pfn_to_online_page(pfn);
> > +	struct folio *folio = pfn_to_online_folio(pfn);
> >  
> > -	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
> > +	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
> >  		return NULL;
> 
> Well, this is awkward.  I asked Vishal to think about exactly this problem
> and we were going to talk about it after we're both back from vacation
> in January.  But I guess we're going to do this in public instead ...
> 
> Specifically, what should the semantics be for a putative
> damon_get_folio() when it encounters a tail page?  Should it return
> the containing folio, or should it return NULL?  And if the semantics
> change here to return the containing folio, what adjustments need to
> be made to the callers?

I'd prefer to simply keep the original behavior, returning NULL, for now unless
someone complaints.


Thanks,
SJ
