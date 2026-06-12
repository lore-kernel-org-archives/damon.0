Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E328C2A1;
	Fri, 12 Jun 2026 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225800; cv=none; b=adKNFnU6diwaY+rXjFF4sQPQfymNhjr7xpybMPDW+AXSc2JXs/40cNiiKmBbteke9lpHQgSC7lCc2Qwm8SYqoFhxTZQppawdKlyXhiU8lbaZPh3bnnj+mk0MWwWV2Dw7GQCZO4ncwbBVXwqFR4qNNMswn36hKQjnAag8+9uuyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225800; c=relaxed/simple;
	bh=1oFWPA1N1maHb0DKaJOs6ZZjaoF6RBwq6xVuxYR1UYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmijhXQloYQs5XNxvye4+AzZXq9OzaJ7QLqKTbGA3EHe3m/XJt0OwMCZINNV3K6YjAOFqy/8Tdp8EK0omCWEJqCK+Yh+at2EZEwHx+2OEYx743lDVc60IgoDN/2TbYfu1oe6MRzjR+RTrgWfi6zew3i+Q34O2qU8RQ+QlK+umho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0emxHqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0emxHqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255171F000E9;
	Fri, 12 Jun 2026 00:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225798;
	bh=i3kfnuMEeb5/mrVusiQhac4POy1/ixgY7y13y7pSyz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0emxHqCf+PaOSTWXWqIs3a9/OijNhQdir/3EJM0kQVueh+wBhWX0Cz4ZHdGm6qnB
	 Nqfv+oRwDzBwJK0HnyJ7Jy6tJ6bz9M4jN7M/ecwuYVelQMbr2/hbiBtpIpDr3jLWG2
	 7vHnTwhYLEFKXllJQl24hs3EAumcuYPAiPMsigqbiiEXvLFW5+gXcIn9lc+4fbbEE+
	 1aY9ep78jQKjzmWpSItJCWqfGOhq08A7a69CyXfOxgC8darvDd45+W3veaPIBP1WAx
	 AStwblsxQG5lyJcEmvPPptVMLKdh2FzAMxn8xIlGvPtGKcECwzbi1f8kNwXh+IB4gU
	 4xACwnn3gAQCw==
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
Subject: Re: [RFC PATCH v4 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Thu, 11 Jun 2026 17:56:30 -0700
Message-ID: <20260612005631.83964-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611150244.3454699-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Thu, 11 Jun 2026 15:02:40 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ========
> 
> This patch set introduces a new autotuning which allows to collapse
> hot regions into hugepages.
> 
> Motivation
> ==========
> 
> Since TLB is a bottleneck for many systems[1], a way to optimize TLB
> misses (or hits) is to use huge pages. Unfortunately, using "always"
> in THP leads to memory fragmentation and memory waste. For this reason,
> most application guides and system administrators suggest to disable THP.
> 
> Currently DAMON has DAMOS_HUGEPAGE, DAMOS_NONHUGEPAGE and DAMOS_COLLAPSE.
> However, there is no way to tune the settings. It will collapse all the
> hot regions that meet the access pattern. If the server is a bare metal
> database or big data server, this will also lead to eventual fragmentation.
> 
> Additionally, currently THP is set globally. Ideally, there should be a
> way to control which tasks can use huge pages.
> 
> Solution
> ========
> 
> DAMON has now a way to autotune some of the variables and adjust quotas
> automatically, so that DAMON is fired only under the right circumstances.
> It would be nice to have something similar, but for huge pages.
> 
> A new autotuning quota goal[2], damos_hugepage_mem_bp, is introduced,
> which checks the huge page consumption to total memory consumption. This
> new quota mechanism reuses current autotuning architecture.
> 
> A new module is introduced to demonstrate the use of huge pages
> collapse autotuning. The goal is to collapse hot regions of a given
> process into huge pages. The module launches a kdamond thread for a
> certain task provided by the user through monitored_pid module argument.
> Hugepage goal autotuning will automatically adjust the aggressiveness
> of hot region collapses.
> 
> This module also has a user autotuning knob which allows the user to
> adjust the aggressiveness of page collapsing.
> 
> Benchmarks
> ==========
> 
> Huge page collapse autotuning was tested in a physicial machine with
> MariaDB 10.5.29 and sysbench as the benchmark framework.
> 
> The hugepage module was set up in the following way:
> 
> # echo 1000 > min_age
> # echo 1000 > quota_percentage_hugepage
> # echo $(pidof mariadbd) > monitored_pid
> # echo on > enabled
> 
> The goal was to achieve 5% of the total memory used as hugepage.
> Since the database was not very big, we may not be able to achieve
> high amount of huge pages per total memory consumption ratio.
> 
> The table below shows the memory consumption over time. Gaps in the
> timestamp means that no changes in the hugepage consumption happened
> over that period of time in MB.
> 
> +-----------+----------------+----------------+----------------------+
> | timestamp | total mem used | huge page used | percentage hugepage  |
> +-----------+----------------+----------------+----------------------+
> | 0         | 3044.988281    | 0              | 0%                   |
> | 22        | 3160.207031    | 2              | 0.06%                |
> | 30        | 3250.90625     | 4              | 0.12%                |
> | 69        | 3781.238281    | 6              | 0.16%                |
> | 71        | 3822.226563    | 8              | 0.21%                |
> | 72        | 3846.578125    | 10             | 0.26%                |
> | 73        | 3852.402344    | 12             | 0.31%                |
> | 74        | 3868           | 14             | 0.36%                |
> | 75        | 3881.84375     | 104            | 2.68%                |
> | 275       | 4194.175781    | 106            | 2.52%                |
> +-----------+----------------+----------------+----------------------+
> 
> After second 275, no more pages are collapsed into hugepages
> 
> Performance:
> Baseline -> 18,124.1 transactions per second
> Hugepage autotune -> 18,163.64 transactions per second
> 
> TODO
> ====
> - Support page splitting for cold hugepages.
> 
> Patches Sequence
> ================
> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
> Patch 2 -> Module that demonstrates how to use
>            DAMOS_QUOTA_HUGEPAGE_MEM_BP and DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
> Patch 3 -> Support for DAMOS_QUOTA_HUGEPAGE_MEM_BP in sysfs-schemes
> Patch 4 -> Documentation
> 
> Changes from previous versions
> ==============================
> RFC 3[3] -> RFC 4
>   - Simplified the module
>   - Removed unnecessary parameters
>   - Renamed DAMOS_QUOTA_HUGEPAGE_MEM_BP to unify the
>     naming style
>   - Switched to DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
>   - Updated the documentation
>   - Removed new interface for context creation with
>     DAMON_OPS_VADDR

Thank you for keep revisioning this patch series!

I think now we are aligned on the overall direction of this series.  Let's add
the new metrics with the sample module.  The sample module's overall shape and
size looks reasonable to me.

So I think now is the time to start making this series be more seriously get
ready for the landing.  I find some parts in commit messages and cover letter
that not correctly updated for my feedbacks on last revision.  Particularly
tests and future work parts,  and sample module name are not addressing my
previous feedback.  I therefore skipping review of quite details in this
revision instead of adding same comments again.  That could be ok for early
stage RFC series, but let's move to the next stage.

From the next revision, could you please take more time on addressing all my
previous comments and updating everythings including comments be consistent?
If you have a reason to keep some of my previous comments not yet addressed for
the next revision, it is toally fine but please clarify.

Also, I'm not sure if I asked this same question before, but ...  Could you
please share your future plans for this specific series?  What change you want
to further make before dropping RFC?


Thanks,
SJ

[...]
