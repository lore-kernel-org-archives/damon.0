Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8053A0
	for <damon@lists.linux.dev>; Wed, 17 May 2023 06:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CG6yKkcSAXmTuFHjKJxYYVG+vMb17/IxBz/Znck1z2k=; b=y7xtAHQVU4tkYSmSVfuwQ0Jnrs
	iPGaJm5VeifNYA5qMSu3pYT1HSgqq/ztIxbl7aayvuqu52zUcZIk1CjPNlAbv8tkr7TreZYy2YlV3
	f/D6z0pM94aTlNkwPKalADYYdsZAGP0inNu6uV1delhWWc7NzZAMQSnQABk6rnUZ8Ojo9ySSNTTg7
	ZRJpngPiWbzeTcTM7k9uVqUdoW5CIMWMIsNYBGkDEaIl+XEqPdUSL0JsENdFwz8WP3EuAbYzetMY6
	Iprh1KwSO2y5Vl0ILl+2jw/1Jac79IYg6HelJ6X7eTNS4wKBXvWByYtXX0O8ogv+NAb/0RY63dpQY
	GH37AvaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pzAUi-008OgF-1J;
	Wed, 17 May 2023 06:18:40 +0000
Date: Tue, 16 May 2023 23:18:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, damon@lists.linux.dev
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <ZGRxwFDV3zZ0mYsI@infradead.org>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511132113.80196-2-ryan.roberts@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 11, 2023 at 02:21:09PM +0100, Ryan Roberts wrote:
> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to validate
> (and potentially modify) the operation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
