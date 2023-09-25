Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB381EA8A
	for <damon@lists.linux.dev>; Mon, 25 Sep 2023 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B44C433C8;
	Mon, 25 Sep 2023 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1695654841;
	bh=YKKQIK4vMhPCWEyAM4Ug/QZsOia0En0oCqy3GEJLLZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPJ6GoiCBgUc6GJOH4BH1j9TEjGzGUCAVaAspSKOWUz55wuTZBpAiCYKWOoNohoaN
	 QbTFPGMClExIvBPS1bAyPei7wKiNDh9TV/W2Y8KCirkV6Fj/2NPIERSrPLDhR0QQ+u
	 EKW8V+IgWABOfMqlqKZzTWyVhQzFnNi1gRssPp+c=
Date: Mon, 25 Sep 2023 08:14:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <linux-mm@kvack.org>, <damon@lists.linux.dev>, SeongJae Park
 <sj@kernel.org>
Subject: Re: [PATCH] mm/damon/vaddr-test: Fix memory leak in
 damon_do_test_apply_three_regions()
Message-Id: <20230925081400.9593189a7665c6ff1f812855@linux-foundation.org>
In-Reply-To: <20230925072100.3725620-1-ruanjinjie@huawei.com>
References: <20230925072100.3725620-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Sep 2023 15:20:59 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> 
> Since commit 9f86d624292c ("mm/damon/vaddr-test: remove unnecessary
> variables"), the damon_destroy_ctx() is removed, but still call
> damon_new_target() and damon_new_region(), the damon_region which is
> allocated by kmem_cache_alloc() in damon_new_region() and the damon_target
> which is allocated by kmalloc in damon_new_target() are not freed. And the
> damon_region which is allocated in damon_new_region() in
> damon_set_regions() is also not freed.
> 
> So use damon_destroy_target to free all the damon_regions and damon_target.
> 
> ...
> 
> Fixes:  9f86d624292c ("mm/damon/vaddr-test: remove unnecessary variables")
> Fixes: dae0087aeff4 ("mm/damon/vaddr: remove damon_va_apply_three_regions()")

Can we please identify a single Fixes: target?  Otherwise, how are
-stable tree maintainers to determine which kernels need the fix?  

I'll go with 9f86d624292c for now.
