Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A6A460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nMY4ZaYfKlcPDFf6C2PNbxoqPDiUclC+ikxeOkazfgc=; b=lSTp9r8dPoePvlxCXIwLopRs3v
	xJXClaoyK/5xw8c1Zyi/lyQs1HGv0H+vcu3VDPKScyWeIwjv+HR+3ijJJ+342uRT3nJQexMD2hz5R
	jmTP+nhVsNIl5tqEOaB50Ywq2PUGg+mCESEVb6BHAczuLS93clw65htaklgqWSWH0U1tsXdXoPKNc
	G+frxzC43Jmt5wMNTyKE9G/84NtrBpMIFw5EZ+vDeyTyXj0jQYkU4HLOskrANCXKv3ImSrfMDv3Jj
	Xaoj4Dat4DNThN1P+zGegXWnFKUXv7vER+ipNcP3nqQsnuqiDyttJrwLPYe/dqnOM1px3jUO6/svl
	dHAXuc7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Nx2-007JkX-ES; Thu, 08 Dec 2022 20:57:04 +0000
Date: Thu, 8 Dec 2022 20:57:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH v3 3/4] mm/damon: Convert
 damon_pa_mark_accessed_or_deactivate() to use folios
Message-ID: <Y5JPoJnNnAz/cmVH@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-4-vishal.moola@gmail.com>

On Thu, Dec 08, 2022 at 12:35:02PM -0800, Vishal Moola (Oracle) wrote:
> This change replaces 2 calls to compound_head() with one. This is in
> preparation for the conversion of deactivate_page() to
> folio_deactivate().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

