Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46033B6BE3;
	Tue, 28 Jul 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249056; cv=none; b=qrTQyo1OED+Mx2C7+41D9pYmrpmLKiF0oxYiqasyE2dZR0hn+dFJ3/e5ilsAZjKkFcHltodKgipamiO4gQa8D2d8Prr9xrIvE1OnIKL0Vb8hi5ULS7mjYTops8fAEI0Oel/X+t1teTo93izT8D83DjQX3oFo2vhfyYZ82sDL9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249056; c=relaxed/simple;
	bh=ncrUpN7sv/v1LIx5Fiy/fMY5AYRQRtAEnFcJZNSlnyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX1wwEg0yl6EK2/czBubZX2xU8cHYeXMfcmlZIQ1TYeVIeTRxHJb9GcMxfmLCN12ZbRlfJF6RIJYXGcQX8724+Zlhzbhz5vBJqv/3cRkUH/C01FbcjI+0vgTj7d2aGMyyuPwBqLVEfyLA+v6hVKMPdYZcqI0GFs7qMiqVqsQ3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+S7Ce7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+S7Ce7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB261F000E9;
	Tue, 28 Jul 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785249055;
	bh=OmT3dxp6UH6Faag4ZsF6HLiXOyvd6MoJI1erRfqSZLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+S7Ce7mB7AtTX4PVcBtyjRfd1MXyr5JKqWftwH01n16zzclPSYpOaS7oIfjGf3Pi
	 qhbk/ADzJyCFEh/UuGecc3iFtzFYWkHBxF7vHNSW6g/AyYYQOsr8vVKvH4FTfkJWDP
	 S74nlqMQiabaa9dYrsUs3Q1ijQoxsNMrhEpnqO7doaQX8bKItue01coNsdnnxQeDvj
	 qLQqLO31WHzWpI9sqiWh3bZXolFDzSqz/ty85SCvuG910ZklgufgKoOazaTCVjpuBw
	 VN73kFCN1E0f3P5aYaqEdAcLzcxVohZOG+pd21ljOKjpRh19cCcBcLf7nQL2phzJcO
	 O3LTbRU1aoXMA==
From: SJ Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with per-range regions
Date: Tue, 28 Jul 2026 07:30:44 -0700
Message-ID: <20260728143046.95229-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c16b32ac-9480-428e-863c-5d35ae4b8eb1@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 18:06:48 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> 
> On 7/27/26 10:26 PM, SJ Park wrote:
> > Hello Jiayuan,
> >
> > On Mon, 27 Jul 2026 17:54:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>
> >> damon_set_region_system_rams_default(), introduced by commit 70d8797c15d6
> >> ("mm/damon: introduce damon_set_region_system_rams_default()"), is used by
> >> DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT to set the default monitoring
> >> target address range covering all 'System RAM' when the user does not
> >> specify a range.  It walks the 'System RAM' resources but keeps only the
> >> start of the first resource and the end of the last one, and then sets a
> >> single monitoring region spanning that whole [first_start, last_end] range.
> >>
> >> On systems whose RAM is split into discrete areas that are far apart in the
> >> physical address space, that single region also covers the holes between
> >> them.  For example:
> >>
> >>    $ sudo cat /proc/iomem | grep RAM
> >>    00001000-0009ffff : System RAM
> >>    00100000-4848c017 : System RAM
> >>    4848c018-48550c57 : System RAM
> >>    48550c58-48551017 : System RAM
> >>    48551018-48615c57 : System RAM
> >>    48615c58-48616017 : System RAM
> >>    48616018-486dac57 : System RAM
> >>    486dac58-4e563017 : System RAM
> >>    4e563018-4e627c57 : System RAM
> >>    4e627c58-4ef39017 : System RAM
> >>    4ef39018-4ef3f057 : System RAM
> >>    4ef3f058-4efe6017 : System RAM
> >>    4efe6018-4efec057 : System RAM
> >>    4efec058-50247fff : System RAM
> >>    50317000-56720fff : System RAM
> >>    56722000-59c19fff : System RAM
> >>    6bbfe000-6bbfefff : System RAM
> >>    6bc00000-777fffff : System RAM
> >>    100000000-1007effffff : System RAM
> >>    67e80000000-77e7fffffff : System RAM
> >>
> >> Here the last two areas (about 1TB starting at 4GiB, and about 1.1TB
> >> starting at ~6.5TB) are separated by a ~5.5TB hole, and the single-region
> >> setup makes DAMON treat that entire hole as if it were memory.
> >>
> >> This is harmful in a few ways.  The monitoring target regions are limited
> >> by max_nr_regions, so regions that fall into the hole waste that budget and
> >> leave fewer regions for the real RAM, coarsening the adaptive regions and
> >> degrading the monitoring accuracy.
> > The hole would look like not accessed.  As a result, the whole region will be a
> > few regions that very cold.  That wouldn't waste the budget that much.  Do you
> > have some specific setups that this cannot help?
> 
> It's my mistake.
> 
> I first saw the kdamond CPU go up, and I assumed it was the number of
> regions. I was wrong.
> 
> I re-tested and profiled it with perf. It's not the region count — it's
> the page-by-page walk of the hole.
> 
> On a VM with a 116GiB hole and a single [first,last] span, I enabled
> DAMON_LRU_SORT and ran perf on its kdamond:
>    30.15%  damon_get_folio
>    17.09%  pfn_to_online_page
>     2.24%  __nr_to_section
>     ...
>     0.07%  damon_split_region_at
>     0.06%  damon_merge_two_regions
> 
> Almost all of it is the per-page folio lookup. Merge and split are ~0.1%.
> The cold scheme targets cold, old regions. The hole is never accessed, so
> it's always cold and old, and it matches. Then the action walks its whole
> empty span page by page, every apply. RECLAIM and LRU_SORT do this by
> default. It scales with the hole size, so on the real 5.5TiB machine the
> kdamond can't keep up.

Makes sense, thank you for investigating and sharing this!

> 
> 
> >
> >> In addition, DAMOS actions on the paddr
> >> operations set walk such a region page by page, so a region that covers the
> >> hole is walked for its entire (empty) span on every application.
> > That makes sense.
> >
> >> Set a separate monitoring region for each discrete System RAM area instead,
> >> coalescing only truly adjacent (no gap in between) resources into one
> >> range, so holes between the areas are excluded.  The reported *start and
> >> *end still carry the overall first-start and last-end, so the user-visible
> >> default range reported via the module parameters is unchanged.
> > I'm concerned if this could result in having too many regions.  The gap between
> 
> On the region count: can't we just coalesce any hole smaller than
> min_region_sz?

I'm not fully understanding your point.  min_region_sz is only 4 KiB by
default, and anyway DAMON cannot create regions of size smaller than
min_region_sz.  I cannot get how this helps.

> After that, the number of ranges is just the number of 
> discrete
> System RAM areas

I'm still not convinced with this.  What if the number of discrete system ram
areas is larger than max_nr_regions?

Actually I was also thinking about this problem for in the past.  One of my
idea at that time was, handle only a few largest holes that practically being
problems.  That is, while reading the system ram layout, find the holes, sort
those by size, and do make holes in DAMON regions layout for the biggest N
(say, 2) holes.  This may handle most cases including your 5 TiB hole.
Actually vaddr is doing this, so we may be able to reuse some of the code.

If it makes sense to you, I will try to implement this.

> 
> > user-visible parameters and internal state is also a concern.
> 
> 
> I think monitor_region_start/end is meant to expose the overall range, and
> skipping the holes inside it is an implementation detail. Even if we didn't
> skip them, the adaptive region count is never 1 anyway — DAMON already
> splits [first,last] into many regions. The holes just add a few more, so
> the param never matched the internal state exactly to begin with.

It is arguable, but I believe this also makes sense in my opinion.

> 
> 
> > A quick workaround would be adjusting the memory layout in BIOS, using DAMON
> > sysfs interface instead, or setting the monitor_region_{start,end} to cover
> > only the single area.  Have you considered such workarounds?
> >
> > Let's complete this high level discussion first.
> 
> 
> Right, this is doable today — the DAMON sysfs interface can set multiple
> 
> regions manually. This patch is only about convenience.

Are you actually running DAMON_LRU_SORT or DAMON_RECLAIM in a production system
having 5 TiB hole?  Or, planning to do?  If the above idea makes sense to you,
I could prioritize implementation of it depending on this.


Thanks,
SJ

[...]
