Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B11FAC
	for <damon@lists.linux.dev>; Fri, 30 Dec 2022 06:53:06 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NjwsS1PtjzRqPf;
	Fri, 30 Dec 2022 14:51:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 14:53:04 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v4 4/8] mm/damon: convert damon_ptep/pmdp_mkold() to use a folio
Date: Fri, 30 Dec 2022 15:08:45 +0800
Message-ID: <20221230070849.63358-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221230070849.63358-1-wangkefeng.wang@huawei.com>
References: <20221230070849.63358-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

With damon_get_folio(), let's convert damon_ptep_mkold() and
damon_pmdp_mkold() to use a folio.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 1294a256a87c..cc63cf953636 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -40,9 +40,9 @@ struct folio *damon_get_folio(unsigned long pfn)
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 {
 	bool referenced = false;
-	struct page *page = damon_get_page(pte_pfn(*pte));
+	struct folio *folio = damon_get_folio(pte_pfn(*pte));
 
-	if (!page)
+	if (!folio)
 		return;
 
 	if (pte_young(*pte)) {
@@ -56,19 +56,19 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 #endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
-		set_page_young(page);
+		folio_set_young(folio);
 
-	set_page_idle(page);
-	put_page(page);
+	folio_set_idle(folio);
+	folio_put(folio);
 }
 
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	bool referenced = false;
-	struct page *page = damon_get_page(pmd_pfn(*pmd));
+	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
 
-	if (!page)
+	if (!folio)
 		return;
 
 	if (pmd_young(*pmd)) {
@@ -82,10 +82,10 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 #endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
-		set_page_young(page);
+		folio_set_young(folio);
 
-	set_page_idle(page);
-	put_page(page);
+	folio_set_idle(folio);
+	folio_put(folio);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
-- 
2.35.3

