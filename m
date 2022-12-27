Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE5111B
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 12:11:43 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NhD1T6H1GzJpTG;
	Tue, 27 Dec 2022 20:07:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 20:11:33 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 2/7] mm: damon: introduce damon_get_folio()
Date: Tue, 27 Dec 2022 20:27:09 +0800
Message-ID: <20221227122714.161224-3-wangkefeng.wang@huawei.com>
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

Introduce damon_get_folio(), and the temporary wrapper function
damon_get_page(), which help us to convert damon related function
to use folios, and it will be droped once the conversion is completed.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.c | 14 ++++++++------
 mm/damon/ops-common.h |  8 +++++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 75409601f934..ff38a19aa92e 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -16,21 +16,23 @@
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
 
 	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
 		return NULL;
 
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
+	folio = page_folio(page);
+	if (unlikely(!folio_test_lru(folio))) {
+		folio_put(folio);
+		folio = NULL;
 	}
-	return page;
+	return folio;
 }
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 8d82d3722204..4ee607813981 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -7,7 +7,13 @@
 
 #include <linux/damon.h>
 
-struct page *damon_get_page(unsigned long pfn);
+struct folio *damon_get_folio(unsigned long pfn);
+static inline struct page *damon_get_page(unsigned long pfn)
+{
+	struct folio *folio = damon_get_folio(pfn);
+
+	return &folio->page;
+}
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
-- 
2.35.3

