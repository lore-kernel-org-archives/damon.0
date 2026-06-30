Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8922097
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794757; cv=none; b=puzauOZV/HZHCk8JORe/DTsP0bP7JGpdrtngklc6TuYnRwokKeeIqxurEYTVviEqXP7M2PB5lUpHJYs1QkloZYQNRiGnDo6lC3HAKbGqdDfTLqqzPyg8OWnjPTdZ2jpwohWmsu6NAaOyJXrp4UcI2HlvH0uO7pa/8q0y2FjX3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794757; c=relaxed/simple;
	bh=4iCXbpvZJzj+Pv/sxw/72HvhB8xv1VwD9jsz1fuPShE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuGWX70hUT3W7gJUkw4+WKGc6zPSfNW37uHGDwrj6GtuM2t0heBJoRYQ31yJXGK7onoHZcF3EZRVPoTArsjJt4uHAzzZSf0yY0N+CRsB1kJa8wHjvMBbR7/xCo6GfG34xBVtvxHLjn2HpqAX93wkXQZvG37KxTRI4v/R4JmCxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px4FJDIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px4FJDIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8C21F000E9;
	Tue, 30 Jun 2026 04:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782794755;
	bh=EZhmRl7DNS/cI1ejCckKzqiRC3z7LWt7lN3J4b2cR5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Px4FJDIcgpjejwhaokxbiv3gvR9R4XDmyMGMR2G3tv2h+uxQufI77vjI4H6uNXUG4
	 bq+xibNJL9jttL1RlQaNY+9sAXIlsoCiXa2Bu7YbC9rbapAHjNGiZSaOqX6jIYou8e
	 wFSm/lr12XOuQTiUTx3ks7ORZe7CHxjxi3TiKg6tGKFZwdPjQfqLfO4DFNc1cmz7Mo
	 0YM+eMMyb616lyzEABgpkRvXMI12NnZ+gnRNfIRcLMyVilNngs3QyjMFMmCCn3vPjL
	 gzyevDc0neh1AbDXc8EAmcEntgqEX0RoGSQ8b7BtM3cpsg+NDGLj0UN+Ynj2HZCNDa
	 yiwn/E2Ay1sDg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 16/18] mm/damon/vaddr: remove attrs param from __damon_va_check_access()
Date: Mon, 29 Jun 2026 21:45:46 -0700
Message-ID: <20260630044547.152219-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630042214.A6C3A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:22:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Thread-unsafe static state in access check functions leads to memory access rate corruption across processes.
> - [High] Incorrect PTE advancement for large folios in DAMON operations causes skipped memory.
> --
> 
> commit 126a430836c56a402d2fefdf82a9e58aed70a6d7
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: remove attrs param from __damon_va_check_access()
> 
> The function is not using attrs parameter. Remove it.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 2eaced0765e26..2058db9c01d52 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -493,8 +493,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> >   * r	the region to be checked
> >   */
> >  static void __damon_va_check_access(struct mm_struct *mm,
> > -				struct damon_region *r, bool same_target,
> > -				struct damon_attrs *attrs)
> > +				struct damon_region *r, bool same_target)
> >  {
> >  	static unsigned long last_addr;
> >  	static unsigned long last_folio_sz = PAGE_SIZE;
> >  	static bool last_accessed;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does using static variables
> here cause a cross-thread data race?
> 
> If multiple DAMON contexts (running in separate kdamond threads) monitor
> virtual addresses simultaneously, a thread processing one process's virtual
> address might read values just written by another thread.
> 
> Could this lead to incorrect reuse of the last_accessed result and corrupt
> access rate statistics across different processes? A similar pattern appears
> to exist in mm/damon/paddr.c:__damon_pa_check_access() as well.

I'm separately working on it.  Not a blocker for this patch.

> 
> [ ... ]
> 
> Additionally, while reviewing this file, I noticed another pre-existing
> issue in damos_va_stat_pmd_entry() and damos_va_migrate_pmd_entry():
> 
> mm/damon/vaddr.c:damos_va_stat_pmd_entry() {
>         ...
>         nr = folio_nr_pages(folio);
>         s->last_applied = folio;
>         ...
> }
> 
> [Severity: High]
> This is a pre-existing issue, but does advancing the PTE by
> folio_nr_pages() overshoot the loop bounds when the start address falls
> in the middle of a large folio?
> 
> Because the address is not necessarily aligned to the start of the large
> folio, advancing by the entire folio size might overshoot the end of the
> folio and inadvertently skip subsequent PTEs that belong to unrelated
> memory. Should the advancement step account for the subpage offset?

The user impact should be minor.  I'm separately working [1] on this.  Not a
blocker for this series.

[1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org


Thanks,
SJ

[...]
