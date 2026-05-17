Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211562236EE
	for <damon@lists.linux.dev>; Sun, 17 May 2026 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061584; cv=none; b=NxR146bR1K3sazDQLdS4qzkR9VsstNfffSMl0Ka/u60QYT204x7Qitb/WwpF7+8awCLU1oHmCfzv/ccPO3ORERVepGnF9Xf6z1fELe3VgsSFzAIdfpV7irOgMMcZ2ogNy3ngtj6FhowkI1nf36KZtClbJsSNCdNrTHTMMpfHuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061584; c=relaxed/simple;
	bh=tW6uHsNbpddjVWNBW7GY/2rknQ5+yKrZzzf78yfzhQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evdQpmPA6bMER/iPM7WzMTlGi/1oOiAtP6VCa1wAZgxsVf3n+Jl3uuNH954/zJ6S3CdCw4lkHZRQOF5o9ZAtNn9YMmsQuC2C+OOJkIHOnIeXPS+TKqi2cKcWf2o3x+Q0y4tGQh34yRU7sdeECaSdAEIYh2g0RlMqjO52RMfJC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv9lJfeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv9lJfeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC2C2BCB0;
	Sun, 17 May 2026 23:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779061583;
	bh=tW6uHsNbpddjVWNBW7GY/2rknQ5+yKrZzzf78yfzhQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bv9lJfeAHc4z+7nRA5nxd7cL/IRPHoS0pitL+WW1LJGikcUrOykqm1n4LMdj1O4KF
	 K3puUsiIr6+IlZusUqmA0dgHbD5+O8laD417sKo9FkYaCeKuc8dMlY101jw5Gq4CIH
	 mCcbZCBmZoOcficROitu6kERLO51ryqjhrZ32+45bvsCdOUx4E6q0N8PuB/m8LN5h0
	 utjRbzJtI1mSsSCF7JQwdLNULJEcQlxEVj3Zen1L6FWi1POuP2IKvdAg61r+mwLOKT
	 38xfvywSsD5UPo0kJDeIch9dnJRXxlb2QptPUHmpy50i4aXCDeqKQyVANZxLOoxik8
	 hwMsa2FDRSHew==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] mm/damon/paddr: add time budget to migration page walk
Date: Sun, 17 May 2026 16:46:14 -0700
Message-ID: <20260517234616.89496-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516235545.18B71C2BCB7@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 23:55:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] The amortized time budget check can be permanently bypassed due to variable PFN strides and loop continues.
> - [High] Early termination causes permanent starvation for the tail end of large DAMON regions.
> - [High] The time budget targets the wrong phase, failing to cap the actual latency spike of the migration.
> - [High] PFN advancement after folio conversion permanently misaligns the scan.
> --
> 
> commit 87860cbf6b4be5f161140aa9a1f9b7d0461955ba
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> 
> mm/damon/paddr: add time budget to migration page walk
> 
> This patch adds a 100ms wall-clock time budget to damon_pa_migrate() to
> prevent long migration walks from causing high scheduling latencies. The
> time check is amortized by checking ktime_get() every 4096 pages.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index e844c990987b9..a2565287bc10f 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> [ ... ]
> > @@ -283,6 +293,11 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
> >  			}
> >  		}
> >  
> > +		/* Time budget: keep kdamond responsive on long migration walks. */
> > +		if (!(pfn & DAMON_PA_MIGRATE_TIME_CHECK_MASK) &&
> > +		    ktime_after(ktime_get(), deadline))
> > +			break;
> 
> Can this time check be permanently bypassed?
> 
> If pfn advances by variable strides, such as when addr += folio_size(folio)
> adds a multi-page stride that jumps over the 4096-page boundary, the exact
> match !(pfn & DAMON_PA_MIGRATE_TIME_CHECK_MASK) is missed, skipping the
> check for the entire next 4096-page cycle.
> 
> Additionally, if pfn does land exactly on a multiple of 4096, but the
> pageblock is skipped via the continue statement just above this block:
> 
>         if (!page) {
>             addr += pageblock_nr_pages * PAGE_SIZE;
>             continue;
>         }
> 
> the loop advances and leaps over the time check.
> 
> If the loop terminates early here, is there a mechanism to save the PFN
> where the scan aborted?
> 
> Since the DAMON core is unaware of this internal early return, the next time
> the scheme applies to this region, it appears it will restart the walk from
> the very beginning of the region.
> 
> Could this result in a permanent livelock for large regions, where memory
> beyond the 100ms scan horizon is never reached or migrated?
> 
> >  		folio = damon_get_folio(pfn);
> >  		if (damon_pa_invalid_damos_folio(folio, s)) {
> [ ... ]
> >  		if (!folio_isolate_lru(folio))
> >  			goto put_folio;
> >  		list_add(&folio->lru, &folio_list);
> >  put_folio:
> >  		addr += folio_size(folio);
> 
> This wasn't introduced by this patch, but does the address advancement
> correctly handle tail pages?
> 
> Since the region start addr might not be folio-aligned, if it falls within
> a tail page of a large folio, does adding the total folio_size(folio)
> overshoot the end of the current folio and skip the head page of the next
> folio?

As I previously replied [1], I will work on this.

> 
> >  		folio_put(folio);
> >  	}
> >  	applied = damon_migrate_pages(&folio_list, s->target_nid);
> 
> Does the time budget cap the actual latency spike of the migration?
> 
> The 100ms budget limits the fast folio isolation phase. The loop can isolate
> gigabytes of memory within 100ms. Once the deadline is reached, all
> collected folios are passed to damon_migrate_pages().
> 
> Could migrating this massive batch, which requires memory allocation and
> page copying, take seconds to complete in a single blocking call and fail
> to keep the migration responsive?

I will revisit other Sashiko's detailed comments once we finish the high level
discussion and decide to pursue this direction.

[1] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516210357.2247-1-ravis.opensrc@gmail.com?part=5


Thanks,
SJ
