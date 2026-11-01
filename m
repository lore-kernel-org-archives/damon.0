Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554429;
	b=O0aWurZdRvqb1D5t9Awb+z1BDH7U++w/NKX/8FWkyYH6hgGMjlO7d04+CUj9M1Pu+CJL
	 HzwwnaPZXr9PUX0eA5Fl/PCtF24WymGqTRo/jL3TLGRw2jbF8b5/bk0RHWxLcMVpJQTLY
	 FQbi1MHY1RfRsxVH66xp2lJbmhUq5UxDw82HpPo0bak9ImOunuGeaOvAPty23fiDIl2Az
	 QoslRgCQjF/HJgw4wtGB/09V7yGpDTdJh3ZJny/fOcoKW6UW1kSIxmxgk4e1Z21i6bZCG
	 suR65ZhhOvH+bt0+b3rgc7FqFIwXcseTQsVS/rUvxaRZX28Av1XAmtHZZ5QnPJOTR+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5Af4wwRThb6wziSNe9r8m/8FYuyWHwsVTFtpr3TfGNM=;
	b=mHVzLAMi1HM5TZgT+SykIBNljuQ6DuaH6sRC3RmIsmQ6ea+SnCOadtumKUbFeSV58I3S
	 qmMWAaHlCjI/13QRv8bjciLbrZWh0xjXwrPoyiYBBChbCPhbwP9zFhDBFsbhp3/aJf+jF
	 9vtxjUTnfXWwXsktEbgdNLgScGD/Zvgksm/QBEX7iChGMFLmJImvmywA/ZEpiCfDx5/DJ
	 kDAUoqZvph91hW9wG1zfKtamZjr4KCNa5TwP6xmA1jGf1e1PsANVYqhYmRo+MaGD3Oj/U
	 kUTGh/JnMPqhgWmscQUoxtMFvKqQs2wUMy1j2POwkMWcNdSQiZiOy/suOV1HMY+zR/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVRcLhEI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC3606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVRcLhEI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5831F000C1;
	Sun,  1 Nov 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554429;
	bh=5Af4wwRThb6wziSNe9r8m/8FYuyWHwsVTFtpr3TfGNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FVRcLhEI49ERG3OYJlx+mU5241XpKwQk1V51ROBQa912ii7uzUBA4q1lLqBNpL3tf
	 8NRRZhxtnCwGOKAPjjIp/gMTMR9fPTHq5FMKz0fJcRESA6vP/YV9Oj6I86pE4UoV15
	 LULZMoKbQ3F+n6gwBcYbLsDgonbJo+7yXA00bjoy8MiNfKA3GRYAtneqRqa31SPN+f
	 EEdc9jf8+WgmfEMLF2t9cdS4IGOjn7JKNActA+Pm6bVSuICOjQgiy4ibX7bE9dSkuR
	 CLdtuXUQsNHTlCZqDHseRk5TwHrR0m40G/k/GTKFMB856QNynHck1SC67In+UKckDg
	 2WMz98MUdeiBw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 2/6] mm/damon/vaddr: use damos->last_applied for migrate action
Date: Sun,  1 Nov 2026 09:33:39 -0800
Message-ID: <20261101173341.82357-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-192531@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 01 Nov 2026 17:27:03 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] mm/damon/vaddr: last_applied not updated when damos_va_filter_out() rejects
> - [Medium] mm/damon/vaddr: stale folio in last_applied after damos_va_migrate()
> - [Low] mm/damon/vaddr: single-page PTE step in damos_va_migrate_pmd_entry()
> --
> 
> commit af5ba00f84f8ca12cd15e44abbd02f8e8e38b95b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: use damos->last_applied for migrate action
> 
> This patch updates damos_va_migrate_pmd_entry() to check and record
> s->last_applied via damos_va_invalid_folio() so that DAMOS_MIGRATE_HOT and
> DAMOS_MIGRATE_COLD actions are not applied multiple times to folios spanning
> adjacent virtual address regions.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index c271b6d63c027..b1d7bcf7305bb 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -834,6 +834,12 @@ static void damos_va_migrate_dests_add(struct folio *folio,
> >  	list_add(&folio->lru, &migration_lists[i]);
> >  }
> >  
> > +static inline bool damos_va_invalid_folio(struct folio *folio,
> > +		struct damos *s)
> > +{
> > +	return !folio || folio == s->last_applied;
> > +}
> > +
> >  static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		unsigned long next, struct mm_walk *walk)
> >  {
> > @@ -854,10 +860,11 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		if (!pmd_present(pmde))
> >  			goto huge_out;
> >  		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
> > -		if (!folio)
> > +		if (damos_va_invalid_folio(folio, s))
> >  			goto huge_out;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
> >  			goto huge_out;
> > +		s->last_applied = folio;
> >  		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> >  				migration_lists);
> >  huge_out:
> > @@ -879,12 +886,13 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		if (pte_none(ptent) || !pte_present(ptent))
> >  			continue;
> >  		folio = vm_normal_folio(walk->vma, addr, ptent);
> > -		if (!folio)
> > +		if (damos_va_invalid_folio(folio, s))
> >  			continue;
> 
> [Severity: Low]
> In damos_va_migrate_pmd_entry(), when damos_va_invalid_folio(folio, s) returns
> true because folio == s->last_applied for a PTE-mapped large folio at the
> start of the next region, the loop continues before computing page_idx and nr:
> 
> 	nr = 1;
> 	ptent = ptep_get(pte);
> 
> 	if (pte_none(ptent) || !pte_present(ptent))
> 		continue;
> 	folio = vm_normal_folio(walk->vma, addr, ptent);
> 	if (damos_va_invalid_folio(folio, s))
> 		continue;
> 	page_idx = folio_page_idx(folio, pte_page(ptent));
> 	nr = folio_nr_pages(folio) - page_idx;
> 
> Doesn't this leave nr at 1 and step through all remaining tail PTEs of that
> large folio one page at a time instead of advancing by folio_nr_pages(folio) -
> page_idx?

Good catch.  I will setup nr and page_idx before calling
damos_va_invalid_folio().

> 
> >  		page_idx = folio_page_idx(folio, pte_page(ptent));
> >  		nr = folio_nr_pages(folio) - page_idx;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
> >  			continue;
> > +		s->last_applied = folio;
> >  		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> >  				migration_lists);
> >  	}
> 
> [Severity: Medium]
> Should s->last_applied be updated even when damos_va_filter_out() rejects the
> folio in both the PMD and PTE paths of damos_va_migrate_pmd_entry(), matching
> damos_va_stat_pmd_entry() and damon_pa_migrate()?
> 
> When a PMD-mapped THP or PTE-mapped large folio spans two adjacent regions and
> is rejected by damos_va_filter_out() in the first region, jumping to huge_out
> or continuing before setting s->last_applied = folio leaves s->last_applied
> unchanged. When the second region is walked, damos_va_filter_out() is called
> a second time on the same folio.
> 
> If an ops filter such as DAMOS_FILTER_TYPE_YOUNG is used to exclude young
> folios (for example with DAMOS_MIGRATE_COLD), evaluating
> damos_va_filter_young_match() in the first region clears the page table young
> bit and marks the folio idle as a side effect:
> 
> mm/damon/vaddr.c:damos_va_filter_young_match() {
> 	...
> 	if (young && ptep)
> 		damon_ptep_mkold(ptep, vma, addr);
> 	else if (young && pmdp)
> 		damon_pmdp_mkold(pmdp, vma, addr);
> 	...
> }
> 
> Wouldn't re-running damos_va_filter_out() on the same folio in the adjacent
> region then observe the folio as old, pass the filter, and migrate the young
> folio that was just rejected in the first region?

Makes sense.  I will do so in the next version.

> 
> [Severity: Medium]
> Also, how does s->last_applied deduplicate a folio across adjacent regions
> once damos_va_migrate() has migrated it in the first region?
> 
> In damos_va_migrate(), damon_migrate_pages() runs at the end of each region
> before the next region is walked:
> 
> mm/damon/vaddr.c:damos_va_migrate() {
> 	...
> 	damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
> 	mmput(mm);
> 
> 	for (int i = 0; i < nr_dests; i++) {
> 		nid = use_target_nid ? s->target_nid : dests->node_id_arr[i];
> 		applied += damon_migrate_pages(&priv.migration_lists[i], nid);
> 		cond_resched();
> 	}
> 	...
> }
> 
> When a large folio spanning two adjacent regions is migrated during the first
> region, migrate_pages() allocates a new destination folio, remaps all PTEs or
> PMDs across the VMA (including those in the second region) to the new folio,
> and frees the source folio.
> 
> When damos_va_migrate_pmd_entry() then walks the second region,
> vm_normal_folio() or vm_normal_folio_pmd() returns the newly allocated
> destination folio while s->last_applied still holds the old source folio
> pointer. Since the pointers do not match, won't damos_va_invalid_folio()
> return false in the second region, causing damos_va_filter_out() and
> damos_va_migrate_dests_add() to be evaluated again on the already-migrated
> folio?

That's a good room to improve.  Not a blocker of this patch in my opinion,
though.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261101171630.81477-1-sj@kernel.org?part=2
> 


Thanks,
SJ
