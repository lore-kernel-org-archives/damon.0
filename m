Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640205;
	b=0A1shOTzT9GQMBikvWk1vZd4jxD4p90QwYtW0KRaca2HjKLBHT0mIt9zMEe25RIDvl3q
	 mj7WW9MCKxIxPqVhT8sEL50evdf5ibcdyhvpqZJxM6aUEGkVebPqtYO/G42Qs9z5tru0v
	 enV/xdv/sFE5zH43kj4dum6Qgcowk3loTC55G/KTQmE5dZtwS7doC7YnwOYkMO3jHL810
	 5mkZVgtLqntSUKdZOIugfhQDej0o6+d+qeJGN7YpMPaksbCpiLczCjgxKLzmoBGMT1gzT
	 78NHr/vv5pMJ5YO4wBqvqZQfePC9QcA4JK/xuOb37kY1EE/EhPTgo2+qvY5z8Re2d4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oRfBKleHhU3BUp7ltu8uNKVynP2g/0Xp3jgnuf+J/Eo=;
	b=Gzx9f/qZCdeu+C5zo/luG6dD6PRsOdVkXWajREsVeqRdq5XlZwwpaqC/lw+dSzrf1v3k
	 EUSgMbmRX+VjzZ51oXLldRSp2VMwgA7Kw1M7XyiKgP1Kz6kdo+CNyAPmSDWU5/4VOmp+T
	 CdtSS3S+ESuDONX/7HM0q/tqnQUx5WEV3sqlI1xUS/6f5YKSNH3Rv5ohrLHqGZ22e6l28
	 gVD9Tp+bWvG5LytXA56UqC4VlYIDnaMEiJnHi7JtL3L+4VeOr9W4xK99eAoHRUSBdH7rx
	 XuIGYEJOCNhMCX0dC0rJLWy+OGrLIO1XHnnZKn/vnCEJYXgaLQyzxkAsUyhenMJQlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=rfiQyacv;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856C606A327
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4856C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=rfiQyacv
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-94961bfe1a0so38519785a.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640204; x=1795245004; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRfBKleHhU3BUp7ltu8uNKVynP2g/0Xp3jgnuf+J/Eo=;
        b=rfiQyacvp3EgNCXdwDeUxch62merHl04V1g5usq1KcZq+SM4p9bP9ccyiaW1aHwptw
         ZxIYscBoJBo7JWiQaRLQf76iI9v5ZfNC9/NEvZCSaoLvWy+jPTaFVSOa4nTTY70QXDIO
         iQ/079W+KGGvkau5+Pt11o6BsuPIIa8icR05xKeMjTtFqXh86/6m2hpzbySuR+G6L7hS
         5odX+fe13dB1WDG3is5lsLgBqYeGJIOWwj25MMapRxelS2zMZnJTSPWBGbiHF169La3K
         bVgMSx9jBmRmbyVxeIEpKBwOKhIE46SN0qmqhdzTPP169Ej2iPoZqXOA6kjd5XvL7jok
         3QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640204; x=1795245004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRfBKleHhU3BUp7ltu8uNKVynP2g/0Xp3jgnuf+J/Eo=;
        b=SeJA6KZ87wZTAp1Hk++uHtVY4N6ucf95ySceaXOPz9r1REWhFLjjZg20Nvdq4wwJM4
         omXH9COxdyBn2NVryrsbc3iEH4BdxE37jEgna3vz8qmyxGT9nUzwPfEjU4ToUXseLS4M
         cBw6q5fh1JYUYMlX6HeOFaZp5/7kYxa+NNAAllxGEYRjlbO8o3IskWdQbVcL/uWtLSdI
         ErbCjPuzfWWdNqvXo1vjfuWwEB0oSCGocFlWBl0BWLvF/wePd9/j4OrSJCvCPRqzmRvj
         /9lQmx8+V0Sa5WV0EKBpSwSVd5zgDvZC6gnD2DOZsmeEywovskaaKGR5NzW2AE3STNVh
         hODg==
X-Forwarded-Encrypted: i=1; AL+hErEw44ZwtDvESjhOA35eiPi6hXCueOyf0Xgx1NgfzJcw7MRJJaVIJTgXFqTYO3n9GfZOIUAEow==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2L98IHtjZnaptQcPy6xujUZ4eAHYIhjljN2kAlMrxjb34WlHd
	oJHLKeteEn6G88pQNZacBKiGbKes0rTdOdQ33FaJWXFAbIs3fyVJhe6RPn9nwgDe6CQ=
X-Gm-Gg: AYBFou3+u2EPbKprivqQrKzia1LqHyfjLqnciBmsg9g1ILlmBMIE8pXp3kS2DwGUOs4
	zHGywOTdA2snPyaCo3jomyyGxoa4YrAHwC+6pLwTDI+SE5jiHc8IPtZsgI+6KYGzc745oHxR1/o
	h1mtwTRFZhDYsv0j/rNZb6hFaEtR92V8lj2PvuWjC/aP90REnysUqtq4uYmoeo5kxCw64xRfqCw
	FKxE7PSfVVLvHSWrXYJj73FYrgFEQSnX+Jy7Lscu8PknV/q7esJKMKaePAuIY3/lWCLe13iesQw
	0eB/NtaHZI+pokUZ5516U52vibGNvHWu3pyBi7tjpqyGbdFBUyPPx3sW90YXxTR8whN1xk7Eh2I
	jkV3D7DGw1YoAbGfaFrUmezx6RvARBvtFSqhAG1PDw/pv8Wwc3Pdcxzzib32yG4GFz9qA5JYopw
	bfTfYPm/ChJcZ6GxfizPXV/NUUZOVYXO4uaqBqu5bf9j3Ci0XMkNOnsJ+cV1GBeU9qAQ1MJIgiq
	KxwBAYZdN7WNV61P4a5JvDViaTu91hF5302lxAxycIAFn5zpBroro4Ji7w3P1XTucJXSha4tr8K
	fOsnJk/DhXeOaviYnR+uUghn23JgLM87SnwlxoEDEAxzMKuHus9fud7OtTosGIHZ+nyKRY12SKQ
	9s8IB+6S5A7HlJ/U/
X-Received: by 2002:a05:620a:8398:b0:93c:ba88:cd65 with SMTP id af79cd13be357-9494b9e13damr803141185a.7.1794640204107;
        Fri, 13 Nov 2026 23:10:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:03 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
Date: Sat, 14 Nov 2026 02:09:37 -0500
Message-ID: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is phase 1 of the Private NUMA node series.

I will send v6 "Private Memory NUMA nodes" (phases 2 and 3) separately
next week for further discussion - but I pulled this out ahead to make
the core filtering mechanism easier to review.

The series is now broken up like so:

Phase 1: Introduce N_MEMORY_COMMON to define "general purpose" (common)
         memory as a concept separate from a node having memory as a
         topological feature (N_MEMORY).

         This phase is a no-op for existing systems, but creates the
         baseline for ensuring private node memory is default opted-out
         of being touched by MM (much like ZONE_DEVICE).


Phase 2: Introduce N_MEMORY_PRIVATE to define memory not part of the
         general purpose pool. With this we can introduce a minimum set
         of KUnit tests for the page allocator to demonstrate the
         isolation mechanism.

         At this point it will be possible for a driver to re-use the
         buddy allocator to make uniform order-N allocations.


Phase 3: Introduce feature bits (COMPACTION, RECLAIM, MEMPOLICY) which
         is the minimum viable set to allow userland to manage a private
         memory node via mbind() and migrate_pages().  

         This enables management of HBM and Coherent GPU memory via
         userland tools (numactl, cpuset) while protecting them from
         incidental allocation (no fallbacks, only explicit placement).

         The memory could even be hotplugged in ZONE_NORMAL and pinned.

Actual cover letter for this portion
====================================

N_MEMORY has two meanings today:
  1) this node has memory
  2) ordinary allocations and MM services can use this node's memory

The two are the same today. They stop being the same once a NUMA node
with memory isn't part of the general allocation pool.

This series adds N_MEMORY_COMMON for the second meaning and converts
the relevant N_MEMORY users accordingly. N_MEMORY continues reporting
memory topology - and some users (cpusets) still utilize it.

At the end of this series, N_MEMORY == N_MEMORY_COMMON, so the series
changes no behavior for existing systems. A later series will add memory
outside N_MEMORY_COMMON without having to audit every N_MEMORY user again.

Rather than add new hooks for page-table and pfn walkers, we consolidate
existing ZONE_DEVICE checks (page/folio_is_zone_device()) into a general
`page/folio_is_common_memory()` check.

The series is laid out as:

  1-3   helper functions to check node states and a folio's
        membership to a common memory node.  N_MEMORY_COMMON itself, and
        the `has_common_memory` sysfs ABI.
  4     zonelists: the fallback lists hold common nodes, and a node's
        __GFP_THISNODE list is built only for a common node
  5-21  N_MEMORY->N_MEMORY_COMMON and zone_device -> common_memory
        conversions. One component per patch.
  22    removal of first_memory_node/next_memory_node, which no longer
        have users after this series.

Each conversion restricts or adjusts:
  - an MM service (reclaim, compaction, KSM, collapse, etc)
  - an allocation target to common memory
  - accounting meant for ordinary allocations from common memory only

has_common_memory lists the same nodes as has_memory until memory
outside N_MEMORY_COMMON exists. It is added now so that userspace, such
as libnuma, can start choosing allocation targets from it, and so that
the meaning is fixed before anything makes the two lists differ.

first/next_memory_node() is replaced by first/next_node_state().

Gregory Price (Meta) (22):
  mm: add node-state-filtered zone and node iterators
  mm: publish and clear node memory states via helpers
  mm: introduce the common-memory node state
  mm/page_alloc: build zonelists from common memory
  mm/mempolicy: keep interleave and tmpfs mount policies on common memory
  mm: base hash distribution on common memory nodes
  mm/memory_hotplug: migrate offlined pages to common memory
  mm/memory-tiers: restrict demotion topology to common memory
  mm/ksm: restrict merging to common memory
  mm/khugepaged: restrict collapse to common memory
  mm/mempolicy: don't NUMA-hint folios outside common memory
  mm/damon: restrict DAMON-native folio operations to common memory
  mm/hugetlb: restrict pool growth to common memory
  mm/page_alloc: count common memory nodes for kswapd recovery
  mm/oom_kill: compare OOM constraints against common memory
  tty/sysrq: use common memory for the manual OOM zonelist
  mm/vmscan: restrict reclaim to common memory
  mm/compaction: restrict compaction to common memory
  mm/migrate: restrict move_pages() destinations to common memory
  PM: hibernate: size the image from common memory
  mm/khugepaged: base the recommended min_free_kbytes on common memory
  nodemask: remove the now-unused first_memory_node/next_memory_node

 Documentation/ABI/stable/sysfs-devices-node | 16 +++++++
 Documentation/mm/physical_memory.rst        |  8 +++-
 drivers/base/node.c                         |  2 +
 drivers/tty/sysrq.c                         |  3 +-
 include/linux/mmzone.h                      | 46 +++++++++++++++++++++
 include/linux/nodemask.h                    | 38 +++++++++++++----
 kernel/power/snapshot.c                     |  7 +++-
 mm/compaction.c                             | 14 +++----
 mm/damon/ops-common.c                       |  7 ++--
 mm/damon/vaddr.c                            |  2 +-
 mm/hugetlb.c                                | 44 +++++++++-----------
 mm/internal.h                               | 18 ++++++++
 mm/khugepaged.c                             | 12 ++++--
 mm/ksm.c                                    |  8 ++--
 mm/memory-tiers.c                           | 23 ++++++-----
 mm/memory_hotplug.c                         | 25 ++++++-----
 mm/mempolicy.c                              | 30 +++++++-------
 mm/migrate.c                                |  2 +-
 mm/mm_init.c                                | 16 ++++---
 mm/oom_kill.c                               |  7 ++--
 mm/page_alloc.c                             | 43 +++++++++++++------
 mm/vmscan.c                                 | 26 ++++++------
 22 files changed, 266 insertions(+), 131 deletions(-)

-- 
2.53.1-Meta

