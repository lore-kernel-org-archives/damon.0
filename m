Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAB1940B0
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876908; cv=none; b=EF0Eui1z/bnJYLd7i5lBFnMh0MgkooTOPKfyixh/jU9jndpHVv6f95Nt56C4KvKXVzDWCfRNXVgHNg3zc/LSEJglJdvN8tznAyCIwGxkkZscM5VsdU+ZCpWCrHyWFF5NuUyG250eUjwboQCB0rb5XLNPg487+ttyPo9rF5TL3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876908; c=relaxed/simple;
	bh=vb+btUtLAYzzl9FcK/m/lgwbR4XtV32+lzKCmDJMuO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lz1zfGDsCtgtZa+MYalK07sulD4uRjXr6Kg/sDvQFxoX2BPJ/2X+aNhUos+oTMzXVQi0XyAExoFRzgL7zZcS8BjGZ+nN1YZev8XRuysSioKbFujl1dp6UzHXpc3Iu02qfu6POz2U1QZ8MKJ+DeKjJg2Sqt3sKTIwKJXzMegAROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXt9rVbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXt9rVbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315331F000E9;
	Fri, 28 Aug 2026 00:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787876907;
	bh=5GdCFEvQV7FfB0ZvBH/LAC2KZvRhGC3hGHP8QTbJhEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EXt9rVbnEG0lDzRJ7bDbVDg/yn1SMUFAOIXlJOm1ls1W1JXXWQLoQR9mzJk7ZUOEp
	 TUQGVvpVD+8JYvbbLGbUXyRn7htUTew2XS35wYtXGMR4erpe/7FdxdnM10F2ylP7DQ
	 Pzrtwhmj1Te6OGQGKLe7x4tPPzU7ZiZnaVrWhYhrJeTCXFAo2QgKA+NHOL4bYA4Sa+
	 bhbXelhPch/Z4PwnbX7FVqVo77YsbXSAhG+tmqyjaJAYBoJllow8TuuaZl60ml5RAV
	 BSbGtyCzxbNT8GryhqkuKqeR3DTBZWpNTZ9+EBAPJ0eHq1y2+cfzXmTLhESkeZK77A
	 UxbqQXz7eqpWQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Nathan Gao" <zcgao@amazon.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon: use a page-aligned sampling address
Date: Thu, 27 Aug 2026 17:28:18 -0700
Message-ID: <20260828002820.62184-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827195026.5B6DE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 19:50:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unaligned address passed to `mmu_notifier_clear_young()` in THP and HugeTLB paths causes out-of-bounds young bit clearing.
> - [High] damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() incorrectly advance the PTE loop by folio_nr_pages(), skipping unrelated PTEs.
> --
> 
> commit aa3021f597712046c0814751d5b225db6dfc5b6c
> Author: Nathan Gao <zcgao@amazon.com>
> Subject: mm/damon: use a page-aligned sampling address
> 
> This patch modifies the DAMON virtual address access check to page-align
> the randomly chosen sampling address. This prevents issues on architectures
> like arm64 where an unaligned address could lead to walking past block
> boundaries and causing page table corruption.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 0648400b2d65b..8856a9131971d 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -361,7 +361,8 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
> >  					struct damon_region *r,
> >  					struct damon_ctx *ctx)
> >  {
> > -	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
> > +	r->sampling_addr = PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
> > +						      r->ar.end));
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while this patch page-aligns
> the sampling address, can this still cause out-of-bounds young bit clearing
> for huge pages?
> 
> When DAMON samples a region, the address is passed down to THP and HugeTLB
> handlers. If the sampled address retains a sub-huge-page offset, the range
> passed to the MMU notifier spans two contiguous huge pages:
> 
> mm/damon/ops-common.c:damon_pmdp_mkold() {
>     ...
>     young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE);
>     ...
> }
> 
> mm/damon/vaddr.c:damon_hugetlb_mkold() {
>     ...
>     if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(hstate_vma(vma))))
>     ...
> }
> 
> Secondary MMUs like KVM check for GFNs overlapping this range. Because the
> adjacent huge page overlaps with this range, KVM could incorrectly clear its
> young/accessed bit, altering the access history of an unrelated huge page.

Makes sense, I will work on this.

> 
> 
> [Severity: High]
> This is also a pre-existing issue not introduced by this patch, but do the
> PTE walk loops in damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry()
> skip unrelated PTEs?
> 
> mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
> 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> 		nr = 1;
> 		ptent = ptep_get(pte);
> ...
> 		folio = vm_normal_folio(walk->vma, addr, ptent);
> ...
> 		nr = folio_nr_pages(folio);
> 	}
> }
> 
> In the PTE walk loops, the step size nr is set to folio_nr_pages(folio).
> However, folio_nr_pages() simply returns the total size of the large folio.
> If the large folio is only partially mapped within the VMA, or if the
> iteration starts at an offset into the folio, blindly advancing pte += nr
> and addr += nr * PAGE_SIZE will overshoot the folio's boundaries. Could this
> skip valid PTEs that map entirely different folios, causing DAMON to silently
> ignore those pages?

I'm working [1] on this.  The plan is to post it again without RFC tag after
the current merge window is closed.

[1] https://lore.kernel.org/20260802162631.90304-1-sj@kernel.org

> 
> >  
> >  	damon_va_mkold(mm, r->sampling_addr);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260827193821.46115-1-zcgao@amazon.com?part=1


Thanks,
SJ
