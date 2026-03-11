Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAE32C92D;
	Wed, 11 Mar 2026 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205629; cv=none; b=TcsloQXqjzNlfnSurGQGc/Bx8/gVqy15mMeYGLuihZvJ18mD6NDGAVTcZ3eWLaSnd7ngPTnweSgeqGtX6lQ7pOdkjj0vfK/b9SGUv6VOBiCG/BbbeeTXrjBWA707AJk7Ba3D0YHRYqG3WrE1PRcCXHVQIZHF+i7EdYSNgrPZAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205629; c=relaxed/simple;
	bh=faeJo8ihjOE+9bWVu9ZNPRNm5sUDD91envks+mZlquc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxgPsro42LBXksNqPahoZztpQlCzAjtWuJRSEB0hTwXyYqfxagrzSlTZWHAtqd4LVH3wBpN+fTxghIGn2WKJmpM4B8MwYmP6oaVIwPgtyUv2vb/R1T4mx5NtYOXWLwhWDEmHyF5umwO0PTncdXooeJEIEGXxwqstcPTh4eVI8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUxX34tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUxX34tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D134C2BCAF;
	Wed, 11 Mar 2026 05:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773205628;
	bh=faeJo8ihjOE+9bWVu9ZNPRNm5sUDD91envks+mZlquc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUxX34txTmCrHmBEwuTeX0N2rpfmmyw7vSLIbdrfUhGHvYen2D3nlcS7kHTAZ+Z1A
	 GUFkyVbUUwu3tXLqv5QAjs/Zijsc5DaUaNNvLfjcYosEsaISjSmVLClWXpnTpRSnw7
	 fZKd8Aa8LuIi8kIqa+W7gvj0FsVAUZFU02Va6nH3QdUmeOLtSYYLt3bsJjgvre/vtM
	 l+zQyxgPnnJ2yF+ez78OhMgdEGGLgJpt4XWDgZ+kmrA+uZBSWWluYswLOlLG8Brf2I
	 Ckgs9c7qbaQzBIUPCc+rBUvKRVa/94GOOmwyDspxn19WoMIjJt0OpSsvMQWf0HsERP
	 Ju27I8kYUStAQ==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
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
Subject: Re: [RFC PATCH v2 0/4] mm/damon: Support hot application detections
Date: Tue, 10 Mar 2026 22:07:00 -0700
Message-ID: <20260311050701.91686-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310162420.4180562-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,


Thank you for continuing this work!

On Tue, 10 Mar 2026 16:24:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ----------

Let's make the legnth of the subject and the length of the underline same.

> 
> This patch set introduces a new dynamic mechanism for detecting hot applications
> and hot regions in those applications.

Seems now you offload the hot applications detection to the user space.  If I'm
not wrong, you should remove "hot applications and" on the above sentence.

> 
> Motivation
> -----------
> 
> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> fragmentation and memory waste. For this reason, most application guides and
> system administrators suggest to disable THP.
> 
> 
> Solution
> -----------
> 
> A new Linux kernel module that uses DAMON to detect hot regions and collapse
> those regions into huge pages. The user supplies a set of PIDs using a module
> parameter,

This sounds reasonable to me.

> and then, the module launches a new kdamond thread to monitor each
> of the tasks.
> 
> In each kdamond, we start with a high min_access value. Our goal is to find the
> "maximum" min_access value at which point the DAMON action is applied. In each
> cycle, if no action is applied, we lower the min_access.

So, this patch series introduces a sort of auto-tuning of the hugepages
collapse hotness threshold, that implemented in the new module.

We already have a sort of DAMOS auto-tuning feature, namely goal-based DAMOS
quota auto-tuning [1].  Have you considered using that?  Of course, it might
not be able to be used as is.  Some extensions, e.g., introduction of new goal
metric, may be needed.

Yet another approach would be implementing the auto-tuning in the user-space.
Because DAMON parameters can be updated online, updating the min_access from
the user space should be doable?  Given the fact the module anyway require
user-space control for feeding the list of applications to apply access-aware
huge pages collapsing, I find no problem at user space driven auto-tuning.

If the goal-based DAMOS quota auto-tuning or the user-space based auto-tuning
are feasible, all the controls can be done using DAMON sysfs interface.
Introduction of the new kernel module might not really be needed in the case.

We have DAMON modules in addition to DAMON sysfs interface for users who want
to use DAMON for a given specific use case with only minimum or near-zero
user-space control.  In this case, because it is already aimed to ask the
user-space to feed the list of applications to apply DAMOS-based hugepages
collapsing, it seems a new module is not really needed, to me.

But I guess your use case might have some special restrictions that really
require use of the module instead of offloading the auto-tuning to the
user-space or DAMON core.  Is that the case?  If so, can you share more details
about it?

> 
> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> which needs the correct vm_flags_t set.

This makes sense to me.  I expect DAMOS_COLLAPSE to have some advantages over
DAMOS_HUGEPAGE for some use cases, similar to MADV_COLLAPSE vs MADV_HUGEPAGE.

From my perspective, this patch series is introducing three things.
1) hugepage collapsing hotness threshold auto-tuning, 2) the module for running
the auto-tuning, and 3) DAMOS_COLLAPSE.  To me, it is unclear if the first two
changes are really needed.  I will wait your answer.

Meanwhile, the third change seems reasonable and not necessarily need to be
blocked for the other two changes.  I think separating the third change from
this patch series and upstreaming it first could also be a path forward.
Because the change is simple and sound, convincing me would be easy.  I'd be
convinced if at least some reasonable test results can be shown.  I'm not
saying we should drop the other two changes.  We can keep discussing those in
parallel.  Rather, upstreaming the third change first could help finding real
benefits of the other two changes, since the testing will be easier.  The
decision is up to Asier, of course.  I'm just sharing my two cents.

> 
> 
> -----------
> Changes in v2:

Let's keep calling this "RFC" here.  When you drop the "RFC" tag, this might
confuse some people.

Also, when you add a changelog of a patch, adding a link to the previous
version [2] can help reviewing.

> - Previously there was a mechanism to automatically detect hot applications.
>   Based on SeongJae Park's feedback [1], this was removed from the module, leaving
>   it entirely to the user space.
> - All allocations now use kzalloc_obj.
> - Since the user space provides now the list of pids to monitor, a commit_input
>   parameter is added to allow changing the pids while the module runs.
> - Renamed the module from dynamic_hugepages to hugepages

Thank you for doing this, Asier.

> 
> [1]: https://lore.kernel.org/all/20260211150902.70066-1-sj@kernel.org/
> 
> Asier Gutierrez (4):
>   Damon_modules_new_paddr_ctx_target. This works  only for physical
>     contexts. In case of virtual addresses, we should  duplicate the
>     code.
>   Support for huge pages collapse, which will be used by
>     dynamic_hugepages module.
>   This new module launches a new kdamond thread for each of them. The
>     purpose is to detect hot regions in a given list of tasks and
>     collapse them into huge pages.
>   DAMON_HOT_HUGEPAGE documentation
> 
>  .../admin-guide/mm/damon/hugepage.rst (new)   | 186 ++++++++
>  include/linux/damon.h                         |   1 +
>  mm/damon/Kconfig                              |   7 +
>  mm/damon/Makefile                             |   1 +
>  mm/damon/hugepage.c (new)                     | 441 ++++++++++++++++++
>  mm/damon/lru_sort.c                           |   5 +-
>  mm/damon/modules-common.c                     |   6 +-
>  mm/damon/modules-common.h                     |   4 +-
>  mm/damon/reclaim.c                            |   5 +-
>  mm/damon/vaddr.c                              |   3 +
>  10 files changed, 650 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/damon/hugepage.rst
>  create mode 100644 mm/damon/hugepage.c
> 
> -- 
> 2.43.0

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning
[2] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ
