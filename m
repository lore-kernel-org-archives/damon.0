Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC451FAB
	for <damon@lists.linux.dev>; Fri, 30 Dec 2022 06:53:06 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NjwsR5CFBzRqPX;
	Fri, 30 Dec 2022 14:51:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 14:53:03 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v4 3/8] mm/damon: introduce damon_get_folio()
Date: Fri, 30 Dec 2022 15:08:44 +0800
Message-ID: <20221230070849.63358-4-wangkefeng.wang@huawei.com>
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

Introduce damon_get_folio(), and the temporary wrapper function
damon_get_page(), which help us to convert damon related functions
to use folios, and it will be dropped once the conversion is completed.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.c | 18 +++++++++++-------
 mm/damon/ops-common.h |  9 ++++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 75409601f934..1294a256a87c 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -16,21 +16,25 @@
  * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
  * NULL.
  *
- * The body of this function is stolen from the 'page_idle_get_page()'.  We
+ * The body of this function is stolen from the 'page_idle_get_folio()'.  We
  * steal rather than reuse it because the code is quite simple.
  */
-struct page *damon_get_page(unsigned long pfn)
+struct folio *damon_get_folio(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
+	struct folio *folio;
 
-	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
+	if (!page || PageTail(page))
 		return NULL;
 
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
+	folio = page_folio(page);
+	if (!folio_test_lru(folio) || !folio_try_get(folio))
+		return NULL;
+	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+		folio_put(folio);
+		folio = NULL;
 	}
-	return page;
+	return folio;
 }
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 8d82d3722204..65f290f0a9d6 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -7,7 +7,14 @@
 
 #include <linux/damon.h>
 
-struct page *damon_get_page(unsigned long pfn);
+struct folio *damon_get_folio(unsigned long pfn);
+static inline struct page *damon_get_page(unsigned long pfn)
+{
+	struct folio *folio = damon_get_folio(pfn);
+
+	/* when folio is NULL, return &(0->page) mean return NULL */
+	return &folio->page;
+}
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
-- 
2.35.3

