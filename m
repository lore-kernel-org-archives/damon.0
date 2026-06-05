Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D1378D9C;
	Fri,  5 Jun 2026 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654094; cv=none; b=KLPJ0N4WfX4yeD/+5sMhkkd6uAVVeomEkIydBsOt2FD8JIJYTXMhx9JY2RIx59WQy/DWc9NPh+xI/cc/nl7zXDON7dwzJc87yhF/UWE8m5MGV9vMXWnmNJ3tFHCPOSUSdYK/x9fP4V+Og2amcb/69QxQmKftWqlHixQjw7oEs44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654094; c=relaxed/simple;
	bh=m4UpGEEadJ0WjOAYoI4gvYf25oKzHkiSw67WOeZG6ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIoNK6KC+MiCSCh9kV+sS6BXwNNj/w2HWj3Bkk90e7NBBKyc5Sc36PJt6Bmjp/96iSqqRfDn/qUGpwqxMWsaYxMfvf6Eva+ubcbvIu1zt5RIV+0jnImJsAC3d43lSbGAvUL2KqndgnamuxavHy9euQlLi3qXORT+ncP9cWBRB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE2kG58h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE2kG58h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC571F00893;
	Fri,  5 Jun 2026 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654092;
	bh=I5VqecLRt7G5iGb70TpzMF2J4Qjuy+1vUMH27FXaf78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DE2kG58hMxthGFnLTKM9WgyXXW0z/Ih2lPXc1ijI95aFcx2R7AziaFPmXqsNZ3iEo
	 GJgPWk5slRIzPwDbGO0AL7r0+PbMGl0PHsUB5OtVy0oOTph7uJNMn8sFlSyIW/eDPU
	 VjOeQjH0eVcLx3V6XQwfaEW04TFaTMRsqDxImeXLXM9YGApwhre4/PuiZboowesG+q
	 PGQzllDWMEEz0pIBeeiWsdy05fSAGlpHIlKQTq4fd6LKW0Tej7F42wt9eTt8sQvn8V
	 Er3vsj+ZXmfqiQwrPrmtc0ZsIGnnYFk312C4Ww2XJq1lNttvuHNlzozmQErjtzci6D
	 fwBQzxAn0xlOg==
Date: Fri, 5 Jun 2026 11:07:57 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: xu.xin16@zte.com.cn, tao.wangtao@honor.com, catalin.marinas@arm.com, 
	will@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, akpm@linux-foundation.org, willy@infradead.org, 
	sj@kernel.org, kees@kernel.org, luizcap@redhat.com, 
	zhangjiao2@cmss.chinamobile.com, kas@kernel.org, hpa@zytor.com, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	jack@suse.cz, riel@surriel.com, harry@kernel.org, jannh@google.com, 
	jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, chengming.zhou@linux.dev, 
	nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, ryncsn@gmail.com, 
	dvander@google.com, wangzicheng@honor.com
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <aiKd7tfrICFnlWxV@lucifer>
References: <20260604111035154Lk-9ZgwKY4Nlk4zz30U1t@zte.com.cn>
 <68a4aec0-72d4-4967-b063-b57cc7ee40cf@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68a4aec0-72d4-4967-b063-b57cc7ee40cf@kernel.org>

On Fri, Jun 05, 2026 at 11:38:52AM +0200, David Hildenbrand (Arm) wrote:
> On 6/4/26 05:10, xu.xin16@zte.com.cn wrote:
> >>>
> >>>  arch/arm64/Kconfig         |   1 +
> >>>  arch/x86/Kconfig           |   1 +
> >>>  fs/proc/page.c             |   6 +-
> >>>  include/linux/mm.h         |  38 ++
> >>>  include/linux/mm_types.h   |   9 +-
> >>>  include/linux/page-flags.h |  34 +-
> >>>  include/linux/pagemap.h    |   2 +-
> >>>  include/linux/rmap.h       | 165 ++++++++-
> >>>  mm/Kconfig                 |  22 ++
> >>>  mm/damon/ops-common.c      |   4 +-
> >>>  mm/debug.c                 |   2 +-
> >>>  mm/debug_vm_pgtable.c      |   2 +-
> >>>  mm/gup.c                   |   6 +-
> >>>  mm/huge_memory.c           |  16 +-
> >>>  mm/internal.h              | 171 +++++++++
> >>>  mm/khugepaged.c            |  13 +-
> >>>  mm/ksm.c                   |  43 ++-
> >>>  mm/memory-failure.c        |  11 +-
> >>>  mm/memory.c                |  19 +-
> >>>  mm/migrate.c               | 126 ++++---
> >>>  mm/mmap.c                  |  15 +-
> >>>  mm/mremap.c                |   4 +-
> >>>  mm/page_idle.c             |   2 +-
> >>>  mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
> >>>  mm/vma.c                   |  76 ++--
> >>>  mm/vma.h                   |   4 +-
> >>>  mm/vma_exec.c              |   2 +-
> >>>  mm/vma_init.c              |   1 +
> >>>  28 files changed, 1279 insertions(+), 206 deletions(-)
> >>
> >> Hi!
> >>
> >> When I saw the diffsat I was concerned. Going through the patches made me ...
> >> more concerned :)
> >>
> >> This is a lot of complexity. On top of something that is already so complicated
> >> that I fail to grasp most details without regularly taking a look at the nice
> >> figures Lorenzo created recently.
> >>
> >> For example, I read above "since child VMAs do not need to allocate anon_vma"
> >> and wondered how that could be part of something that is just done lazily. Then
> >> I had to learn in the patches that there is some additional "Child VMAs
> >> are created as ANON_VMA_TREE_PARENT and do not allocate anon_vma" -- excuse me,
> >> what? :)
> >>
> >> Reading about VMA refcounts made me shiver. Reading "Holding only
> >> folio_lock(folio) cannot guarantee that the split
> >> operation completes atomically." confused me. Learning that we have to invent
> >> interesting ways to make page migration mutually exclusive to free_pgtables()
> >> concerned me. Figuring out that there are arch-specific config options and
> >> runtime toggles is a clear warning sign.
> >>
> >> Seeing test_folio_unmapped() was funny, though (why?! :)).
> >>
> >> I think this patch set has a noble goal of reducing anon_vma overhead when anon
> >> pages are not shared during fork. However, using anon_vma for them actually
> >> makes the overall implementation (e.g., rmap walks, locking) more consistent and
> >> simpler.
> >>
> >> Even if we could be convinced that most of this here is correct, how should we
> >> reasonably maintain this increasing level of complexity here?
> >
> > Indeed, it's very complex, but having the changes of 15 patches scattered across
> > various subsystems is really frustrating for reviewers. It took me a whole day to
> > read through the entire patch set, which made an already complicated matter even
> > more complex (maintaining such complex code in the future will be a pain).
> >
> > However, overall, I think the original intention behind Tao's patch is innovative
> > and valuable, and Tao could definitely make this patch set simpler and more
> > readable, because the core changes actually start from PATCH 10.
> >
> > I believe that if Tao had done the following, things might have gone better and easier
> > for reviewing. In fact, I understand the motivation behind the patch is quite simple
> > at its core (just wanting to avoid allocating the anon_vma structure when a VMA hasn't
> > been truly forked, and instead put the VMA information directly into folio->mapping):
> >
> > 1) You could actually simplify your patch significantly — without adding a lot of wrappers
> > and helper functions that introduce extra review overhead — and keep only the most essential elements.
> >
> > 2) Provide complete test code (in tools/testing/selftest) that covers the affected functionality,
> > such as VMA, huge pages, KSM, etc.
> >
> > 3) Use the RFC tag to start a discussion.
> >
> >
> > I would be very glad to see if Tao could post a simpler v2 version that does not alter the rmap
> > core data structures too much and does not introduce excessive complexity, no matter whether
> > it can be merged finaly.
>
> I'm afraid, the overall complexity would increase in any case.
>
> So to quote myself "But fundamentally, I think we want to find a new design that
> is just naturally simpler."

In general I'm prioritising my work, and hope to ship something within the next
month, even if it might just be some early bits of work on this to plumb stuff
in, and certainly the main ting will be an RFC :)

So keep an eye out for this which will hopefully address people's needs!

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
