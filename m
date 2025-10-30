Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C052FD681
	for <damon@lists.linux.dev>; Thu, 30 Oct 2025 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790043; cv=none; b=FeUWkTs1s4pBfA5pfR/VB7gWHtA8iHL/DwyM2Xu8eXvuaJ3NYmnD4xMUNeWdJ+12R45EQeM8uumpe5HEhOGPWYrMG7BbANaUQr+/vWZ2rpON7Re49OSpip5O0fDgZHQTXJCYX9M7JTRpDP6tC5BpM3x3uZe9vO1znHKS8TVMkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790043; c=relaxed/simple;
	bh=6wFQctrH9Emy+DRHKHrRYkLJTyaBAsLrNSRHmSQcQSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6N9SioxOzvXKN5PyZwBJFwTU3n5LVYvRDunFo94XNpwy/VyfcP4hdrRdPzwhqj+BFxa0jHEUGcdzcE38uhfq+jHGLMBwVrVT0pj5pz2ZB9YJ4bpNv5fPyo9ntTnQSKBeOkZUh3EZS+oSbTHk7O8KMs9iS/JQHz+RLMbDVv7Nkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=O41fgqk8; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="O41fgqk8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CF/pzoLZDqGYNJEmki4gmVAam6PfVGZJ9Q6V3dL36n8=;
	b=O41fgqk84/0l1v2gXv3gyw/kKurEfhYPJyQaDFb2ozXRL7OEsXhnIcxw8tT3pxZWlE4aWkSCW
	XWuUMZrIKcRRArKU1SnY37G+KIEApS12ZLMR2bGE0s+A6QWrUNadmkkEHdhTR98POkC2xcE3s3J
	8/WMFcgtEOzj7zodrQanzRg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cxnXq4fwRz12LFQ;
	Thu, 30 Oct 2025 10:06:35 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A8B1140279;
	Thu, 30 Oct 2025 10:07:12 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:07:11 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 0/2] mm/damon: fixes for the jiffies-related issues
Date: Thu, 30 Oct 2025 10:07:44 +0800
Message-ID: <20251030020746.967174-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to
make jiffies wrap bugs appear earlier. However, this may cause the
time_before() series of functions to return unexpected values, resulting
in DAMON not functioning as intended. Meanwhile, similar issues exist
in some specific user operation scenarios.

This patchset addresses these issues. The first patch is about the
DAMON_STAT module, and the second patch is about the core layer's sysfs.

Changes from v1
(https://lore.kernel.org/all/20251028061927.1378746-1-yanquanmin1@huawei.com/)
- Added commit information describing another similar issue. (found by SJ)
- Making last_refresh_jiffies a global variable and initialize it on
  damon_stat_start(). (suggested by SJ)
- Added a new patch that fixes the same root cause issue in the core
  layer's sysfs. (found and suggested by SJ)

Quanmin Yan (2):
  mm/damon/stat: change last_refresh_jiffies to a global variable
  mm/damon/sysfs: change next_update_jiffies to a global variable

 mm/damon/stat.c  |  9 ++++++---
 mm/damon/sysfs.c | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.43.0

