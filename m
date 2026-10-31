Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480176;
	b=jVCPBTSfJuKTo0KZC4wQPnBz0LMiVEBnSs9QZ1rrW+PdVqhKlcW2K2Zlx+ePhZ0CZBuF
	 SIVA1yCY6r8e6SATRVpTeledUgf+kxV78xqOD23KNOhPAzk8MR6nv9TDw2iuAb9sEu+cE
	 nlT6kacx3zhBpzAl2Pi2x12XWG06hXj/gxNE2DWinciMkPS+8+7fsgRByUI0gn6mC3wM5
	 MWOeJZaLBsaq2hqKxXSuGzE19iWcmVqr/nJfsPfB4CkHfAnUUQCIOXlLFFjVsXYyEDLmC
	 5LMjsH4zZBgUs67yMiGESFw1w/bMCkwskDauL18H14LP5N0czpw/OI6/kYyzNd6acXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bjK3yGbh9I562aCl8x1LgXKj2z60QV4RAB6gwWU7JvI=;
	b=UUYddomNRjxEvz/TNv8oET9D0OgPCf4xGO14ux2fsUuiHCIcoCmZ+kwhOG2zSvSQmpCD
	 Ob7eDHNx+RNkK7ThZCgHOXXBO9hhUtFnOVGEEotzk1gM4n4rnr4rRwNQW07Tsf0ACn3/S
	 4F3+i+QjC/Jfku3A+22OZYrhaF3qCP62KaqbalOeVCSYu5/zvgO5fXnMKBzSR2wmqrE2f
	 gBUCIvlHfcXEy88xODUdW3x5vDtd0DlnJ5t7c6Ri8fmBmDYi06amdq7SNMbepsVyOgOrS
	 MiwOVjeSX1lUj0YbiUzamIf3Ifrvlk+Wlyq5S9Hse+A7JxU91HVG4HqFDRCpn6QTh+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcN7mrT0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375A606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcN7mrT0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E0F1F000C1;
	Sat, 31 Oct 2026 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793480175;
	bh=bjK3yGbh9I562aCl8x1LgXKj2z60QV4RAB6gwWU7JvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FcN7mrT0Fk92Pf9d8ua1XgnJRDHDr2AYDAk6Q6oX1zirqp1LEZMolcKZ8/DkUMCVJ
	 b+37cUAkM7wRvYaVTmpoQ5finMV84Zak/q5m2IEMRymE8oLT2IP7baliOf28DEVP8A
	 J6FEoieIsELr9eEE9pwj9pnAL3S/AZrBKPSlhKgmZFqN4EcneNyX1hl/o11QsL9FoR
	 YA6WE3viXtwLJirmi07y4Opwjfr6M6L8VhOoSzjdeKWTWwLFMqBZjPELma/2fbqGFW
	 GNzAgo8gPGrcZHyjL4G+jqNWLyhQCXb0y82Gr5APhntirYbkgPz5fy8S2t678zObBF
	 5B7XSBLqbjdBQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 3/6] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Sat, 31 Oct 2026 13:56:06 -0700
Message-ID: <20261031205608.97086-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-192119@kernel.org>
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

On Sat, 31 Oct 2026 20:36:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] mm/damon/vaddr: uninitialized priv.sz_filter_passed in damos_va_migrate()
> - [Medium] mm/damon/vaddr: double-counted sz_filter_passed in damos_va_migrate_pmd_entry()
> --
> 
> commit 872d2945863aba3a6ac672128498f5d65dbc8d40
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
> 
> This commit adds sz_filter_passed accounting to the DAMON virtual address
> space implementation of the migrate_hot and migrate_cold DAMOS actions by
> accumulating folio sizes in damos_va_migrate_pmd_entry().
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index c271b6d63c027..112095c2d53fd 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -776,6 +776,7 @@ static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
> >  struct damos_va_migrate_private {
> >  	struct list_head *migration_lists;
> >  	struct damos *scheme;
> > +	unsigned long *sz_filter_passed;
> >  };
> >  
> >  /*
> > @@ -840,6 +841,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  	struct damos_va_migrate_private *priv = walk->private;
> >  	struct list_head *migration_lists = priv->migration_lists;
> >  	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> 
> [Severity: Critical]
> Is priv.sz_filter_passed ever initialized before the page walk runs?
> 
> In damos_va_migrate(), struct damos_va_migrate_private priv is declared on
> the stack without an initializer, and only priv.scheme and
> priv.migration_lists are set before calling damon_va_walk_page_range():
> 
> mm/damon/vaddr.c:damos_va_migrate() {
> 	...
> 	struct damos_va_migrate_private priv;
> 	...
> 	priv.scheme = s;
> 	priv.migration_lists = kmalloc_objs(*priv.migration_lists, nr_dests);
> 	if (!priv.migration_lists)
> 		return 0;
> 
> 	for (int i = 0; i < nr_dests; i++)
> 		INIT_LIST_HEAD(&priv.migration_lists[i]);
> 
> 
> 	mm = damon_get_mm(target);
> 	if (!mm)
> 		goto free_lists;
> 
> 	damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
> 	...
> }
> 
> When damon_va_apply_scheme() invokes damos_va_migrate() for DAMOS_MIGRATE_HOT
> or DAMOS_MIGRATE_COLD and damos_va_migrate_pmd_entry() encounters a present
> folio that passes damos_va_filter_out(), won't *sz_filter_passed +=
> folio_size(folio) dereference an uninitialized stack pointer?

Nice finding.  I will set the field in damos_va_migrate(), to sz_filter_passed
parameter it received.

> 
> >  	struct damos_migrate_dests *dests = &s->migrate_dests;
> >  	struct folio *folio;
> >  	spinlock_t *ptl;
> > @@ -858,6 +860,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  			goto huge_out;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
> >  			goto huge_out;
> > +		*sz_filter_passed += folio_size(folio);
> >  		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> >  				migration_lists);
> >  huge_out:
> > @@ -885,6 +888,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		nr = folio_nr_pages(folio) - page_idx;
> >  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
> >  			continue;
> > +		*sz_filter_passed += folio_size(folio);
> 
> [Severity: Medium]
> Can *sz_filter_passed double-count a large folio that spans across multiple
> adjacent damon_region ranges?
> 
> In damos_va_stat_pmd_entry(), the walk checks damos_va_invalid_folio(folio, s)
> and records s->last_applied = folio so that a PMD-mapped THP or PTE-mapped
> large folio overlapping more than one damon_region is only counted once per
> scheme application pass:
> 
> mm/damon/vaddr.c:damos_va_stat_pmd_entry() {
> 		...
> 		if (damos_va_invalid_folio(folio, s))
> 			goto huge_unlock;
> 
> 		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
> 			*sz_filter_passed += folio_size(folio);
> 		s->last_applied = folio;
> 		...
> }
> 
> In damos_va_migrate_pmd_entry(), s->last_applied is neither checked nor
> updated on either the THP path or the PTE loop path. If a large folio spans
> multiple regions and is not migrated during the first region's walk (for
> example, because folio_nid(folio) already matches the target node in
> damos_va_migrate_dests_add(), or because isolation or migration fails),
> walking the next overlapping damon_region will encounter the same folio and
> add the full folio_size(folio) to *sz_filter_passed again.
> 
> Should damos_va_migrate_pmd_entry() also check damos_va_invalid_folio(folio,
> s) and update s->last_applied = folio?

Good finding.  But this is a pre-existing issue.  I think it is better to be
fixed first, before this patch, though.  I will add the fix to this series, or
post it as a separate one before this series is merged.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261031202614.96036-1-sj@kernel.org?part=3
> 


Thanks,
SJ
