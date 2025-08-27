Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC420B7EE
	for <damon@lists.linux.dev>; Wed, 27 Aug 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295921; cv=none; b=fi/k1ct2J8+A6Jlyq+uGbJdpctS9mQ2w8AHmAVB6T9T3cgrIQ+dskPEiWu64lK+6OybdAuvs4BaZTMhNRknrK308nhkL7qSQ7Y57HF7wdF4/TedcbWQqdUdtxC4v4meKdGNKyxsfqECPxx/gGwlh3JNutXjshAZ8+xliY4DSPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295921; c=relaxed/simple;
	bh=OWLQw4lnYUYtpWOqi4TdnN5N+Uc2CIvj6pHOBNWwyjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnoSzU6kQe/GaH3dAkvk8ZCfbqJn3HSl/FusK86xbzBTvNMaxSC44eJb57TZ1L44tnrAPQeDS+uCiydDSE17WHM8LXkJ1w2fe1MnWbgNw8dYGr0PLJQzIy+CYbvinYlxcD6qMCy5XNafH9lF4T0Mqi2XwKNGwFPUrQmVXtrnQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cBjjK4h2rz14MGx;
	Wed, 27 Aug 2025 19:58:29 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C630180483;
	Wed, 27 Aug 2025 19:58:36 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 19:58:35 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 0/2] mm/damon: void divide-by-zero in DAMON module's parameters application
Date: Wed, 27 Aug 2025 19:58:56 +0800
Message-ID: <20250827115858.1186261-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf200018.china.huawei.com (7.185.36.31)

DAMON's RECLAIM or LRU_SORT modules perform no validation on
user-configured parameters during application, which may lead
to division-by-zero errors.

Avoid the divide-by-zero by adding validation checks when DAMON
modules attempt to apply the parameters.

Changes from RFC v1
(https://lore.kernel.org/all/20250826033653.1208227-1-yanquanmin1@huawei.com/)
- No code changes.
  - Drop RFC tag.
  - Add 'Cc: stable@' tags to each patch.

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

