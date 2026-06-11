Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC43D8135
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190229; cv=none; b=K5n4mI77D0Cp6q0tiYXYPwhzqnp7uwLnIInBx/BeNeAQd4bOl2gNGlPXZl822ciGyW5i+QwYs+dj9bkuQkXesuaW9Myv8qTHL3VRYud1/IYrwBBIDcO6DjKf46zCshrGeUywvaZl5lYPdFjByiKzTWZq0ZTa+T/Fzb95yFsXsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190229; c=relaxed/simple;
	bh=Cr+FnV+6P869Bx1t0VKOAi6C83mgys+Yzsg18csX/YI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZXdIUniNlGVolV7UTjY7IoS8kqwsB2yJwaX66PbL3AGHMfEPvpoixOOcPGAzUxATgAaU++Rrnu/WXiRmPRFH8iJ71UoASIiTKRv4BwinwigIflaBkcC+iD3ot+vxENqSmIWWM9uoybEkquhRT7rHAydUPgIdVNno0F/tJTVf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gbm9l00MfzJ467c;
	Thu, 11 Jun 2026 23:03:22 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 405AD40569;
	Thu, 11 Jun 2026 23:03:38 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jun 2026 18:03:37 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v4 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Thu, 11 Jun 2026 15:02:40 +0000
Message-ID: <20260611150244.3454699-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
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

A new autotuning quota goal[2], damos_hugepage_mem_bp, is introduced,
which checks the huge page consumption to total memory consumption. This
new quota mechanism reuses current autotuning architecture.

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
Since the database was not very big, we may not be able to achieve
high amount of huge pages per total memory consumption ratio.

The table below shows the memory consumption over time. Gaps in the
timestamp means that no changes in the hugepage consumption happened
over that period of time in MB.

+-----------+----------------+----------------+----------------------+
| timestamp | total mem used | huge page used | percentage hugepage  |
+-----------+----------------+----------------+----------------------+
| 0         | 3044.988281    | 0              | 0%                   |
| 22        | 3160.207031    | 2              | 0.06%                |
| 30        | 3250.90625     | 4              | 0.12%                |
| 69        | 3781.238281    | 6              | 0.16%                |
| 71        | 3822.226563    | 8              | 0.21%                |
| 72        | 3846.578125    | 10             | 0.26%                |
| 73        | 3852.402344    | 12             | 0.31%                |
| 74        | 3868           | 14             | 0.36%                |
| 75        | 3881.84375     | 104            | 2.68%                |
| 275       | 4194.175781    | 106            | 2.52%                |
+-----------+----------------+----------------+----------------------+

After second 275, no more pages are collapsed into hugepages

Performance:
Baseline -> 18,124.1 transactions per second
Hugepage autotune -> 18,163.64 transactions per second

TODO
====
- Support page splitting for cold hugepages.

Patches Sequence
================
Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
Patch 2 -> Module that demonstrates how to use
           DAMOS_QUOTA_HUGEPAGE_MEM_BP and DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
Patch 3 -> Support for DAMOS_QUOTA_HUGEPAGE_MEM_BP in sysfs-schemes
Patch 4 -> Documentation

Changes from previous versions
==============================
RFC 3[3] -> RFC 4
  - Simplified the module
  - Removed unnecessary parameters
  - Renamed DAMOS_QUOTA_HUGEPAGE_MEM_BP to unify the
    naming style
  - Switched to DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
  - Updated the documentation
  - Removed new interface for context creation with
    DAMON_OPS_VADDR

RFC 2[4] -> RFC 3
  - Module moved to samples
  - Change autotune to monitor total memory and hugepage
  - Added performnace benchmarks to the cover letter
  - Bail out gracefully when trying to start disable
    the module after the monitored task exited. This
    issue was discovered by sashiko [5]
  - Fixed typos and added quota_sz to the documentation
    discovered by sashiko [6]
RFC 1[7] -> RFC 2
  - Rebased into mm-new
  - Use DAMOS_COLLAPSE instead of DAMOS_HUGEPAGE
  - Fixed an issue that returned silently an error when the PID
    didn't exist in the system.[8]

[1] https://dl.acm.org/doi/pdf/10.1145/3307650.3322227
[2] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com
[3] https://lore.kernel.org/20260604150338.501128-1-gutierrez.asier@huawei-partners.com
[4] https://lore.kernel.org/20260522145518.158910-1-gutierrez.asier@huawei-partners.com
[5] https://lore.kernel.org/20260522171210.900B11F00A3D@smtp.kernel.org
[6] https://lore.kernel.org/20260522171633.AAF5B1F000E9@smtp.kernel.org
[7] https://lore.kernel.org/20260430134139.2446417-1-gutierrez.asier@huawei-partners.com
[8] https://lore.kernel.org/all/20260430154338.E22E6C2BCB3@smtp.kernel.org/

Asier Gutierrez (4):
  mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
  mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
  mm/damon/sysfs: support hugepage_mem_bp quota goal metric
  Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management

 .../admin-guide/mm/damon/hugepage.rst (new)   | 113 ++++++++++
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 include/linux/damon.h                         |   2 +
 mm/damon/core.c                               |  14 ++
 samples/damon/Kconfig                         |  12 +
 samples/damon/Makefile                        |   1 +
 samples/damon/hugepage.c (new)                | 207 ++++++++++++++++++
 7 files changed, 350 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/hugepage.rst
 create mode 100644 samples/damon/hugepage.c

-- 
2.43.0
