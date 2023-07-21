Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72DDA38
	for <damon@lists.linux.dev>; Fri, 21 Jul 2023 05:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B047DC433C7;
	Fri, 21 Jul 2023 05:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689916735;
	bh=TTI/GlElwDYyih0KOVoE5zW1kAkMrgogNBmCmy5UeQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eB4YsL4nxl0qIm/TpuKDY5S2GXuAh7qGicWKVqPsmqj1DSokXbdb4/nHPW8ZQI4Ug
	 vP1f7ciEphR0wgaHQ+b7zviAYPPivdW7iK2rb12SZWX0YiDJFaZwygnyLFw4aZgtUH
	 0GCssRGE0VB8x3pHjshGBuCRKO+snluglPtNdOYo=
Date: Fri, 21 Jul 2023 07:18:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, hch@lst.de,
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com,
	rppt@kernel.org, stable@vger.kernel.org, urezki@gmail.com,
	willy@infradead.org, yuzhao@google.com, ziy@nvidia.com,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
Message-ID: <2023072144-item-cosmic-5c73@gregkh>
References: <2023071613-reminder-relapse-b922@gregkh>
 <20230717193008.122040-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193008.122040-1-sj@kernel.org>

On Mon, Jul 17, 2023 at 07:30:08PM +0000, SeongJae Park wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> commit c11d34fa139e4b0fb4249a30f37b178353533fa1 upstream.
> 
> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information.  Further, it is bad
> practice to directly set a pte entry within a table.  Instead clearing
> young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
> 
> Link: https://lkml.kernel.org/r/20230602092949.545577-3-ryan.roberts@arm.com
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> This is a manual backport of the commit, which cannot cleanly
> cherry-picked on 5.15.y[1], on 5.15.y, specifically 5.15.120.
> 
> [1] https://lore.kernel.org/stable/2023071613-reminder-relapse-b922@gregkh/

Now queued up, thanks.

greg k-h
