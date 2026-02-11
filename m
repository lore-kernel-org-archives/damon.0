Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D81DF980;
	Wed, 11 Feb 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822550; cv=none; b=oHwisw3LshD0B89f3RLIqU2NcNuos7Os9i7+K5Kl6b1gk7rWkNLtTLy7ttmWwsH6JfAKP+Vl8r1GS8/O7nsfVteDNV5nLsupbzptAoOUedzkzcvAgfQ8PVs006OwqegVpWfK2tltXauhS9yoE9IOqVK1bFs4SqALCepYm/H9V/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822550; c=relaxed/simple;
	bh=kidemfEHfwA/RaeWaMvfBYTeQqC+AQw/P+YNx91uzmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKZyLU356LrSK2xFgr6WXrh2oKGWSNI91BcoIYzTMXMf427DDn4GuTktqgWUAiF9EvTnuYwsZoom1RFT1VPkEPmb3ZAf/3EyQ+TmFfV9RYKMioiRyo3OQKF6oKpbVrA8ZJRhYRtEOHuq5ilm1IQAtVE5ALnGadbVtR7996I+Y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4nWvANk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4nWvANk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200FBC16AAE;
	Wed, 11 Feb 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770822550;
	bh=kidemfEHfwA/RaeWaMvfBYTeQqC+AQw/P+YNx91uzmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4nWvANkBzrOKUXI1x1jpjzjzGphxi6Y5PKgMoqdjdUwXbIzzhp+ixpZ61VwuhvGm
	 VZnyO9GlHj6OmKp3WOd+3RodKuckpjTC9PBYoVRs9Pke9EZM5qHF9YOF8AFeZ7yy3P
	 IgEWJ6b7jpO3L3z7o5b8nTK8njzwbIf0Qg9jlMtRIQAjglkz38RhLKwXUa3uENTDus
	 hkIgxvlO4LTSRs/daYJ3KsXohI0MyFCynoZDB1VvWRtmYo3sVQs6DYXRlkL21GO+ds
	 Z/Lbm+fE5gf9HAsYoVzIXTRpqvDLMZMfbjTQAYik2t/n0sr5CeDk5TPKeDvvFKi1QJ
	 jRkwe2ZJk2e7g==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
Date: Wed, 11 Feb 2026 07:09:00 -0800
Message-ID: <20260211150902.70066-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 11 Feb 2026 14:29:41 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SeongJae,
> 
> On 2/11/2026 9:59 AM, SeongJae Park wrote:
> > On Mon, 2 Feb 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Overview
> >> ----------
> >>
> >> This patch set introduces a new dynamic mechanism for detecting hot applications
> >> and hot regions in those applications.
> >>
> >> Motivation
> >> -----------
> >>
> >> Currently DAMON requires the system administrator to provide information about
> >> which application needs to be monitored and all the parameters. Ideally this
> >> should be done automatically, with minimal intervention from the system
> >> administrator.
> >>
> >>
> >> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> >> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> >> fragmentation and memory waste. For this reason, most application guides and
> >> system administrators suggest to disable THP.
> >>
> >> We would like to detect: 1. which applications are hot in the system and 2.
> >> which memory regions are hot in order to collapse those regions.
> >>
> >>
> >> Solution
> >> -----------
> >>
> >>      ┌────────────┐           ┌────────────┐
> >>      │Damon_module│           │Task_monitor│
> >>      └──────┬─────┘           └──────┬─────┘
> >>             │         start          │
> >>             │───────────────────────>│
> >>             │                        │
> >>             │                        │────┐
> >>             │                        │    │ calculate task load
> >>             │                        │<───┘
> >>             │                        │
> >>             │                        │────┐
> >>             │                        │    │ sort tasks
> >>             │                        │<───┘
> >>             │                        │
> >>             │                        │────┐
> >>             │                        │    │ start kdamond for top 3 tasks
> >>             │                        │<───┘
> >>      ┌──────┴─────┐           ┌──────┴─────┐
> >>      │Damon_module│           │Task_monitor│
> >>      └────────────┘           └────────────┘
> >>
> >>
> >> We calculate the task load base on the sum of all the utime for all the threads
> >> in a given task. Once we get total utime, we use the exponential load average
> >> provided by calc_load. The tasks that become cold, the kdamond will be stopped
> >> for them.
> >>
> >> In each kdamond, we start with a high min_access value. Our goal is to find the
> >> "maximum" min_access value at which point the DAMON action is applied. In each
> >> cycle, if no action is applied, we lower the min_access.
> >>
> >> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> >> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> >> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> >> which needs the correct vm_flags_t set.
> >>
> >> Benchmark
> >> -----------
> >>
> >> Asier Gutierrez (4):
> >>    mm/damon: Generic context creation for modules
> >>    mm/damon: Support for synchrounous huge pages collapse
> >>    mm/damon: New module with hot application detection
> >>    documentation/mm/damon: Documentation for the dynamic_hugepages 
> >> module
> >>
> >>  .../mm/damon/dynamic_hugepages.rst (new)      | 173 ++++++
> >>  include/linux/damon.h                         |   1 +
> >>  mm/damon/Kconfig                              |   7 +
> >>  mm/damon/Makefile                             |   1 +
> >>  mm/damon/dynamic_hugepages.c (new)            | 579 ++++++++++++++++++
> >>  mm/damon/lru_sort.c                           |   6 +-
> >>  mm/damon/modules-common.c                     |   7 +-
> >>  mm/damon/modules-common.h                     |   5 +-
> >>  mm/damon/reclaim.c                            |   5 +-
> >>  mm/damon/vaddr.c                              |   3 +
> >>  10 files changed, 778 insertions(+), 9 deletions(-)
> >>  create mode 100644 Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
> >>  create mode 100644 mm/damon/dynamic_hugepages.c
> > 
> > By the way, I proposed [1] an LSF/MM/BPF session for access-aware THP today.  I
> > also mentioned this patch series on the proposal as one of potential discussion
> > topics, and Cc-ed Asier.
> > 
> > I just wanted to make sure that the proposal is never a sort of implicit
> > request to hold the progress of this patch series.  Please continue discussions
> > and revisioning of this patch series regardless of the proposed LSF/MM/BPF
> > session.
> > 
> > [1] https://lore.kernel.org/20260211050729.69719-1-sj@kernel.org
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> 
> Yes, I keep working on this, I haven't given up.

Thank you Asier :)

> 
> I was thinking about your comments and about the overall idea. When you
> mentioned goals and autotuning, were you referring to DAMOS_QUOTA_USER_INPUT?
> The idea was to adjust the min_nr_accesses for region and I haven't found a way
> to adjust the damos_access_pattern using goals and quotas. If there is a way to
> do it, it may be a good idea to reuse already existing components.

I was not asking with DAMOS_QUOTA_USER_INPUT or a specific usage of DAMOS quota
goal feature for this use case in my mind.  Rather than that, I was asking
because I am also finding if there is a good way to utilize the feature for
THP.  That is, I wanted to know if you also tried that but resulted in using
a different way, because you found the feature cannot be used, and if so, what
options you tried.

One brainstorming idea I have, which I also want to further discuss on
LSF/MM/BPF is, making a new DAMOS quota goal metric.  For example, ratio of thp
to normal page.  Then, we can setup a DAMOS scheme of THP collapse action, with
quota goal of the metric, targeting, say, 50%.  Then DAMOS will automatically
adjust the scheme's aggressiveeness so that the target memory region to have
THP for 50% of it, in eventual.  Is 50% reasonable?  I feel that's good enough
for at least being default value as long as users can tweak.  But I have no
concrete theory, and didn't test.  Hence I'm saying I found no good but only
brain storming idea yet.  Yet another possible quota goal metric would be THP
hit rate, or THP collapse-causing kernel time increase.

> 
> Also, I thought about moving part of the logic to user space. What do you think
> if we leave the hot application detection mechanism in the user space and we
> keep the THP part and autotuning in the kernel? Maybe this way we can move
> forward easier and eventually merge it in the mainstream.

I agree that could be easier way.  Particularly, adding a new DAMOS action for
THP collapsing should be pretty easy in my opinion.  The expected usage and
benefit is clear to me, and the required change is quite simple (easy to
maintain).  If you have any good test results with it, I find no reason to
object it.

For auto-tuning, if you are saying the current min_nr_accesses adjustment in
the module, I'm not very sure if I'm understanding how it will look like.  A
few questions off the top of my head about it are: Will it be another core
feature?  Or, will it be the module's feature?  Will it be optional?  Why it
cannot be a new metric of DAMOS quota auto-tuning?  What is the performance
results?  And more. So I'd like to take another round of detailed review.

Nevertheless, even with the current shape, if your planned usage is clear,
tested benefit is significant, and you have valid reason to upstream this as is
for your selfish use case, I wouldn't say "no" at upstreaming it.  I may ask
some clarifications and cleanups, of course, though.

So, if you have concrete usage plan, quite good test results, and reason to
upstream it asap, please feel free to push it as is.  Upstreaming easy parts
first one by one would also be good strategy.  For example, THP collapsing
DAMOS action first, then auto-tuning (it may results in the current way, a new
DAMOS quota goal metric, or somewhat much better than what we discuss now), and
finally hot applications detection and more.

Whether to upstream it as is at once or doing it in smaller pieces is solely up
to you.  I feel like I sligtly prefer the latter one, but never a strong
opinion.  Whatever you choose, I will be happy to help :)


Thanks,
SJ

[...]
