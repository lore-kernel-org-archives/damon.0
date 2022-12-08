Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA19A460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gusrjqGtF3EWWrH8XS3Cy8AToTM2/ZhBBd0S8TkvBrw=; b=eRAq1WAdlXVzkmQS7hGu0nozRC
	15wcLiOpBNO2azsiE9umptASk9KZ9FxNZz4gVAkUNTm0J9MzvrhYtev0TLe4baVp/9zI+UtUqr5tn
	zTv8MFHYYRjPXDl1oiFORi0a1eEqBGQGAwfDt1PxVm3Cg7+CBFVXAEZmS4juW/mf74fqcGO0IJDTT
	xusx6Dm7jvLQUKAQrU382+dowwCaTDRKBRuc5naWKkMApYAxVsq4udYeQUsN6ofDC7BvL+BK9WorO
	vszA67KV3gs7Zlsxeer20cYuM0isf+5vP2/6Bm7r1Kxz9m4Q+4T4GRniIWPUXslZbESBAIMblE8JG
	fpB5SvxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Nwr-007JjJ-Md; Thu, 08 Dec 2022 20:56:53 +0000
Date: Thu, 8 Dec 2022 20:56:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH v3 1/4] mm/memory: Add vm_normal_folio()
Message-ID: <Y5JPlRFggaLKQ3F5@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-2-vishal.moola@gmail.com>

On Thu, Dec 08, 2022 at 12:35:00PM -0800, Vishal Moola (Oracle) wrote:
> Introduce a wrapper function called vm_normal_folio(). This function
> calls vm_normal_page() and returns the folio of the page found, or null
> if no page is found.
> 
> This function allows callers to get a folio from a pte, which will
> eventually allow them to completely replace their struct page variables
> with struct folio instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
