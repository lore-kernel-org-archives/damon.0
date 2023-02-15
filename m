Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCC6109
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rDZl/5EEHbOPpxdRh+6glISWcS2OPg5HePgxkDGiegQ=; b=Tn7w5yBgAzqBzJkXZoFI1LG/rg
	yhJaeStJwyI5ZMuALThvIPfaeRFlm9/DzsDFX5jNKaGaUw3/3nhuDwj0Jv8nIwcdtKvkYU1FO39E1
	/u8L/iKTU+OtZncNwkUahyDKyTaYB3+Sd4h9AKw/xwKJjB1M/RIYi7Kps3Teqky7NWc+1pJ6nRdHQ
	NjiIT0soE9Ek/jdpFhzNrDJYJyEL3OYeMAtB5og4LtYkiCYHPZ3hvaVLtxx7vliCGTEsHhvDRQD0R
	TXljirgf5gUdnTogAeb9x3WxJ0/yCUuapR3MBByX9SGu398gW0Nbo+hVhNuxkvrUxA9pzbU9XHBtC
	briV317g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSJub-007aG4-Cf; Wed, 15 Feb 2023 15:41:37 +0000
Date: Wed, 15 Feb 2023 15:41:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sj@kernel.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeelb@google.com, muchun.song@linux.dev, naoya.horiguchi@nec.com,
	linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
	mike.kravetz@oracle.com, damon@lists.linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
Message-ID: <Y+z9MSpKioRsWvKj@casper.infradead.org>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>

On Wed, Feb 15, 2023 at 06:39:36PM +0800, Baolin Wang wrote:
> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> care about the negative value, thus we can convert the isolate_hugetlb()
> to return a boolean value to make code more clear when checking the
> hugetlb isolation state. Moreover converts 2 users which will consider
> the negative value returned by isolate_hugetlb().
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
