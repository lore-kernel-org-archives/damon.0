Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BA3F6C32;
	Wed, 27 May 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881436; cv=none; b=l5mVHkaQsVB3Y+QunK+tOb3s6SzGLrJ0p1gaf7LI3h9fGSV0dOYhaF7WV5PWTvGCHqSXjnI6MzzgfNMC/7l2QOcg2vU6qRE8i+7lh8JftmaRe/z16qI2W5JPEfw5XsB1Aa45NLhNG7xx0RkO3ux0/AG4CkSVFw8J2ReRqxuyGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881436; c=relaxed/simple;
	bh=KIFTUKxAv0USQdS+hKdrkbE8lG1CiSkJ5vHM19IE5Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE6QQW8BRy5OYHK9F7XAmunVawJB/8NoM9ybuE0CftBC9C4VBOUKolCfJiK73N46mqUmBU01G/mE0RwlBKdGYlOroCR2ELWeZA/ExyhoqAzJpMejQHrWE8hcD7AQ0igKm6vb1m1G3G/AXEJ3eKeJ4wogn0vyOfzxwnCvLozNEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=logbsObH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="logbsObH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EC31F000E9;
	Wed, 27 May 2026 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881432;
	bh=Tcb0qxLA9RNxrwz29kVtvmLZ2aii5ujZuhxC1huYlKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=logbsObHFcZ0H5NqgDgc5xjivfG0w1EDTwIm6GsW5wuBoLCHEkfM4GzYOaqttoyhE
	 BKW5l0jY0SY1saWM3DHvASSuljoBGm5yL7ble07ivJM/eZQnHGdt1kt5ANPvWk8pWS
	 PHLng9JaQCN7TYaKtI4sHAcP+P3pSIYQjx7uDFdDdMVijLI+Wh/Loam3FHDuBCZxA5
	 lpGrw3WiuNrxcW7dYJh6Igwvod7xnNcOTMnTj0h9DvPjPzxTJnKFKDd7o10H9isydU
	 B3PV8j+gRwEoRQdGSWdpUu4zhKgURNH4iySWL1Z3fGfwfmV6RJT2rbShNSdEh/ywFQ
	 ca7cIRvpK8l+w==
Date: Wed, 27 May 2026 12:30:28 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: tao <tao.wangtao@honor.com>
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, hpa@zytor.com, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	riel@surriel.com, harry@kernel.org, jannh@google.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, 
	nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, ryncsn@gmail.com, 
	21cnbao@gmail.com, jparsana@google.com, dvander@google.com, zhangji1@honor.com, 
	wangzicheng@honor.com
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahbSrt0B1aQTwrk4@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>

I'm sorry but this is not how kernel development is done.

You're sending a series that's very invasive, that you've not coordinated
with anybody else, nor have you mentioned it at a conference, nor engaged
with in discussion with anybody else in the community in any way.

And you've sent it without an RFC, at -rc5 is... quite something.

We do NOT want to extend or expand or hack in anything like this on top of
the existing anon_vma machinery. It's a mess that requires replacement, not
more hacks or expansion.

I've been working on a replacement for the anonymous rmap, recently
presenting at LSF/MM, and all of that has been very public.

In fact I have engaged in recent work which reduced lock contention in
anon_vma, it's really quite discourteous for you not to have contacted me
or the community in addition to the above.

On Wed, May 27, 2026 at 07:01:32PM +0800, tao wrote:
> TL;DR
> -----
>
> This series introduces ANON_VMA_LAZY, which defers anon_vma creation
> until it is actually required.
>
> - anon_vma memory reduced by ~92-97%, anon_vma_chain reduced by ~50-57%
> - rmap operations on ANON_VMA_LAZY VMAs do not require anon_vma locking
>
> Background
> ----------
>
> Currently anon_vma structures are created eagerly when anonymous VMAs
> are initialized. However, many VMAs never participate in fork or rmap

What are you talking about? 'Initialized'? They are created when memory is
faulted in, and we explicity need to know that that's the case.

Also the folio->mapping is required to point to something to allow for anon
rmap...

> operations that require anon_vma chains, so the allocated anon_vma and
> anon_vma_chain objects are often unnecessary.

Right, because we never split or merge VMAs nor require anon rmap?

>
> Design overview
> ---------------
>
> ANON_VMA_LAZY defers anon_vma allocation until it is actually needed
> (for example during fork). VMAs that never participate in sharing can
> avoid creating anon_vma structures entirely.

Well, it's needed the second something's faulted in so you can perform anon
rmap.

>
> Before an anon_vma exists, rmap operations rely directly on VMA
> information, so no anon_vma locking is required. An anon_vma is created
> and linked only when sharing semantics are required.

Err 'directly on VMA information'... a VMA pointer? That can change at any
point? What about remaps?...

I guess I'll see in the code.

>
> This series introduces anon_rmap helpers to make rmap less dependent on
> direct anon_vma access. It also introduces anon_vma_tree_t as a container
> to support both the lazy and the existing anon_vma layouts.

Super invasive, extending the already broken abstraction further. We don't
want this.

>
> Once a VMA becomes associated with an anon_vma, the normal behavior
> remains unchanged.



>
> Memory impact
> -------------
>
> Preliminary measurements show significant reductions in anon_vma-related
> slab allocations.
>
> After boot:
>
> Object            | Before (active KB) | After (active KB) | Change
> vm_area_struct    | 117035             | 118176            | +1.0%
> anon_vma_chain    | 18865.8            | 8112.06           | -57.0%
> anon_vma          | 20426.4            | 613.75            | -97.0%
>
> After launching 24 apps:
>
> Object            | Before (active KB) | After (active KB) | Change
> vm_area_struct    | 196873             | 197345            | +0.2%
> anon_vma_chain    | 31477.1            | 15576.8           | -50.5%
> anon_vma          | 33280              | 2648.12           | -92.0%
>
> Simple fork microbenchmarks also show a slight improvement in fork
> performance, since child VMAs do not need to allocate anon_vma
> structures during fork.

This seems completely broken too re: anon_vma propagation on fork?

The above is only meaningful if you're not fundamentally breaking anon rmap
which is very easily done, but in addition, I'm not interested in seeing
the anon_vma machinery extended further.

>
> Feedback and suggestions are welcome.

This is what you should have sought AHEAD of sending this.

I'll look at the code, but in general you've gone about this in a really
unfortuate way with respect to the community. This is not to collaborate.

>
>
> tao (15):
>   mm/rmap: introduce anon_rmap APIs for anonymous folios
>   mm: convert anon_vma rmap APIs to anon_rmap
>   mm: introduce anon_vma_tree_t for multiple anon_vma topologies
>   mm: switch to anon_vma_tree_t APIs in preparation for ANON_VMA_LAZY
>   mm: add CONFIG_ANON_VMA_LAZY and folio helpers
>   mm: add CONFIG_VMA_REF and VMA helpers
>   mm: replace direct FOLIO_MAPPING_ANON usage with helpers
>   mm: prepare rmap infrastructure for ANON_VMA_LAZY
>   mm: implement ANON_VMA_LAZY rmap semantics
>   mm: defer anon_vma creation with ANON_VMA_LAZY
>   mm: handle ANON_VMA_LAZY in huge page operations
>   mm: handle ANON_VMA_LAZY during migration
>   mm: support setup and upgrade of ANON_VMA_LAZY folios
>   mm: support merging of ANON_VMA_LAZY VMAs
>   mm: enable CONFIG_ANON_VMA_LAZY on arm64 and x86_64
>
>  arch/arm64/Kconfig         |   1 +
>  arch/x86/Kconfig           |   1 +
>  fs/proc/page.c             |   6 +-
>  include/linux/mm.h         |  38 ++
>  include/linux/mm_types.h   |   9 +-
>  include/linux/page-flags.h |  34 +-
>  include/linux/pagemap.h    |   2 +-
>  include/linux/rmap.h       | 165 ++++++++-
>  mm/Kconfig                 |  22 ++
>  mm/damon/ops-common.c      |   4 +-
>  mm/debug.c                 |   2 +-
>  mm/debug_vm_pgtable.c      |   2 +-
>  mm/gup.c                   |   6 +-
>  mm/huge_memory.c           |  16 +-
>  mm/internal.h              | 171 +++++++++
>  mm/khugepaged.c            |  13 +-
>  mm/ksm.c                   |  43 ++-
>  mm/memory-failure.c        |  11 +-
>  mm/memory.c                |  19 +-
>  mm/migrate.c               | 126 ++++---
>  mm/mmap.c                  |  15 +-
>  mm/mremap.c                |   4 +-
>  mm/page_idle.c             |   2 +-
>  mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
>  mm/vma.c                   |  76 ++--
>  mm/vma.h                   |   4 +-
>  mm/vma_exec.c              |   2 +-
>  mm/vma_init.c              |   1 +
>  28 files changed, 1279 insertions(+), 206 deletions(-)
>
> --
> 2.17.1
>
>

Lorenzo
