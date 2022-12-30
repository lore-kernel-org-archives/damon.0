Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37351FAB
	for <damon@lists.linux.dev>; Fri, 30 Dec 2022 06:53:12 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NjwpZ1h2SzJpV1;
	Fri, 30 Dec 2022 14:49:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 14:53:04 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v4 5/8] mm/damon/paddr: convert damon_pa_*() to use a folio
Date: Fri, 30 Dec 2022 15:08:46 +0800
Message-ID: <20221230070849.63358-6-wangkefeng.wang@huawei.com>
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

With damon_get_folio(), let's convert all the damon_pa_*() to use a folio.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 58 ++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6334c99e5152..99d4c357ef2b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -33,17 +33,15 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 
 static void damon_pa_mkold(unsigned long paddr)
 {
-	struct folio *folio;
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
 		.rmap_one = __damon_pa_mkold,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
-	if (!page)
+	if (!folio)
 		return;
-	folio = page_folio(page);
 
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		folio_set_idle(folio);
@@ -122,8 +120,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 
 static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 {
-	struct folio *folio;
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct damon_pa_access_chk_result result = {
 		.page_sz = PAGE_SIZE,
 		.accessed = false,
@@ -135,9 +132,8 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	};
 	bool need_lock;
 
-	if (!page)
+	if (!folio)
 		return false;
-	folio = page_folio(page);
 
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		if (folio_test_idle(folio))
@@ -203,18 +199,18 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 }
 
 static bool __damos_pa_filter_out(struct damos_filter *filter,
-		struct page *page)
+		struct folio *folio)
 {
 	bool matched = false;
 	struct mem_cgroup *memcg;
 
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_ANON:
-		matched = PageAnon(page);
+		matched = folio_test_anon(folio);
 		break;
 	case DAMOS_FILTER_TYPE_MEMCG:
 		rcu_read_lock();
-		memcg = page_memcg_check(page);
+		memcg = folio_memcg_check(folio);
 		if (!memcg)
 			matched = false;
 		else
@@ -231,12 +227,12 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
 /*
  * damos_pa_filter_out - Return true if the page should be filtered out.
  */
-static bool damos_pa_filter_out(struct damos *scheme, struct page *page)
+static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 {
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, scheme) {
-		if (__damos_pa_filter_out(filter, page))
+		if (__damos_pa_filter_out(filter, folio))
 			return true;
 	}
 	return false;
@@ -245,33 +241,33 @@ static bool damos_pa_filter_out(struct damos *scheme, struct page *page)
 static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 {
 	unsigned long addr, applied;
-	LIST_HEAD(page_list);
+	LIST_HEAD(folio_list);
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
-		struct page *page = damon_get_page(PHYS_PFN(addr));
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!page)
+		if (!folio)
 			continue;
 
-		if (damos_pa_filter_out(s, page)) {
-			put_page(page);
+		if (damos_pa_filter_out(s, folio)) {
+			folio_put(folio);
 			continue;
 		}
 
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
-		if (isolate_lru_page(page)) {
-			put_page(page);
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
+		if (folio_isolate_lru(folio)) {
+			folio_put(folio);
 			continue;
 		}
-		if (PageUnevictable(page)) {
-			putback_lru_page(page);
+		if (folio_test_unevictable(folio)) {
+			folio_putback_lru(folio);
 		} else {
-			list_add(&page->lru, &page_list);
-			put_page(page);
+			list_add(&folio->lru, &folio_list);
+			folio_put(folio);
 		}
 	}
-	applied = reclaim_pages(&page_list);
+	applied = reclaim_pages(&folio_list);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
@@ -282,14 +278,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	unsigned long addr, applied = 0;
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
-		struct page *page = damon_get_page(PHYS_PFN(addr));
-		struct folio *folio;
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!page)
+		if (!folio)
 			continue;
-		folio = page_folio(page);
 
-		if (damos_pa_filter_out(s, &folio->page)) {
+		if (damos_pa_filter_out(s, folio)) {
 			folio_put(folio);
 			continue;
 		}
-- 
2.35.3

