Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC59A921
	for <damon@lists.linux.dev>; Thu, 31 Jul 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999417; cv=none; b=osEldpsxNnudJ8k/q82ReKBqdqRCM7t9iRGcM9HHryK95DiCZ+lQgJbpEwQSf1obEuEfA44b7ye/FfcipGYIpfF2o1n0ySyDYPuys28fEWY35vtURzihwejcxO8sIY1wrBh1rDbkbM7Zf6F1s8IJawbwJ/IF6ltQQk/Hi3RZoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999417; c=relaxed/simple;
	bh=E6cJ+zxFj+aT08x4JkTfQc+SP/Jaio58xoKKp7O0wjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHUPZkdoeOcBoQ4+LGtKMdk5zRzzcXGymGQ7F/LesQaM/nDJ8QvAK3jwAfHpqGLzZqrREx/1HW+vL+swmO7Vwpuvw8wtIeWbJ6YLkhOILXDnt74yMmN9RBPI9Q4PmPNbK12stpgl/GSo44uxKS07v/dg3LgP7rD/3uG7TNoig3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6mqew48; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6mqew48"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458acf84589so15585e9.3
        for <damon@lists.linux.dev>; Thu, 31 Jul 2025 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999413; x=1754604213; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGu/ALKuNn9LH5k5HOTa1HKwUmJnZbmVQXYYh6YCD4M=;
        b=L6mqew48IImineOp0r8aKONRk9uVvznzztIxRb0o5iOYZUIufdv1FKa3rcYZR6IWxi
         c9lLN51cRL/lX+1k6f26TNvWMhm0O1VzJeIYxfONcffZJ5z0m7fbYxIJKYn2NKkjqGxv
         ++d8ndOTdxjswW0e0e+dQfaC4GRxUYNne6LddE/1k3IWPMmQ+G17KSPN35MIjMjKo4L9
         3DWozuSd6fp+DKLEYhwwgtKgwjcvK9uERRwcbmoqYqnjPKstnIDbT+rGytpd97yTDUvT
         qbFGANCIG/T/emaE8vvjy8cCMYw4h1oAryGW2lljcSJSik+5BEGzQQjVozWPuHfgYRv0
         LCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999413; x=1754604213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGu/ALKuNn9LH5k5HOTa1HKwUmJnZbmVQXYYh6YCD4M=;
        b=VGqXYK2XJX57WMWBnso1icctVprH6ofWiE3oTEurgWcu7ufsvWQ5ZAILcxLSkpDK4J
         tU0JucRH0FFYojQQgZxdeJq1GjRcoUro65CwBeqLCE4UUQHz7AxYtYLUrmw64L3tankP
         iMlmTZYombHYDIQQRGtDZokWnWXo+5LPHFYVNtEQfnCjB0B5yUrvsOmq/7da5rRWZ9+3
         VSCPon7aTUl3VC+npV8bljP6bg4/lqg7HYnmkK865s0trgPcyJ1J8ZnC/V+2rLv7e4mv
         8+Nqxk4EY8YzGQcjUVOww3MZSFysdlpWZRuWE+aukvFuT8NTiWJfy64Ge6MCeSN/1TYa
         mp+w==
X-Forwarded-Encrypted: i=1; AJvYcCUgI4SicWv3Awi7QMbSradrXny+gNcT6JZHeSH0zp5vBmd5p04YRGcXUvfl4yLf/bZQ/0wLiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7GbgGIeHfDnhDueh04EaXhHvPG4J2OIVci8SKiBUzVxaQt468
	cDuHzVkdCPxSM2G4TfXaLzTJNAbcleNVlw+ZeV2em4hcrXvwIN4EpvG3
X-Gm-Gg: ASbGnct/b8R+RwNlC3nnBCJ61QCFXuFU9QBwIJDb7/vaI8Fr3maNqNLzBa96PRYr3/Z
	euUYhY6LIs0go73t8RNpieTQ5flpikeI5pzeN4AYb1yoPq7H+QOa8pXXwPao+mpUag5xQLtiLhY
	/CSJjo8K2JZpFPu9AnFqwNWZoIYq/HJ0OgUJDjJFj/Z+myxltCoEhoINMaEmRnNah68avPfFACx
	1h7uWff5sGy4A3j7H+Zvjm0OQ8IaRGPIsUkVYV3+7G1Yz1damucA/v0B2CQqqVcJkPtEOgV/jIK
	OL5+amTgvJI5qf3Wea3r/v4l5dduAIRY4cXMOopR1iu/iPa/uqTsRKP8nMQ/W4dnGuLiwBtR15Y
	767BBGPipiYw89d+3oEtxzE7ZlE0Ska2CpcYBJsp4hmqa8izNKeRHMNq2T1bLbGgJnGYrlQZGrb
	IL8E7lVSZw8+MG76IX2Q==
X-Google-Smtp-Source: AGHT+IEpQU5RUUY6u5gnu7NyPeCEdAAfsGAjn+vhiZE1PCPsLtEeTjEmZhRhMRAnMw5GEfshKbtFxA==
X-Received: by 2002:a05:600c:3483:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-45892b9d8b9mr85100285e9.13.1753999413041;
        Thu, 31 Jul 2025 15:03:33 -0700 (PDT)
Received: from Yueyangs-MacBook-Pro.local (vpn-254-003.epfl.ch. [128.179.254.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c80sm3623933f8f.43.2025.07.31.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:03:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:03:29 +0100
From: YUEYANG PAN <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon: Add damos_stat support for vaddr
Message-ID: <aIvoMbici26ekErC@Yueyangs-MacBook-Pro.local>
References: <c05b1b4f66758c0154e4d037adcb15c43917f38b.1753895066.git.pyyjason@gmail.com>
 <20250730175652.60173-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730175652.60173-1-sj@kernel.org>

On Wed, Jul 30, 2025 at 10:56:52AM -0700, SeongJae Park wrote:
> On Wed, 30 Jul 2025 10:19:56 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > This patch adds support for damos_stat in virtual address space.
> > It leverages the walk_page_range to walk the page table and gets
> > the folio from page table. The last folio scanned is stored in
> > damos->last_applied to prevent double counting.
> > 
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/damon/vaddr.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 104 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 87e825349bdf..6ed919e817e2 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -890,6 +890,109 @@ static unsigned long damos_va_migrate(struct damon_target *target,
> >  	return applied * PAGE_SIZE;
> >  }
> >  
> > +struct damos_va_stat_private {
> > +	struct damos *scheme;
> > +	unsigned long *sz_filter_passed;
> > +};
> > +
> > +static inline bool damon_va_invalid_damos_folio(struct folio *folio, struct damos *s)
> 
> Weirdly DAMON code usually keeps the 80 columns limit.  Could you please break
> down this line?
> 
> Also, the name feels long to me.  What about damos_va_invalid_folio()?
> 

Thanks. I will fix it in the next version.

> > +{
> > +	return !folio || folio == s->last_applied;
> > +}
> > +
> > +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct vm_area_struct *vma = walk->vma;
> > +	struct folio *folio;
> > +	spinlock_t *ptl;
> > +	pte_t *start_pte, *pte, ptent;
> > +	int nr;
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	if (pmd_trans_huge(*pmd)) {
> > +		pmd_t pmde;
> > +
> > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > +		if (!ptl)
> > +			return 0;
> > +		pmde = pmdp_get(pmd);
> > +		if (!pmd_present(pmde))
> > +			goto huge_unlock;
> > +
> > +		folio = vm_normal_folio_pmd(vma, addr, pmde);
> > +
> > +		if (damon_va_invalid_damos_folio(folio, s))
> > +			goto huge_unlock;
> > +
> > +		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
> > +			*sz_filter_passed += folio_size(folio);
> > +		s->last_applied = folio;
> > +
> > +huge_unlock:
> > +		spin_unlock(ptl);
> > +		return 0;
> > +	}
> > +#endif
> > +	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	if (!start_pte)
> > +		return 0;
> > +
> > +	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> > +		nr = 1;
> > +		ptent = ptep_get(pte);
> > +
> > +		if (pte_none(ptent) || !pte_present(ptent))
> > +			continue;
> > +
> > +		folio = vm_normal_folio(vma, addr, ptent);
> > +
> > +		if (damon_va_invalid_damos_folio(folio, s))
> > +			continue;
> > +
> > +		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
> > +			*sz_filter_passed += folio_size(folio);
> > +		nr = folio_nr_pages(folio);
> > +		s->last_applied = folio;
> > +	}
> > +
> > +	pte_unmap_unlock(start_pte, ptl);
> > +
> 
> No strong opinion, but I'd like to drop above two blank lines (one after the
> for loop, and one after pte_unmap_unlock() if you don't mind.
> 

Will remove it in the next version.

> > +	return 0;
> > +}
> > +
> > +static unsigned long damos_va_stat(struct damon_target *target,
> > +		struct damon_region *r, struct damos *s,
> > +		unsigned long *sz_filter_passed)
> > +{
> > +
> 
> Seems this is unnecessary blank line.  Let's remove it.

Will remove it in the next version.

> 
> > +	struct damos_va_stat_private priv;
> > +	struct mm_struct *mm;
> > +	struct mm_walk_ops walk_ops = {
> > +		.pmd_entry = damos_va_stat_pmd_entry,
> > +		.walk_lock = PGWALK_RDLOCK,
> > +	};
> > +
> > +	priv.scheme = s;
> > +	priv.sz_filter_passed = sz_filter_passed;
> > +
> > +	if (!damon_scheme_has_filter(s))
> > +		return 0;
> > +
> > +	mm = damon_get_mm(target);
> > +	if (!mm)
> > +		return 0;
> > +
> > +	mmap_read_lock(mm);
> > +	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
> > +	mmap_read_unlock(mm);
> > +	mmput(mm);
> > +	return 0;
> > +}
> > +
> >  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >  		struct damon_target *t, struct damon_region *r,
> >  		struct damos *scheme, unsigned long *sz_filter_passed)
> > @@ -916,7 +1019,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >  	case DAMOS_MIGRATE_COLD:
> >  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
> >  	case DAMOS_STAT:
> > -		return 0;
> > +		return damos_va_stat(t, r, scheme, sz_filter_passed);
> >  	default:
> >  		/*
> >  		 * DAMOS actions that are not yet supported by 'vaddr'.
> > -- 
> > 2.47.3
> 
> 
> Thanks,
> SJ

Best Wishes
Pan
