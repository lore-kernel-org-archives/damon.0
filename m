Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F4283C82
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395202; cv=none; b=D82OyDBHUGOpSL6vkTVyqfQebe5fCgyE+veIJTtsgLFIz5LeSEVOeSfoiOKmuVUW+9IZm3z8NBHNRbl14LZz9dtc4djjb4Dv0t0Q8XkzUHdnvfdedzDEzmjnj4OZagdlv7yZOaNUc88uJfxPevpjv+bzar93qWwOZklxYu3D1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395202; c=relaxed/simple;
	bh=f2EHg3IxZFJ0EdYVhUVYb2/yeB7v1FllkhlSdEkdcfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBW668WUgU/BOS488TpsWZLTprTkhVPc85Fg0n9OOv88lexuMJgT0Kng6unSmctre5AbY/usIRHhjOTx2yQFaSg6QdfhBjDJGY5UX4AVdmZynkt/bpyW6I9T174XJTGJU01fDmGauPN4LkQppK6+Unc3j3uMm07S9xljRdm3wXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFEcbvWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFEcbvWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D601F000E9;
	Sat, 18 Jul 2026 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784395200;
	bh=YpDV1on0CD3YnyPVqrwl7ht6tZQQ/NxRem2kPW17LKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFEcbvWx8rIuOGRLQN+D7YQkjnuxcjY6E4+HL7oowARigFJ+Q6wNCt5HLck/1yzVC
	 LtKQ15CTu1XKsMO0fDNbEqY3JZ7tqhad5a6DfGdmgZvybD2JaZjWz8+qaK+YmUtSCF
	 fAQgDaFJ76H1uYm0gTwm07TRPzDDXtBYrME/T2rGpdtqNF7f6otV7WS0BHhGaHR1qo
	 fA0pgCsuhTCzEIBq/UwHaxxyb3oWUQZqv4HSkBEiV14J9NvC6g3Xs6c7m1p2+5nOFj
	 MhIiEMuoDLJuArd6zTSdfaAmr4bOZ/dQXuLEGaI/Rd7Ehmptq82z9bwx7ZndXGPQ0B
	 aD3E9yz8AGm4w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Sat, 18 Jul 2026 10:19:36 -0700
Message-ID: <20260718171936.87766-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718171523.87547-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 10:15:29 -0700 SJ Park <sj@kernel.org> wrote:

> On Sat, 18 Jul 2026 17:00:57 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Incomplete bug fix in damon_apply_min_nr_regions() leads to O(N^2) allocator thrashing on allocation failure.
> > - [High] Silent failure of damon_split_region_at() bypasses DAMON quotas and bounds checks.
> > --
> > 
> > --- Patch [1]: [PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions() ---
> > commit 51e7e9012c52dde83bac4be44f0bbfbdbe01572d
> > Author: SJ Park <sj@kernel.org>
> > Subject: mm/damon/core: handle region split failure in apply_min_nr_regions()
> > 
> > damon_apply_min_nr_regions() repeatedly split each region until its size
> > becomes small enough to meet the user-defined low limit of the number of
> > regions. The loop assumes the split operation (damon_split_region_at())
> > will always succeed and create the new region.
> > 
> > Link: https://lore.kernel.org/20260717011834.120715-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 20d267c615faf..3d829e0ad63b5 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -1913,6 +1913,9 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
> > >  		damon_for_each_region_safe(r, next, t) {
> > >  			while (damon_sz_region(r) > max_region_sz) {
> > >  				damon_split_region_at(t, r, max_region_sz);
> > > +				/* split might failed */
> > > +				if (r == damon_last_region(t))
> > > +					break;
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does this fix leave an
> > O(N^2) allocator thrashing loop when an allocation fails on a non-last
> > region?
> > 
> > If a region fails to split due to memory pressure and is not the last
> > region, the inner loop unconditionally advances r = damon_next_region(r).
> > This moves to the next pre-existing region instead of a newly created
> > one, and the inner loop will attempt to split this next region, continuing
> > to the end of the list.
> > 
> > Then, the outer damon_for_each_region_safe() loop advances to its
> > pre-saved next pointer and repeats the entire process.
> > 
> > Could this severely thrash the page allocator with redundant
> > kmem_cache_alloc() calls and cause RCU stalls or lockups during an
> > OOM condition?
> 
> The allocation is arguably too small to fail.  And the while loop is supposed
> to run only occasionally.  Most regions in most case would not exceed
> max_region_sz.  But good call.  I will separately work on making this more
> safe.

Hmm, but no reason to rush.  I will fix this together in the next revision.


Thanks,
SJ

[...]
