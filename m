Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7013ACA42
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622274; cv=none; b=VRnFDfxmMZwi7mSc+7gYtqelQvBjvL7Xwi7TRnI8wPPX3F7J3Dgmpaur0h67YUiVJVHhsO3iH/TecFa2MG7uJ0xBuHBxIToLlxy14AMTgD2kMTZrA6tKyPZ7oFIl45MJwq9NSDN+da0ZsLVE0PCnL/i+sQ7owcm/n/OonIUrWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622274; c=relaxed/simple;
	bh=B5PCuOjn6HhSdafHpUxiEFVzB2DhTpZLEFGJkP4kcP8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DX4tqfT6sJkzlNRmgCV0JSAlRxqZwpTaszp4pjnG7smRsy5/YX8FgV5NySY6iWVterrw3lUYR3OKBtlbYpfd1yl8rGwrqwzD1AFEzwOOww7YbQObfFZt7ZRGkRuOOvmRXP2Fihi8fOUaYx81WtadjStHt4EZHuQV7BgBV3Wekgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gfqy60jpzzHnGfD;
	Tue, 16 Jun 2026 23:03:58 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B38440574;
	Tue, 16 Jun 2026 23:04:14 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:04:14 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Tue, 16 Jun 2026 15:03:13 +0000
Message-ID: <20260616150316.580819-1-gutierrez.asier@huawei-partners.com>
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

A new autotuning quota goal[2], damos_hugepage_mem_bp, is introduced,
which checks the huge page consumption to total memory consumption. This
new quota mechanism reuses current autotuning architecture.

A new sample module (SAMPLE_DAMON_HPAGE) is introduced to demonstrate
the use of huge pages collapse autotuning. The goal is to collapse hot
regions of a given process into huge pages. The sample module launches
a kdamond thread for a certain task provided by the user through
taget_pid module argument. Hugepage goal autotuning will automatically
adjust the aggressiveness of hot region collapses.

This sample module also has a user autotuning knob which allows the
user to adjust the aggressiveness of page collapsing.

Benchmarks
==========

Huge page collapse autotuning was tested in a physicial machine with
MariaDB 10.5.29 and sysbench as the benchmark framework.

The hugepage module was set up in the following way:

# echo 1000 > min_age
# echo 1000 > quota_percentage_hugepage
# echo $(pidof mariadbd) > taget_pid
# echo on > enabled

The goal was to achieve 5% of the total memory used as hugepage.
Since the database was not very big, we may not be able to achieve
high amount of huge pages per total memory consumption ratio.

The table below shows the memory consumption over time. Timestamp is in
second and the memory usage in is MBytes. Gaps in the timestamp means
that no changes in the hugepage consumption happened over that period
of time in MB. The total used memory is calculated as
mem_total - mem free. The huge page used is calculated as
huge_page_anon + huge_page_shmem + huge_page_file. The table also
shows the huge pages to total memory ratio.

Hugepage autotune benchmark:
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


THP (always) benchmark:
+-----------+----------------+----------------+---------------------+
| timestamp | total mem used | huge page used | percentage hugepage |
+-----------+----------------+----------------+---------------------+
|         1 |    4489.320313 |            184 |         4.098615986 |
|        15 |    4581.871094 |            214 |         4.670580984 |
|        30 |    4757.742188 |            376 |         7.902908253 |
|        45 |    4937.574219 |            558 |         11.30109595 |
|        60 |    5147.867188 |            728 |         14.14177898 |
|        75 |      5407.0625 |            918 |         16.97779524 |
|        95 |    5668.796875 |           1040 |         18.34604455 |
|       105 |    5723.839844 |           1056 |         18.44915352 |
|       115 |     5736.84375 |           1072 |         18.68623317 |
|       125 |    5732.042969 |           1088 |         18.98101612 |
|       186 |    5753.601563 |           1184 |         20.57841488 |
|       246 |    5746.398438 |           1280 |         22.27482159 |
|       306 |    5752.128906 |           1376 |         23.92157795 |
|       367 |      5772.5625 |           1472 |         25.49994045 |
|       427 |    5832.019531 |           1568 |         26.88605536 |
|       488 |    5813.246094 |           1664 |         28.62428277 |
|       548 |    5807.621094 |           1760 |         30.30500736 |
|       598 |    5841.253906 |           1822 |         31.19193292 |
|       669 |    5982.160156 |           1854 |         30.99214918 |
|       931 |    5946.605469 |           1868 |         31.41287933 |
|       981 |    6020.207031 |           1896 |         31.49393352 |
|       991 |    5988.445313 |           1910 |         31.89475566 |
|      1011 |    5988.570313 |           1926 |         32.16126554 |
|      1032 |    6016.039063 |           1936 |         32.18064211 |
|      1575 |    6057.289063 |           1968 |         32.48978181 |
|      1606 |    6026.167969 |           2000 |         33.18858702 |
+-----------+----------------+----------------+---------------------+
I ignored some points to make the table shorter. Anyway, the amount
of memory consumption, total and huge pages, is a lot higher than
with DAMON hugepage autotuning.


Performance:
Baseline (no THP, module off) -> 18,162.45 transactions per second
Hugepage autotune -> 18,211.82 transactions per second (+0.27% improvement)
THP always -> 18,388.3 (+1.24%)
THP madvise -> 18,179.25 (+0.09%)

Improvement is due to lower TLB misses

Patches Sequence
================
Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
Patch 2 -> Module that demonstrates how to use
           DAMOS_QUOTA_HUGEPAGE_MEM_BP and DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
Patch 3 -> Support for DAMOS_QUOTA_HUGEPAGE_MEM_BP in sysfs-schemes

Changes from previous versions
==============================
RFC 4[3] -> v1
  - Renamed config to SAMPLE_DAMON_HPAGE, file to hpage.c and
    functions to damon_sample_hpage_...
  - Make the module depend on TRANSPARENT_HUGEPAGE, since
    the module will need some THP functions anyway
  - Removed documentation, since this is just a sample module
  - Removed DAMOS_QUOTA_HUGEPAGE_MEM_BP from
    damos_sysfs_add_quota_score
  - Added a short description of the module in Kconfig

RFC 3[4] -> RFC 4
  - Simplified the module
  - Removed unnecessary parameters
  - Renamed DAMOS_QUOTA_HUGEPAGE_MEM_BP to unify the
    naming style
  - Switched to DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
  - Updated the documentation
  - Removed new interface for context creation with
    DAMON_OPS_VADDR

RFC 2[5] -> RFC 3
  - Module moved to samples
  - Change autotune to monitor total memory and hugepage
  - Added performnace benchmarks to the cover letter
  - Bail out gracefully when trying to start disable
    the module after the monitored task exited. This
    issue was discovered by sashiko [6]
  - Fixed typos and added quota_sz to the documentation
    discovered by sashiko [7]

RFC 1[8] -> RFC 2
  - Rebased into mm-new
  - Use DAMOS_COLLAPSE instead of DAMOS_HUGEPAGE
  - Fixed an issue that returned silently an error when the PID
    didn't exist in the system.[9]

[1] https://dl.acm.org/doi/pdf/10.1145/3307650.3322227
[2] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com
[3] https://lore.kernel.org/20260611150244.3454699-1-gutierrez.asier@huawei-partners.com
[4] https://lore.kernel.org/20260604150338.501128-1-gutierrez.asier@huawei-partners.com
[5] https://lore.kernel.org/20260522145518.158910-1-gutierrez.asier@huawei-partners.com
[6] https://lore.kernel.org/20260522171210.900B11F00A3D@smtp.kernel.org
[7] https://lore.kernel.org/20260522171633.AAF5B1F000E9@smtp.kernel.org
[8] https://lore.kernel.org/20260430134139.2446417-1-gutierrez.asier@huawei-partners.com
[9] https://lore.kernel.org/all/20260430154338.E22E6C2BCB3@smtp.kernel.org/

Asier Gutierrez (3):
  mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
  mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
  mm/damon/sysfs: support hugepage_mem_bp quota goal metric

 include/linux/damon.h    |  2 ++
 mm/damon/core.c          | 14 ++++++++++++++
 mm/damon/sysfs-schemes.c |  4 ++++
 samples/damon/Kconfig    | 14 ++++++++++++++
 samples/damon/Makefile   |  1 +
 5 files changed, 35 insertions(+)

-- 
2.43.0

