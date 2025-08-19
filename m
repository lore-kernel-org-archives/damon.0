Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01221883E;
	Tue, 19 Aug 2025 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584776; cv=none; b=NTTj98oBySo5Tqzrn4ZUeFC9fuY7l/1lj5vUb5zA8WrmwfZopqTsxqBOzSl4TZfytkP6ePtd4f6tWa7vnaPS9zniQrzfIJJOXG+N4DdT/NdtSP/5hCT/j2gmVJmy9ZbsqIG/QvNWTQn9g3lQe19jAnXyJ11i4Uzk1oTd1yo8yvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584776; c=relaxed/simple;
	bh=cobszW34dvhWuWQ5UgCda75bpk87ATDQHb9EveDVexo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtYb0q+XZfo0DK49jobylXo+W6dm6e+/tjspkTju7ja/LOMNTpMBZM8ms3mRwaI//dkSqJPhM9dLmTdk7R9c6OT3LWVNRSFj7EXWdYjn/I+zrTJDkx6SHjjNpzT3iaNzUJ7dhVX511gYg+7sDul/FWv6DrMcV/ok8l6DUbeMcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJNMRDKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJNMRDKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DBFC113CF;
	Tue, 19 Aug 2025 06:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584776;
	bh=cobszW34dvhWuWQ5UgCda75bpk87ATDQHb9EveDVexo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJNMRDKjqIPcBLA4OJc9bVjpJvDuF+hYI4GdaqqyG/t/HDJSwR/kqY4RMJlW/v4Xv
	 UzceS7s2HWXan00E7JtVqPDOLgzr4ewOrSzYfuN7w3TAQGiSUpUzs38mW9jRRZ6iiX
	 9gC9dCT+O2gjrH+g8zyT9RBoDFJOnPxUqBInvA/2pmsCWnuNxoDbE3egdyY6lIhnjo
	 eSOIkHCRewbbBCd53T2Op5MWKi/XKgDBRO+hDRv1b9QKAAdZnOdf2RXupUHzXcBDZm
	 X0hT7nmATPI67fwQaupufQSbKAPv5Un0ujdOl0KBd6XUIcV8Hn7Y7t1ZxBSmukYxsY
	 NOCeDW/3F6p9A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 03/16] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Mon, 18 Aug 2025 23:26:13 -0700
Message-Id: <20250819062613.39988-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819061826.39289-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 23:18:26 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Quanmin,
> 
> 
> 
> On Wed, 13 Aug 2025 13:06:53 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > From: SeongJae Park <sj@kernel.org>
> > 
> > Add support of addr_unit for DAMOS_PAGEOUT action handling from the
> > DAMOS operation implementation for the physical address space.
> 
> As I suggested on another reply[1], please squash attaching patch to this one
> when you post next version of this series.
> 
> [1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

Sorry for the above wrong link.  Plese use
https://lore.kernel.org/20250813170806.6251-1-sj@kernel.org instead.

> 
> [...]
> 
> 
> Thanks,
> SJ
> 
> ==== Attachment 0 (0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch) ====
> >From 525b3d1d9dd53f4ca6b4d2254e5cc7f99c8eae0d Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Wed, 13 Aug 2025 21:24:35 -0700
> Subject: [PATCH] mm/damon/paddr: set DAMOS_PAGEOUT stat in core address unit
> 
> Operations layer should set DAMOS stat in core layer address unit, but
> paddr is returning that for PAGEOUT in paddr address unit.  Fix it.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/paddr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 98cb6930c183..826c2064dbfd 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -139,8 +139,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
>  		unsigned long addr_unit, struct damos *s,
>  		unsigned long *sz_filter_passed)
>  {
> -	phys_addr_t addr;
> -	unsigned long applied;
> +	phys_addr_t addr, applied;
>  	LIST_HEAD(folio_list);
>  	bool install_young_filter = true;
>  	struct damos_filter *filter;
> @@ -172,7 +171,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
>  		if (damos_pa_filter_out(s, folio))
>  			goto put_folio;
>  		else
> -			*sz_filter_passed += folio_size(folio);
> +			*sz_filter_passed += folio_size(folio) / addr_unit;
>  
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> @@ -191,7 +190,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
>  	applied = reclaim_pages(&folio_list);
>  	cond_resched();
>  	s->last_applied = folio;
> -	return applied * PAGE_SIZE;
> +	return applied * PAGE_SIZE / addr_unit;
>  }
>  
>  static inline unsigned long damon_pa_mark_accessed_or_deactivate(
> -- 
> 2.39.5
> 
> 
