Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535A3201
	for <damon@lists.linux.dev>; Thu, 29 Dec 2022 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1tXPNTjQrGpQJnxsISBWx0T+RRuQWBm24hZghH8jCs0=; b=sWzLqxG6JdyOQOHnQf2TJkBjWF
	MiBWkGdRrdJzylSZE4ndx6TsChBYs+iCLdt/Ksx0J+yetnr8avR69SWJjguY4vTK/eELea7WI6LVE
	1w8xLB2hpa0bydmFTEbJXlZ92xJ69NXHJ2vf2K7+NQEgskK46lpYTTB5RsqZEGCsT4xdG9ODKmnSY
	KVRSKHJTmwdR0xJIGMIqAo3SSyj8nr6/yC2YQgVS4VQ16PyjUvH1so9BRC6JlmpBuUrL906qi1dW9
	gWE0g9cRQy8HovR0/Vp0aGNYhFbF94tOjdXgq9yzf/lOf3MrCiEzgDr7PwLNX0y2nAe4Ptlicc3Vg
	Vedl/Q/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAzdN-00A6C5-9I; Thu, 29 Dec 2022 20:36:13 +0000
Date: Thu, 29 Dec 2022 20:36:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, vishal.moola@gmail.com, david@redhat.com
Subject: Re: [PATCH -next v3 4/7] mm/damon/paddr: convert damon_pa_*() to use
 folios
Message-ID: <Y636PVBaq7VoLyoO@casper.infradead.org>
References: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
 <20221228113413.10329-5-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228113413.10329-5-wangkefeng.wang@huawei.com>

On Wed, Dec 28, 2022 at 07:34:10PM +0800, Kefeng Wang wrote:
> -		memcg = page_memcg_check(page);
> +		memcg = page_memcg_check(folio_page(folio, 0));

I doubly don't like this.  First, it should have been &folio->page.
Second, we should have a folio_memcg_check().  The only reason we don't
is that I hadn't needed one before now.  Try adding this patch on first.

--- 8< ---

From 5fca3ae2278b72d96d99fad5c433cd429a11989d Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Thu, 29 Dec 2022 12:59:41 -0500
Subject: [PATCH] memcg: Add folio_memcg_check()

Convert page_memcg_check() into folio_memcg_check() and add a
page_memcg_check() wrapper.  The behaviour of page_memcg_check() is
unchanged; tail pages always had a NULL ->memcg_data.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
2.35.1

