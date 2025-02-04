Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC321C17E
	for <damon@lists.linux.dev>; Tue,  4 Feb 2025 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710775; cv=none; b=XpZc0bUbuH/eBPbi4opszvyxdxKuPW/QTrMiXg6xXG8UewvhGBs0RbR/HWgrJ7EzlatPmCm1XukawejYrYt6VcBMLR5AF2QHkfsTt+C56mqWKsl26EJXVSgWYzcQHC5OmIdiBf/boKeBigRpMg0kDskNwMMPD4lOeivHh6yR4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710775; c=relaxed/simple;
	bh=+z5mOvioXjbBAefe2Jb/27wvTjhE+fwuuMEE89eNhRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2P9RtEaiMM0bcg6Bx5AkLrd6aaOaeA8451MS4iU68L//01qlLmYgbwY1dJ1cL2ub/j4jVpYhgYL9wg7OQgsdfP8mgQtm8lXeRfjS9RGSz3ALvfoayPlkJJ9xrT5IYLIKKQIEJbDirxzMCXjEg6t22UDMgK6muqmJ3527vunRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofnJcgZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofnJcgZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA9EC4CEDF;
	Tue,  4 Feb 2025 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738710774;
	bh=+z5mOvioXjbBAefe2Jb/27wvTjhE+fwuuMEE89eNhRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofnJcgZ41WKeINaNhRSdv8fvbjPJFkwTkeRI8y0y/COwcHLl1gQnP/+5PyK70SQD7
	 1qZznIh0kWDYsgcKUI9FI3Bz/5za1BceZIpesn4SWiI/Whr2H3yAz1+v1KCW+rG2Gx
	 iG6cDnrBSQ0lp87XGtCleZCFYkgOi9odQGoV70XYRKWsTyo02IoCBs0bVqN+fOyYI9
	 bPvBWQRD105VvCmpEFdTu2WPc+30OrEGLUY7/jj4Z4RgCGxiF5QKBAzuA4W+DyC+Ly
	 HQeCwABWDgW8DrTusTZYIB0CAR5QpdnOMtbBe7BI4hFtHCOCli+FvVpdc9OqLZfzYn
	 1zTx6bmEyGzCQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/6] mm/damon: introduce DAMOS filter type hugepage
Date: Tue,  4 Feb 2025 15:12:48 -0800
Message-Id: <20250204231248.2729-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203225604.44742-5-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  3 Feb 2025 22:55:31 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to gather statistics to check if memory regions of specific
> access tempratures are backed by hugepages of a size in a specific
> range

nit.  A period is missed?

> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/damon.h    | 2 ++
>  mm/damon/paddr.c         | 7 +++++++
>  mm/damon/sysfs-schemes.c | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f30ceeff215..5ba6c2114e3f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -336,6 +336,7 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
>   * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
>   * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
> + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.

What about "DAMOS_FILTER_TYPE_HUGEPAGE_SIZE: hugepages of a given size range."?

>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> @@ -355,6 +356,7 @@ enum damos_filter_type {
>  	DAMOS_FILTER_TYPE_ANON,
>  	DAMOS_FILTER_TYPE_MEMCG,
>  	DAMOS_FILTER_TYPE_YOUNG,
> +	DAMOS_FILTER_TYPE_HUGEPAGE,
>  	DAMOS_FILTER_TYPE_ADDR,
>  	DAMOS_FILTER_TYPE_TARGET,
>  	NR_DAMOS_FILTER_TYPES,
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 3f59a3fdc391..34fe1eb664cc 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -227,6 +227,7 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>  {
>  	bool matched = false;
>  	struct mem_cgroup *memcg;
> +	size_t folio_sz;
>  
>  	switch (filter->type) {
>  	case DAMOS_FILTER_TYPE_ANON:
> @@ -246,6 +247,12 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>  		if (matched)
>  			damon_folio_mkold(folio);
>  		break;
> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)

I think we don't really need this macro?

> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> +		folio_sz = folio_size(folio);
> +		matched = filter->folio_size.min <= folio_sz && folio_sz <= filter->folio_size.max;

We should also return 'false' if the folio is not a large folio (folio_sz ==
PAGE_SIZE), if we agreed to my suggestion on the previous version of this patch
series?

I'd also prefer calling filter->folio_siz as sz_range or size_range, so that we
can reuse it for future filter types of size range.

> +		break;
> +#endif
>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index bc7ca43ca9c4..76aee3ab277e 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -330,6 +330,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
>  	"anon",
>  	"memcg",
>  	"young",
> +	"hugepage",

hugepage_size?

>  	"addr",
>  	"target",
>  };
> -- 
> 2.43.5


Thanks,
SJ
