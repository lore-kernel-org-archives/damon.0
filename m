Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B11624C5;
	Fri,  1 May 2026 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596112; cv=none; b=nO9quUg3T9JgxVs/H6iafBvnDqpFWkWQyyLWIN2rl2yU7MQFCXGoUighueWXUYZJNCbArbjQwMwpgQ2gimca0NBy1q8DJ+50/wLdyT4mA0Gq07N3F1VzqU2wev/fYB9rb/lj2+Boa6FN5MFirvVaYWi2dG/nn+0nPcWH7fqJsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596112; c=relaxed/simple;
	bh=gn0A/IMKl276FIB3LENO7HJggCV5JRxz4pjAVumVjKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZbY2vm4mk6+sxs3Iu7OVN3Y5F1r8mMzetA+xlbZOoxMm3ZxM4i0sL4UfK8PROyY2EV8+7PSqVbatZHUL4caDpaCSuL2sj+3Q8ZxzFqvEHvf1r1F245K+ScF/Vldjd2MSkak5KBq7WgrLQfeGf+cH32kTPb+HAUmO+kx/0ii34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB3hWGTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB3hWGTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51811C2BCB3;
	Fri,  1 May 2026 00:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596111;
	bh=gn0A/IMKl276FIB3LENO7HJggCV5JRxz4pjAVumVjKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NB3hWGTVp+q+Ls8LF2zgKA0MlM4bGXU7nMaJM6O3ArU64jgTi1jiHz3GZ5E7Jn64D
	 dkYqhYipn/xBf3qVqdHzaTRs4iAlIqHlAAK775YR+PGqA7RYqknYzQYh13xCYf9XuL
	 fct6AWzEVT6U/bxWE4v0LkAG9CCQuCYzkl9r0zU0qutKc6MY/zU1QUWUG+wo6h0CTr
	 tfch0E8+oV5M3zSiFIGAgsrwti6fed0LIz1eAba3TudNKgIVB4PNxajerSZbx5NtLq
	 LTaI0WV1IfrDqKLTD4PzocZT0x7si2hdcYU0edRP7Cs95m73NnoOlpHE6N8f1RixPB
	 DGZzGKacK26Sw==
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
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Thu, 30 Apr 2026 17:41:47 -0700
Message-ID: <20260501004148.78873-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Thu, 30 Apr 2026 13:41:35 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ================

Let's align the length of underline with the text.

> 
> This patch set introduces a new autotuning which allows to collapse
> hot regions into hugepages.
> 
> Motivation
> ================
> 
> Since TLB is a bottleneck for many systems, a way to optimize TLB
> misses (or hits) is to use huge pages. Unfortunately, using "always"
> in THP leads to memory fragmentation and memory waste. For this reason,
> most application guides and system administrators suggest to disable THP.

I think the motivation should further explain why existing DAMOS features
(access pattern-based targetting and quota auto-tuning with existing quota
goals) are insufficient.  If that makes the text too long, I think the
explanation for well-known THP benefit and problems can be reduced or skipped.

> 
> Solution
> ================
> 
> A new autotuning quota goal[1], damos_get_used_hugepage_mem_bp, is
> introduced, which checks the huge page consumption to total anonymous
> memory consumption. This new quota mechanism reuses current autotuning
> architecture.

The idea makes sense to me.

The name sounds bit redundant, though.  How about DAMOS_QUOTA_HUGEPAGE_BP for
the enum, and hugeapge_bp for sysfs input?

> 
> A new module is introduced to demonstrate the use of huge pages
> collapse autotuning. The module launches a kdamond thread for a 
> certain task provided by the user through monitored_pid module argument.

If it is only for demonstration, I think it is more fit to be a sample module
(placed under samples/damon/).

> 
> This module also has a user autotuning knob which allows the user to
> adjust the aggressiveness of page collapsing.
> 
> Benchmarks
> ================
> In progress, will add them in the next RFC series.

Looking forward to!

I may request not that much test results for the quota goal.  If the module is
not just a sample but for a real world use case, I may hope somewhat reasonable
test resulsts.

> 
> TODO
> ================
> 
> - Since DAMOS_COLLAPSE is not in upstream and this is just a
>   RFC, I have used DAMOS_HUGEPAGE instead. This will change
>   to DAMOS_COLLAPSE in future series.

It is now in mm-new and it is recommended to use it as a baseline for DAMON
patches.  So please feel free to use DAMOS_COLLAPSE from the next version,
unless there is a reason to worry if DAMOS_COLLAPSE will be dropped from
mm-new.

> 
> Patches Sequence
> ================
> Patch 1 -> damon_modules_new_vaddr_ctx_target
> Patch 2 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
> Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
>            and the new VADDR ctx creation
> Patch 4 -> Documentation
> 
> [1] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com

Adding more context about what this link is would be nice.  I can find the link
marker from the above text, but I was unable to expect what this is without
opening the link.


Thanks,
SJ

[...]
