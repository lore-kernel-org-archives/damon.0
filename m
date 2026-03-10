Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F73BED7A
	for <damon@lists.linux.dev>; Tue, 10 Mar 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159939; cv=none; b=hWCSOEjVh2m3lalT0lo/hjt88vft7jNSgMx3LM05gY97jipyL0JCo+9+w6NfaJmaQqBrvIn2xH5r40P98PQxwD7iQnyORLE1LZ1YvNnOFYbZKbuB6addk66Gb4tjGxFLm+3QF/5xxzYZZW2zf83ofdyKyG4ZODgHOLrjg3zkOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159939; c=relaxed/simple;
	bh=NPmqrWUNP/Ios/o+cZrrqozk3FgzvNzdlTubO3Mx8ic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLFEReUPebOxLKQXe741zujEKj0SIF1AtEmSexuOP2RcDpRq94nd+IXvIEddIbx8fomt5LSD2mkOI36uJjDi8Ok5l/SL1VHV/uAKTjS1W1sxeNy6re3C4DjQtMpotYHa6pgPYT0dr1Ow0Hh/8FsEatNxdK0G1u4LssBb06O5wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fVfPM6plZzHnGgg;
	Wed, 11 Mar 2026 00:25:27 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id EE06D40086;
	Wed, 11 Mar 2026 00:25:33 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 19:25:33 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/4] mm/damon: Support hot application detections
Date: Tue, 10 Mar 2026 16:24:16 +0000
Message-ID: <20260310162420.4180562-1-gutierrez.asier@huawei-partners.com>
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
----------

This patch set introduces a new dynamic mechanism for detecting hot applications
and hot regions in those applications.

Motivation
-----------

Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
fragmentation and memory waste. For this reason, most application guides and
system administrators suggest to disable THP.


Solution
-----------

A new Linux kernel module that uses DAMON to detect hot regions and collapse
those regions into huge pages. The user supplies a set of PIDs using a module
parameter, and then, the module launches a new kdamond thread to monitor each
of the tasks.

In each kdamond, we start with a high min_access value. Our goal is to find the
"maximum" min_access value at which point the DAMON action is applied. In each
cycle, if no action is applied, we lower the min_access.

Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
collapse synchronously and avoid polluting khugepaged and other parts of the MM
subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
which needs the correct vm_flags_t set.


-----------
Changes in v2:
- Previously there was a mechanism to automatically detect hot applications.
  Based on SeongJae Park's feedback [1], this was removed from the module, leaving
  it entirely to the user space.
- All allocations now use kzalloc_obj.
- Since the user space provides now the list of pids to monitor, a commit_input
  parameter is added to allow changing the pids while the module runs.
- Renamed the module from dynamic_hugepages to hugepages

[1]: https://lore.kernel.org/all/20260211150902.70066-1-sj@kernel.org/

Asier Gutierrez (4):
  Damon_modules_new_paddr_ctx_target. This works  only for physical
    contexts. In case of virtual addresses, we should  duplicate the
    code.
  Support for huge pages collapse, which will be used by
    dynamic_hugepages module.
  This new module launches a new kdamond thread for each of them. The
    purpose is to detect hot regions in a given list of tasks and
    collapse them into huge pages.
  DAMON_HOT_HUGEPAGE documentation

 .../admin-guide/mm/damon/hugepage.rst (new)   | 186 ++++++++
 include/linux/damon.h                         |   1 +
 mm/damon/Kconfig                              |   7 +
 mm/damon/Makefile                             |   1 +
 mm/damon/hugepage.c (new)                     | 441 ++++++++++++++++++
 mm/damon/lru_sort.c                           |   5 +-
 mm/damon/modules-common.c                     |   6 +-
 mm/damon/modules-common.h                     |   4 +-
 mm/damon/reclaim.c                            |   5 +-
 mm/damon/vaddr.c                              |   3 +
 10 files changed, 650 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/hugepage.rst
 create mode 100644 mm/damon/hugepage.c

-- 
2.43.0

