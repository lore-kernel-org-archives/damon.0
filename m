Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E49376BC1
	for <damon@lists.linux.dev>; Mon,  2 Feb 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044257; cv=none; b=aa5fy8kGKon2rI3hWq8oQYCkbCDidB5+fi9QJvbvaQw0VCaVDmIpZ6Ak3dxeTjBHpIutF/lAcIBV80/wZ2t8RkrYD4u1Vp2EREfEdWKQpEyhIPVet8sqcEtfh7ajkesB4mJ3s4mySLn4Nm6IpvCJFExC13EW2gIAfSGEfgLpmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044257; c=relaxed/simple;
	bh=PemW5+E0ByOpbZfRs/RzR76KR2i1uAhftFP+ZfttKFw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCrO3CpHe2JIOsxyd8K/4HJJLecIy5xPdTOzEKSypvjM7mI+az7s57E50x7I8rEiao4bB9ovuLythaMqK9TrOyznljPSBxeyRLKb5jsrwSHRJmgYdx0Kv4NLDm92yTiaAucpqNTfrq+BI2Qt2ttgFzLXmVh2XLiJSuo0fRAZCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4V7Q5vfLzHnH7y;
	Mon,  2 Feb 2026 22:56:34 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 58F4840571;
	Mon,  2 Feb 2026 22:57:32 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 17:57:31 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <sj@kernel.org>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
Date: Mon, 2 Feb 2026 14:56:45 +0000
Message-ID: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Overview
----------

This patch set introduces a new dynamic mechanism for detecting hot applications
and hot regions in those applications.

Motivation
-----------

Currently DAMON requires the system administrator to provide information about
which application needs to be monitored and all the parameters. Ideally this
should be done automatically, with minimal intervention from the system
administrator.


Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
fragmentation and memory waste. For this reason, most application guides and
system administrators suggest to disable THP.

We would like to detect: 1. which applications are hot in the system and 2.
which memory regions are hot in order to collapse those regions.


Solution
-----------

     ┌────────────┐           ┌────────────┐
     │Damon_module│           │Task_monitor│
     └──────┬─────┘           └──────┬─────┘
            │         start          │
            │───────────────────────>│
            │                        │
            │                        │────┐
            │                        │    │ calculate task load
            │                        │<───┘
            │                        │
            │                        │────┐
            │                        │    │ sort tasks
            │                        │<───┘
            │                        │
            │                        │────┐
            │                        │    │ start kdamond for top 3 tasks
            │                        │<───┘
     ┌──────┴─────┐           ┌──────┴─────┐
     │Damon_module│           │Task_monitor│
     └────────────┘           └────────────┘


We calculate the task load base on the sum of all the utime for all the threads
in a given task. Once we get total utime, we use the exponential load average
provided by calc_load. The tasks that become cold, the kdamond will be stopped
for them.

In each kdamond, we start with a high min_access value. Our goal is to find the
"maximum" min_access value at which point the DAMON action is applied. In each
cycle, if no action is applied, we lower the min_access.

Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
collapse synchronously and avoid polluting khugepaged and other parts of the MM
subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
which needs the correct vm_flags_t set.

Benchmark
-----------

Asier Gutierrez (4):
   mm/damon: Generic context creation for modules
   mm/damon: Support for synchrounous huge pages collapse
   mm/damon: New module with hot application detection
   documentation/mm/damon: Documentation for the dynamic_hugepages 
module

 .../mm/damon/dynamic_hugepages.rst (new)      | 173 ++++++
 include/linux/damon.h                         |   1 +
 mm/damon/Kconfig                              |   7 +
 mm/damon/Makefile                             |   1 +
 mm/damon/dynamic_hugepages.c (new)            | 579 ++++++++++++++++++
 mm/damon/lru_sort.c                           |   6 +-
 mm/damon/modules-common.c                     |   7 +-
 mm/damon/modules-common.h                     |   5 +-
 mm/damon/reclaim.c                            |   5 +-
 mm/damon/vaddr.c                              |   3 +
 10 files changed, 778 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
 create mode 100644 mm/damon/dynamic_hugepages.c

-- 
2.43.0

