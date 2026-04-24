Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1321D590;
	Fri, 24 Apr 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994973; cv=none; b=Cx7prIo2Sb4YGdmfpBikjDqAYqWhBKT2rwL9Xtj8/e12wJp94N3PKQz++eQW64jAAw5nx//Q7n83XMzigUYFdBZ06fob+DJxyAu+fxcZvCJIiM6VbA8OCx+giDSGJQNvZswgFql/Zrs05a92bXgiF1gAEkn3uqxrf7KDlVET91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994973; c=relaxed/simple;
	bh=QSSazNTuZnTtnxSTAVV/omqIibexYYaHVv32vSM+ju0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y94Xl39y0OXA13+VLfuXF/bxRloAnNi7wjzkvV96Wyi3Lp2b6BT8jaWlA9Hx9gVfWbHpBW4QbBTSpOFdj0gIpKrbs//Ho8kqQmCcffj+FMRBQCzgaiVL1iJ4ae6HJ0BpLo0zKdscdlsttWfyQg9ZmOEIArl00iQ2vw8Tm2YpaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHk011y5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHk011y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E81C2BCAF;
	Fri, 24 Apr 2026 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994973;
	bh=QSSazNTuZnTtnxSTAVV/omqIibexYYaHVv32vSM+ju0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHk011y5Tu5pSPb+NUNCFvmb5kjhWiRIURuxLfWuBxcJebDoo+a0ykEL9ct3C7Jey
	 +c82I/dZUSZsQx4+psoG9KYEMLmbiQAjitXTa8uhHpLxH0BPF9VLfK4FR3GHWRhelY
	 uj/wUW06lIxYLsNTnvCnj/cpymNNASFaJMbonzrgTEhq6yAUGBPn1icEiZuwX8JRiJ
	 wY7TridOAebUl6K/IcR4j9eSgxMGxxI1ABsVvIiB0PHuEYMEatHbPeQIvn9aHIOr1b
	 3rX0yZ1bL8AskzLOAY5FvcoD03cI/BUBqHhZtwTb0/+i9qsxBLkyVLiii4ZvLKbacJ
	 n4Ghapr0tMD3Q==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/paddr: prefetch struct page of the next region
Date: Thu, 23 Apr 2026 18:42:45 -0700
Message-ID: <20260424014245.1124-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423122340.138880-2-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 23 Apr 2026 20:23:37 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> In paddr mode with large nr_regions (20k+), damon_get_folio() dominates
> kdamond CPU time.  perf annotate shows ~98% of its samples on a single
> load: reading page->compound_head for page_folio().  DAMON samples a
> random PFN per region, so the access pattern scatters across the
> vmemmap with no locality that hardware prefetchers can exploit; every
> compound_head load misses to DRAM (~250 cycles).
> 
> Issue a software prefetch for the next region's struct page one
> iteration before it is needed.  In __damon_pa_prepare_access_check(),
> the next region's sampling_addr is picked eagerly (one iteration ahead
> of where its mkold will run) so the prefetched line is usable, and the
> first region of each epoch is handled with a one-off branch since it
> has no predecessor to have pre-picked its addr.  damon_pa_check_accesses()
> just prefetches based on sampling_addr already populated by the
> preceding prepare pass.
> 
> Two details worth calling out:
> 
>   - prefetchw() rather than prefetch(): compound_head (+0x8) and
>     _refcount (+0x34) share a 64B cacheline.  The subsequent
>     folio_try_get() / folio_put() atomics write _refcount, so bringing
>     the line in exclusive state avoids a later S->M coherence upgrade.
> 
>   - pfn_to_page() rather than pfn_to_online_page(): on
>     CONFIG_SPARSEMEM_VMEMMAP the former is pure arithmetic
>     (vmemmap + pfn), while the latter walks the mem_section table.  The
>     mem_section lookup itself incurs a DRAM miss for random PFNs, which
>     would serialize what is supposed to be a non-blocking hint - an
>     earlier attempt that used pfn_to_online_page() saw the prefetch
>     path's internal stall dominate perf (~91% skid on the converge
>     point after the call).  Prefetching an unmapped vmemmap entry is
>     safe: the hint is dropped without faulting.

Sashiko raises [1] a concern about this.  Could you please reply?

> 
> Concurrency: list_next_entry() and &list == &head comparisons are safe
> without locking because kdamond is the sole mutator of the region list
> of its ctx; external threads must go through damon_call() which defers
> execution to the same kdamond thread between sampling iterations
> (see documentation on struct damon_ctx and damon_call()).
> 
> Tested with paddr monitoring, max_nr_regions=20000, and stress-ng-vm
> consuming ~90% of memory across 8 workers: kdamond CPU further reduced
> from ~50% to ~40% of one core on top of the earlier damon_rand_fast()
> change.

This patch feels bit complicated.  I'm not sure if the performance gain is
really big enough to compensate the added complexity.  As I also asked to the
previous patch, could you please share more details about your use case?

I will review the code in detail after the above high level question and
concern are addressed.

[1] https://lore.kernel.org/20260423192534.300CEC2BCB2@smtp.kernel.org


Thanks,
SJ

[...]
