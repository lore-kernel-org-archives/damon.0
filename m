Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B748293458
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586667; cv=none; b=lg/aO3yt082tLjvenpWMFlrMZ9etz0MvENKqDn/K0CC/vc2SAiUj0iQHJfT+XAOZz8++KTNfGtWALeQScSFRRwAe4rNyyN4Ps2uTlrEq5Ftf8X6ElJIut+AFUUFW94u/NYW3MbjTvjPdjdjgRtG7qnLBpKkLGzQqxmLPsgwGeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586667; c=relaxed/simple;
	bh=pVtueMVhJDICwZCqPGKYk9tuC5MsMYtVk9wC8zpv3L0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eix4FgMw6otRRD+oukeWq2dp7S5Rq+OiL0PdzibX2zFATSulp8AYkdBY6SGEThTlHTiQ6kauAyWSO/uKKNA0+YRV6Duju+mKBvJu+Nme3CiToW8BlmkG8yD+8OqLrHLGlBZT8RfKcYo1jTB15IqFRSvN9Uz2EkNxExdueqtoEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWSX550zDzJ46BT;
	Thu,  4 Jun 2026 23:04:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 6062F40569;
	Thu,  4 Jun 2026 23:04:25 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 18:04:24 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Thu, 4 Jun 2026 15:03:33 +0000
Message-ID: <20260604150338.501128-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Overview
========

This patch set introduces a new autotuning which allows to collapse
hot regions into hugepages.

Motivation
==========

Since TLB is a bottleneck for many systems[1], a way to optimize TLB
misses (or hits) is to use huge pages. Unfortunately, using "always"
in THP leads to memory fragmentation and memory waste. For this reason,
most application guides and system administrators suggest to disable THP.

Currently DAMON has DAMOS_HUGEPAGE, DAMOS_NONHUGEPAGE and DAMOS_COLLAPSE.
However, there is no way to tune the settings. It will collapse all the
hot regions that meet the access pattern. If the server is a bare metal
database or big data server, this will also lead to eventual fragmentation.

Additionally, currently THP is set globally. Ideally, there should be a
way to control which tasks can use huge pages.

Solution
========

DAMON has now a way to autotune some of the variables and adjust quotas
automatically, so that DAMON is fired only under the right circumstances.
It would be nice to have something similar, but for huge pages.

A new autotuning quota goal[2], damos_get_used_hugepage_mem_bp, is
introduced, which checks the huge page consumption to total anonymous
memory consumption. This new quota mechanism reuses current autotuning
architecture.

A new module is introduced to demonstrate the use of huge pages
collapse autotuning. The goal is to collapse hot regions of a given
process into huge pages. The module launches a kdamond thread for a
certain task provided by the user through monitored_pid module argument.
Hugepage goal autotuning will automatically adjust the aggressiveness
of hot region collapses.

This module also has a user autotuning knob which allows the user to
adjust the aggressiveness of page collapsing.

Benchmarks
==========

Huge page collapse autotuning was tested in a physicial machine with
MariaDB 10.5.29 and sysbench as the benchmark framework.

The hugepage module was set up in the following way:

# echo 1000 > min_age
# echo 1000 > quota_percentage_hugepage
# echo $(pidof mariadbd) > monitored_pid
# echo on > enabled

The goal was to achieve 5% of the total memory used as hugepage.

The table below shows the memory consumption over time. Gaps in the
timestamp means that no changes in the hugepage consumption happened
over that period of time.

+-----------+----------------+----------------+----------------------+
| timestamp | total mem used | huge page used | percentage hugepage  |
+-----------+----------------+----------------+----------------------+
| 0         | 4721188        | 0              | 0%                   |
| 28        | 4216848        | 4              | 0%                   |
| 37        | 4189912        | 38912          | 1%                   |
| 39        | 4195188        | 47104          | 1%                   |
| 55        | 4111612        | 51200          | 1%                   |
| 59        | 4137012        | 53248          | 1%                   |
| 60        | 4137052        | 55296          | 1%                   |
| 61        | 4156832        | 57344          | 1%                   |
| 62        | 4136920        | 59392          | 1%                   |
| 64        | 4109872        | 61440          | 1%                   |
| 65        | 4119108        | 63488          | 2%                   |
| 66        | 4145532        | 65536          | 2%                   |
| 67        | 4134544        | 67584          | 2%                   |
| 68        | 4158244        | 126976         | 3%                   |
| 69        | 4124276        | 204800         | 5%                   |
| 70        | 4100680        | 333824         | 8%                   |
| 71        | 4095540        | 462848         | 11%                  |
+-----------+----------------+----------------+----------------------+

Performance:
Baseline -> 18,162.45 transactions per second
Hugepage autotune -> 18,211.82 transactions per second


Eventually, the amount of huge pages reached 20%. This is consistent
with how quota goals autotuning work. We are more aggresive when the
quota is less than 10%, and less aggresive when the quota is higher.
At some point, the aggressiveness just fades and no more collapses
occur.

TODO
====
- Support page splitting for cold hugepages.

Patches Sequence
================
Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
Patch 2 -> damon_modules_new_vaddr_ctx_target
Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
           and the new VADDR ctx creation
Patch 4 -> Documentation

Changes from previous versions
==============================
RFC 2[3] -> RFC 3
  - Module moved to samples
  - Change autotune to monitor total memory and hugepage
  - Added performnace benchmarks to the cover letter
  - Bail out gracefully when trying to start disable
    the module after the monitored task exited. This 
    issue was discovered by sashiko [4]
  - Fixed typos and added quota_sz to the documentation
    discovered by sashiko [5]
RFC 1[6] -> RFC 2
  - Rebased into mm-new
  - Use DAMOS_COLLAPSE instead of DAMOS_HUGEPAGE
  - Fixed an issue that returned silently an error when the PID
    didn't exist in the system.[7]

[1] https://dl.acm.org/doi/pdf/10.1145/3307650.3322227
[2] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com
[3] https://lore.kernel.org/20260522145518.158910-1-gutierrez.asier@huawei-partners.com
[4] https://lore.kernel.org/20260522171210.900B11F00A3D@smtp.kernel.org
[5] https://lore.kernel.org/20260522171633.AAF5B1F000E9@smtp.kernel.org
[6] https://lore.kernel.org/20260430134139.2446417-1-gutierrez.asier@huawei-partners.com
[7] https://lore.kernel.org/all/20260430154338.E22E6C2BCB3@smtp.kernel.org/

Asier Gutierrez (4):
  mm/damon: Generalize ctx_target creation for damon_ops_id and add vaddr support
  mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
  mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
  Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management documentation

Asier Gutierrez (4):
  Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
    metric to measure the amount of huge page consumption to total
    anonymous memory consumption ratio.
  This patch adds a new function damon_modules_new_vaddr_ctx_target.
    Since ctx_target creation for vaddr and paddr is almost identical,
    the logic is extracted to a new function,
    damon_modules_new_ctx_target, and vaddr and paddr functions are left
    just as interfaces.
  This patch introduces a new DAMON module (SAMPLE_DAMON_HUGEPAGE) which
    collapses hot regions into huge pages.
  Add documentation for the DAMON-based Hugepage Management
    (DAMON_HUGEPAGE) feature, which automatically manages huge pages  by
    identifying hot memory regions and collapsing them back to regular
    pages. The documentation covers the module's features, operation,
    and all available module parameters.

 .../admin-guide/mm/damon/hugepage.rst (new)   | 271 ++++++++++++++
 include/linux/damon.h                         |   1 +
 mm/damon/Makefile                             |   8 +-
 mm/damon/core.c                               |  14 +
 mm/damon/modules-common.c                     |  31 +-
 mm/damon/modules-common.h                     |   3 +
 samples/damon/Kconfig                         |  12 +
 samples/damon/Makefile                        |   2 +
 samples/damon/hugepage.c (new)                | 350 ++++++++++++++++++
 9 files changed, 684 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/hugepage.rst
 create mode 100644 samples/damon/hugepage.c

-- 
2.43.0

