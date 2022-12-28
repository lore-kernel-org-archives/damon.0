Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741306FC7
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 23:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E586C433D2;
	Wed, 28 Dec 2022 23:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672269260;
	bh=3pT3Vmr4qXyIpvaJ20iy54B0P7FiMhelVXGMDaZ+8vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SpNmlEarS5VXMhH5cPPiEI3NT/7vsQIZdwZmLIdouHPJcHHvuicpH+YfpyVZq+KS6
	 Hcdpq2e4uFuDlEGygs+RF4C682bDkX2zUtxVtnKiJ6dwSel677HuJcbBoHaJbh0rgl
	 ZZNRe927mlo+jVxOFR638RDvHnz7qMUmpJpcRvuupL0C0yn0GTenZXZiIWCO4tNZ5I
	 khBPouKGJhNIa9KDn32In+YpVpOkmhr1HiGAwibexKjT4S1Fogbe1z2lyzlH0KQkv4
	 LAvo7CuM3dKpWQNtnLzEeh+2/P4NmdJCEMl+BdszGQEJtkj0MbnHQlXUXwTB5rPnF0
	 Krj7xf+5KGc/A==
From: SeongJae Park <sj@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	david@redhat.com
Subject: Re: [PATCH -next v3 2/7] mm/damon: introduce damon_get_folio()
Date: Wed, 28 Dec 2022 23:14:17 +0000
Message-Id: <20221228231417.150148-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y6zE5DsGU1CRpWS2@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matthew,

On Wed, 28 Dec 2022 22:36:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Dec 28, 2022 at 07:34:08PM +0800, Kefeng Wang wrote:
> > +static inline struct page *damon_get_page(unsigned long pfn)
> > +{
> > +	struct folio *folio = damon_get_folio(pfn);
> > +
> > +	/* when folio is NULL, return &(0->page) mean return NULL */
> > +	return &folio->page;
> 
> I really don't think this comment is needed.  This is the standard idiom
> for converting from a folio to its head page.

Well, I think some of DAMON code readers (at least me) might not yet that
familiar with Folio, as it has not been a while since DAMON started using
Folio.  Also, maybe I overlooked some comments or documents, but I was unable
to sure if the offset of 'page' in 'folio' is intended to be never changed with
any future changes, or not.  So I thought adding one more line of explanation
here could be helpful for someone.

I also show some code using 'folio_page(folio, 0)', so I might not be the only
one who at least sometimes forget the idiom.  For helping people remember this
idiom easier, what do you think about having a new macro or static inline
function, say, 'folio_head_page()' and comment why passing NULL is ok on the
function?  IMHO, that would be easier to read.


Thanks,
SJ
