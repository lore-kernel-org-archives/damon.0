Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108C1FE44D;
	Tue, 29 Jul 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811204; cv=none; b=Wv3FSxlR9vxJzUsaD8yjfOpzztRbxOjUTG9MFchis3i1BeDxoytGQSDCCWIuwQsRsMDSr77Iwmhr8OFawgN5nBLhGJ4pbe87TN4lZZ9XHc3e2wN9xdvAAdRRYEkPoyJaggSshbZAKT1A384qNDf9Rrno2jQHphp5Lcc/qkt2zEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811204; c=relaxed/simple;
	bh=axw56qNK2M0b9TkvZbH1wszkzgL5tAgxNV9SaY843S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J07sbmUbL5lv9Ky2lSEE9De+A0d9XR2Og2RMXJk83b/J1MGCy2J1Kx8dcCyMq/6xyTrkbpPf/5OclSkavJEbhHDmsQ6zhl9OlDGhMBOar+efgcAkOEyNNNJ3iQ1qsOyW9661gKZDPITpEzir2a4KaqiP3G2b7aCp+rquP1VSWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlY7dXwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlY7dXwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446F7C4CEF4;
	Tue, 29 Jul 2025 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753811203;
	bh=axw56qNK2M0b9TkvZbH1wszkzgL5tAgxNV9SaY843S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlY7dXwCI86fpg+qoNSTeO6Z/W+YBwY1+Ujfh2mG014Qp6YO0B4PSgJ3+Enpz/4pP
	 bfYBXJ/2AZG1Gl2tAhtewL8evwnyfKaX1Y6P9Iczjp/WVj8v+V6Vir3cZ6Mgr77QMY
	 0pN9uoT0Zz8E/jbjgcDOSbGCG49f0Lf+U/Y9JKoFzjeBwh7s+nFtqr4l0iOE0Q/snY
	 FeSrCS3UOKf+vSlok4vS855A7SSP6RLN5L4Vo+gEKLMCDVcykpmTPkAV3ZexHdeKwS
	 pBoj9WvOXGCo0KxEPKVuM8xDzquvO8tAQ4Ezcuu4argY0mFnMIgvkSkIQfnQWC+lFB
	 IsAJWURV0Vslg==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Yueyang Pan <pyyjason@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 10:46:40 -0700
Message-Id: <20250729174640.55762-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pan and David, thank you for this patch and comments!

On Tue, 29 Jul 2025 16:11:32 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 29.07.25 15:53, Yueyang Pan wrote:
> > From: PanJason <pyyjason@gmail.com>
> > 
> > This patch adds support for damos_stat in virtual address space.
> > It leverages the walk_page_range to walk the page table and gets
> > the folio from page table. The last folio scanned is stored in
> > damos->last_applied to prevent double counting.
> > ---
> >   mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 112 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 87e825349bdf..3e319b51cfd4 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
> >   	return applied * PAGE_SIZE;
> >   }
> >   
> > +struct damos_va_stat_private {
> > +	struct damos *scheme;
> > +	unsigned long *sz_filter_passed;
> > +};
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct folio *folio;
> > +	spinlock_t *ptl;
> > +	pmd_t pmde;
> > +
> > +	ptl = pmd_lock(walk->mm, pmd);
> > +	pmde = pmdp_get(pmd);
> > +
> > +	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
> > +		goto unlock;
> > +
> > +	/* Tell page walk code to not split the PMD */
> > +	walk->action = ACTION_CONTINUE;
> > +
> > +	folio = damon_get_folio(pmd_pfn(pmde));
> > +	if (!folio)
> > +		goto unlock;
> > +
> > +	if (damon_invalid_damos_folio(folio, s))
> > +		goto update_last_applied;
> > +
> > +	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
> > +		*sz_filter_passed += folio_size(folio);
> 
> See my comment below regarding vm_normal_page and folio references.
> 
> But this split into two handlers is fairly odd. Usually we only have a 
> pmd_entry callback (see madvise_cold_or_pageout_pte_range as an 
> example), and handle !CONFIG_TRANSPARENT_HUGEPAGE in there.
> 
> Then, there is also no need to mess with ACTION_CONTINUE

I don't really mind this, but I agree keeping the consisteency would be good.
Pan, could you please unify the handlers into one?

> 
> > +	}
> > +
> > +	folio_put(folio);
> > +update_last_applied:
> > +	s->last_applied = folio;
> > +unlock:
> > +	spin_unlock(ptl);
> > +	return 0;
> > +}
> > +#else
> > +#define damon_va_stat_pmd_entry NULL
> > +#endif
> > +
> > +static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct folio *folio;
> > +	pte_t ptent;
> > +
> > +	ptent = ptep_get(pte);
> > +	if (pte_none(ptent) || !pte_present(ptent))
> > +		return 0;
> > +
> > +	folio = damon_get_folio(pte_pfn(ptent));
> > +	if (!folio)
> > +		return 0;
> 
> We have vm_normal_folio() and friends for a reason -- so you don't have 
> to do pte_pfn() manually.
> 
> ... and now I am confused. We are holding the PTL, so why would you have 
> to grab+put a folio reference here *at all*.

We don't have to.  I think Pan does so because other similar existing code in
this file is also doing so.  I was doing so because I wanted to use the handy
damon_get_folio() and those are not making real problems.

But, yes, unnecessary things are unnecessary things.  Pan, could you please use
vm_normal_folio() instead of damon_get_folio() and remove the related
folio_put() call?

I will also work on cleanup of existing unnecessary folio reference
manipulations, regardless of this patch series.


Thanks,
SJ

[...]
