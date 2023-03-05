Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AF7E
	for <damon@lists.linux.dev>; Sun,  5 Mar 2023 00:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GFZU3Vr031k0W6AOiBuxkRp/WomquZxxmMw7RSoYHIA=; b=mFptCZUCgRYLzFH1ts+We08mpb
	hEMOVNREw6u+CJkwBA3vzRQ6lqpmgxsVNX8toK5l0rtpeilw1wSZQLxqgwnBzpHSwsHklzEuAVfC8
	42TcF0GiKHIh/Gb+Vj9jDxHd3wXRsq1IcN0Bsp6lFLVHlmsYZRkr3/nZ3x45+hocFrzkeLGUc7S8M
	teCVj5FJ3MzpUSODowjI6rCwia4u4Fc8Tqlw+9TQxnB+FfhIh03iqCD7LqnTSdSO+cgDTQmNAJrtk
	+wrA2hN5JK/Uj7o/ifYxz3jVYoC8JBMv7q+EbkgVeamd51qd5Tc77LBtmWK/M/dn+BxrhJsrfPOCY
	8pccAU3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYbnY-0047NX-Qn; Sun, 05 Mar 2023 00:00:20 +0000
Date: Sun, 5 Mar 2023 00:00:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/paddr: fix folio_size() call after
 folio_put() in damon_pa_young()
Message-ID: <ZAPblL0G6JkekBtU@casper.infradead.org>
References: <20230304193949.296391-1-sj@kernel.org>
 <20230304193949.296391-2-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304193949.296391-2-sj@kernel.org>

On Sat, Mar 04, 2023 at 07:39:48PM +0000, SeongJae Park wrote:
> damon_pa_young() is accessing a folio via folio_size() after folio_put()
> for the folio has invoked.  Fix it.
> 
> Fixes: 397b0c3a584b ("mm/damon/paddr: remove folio_sz field from damon_pa_access_chk_result")
> Cc: <stable@vger.kernel.org> # 6.3.x
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
