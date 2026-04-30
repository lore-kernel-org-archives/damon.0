Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A642846A
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556526; cv=none; b=c1oERdDlfWNXigTGR3IrQOBfzscqimb7WsSJILfTx8PyI6/sIuQdwkRQD9m1YGJSkyi34yWb2F2xJinvkCro8V79a+iGLzJ1DgBjJkZrmPCezFG4JjEkq+6vW/8AS3/NbFqnC9yYyAYQvVp63E9bpEuh8LNGKJczb3fOa53Ragg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556526; c=relaxed/simple;
	bh=TgdPdJvq8ZBAg/qn5mQ1wL3i4aBw8dt2H5vi1m8qu5k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbzivQOGy3KZEbOUhcJ/yQ+zOylc3Bk2D+eB8Tq0Uv12exCQ43jQXNT+t/YZ09GWfcZm9d2YlD3TuWABzjKj1uIZvi8PiFHGhb1cx0bJ/gZQExBe7qWE8vhIaS+YvoUHTX/L2XlaQYQoLw689HonKERVF6Mg1Uq3jOMdTa15/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5wLD6h7yzHnGhv;
	Thu, 30 Apr 2026 21:41:08 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C484640569;
	Thu, 30 Apr 2026 21:41:54 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 16:41:54 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Thu, 30 Apr 2026 13:41:35 +0000
Message-ID: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Overview
================

This patch set introduces a new autotuning which allows to collapse
hot regions into hugepages.

Motivation
================

Since TLB is a bottleneck for many systems, a way to optimize TLB
misses (or hits) is to use huge pages. Unfortunately, using "always"
in THP leads to memory fragmentation and memory waste. For this reason,
most application guides and system administrators suggest to disable THP.

Solution
================

A new autotuning quota goal[1], damos_get_used_hugepage_mem_bp, is
introduced, which checks the huge page consumption to total anonymous
memory consumption. This new quota mechanism reuses current autotuning
architecture.

A new module is introduced to demonstrate the use of huge pages
collapse autotuning. The module launches a kdamond thread for a 
certain task provided by the user through monitored_pid module argument.

This module also has a user autotuning knob which allows the user to
adjust the aggressiveness of page collapsing.

Benchmarks
================
In progress, will add them in the next RFC series.

TODO
================

- Since DAMOS_COLLAPSE is not in upstream and this is just a
  RFC, I have used DAMOS_HUGEPAGE instead. This will change
  to DAMOS_COLLAPSE in future series.

Patches Sequence
================
Patch 1 -> damon_modules_new_vaddr_ctx_target
Patch 2 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
           and the new VADDR ctx creation
Patch 4 -> Documentation

[1] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com

 .../admin-guide/mm/damon/hugepage.rst (new)   | 258 +++++++++++++
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 include/linux/damon.h                         |   1 +
 mm/damon/Kconfig                              |   7 +
 mm/damon/Makefile                             |   1 +
 mm/damon/core.c                               |  15 +
 mm/damon/hugepage.c (new)                     | 341 ++++++++++++++++++
 mm/damon/modules-common.c                     |  33 +-
 mm/damon/modules-common.h                     |   3 +
 9 files changed, 652 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/hugepage.rst
 create mode 100644 mm/damon/hugepage.c

-- 
2.43.0

