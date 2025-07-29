Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FEABE4E;
	Tue, 29 Jul 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812914; cv=none; b=Z+XAgnjcDfQY7KG3ws/uVyvJBBMnZ4QT+tV8zUMCODVQqjjnSBDVNPob0RHfTVRHrWDpqDnEzBmuhbuGvj09vm3sleT8WEzpGavZAcj1M+dvoS0ZzcNysLhy1txIbXj1iywLBUMctmmI7fM8CXeeDaQiTPaM0Yj3/SW7QZdEyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812914; c=relaxed/simple;
	bh=TZBXNASe2pDArkZUxLGfDiu3sHbEqjRKTJxrS5ouBFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8Lkdq9p+aGGg+rIT0VXXyCn/wlGmVvnkKsI6lf3flyV9v8eW3gLwSuZrRLcKDNEHMz/zQLiXpyMEAMI2YEKX7Ll6fDo2A9uBV88AE8HFKIJbxrYNgxwxqejHrbsaf/f3GUfD0c+rQSGWl9fzIfQi1BNjjkzg+6IUmFHsHB4USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4vtOIB5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4vtOIB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DF3C4CEEF;
	Tue, 29 Jul 2025 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753812914;
	bh=TZBXNASe2pDArkZUxLGfDiu3sHbEqjRKTJxrS5ouBFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4vtOIB5goB0G2wlEpeI5Fr7i+EoWJ8c2jyBLUs/g4xSJrX7T5EDUNm/GeORWt8lN
	 O6QZ1bzxPmee+Kyx0SCq6Yn0fCBdqimJL99tm9FG+TIqWijEPg4N5yNIOdabvM/RkR
	 8Mg40E7YPj8cMkto4MLdbB7oWrJfKbGekJwUPEp38Zkxly9g8mOb094yEdGTy3B+ef
	 F0HmC4djkXyrHOfqFbZtrv3Rv2qCHtlcTC1YVlzlP3B505aWU49bxMMuYJ2mZfORBn
	 yBPv4yLzzCnQjtUl4sOr78vy2soY3fdtb2MgdJKYxBzGdxiGhEl4laSs7DOZrUEBXr
	 pw7CGR7wAtTYw==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 11:15:10 -0700
Message-Id: <20250729181510.56035-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 06:53:30 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> From: PanJason <pyyjason@gmail.com>
> 
> This patch adds support for damos_stat in virtual address space.
> It leverages the walk_page_range to walk the page table and gets
> the folio from page table. The last folio scanned is stored in
> damos->last_applied to prevent double counting.

Thank you for this patch, Pan!  I left a few comments below.  I think those are
mostly insignificant change requests, though.

> ---
>  mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 87e825349bdf..3e319b51cfd4 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
>  	return applied * PAGE_SIZE;
>  }
>  
> +struct damos_va_stat_private {
> +	struct damos *scheme;
> +	unsigned long *sz_filter_passed;
> +};
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	struct damos_va_stat_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> +	struct folio *folio;
> +	spinlock_t *ptl;
> +	pmd_t pmde;
> +
> +	ptl = pmd_lock(walk->mm, pmd);
> +	pmde = pmdp_get(pmd);
> +
> +	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
> +		goto unlock;
> +
> +	/* Tell page walk code to not split the PMD */
> +	walk->action = ACTION_CONTINUE;

As David suggested, let's unify this with pte handler following the pattern of
madvise_cold_or_pageout_pte_range() and drop above ACTION_CONTINUE code, unless
you have different opinions.

> +
> +	folio = damon_get_folio(pmd_pfn(pmde));

As also David suggested, let's use vm_normal_folio_pmd() instead, and drop
unnecessary folio_put().

> +	if (!folio)
> +		goto unlock;

damon_invalid_damos_folio() returns true if folio is NULL, so I think above
check is unnecessary.

> +
> +	if (damon_invalid_damos_folio(folio, s))
> +		goto update_last_applied;

Because we didn't really apply the DAMOS action, I think it is more proper to
goto 'unlock' directly.

Oh, and I now realize damon_invalid_damos_folio() puts the folio for none-NULL
invalid folio...

Because the code is simple, let's implement and use 'va' version
invalid_damos_folio(), say, damon_va_invalid_damos_folio(), which doesn't put
the folio.

> +
> +	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
> +		*sz_filter_passed += folio_size(folio);
> +	}

Let's remove braces for single statement, as suggested[1] by the coding style.

> +
> +	folio_put(folio);
> +update_last_applied:
> +	s->last_applied = folio;
> +unlock:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_va_stat_pmd_entry NULL
> +#endif
> +
> +static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	struct damos_va_stat_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> +	struct folio *folio;
> +	pte_t ptent;
> +
> +	ptent = ptep_get(pte);
> +	if (pte_none(ptent) || !pte_present(ptent))
> +		return 0;
> +
> +	folio = damon_get_folio(pte_pfn(ptent));

As David suggested, let's use vm_normal_folio() here, and remove below
folio_put().

> +	if (!folio)
> +		return 0;

As also mentioned above, let's drop above NULL case check, in favor of that in
damon_va_invalid_damos_folio().

> +
> +	if (damon_invalid_damos_folio(folio, s))
> +		goto update_last_applied;

Again, I don't think we need to update s->last_applied in this case.  Let's
do only necessary cleanups and return.

> +
> +	if (!damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL)){
> +		*sz_filter_passed += folio_size(folio);
> +	}

Let's drop braces for single statement[1].

> +
> +	folio_put(folio);
> +
> +update_last_applied:
> +	s->last_applied = folio;
> +	return 0;
> +}
> +
> +static unsigned long damos_va_stat(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +

Let's remove this unnecessary blank line.

> +	struct damos_va_stat_private priv;
> +	struct mm_struct *mm;
> +	struct mm_walk_ops walk_ops = {
> +		.pmd_entry = damos_va_stat_pmd_entry,
> +		.pte_entry = damos_va_stat_pte_entry,
> +		.walk_lock = PGWALK_RDLOCK,
> +	};
> +
> +	priv.scheme = s;
> +	priv.sz_filter_passed = sz_filter_passed;
> +
> +	if (!damon_scheme_has_filter(s)){
> +		return 0;
> +	}

Let's remove braces for single statement[1].

> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	pr_debug("Call va_stat: %lu\n", *sz_filter_passed);

I don't think we really need this debug log.  Can we remove?

> +	return 0;
> +

Yet another unnecessary blank line.  Let's remove.

> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme, unsigned long *sz_filter_passed)
> @@ -916,7 +1027,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_MIGRATE_COLD:
>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
>  	case DAMOS_STAT:
> -		return 0;
> +		return damos_va_stat(t, r, scheme, sz_filter_passed);
>  	default:
>  		/*
>  		 * DAMOS actions that are not yet supported by 'vaddr'.
> -- 
> 2.47.3

[1] https://docs.kernel.org/process/coding-style.html


Thanks,
SJ
