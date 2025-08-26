Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F3155322
	for <damon@lists.linux.dev>; Tue, 26 Aug 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179392; cv=none; b=QKE1VF2mgSZAJ5uI+bL+z3TM3IVl4upQg92xxmktTMBzBzZMcVlxIVZNs4pmCUZZ/A9DHuEfjDsyvJF9r6zoXmxNlPI5nhMPOr9AWXQMUwx0tzFKYl1sCB4He+JSNoublbCIG8kfBms28SJsVnfwK44u89mMbp7F9laFJL3ix7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179392; c=relaxed/simple;
	bh=OtmR6WiLkvCSAquLRpIdNEdofsRMvdZyZwqT9GScVQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jR93WH6A250aqqCsFAWYEtPgvb6kUKgvkftDJkKhi5wPyaDhEXszDEqKTJfjNXav4Tt3rEJc/DmawSXA9m6bOCb+qHLpyPWWYOBXQ9dvF/g1Er3uwgjnQ8WYkpJbNUrouS+iz4lgMkkH6k577EtCKHUw9qwWYwRl2WywaJmqr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c9tY804Frz1R9BL;
	Tue, 26 Aug 2025 11:33:32 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id ACCB5140296;
	Tue, 26 Aug 2025 11:36:27 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 11:36:27 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH 0/2] mm/damon: void divide-by-zero in DAMON module's parameters application
Date: Tue, 26 Aug 2025 11:36:51 +0800
Message-ID: <20250826033653.1208227-1-yanquanmin1@huawei.com>
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

DAMON's RECLAIM or LRU_SORT modules perform no validation on
user-configured parameters during application, which may lead
to division-by-zero errors.

Avoid the divide-by-zero by adding validation checks when DAMON
modules attempt to apply the parameters.

Quanmin Yan (2):
  mm/damon/lru_sort: avoid divide-by-zero in
    damon_lru_sort_apply_parameters()
  mm/damon/reclaim: avoid divide-by-zero in
    damon_reclaim_apply_parameters()

 mm/damon/lru_sort.c | 5 +++++
 mm/damon/reclaim.c  | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.43.0

