Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8443375BE;
	Thu, 28 Aug 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401169; cv=none; b=ium4PCQ1AoOCjmen9gHp710XttZ9dMYrHsnl4tsHCvNfARBZeCiygVKiENpMChsJihoaBDyqgE8c06Y6gix5HdrVl1GnDyYSM7v2+BmBvnaUssJeShziIMjcr3OJ10E+bU1r4gJ078yej6MQTw2My3WInw6kHhMuB0HwnxaJCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401169; c=relaxed/simple;
	bh=XMisQHBbtJ+sybKmhuOJ1thay4xxeICp3JVlocPQ0yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LD9uaD9uDaQxo4yEjzV5NmuEX2ciMIYqwv/z4YE+3iC9WRWCKc9Lyct9eT/mJMkoeaPMtJbS3q39VUH4F2JKv+wWrMBgbTR8iYU3F4nR7QmABBbPsUkpT3onzleRZduodqxqxesR6gECiJ8HScbAeJWGC2zO49m9KSQSMY0uuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjBJ+byh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjBJ+byh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6573FC4CEEB;
	Thu, 28 Aug 2025 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401167;
	bh=XMisQHBbtJ+sybKmhuOJ1thay4xxeICp3JVlocPQ0yY=;
	h=From:To:Cc:Subject:Date:From;
	b=YjBJ+byhXwpLP4Nhb/QINTUZnWulaCZqKoSScXOQYIiSWNc7HmO7cgWUK9DCbhhER
	 9ZlhUogSBYJC80pUmFoEBloHTU+emuuYJmcxdwdYcqfRm72ypvzteOE4VqPUn1y3q3
	 YDUZkC/IB904rebcUDG/PVHxhT67w5yky0HneQLa/utuX+TLFEApV2vf3ZRUrndLaD
	 OUy26STkYDEnMQxAE6lku0/ArwqiTnmECyMMuCTqphOWeiJvLdh9uO0i5gROgT05Rv
	 P2gdISyoD9FiwQwtnP8wrMa8k00SgYlUgxbqp5g7iGz+L+DaS3VCyUnlnBvBmtMLEF
	 uNCS3R8Zm2Dqg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 00/11] mm/damon: support ARM32 with LPAE
Date: Thu, 28 Aug 2025 10:12:31 -0700
Message-Id: <20250828171242.59810-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, DAMON's physical address space monitoring only supported
memory ranges below 4GB on LPAE-enabled systems. This was due to
the use of 'unsigned long' in 'struct damon_addr_range', which is
32-bit on ARM32 even with LPAE enabled[1].

To add DAMON support for ARM32 with LPAE enabled, a new core layer
parameter called 'addr_unit' was introduced[2]. Operations set layer
can translate a core layer address to the real address by multiplying
the parameter value to the core layer address. Support of the parameter
is up to each operations layer implementation, though. For example,
operations set implementations for virtual address space can simply
ignore the parameter. Add the support on paddr, which is the DAMON
operations set implementation for the physical address space, as we have
a clear use case for that.

[1]https://lore.kernel.org/all/20250408075553.959388-1-zuoze1@huawei.com/
[2]https://lore.kernel.org/all/20250416042551.158131-1-sj@kernel.org/

Changes from v2
(https://lore.kernel.org/20250822093420.2103803-1-yanquanmin1@huawei.com)
- Fix 64bit division linking errors on certain 32bit arch configs.
- Re-posted by SJ.

Changes from v1
(https://lore.kernel.org/all/20250821105159.2503894-1-yanquanmin1@huawei.com/)
- Set dst->min_sz_region as src->min_sz_region in damon_commit_ctx().
- Fixed the incorrect 'min_region' in the commit message.

Changes from RFC v2
(https://lore.kernel.org/all/20250820080623.3799131-1-yanquanmin1@huawei.com/)
- Rename 'min_region' to 'min_sz_region'.
- Separate the overflow prevention in damos_set_effective_quota() from
  this series.
- Drop RFC tag.

Changes from RFC v1
(https://lore.kernel.org/all/20250813050706.1564229-1-yanquanmin1@huawei.com/)
- Set DAMOS_PAGEOUT, DAMOS_LRU_[DE]PRIO, DAMOS_MIGRATE_{HOT,COLD} and
  DAMOS_STAT stat in core address unit.
- Pass ctx->min_region value to replace the original synchronization.
- Drop the DAMOS stats type changes, keep them as 'unsigned long' type.
- Separate add addr_unit support for DAMON_RECLAIM and LRU_SORT from
  this patch series.

Quanmin Yan (1):
  mm/damon: add damon_ctx->min_sz_region

SeongJae Park (10):
  mm/damon/core: add damon_ctx->addr_unit
  mm/damon/paddr: support addr_unit for access monitoring
  mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
  mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
  mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
  mm/damon/paddr: support addr_unit for DAMOS_STAT
  mm/damon/sysfs: implement addr_unit file under context dir
  Docs/mm/damon/design: document 'address unit' parameter
  Docs/admin-guide/mm/damon/usage: document addr_unit file
  Docs/ABI/damon: document addr_unit file

 .../ABI/testing/sysfs-kernel-mm-damon         |   7 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  11 +-
 Documentation/mm/damon/design.rst             |  16 ++-
 include/linux/damon.h                         |   7 +-
 mm/damon/core.c                               |  70 ++++++-----
 mm/damon/paddr.c                              | 119 +++++++++++-------
 mm/damon/sysfs.c                              |  41 +++++-
 mm/damon/tests/core-kunit.h                   |  21 ++--
 mm/damon/tests/vaddr-kunit.h                  |   2 +-
 mm/damon/vaddr.c                              |   2 +-
 10 files changed, 204 insertions(+), 92 deletions(-)


base-commit: 398a6e2cbd43b92d9a5fa6b4020be72c2441babd
-- 
2.39.5
