Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5843644C1
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226045; cv=none; b=ogHdM+8IAHoOIWQ0ZCSlity4IiNO3tAUkT51G1D79o9IDJYY2V5IwCRt0T4EBZvCd1h7EZurLiaP9npfv61Wf9A8vRrlnrHMJXNNpk9YM2pv+eT2bQdoIjkBOHWqwWM/HyptlfmCKJu8GpJNBLD7SlQ2oibnhs3hXOAirM8FbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226045; c=relaxed/simple;
	bh=Igtvo1RZyGBGmZ/XAxaRRyGuEbiUuUgCkg7GrZzcUxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7axcQ192GVsoVmf8P7NBskP8NXpndUXsQ+fwG6/cUv67QPwazG1fk+fuBiyvR0d7YXDlSa2f20E5AQnU/eXwkn02vjZagsOY2SCEVqMgklFgNsBOHQA/DDYrLCwJ7Ak+zLGWsAZvt2XACKWvw+jB5NvmJhFA9jUfRDWDNpS2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHaEXHFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHaEXHFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FFF1F000E9;
	Tue,  1 Sep 2026 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226042;
	bh=VIlBXmdWiJamUATjOoZpVtfuO7IfcZ8RnHp4OWXRAvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nHaEXHFGXMYLrIlHRqwkUosrMWe9vA1aSNrXbyHntjmu6N20r74lTOC8XrxuAHN5D
	 QI/V5EMNVt+kbK3n/ZjdxUI3Hdz+svhJHfpAjhx99wtZgfzSwtLFtPlntgm+pgXCnW
	 FrEUeEBZtHDjQbnnmsf0rgBiRIvmeCQexJN2X9qa4EBnG1Vd7x5Ry26fJ+kiFGps4f
	 yVRY4ydfRBH1ySDY5KuYsvFTChS5VekVLjK418wLptq6BYF0JN1IBAiEZatAUK7ia9
	 Kt8xHSwuRSS1o1A3Q9UcWjUFU3SImPlh6suE28ZB5hArmW1tVOSRNrhDr87DlF7/B5
	 y43TAeQ3JVAwg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Nathan Gao" <zcgao@amazon.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/vaddr: use a page-aligned address for the sampling walks
Date: Mon, 31 Aug 2026 18:27:13 -0700
Message-ID: <20260901012715.91063-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831223936.D42841F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 22:39:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch fails to fix the unaligned page table walk vulnerability for `r->ar.start` in DAMOS migration and stat paths.
> - [High] Incorrect PTE advancement for large folios in `damos_va_migrate_pmd_entry` and `damos_va_stat_pmd_entry` causes unrelated PTEs to be silently skipped.
> - [High] `damos_madvise` miscalculates the madvise range when region boundaries are not page-aligned, potentially applying actions to memory completely outside the region.
> - [High] Unaligned huge page address passed to `mmu_notifier_clear_young()` corrupts adjacent huge pages' access bits.
> --
> 
> commit fa91d6928f529249184a9980dfc55fc3ff427ea8
> Author: Nathan Gao <zcgao@amazon.com>
> 
> mm/damon/vaddr: use a page-aligned address for the sampling walks
> 
> This commit aligns the sampling address passed to damon_va_walk_page_range()
> down to a page boundary in damon_va_mkold() and damon_va_young(). This
> prevents an out-of-bounds page table access on arm64 caused by clearing the
> young flag on a batch of PTEs derived from an unaligned address.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 0648400b2d65b..fe76714d8e3d6 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -350,6 +350,9 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> >  		.hugetlb_entry = damon_mkold_hugetlb_entry,
> >  	};
> >  
> > +	/* Arch helpers can derive a page range from @addr; align it down. */
> > +	addr = PAGE_ALIGN_DOWN(addr);
> > +
> 
> [Severity: High]
> This is a pre-existing issue, but does this patch miss fixing the same
> unaligned page table walk vulnerability for r->ar.start in the DAMOS
> migration and stat paths?
> 
> While this commit fixes damon_va_mkold() and damon_va_young() by
> aligning the address before walking the page table, DAMON region boundaries
> (r->ar.start) can also be unaligned. damos_va_migrate() and
> damos_va_stat() pass r->ar.start to damon_va_walk_page_range()
> without aligning it.
> 
> When a YOUNG filter is applied, this unaligned address propagates through
> damos_va_filter_out() to damon_ptep_mkold(..., addr):
> 
> mm/damon/vaddr.c:damos_va_migrate() {
>     ...
>     damon_va_walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
>     ...
> }
> 
> Will this trigger the exact same out-of-bounds PTE access bug on arm64
> that this patch intends to fix?

For vaddr case, no DAMON API callers oerride min_region_sz.  So always regions
are aligned to default min_region_sz, which is PAGE_SIZE.  So it should be
fine.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but can passing this PAGE_SIZE aligned
> address cause state corruption for memory access tracking in secondary MMUs
> (like KVM) for huge pages?
> 
> The page table walker calls damon_mkold_pmd_entry() and
> damon_mkold_hugetlb_entry() with this page-aligned, but not necessarily
> huge-page-aligned addr.
> 
> In damon_pmdp_mkold(), this unaligned addr is passed verbatim to
> mmu_notifier_clear_young():
> 
> mm/damon/ops-common.c:damon_pmdp_mkold() {
>     ...
>     young |= mmu_notifier_clear_young(vma->vm_mm, addr,
>                                       addr + HPAGE_PMD_SIZE);
>     ...
> }
> 
> Because addr is offset within the huge page, does the invalidation range
> [addr, addr + HPAGE_PMD_SIZE) span past the end of the current huge page
> and corrupt the access bits of the adjacent huge page?

I believe clearing access bits more or less than needed should be fine, as long
as those are correctly access bits, since it is not corrupting memory.  Let me
know if I'm missing something.

> 
> >  	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
> >  }
> 
> [ ... ]
> 
> > @@ -476,6 +479,9 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr)
> >  		.hugetlb_entry = damon_young_hugetlb_entry,
> >  	};
> >  
> > +	/* Arch helpers can derive a page range from @addr; align it down. */
> > +	addr = PAGE_ALIGN_DOWN(addr);
> > +
> 
> [Severity: High]
> This is a pre-existing issue, but does the PTE loop in
> damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() incorrectly
> skip unrelated PTEs for large folios?
> 
> In these PMD entry callbacks, the advancement relies on
> folio_nr_pages(folio):
> 
> mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
>     ...
>     nr = folio_nr_pages(folio);
>     ...
>     pte += nr;
>     addr += nr * PAGE_SIZE;
>     ...
> }
> 
> If the iteration starts on a tail subpage of a large folio (for example, if
> the region boundary r->ar.start lands in the middle of a folio), the
> remaining pages of that folio in the current PMD are fewer than
> folio_nr_pages(folio). By advancing by the full folio_nr_pages(folio),
> will this overstep the end of the folio and silently skip subsequent,
> unrelated PTEs?

We are separately working [1] on this.
> 
> 
> [Severity: High]
> This is a pre-existing issue, but does damos_madvise() miscalculate the
> range when region boundaries are not page-aligned, potentially applying
> actions to memory completely outside the target region?
> 
> The boundaries are calculated using PAGE_ALIGN:
> 
> mm/damon/vaddr.c:damos_madvise() {
>     ...
>     unsigned long start = PAGE_ALIGN(r->ar.start);
>     unsigned long len = PAGE_ALIGN(damon_sz_region(r));
>     ...
> }
> 
> If a region spans from 0x10005 to 0x11000 (size 0xFFB), start
> becomes 0x11000 and len becomes 0x1000. The resulting do_madvise()
> range is 0x11000 to 0x12000. Will this completely miss the target
> region (which ends at 0x11000) and incorrectly apply destructive actions
> like MADV_PAGEOUT or MADV_FREE to the page entirely after the region?

As I mentioned above, vaddr will always have PAGE_SIZE aligned regions, so this
issue doesn't happen.

> 
> >  	damon_va_walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
> >  	return arg.young;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831221151.50561-1-zcgao@amazon.com?part=1
> 

[1] https://lore.kernel.org/20260831140254.72004-1-sj@kernel.org


Thanks,
SJ
