Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F6ECA
	for <damon@lists.linux.dev>; Tue, 17 May 2022 14:40:42 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2f0Z6BXtzhZFm;
	Tue, 17 May 2022 22:39:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 22:40:33 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 22:40:33 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: damon: Use HPAGE_PMD_SIZE
Date: Tue, 17 May 2022 22:51:20 +0800
Message-ID: <20220517145120.118523-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

Using HPAGE_PMD_SIZE instead of open code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.c | 3 +--
 mm/damon/paddr.c      | 2 +-
 mm/damon/vaddr.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e346cc10d143..10ef20b2003f 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -73,8 +73,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
-				addr + ((1UL) << HPAGE_PMD_SHIFT)))
+	if (mmu_notifier_clear_young(mm, addr, addr + HPAGE_PMD_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 21474ae63bc7..b40ff5811bb2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -106,7 +106,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 			result->accessed = pmd_young(*pvmw.pmd) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
-			result->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+			result->page_sz = HPAGE_PMD_SIZE;
 #else
 			WARN_ON_ONCE(1);
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 9a56ff60f244..5767be72c181 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -443,7 +443,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (pmd_young(*pmd) || !page_is_idle(page) ||
 					mmu_notifier_test_young(walk->mm,
 						addr)) {
-			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+			*priv->page_sz = HPAGE_PMD_SIZE;
 			priv->young = true;
 		}
 		put_page(page);
-- 
2.35.3

