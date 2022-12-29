Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE993201
	for <damon@lists.linux.dev>; Thu, 29 Dec 2022 21:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46C2C433EF;
	Thu, 29 Dec 2022 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672349473;
	bh=2Y3imQo7xBglzfZKMiOT5BUj+bBiKnbjHMGtXf4KXvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVwsIyiSLE+qdHHryUYdFWEYA0z29hbOruGvTKsou3fuioE+rWLn81bWLU+2mfT8b
	 nY0aDxVk2C1RpGhrHEC0+1Ctu8CDIXMNk+jVN0MLreoSrKaEM/PWmbWE6k5nz1LODA
	 I79i7rLW9IrL6qIwox9EiY/MNSL5Ipf3VY8/m86GL7YnPt6sybtwqaDSvk5M6bILiT
	 91s3U5BVy+5KfSwJolIkfAEFmE+rUtHetFSyZVLF8kSedIkwWIUvSFd6p1LetzGw+d
	 CrIzCqMEXdwchu/jqTgE7q57bWEAHdsbahYXBcBTD4QZ55u/wEK1F2l49kY5RJki3Y
	 RFeRofCmla5qQ==
From: SeongJae Park <sj@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	david@redhat.com
Subject: Re: [PATCH -next v3 5/7] mm/damon/vaddr: convert damon_young_pmd_entry() to use folio
Date: Thu, 29 Dec 2022 21:31:11 +0000
Message-Id: <20221229213111.163524-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y64BRAL90fZA7gIe@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Dec 2022 21:06:12 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Dec 28, 2022 at 07:34:11PM +0800, Kefeng Wang wrote:
> > -		if (pmd_young(*pmd) || !page_is_idle(page) ||
> > +		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
> >  					mmu_notifier_test_young(walk->mm,
> >  						addr)) {
> >  			*priv->page_sz = HPAGE_PMD_SIZE;
> 
> hmm ...
> 
> >  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> >  	if (!pte_present(*pte))
> >  		goto out;
> > -	page = damon_get_page(pte_pfn(*pte));
> > -	if (!page)
> > +	folio = damon_get_folio(pte_pfn(*pte));
> > +	if (!folio)
> >  		goto out;
> > -	if (pte_young(*pte) || !page_is_idle(page) ||
> > +	if (pte_young(*pte) || !folio_test_idle(folio) ||
> >  			mmu_notifier_test_young(walk->mm, addr)) {
> >  		*priv->page_sz = PAGE_SIZE;
> 
> hmm ...
> 
> So why aren't we doing '*priv->page_sz = folio_size(folio)'?  What does
> DAMON want to do when encountering folios that are neither PAGE_SIZE
> nor HPAGE_PMD_SIZE?

Good point.  We use the field to know if next address to check access is in
same folio and therefore if we could reuse the last access check result.  So it
would be better to use 'folio_size(folio)' here.  The field name would also
better to be 'folio_sz'.  I will make the change, unless others do.


Thanks,
SJ
