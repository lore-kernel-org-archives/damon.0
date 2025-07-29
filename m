Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BE238152;
	Tue, 29 Jul 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813204; cv=none; b=AOBnvu7YlBvVwmjxXdxip3o1CJNUGfIHYm+DySZbv8ra5GXwrMG2ND9z7uQATrNBnPxI+FaIzztgmTNIoLaPLVL7ZT5143XeI1yDVLF5VWxDiK32+tdOFplE4zRWO60uUo4J3dX1OlA3IxMvxYqbDi7zy4RrQ1ziPmbzy3jxx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813204; c=relaxed/simple;
	bh=QDwhP+ZU0XuVGLZz9IuLWC3Z2KwTgUVuszFTh8nyyqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/nZSCfl0e68xTfEWrMFDTqxhH6CaGpryYqH0MZQO4aSXJmQ19b9aapJJ7ioksPHJqzhrEscYBtSOSsbgr5Zl3NpF9GsKLhw9myyme4bMK6zf+9NSl/XeO2e/d1SBRPJ/ae2Ko39qwMdg9sXm2jB73MXxZHFyz9MfcLWxeq8Ywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGs0fL0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGs0fL0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AA5C4CEF7;
	Tue, 29 Jul 2025 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813204;
	bh=QDwhP+ZU0XuVGLZz9IuLWC3Z2KwTgUVuszFTh8nyyqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGs0fL0wEDqAIyz/fdOpOD+aaAcq63/Zn04dzV0gCTJ6JD7FhdWXdgIiA42cEAyuL
	 ZIy/FqjtMIDDheIlQtioQKA9Iov/4R4xpMA2W+uH/1y0paxmT/ZkfqyQ3ZN/crZU7F
	 OtknUeSs+22M0nsRA1GofKw6pdAM3dA7upEM99IHesY2px/EQSmUlomHtaKKPmjJzo
	 y9UJw5CaN8SwzP8geSJlkUzSZ6bYKgyUPWf2RNiartkJm/uMYQKeaIwfKJxohb1G7v
	 bkPfgnMOO5Msp+0Fqs72cqg2/nwA7+LFHGNFSbN1795F5ka/XspRv86QyTwKQ8z8Fo
	 GeziZJ0Wte7Cg==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon: Move invalid folio and has filter to ops-common
Date: Tue, 29 Jul 2025 11:20:01 -0700
Message-Id: <20250729182001.56172-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2e143ff5789954b2c3c5b97b12569bc324cff087.1753794408.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 06:53:29 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> From: PanJason <pyyjason@gmail.com>
> 
> This patch moves the damon_pa_invalid_damos_folio and
> damon_pa_scheme_has_filter to ops-common. renaming them
> to damon_invalid_damos_folio and damon_scheme_has_filter.
> Doing so allows us to reuse their logic in the vaddr version
> of DAMOS_STAT

You forgot adding your Signed-off-by:

> ---
>  mm/damon/ops-common.c | 19 +++++++++++++++++++
>  mm/damon/ops-common.h |  3 +++
>  mm/damon/paddr.c      | 29 +++++------------------------
>  3 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 99321ff5cb92..7d3b48cc0f86 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -412,3 +412,22 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>  
>  	return nr_migrated;
>  }
> +
> +bool damon_scheme_has_filter(struct damos *s)
> +{
> +	struct damos_filter *f;
> +	damos_for_each_ops_filter(f, s)
> +		return true;
> +	return false;
> +}
> +
> +bool damon_invalid_damos_folio(struct folio *folio, struct damos *s)
> +{
> +	if (!folio)
> +		return true;
> +	if (folio == s->last_applied) {
> +		folio_put(folio);
> +		return true;
> +	}
> +	return false;
> +}

Unless you have different opinions about this function I mentioned on the reply
to the next patch, let's not move this function.

> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 61ad54aaf256..4e905477fdce 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -21,3 +21,6 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  
>  bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
>  unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
> +
> +bool damon_scheme_has_filter(struct damos *s);
> +bool damon_invalid_damos_folio(struct folio *folio, struct damos *s);
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 53a55c5114fb..a8b7048e871e 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -114,16 +114,6 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
>  	return scheme->ops_filters_default_reject;
>  }
>  
> -static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
> -{
> -	if (!folio)
> -		return true;
> -	if (folio == s->last_applied) {
> -		folio_put(folio);
> -		return true;
> -	}
> -	return false;
> -}
>  
>  static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
>  		unsigned long *sz_filter_passed)
> @@ -152,7 +142,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
>  	addr = r->ar.start;
>  	while (addr < r->ar.end) {
>  		folio = damon_get_folio(PHYS_PFN(addr));
> -		if (damon_pa_invalid_damos_folio(folio, s)) {
> +		if (damon_invalid_damos_folio(folio, s)) {
>  			addr += PAGE_SIZE;
>  			continue;
>  		}
> @@ -192,7 +182,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  	addr = r->ar.start;
>  	while (addr < r->ar.end) {
>  		folio = damon_get_folio(PHYS_PFN(addr));
> -		if (damon_pa_invalid_damos_folio(folio, s)) {
> +		if (damon_invalid_damos_folio(folio, s)) {
>  			addr += PAGE_SIZE;
>  			continue;
>  		}
> @@ -239,7 +229,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  	addr = r->ar.start;
>  	while (addr < r->ar.end) {
>  		folio = damon_get_folio(PHYS_PFN(addr));
> -		if (damon_pa_invalid_damos_folio(folio, s)) {
> +		if (damon_invalid_damos_folio(folio, s)) {
>  			addr += PAGE_SIZE;
>  			continue;
>  		}
> @@ -262,28 +252,19 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
>  	while (addr < r->ar.end) {
>  		folio = damon_get_folio(PHYS_PFN(addr));
> -		if (damon_pa_invalid_damos_folio(folio, s)) {
> +		if (damon_invalid_damos_folio(folio, s)) {
>  			addr += PAGE_SIZE;
>  			continue;
>  		}
> -- 
> 2.47.3

Other than above, looks good to me.


Thanks,
SJ
