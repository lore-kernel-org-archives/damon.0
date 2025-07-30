Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C751E0DEA;
	Wed, 30 Jul 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897510; cv=none; b=N4xoiofK4mnzWkwJXgGCO3PD2P6JmBthCwchS+YYMv6Myp59oGlGD4stph5rHYVQsG2WHvIlm/NICTH4grxx4VYNe3yzwyQP1WG/wFHE7X1ToJ6I/skF/1kEEuulHKdHnQaxo36RsnHB321qwYGD+nS06QBfpvmQemCEuP5OhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897510; c=relaxed/simple;
	bh=hs1BG8aT9FKJxFJ3orJrSyaFQ690x26pRpZbi29Wndk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sx04xqj9cCyh9oHSYYRvgsPDJmG0UpTePxmueobDnCV5nkMLi9BPsi34R3znrwGQooU6snfT7Rc1h2aUM64oqtTSwJw3zSf1h6mwis7m+8n6vny/l/6mF4WXplynIZDC+9A5dSyxvSECBYCETLbswZ4rdzx9Uq16jPo1NRKLrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEP1lFUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEP1lFUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10487C4CEE3;
	Wed, 30 Jul 2025 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753897510;
	bh=hs1BG8aT9FKJxFJ3orJrSyaFQ690x26pRpZbi29Wndk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEP1lFUjEuHDMz5py9iUrVsEfEUE3+316GPzop2YCr8II6veIhr+2UKp3+HveEOt4
	 McQndkN1Kv7EJVlTixbMJXxm4E51Dh9egxNyDeAdyYYY9BJocgN4F4s/wnO7virAn2
	 gunidqgh+rTFBKl9cIDmX9H3a0j02bihNJ7LCDm47V4nZz/RyJ3Q4hDCmaV9SPQrJc
	 X8wgSv62S+FnIk/OMBvPACfPGDalOkBwzkS0iyU/WX67vHEqZAWzE1Ynm9105LLd4i
	 V1dhUvlBjvaKkaqpNpGtHIqoBjmI8Sedasm4GzRWBj1B8SX55DpwRpYgEgQ8xvkxSU
	 cqwtdcytBispw==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: Move has filter to ops-common
Date: Wed, 30 Jul 2025 10:45:06 -0700
Message-Id: <20250730174506.60001-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <06734aa15198e542f9defbc1d29fc0731671c3d8.1753895066.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 10:19:55 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> This patch moves damon_pa_scheme_has_filter to ops-common. renaming
> to damon_scheme_has_filter.
> Doing so allows us to reuse its logic in the vaddr version
> of DAMOS_STAT
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> ---
>  mm/damon/ops-common.c |  9 +++++++++
>  mm/damon/ops-common.h |  2 ++
>  mm/damon/paddr.c      | 11 +----------
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 99321ff5cb92..3ebfa356ca46 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>  
>  	return nr_migrated;
>  }
> +
> +bool damon_scheme_has_filter(struct damos *s)
> +{
> +	struct damos_filter *f;
> +
> +	damos_for_each_ops_filter(f, s)
> +		return true;
> +	return false;
> +}

I should have tell this earlier, sorry.  I now think it would be good to have
ops-common.c own prefix, since this namee makes me expect the function is on
DAMON core layer.  Also, I use normal 'grep' and ctags at the best, and maybe
I'm not the only one that that lazy at learning new tools.

Following the weird and none-public naming convention we have on DAMON,
damos_ops_ for DAMOS-related functions and damon_ops_ for monitoring-related
functions would be the prefix for ops-common.c.

So, what about renaming this to damos_ops_has_filter() if we have a chance to
revision this once again?

> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 61ad54aaf256..8d5c5c7631ac 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  
>  bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
>  unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
> +
> +bool damon_scheme_has_filter(struct damos *s);
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 53a55c5114fb..daeceed981a0 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  	return applied * PAGE_SIZE;
>  }
>  
> -static bool damon_pa_scheme_has_filter(struct damos *s)
> -{
> -	struct damos_filter *f;
> -
> -	damos_for_each_ops_filter(f, s)
> -		return true;
> -	return false;
> -}
> -
>  static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
>  		unsigned long *sz_filter_passed)
>  {
>  	unsigned long addr;
>  	struct folio *folio;
>  
> -	if (!damon_pa_scheme_has_filter(s))
> +	if (!damon_scheme_has_filter(s))
>  		return 0;
>  
>  	addr = r->ar.start;
> -- 
> 2.47.3

Otherwise, all looks good to me.


Thanks,
SJ
