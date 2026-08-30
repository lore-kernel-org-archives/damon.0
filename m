Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3A3F105B;
	Sun, 30 Aug 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113060; cv=none; b=joyml/REEY3V5LcV2icbn46Z84r2gLBz1ximVGd2luoK00OzmnkRmkGDnOtpHekLTkFffbOueNXwGQr6y8DSOBmtD0tIBCsn7tH0apbNxGfnoINA1QmijXpVkYM/z4v1NPRE6eSEtQEWmZp5jfg0I28PLYVAjgF4yvbpLm7Ly0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113060; c=relaxed/simple;
	bh=3nOsf/WwS4ndXuO3uNa1zvzND7BWlSNK7AdVKcsPNVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjTxww5KANrS3I8u2ioowrBZpe572yIscgCs1Iagccu+B0wL7X5ofV1w1pQj5cNiiCfxs6M45Qg1jlIW4ZhJbgsTwHvM7DiN44c8z5LS9r0ztW7RGFqFasez1P9aIhFBvNscTadNz2q/xKiBszy/BGIOsSF8uZ737X8rmCkfjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgLTMhUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgLTMhUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A0E1F000E9;
	Sun, 30 Aug 2026 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788113058;
	bh=m88xwc8JeINQOcEmdlY5EvrRQoPq/hErRaBWIQ73IgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UgLTMhUaoy23cUFdrrSHJgkX2Cwez8f8AB4yxm3mRLGkgbS4p1BXJohv7il1iva2r
	 N4TGWinDnKGvt036jNZuSGnWiFMXi8AgBfQUXMwCbax3JLjk07r46g4BDK61rRkaCs
	 KoPX5sPgUyhzxv0IBwgut2ar2W/pG+squx+cImEx4ze8okE6J8m6dUAshbWf9Vlh1Y
	 r6RVDWIFuQ1xBDvQq+8piJApEeqFhieXfCLBJIA5acK3hx51/QzMCltO/TfMKotiVy
	 bEuJjPOgYxV6Wa5DvSRjvZYggCzFkPNE2C6xVYZKJhO+0IfbsWtaixl/6yKHqwUokL
	 efhpvsWNz11ww==
From: SJ Park <sj@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] mm/damon: support access monitoring of hugetlb-backed memory
Date: Sun, 30 Aug 2026 11:04:11 -0700
Message-ID: <20260830180411.103772-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830051407.50008-1-kiyer@crusoe.ai>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krishna,


Thanks you for this great patch series.

On Sat, 29 Aug 2026 22:14:01 -0700 Krishna Iyer <kiyer@crusoe.ai> wrote:

> On virtualization hosts, most system memory is often backed by
> hugetlbfs.  On our production hosts, for example, ~95% of RAM is 1 GiB
> hugetlb pages backing guest memory.  DAMON's physical address space
> monitoring cannot produce a useful access signal for such memory, for
> two layered reasons.
> 
> First, it is blind to hugetlb folios.  Every access check starts at
> damon_get_folio(), which rejects folios that are not on the LRU lists,
> and hugetlb folios are managed outside of the LRU by design.  As a
> result, all hugetlb-backed memory is silently reported as never
> accessed.

Nice catch.  I admit DAMON is completely broken for your use case, and this
will effectively and completely fix it.  I want to get this fix as soon as
possible.

> 
> Second, even once hugetlb folios are visible, access-bit-based sampling
> under-reports hot memory.  DAMON deliberately clears accessed bits
> without TLB flushes to keep the overhead low, so accesses served from
> cached translations do not walk the page tables and never re-set the
> bit.  With 1 GiB mappings, translations effectively never leave the
> TLBs, pinning the observed access rate to the TLB-refill rate: a
> saturating guest is indistinguishable from a nearly idle one.

There were similar issue reports.  In most cases, it was because they were
running small test workloads on large systems.  It was unclear if the same
issue can happen on real production workloads.  That's because we expect real
workloads to intentionally access most of system memory, and therefore
naturally flush TLB entries.  On 1 TiB memory system utilizing 1 GiB huge tlb
pages, I can agree the issue can happen more frequently, even on real
workloads.  But, I'm still curious what is the real impact.

> 
> Patches 1-3 address the visibility problem.  The first patch moves
> damon_hugetlb_mkold() from vaddr to ops-common as a preparation.  The
> second patch teaches the folio mkold/young rmap walkers to handle
> hugetlb folios, aging the huge PTE and notifying secondary MMUs across
> the whole huge page size; the secondary MMU notification is what
> surfaces guest-side (e.g., KVM/EPT) accessed bits.  The third patch
> adds damon_get_folio_incl_hugetlb() and uses it from the paddr
> monitoring primitives only.  DAMOS action appliers such as
> DAMON_RECLAIM and DAMON_LRU_SORT keep the LRU-only lookup and are
> behaviorally unchanged.

I left a few trivial comments for names and comments to patches 2 and 3.  After
resolving the trivial things, these will be ready to be merged in my opinion.

Meanwhile, I have a few concerns and want to have sufficient discussions for
rest of this series.  Could you pleae split the first patches out of this
series, revision for the given comments and post as another series?  After
finishing it, we could take more time on the second part of this series.

> 
> Patches 4-6 address the intensity problem with a new default-off
> monitoring context option, 'aging_flush'.  When set, access bit
> clearing for monitoring uses the flushing primitives
> (mmu_notifier_clear_flush_young() and TLB-flushing PTE/PMD/hugetlb
> aging) so that the next access is guaranteed to re-set the accessed
> bit.  The option is exposed via the DAMON sysfs interface (patch 5) and
> as a DAMON_STAT module parameter (patch 6).  With the option unset, the
> behavior is identical to before this series.

I understand this is really needed for your use case.  But, I'd like to take
sufficient time here.  Two concerns stand out to me.  The maintenance of the
new interface, and the performance impact.

Firstly, the new interface.  We are changing DAMON for general data attributes
monitoring.  Memory access will be only one of the attributes that DAMON can
monitor.  For this, we introduced probes interface.  As soon as the new
interface is matured, we would discourage use of the old interface for access
monitoring.  We might even deprecate it over long time.  To make it easier, I
don't want to add more features for access monitoring only.  I'd like to make
this TLB flush interface as part of the new interface.

More specifically, I'm working [1] on introduce monitoring preparation actions
concept.  We could add TLB flushing as one of preparation actions and implement
interface on it.  For example,

    cd /sys/kernel/mm/damon/...
    echo tlb_flush > preps/0/prep_action

It could also later be extended for custom periodic TLB flush (we might not
want to flush TLB for every sampling but once per N samplings), like below.

    # do the given prep action once per 5 sampling intervals.
    echo 5 > preps/0/action_interval

I'm giving above as an example brain-storming ideas.  I'm not suggesting to do
exactly that.  But my point is, I think we need more thought about the
long-term sustainable and maintainable interface.

> 
> Evaluation on an Intel EPT host running a 944 GiB guest with an 842 GiB
> in-guest memory workload (masim):
> 
>   configuration          estimated access rate    idle -> load
>                          idle -> load (GB/s)      separation
>   stock                  0.08 -> 0.21             none (guest memory
>                                                   invisible)
>   patches 1-3            1.70 -> 1.96             1.2x
>   full series, flush on  1.21 -> 5.34             4.4x

So, you can show some of the guest access after patches 1-3, because TLB is
naturally flushed even in your setup.  But with explicit and periodic TLB
flush, you show definitely more and real access.  This makes sense to me, and
align with the theory.

> 
> With aging_flush set, the estimated hot footprint covers ~82% of the
> actual working set size, compared to ~40% without flushing, where the
> signal mostly reflects the ambient TLB-refill rate rather than guest
> accesses.

I think that makes sense, but having more details would be even nicer.  For
example, below questions are raised on my head.

How do you define and detect the actual working set size, and DAMON-found
working set size?

What is the size of TLB in your setup?

Could you share more details about your masim [2] run setup?

What is the estimated memory bandwidth if you run DAMON inside guest?

> kdamond CPU consumption stays approximately 0%, and the
> worst-case flush overhead measured is below 0.1%, which is acceptable
> for hosts that opt in.

Flushing TLB makes overhead in kdamond.  But it also makes performance
degradation to the running workloads.  Actually that's bigger concern.  Have
you had a chance to measure that?  If so, could you share that too?

> 
> Per Documentation/process/generated-content.rst, this series was
> developed with the assistance of an AI coding assistant (Anthropic
> Claude, via Claude Code).  The assistant helped draft the code and
> changelogs, and performed the rebase of the series from its original
> 6.17-based development tree onto mm-new, including merge conflict
> resolution against recent DAMON changes.  All changes were reviewed by
> the human submitter, who takes full responsibility for the
> contribution.
> 
> The series as posted here was regression-tested on its base commit
> with a full x86_64 kernel build (no new W=1 warnings in mm/damon), the
> DAMON kunit suite (41/41 passing) and the DAMON selftests (15/15
> passing) on a kernel booted with virtme-ng.  Functional validation
> (the evaluation above, ftrace verification that the flag switches the
> notifier variants, and enable/disable stress testing) was performed by
> the submitter on production-like hosts running the 6.17-based backport
> of this series.

This kind of transparent and detailed disclosures help reviewers.  Thank you
for doing this.

So, to summarize, I'd suggest reposting the first three patches as another
series and focus on it for now.  In parallel or after it is done, we could
further discuss about TLB flush change.

> 
> Krishna Iyer (6):
>   mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
>   mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap
>     walkers
>   mm/damon/paddr: support hugetlb folios in access monitoring
>   mm/damon: support flush-assisted access bit clearing for monitoring
>   mm/damon/sysfs: support aging_flush
>   mm/damon/stat: support aging_flush

Because there are high level things that I'd like to discuss first, I will hold
reviewing patches 4-6 for now.

> 
>  include/linux/damon.h |   2 +
>  mm/damon/core.c       |   2 +
>  mm/damon/ops-common.c | 154 ++++++++++++++++++++++++++++++++++++------
>  mm/damon/ops-common.h |  18 ++++-
>  mm/damon/paddr.c      |  11 +--
>  mm/damon/stat.c       |   6 ++
>  mm/damon/sysfs.c      |  29 ++++++++
>  mm/damon/vaddr.c      |  46 +++----------
>  8 files changed, 203 insertions(+), 65 deletions(-)
> 
> 
> base-commit: d2aad7fdcda7ae8a726926f2d6de7fe9e8ee7563
> -- 
> 2.54.0

[1] https://lore.kernel.org/20260728041242.187380-1-sj@kernel.org
[2] https://github.com/sjp38/masim


Thanks,
SJ
