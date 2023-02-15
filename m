Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259A2F34
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 10:39:51 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vbk1biH_1676457587;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbk1biH_1676457587)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 18:39:48 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	sj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	naoya.horiguchi@nec.com,
	linmiaohe@huawei.com,
	david@redhat.com,
	osalvador@suse.de,
	mike.kravetz@oracle.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mm: hugetlb: change to return bool for isolate_hugetlb()
Date: Wed, 15 Feb 2023 18:39:36 +0800
Message-Id: <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
care about the negative value, thus we can convert the isolate_hugetlb()
to return a boolean value to make code more clear when checking the
hugetlb isolation state. Moreover converts 2 users which will consider
the negative value returned by isolate_hugetlb().

No functional changes intended.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 13 ++++++++-----
 mm/memory-failure.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  7 +++----
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index df6dd624ccfe..5f5e4177b2e0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,7 +171,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-int isolate_hugetlb(struct folio *folio, struct list_head *list);
+bool isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
@@ -413,9 +413,9 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
+static inline bool isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
-	return -EBUSY;
+	return false;
 }
 
 static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a01a9dbf445..16513cd23d5d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2925,13 +2925,16 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 */
 		goto free_new;
 	} else if (folio_ref_count(old_folio)) {
+		bool isolated;
+
 		/*
 		 * Someone has grabbed the folio, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(old_folio, list);
+		isolated = isolate_hugetlb(old_folio, list);
 		spin_lock_irq(&hugetlb_lock);
+		ret = isolated ? 0 : -EBUSY;
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
 		/*
@@ -3005,7 +3008,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (folio_ref_count(folio) && !isolate_hugetlb(folio, list))
+	if (folio_ref_count(folio) && isolate_hugetlb(folio, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
 		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
@@ -7251,15 +7254,15 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * These functions are overwritable if your architecture needs its own
  * behavior.
  */
-int isolate_hugetlb(struct folio *folio, struct list_head *list)
+bool isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
-	int ret = 0;
+	bool ret = true;
 
 	spin_lock_irq(&hugetlb_lock);
 	if (!folio_test_hugetlb(folio) ||
 	    !folio_test_hugetlb_migratable(folio) ||
 	    !folio_try_get(folio)) {
-		ret = -EBUSY;
+		ret = false;
 		goto unlock;
 	}
 	folio_clear_hugetlb_migratable(folio);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e504362fdb23..8604753bc644 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2508,7 +2508,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool isolated = false;
 
 	if (PageHuge(page)) {
-		isolated = !isolate_hugetlb(page_folio(page), pagelist);
+		isolated = isolate_hugetlb(page_folio(page), pagelist);
 	} else {
 		bool lru = !__PageMovable(page);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2751bc3310fd..a256a241fd1d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -609,7 +609,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && folio_estimated_sharers(folio) == 1 &&
 	     !hugetlb_pmd_shared(pte))) {
-		if (isolate_hugetlb(folio, qp->pagelist) &&
+		if (!isolate_hugetlb(folio, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
 			 * Failed to isolate folio but allow migrating pages
diff --git a/mm/migrate.c b/mm/migrate.c
index 53010a142e7f..2db546a0618c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2095,6 +2095,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct page *page;
 	int err;
+	bool isolated;
 
 	mmap_read_lock(mm);
 	err = -EFAULT;
@@ -2126,13 +2127,11 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			err = isolate_hugetlb(page_folio(page), pagelist);
-			if (!err)
-				err = 1;
+			isolated = isolate_hugetlb(page_folio(page), pagelist);
+			err = isolated ? 1 : -EBUSY;
 		}
 	} else {
 		struct page *head;
-		bool isolated;
 
 		head = compound_head(page);
 		isolated = isolate_lru_page(head);
-- 
2.27.0

