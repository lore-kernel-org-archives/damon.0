Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28235678ED;
	Wed,  9 Sep 2026 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962659; cv=none; b=XlMKTvFpb/O3GnpiL+6pI1W2Mdoy7MXAPTiunwyWjZGta/ooccVJRO8uOWMA25X6d9GfNB+d1dAfnbHeoT7d9PlH+PhlP1GwyQXyVEsFLJUqf3pqE1C0KUAnONPHcXPhG3lcMphYfK/9OcmdR0j+wZJ1MFIJ2AJos5rTxho4RY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962659; c=relaxed/simple;
	bh=chJoHZKREMSQchbWk7BcihNcvxO7HU8pRLDu7X832Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0oPuvsZ1kH2l5XZe0rtlTOcgwzY3zCJWfQPurRGMknHrpIFN3qOgdMuAdItT82XPWb7Ntsu7qfvNABrtSPSLNsPYYID7/MbxTfHj7wWCyTwxFUBpGrloZB7eLiibQgVFF5kvCGhtblRCozP+RbaGVrQP2bIc5J0rWbWH5UxxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpeBgT0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpeBgT0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6441F00AC4;
	Wed,  9 Sep 2026 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962657;
	bh=XvOnZdXRT1oYcTh0OqGiqvrYhRphtRi0kIGud2JHRJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YpeBgT0TICnF9MYO0bH+bAV4LO6GtLbLvnZxUU498U1z4TDRjxPYX9wrjCOoKBK5w
	 9BUwtDs6dvIvZmcX/YVZsqzwTYUSkZfs9xIdWyodB8lh8uSypybKybSotJVPFBc8JW
	 FcN1vV1M6Gmy2wT/pr/xXUUN9hDuRYtuKSofh+M5BxYKboIU+vn1G9Fsia9p0pYFiG
	 hhv0ZaukGfgqavbwglUUouF/XvDlZPgwHubXyQTlGQy3TKJOB9I7srQDivvOljYx4T
	 tHYh0CgN1Y+NIrYjKleZUa3ZHTFXWTiMXwVxXrM2edkwU4uJyEfKeso+SGNAJyGx95
	 x2FLIyVii9osQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe filter type
Date: Wed,  9 Sep 2026 07:04:07 -0700
Message-ID: <20260909140408.104699-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909140408.104699-1-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON virtual address space operation set (vaddr) does not support
pgidle_unset probe filter type.  Add the support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 55 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 45239f05e113b..9a38dc89a156e 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -522,13 +522,49 @@ static void damon_va_prep_probes(struct damon_ctx *ctx, bool set_samples)
 	}
 }
 
-static bool damon_va_filter_pass(struct folio *folio, struct damon_probe *p)
+static bool damon_va_young_addr(struct folio *folio, pte_t *pte, pmd_t *pmd,
+		struct mm_struct *mm, unsigned long addr)
+{
+	bool young = false;
+
+	if (pte)
+		young = pte_young(*pte);
+	else if (pmd)
+		young = pmd_young(*pmd);
+	young = young || !folio_test_idle(folio) ||
+		mmu_notifier_test_young(mm, addr);
+	return young;
+}
+
+static bool damon_va_filter_match(struct damon_filter *filter,
+		struct folio *folio, pte_t *pte, pmd_t *pmd,
+		struct mm_struct *mm, unsigned long addr)
+{
+	bool matched = false;
+
+	switch (filter->type) {
+	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_va_young_addr(folio, pte, pmd, mm,
+					addr);
+		break;
+	default:
+		return damon_ops_filter_match(filter, folio);
+	}
+	return matched == filter->matching;
+}
+
+static bool damon_va_filter_pass(struct folio *folio, struct damon_probe *p,
+		pte_t *pte, pmd_t *pmd, struct mm_struct *mm,
+		unsigned long addr)
 {
 	struct damon_filter *f;
 	bool pass = true;
 
 	damon_for_each_filter(f, p) {
-		if (damon_ops_filter_match(f, folio)) {
+		if (damon_va_filter_match(f, folio, pte, pmd, mm, addr)) {
 			pass = f->allow;
 			break;
 		}
@@ -543,13 +579,15 @@ struct damon_va_probe_walk_private {
 };
 
 static void damon_va_probe_folio(struct damon_ctx *ctx,
-		struct damon_region *r, struct folio *folio)
+		struct damon_region *r, struct folio *folio,
+		pte_t *pte, pmd_t *pmd, struct mm_struct *mm)
 {
 	struct damon_probe *probe;
 	int i = 0;
 
 	damon_for_each_probe(probe, ctx) {
-		if (damon_va_filter_pass(folio, probe))
+		if (damon_va_filter_pass(folio, probe, pte, pmd, mm,
+					r->sampling_addr))
 			r->probe_hits[i]++;
 		i++;
 	}
@@ -574,7 +612,8 @@ static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
 		if (!folio)
 			goto huge_out;
-		damon_va_probe_folio(priv->ctx, priv->r, folio);
+		damon_va_probe_folio(priv->ctx, priv->r, folio, NULL, &pmde,
+				walk->vma->vm_mm);
 
 huge_out:
 		spin_unlock(ptl);
@@ -591,7 +630,8 @@ static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
 	folio = vm_normal_folio(walk->vma, addr, ptent);
 	if (!folio)
 		goto out;
-	damon_va_probe_folio(priv->ctx, priv->r, folio);
+	damon_va_probe_folio(priv->ctx, priv->r, folio, &ptent, NULL,
+			walk->vma->vm_mm);
 
 out:
 	pte_unmap_unlock(pte, ptl);
@@ -615,7 +655,8 @@ static int damon_va_probe_hugetlb_entry(pte_t *pte, unsigned long hmask,
 
 	folio = pfn_folio(pte_pfn(entry));
 	folio_get(folio);
-	damon_va_probe_folio(priv->ctx, priv->r, folio);
+	damon_va_probe_folio(priv->ctx, priv->r, folio, &entry, NULL,
+			walk->vma->vm_mm);
 	folio_put(folio);
 
 out:
-- 
2.47.3
