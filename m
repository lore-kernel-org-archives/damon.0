Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83919D8AC;
	Fri,  1 Aug 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091558; cv=none; b=YOANnnhZ7I2DcpF1fe2ZNAQnOzXUBjiZGhha0dl+83VEWqOVib4T6/WQFGPtuyG5BmfHs5+N2pf7Nf2tlbQ98Xn/s6IfrU7VJpVgXkwv7HJ66WseD/BVbP4s6MU1GUAj62XnyRGoe6xjMYrEOQZ+DGp7CrjK9sXYFTqTwlwm19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091558; c=relaxed/simple;
	bh=MnEEczPpbP4/NoVuZ+RGReSlbA6n00lVLaBy9fFX2Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP2d04Pj0EnxxB/IhpbPCuM99CYhSHFypcHvMDQy7qHC9h2S5hsnG2sNCkh6I4UauGpU0wBcMSvQ4zEgdOA30ECTqwktNLSN5WntJkcXvOsZU+gbx7v1+SD+5zUAywXFc5bBkEhDDAmdKAgkgjMRg8oD69jIA6GyZdvq8nV14Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yit97oU8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yit97oU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DEDC4CEE7;
	Fri,  1 Aug 2025 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091558;
	bh=MnEEczPpbP4/NoVuZ+RGReSlbA6n00lVLaBy9fFX2Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yit97oU8o/aPbODWMoTlA86Rdvr8PwSZ/vBkVD7JqI8gSje7SsoPMqqkYLmuo1FUI
	 7foTlQDXiXeCrz/5rGgbtSB5aYQaYOOkuNDSK5glcDLPiSU11I9p0ik5nvmNenP63c
	 XqjJwfgdKUS9WTI2P80oq9NrUvO1A0JfFk4DK+gprYZsevZiiirhgo5CUwsMWclgth
	 +oExuvyJaIo3eejodBZFnDuRw7mbGQs5yxTEdy1C/KAsp4dUrLaqIWIdadwenQexTq
	 0BTE0KzWZYuJifphC85L4+6OwRA4ulX8pJhNkCB3pWrsJsWVHF3kzcR8L7bD3JrzoH
	 FDRTzW8f8X9fw==
From: SeongJae Park <sj@kernel.org>
To: pyyjason@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 2/2] mm/damon: Add damos_stat support for vaddr
Date: Fri,  1 Aug 2025 16:39:14 -0700
Message-Id: <20250801233914.1530-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <88cc271642476fa6025f3789781dfc8c2f576eab.1754088635.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  1 Aug 2025 22:59:51 +0000 pyyjason@gmail.com wrote:

> From: Yueyang Pan <pyyjason@gmail.com>
> 
> This patch adds support for damos_stat in virtual address space.

As mentioned on the cover letter, this is not very technically correct.  Could
you please change the subject and above changelog, as suggested on the cover
letter?

> It leverages the walk_page_range to walk the page table and gets
> the folio from page table. The last folio scanned is stored in
> damos->last_applied to prevent double counting.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> ---
>  mm/damon/vaddr.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 87e825349bdf..5960d5d36123 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -890,6 +890,107 @@ static unsigned long damos_va_migrate(struct damon_target *target,
>  	return applied * PAGE_SIZE;
>  }
>  
> +struct damos_va_stat_private {
> +	struct damos *scheme;
> +	unsigned long *sz_filter_passed;
> +};
> +
> +static inline bool damos_va_invalid_folio(struct folio *folio,
> +		struct damos *s)
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
> +		if (damos_va_invalid_folio(folio, s))
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
> +		if (damos_va_invalid_folio(folio, s))
> +			continue;
> +
> +		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
> +			*sz_filter_passed += folio_size(folio);
> +		nr = folio_nr_pages(folio);
> +		s->last_applied = folio;
> +	}
> +	pte_unmap_unlock(start_pte, ptl);
> +	return 0;
> +}
> +
> +static unsigned long damos_va_stat(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
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
> +	if (!damon_ops_has_filter(s))

I suggested to change this function's name to damos_ops_has_filter() on the
previous patch of this series.  If it is accepted, this should also be updated.

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
> @@ -916,7 +1017,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_MIGRATE_COLD:
>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
>  	case DAMOS_STAT:
> -		return 0;
> +		return damos_va_stat(t, r, scheme, sz_filter_passed);
>  	default:
>  		/*
>  		 * DAMOS actions that are not yet supported by 'vaddr'.
> -- 
> 2.43.0


Thanks,
SJ
