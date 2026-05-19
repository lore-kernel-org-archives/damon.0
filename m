Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBD2BCF46;
	Tue, 19 May 2026 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153287; cv=none; b=bQLWvE9b7FW2aYI5xevhdUdyr1GXLTbPoUaMD8UyEVfrsLetBcDRLGxgi6LctxX6jQx0wWxXZsFRy4e462jHWE9eeGN2tZ8V3DSBoWc78IVlDDbwAAXhrKis+G1iHUae8fTMru5kfkveIwcXEECDVj0g2HumT9yyk3VD2oHY/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153287; c=relaxed/simple;
	bh=2kljYz959akpWYYVv87a7PKBDFfGelUMKZ7YiyHZVXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb+o8gPP0EZRSbXFaU51Cpx0I7OvdwWkeZUmOJeJCQF10aNzCXfXijBWtRxu684jvt12JRhEUTwlLaND6XN08isdubkdqvNQ5ILgygvx9Czs0Rncq2CZETOtNvOYg91gJi+//sArT0F4UkWz4fHL39zMxgbUBoUaAC4GDCAGR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWilHvQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWilHvQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DD6C2BCB7;
	Tue, 19 May 2026 01:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779153287;
	bh=2kljYz959akpWYYVv87a7PKBDFfGelUMKZ7YiyHZVXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWilHvQPZZd7DeQWwFDL3B4sTRguYaw7ISYSe0UQ0fYUO4eJke5tPz64CcMo3G2J6
	 +wnwTk6xFCEThHHyMi4f6QMI27THb57EWnbonfpK2XsqJBdW1I3Ugeazh8Lo0drZDD
	 2Ahmm/UqczhgdP1cDp6262zavReH9qJ5DxDtn2zhNP8U/yxW+PsiDvZBc6v0ojukp6
	 dWQJ4GbQoPLGangb7/vvH/nvpHjDw0urB8TVWWRfpI3A6+IiPUG7Cqfr5n1M9tf/5y
	 xIQ3wSXcEeLz3jTPyzyPuQkJIB7haF7JWAJc3vswiHlSLNcDPYxsVFTK7r287W595C
	 raaFcnwN+N1RA==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 4/5] mm/damon/paddr: skip free pageblocks in migration walk
Date: Mon, 18 May 2026 18:14:28 -0700
Message-ID: <20260519011429.100021-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y17nudor22aJvakfos3UegPgEG1M8N7cJPAxWX0Ca=MvfA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 17 May 2026 22:38:51 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Sun, May 17, 2026 at 4:38 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sat, 16 May 2026 14:03:56 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > damon_pa_migrate() walks every PFN in a region linearly, calling
> > > damon_get_folio() for each one.  On sparse physical address spaces
> > > (e.g., CXL-attached memory), a single DAMON region can span hundreds
> > > of gigabytes where most memory is free and sitting in the buddy
> > > allocator.  Most page lookups are fruitless and dominate kdamond
> > > tick time.
> >
> > On sparse address spaces, the problem would be large DAMON regions of offlined
> > memory.  The large DAMON regions that nearly all freed memory is another
> > problem that doesn't require the sparse address spaces.  If I'm not wrong, the
> > above paragraph could better clarified in my opinion.
> >
> > >
> > > Check at pageblock boundaries (2MB on x86_64) whether the block is
> > > entirely free.  If the first page of a pageblock is a buddy page at
> > > pageblock_order or higher, the entire block is free and can be
> > > skipped.
> > > Similarly skip pageblocks where pfn_to_online_page() returns
> > > NULL.
> > >
> > > This reduces the iteration from O(region_sz / PAGE_SIZE) to
> > > O(region_sz / pageblock_sz) + O(populated_pages).
> > >
> > > buddy_order_unsafe() is used without zone->lock.  A transient false
> > > positive (block becomes non-free between the PageBuddy and order
> > > checks) costs at most one tick of missed candidates on that block;
> > > the next tick re-scans.  No correctness consequence as DAMON walks
> > > are best-effort.
> >
> > I was initially thinking this is a good and reasonable optimization approach.
> > But on the second thought I get below questions.
> >
> > For large offlined memory space problem, couldn't we simply tune DAMON's
> > monitoring regions boundary to ignore the holes?
> >
> > For large free memory area, is it reasonable to assume such situations?  In
> > production, users will try to utilize as much memory of the system as possible.
> > Then, wouldn't there be such problematically large free memory area?
> >
> > Could you please enlighten me?
> >
> 
> Hi SJ,
> 
> You're right on the first point.  For static offlined memory
> holes (memory hotplug gaps, partial socket population, etc.) the
> right answer is configuring the monitoring region boundaries to
> exclude them upfront, not making the walk skip them at runtime.
> The changelog is clearer if I narrow the patch to the free-but-
> online case.

Thank you for clarifying, Ravi.

> 
> On the free-online case: I agree large free memory areas are
> not the steady state on a fully-utilized system.  The cases I
> had in mind are more limited:
> 
>    - A workload using a small part of a much larger range, with
>       the rest left as headroom (e.g. 64 GB used of a 512 GB
>       range).

Why would the user have that large amount of headroom?

> 
>   - Shared tiers where workloads are allocated and freed on their own
>     timelines.  Any single piece of free memory doesn't last
>     long, but on a busy system there's typically a meaningful
>     free fraction in the range at any point -- especially on a
>     slower tier, where workloads prefer faster memory first
>     when it's available.

I agree there could be reasonable amount of free memory.  But, I'm still not
feeling difficult to know would that be big enough to cause the issue in DAMOS.

> 
> The patch as written is a narrow optimization for those cases:
> the pageblock-aligned check is one extra read per
> pageblock_nr_pages PFNs (about 1 per 512 on x86_64), so it's
> effectively a no-op when the region is fully populated.
> 
> If you don't see those workloads as warranting the change, I'm
> happy to drop the patch.  If the framing is the issue more than
> the change itself, I can respin a v2 with:
> 
>   - the changelog narrowed to the free-but-online case (no
>     offlined-memory framing);
>   - any suggestions from you on sashiko's review comments.

I think your arguments make sense in general.  But I'm still not quite sure
what is the realistic size of the problem, so difficult to judge.  Having a
clearer and detailed use case and backing data would be nice.

I also got a little and trivial concern for this approach.  DAMOS quota system
assumes the cost of applying DAMOS action will be proportional to the size of
memory it is applied for.  After this patch is applied, the cost will depend on
amount of free or offline memory in the memory.  It might make users difficult
to predict the overhead of DAMOS.  I might be too picky and hallucinated, but
to be honest I'm not feeling 100% comfortable with this change.

For long term, we are working on extending DAMON for general data attributes
monitoring.  I pretty sure you also aware of that.  The v1 [1] is just added to
mm-new for more testing.  It is currently supporting anon page and belinging
memory cgroup attributes.  I'm planning to extend that a lot.  In future, DAMOS
might be able to target and filter memory based on the attributes monitoring
results.  Then, we may be able to extend it for monitoring online or freeness
of the memory and ask DAMOS to filter out or de-prioritize memory regions
having high proportion of free or offline memory.

So, long story short, I'd suggest to revisit this after a clear use case and
real problem is found, unless we have it right now.

[1] https://lore.kernel.org/20260518234119.97569-1-sj@kernel.org


Thanks,
SJ

[...]
