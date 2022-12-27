Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898F10E4
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 12:11:43 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NhD4V05vFz16LrF;
	Tue, 27 Dec 2022 20:10:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 20:11:32 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 1/7] mm: page_idle: Convert page idle to use folios
Date: Tue, 27 Dec 2022 20:27:08 +0800
Message-ID: <20221227122714.161224-2-wangkefeng.wang@huawei.com>
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

Firtly, make page_idle_get_page() return a folio when successfully
grab a ref of a page, also rename it page_idle_get_folio(), then,
use it to covert page_idle_bitmap_read()/write() functions.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_idle.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index bc08332a609c..4f248e500e08 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -31,19 +31,20 @@
  *
  * This function tries to get a user memory page by pfn as described above.
  */
-static struct page *page_idle_get_page(unsigned long pfn)
+static struct folio *page_idle_get_folio(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
+	struct folio *folio;
 
-	if (!page || !PageLRU(page) ||
-	    !get_page_unless_zero(page))
+	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
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
 
 static bool page_idle_clear_pte_refs_one(struct folio *folio,
@@ -83,10 +84,8 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
 	return true;
 }
 
-static void page_idle_clear_pte_refs(struct page *page)
+static void page_idle_clear_pte_refs(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	/*
 	 * Since rwc.try_lock is unused, rwc is effectively immutable, so we
 	 * can make it static to save some cycles and stack.
@@ -115,7 +114,7 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 				     loff_t pos, size_t count)
 {
 	u64 *out = (u64 *)buf;
-	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, end_pfn;
 	int bit;
 
@@ -134,19 +133,19 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 		bit = pfn % BITMAP_CHUNK_BITS;
 		if (!bit)
 			*out = 0ULL;
-		page = page_idle_get_page(pfn);
-		if (page) {
-			if (page_is_idle(page)) {
+		folio = page_idle_get_folio(pfn);
+		if (folio) {
+			if (folio_test_idle(folio)) {
 				/*
 				 * The page might have been referenced via a
 				 * pte, in which case it is not idle. Clear
 				 * refs and recheck.
 				 */
-				page_idle_clear_pte_refs(page);
-				if (page_is_idle(page))
+				page_idle_clear_pte_refs(folio);
+				if (folio_test_idle(folio))
 					*out |= 1ULL << bit;
 			}
-			put_page(page);
+			folio_put(folio);
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
 			out++;
@@ -160,7 +159,7 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 				      loff_t pos, size_t count)
 {
 	const u64 *in = (u64 *)buf;
-	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, end_pfn;
 	int bit;
 
@@ -178,11 +177,11 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
 		if ((*in >> bit) & 1) {
-			page = page_idle_get_page(pfn);
-			if (page) {
-				page_idle_clear_pte_refs(page);
-				set_page_idle(page);
-				put_page(page);
+			folio = page_idle_get_folio(pfn);
+			if (folio) {
+				page_idle_clear_pte_refs(folio);
+				folio_set_idle(folio);
+				folio_put(folio);
 			}
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
-- 
2.35.3

