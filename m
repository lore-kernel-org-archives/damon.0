Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE417ABA
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 09:30:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D42D176A;
	Fri,  2 Jun 2023 02:30:55 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73083F7BD;
	Fri,  2 Jun 2023 02:30:07 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: [PATCH v3 3/4] mm/damon/ops-common: Refactor to use {pte|pmd}p_clear_young_notify()
Date: Fri,  2 Jun 2023 10:29:48 +0100
Message-Id: <20230602092949.545577-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602092949.545577-1-ryan.roberts@arm.com>
References: <20230602092949.545577-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the fix in place to atomically test and clear young on ptes and
pmds, simplify the code to handle the clearing for both the primary mmu
and the mmu notifier with a single API call.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/damon/ops-common.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index acc264b97903..d4ab81229136 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -39,21 +39,12 @@ struct folio *damon_get_folio(unsigned long pfn)
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
-	bool referenced = false;
 	struct folio *folio = damon_get_folio(pte_pfn(*pte));
 
 	if (!folio)
 		return;
 
-	if (ptep_test_and_clear_young(vma, addr, pte))
-		referenced = true;
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
+	if (ptep_clear_young_notify(vma, addr, pte))
 		folio_set_young(folio);
 
 	folio_set_idle(folio);
@@ -63,21 +54,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool referenced = false;
 	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
 
 	if (!folio)
 		return;
 
-	if (pmdp_test_and_clear_young(vma, addr, pmd))
-		referenced = true;
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
+	if (pmdp_clear_young_notify(vma, addr, pmd))
 		folio_set_young(folio);
 
 	folio_set_idle(folio);
-- 
2.25.1

