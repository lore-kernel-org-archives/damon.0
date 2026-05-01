Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F22189F43;
	Fri,  1 May 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596907; cv=none; b=M7tPfdCT13TLD5d2Tk9cELx+8mtO6EtjDBw/i8mNe8GX7iNutP2o3WM7QeKG69Ykz+Veprt7hO24YX/h2q8nKcck/kvuxXp6FQsRFEofDkxmfZrSm2gF7hFpk4x/5nHXvXefl6x27nj5ltUEX9rZy5FU6rPOvThB8kvm65BpQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596907; c=relaxed/simple;
	bh=SN2ogcq83g8zSLd1ScLAn6N3IB4C4UcwuiZDm7rQfd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFVPWbuSr/vpJEX1xPWdPWybV/mJS7ddHSwN5VluzfINlgMeK2meYC8fTvUqA/EJVJ2JAL12iWgYLs/OSU4NgLhjOu3Yki6ZW0OXrNlHbUbZd/gzLhZ2AgN69YdZudXDoTI8b4+v9QRRTI4zTVulkPPumhl4rIj3gKU3iNqB1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXVnd7xl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXVnd7xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3124C2BCB3;
	Fri,  1 May 2026 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596907;
	bh=SN2ogcq83g8zSLd1ScLAn6N3IB4C4UcwuiZDm7rQfd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXVnd7xl5UVm7hvwTTTinhJuHSd1vhtuM2+x/aIfnnk8VyEZ/XP4QvR1eZ+ryFB46
	 puVPydCdwDfWPNWMGX0n/cXblC/zk/NThvpB+nZnU0TMziDESWgCgWvCZIqxo0taSo
	 oFiYK7GULgOF2j4l++4UtC4BVmwS7DyQahpDnZk+OH7IuG4kmoPISoB/eYQonHgki0
	 FDd27GG3+hqlLVLdd/A7PE7rGP96l4jyfcag+dID5VRxN3KMvpZLOYbat1vaoat0WM
	 YRypV+BU5FsJ6jxwksin9sLOWpgExJzE99tTYXForFdA67Kx/WPajU/mu5eUfdjxmp
	 1a88hlYvtMXWA==
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
Subject: Re: [RFC PATCH v1 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Thu, 30 Apr 2026 17:54:57 -0700
Message-ID: <20260501005458.79180-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430134139.2446417-4-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Apr 2026 13:41:38 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch introduces a new DAMON module (DAMON_HUGEPAGE)
> which collapses hot regions into huge pages.
> 
> DAMON_HUGEPAGE operates in the virtual memory space, for a
> specific task.

The new quota goal is for global memory, isn't it?  Why use global memory goal
for virtual address based scheme?

I understand it makes sense to monitor virtual address space for collapsing.
If we have to do collapsing, should we modify the quota goal to work for only
given task's virtual address space?

Also, what about split?  Should we also split huge pages into regular pages if
it is cold?  Maybe that could work on physical address space, and use the
proposed quota goal as is?

> The user is expected to supply the PID of
> the task that is going to be monitored through the
> monitored_pid module variable.
> 
> DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to
> increase or decrease the aggressiveness of page collapsing.
> User autotuning is also available for additional tuning
> aggressiveness control.
> 
> The module also includes changes to the DAMON compilation,
> so that the module can be enabled or disabled.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  mm/damon/Kconfig          |   7 +
>  mm/damon/Makefile         |   1 +
>  mm/damon/hugepage.c (new) | 341 ++++++++++++++++++++++++++++++++++++++

The cover letter was saying this module is for demonstrating the usage of the
new goal type, but this is not a sample module.  Let's make sure what is the
purpose of this module, and decide where to put it based on that.

I will skip detailed code review until the above high level question is
answered, as depending on the conclusion the code may be changed a lot.


Thanks,
SJ

[...]
