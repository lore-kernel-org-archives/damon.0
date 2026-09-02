Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0D78F3A;
	Wed,  2 Sep 2026 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321670; cv=none; b=KObG0lxAGygebVrrnypPD7LKis5UThF1pHxk8KI9Y+C//2qtglniQfGNlwFOQa3ETq8spFpZU1AgP0JgiGL+bVEG9j6vm8uki2pO5PMdUGLd+pM/rIwfnlRZy68aAT9L5TGzofnU28QiBIm2db/4Nbt5s7Hn4uukiV/KHKVs6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321670; c=relaxed/simple;
	bh=OxwbWwY38R7qZJOwWJVPTjMHHPTpg7pzp6qE46UgKRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9qzh1noz0/9H/CV2nMi++NXG8JK2nTaBubRMNUDqGUeiDeYZdsySGLgeCC8MentGH5ssrJv77xMOWBBN4ioeKlH7emggPq+rrkdhW1cYXMxvP1t8ENMPtTx/xYbPbeVjJpASl8RLCGrj9iPcwJqMdLGwSBb4+TQYa1G40Vq6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHe6kNZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHe6kNZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD21F000E9;
	Wed,  2 Sep 2026 04:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788321668;
	bh=wt1NDs6v7QlaW4AX3BZSW4pHiL3RYherAJk3Zng4lw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHe6kNZf5rmhs+WiJaE82J7FaSKP8wwhWRLqIqODlnTNAtAdWzKDqJDhpZ7the4gb
	 BySaOQHTe4g3MPz73i3oFeR+EbkrOkUWYsXkG1tl7JBaS1H2v5d/chbemHYKc6WlBn
	 9uB0iJT5Qh3ImL8n1gbAsrOpqoG2RQB3puVsguSFmSWSEZbs1WUxm6jbB82TZaiPIs
	 YCVtCDh6wfFGeE4zr7CnK8sTKWRgDdtHElW0YpvwGYu6R7/F9BrF2T3yeBgMyBfXnT
	 buYjrwIukzSISdTA3Ma1Tfratnah1sTjb1caM3mtRH4o7VCRiubTycz/9lQlgLDm0v
	 vIcTaWdhpFnwg==
From: SJ Park <sj@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: SJ Park <sj@kernel.org>,
	Nathan Gao <zcgao@amazon.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v3] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Tue,  1 Sep 2026 21:01:00 -0700
Message-ID: <20260902040101.83573-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ee0f3f47-f6c0-4b3c-807c-db80385db3b8@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 10:34:39 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 9/2/26 8:11 AM, SJ Park wrote:
> > On Tue, 1 Sep 2026 13:10:01 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> > 
> >> __damon_va_prepare_access_check() picks a random byte address within the
> >> region and stores it in r->sampling_addr. damon_va_mkold() passes it into
> >> a page table walk, which hands it to damon_ptep_mkold() as the address of
> >> the page to sample:
> >>
> >>    damon_va_mkold(mm, r->sampling_addr)
> >>      damon_va_walk_page_range(mm, addr, addr + 1)
> >>        damon_mkold_pmd_entry()
> >>          damon_ptep_mkold(pte, vma, addr)
> >>            ptep_test_and_clear_young(vma, addr, pte)
> >>            mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> >>
> >> For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> >> clearing of the young flag for large folios"), the contpte helper walked
> >> exactly CONT_PTES entries from the aligned-down page table pointer and
> >> used @addr only to pass down to each entry, so an unaligned value was
> >> harmless:
> >>
> >>          ptep = contpte_align_down(ptep);
> >>          addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> >>          for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> >>
> >> Now the range to walk is derived from @addr instead: end = addr +
> >> nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
> >> page of a contpte block, the sub-page offset puts end just past the
> >> block boundary, so the round-up lands a whole block further and the
> >> walk clears PTE_AF in CONT_PTES entries beyond the sampled block. For
> >> the last block in a page table page, those entries are past the end of
> >> that page, so the walk writes into the page that follows.
> > 
> > I just wanted to call out again that I'm wondering if we could restore the
> > unaligned address support in the helper.  E.g., as a very dirty hack that I can
> > imagine off the top of my head,
> > 
> > '''
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -30,6 +30,7 @@ static inline pte_t *contpte_align_addr_ptep(unsigned long *start,
> >                                               unsigned long *end, pte_t *ptep,
> >                                               unsigned int nr)
> >   {
> > +       *start = PAGE_ALIGN_DOWN(*start);
> >          /*
> >           * Note: caller must ensure these nr PTEs are consecutive (present)
> >           * PTEs that map consecutive pages of the same large folio within a
> > '''
> > 
> > I and Nathan have no strong clue, so we are looking for Baolin and others'
> > opinion.
> > 
> > While waiting for the opinions, I and Nathan agree we should stop bleeding with
> > a pinpoint hotfix change in DAMON.
> 
> Thanks for the reporting.
> 
> IMO, we could let the arch low-level functions handle the alignment of 
> addr, but that would also require changing functions like 
> contpte_clear_young_dirty_ptes(), contpte_set_ptes() and so on, which 
> would cause a lot of churn? (they also assume that addr is page aligned).
> 
> Since the arch low-level functions basically assume that addr is 
> page-size aligned, and the addr handling in the mm core is also mostly 
> page-size aligned, I think the caller guaranteeing that addr is 
> page-size aligned is a reasonable fix. So:

Thank you for your opinion, Baolin.  That makes sense to me.  I will try to
further revisit DAMON code to make alignment be more complete and consistent
whenever needed.

> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


Thanks,
SJ
