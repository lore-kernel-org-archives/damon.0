Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131C340279;
	Wed, 12 Nov 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962160; cv=none; b=YQ0O98V8pxjhYTtFy8ySoi8mbOdsUdEhSWDFLfUfvoQxA1T8/956NUzMR40GYbTwMc3P8hFEopze5zcijFsjCkt+QxuFEzWGpgce3EP1ohz00MLrfiWjhTa2tS/+uQ66NGTGusw8UvH+VEFRyVvoDOC+GCdXbMgKOwklsmLJjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962160; c=relaxed/simple;
	bh=fyGxdylWBgAVN1pPbqolUxiQxMykoRKgirgaM7k7Lm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrGwf7vYqIgd40o9jCxAhfhf4BZ3UN/tjpSx0cv6/wwmtBovZTv1FIzR7KDWPLwuEbT6T0Krol5mKd7Xrdul+1InQZUMUjUq9NASPQnn9S09yQfCoFKPfN9Txo2N9rCRUgz8YjR0asP/MnZf8hKgILF+E5hG9Y2mh1x8I/oVXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJPkMLOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJPkMLOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA50C16AAE;
	Wed, 12 Nov 2025 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962159;
	bh=fyGxdylWBgAVN1pPbqolUxiQxMykoRKgirgaM7k7Lm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJPkMLOQM8CjnT+976he2HZY6GupzdlSz309HLegPA5L06cVXuJWLwg0Fk/XXWNUC
	 j5lpRzEVSqTzbY0SvInaI3YLw989pC2Uql8SIqSHl+s2X//n71ukEeDUvwdr/C3l9u
	 tnajO7HxephoCH2YXNUkNhmnf8mp0j1Kg/hAEoDU3WRGDWgmx4wZ2aCZYp3Es4Kg43
	 MfyX6StfLBBwvBNihzy510M8FL/APG2NE+kgce6za0HjGVbSqw7+breLPufbdI0BRI
	 7Zt4esOBgnllnoTXCVrCU4x0wCh3RrhlYZ7Mkk8RAto4djZmBTE/sJJ9/ukI39X7YD
	 UZ5CR54rRz3HA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 5/9] mm/damon/vaddr: consistently use only pmd_entry for damos_migrate
Date: Wed, 12 Nov 2025 07:41:08 -0800
Message-ID: <20251112154114.66053-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For page table walks, it is usual [1] to have only one pmd entry
function.  The vaddr.c code for DAMOS_MIGRATE_{HOT,COLD} is not
following the pattern.  Instead, it uses both pmd and pte entry
functions without a special reason.  Refactor it to use only the pmd
entry function, to make the code under mm/ more consistent.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 84 +++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 9c06cfe4526f..ef57e95eb422 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -695,7 +695,6 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	list_add(&folio->lru, &migration_lists[i]);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
@@ -705,58 +704,49 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
-	pmd_t pmde;
-
-	ptl = pmd_lock(walk->mm, pmd);
-	pmde = pmdp_get(pmd);
-
-	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
-		goto unlock;
-
-	/* Tell page walk code to not split the PMD */
-	walk->action = ACTION_CONTINUE;
-
-	folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
-	if (!folio)
-		goto unlock;
-
-	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
-		goto unlock;
-
-	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
-		migration_lists);
-
-unlock:
-	spin_unlock(ptl);
-	return 0;
-}
-#else
-#define damos_va_migrate_pmd_entry NULL
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+	pte_t *start_pte, *pte, ptent;
+	int nr;
 
-static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
-		unsigned long next, struct mm_walk *walk)
-{
-	struct damos_va_migrate_private *priv = walk->private;
-	struct list_head *migration_lists = priv->migration_lists;
-	struct damos *s = priv->scheme;
-	struct damos_migrate_dests *dests = &s->migrate_dests;
-	struct folio *folio;
-	pte_t ptent;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		pmd_t pmde = pmdp_get(pmd);
 
-	ptent = ptep_get(pte);
-	if (pte_none(ptent) || !pte_present(ptent))
+		if (!pmd_present(pmde))
+			goto huge_out;
+		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
+		if (!folio)
+			goto huge_out;
+		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
+			goto huge_out;
+		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
+				migration_lists);
+huge_out:
+		spin_unlock(ptl);
 		return 0;
+	}
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	folio = vm_normal_folio(walk->vma, addr, ptent);
-	if (!folio)
+	start_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
 		return 0;
 
-	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
-		return 0;
+	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
+		nr = 1;
+		ptent = ptep_get(pte);
 
-	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
-		migration_lists);
+		if (pte_none(ptent) || !pte_present(ptent))
+			continue;
+		folio = vm_normal_folio(walk->vma, addr, ptent);
+		if (!folio)
+			continue;
+		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
+			return 0;
+		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
+				migration_lists);
+		nr = folio_nr_pages(folio);
+	}
+	pte_unmap_unlock(start_pte, ptl);
 	return 0;
 }
 
@@ -822,7 +812,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct mm_walk_ops walk_ops = {
 		.pmd_entry = damos_va_migrate_pmd_entry,
-		.pte_entry = damos_va_migrate_pte_entry,
+		.pte_entry = NULL,
 		.walk_lock = PGWALK_RDLOCK,
 	};
 
-- 
2.47.3
