Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C3545D95;
	Wed,  9 Sep 2026 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962659; cv=none; b=pmUNDkefiUt83o46s6ZxKajDLh1zENIc7alTqLVXEMuJ4odv7xRwYkHJs8CYSqcPm9xglwwLxRmBG83zOn3QNyLyfnOy1xIsXzZ8EGH/6/ZdyFVR8bN0DqOFgmMFANd/ss2AhAYcIIwepmT/h/A5mik0zypOAEsoeLgJRBQcCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962659; c=relaxed/simple;
	bh=6XNabZx0rdT/us2xD8F3Yx1aNqF1vaFNgfnZgADOfSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgGeIU29aH/hc4tLk4r1QdNS51pHwMaAFHA9uKqEWzDH+YDfwVGG2MY8LkSxnptrNQH2SILmTQ65tUZ60nKv5Pp0X+EFl0oRNnmnqQum1jTwfi0B5SBgCNIx/PyGf1D1d7IAa6k4s2LKcU7OkDV3mzUg3JVPAkQjjQOANQPv8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2y1dlMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2y1dlMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3EC1F00ADF;
	Wed,  9 Sep 2026 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962657;
	bh=ljZqDnomsr/PzAJ3OgMACOqJ7QipPXHSesCap1Ut72A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L2y1dlMuE1ixFnYJgeWuEsNa0dHmIaaRkNfYW4OozjKIFHFiLRMh/P1LhSWsqnfns
	 bMnpWg+MZ6hPnCLw3TLsTaIqAW0Ek3iPAcHqrz2r7SX7uEljBcquT53jY2ZbkGX3Wt
	 4haLBzVPRGdcmA1JFJ4ZxcJkX6ULPYWFF4BeW9scwBUJknirN1KDkhdmQwN4jkBjK+
	 sl69H66rhyAvRFtivWso31yMuxp4UwoSUcTbKa5VURMN8+WgV1jKiT7bV6eaXHfpDD
	 MGdhFnZqLPt9yCUnr4ov4Z9d4OJbluXNWBpoWh1XBcsnzvKxsrFzbBdjJ0RxKsv+wd
	 nVW+Y+BCH3Piw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH REPOST 4/5] mm/damon/vaddr: extend apply_probes() for hugetlb
Date: Wed,  9 Sep 2026 07:04:06 -0700
Message-ID: <20260909140408.104699-5-sj@kernel.org>
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

DAMON virtual address space operation set(vaddr) does not support
hugetlb pages in apply_probes.  Extend it for hugetlb pages.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7c548ec0cf6b5..45239f05e113b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -598,6 +598,34 @@ static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int damon_va_probe_hugetlb_entry(pte_t *pte, unsigned long hmask,
+		unsigned long addr, unsigned long end, struct mm_walk *walk)
+{
+	struct damon_va_probe_walk_private *priv = walk->private;
+	struct hstate *h = hstate_vma(walk->vma);
+	struct folio *folio;
+	spinlock_t *ptl;
+	pte_t entry;
+
+	ptl = huge_pte_lock(h, walk->mm, pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
+	if (!pte_present(entry))
+		goto out;
+
+	folio = pfn_folio(pte_pfn(entry));
+	folio_get(folio);
+	damon_va_probe_folio(priv->ctx, priv->r, folio);
+	folio_put(folio);
+
+out:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damon_va_probe_hugetlb_entry NULL
+#endif /* CONFIG_HUGETLB_PAGE */
+
 static void __damon_va_apply_probes(struct damon_ctx *ctx,
 		struct mm_struct *mm,  struct damon_region *r)
 {
@@ -607,7 +635,7 @@ static void __damon_va_apply_probes(struct damon_ctx *ctx,
 	};
 	struct mm_walk_ops damon_probe_walk_ops = {
 		.pmd_entry = damon_va_probe_pmd_entry,
-		.hugetlb_entry = NULL,
+		.hugetlb_entry = damon_va_probe_hugetlb_entry,
 	};
 	unsigned long addr = r->sampling_addr;
 
-- 
2.47.3
