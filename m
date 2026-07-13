Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28830FC03
	for <damon@lists.linux.dev>; Mon, 13 Jul 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954173; cv=none; b=ZaxVZOGbEHoB5UbHMLRBFvS6j6d4h3hBrQhCB+H6Mo9po9QdnsxVFTKnmVfC7Mvl020VVV6/2mC0/+jC4VQ2wV0pBSJGUCOlw90XXC4cLbX+LORZQ+54XkqW6PZthziRH7dgoc/cPp6zRfItIlbPFb4l2JSODEt5wKwyD0roTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954173; c=relaxed/simple;
	bh=9s64n2bpO9XF4piXZIEn5D5BihGVPt9pf9ZwKDw7HiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmVHh6AwWdToEcEvXIfI9CrgBhujW4dU1/R725vf/4fXUGme0LnrIm6Ae95uSuahpO9KMDKSuIK3L5ZVnMFrhO+iE0g/uCxf67AHi4wTloxZIG022U4SKj9tEZJnkeMpBNwJR6doXU8Af1k1H1ZApmfp4oBmhr1bojZbtHfb0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5icjl7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5icjl7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14951F000E9;
	Mon, 13 Jul 2026 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783954172;
	bh=CiEEhxCWkkUoKZtR22IRPbBXtvxSkwtFFU7pcLqIwIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5icjl7GpGjJkirvpI7nqX9L5gIWPHplcg7vL2Ol/lnQT712R1YzR2rw3yxECl2jM
	 jYd9UNMQuZAAFx4JbyjJETFUrNi4/UkVxyt2OpZgBigfk2ST9peoEfv5stg3PJjhnM
	 Aj9Fs/ggD1bkcaDX602ks256ZwgWPV/vxaXSRpZd0IOn9vuOigH246pe3HFmoj2h+Q
	 bLia5oP8Xt6hMIXxgBnWJcPy7wISV0fym5UhgBEoC4P2icH8/XkQD3Tmii2PxknBuv
	 aWhfUdRssMC/7nFl6/oNt9U5BcIm9hoa8oXDqf2mGYN7RWhk9VMlDlZvaN39DhHypd
	 dePKHss8NQgow==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 3/5] mm/damon/vaddr: drop last same folio access check optimization
Date: Mon, 13 Jul 2026 07:49:23 -0700
Message-ID: <20260713144925.39871-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713140653.E81971F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 13 Jul 2026 14:06:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete fix: identical data race in `mm/damon/paddr.c` causes access statistics corruption
> --
> 
> --- Patch [3]: [RFC PATCH v1.2 3/5] mm/damon/vaddr: drop last same folio access check optimization ---
> commit d42bea4a157d94e45112b2190d4aba2a5eeffaa2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: drop last same folio access check optimization
> 
> This patch removes the "last same folio access check" optimization in
> vaddr.c to fix a data race when multiple kdamonds are running.
> 
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index d10b8042adb5b..d487b7a4a1042 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> 
> [ ... ]
> 
> > @@ -494,28 +487,17 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> >   * r	the region to be checked
> >   */
> >  static void __damon_va_check_access(struct mm_struct *mm,
> > -				struct damon_region *r, bool same_target)
> > +				struct damon_region *r)
> >  {
> > -	static unsigned long last_addr;
> > -	static unsigned long last_folio_sz = PAGE_SIZE;
> > -	static bool last_accessed;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same data race still
> exist in mm/damon/paddr.c?
> 
> Looking at __damon_pa_check_access() in mm/damon/paddr.c, it seems to have the
> exact same caching optimization using static variables:
> 
> 	static phys_addr_t last_addr;
> 	static unsigned long last_folio_sz = PAGE_SIZE;
> 	static bool last_accessed;
> 
> Since these static variables aren't protected by any locks, could concurrent
> kdamond threads using DAMON_OPS_PADDR clobber each other's state in the exact
> same way?
> 
> For example, if Thread A processes a 2MB huge page and updates last_folio_sz
> to 2MB, could Thread B evaluate its next sampling_addr using Thread A's 2MB
> last_folio_sz?
> 
> This would cause ALIGN_DOWN(last_addr, 2MB) == ALIGN_DOWN(sampling_addr, 2MB)
> to incorrectly evaluate to true for up to 512 consecutive 4KB pages, assigning
> them all the last_accessed value without actually checking them. Should this
> identical optimization be removed from paddr.c as well to completely resolve
> the data race?

Yes, that's what the next patch in this series is fixing.

> 
> > +	bool accessed;
> >  
> >  	if (!mm) {
> >  		damon_update_region_access_rate(r, false);
> >  		return;
> >  	}
> >  
> > -	/* If the region is in the last checked page, reuse the result */
> > -	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
> > -				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
> > -		damon_update_region_access_rate(r, last_accessed);
> > -		return;
> > -	}
> > -
> > -	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
> > -	damon_update_region_access_rate(r, last_accessed);
> > -
> > -	last_addr = r->sampling_addr;
> > +	accessed = damon_va_young(mm, r->sampling_addr);
> > +	damon_update_region_access_rate(r, accessed);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713135838.32730-1-sj@kernel.org?part=3


Thanks,
SJ
