Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1454B1CC;
	Tue,  8 Sep 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875539; cv=none; b=fbRQtDmdOwlLi1QDDW5EWmXFt95/9JHU/aw6apMGaHjEHF3YKZzASn6hs9KTUvQxiqcaBv5CE2V2LRh74FHFHlxWdznjQ0VFkM4Zn7qWdc2wwhzbNRIeKLD1vNfrtN7Ws4tge/I84V8eAKP8RGP6QChUfdGaHnyO10KdlIHPcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875539; c=relaxed/simple;
	bh=KHDIh335W8FKetHqgUJZAilYRrFY8ilqgzc0OxsOTfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMIMs24r+ih28J5Jmq+W5Skqlz6XVufoK620NGHzE8UuVuf/0GRQ6Ij5/ZDV4I+xVaar/EDeRagQuoXyg7EZ3ZYEZXVocien1ME+dtmYmghxvTNZS8pCxLlBlaglw7MWuuO3tEchkaEieDjQwyGe3EhBxUrnwGAeC+M9I9YZcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdfYkuV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdfYkuV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC24B1F00A3E;
	Tue,  8 Sep 2026 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875524;
	bh=6kczmrPAUogSYXZZ+xxo8bL8jMA/tFmXj3bQ+IC2xRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdfYkuV6xeUH2S6Q+QtzgR+3pVWXzHTRUCvHcyhdEZt8PVcgIXAC002vdQo9mo8Rn
	 YHOYP5gHWieUOEJwHEqM8ENToViQzIareRHLM8Ha8X5aVR82QP0fU2IewbK/3bqP5v
	 xL4h+XtBdkoQFonQesAT+1hjqUQ0wDcXasz59emqgCP80Mf4vnQEOj40ulgIcFvQ/V
	 AmROXWB5pqz2v2yvd6yfl0C+XB3iccrOUEvg+DFM4vp4hggxnH4kqbOFjDB9ki0iR/
	 +sn7i3tFBS4RO61PrkgZJTG1SKKbFdybDvj3Pq9yX2NcC237Yuw/cxdc9+Dm1QPTlU
	 SWEo19qZcOdaA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Krishna Iyer <kiyer@crusoe.ai>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/3] mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
Date: Tue,  8 Sep 2026 06:51:53 -0700
Message-ID: <20260908135156.97481-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908135156.97481-1-sj@kernel.org>
References: <20260908135156.97481-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krishna Iyer <kiyer@crusoe.ai>

damon_hugetlb_mkold() clears the accessed bit of a hugetlb-mapping huge
PTE and propagates the aging to secondary MMUs via
mmu_notifier_clear_young(), spanning the whole huge page size.  It
currently lives in vaddr.c, and is thus usable only by the virtual
address space monitoring operations set.

The physical address space monitoring operations set will need the same
logic, to support access monitoring of hugetlb-backed memory.  Move the
function to ops-common as-is, with no behavioral change.  A follow-up
change will use it from the folio-granular rmap walkers.

Link: https://lore.kernel.org/20260902025700.17975-2-kiyer@crusoe.ai
Cc: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 37 +++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  9 +++++++++
 mm/damon/vaddr.c      | 34 ----------------------------------
 3 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 7219c608b1952..995cc1f3b9f32 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -3,6 +3,7 @@
  * Common Code for Data Access Monitoring
  */
 
+#include <linux/hugetlb.h>
 #include <linux/migrate.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
@@ -103,6 +104,42 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
+{
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	if (!pte_young(*entry))
+		return false;
+	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
+	*entry = pte_mkold(*entry);
+	set_huge_pte_at(mm, addr, pte, *entry, psize);
+	return true;
+}
+
+void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	bool referenced = false;
+	pte_t entry = huge_ptep_get(mm, addr, pte);
+	struct folio *folio = pfn_folio(pte_pfn(entry));
+
+	folio_get(folio);
+
+	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
+	if (mmu_notifier_clear_young(mm, addr,
+				     addr + huge_page_size(hstate_vma(vma))))
+		referenced = true;
+
+	if (referenced)
+		folio_set_young(folio);
+
+	folio_set_idle(folio);
+	folio_put(folio);
+}
+#endif	/* CONFIG_HUGETLB_PAGE */
+
 #define DAMON_MAX_SUBSCORE	(100)
 #define DAMON_MAX_AGE_IN_LOG	(32)
 
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 38d295488fa18..f7811c9c7a024 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -9,6 +9,15 @@ struct folio *damon_get_folio(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
+#ifdef CONFIG_HUGETLB_PAGE
+void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr);
+#else
+static inline void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+}
+#endif	/* CONFIG_HUGETLB_PAGE */
 void damon_folio_mkold(struct folio *folio);
 bool damon_folio_young(struct folio *folio);
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 91a0d441c1f94..af9e1b82454cc 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -283,40 +283,6 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
-		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
-{
-	unsigned long psize = huge_page_size(hstate_vma(vma));
-
-	if (!pte_young(*entry))
-		return false;
-	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
-	*entry = pte_mkold(*entry);
-	set_huge_pte_at(mm, addr, pte, *entry, psize);
-	return true;
-}
-
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
-				struct vm_area_struct *vma, unsigned long addr)
-{
-	bool referenced = false;
-	pte_t entry = huge_ptep_get(mm, addr, pte);
-	struct folio *folio = pfn_folio(pte_pfn(entry));
-
-	folio_get(folio);
-
-	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
-	if (mmu_notifier_clear_young(mm, addr,
-				     addr + huge_page_size(hstate_vma(vma))))
-		referenced = true;
-
-	if (referenced)
-		folio_set_young(folio);
-
-	folio_set_idle(folio);
-	folio_put(folio);
-}
-
 static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				     unsigned long addr, unsigned long end,
 				     struct mm_walk *walk)
-- 
2.47.3
