Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8765232
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 21:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3813C433F2;
	Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673300028;
	bh=CFEeibNvvYAHsooB/GZxZzGLeG1gUo5uWWp85VJYZOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkayMLf4IhwPE5yfzgDGZfwtnsgWnvEkfeAXD5O25NOF846s/PGNbZIBST+o9XJfu
	 YTzFb7YVkNVDpiaxedFNYwJ5bGBdaSZlzL0dJifZseNQaZ9fVWqVQmyDdHhV+vKXja
	 HASc/1EM1sgLdlweKLpxJWF0NKPshrKc8IjLEngSJK+LCP2VWTSJxuduVYw99ul/ij
	 NzCuJU0/oB5GhgMqwXkr0/VEu2XMLuavwrhnAr0bYcTbsg9oa3xyQuy7Jd7rGl+BIG
	 b/Aw174M8zeE6Hi9q4YH1GA+PwK7bX+GynKfII38j5rrg51mvQfOX0XcBjXRTshqIX
	 7XmdlB/xwMVHg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm/damon/paddr: rename 'damon_pa_access_chk_result->page_sz' to 'folio_sz'
Date: Mon,  9 Jan 2023 21:33:33 +0000
Message-Id: <20230109213335.62525-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109213335.62525-1-sj@kernel.org>
References: <20230109213335.62525-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's physical address space monitoring operations set is using folio
now.  Rename 'damon_pa_access_chk_result->page_sz' to reflect the fact.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 99d4c357ef2b..65c1e0f91535 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -80,7 +80,8 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_pa_access_chk_result {
-	unsigned long page_sz;
+	/* size of the folio for the access checked physical memory address */
+	unsigned long folio_sz;
 	bool accessed;
 };
 
@@ -91,7 +92,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
 	result->accessed = false;
-	result->page_sz = PAGE_SIZE;
+	result->folio_sz = PAGE_SIZE;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
@@ -103,7 +104,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 			result->accessed = pmd_young(*pvmw.pmd) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
-			result->page_sz = HPAGE_PMD_SIZE;
+			result->folio_sz = HPAGE_PMD_SIZE;
 #else
 			WARN_ON_ONCE(1);
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -118,11 +119,11 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return !result->accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
+static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct damon_pa_access_chk_result result = {
-		.page_sz = PAGE_SIZE,
+		.folio_sz = PAGE_SIZE,
 		.accessed = false,
 	};
 	struct rmap_walk_control rwc = {
@@ -157,25 +158,25 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	folio_put(folio);
 
 out:
-	*page_sz = result.page_sz;
+	*folio_sz = result.folio_sz;
 	return result.accessed;
 }
 
 static void __damon_pa_check_access(struct damon_region *r)
 {
 	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
+	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
+	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
 		if (last_accessed)
 			r->nr_accesses++;
 		return;
 	}
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
+	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
 	if (last_accessed)
 		r->nr_accesses++;
 
-- 
2.25.1

