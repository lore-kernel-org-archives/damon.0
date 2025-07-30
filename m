Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A52E3AF0;
	Wed, 30 Jul 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898216; cv=none; b=lYQZRuN1TI8wmJzj+omahINP6Xo86223K4a0cKMlOpxjz7AZoRZgtrVZuGdSn/uCJbTaLHEsil5rMP4vibS3UVA4TnlVpdPFQIKNYf0sRsXB1w3/2XZ/4DqUnorUBUPS2prx8cKBr5Hn/26RChj4nDVVZFneRPWGABsAzLWv3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898216; c=relaxed/simple;
	bh=LxlL3e6vR/HG4aAeNYWdTWRtYhjSKsDeB3n9zodRNKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MY6rRIke8nU58NwKbBA7+Qwgmwqz1c3NUrNYUsCKr6rupXwNs9mp14EVxaU1JL4rJQH6Aq2fN6Hdq8LCl7YHyRQWgFYu5zWTu34Ak0coRcFKHVEk8WL5ZnnAXUE/Aj4SKR0WsCqd7oa44gg/H4huKwIPgMRAdyghba56Vh8dwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmhIB6rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmhIB6rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1176C4CEE7;
	Wed, 30 Jul 2025 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753898215;
	bh=LxlL3e6vR/HG4aAeNYWdTWRtYhjSKsDeB3n9zodRNKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmhIB6rwEPaQO/Kz2XplzMkph3aNpT/mO8O9r3oM07r1u2d/KSkOmLDTwvIIVGs+9
	 qrS9w9JcKtrEzhSH1eZVWTCgNdV9WqCbiFnGSf7fpfPJ9a1uXtQg2rnucfQbXyH7vt
	 YpWeppA9eHbXki8P8Kpsuduy5rbUCSW7J3KH6wJ2gIXeNhmmVgjlC+aUguWjnEBVpI
	 Kw5w8z0hcK/sfavGU6AsLX39TbLvXrJ+6c0x9xv3m/kukaKKBgFDqbSLuU1VS9paIp
	 Mv37T8M6Bslm1zXa+gB5/ar0I71926sLzi6DcZRFjDj3mqUvRiMt2PyTVVnlwai9uj
	 aqDRnYn18lDrQ==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon: Add damos_stat support for vaddr
Date: Wed, 30 Jul 2025 10:56:52 -0700
Message-Id: <20250730175652.60173-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c05b1b4f66758c0154e4d037adcb15c43917f38b.1753895066.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 10:19:56 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> This patch adds support for damos_stat in virtual address space.
> It leverages the walk_page_range to walk the page table and gets
> the folio from page table. The last folio scanned is stored in
> damos->last_applied to prevent double counting.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> ---
>  mm/damon/vaddr.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 87e825349bdf..6ed919e817e2 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -890,6 +890,109 @@ static unsigned long damos_va_migrate(struct damon_target *target,
>  	return applied * PAGE_SIZE;
>  }
>  
> +struct damos_va_stat_private {
> +	struct damos *scheme;
> +	unsigned long *sz_filter_passed;
> +};
> +
> +static inline bool damon_va_invalid_damos_folio(struct folio *folio, struct damos *s)

Weirdly DAMON code usually keeps the 80 columns limit.  Could you please break
down this line?

Also, the name feels long to me.  What about damos_va_invalid_folio()?

> +{
> +	return !folio || folio == s->last_applied;
> +}
> +
> +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	struct damos_va_stat_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct folio *folio;
> +	spinlock_t *ptl;
> +	pte_t *start_pte, *pte, ptent;
> +	int nr;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (pmd_trans_huge(*pmd)) {
> +		pmd_t pmde;
> +
> +		ptl = pmd_trans_huge_lock(pmd, vma);
> +		if (!ptl)
> +			return 0;
> +		pmde = pmdp_get(pmd);
> +		if (!pmd_present(pmde))
> +			goto huge_unlock;
> +
> +		folio = vm_normal_folio_pmd(vma, addr, pmde);
> +
> +		if (damon_va_invalid_damos_folio(folio, s))
> +			goto huge_unlock;
> +
> +		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
> +			*sz_filter_passed += folio_size(folio);
> +		s->last_applied = folio;
> +
> +huge_unlock:
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +#endif
> +	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	if (!start_pte)
> +		return 0;
> +
> +	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> +		nr = 1;
> +		ptent = ptep_get(pte);
> +
> +		if (pte_none(ptent) || !pte_present(ptent))
> +			continue;
> +
> +		folio = vm_normal_folio(vma, addr, ptent);
> +
> +		if (damon_va_invalid_damos_folio(folio, s))
> +			continue;
> +
> +		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
> +			*sz_filter_passed += folio_size(folio);
> +		nr = folio_nr_pages(folio);
> +		s->last_applied = folio;
> +	}
> +
> +	pte_unmap_unlock(start_pte, ptl);
> +

No strong opinion, but I'd like to drop above two blank lines (one after the
for loop, and one after pte_unmap_unlock() if you don't mind.

> +	return 0;
> +}
> +
> +static unsigned long damos_va_stat(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +

Seems this is unnecessary blank line.  Let's remove it.

> +	struct damos_va_stat_private priv;
> +	struct mm_struct *mm;
> +	struct mm_walk_ops walk_ops = {
> +		.pmd_entry = damos_va_stat_pmd_entry,
> +		.walk_lock = PGWALK_RDLOCK,
> +	};
> +
> +	priv.scheme = s;
> +	priv.sz_filter_passed = sz_filter_passed;
> +
> +	if (!damon_scheme_has_filter(s))
> +		return 0;
> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	return 0;
> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme, unsigned long *sz_filter_passed)
> @@ -916,7 +1019,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
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


Thanks,
SJ
