Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0F41C62;
	Fri,  1 Aug 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091047; cv=none; b=B+/dmTg1ySpRHrO65n0E1Q61ZyQtqtnHOcGxRpqugcD4Uv6luWDBkMLOl4c5eVJwTE5xBV7A0xNuQORvTy5DpyD9SKQGVhplNcPOPEiwt+p6aKBUm2SfUpy9ZKH1ALz+pkUcYpKEWIr6/cWlLOkmyL9Eb3537Q6QyieSeKwr8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091047; c=relaxed/simple;
	bh=ctwKht944Ty5r59IlMbVaQb5+XsFWdWm6fDxZsJiL7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKqgbs/pndS3oqaABSlhKqKrOnVqnlSzYtYwN7KJG4A8kgp1Gt24/vDZU+/OlPWT7kqhQn1BSXwKkYy6sgoUuag7Ok5xV8tT0gdtft3LnYo/HbOmCflNvZadvk50q8tfQYX/euOq0H/BW5zClm4BbqbXXfRL+lmlBLl3HVcfwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhT12GCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhT12GCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EF6C4CEE7;
	Fri,  1 Aug 2025 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091046;
	bh=ctwKht944Ty5r59IlMbVaQb5+XsFWdWm6fDxZsJiL7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhT12GCYqCttbObWM0kp9mAskV2wLU/cel7pO99XFGSosrg1ezGm1oQhnHIt5rVe0
	 g9E9S4MljV1cYdcivwH0PAW26cDaFYkmxWNaBJ+Yz6RgAOhVfDWq1d29LAW3zZR9rq
	 ZeJLpGy5laJ5wNupnSPF9/Y9NuuKevDafKTeQWBN15P8FoHjzAVjXW/Z6MGcrnM/DA
	 FeMpaOMp85lvPHnef2IeuXMuvTKlzt5ZFe3MQUF5Wb4M5I94SsW2U4ZIxpjsld0rE6
	 RU4S6QaiWPxNFW1tzTMEhZs1iSNpFJdi1Y2Ri8jWgPWHpoYOZRZYKtk5DHT3uUUZD4
	 pRTFDNtF6GJJw==
From: SeongJae Park <sj@kernel.org>
To: pyyjason@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] mm/damon: Move has filter to ops-common
Date: Fri,  1 Aug 2025 16:30:44 -0700
Message-Id: <20250801233044.1392-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <a290e7913a1c39f605b8cceafd86d41c2dbebf82.1754088635.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  1 Aug 2025 22:59:50 +0000 pyyjason@gmail.com wrote:

> From: Yueyang Pan <pyyjason@gmail.com>
> 
> This patch moves damon_pa_scheme_has_filter to ops-common. renaming
> to damon_ops_has_filter.
> Doing so allows us to reuse its logic in the vaddr version
> of DAMOS_STAT

Let's update the subject to better reflect the change, e.g.,

    mm/damon/paddr: move filters existence check function to ops-common

> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> ---
>  mm/damon/ops-common.c |  9 +++++++++
>  mm/damon/ops-common.h |  2 ++
>  mm/damon/paddr.c      | 11 +----------
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 99321ff5cb92..de5404477242 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>  
>  	return nr_migrated;
>  }
> +
> +bool damon_ops_has_filter(struct damos *s)

Thank you for renaming this following my suggestion!  My suggestion was
damos_ops_has_filter(), though?

> +{
> +	struct damos_filter *f;
> +
> +	damos_for_each_ops_filter(f, s)
> +		return true;
> +	return false;
> +}
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 61ad54aaf256..d3d36bca90b9 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  
>  bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
>  unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
> +
> +bool damon_ops_has_filter(struct damos *s);
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 53a55c5114fb..9d9cdcc10b8e 100644
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
> +	if (!damon_ops_has_filter(s))
>  		return 0;
>  
>  	addr = r->ar.start;
> -- 
> 2.43.0

Looks good otherwise.


Thanks,
SJ
