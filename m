Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830A2BE055
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057161; cv=none; b=DP5Q6GRWcGxgn4X8+0H7tmOfSIVPBXaFof0Vv7cf+sL25qSS3Vlzpu95f2/ACOeH1gvPF2DFunM8gRSUonn8qSyG9Xyhx+CFr2MemTikAJRtrqD7Rk28rbaDUYb7jNC0VQLcLe3IK8QqQ+l0V8GAs/0h7gzfWS8SEqMz5VppOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057161; c=relaxed/simple;
	bh=MlAUVLDnhKNoUBgjgBXR8tg4lXbCEv2IRdsbvu5a6P0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=famwzRAgFxKB9paD472VozP7op6cOs6dz3HHp0r6HghW8grL0clWqkoPEaH9zZ72tRtqiLc2JVLa5Mw4NzhBDFprOf77o+TJkGflSs8z2MCGQ1Gz5Li/l5NwbDHA4Pp0y4vF5yNA8gzXgMPQxfhRBNn5j7zPocO1tCUSzf9Imfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c1vV13byRz2Cg6F;
	Wed, 13 Aug 2025 11:48:09 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 071BA1A0188;
	Wed, 13 Aug 2025 11:52:29 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:28 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
Date: Wed, 13 Aug 2025 13:06:50 +0800
Message-ID: <20250813050706.1564229-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Previously, DAMON's physical address space monitoring only supported
memory ranges below 4GB on LPAE-enabled systems. This was due to
the use of 'unsigned long' in 'struct damon_addr_range', which is
32-bit on ARM32 even with LPAE enabled.

Implements DAMON compatibility for ARM32 with LPAE enabled.

Patches 01/16 through 10/16 are from the mailing list[1], add a new core
layer parameter called 'addr_unit'. Operations set layer can translate a
core layer address to the real address by multiplying the parameter value
to the core layer address.

Patches 11/16 through 14/16 extend and complement patches 01~10, addressing
various issues introduced by the addr_unit implementation.

Patches 15/16 and 16/16 complete native DAMON support for 32-bit systems.

[1] https://lore.kernel.org/all/20250416042551.158131-1-sj@kernel.org/

Quanmin Yan (6):
  mm/damon: add addr_unit for DAMON_RECLAIM and LRU_SORT
  mm/damon: add damon_ctx->min_region and damon_target->min_region
  mm/damon/sysfs: ensure valid addr_unit setting in
    damon_sysfs_apply_inputs()
  mm/damon/core: convert sz to byte units when updating state
  mm/damon: the byte statistics data type in damos_stat uses unsigned
    long long
  mm/damon/core: handle quota->esz overflow issues

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

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
 Documentation/admin-guide/mm/damon/usage.rst  | 11 ++-
 Documentation/mm/damon/design.rst             | 16 +++-
 include/linux/damon.h                         | 24 +++--
 mm/damon/core.c                               | 80 +++++++++++-----
 mm/damon/lru_sort.c                           | 16 +++-
 mm/damon/modules-common.c                     |  5 +-
 mm/damon/modules-common.h                     |  6 +-
 mm/damon/paddr.c                              | 95 ++++++++++++-------
 mm/damon/reclaim.c                            | 16 +++-
 mm/damon/stat.c                               |  2 +-
 mm/damon/sysfs-schemes.c                      | 12 +--
 mm/damon/sysfs.c                              | 27 ++++++
 13 files changed, 226 insertions(+), 91 deletions(-)

-- 
2.34.1

