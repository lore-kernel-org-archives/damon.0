Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066327BF7C;
	Fri,  5 Jun 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621586; cv=none; b=CMS75fV9UYzP65KPpWgrUfS0shevR70ZqXBQGsxtYigDq6HH+6wQ3PixEgQDJtZllg8T/LcvsWnWf/2f+aim6TMiB1TqorG/eeao1Cw55de1X3QJ5mWiDkw7sa+YjdMcnTrTkjIGBhy16/JT2/O5gjSvVscD5rS4nGqg3ltUbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621586; c=relaxed/simple;
	bh=fUSnFZk81BcB3DHFoV/ljZgjwzoK8JiUxpPmya3xhic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX5x80/hkHNx+jfl/HWRV3bpWtWVoWbQOlKPq9hDEoZliXFZxsw8+KFfsajRupZYuFmAeCOjBe12Xc/FIbAT1sTasPMuYjdTQT+R9e0BzuRYTMfjKi+d7SY6cUsroioxdP2jg9MGfGEre91t+k4z93BCBGOGhR7FzI8A5dcVL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gffu67pK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gffu67pK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AFF1F00893;
	Fri,  5 Jun 2026 01:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621585;
	bh=O2jfgDGh1JqIqL3XwH3zVPi2aidnhBEMNm8yj1o7J8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gffu67pK00AcBbgZgJJLLwrZd3eSRjO95CGNVW/EFGuYpyN8pmAqRxLB288ZQradf
	 yVO0GMXO8jIdXbf2E6UzIEOo78NJj10aWMLnVRaKjYS7+bSe7hC6eDXFD2pgr3DOTw
	 TqWVWbiZR8RUX7bY8EZFeiQUWE6DHPFgTXa/b6iMBfm6Ac0vJUfmoSlCu37AONtYri
	 09XyeIvhx3Z0/RHvtrjcFFthd3LX29izDHjZPxAEVY0o91R3R7WEh3VntEVFrrMqxL
	 eWMVD6WqqvwLdueUJOhUmuD/ojS1VZJIkv5ucmEjfp+eVM+IxmKjJYZJrx1JOARU33
	 u94QZPvqaZ85w==
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
Subject: Re: [RFC PATCH v3 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Thu,  4 Jun 2026 18:06:19 -0700
Message-ID: <20260605010620.83004-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604150338.501128-4-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Jun 2026 15:03:36 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch introduces a new DAMON module (SAMPLE_DAMON_HUGEPAGE)

Could we make the name shorter, to look more consistent with other sample
modules?  E.g., SAMPLE_DAMON_HPAGE?

> which collapses hot regions into huge pages.
> 
> SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
> specific task. The user is expected to supply the PID of the task
> that is going to be monitored through the monitored_pid module
> variable.
> 
> SAMPLE_DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to
> increase or decrease the aggressiveness of page collapsing. User
> autotuning is also available for additional tuning aggressiveness
> control.
> 
> The module also includes changes to the DAMON compilation, so that
> the module can be enabled or disabled.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  mm/damon/Makefile              |   8 +-
>  samples/damon/Kconfig          |  12 ++
>  samples/damon/Makefile         |   2 +
>  samples/damon/hugepage.c (new) | 350 +++++++++++++++++++++++++++++++++
>  4 files changed, 368 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index d8d6bf5f8bff..16459ce40304 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -1,9 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-y				:= core.o
> +obj-y				:= core.o modules-common.o
>  obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
>  obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
>  obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
> -obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
> -obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
> -obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
> +obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
> +obj-$(CONFIG_DAMON_LRU_SORT)	+= lru_sort.o
> +obj-$(CONFIG_DAMON_STAT)	+= stat.o

This is for letting the new sample module use the code in ops-common.o, right?
I'd like to keep sample modules simple and isolated under samples/ directory.
Could you please make the sample module simpler and remove the above change?

> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
> index cbf96fd8a8bf..512f150aaabb 100644
> --- a/samples/damon/Kconfig
> +++ b/samples/damon/Kconfig
> @@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_DAMON_HUGEPAGE
> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HUGEPAGE)"

Can this be more consistent with other sample modules?  E.g.,

DAMON sample module for auto-tuned THP collapsing ?

> +	depends on DAMON && DAMON_VADDR
> +	help
> +	  This module monitors a certain PID provided by the user through
> +	  monitored_pid attribute. Hot regions are determined by DAMON-based
> +	  sampling. Collapsing occurs according to the quota goal using total
> +	  memory usage to huge page usage ratio. The ratio is set by the user
> +	  through a module attribute.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/samples/damon/Makefile b/samples/damon/Makefile
> index 72f68cbf422a..f90845faec85 100644
> --- a/samples/damon/Makefile
> +++ b/samples/damon/Makefile
> @@ -3,3 +3,5 @@
>  obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
>  obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
>  obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
> +obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE)	+= hugepage.o
> +ccflags-$(CONFIG_SAMPLE_DAMON_HUGEPAGE)	+= -I$(srctree)/mm/damon

As I mentioned above, let's not mix samples/ with mm/damon/

> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
> new file mode 100644
> index 000000000000..e24562c92348
> --- /dev/null
> +++ b/samples/damon/hugepage.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 HUAWEI, Inc.
> + *             https://www.huawei.com
> + *
> + * Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> + */
> +
> +#define pr_fmt(fmt) "damon-hugepage: " fmt

Apparently this module's source code is following patterns of reclaim.c and
lru_sort.c.  That's for non-sample modules.  Could you please rewrite this
sample module following patterns in sample modules, like that for wsse.c or
prcl.c ?


Thanks,
SJ

[...]
