Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D5258EE0;
	Wed, 11 Feb 2026 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793158; cv=none; b=TEowtcaHNToYTX8o6B1mVHlpncf5RbPxmw79j/wdOuuoKYxfxQGAPLdibbdT1KTShsppb9u8WYf7FVx+8Xoa4KDAR5pWm+ynInpp6Ut2DT37pmn5a7WRAEKgcJKeGs9xYlB1X2y1Al7f/eCDY89q19U3o6yJQluN1yVX0vKO3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793158; c=relaxed/simple;
	bh=rclUdVW+gYi3vSJidp7DNr34hFtP2+tfLi6yHa+zmwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thJzOxGb6wMM1gKhu7G+BwERQlyggdjOtw02HRoKN26VG7TIqL+KajGyMG+eT72hROlRgmraAP9YrL9I1eXv9P/ZILM1d0oh0ILm8PlfzRgqp+UC6bWzKEthow53hjN7n0cq5QjHmSA0kFpradq6SY7U0RTBtIOLeMKnFkxn7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daQmtwYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daQmtwYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C2C4CEF7;
	Wed, 11 Feb 2026 06:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770793158;
	bh=rclUdVW+gYi3vSJidp7DNr34hFtP2+tfLi6yHa+zmwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daQmtwYNuAqsJUQHTDrvZf8/bIzvWnDmzifjZW+ZzMtug3jXXhRvaLh80p9eTEzbg
	 gSi45aZxI7ri98rUSaNBG3V5PTuWrFX3fXlwShfB8izNeU2KaFL9J59yNFSwvIG4Vw
	 zCX3/K37sX4uyf3E1fdCufQpZxkZ21jQ8te37SNJjKca+j8A2aWrED46May48oxVAL
	 EGbJbMOb2ka1cPlTF5yLQ/6A8pJAlggweOaWQFrWBz/GP3gS3lXlogcP9yOGsNyNL2
	 InEfiGmU1pexSBueCYTgJzsufV7gJVwg5Ms1fY0xWnsVICq//9/Nn4zh8BQNnyfWfT
	 KyUIvZIga8lwQ==
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
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
Date: Tue, 10 Feb 2026 22:59:12 -0800
Message-ID: <20260211065914.68174-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 2 Feb 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ----------
> 
> This patch set introduces a new dynamic mechanism for detecting hot applications
> and hot regions in those applications.
> 
> Motivation
> -----------
> 
> Currently DAMON requires the system administrator to provide information about
> which application needs to be monitored and all the parameters. Ideally this
> should be done automatically, with minimal intervention from the system
> administrator.
> 
> 
> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> fragmentation and memory waste. For this reason, most application guides and
> system administrators suggest to disable THP.
> 
> We would like to detect: 1. which applications are hot in the system and 2.
> which memory regions are hot in order to collapse those regions.
> 
> 
> Solution
> -----------
> 
>      ┌────────────┐           ┌────────────┐
>      │Damon_module│           │Task_monitor│
>      └──────┬─────┘           └──────┬─────┘
>             │         start          │
>             │───────────────────────>│
>             │                        │
>             │                        │────┐
>             │                        │    │ calculate task load
>             │                        │<───┘
>             │                        │
>             │                        │────┐
>             │                        │    │ sort tasks
>             │                        │<───┘
>             │                        │
>             │                        │────┐
>             │                        │    │ start kdamond for top 3 tasks
>             │                        │<───┘
>      ┌──────┴─────┐           ┌──────┴─────┐
>      │Damon_module│           │Task_monitor│
>      └────────────┘           └────────────┘
> 
> 
> We calculate the task load base on the sum of all the utime for all the threads
> in a given task. Once we get total utime, we use the exponential load average
> provided by calc_load. The tasks that become cold, the kdamond will be stopped
> for them.
> 
> In each kdamond, we start with a high min_access value. Our goal is to find the
> "maximum" min_access value at which point the DAMON action is applied. In each
> cycle, if no action is applied, we lower the min_access.
> 
> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> which needs the correct vm_flags_t set.
> 
> Benchmark
> -----------
> 
> Asier Gutierrez (4):
>    mm/damon: Generic context creation for modules
>    mm/damon: Support for synchrounous huge pages collapse
>    mm/damon: New module with hot application detection
>    documentation/mm/damon: Documentation for the dynamic_hugepages 
> module
> 
>  .../mm/damon/dynamic_hugepages.rst (new)      | 173 ++++++
>  include/linux/damon.h                         |   1 +
>  mm/damon/Kconfig                              |   7 +
>  mm/damon/Makefile                             |   1 +
>  mm/damon/dynamic_hugepages.c (new)            | 579 ++++++++++++++++++
>  mm/damon/lru_sort.c                           |   6 +-
>  mm/damon/modules-common.c                     |   7 +-
>  mm/damon/modules-common.h                     |   5 +-
>  mm/damon/reclaim.c                            |   5 +-
>  mm/damon/vaddr.c                              |   3 +
>  10 files changed, 778 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
>  create mode 100644 mm/damon/dynamic_hugepages.c

By the way, I proposed [1] an LSF/MM/BPF session for access-aware THP today.  I
also mentioned this patch series on the proposal as one of potential discussion
topics, and Cc-ed Asier.

I just wanted to make sure that the proposal is never a sort of implicit
request to hold the progress of this patch series.  Please continue discussions
and revisioning of this patch series regardless of the proposed LSF/MM/BPF
session.

[1] https://lore.kernel.org/20260211050729.69719-1-sj@kernel.org


Thanks,
SJ

[...]
