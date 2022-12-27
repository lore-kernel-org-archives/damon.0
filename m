Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0C6ADB
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 21:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5B4C433D2;
	Tue, 27 Dec 2022 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672177115;
	bh=acdQy0Fz5MV+4Q92/bTs266NGfZ7aBnK5NRffLaTJ3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEARoZa3KHVgNO3Rfiv1ejsZi0dzhu6j6oNXslOM261dXGjVVIWn0Fh7WRcn90rsE
	 rghHVYdBp6rnpsBoeSx7X9qRr7OesSQ37ZJRuwouQaHtmYw6owwBQkpD/QJDf+Ghma
	 JlqTNCcIcM+9yU5FSwvMOL85ITCwS7t9bU7sefXWN+pP3vZl2iEcAR3CWgjVn+5YVs
	 S21p5KSs/q1ofVl7IJmpOQWw3ZNA0+NdE/9u3zZiylLVY60qnsghBsla/ML6LpUkjx
	 2pEiwKhpX85Tj8FyvEfdp+XCL8nQU0yKomz5lyPxuZ46sfvf5GjvcTcEYPxDs/yEr/
	 YcEiOQchqD+MQ==
From: SeongJae Park <sj@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	david@redhat.com
Subject: Re: [PATCH -next v2 2/7] mm: damon: introduce damon_get_folio()
Date: Tue, 27 Dec 2022 21:38:33 +0000
Message-Id: <20221227213833.3261-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y6tMZNvTF4ZsoQEq@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Dec 2022 19:49:56 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 27, 2022 at 07:42:57PM +0000, SeongJae Park wrote:
> > > +static inline struct page *damon_get_page(unsigned long pfn)
> > > +{
> > > +	struct folio *folio = damon_get_folio(pfn);
> > > +
> > > +	return &folio->page;
> > 
> > I think we should check if folio is NULL before dereferencing it?
> 
> &folio->page does not dereeference folio.

Ah, ok.  And this is safe because ->page is at the beginning of folio, right?

Kefeng, could we add a comment explaining it, for people having bad eyes like
me?


Thanks,
SJ
