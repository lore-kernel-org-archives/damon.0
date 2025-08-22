Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB92F3C37
	for <damon@lists.linux.dev>; Fri, 22 Aug 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856092; cv=none; b=V4CiTJm0NYC5trQaS87Qa7xU2YVZnKYDo9F6jFcMA+bvp/HXM/elCswvMokFNOI5imEsKBYA+j6pEJX1sq4VqR4D/wA2EBt2WLBqsyJ46ruMW1vBpy6xUaprqpnT4uwnnRsWFqosOJ7I7sVORuPaJpmg9/vHnJJt18Ba25VrPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856092; c=relaxed/simple;
	bh=nHKqwlGT6zAbmYyo88tFT/84/vMlx+N7OikR/tlVpus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cuDvEC7UTgZNFDtCMepZ2BkPSsfdLH7kDg9pFaYcJhyeEIgqLipSH4RG/C83k63gvbVWQD9Zb32U7g3BzLspqBPvuQ5v+kxrV25Ot92N7XpcU11K96tJmRUI9CMQgHqhMhqlfSXJCpKLFmymUbzob9kqAo2FyVdI3/YTFD8VvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c7Zy60S4nzdcSB;
	Fri, 22 Aug 2025 17:43:42 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id EB2C31401E9;
	Fri, 22 Aug 2025 17:48:05 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 17:48:05 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 00/11] mm/damon: support ARM32 with LPAE
Date: Fri, 22 Aug 2025 17:34:08 +0800
Message-ID: <20250822093420.2103803-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

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
 mm/damon/core.c                               |  70 +++++++-----
 mm/damon/paddr.c                              | 106 +++++++++++-------
 mm/damon/sysfs.c                              |  41 ++++++-
 mm/damon/tests/core-kunit.h                   |  21 ++--
 mm/damon/tests/vaddr-kunit.h                  |   2 +-
 mm/damon/vaddr.c                              |   2 +-
 10 files changed, 191 insertions(+), 92 deletions(-)

-- 
2.43.0

