Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488DA460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jb9j7hoUMtJrjIlX4VkfqzP4vBPOAIAet/v5+Ib4wy0=; b=ugalxz2fQQ9utCCE5YX4aE1dVs
	aQGxLZglMEbkiuoNTITgIi4+UIR0kY5qALFNc4uxXI5OcRa6Lj4Mz2cy6nvmQZxk/Sh+0nRUYYQl+
	5A1bIZ4YMXVacWKJIKZ3lzkXKa1S85DxH30zvLAUMrQ7ew3sez9uWAfk2CWgWsN0AqrVcNbYP5+9Q
	a7a012ZZuNZ3aXTWoFW8CuGwgDn9WScQY0BbMlEFWjsvMNO1S+iOf8jbu+VBH+KsgvdBXkJrCJiFa
	j1hIe8I+XrWsNM6AfDBHYiH7+cKa36D53rM+Eg3r/l7eb5/FXObtWQe1EJXIspLnO0/WzJjXXN6/l
	rIDGsA2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3NzA-007Jqa-4l; Thu, 08 Dec 2022 20:59:16 +0000
Date: Thu, 8 Dec 2022 20:59:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH v3 4/4] mm/swap: Convert deactivate_page() to
 folio_deactivate()
Message-ID: <Y5JQJINs4LPG510r@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-5-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-5-vishal.moola@gmail.com>

On Thu, Dec 08, 2022 at 12:35:03PM -0800, Vishal Moola (Oracle) wrote:
> Deactivate_page() has already been converted to use folios, this change
> converts it to take in a folio argument instead of calling page_folio().
> It also renames the function folio_deactivate() to be more consistent
> with other folio functions.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

(for future series like this, it's slightly fewer changes to introduce
folio_deactivate() first and change deactivate_page() to be a wrapper.
Then patches 2 & 3 in this series can just be converted straight to
folio_deactivate() instead of being changed twice.  wouldn't ask
you to redo the patch series at this point, but next time ...)
