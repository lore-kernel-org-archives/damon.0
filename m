Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67121119
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 11:18:28 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nhprj6rz0z16LsV;
	Wed, 28 Dec 2022 19:17:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 19:18:26 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v3 6/7] mm/damon: remove unneed damon_get_page()
Date: Wed, 28 Dec 2022 19:34:12 +0800
Message-ID: <20221228113413.10329-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
References: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

After all damon_get_page() callers are converted to damon_get_folio(),
remove unneed wrapper damon_get_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 65f290f0a9d6..14f4bc69f29b 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -8,13 +8,6 @@
 #include <linux/damon.h>
 
 struct folio *damon_get_folio(unsigned long pfn);
-static inline struct page *damon_get_page(unsigned long pfn)
-{
-	struct folio *folio = damon_get_folio(pfn);
-
-	/* when folio is NULL, return &(0->page) mean return NULL */
-	return &folio->page;
-}
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
-- 
2.35.3

