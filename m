Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D33E95B5
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881212; cv=none; b=V6/Q4VSsTiLRs/bM7LdeE9zXS07aBwX8gJiZVUWShV047q2JeVUs1Lqs5RIqZUorTRRMYRqmDe4eaJgqdAMCTfB6SZYu8srRCyGGr9b/l07UZ9QA5OEy6Ts6kE/xdYK9GAhZZhpPZWjiksfuzR8msiO9G7ZEZnjdHzxM/dcovB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881212; c=relaxed/simple;
	bh=qoIFnxvb/u5KBE1R27C75C60Tasnec+gPdBlMUkMn2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R1CNfZ6A0OIbxCYMfj8j2YeBXP/rR57UJvER+TdvzKoihxH+5dMIHJw4VZce7KzuBNtouhRjTe3uxiPXPrdg+/gdwUO8zvDhCmOEqrb3yJ90JEtCvB9N02DT+XCPFFTilNmAG0QeushrC0QjfjBY0DmpCAODozkcqiBddeundgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=QdYLaf7r; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="QdYLaf7r"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=vvR/tuZayREkwIkwHZP/jPrTyMDEhSidNL4CuNjxao4=;
	b=QdYLaf7rRUY0eslf6/Dm3hgzaAxp8J54DWdegtqXyS3m6oBsFnah8p8LFKqKy9gqw3DSuBW3Z
	FWwRV66U5wdU0ilIb85tskEAYEdOXfnqg5rQ4TE0w4s4gJ0PL/ght2I4MYGaCT25aG/12gPQWWQ
	KDjiXKyb42/L4dBK7BnWDjo=
Received: from TW001.hihonor.com (unknown [10.77.229.151])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gQRcS4gXvzYl1Fx;
	Wed, 27 May 2026 19:05:44 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW001.hihonor.com
 (10.77.229.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:06:59 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:06:59 +0800
From: tao <tao.wangtao@honor.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<willy@infradead.org>, <sj@kernel.org>, <kees@kernel.org>,
	<luizcap@redhat.com>, <zhangjiao2@cmss.chinamobile.com>,
	<tao.wangtao@honor.com>, <kas@kernel.org>, <ljs@kernel.org>
CC: <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <jack@suse.cz>,
	<riel@surriel.com>, <harry@kernel.org>, <jannh@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <nao.horiguchi@gmail.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <pfalcato@suse.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<damon@lists.linux.dev>, <shakeel.butt@linux.dev>, <ryncsn@gmail.com>,
	<21cnbao@gmail.com>, <jparsana@google.com>, <dvander@google.com>,
	<zhangji1@honor.com>, <wangzicheng@honor.com>
Subject: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
Date: Wed, 27 May 2026 19:01:32 +0800
Message-ID: <20260527110147.17815-1-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: TW006-1.hihonor.com (10.77.215.153) To TA003.hihonor.com
 (10.72.0.43)

TL;DR
-----

This series introduces ANON_VMA_LAZY, which defers anon_vma creation
until it is actually required.

- anon_vma memory reduced by ~92-97%, anon_vma_chain reduced by ~50-57%  
- rmap operations on ANON_VMA_LAZY VMAs do not require anon_vma locking

Background
----------

Currently anon_vma structures are created eagerly when anonymous VMAs
are initialized. However, many VMAs never participate in fork or rmap
operations that require anon_vma chains, so the allocated anon_vma and
anon_vma_chain objects are often unnecessary.

Design overview
---------------

ANON_VMA_LAZY defers anon_vma allocation until it is actually needed
(for example during fork). VMAs that never participate in sharing can
avoid creating anon_vma structures entirely.

Before an anon_vma exists, rmap operations rely directly on VMA
information, so no anon_vma locking is required. An anon_vma is created
and linked only when sharing semantics are required.

This series introduces anon_rmap helpers to make rmap less dependent on
direct anon_vma access. It also introduces anon_vma_tree_t as a container
to support both the lazy and the existing anon_vma layouts.

Once a VMA becomes associated with an anon_vma, the normal behavior
remains unchanged.

Memory impact
-------------

Preliminary measurements show significant reductions in anon_vma-related
slab allocations.

After boot:

Object            | Before (active KB) | After (active KB) | Change
vm_area_struct    | 117035             | 118176            | +1.0%
anon_vma_chain    | 18865.8            | 8112.06           | -57.0%
anon_vma          | 20426.4            | 613.75            | -97.0%

After launching 24 apps:

Object            | Before (active KB) | After (active KB) | Change
vm_area_struct    | 196873             | 197345            | +0.2%
anon_vma_chain    | 31477.1            | 15576.8           | -50.5%
anon_vma          | 33280              | 2648.12           | -92.0%

Simple fork microbenchmarks also show a slight improvement in fork
performance, since child VMAs do not need to allocate anon_vma
structures during fork.

Feedback and suggestions are welcome.


tao (15):
  mm/rmap: introduce anon_rmap APIs for anonymous folios
  mm: convert anon_vma rmap APIs to anon_rmap
  mm: introduce anon_vma_tree_t for multiple anon_vma topologies
  mm: switch to anon_vma_tree_t APIs in preparation for ANON_VMA_LAZY
  mm: add CONFIG_ANON_VMA_LAZY and folio helpers
  mm: add CONFIG_VMA_REF and VMA helpers
  mm: replace direct FOLIO_MAPPING_ANON usage with helpers
  mm: prepare rmap infrastructure for ANON_VMA_LAZY
  mm: implement ANON_VMA_LAZY rmap semantics
  mm: defer anon_vma creation with ANON_VMA_LAZY
  mm: handle ANON_VMA_LAZY in huge page operations
  mm: handle ANON_VMA_LAZY during migration
  mm: support setup and upgrade of ANON_VMA_LAZY folios
  mm: support merging of ANON_VMA_LAZY VMAs
  mm: enable CONFIG_ANON_VMA_LAZY on arm64 and x86_64

 arch/arm64/Kconfig         |   1 +
 arch/x86/Kconfig           |   1 +
 fs/proc/page.c             |   6 +-
 include/linux/mm.h         |  38 ++
 include/linux/mm_types.h   |   9 +-
 include/linux/page-flags.h |  34 +-
 include/linux/pagemap.h    |   2 +-
 include/linux/rmap.h       | 165 ++++++++-
 mm/Kconfig                 |  22 ++
 mm/damon/ops-common.c      |   4 +-
 mm/debug.c                 |   2 +-
 mm/debug_vm_pgtable.c      |   2 +-
 mm/gup.c                   |   6 +-
 mm/huge_memory.c           |  16 +-
 mm/internal.h              | 171 +++++++++
 mm/khugepaged.c            |  13 +-
 mm/ksm.c                   |  43 ++-
 mm/memory-failure.c        |  11 +-
 mm/memory.c                |  19 +-
 mm/migrate.c               | 126 ++++---
 mm/mmap.c                  |  15 +-
 mm/mremap.c                |   4 +-
 mm/page_idle.c             |   2 +-
 mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
 mm/vma.c                   |  76 ++--
 mm/vma.h                   |   4 +-
 mm/vma_exec.c              |   2 +-
 mm/vma_init.c              |   1 +
 28 files changed, 1279 insertions(+), 206 deletions(-)

-- 
2.17.1

