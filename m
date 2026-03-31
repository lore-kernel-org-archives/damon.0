Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81A35C190;
	Tue, 31 Mar 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920672; cv=none; b=DSU3qH10uoaDuCxCyc9Lv9Cxu86nDeUELgfF8DpcyQaISwOLfxspXUfsYmnhKIKqUeWNyAQutpXKrFk9guvwpM7gwU8a+YYsWPcW2JtZTM8E+mzd7CcCpj7ARgIHwF+PmSToYi5H+JlZ0J/6EnxyhkjS9jzOzBSEQdG194cI5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920672; c=relaxed/simple;
	bh=BpCVDVb5hN5kDG6hsr8UXPJLUCxbf+zwL266pUrp/ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCrPXnqyKlPfodn/O6gOW9qJpxRQeA/XTtSW3PgnQnEg+8BrjIc40aAfrVE6OmWpKb5spMq1wUkHKcgbPoiYZOy3rCtc1BW6Kgt1YZLpVFUN9LL2Ej8Y2fTS8Fo78xFrIGijugLUs8Nml3SK/RorBROz93X7iuFRLWFlABHrX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC7AnM/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC7AnM/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E28AC4CEF7;
	Tue, 31 Mar 2026 01:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774920672;
	bh=BpCVDVb5hN5kDG6hsr8UXPJLUCxbf+zwL266pUrp/ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LC7AnM/OUeEgrcsa8HHEFPqLWP243+Ja97lMHe/+cSbJjhGvEF1WG6XBJZOuPfjiV
	 uD6UwdovAaHKO6CmDmC2gFBJixhk2NR2iymAN35CLWOtDoLmERdKVzEafzX6ZZx/sz
	 5k0L8MkFTUQ1kiZISs0Vi3pnm+SRGcSxtSv/TEKHl91kilNuPPnNsM2yBbXDLSdL3S
	 X1xeulcRWo9CwHIrq6t5F33pe5e6VPBb6Q/B/a4xxevKUnscHl8dlWJ4Xmx32LTx67
	 E9mSo2MroRe7+c/cqVsP4fEBHMK160SqY0Ou5G2Fuf7B3ipH8bHHfHGOzXjdn5vTum
	 bevTyWo+SlbvA==
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
Subject: Re: [PATCH v1 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Mon, 30 Mar 2026 18:31:09 -0700
Message-ID: <20260331013109.66590-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330145758.2115502-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Mon, 30 Mar 2026 14:57:58 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch set introces a new action:  DAMOS_COLLAPSE.
> 
> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> working, since it relies on hugepage_madvise to add a new slot. This
> slot should be picked up by khugepaged and eventually collapse (or
> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> enabled, khugepaged will not be working, and therefore no collapse
> will happen.

I should raised this in a previous version, sorry.  But, that is only a half of
the picture.  That is, khugepaged is not the single THP allocator for
MADV_HUGEPAGE.  IIUC, MADV_HUGEPAGE-applied region also allocates huge pages in
page fault time.  According to the man page,

    The kernel will regularly scan the areas marked as huge page  candidates
    to replace  them with huge pages.  The kernel will also allocate huge pages
    directly when the region is naturally aligned to the huge page size (see
    posix_memalign(2)).

I think the description is better to be wordsmithed or clarified.  Maybe just
pointing the MADV_COLLAPSE intro commit (7d8faaf15545 ("mm/madvise: introduce
MADV_COLLAPSE sync hugepage collapse")) for the rationale could also be a good
approach, as the aimed goal of DAMOS_COLLAPSE is not different from
MADV_COLLAPSE.

> 
> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
> the address range synchronously.
> 
> This new action may be required to support autotuning with hugepage
> as a goal[1].
> 
> [1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
> 
> ---------
> Benchmarks:

I recently heard some tools could think above line as the commentary
area [1] separation line.  Please use ==== like separator instead.  For
example,

    Benchmarks
    ==========

> 
> Tests were performed in an ARM physical server with MariaDB 10.5 and 
> sysbench. Read only benchmark was perform with uniform row hitting,
> which means that all rows will be access with equal probability.
> 
> T n, D h: THP set to never, DAMON action set to hugepage
> T m, D h: THP set to madvise, DAMON action set to hugepage
> T n, D c: THP set to never, DAMON action set to collapse
> 
> Memory consumption. Lower is better.
> 
> +------------------+----------+----------+----------+
> |                  | T n, D h | T m, D h | T n, D c |
> +------------------+----------+----------+----------+
> | Total memory use | 2.07     | 2.09     | 2.07     |
> | Huge pages       | 0        | 1.3      | 1.25     |
> +------------------+----------+----------+----------+
> 
> Performance in TPS (Transactions Per Second). Higher is better.
> 
> T n, D h: 18324.57
> T n, D h 18452.69

"T m, D h" ?

> T n, D c: 18432.17
> 
> Performance counter
> 
> I got the number of L1 D/I TLB accesses and the number a D/I TLB
> accesses that triggered a page walk. I divided the second by the
> first to get the percentage of page walkes per TLB access. The
> lower the better.
> 
> +---------------+--------------+--------------+--------------+
> |               | T n, D h     | T m, D h     | T n, D c     |
> +---------------+--------------+--------------+--------------+
> | L1 DTLB       | 127248242753 | 125431020479 | 125327001821 |
> | L1 ITLB       | 80332558619  | 79346759071  | 79298139590  |
> | DTLB walk     | 75011087     | 52800418     | 55895794     |
> | ITLB walk     | 71577076     | 71505137     | 67262140     |
> | DTLB % misses | 0.058948623  | 0.042095183  | 0.044599961  |
> | ITLB % misses | 0.089100954  | 0.090117275  | 0.084821839  |
> +---------------+--------------+--------------+--------------+
> 
> - We can see that DAMOS "hugepage" action works only when THP is set
>   to madvise. "collapse" action works even when THP is set to never.

Make sense.

> - Performance for "collapse" action is slightly lower than "hugepage"
>   action and THP madvise.

It would be good to add your theory about from where the difference comes.  I
suspect that's mainly because "hugepage" setup was allocating more THP?

> - Memory consumption is slighly lower for "collapse" than "hugepage"
>   with THP madvise. This is due to the khugepage collapses all VMAs,
>   while "collapse" action only collapses the VMAs in the hot region.

But you use thp=madvise, not thp=always?  So only hot regions, which
DAMOS_HUGEPAGE applied, could use THP.  It is same to DAMOS_COLLAPSE use case,
isn't it?

I'd rather suspect the natural-aligned region huge page allocation of
DAMOS_HUGEPAGE as a reason of this difference.  That is, DAMOS_HUGEPAGE applied
regions can allocate hugepages in the fault time, on multiple user threads.
Meanwhile, DAMOS_COLLAPSE should be executed by the single kdamond (if you
utilize only single kdamond).  This might resulted in DAMOS_HUGEPAGE allocating
more huge pages faster than DAMOS_COLLAPSE?

> - There is an improvement in THP utilization when collapse through
>   "hugepage" or "collapse" actions are triggered.

Could you clarify which data point is showing this?  Maybe "Huge pages" /
"Total memory use" ?  And why?  I again suspect the fault time huge pages
allocation.

> - "collapse" action is performance synchronously, which means that
>   page collapses happen earlier and more rapidly.

But these test results are not showing it clearly.  Rather, the results is
saying "hugepage" was able to make more huge pages than "collapse".  Still the
above sentence makes sense when we say about "collapsing" operations.  But,
this test is not showing it clearly.  I think we should make it clear the
limitation of this test.

>   This can be
>   useful or not, depending on the scenario.
> 
> Collapse action just adds a new option to chose the correct system
> balance.

That's a fair point.  I believe we also discussed pros and cons of
MADV_COLLAPSE, and concluded MADV_COLLAPSE is worthy to be added.  For
DAMOS_COLLAPSE, I don't think we have to do that again.

> 
> Changes
> ---------
> RFC v2 -> v1:
> Fixed a missing comma in the selftest python stript
> Added performance benchmarks
> 
> RFC v1 -> RFC v2:
> Added benchmarks
> Added damos_filter_type documentation for new action to fix kernel-doc

Please put changelog in the commentary area, and consider adding links to the
previous revisions [1].

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---

Code looks good to me.  Nonetheless I'd hope above commit message and benchmark
results analysis be more polished and/or clarified.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ
