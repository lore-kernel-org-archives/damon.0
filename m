Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9954F4A26
	for <damon@lists.linux.dev>; Mon, 12 Sep 2022 19:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B63DC433D6;
	Mon, 12 Sep 2022 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1663010800;
	bh=+KE36g10OHpuTg9RLmHGCa2Z6Hs0fenFn9IVggo2Ao4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S1Dkyxk4tr7+QgJpNp5Htd8OAnRf7PWC2kayDlmAUaWd8bP1QDAgCb1IBvgx863xw
	 v3FKTP9SD0FzT3E0RTkO8eFaJJyl2Wep4a9PoeR+mkku1FOYvHwtu0dyQyULI8BGvm
	 NUiv4U/fBXTVHcCaAVrghMgTvFq5hJ9eiFf8Wa1w=
Date: Mon, 12 Sep 2022 12:26:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dawei Li <set_pte_at@outlook.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: improve damon_new_region strategy
Message-Id: <20220912122639.6c8363ee79f3313299c9446f@linux-foundation.org>
In-Reply-To: <TYCP286MB2323DA1894FA55BB9CF90978CA449@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323DA1894FA55BB9CF90978CA449@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Sep 2022 22:39:03 +0800 Dawei Li <set_pte_at@outlook.com> wrote:

> Kdamond is implemented as a periodical split-merge pattern, which will
> create and destroy regions possibly on high frequency(hundreds or even
> thousands of per sec), depending on number of regions and aggregation
> period.  In that case, kmalloc and kfree could bring considerable overhead
> to system, which can be improved by private kmem cache.
> 

A dedicated slab cache should be faster and will also consume less
memory, due to better packing into the underlying pages.  So I redid
the changelog thusly:

: Kdamond is implemented as a periodical split-merge pattern, which will
: create and destroy regions possibly at high frequency (hundreds or even
: thousands of per sec), depending on the number of regions and aggregation
: period.  In that case, kmalloc and kfree could bring speed and space
: overheads, which can be improved by using a private kmem cache.

> +static int __init damon_init(void)
> +{
> +	damon_region_cache = kmem_cache_create("damon_region_cache", sizeof(struct damon_region),

Should be able to use just

	damon_region_cache = KMEM_CACHE(damon_region, 0);

here.  Please test that and send along a fixup patch?

