Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF743AB5BB
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407461; cv=none; b=TIFG+CA+P/MX7LYSIfW8xes6ep1lKZi/fLZjQPCvcnJ3iGvmHfOu1z8GA0bRdkcU8UY4L3U00hCE3yx0YeRte7cUybB9mvIWRKXOrL9Esiu2nqRIL0J2ZA2B2K/QVzg7C7wopQJCidrDfe+Sx8vebdJuzRhOXta5dz9lMrkNS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407461; c=relaxed/simple;
	bh=eQXxf1HV82HSdOFjs7U1aOJxW3fGqjSzmrTgTg4oHeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gatvGrfQw49aBuamJ7LIznb5/+pvmSeU6V4QvREYjn9lOIHzbT4vjYKpalfrBVikIb9zY1KkcE3rvuPRlk8wmBr9IY8h4jM2lzI8OaBU+f3Q//rNdGh8O7C3lfhJSe7nsnGLwu53lzBxTmEKdBhDHCsd4ZBGQBpihrNvTTL5QAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=bHIN3JX2; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="bHIN3JX2"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=ZDJSgUwHqq8jxXQvcm742CwOtIu0SZlIT9GfO+c8Z6k=;
	b=bHIN3JX2VTj6Lgnx1DhVZMbJrkK9eQ0rJDgt52+sZ0u+Tac3apEhlzLov3GZI0+ifhr+3YSKp
	wF4nV43ClFnYyCQQZNeMvX1R9OEGjyYwqysc0jR52XP0ZRMt5SuzdkHgzSY8rTgsbkk51UF09t3
	YWurbrwWeQgOZOmJJFxj5UU=
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gvWlv1mxwzYlvpK;
	Tue,  7 Jul 2026 14:39:07 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:39:06 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:39:05 +0800
From: tao <tao.wangtao@honor.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <willy@infradead.org>, <sj@kernel.org>, <kees@kernel.org>,
	<luizcap@redhat.com>, <zhangjiao2@cmss.chinamobile.com>, <kas@kernel.org>,
	<ljs@kernel.org>
CC: <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <jack@suse.cz>,
	<riel@surriel.com>, <harry@kernel.org>, <jannh@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
	<baoquan.he@linux.dev>, <nao.horiguchi@gmail.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<pfalcato@suse.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <damon@lists.linux.dev>, <shakeel.butt@linux.dev>,
	<ryncsn@gmail.com>, <jparsana@google.com>, <dvander@google.com>,
	<zhangji1@honor.com>, <wangzicheng@honor.com>, tao <tao.wangtao@honor.com>
Subject: [RFC PATCH v2 00/13] mm: rework anon_vma and remove anon_vma_chain
Date: Tue, 7 Jul 2026 14:32:55 +0800
Message-ID: <20260707063308.29176-1-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: TW002-1.hihonor.com (10.72.0.137) To TA003.hihonor.com
 (10.72.0.43)

Hi all,

Since v1 was relatively complex and difficult to extend, this version
adopts a simpler anon_vma implementation approach.


Replace the original anon_vma + anon_vma_chain multiple rbtree
structures with a depth-aware doubly linked list, and remove anon_vma_chain.


During rmap walks, vma_rmap_base(vma) is used to compute the page
address and look up the corresponding VMA from mm_mt:

  vma_rmap_base(vma) = vma->vm_start - vma->vm_pgoff * PAGE_SIZE

  page_address(vma, pgoff)
    = vma->vm_start + (pgoff - vma->vm_pgoff) * PAGE_SIZE
    = vma->vm_start - vma->vm_pgoff * PAGE_SIZE + pgoff * PAGE_SIZE
    = vma_rmap_base(vma) + pgoff * PAGE_SIZE

Since vma_rmap_base(vma) remains invariant across VMA merge and split
operations, VMA updates only need to adjust the VMA count of the
corresponding anon_vma. The anon_vma no longer directly tracks VMAs,
which eliminates the need for anon_vma_chain.

Process fork behaves like a fractal expansion of both tasks and
anon_vmas. A dedicated fractal_list records forked anon_vmas, while
descendant anon_vmas are derived from fork depth during rmap walks.
For this reason, the new design is named ANON_VMA_FRACTAL.

The depth is initialized to 0.
When a child is added, the root depth is set to 1.
A remap child has a depth of parent->depth + 1,
while a fork child has a depth of parent->depth + 2.
For example:
 1) A forks B and C:

	                   (1A)
	                  /    \
	                (3B)---(3C)

 2) B remaps D:

	                   (1A)
	                  /    \
	                (3B)   (3C)
	                /       /
	              (4D)-----o

 3) B forks E and F:

	                   (1A)--o
	                  /       \
	                (3B)      (3C)
	                /         /
	              (4D)       /
	              /         /
	            (5E)------(5F)

 4) C forks G:

	                   (1A)------------o
	                  /                 \
	                (3B)      (3C)       o
	                /         /  \      /
	              (4D)       /    \    /
	              /         /      \  /
	            (5E)------(5F)     (5G)

Only the root node A needs to traverse all descendants; non-root nodes
only traverse their own descendant nodes. For example:
- When rmap-ing A: first process A, then traverse all descendants
  B/D/E/F/C/G. A does not need to be traversed again.
- When rmap-ing B: first process B, then traverse its descendants
  D/E/F. Since C->depth <= B->depth, the rmap walk terminates at C.

The fractal_list remains stable across VMA merge and split operations.
It is updated only when anon_vmas are forked, remapped, or unlinked, and
is traversed during rmap walks.

On an Android device after boot, memory usage of vm_area_struct,
anon_vma, and anon_vma_chain is reduced by about 35 MB.

  struct              base(KB)  patch(KB)  patch_struct      saved(KB)
  --------------------------------------------------------------------
  vm_area_struct        110760     103837  vm_area_struct         6887
  anon_vma               19152       8576  anon_node             10576
  anon_vma_chain         17560          0  NA                    17560
  NA                         0        346  anon_semaphore         -346

lat_proc shows fork performance improves by about 15% at P=10.

Changes since v1:
- anon_vma now stores mm and rmap_base for VMA lookup, and only tracks
  the number of associated VMAs instead of directly tracking VMAs
- Use fractal_list + depth to maintain anon_vma topology and remove
  anon_vma_chain completely
- Keep folio->mapping storing anon_vma
- Preserve existing APIs and external callers unchanged while
  introducing ANON_RMAP_FOREACH_VMA() to unify anonymous rmap traversal
- Use vm_refcnt on leaf VMAs for rmap protection
- Optimize rwsem memory usage with shared semaphores

Patch layout:
  1-2: add CONFIG_ANON_VMA_FRACTAL and basic helpers
  3-7: implement anon_vma fractal infrastructure
  8: implement anonymous folio rmap
  9-10: replace anon_vma with anon_node
  11: use vm_refcnt on leaf VMAs for rmap protection
  12: optimize anon_vma memory usage with shared semaphores

v1:
https://lore.kernel.org/all/20260527110147.17815-1-tao.wangtao@honor.com/

tao (13):
  mm: add CONFIG_ANON_VMA_FRACTAL
  mm: implement helpers for ANON_VMA_FRACTAL
  mm: implement __anon_node_prepare for ANON_VMA_FRACTAL
  mm: implement anon_node_clone for ANON_VMA_FRACTAL
  mm: implement anon_node_fork_with_prev for ANON_VMA_FRACTAL
  mm: implement unlink_anon_nodes for ANON_VMA_FRACTAL
  mm: handle rmap_base changes for ANON_VMA_FRACTAL
  mm: implement anonymous folio rmap for ANON_VMA_FRACTAL
  mm: prepare anon_node replacement for ANON_VMA_FRACTAL
  mm: replace anon_vma with anon_node for ANON_VMA_FRACTAL
  mm: optimize rmap for ANON_VMA_FRACTAL with PVL
  mm: shared semaphores for ANON_VMA_FRACTAL
  mm: Enable CONFIG_ANON_VMA_FRACTAL by default

 include/linux/mm.h       |   2 +
 include/linux/mm_types.h |   2 +
 include/linux/rmap.h     |  56 ++++
 include/linux/rwsem.h    |  10 +
 mm/Kconfig               |  37 +++
 mm/internal.h            | 205 ++++++++++++
 mm/ksm.c                 |  19 +-
 mm/memory-failure.c      |   8 +-
 mm/mmap.c                |   7 +-
 mm/rmap.c                | 686 +++++++++++++++++++++++++++++++++++++--
 mm/vma.c                 |  76 ++++-
 mm/vma_init.c            |   2 +
 12 files changed, 1056 insertions(+), 54 deletions(-)

-- 
2.17.1

