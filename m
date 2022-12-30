Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2C1FAB
	for <damon@lists.linux.dev>; Fri, 30 Dec 2022 06:53:11 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NjwsX1WvMz16Lxn;
	Fri, 30 Dec 2022 14:51:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 14:53:02 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v4 1/8] mm: memcg: Add folio_memcg_check()
Date: Fri, 30 Dec 2022 15:08:42 +0800
Message-ID: <20221230070849.63358-2-wangkefeng.wang@huawei.com>
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

From: Matthew Wilcox <willy@infradead.org>

Convert page_memcg_check() into folio_memcg_check() and add a
page_memcg_check() wrapper.  The behaviour of page_memcg_check() is
unchanged; tail pages always had a NULL ->memcg_data.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/memcontrol.h | 40 +++++++++++++++++++++++++-------------
 mm/memcontrol.c            |  6 +++---
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d3c8203cab6c..a2ebb4e2da63 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -466,34 +466,34 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 }
 
 /*
- * page_memcg_check - get the memory cgroup associated with a page
- * @page: a pointer to the page struct
+ * folio_memcg_check - Get the memory cgroup associated with a folio.
+ * @folio: Pointer to the folio.
  *
- * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function unlike page_memcg() can take any page
- * as an argument. It has to be used in cases when it's not known if a page
+ * Returns a pointer to the memory cgroup associated with the folio,
+ * or NULL. This function unlike folio_memcg() can take any folio
+ * as an argument. It has to be used in cases when it's not known if a folio
  * has an associated memory cgroup pointer or an object cgroups vector or
  * an object cgroup.
  *
- * For a non-kmem page any of the following ensures page and memcg binding
+ * For a non-kmem folio any of the following ensures folio and memcg binding
  * stability:
  *
- * - the page lock
+ * - the folio lock
  * - LRU isolation
- * - lock_page_memcg()
+ * - lock_folio_memcg()
  * - exclusive reference
  * - mem_cgroup_trylock_pages()
  *
- * For a kmem page a caller should hold an rcu read lock to protect memcg
- * associated with a kmem page from being released.
+ * For a kmem folio a caller should hold an rcu read lock to protect memcg
+ * associated with a kmem folio from being released.
  */
-static inline struct mem_cgroup *page_memcg_check(struct page *page)
+static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 {
 	/*
-	 * Because page->memcg_data might be changed asynchronously
-	 * for slab pages, READ_ONCE() should be used here.
+	 * Because folio->memcg_data might be changed asynchronously
+	 * for slabs, READ_ONCE() should be used here.
 	 */
-	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
 	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
@@ -508,6 +508,13 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+static inline struct mem_cgroup *page_memcg_check(struct page *page)
+{
+	if (PageTail(page))
+		return NULL;
+	return folio_memcg_check((struct folio *)page);
+}
+
 static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
 {
 	struct mem_cgroup *memcg;
@@ -1165,6 +1172,11 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 	return NULL;
 }
 
+static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 92f319ef6c99..259bc0a48d16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2939,13 +2939,13 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 	}
 
 	/*
-	 * page_memcg_check() is used here, because in theory we can encounter
+	 * folio_memcg_check() is used here, because in theory we can encounter
 	 * a folio where the slab flag has been cleared already, but
 	 * slab->memcg_data has not been freed yet
-	 * page_memcg_check(page) will guarantee that a proper memory
+	 * folio_memcg_check() will guarantee that a proper memory
 	 * cgroup pointer or NULL will be returned.
 	 */
-	return page_memcg_check(folio_page(folio, 0));
+	return folio_memcg_check(folio);
 }
 
 /*
-- 
2.35.3

