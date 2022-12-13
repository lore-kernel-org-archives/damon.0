Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E142579
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 09:11:23 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWXlR60YRzJqT4;
	Tue, 13 Dec 2022 17:10:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:20 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Oscar Salvador <osalvador@suse.de>, SeongJae Park
	<sj@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, <vishal.moola@gmail.com>, <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 5/8] mm: damon: convert damon_ptep/pmdp_mkold() to use folios
Date: Tue, 13 Dec 2022 17:27:32 +0800
Message-ID: <20221213092735.187924-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

With damon_get_folio(), let's convert damon_ptep_mkold() and
damon_pmdp_mkold() to use folios.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 40b79b022129..40ea39fe204d 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -36,9 +36,9 @@ struct folio *damon_get_folio(unsigned long pfn)
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 {
 	bool referenced = false;
-	struct page *page = damon_get_page(pte_pfn(*pte));
+	struct folio *folio = damon_get_folio(pte_pfn(*pte));
 
-	if (!page)
+	if (!folio)
 		return;
 
 	if (pte_young(*pte)) {
@@ -52,19 +52,19 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
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
@@ -78,10 +78,10 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
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

