Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C31CD1E4
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692727; cv=none; b=pF4miSrtFqzoEL2QpfBU1DqMuwr5oiB6hDYBi+3YUD2w/a3dPOeOreWdM7XrjWB6ua2mYmmCCnHt725KlzvVXlS4IXKPCOeyH4O9PA7YAvCaCQiBnmownErF9QmxD/GlIvvOQAyzDN7+//8NK8XdXKZTcDOYIouNIgLndf+Rs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692727; c=relaxed/simple;
	bh=SdR4en3/oYVbtT6UNkTl4rgnKtSBreTPHMwQZM2Qny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qg/4oYreQJpH4Uo8YTI3LnIkw6FvkM0wOzUcjGTj9w0b3M8adJssc6gU/Llyus3eD2aPBcSM5OkgjzjR8zaqSbThVZ5/4XCnNstWphyVU1rIOtB4Pj2T3ASpSwo2bql8oXeZRn32XncBEFB/YDsg3Bde5oMEwXfnS+0wRSjc38U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4ux3a4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4ux3a4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCB1F000E9;
	Sun,  2 Aug 2026 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692726;
	bh=0wLQNO9tcRfijjmnZM3MFyTS6LwfbefvpyJwL05qWjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4ux3a4MQ6M7PwUMoTu9/W876sXMbzSsi08lsCvJyVQq89z3n5ujSdeu2LPYMS67W
	 vkw7oGQN/VB0HAMMD+7VUKUaH8PKF4qMJ/Uv+w2j1Lx9B5ex6Djc3BA24FtcnHsAPT
	 Z0IrjZfwm0h6tujCcbKVBRe85RvOM7cCc/sSo28yLo8pBEMgk1Z4pxlh2tQOJA2E0L
	 Gsxs5LhPd7hO3QmS7kG8nKo4qtNSJfafweku0c7QjOBYyh6qegAJBuWwxogNPEdGe0
	 JGDHDqXQ1hjv01U5OKs+FtQu31qdAekX+5RpLBaLuEPSZhUaCF3JREppcZJX9kQQ10
	 hHgkTO9WRq0XA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 5/9] mm/damon/vaddr: respect folio end for DAMOS_STAT
Date: Sun,  2 Aug 2026 10:45:18 -0700
Message-ID: <20260802174519.1724-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802163631.33F561F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:36:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unsafe blind PTE batching skips intermediate mappings and misses per-PTE Accessed/Young bits for large folios.
> --
> 
> --- Patch [5]: [RFC PATCH v1.1 5/9] mm/damon/vaddr: respect folio end for DAMOS_STAT ---
> commit d6ffeea9e85e0fc3aa2c2575b8113904f9da4123
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: respect folio end for DAMOS_STAT
> 
> This commit fixes an issue in DAMOS_STAT page-level monitoring where the
> address advancement could incorrectly skip folios if a region starts in the
> middle of a large folio. It ensures the address is advanced exactly to the
> start of the next folio by calculating the correct page index.
> 
> [1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 0648400b2d65b..4b0b5edf67952 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> [ ... ]
> > @@ -844,7 +846,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  
> >  		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
> >  			*sz_filter_passed += folio_size(folio);
> > -		nr = folio_nr_pages(folio);
> > +		page_idx = folio_page_idx(folio, pte_page(ptent));
> > +		nr = folio_nr_pages(folio) - page_idx;
> 
> [Severity: High]
> This is a pre-existing issue, but does this blind PTE batching skip
> intermediate mappings and miss per-PTE Accessed/Young bits for large folios?
> 
> When damos_va_filter_out() tests the young filter, it only checks the
> accessed bit of the first pte. By unconditionally advancing pte += nr without
> aggregating the accessed bits of the remaining subpages, could this miss
> hardware accesses on PTE-mapped large folios (like mTHP) and cause DAMON to
> falsely classify actively used memory as cold?
> 
> Additionally, if userspace partially unmaps or remaps portions of this large
> folio (for example, via MADV_DONTNEED or mmap), the page table might contain
> different folios or empty entries in the skipped range. By blindly advancing
> the PTE walker based purely on the first folio's size, does this ignore those
> mixed mappings and fail to monitor the substituted folios?

Handling all the cases would be too complicated for backporting.  I will
revisit this later.

> 
> >  		s->last_applied = folio;
> >  	}
> >  	pte_unmap_unlock(start_pte, ptl);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=5
> 


Thanks,
SJ
