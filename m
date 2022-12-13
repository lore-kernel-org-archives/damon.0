Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DD257F
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 09:11:29 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NWXlP4CWPz15NQL;
	Tue, 13 Dec 2022 17:10:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:21 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Oscar Salvador <osalvador@suse.de>, SeongJae Park
	<sj@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, <vishal.moola@gmail.com>, <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 7/8] mm: damon: vaddr: convert damon_young_pmd_entry() to use folio
Date: Tue, 13 Dec 2022 17:27:34 +0800
Message-ID: <20221213092735.187924-8-wangkefeng.wang@huawei.com>
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

With damon_get_folio(), let's convert damon_young_pmd_entry()
to use folios.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/vaddr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 15f03df66db6..2fab7241aa04 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -431,7 +431,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	pte_t *pte;
 	spinlock_t *ptl;
-	struct page *page;
+	struct folio *folio;
 	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -446,16 +446,16 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 			spin_unlock(ptl);
 			goto regular_page;
 		}
-		page = damon_get_page(pmd_pfn(*pmd));
-		if (!page)
+		folio = damon_get_folio(pmd_pfn(*pmd));
+		if (!folio)
 			goto huge_out;
-		if (pmd_young(*pmd) || !page_is_idle(page) ||
+		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
 					mmu_notifier_test_young(walk->mm,
 						addr)) {
 			*priv->page_sz = HPAGE_PMD_SIZE;
 			priv->young = true;
 		}
-		put_page(page);
+		folio_put(folio);
 huge_out:
 		spin_unlock(ptl);
 		return 0;
@@ -469,15 +469,15 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	page = damon_get_page(pte_pfn(*pte));
-	if (!page)
+	folio = damon_get_folio(pte_pfn(*pte));
+	if (!folio)
 		goto out;
-	if (pte_young(*pte) || !page_is_idle(page) ||
+	if (pte_young(*pte) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->page_sz = PAGE_SIZE;
+		*priv->page_sz = PAGE_SIZE * folio_nr_pages(folio);
 		priv->young = true;
 	}
-	put_page(page);
+	folio_put(folio);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
-- 
2.35.3

