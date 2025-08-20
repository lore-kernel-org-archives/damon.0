Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048952D94BF
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678014; cv=none; b=pG8tsXszNIzcMMRA6wn3qQmiSUmfdjhi3+LS20sLZ2lz3N2Ele+37nVEdzcvIuHiiK+2lpOWW1k6pGteenCthcp/9zGIStz6zw5nXg0b4MmEaYaIRa1M+PHUnSCm0h4el5izDAQ/rIqX0tY3NYaRfpEb7IXpLAfapCZpQjMfahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678014; c=relaxed/simple;
	bh=RTSTDEIBXHGr1nvHn0RVkrs9xBnaM+R+QX9RCAqUbBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBjksYZXMSxSHj5rPiigS7kbLvQ1qQe4qX9+YC6vBBCNFeX3HfEXLy0tAXjcWd1S5CbK9ZzdVO1MgNUJqxtZwJAsUVYu4wY/bxjJCfiDWfkDw9AD0kvEgAgKcIiDztAwWiul8nUc/Cqk0htj6R27nSfwqISs7tvMIzMN9zBXiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6K7B0ZWgz2gLG9;
	Wed, 20 Aug 2025 16:17:10 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C0FE1402CD;
	Wed, 20 Aug 2025 16:20:03 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 16:20:02 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH mm-next v2 00/12] mm/damon: support ARM32 with LPAE
Date: Wed, 20 Aug 2025 16:06:10 +0800
Message-ID: <20250820080623.3799131-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Changes in v2:
- set DAMOS_PAGEOUT, DAMOS_LRU_[DE]PRIO, DAMOS_MIGRATE_{HOT,COLD} and
  DAMOS_STAT stat in core address unit.
- pass ctx->min_region value to replace the original synchronization.
- drop the DAMOS stats type changes, keep them as 'unsigned long' type.
- separate add addr_unit support for DAMON_RECLAIM and LRU_SORT from
  this patch series.

Quanmin Yan (2):
  mm/damon: add damon_ctx->min_region
  mm/damon/core: prevent unnecessary overflow in
    damos_set_effective_quota()

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
 mm/damon/core.c                               |  75 +++++++------
 mm/damon/paddr.c                              | 106 +++++++++++-------
 mm/damon/sysfs.c                              |  41 ++++++-
 mm/damon/tests/core-kunit.h                   |  16 +--
 mm/damon/tests/vaddr-kunit.h                  |   2 +-
 mm/damon/vaddr.c                              |   2 +-
 10 files changed, 188 insertions(+), 95 deletions(-)

-- 
2.43.0

