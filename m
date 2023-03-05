Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C207E
	for <damon@lists.linux.dev>; Sun,  5 Mar 2023 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TkIQu3TPsM6ji5C2QtwbOmWwtOZkLwyJUtqHPGL53xE=; b=eTiY+jAgsZl8q470a4XOe8TBmP
	ujKjrZTDRfH0d5knsDYYetvbHuxg0LRvMhM2MV9tZXJe4d60f3I3dckhIw/GNjgnl0FrFMx+rUZl1
	13D35Qdb61mtDiFWfSfmWDgCC4Vh8dpxbH5yeic7K/oGRK3EmB5niWRzJqPLzQwGTIJFvzyZtM07U
	p+u5APYXYCSxsiWB4SmHb8XF8kDgWN7VHZ8FTsWLJRI0Pfor4JbmN6ATpgU3MiwZsCH9Us5W2M3IW
	ckHwBS8L+46xSVAcP8XJ5KKOgn9RI2vvr/HL1iJquGsRjZpJUznt7xFsYfHvY21gFVXvUxd/8XE36
	19+xbmdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYbnp-0047Nz-7v; Sun, 05 Mar 2023 00:00:37 +0000
Date: Sun, 5 Mar 2023 00:00:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/paddr: fix folio_nr_pages() after
 folio_put() in damon_pa_mark_accessed_or_deactivate()
Message-ID: <ZAPbpUkiw3T2blE5@casper.infradead.org>
References: <20230304193949.296391-1-sj@kernel.org>
 <20230304193949.296391-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304193949.296391-3-sj@kernel.org>

On Sat, Mar 04, 2023 at 07:39:49PM +0000, SeongJae Park wrote:
> damon_pa_mark_accessed_or_deactivate() is accessing a folio via
> folio_nr_pages() after folio_put() for the folio has invoked.  Fix it.
> 
> Fixes: f70da5ee8fe1 ("mm/damon: convert damon_pa_mark_accessed_or_deactivate() to use folios")
> Cc: <stable@vger.kernel.org> # 6.3.x
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

