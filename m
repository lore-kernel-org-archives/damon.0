Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03353537FD
	for <damon@lists.linux.dev>; Sun, 17 May 2026 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061280; cv=none; b=XNhQaoNC9+0Jc2Cu0Kk/vEBcT6roKvxWbwNgze5oaVFHJQc8b/0IEd2MfMwZBr1ETGGGk6jcE223Y3JS61NvbF6kHUe/7B8xxqV4/WHGDOwvySAlIHPHDF8lje/tdmQvJPDKQf8ZbWEyKGKKJjZ1pGXL3ZdnkTihrhfDVShArpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061280; c=relaxed/simple;
	bh=mFS5UlbTSx3XuRBw5dqSNFDN8MdSv4Nu0SW2rixCAx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHZlaocdb0UchOJzo2xsAH1XlzSMu+LHvtAzNhz5Ko+VzK1T/cITCuKNmX5YqIfYSKYZKx5uH+9kFZNf9ek/k85E8eo8txpJG8OwDVLpzj3s5r2hmHvxKJ7xcTU4E8yLD/w+QCcaxwl3uIgDjQcz3+OvSkCnh15YmM/5QHyWMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkl1mE1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkl1mE1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20B6C2BCB0;
	Sun, 17 May 2026 23:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779061279;
	bh=mFS5UlbTSx3XuRBw5dqSNFDN8MdSv4Nu0SW2rixCAx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkl1mE1bnXjI5/frHmOnleBYS2NQDtXMP878cbBb5Ev7ByxvHRy/vO6HEH0Y5BxAU
	 9m6q6SkItLYCqGK2UusEGqI3yo7uZpw2NmsFIaSFg33C/XzyU2qqSlxRBS6O+3zB4v
	 5rkXpT9K9Dr9MvyT+hjFJfRTU4Od0dZ5hoFZToY+4gG//a1/Ztu/Po6L3GOaObsnBg
	 0eM2tOdlyZL2t5pXCPxwICPxqp4CMLg+M5Msk8tn910OqIB42e5W2ziOxOUoJV9/s6
	 3wnXE+3QC5Vo91e1U0RLppdEp7oW76HgJDO9ZFh9VjuadBUr8ESyO5YeJTs8spfpHo
	 3CIIPey53GJDA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/5] mm/damon/paddr: skip free pageblocks in migration walk
Date: Sun, 17 May 2026 16:41:10 -0700
Message-ID: <20260517234112.89245-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516233628.54E2AC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 23:36:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Calling `PageBuddy()` on a tail page triggers a kernel panic.
> - [High] Unsafe address advancement skips valid memory when starting from an unaligned offset within a folio.
> - [High] Speculative access of folio flags on an unreferenced folio risks `VM_BUG_ON_FOLIO`.
> - [Medium] The optimization fails to skip buddy blocks larger than `pageblock_order` efficiently.
> - [Medium] Skipping an entire pageblock when `pfn_to_online_page()` returns NULL misses valid memory.
> --
> 
> commit 66e620b27c62d5fcd72a28187d8b381c33d31172
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> Subject: mm/damon/paddr: skip free pageblocks in migration walk
> 
> This patch optimizes DAMON physical memory walks on sparse address spaces
> by checking if a pageblock is entirely free or offline, skipping the entire
> block to reduce kdamond tick time.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index c4738cd5e221e..e844c990987b9 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -258,13 +258,32 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
> >  		unsigned long addr_unit, struct damos *s,
> >  		unsigned long *sz_filter_passed)
> >  {
> > -	phys_addr_t addr, applied;
> > +	phys_addr_t addr, end, applied;
> >  	LIST_HEAD(folio_list);
> >  	struct folio *folio = NULL;
> > +	unsigned long pfn;
> >  
> >  	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
> > -	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
> > -		folio = damon_get_folio(PHYS_PFN(addr));
> > +	end = damon_pa_phys_addr(r->ar.end, addr_unit);
> > +	while (addr < end) {
> > +		pfn = PHYS_PFN(addr);
> > +
> > +		/* Skip pageblocks that are entirely free. */
> > +		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
> > +			struct page *page = pfn_to_online_page(pfn);
> > +
> > +			if (!page) {
> > +				addr += pageblock_nr_pages * PAGE_SIZE;
> > +				continue;
> > +			}
> 
> If a memory hole is smaller than a pageblock, can skipping the entire
> pageblock miss valid, online pages in the remainder of the block?
> 
> > +			if (PageBuddy(page) &&
> > +			    buddy_order_unsafe(page) >= pageblock_order) {
> > +				addr += pageblock_nr_pages * PAGE_SIZE;
> > +				continue;
> > +			}
> 
> Does this code risk a kernel panic when calling PageBuddy() on a tail page?
> 
> If a pageblock-aligned PFN points to a tail page of a larger compound page
> (such as a 1GB HugeTLB page), PageBuddy() would trigger a VM_BUG_ON_PGFLAGS
> due to the PF_NO_TAIL policy.
> 
> Also, if a free buddy block is larger than pageblock_order, does the
> optimization fall back to stepping by PAGE_SIZE?
> 
> The first pageblock is skipped, but on the next iteration, pfn points to the
> start of the second pageblock, which is a tail page of the large buddy block.
> Because the PG_buddy flag is only set on the head page, PageBuddy(page) will
> evaluate to false.

I will revisit above details after my high level questions are answered.

> 
> > +		}
> > +
> > +		folio = damon_get_folio(pfn);
> 
> This isn't a bug introduced by this patch, but does damon_get_folio()
> speculatively access folio flags before acquiring a reference?
> 
> mm/damon/ops-common.c:damon_get_folio() {
>     ...
>     if (!folio_test_lru(folio) || !folio_try_get(folio))
>         return NULL;
>     ...
> }
> 
> If the page is concurrently freed and reallocated as a tail page of a new
> compound page, calling folio_test_lru() before folio_try_get() risks a
> VM_BUG_ON_FOLIO.

Good finding.  I will work on this.

> 
> Additionally, this wasn't introduced by this patch, but can the physical
> address advancement skip valid memory when starting from an unaligned offset?
> 
> If damon_pa_migrate() starts at an unaligned offset within a large folio, pfn
> points to a tail page, and damon_get_folio() resolves this to the head folio.
> The loop then unconditionally advances by the full folio size:
> 
>     put_folio:
>         addr += folio_size(folio);
>         folio_put(folio);
> 
> Adding the total folio size to an unaligned starting offset would push addr
> past the actual end of the folio, skipping pages in the subsequent memory
> region.

Again, good finding.  I will work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516210357.2247-1-ravis.opensrc@gmail.com?part=4


Thanks,
SJ

[...]
