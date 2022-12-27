Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8410E3
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 12:11:43 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NhD0m722MzkWv6;
	Tue, 27 Dec 2022 20:07:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 20:11:35 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 7/7] mm: damon: vaddr: convert hugetlb related function to use folios
Date: Tue, 27 Dec 2022 20:27:14 +0800
Message-ID: <20221227122714.161224-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221227122714.161224-1-wangkefeng.wang@huawei.com>
References: <20221227122714.161224-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

Convert damon_hugetlb_mkold() and damon_young_hugetlb_entry() to
use folios.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/vaddr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 29227b7a6032..9d92c5eb3a1f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -335,9 +335,9 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(pte);
-	struct page *page = pte_page(entry);
+	struct folio *folio = pfn_folio(pte_pfn(entry));
 
-	get_page(page);
+	folio_get(folio);
 
 	if (pte_young(entry)) {
 		referenced = true;
@@ -352,10 +352,10 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 #endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
-		set_page_young(page);
+		folio_set_young(folio);
 
-	set_page_idle(page);
-	put_page(page);
+	folio_set_idle(folio);
+	folio_put(folio);
 }
 
 static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
@@ -490,7 +490,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 {
 	struct damon_young_walk_private *priv = walk->private;
 	struct hstate *h = hstate_vma(walk->vma);
-	struct page *page;
+	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t entry;
 
@@ -499,16 +499,16 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto out;
 
-	page = pte_page(entry);
-	get_page(page);
+	folio = pfn_folio(pte_pfn(entry));
+	folio_get(folio);
 
-	if (pte_young(entry) || !page_is_idle(page) ||
+	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr)) {
 		*priv->page_sz = huge_page_size(h);
 		priv->young = true;
 	}
 
-	put_page(page);
+	folio_put(folio);
 
 out:
 	spin_unlock(ptl);
-- 
2.35.3

