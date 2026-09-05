Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E143A63EF;
	Sat,  5 Sep 2026 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640007; cv=none; b=AOH7EXRnPpYOUir/D9VC7l/ibH9RwAo1N+RQWXtvRz/V+1VNyjqLFWrEzYCKBmPZ9meY8YXznXyDmLKfTjxvK12maw36urAkSYS88SVlt0ueA0UGAximYlRmtAGEqHjs0ZV2oPTKGYIM24mmnZfzXImUathcsXrbbdvsVHNqIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640007; c=relaxed/simple;
	bh=6XNabZx0rdT/us2xD8F3Yx1aNqF1vaFNgfnZgADOfSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTrY9dq2ke9VxUINVWiQxpSg9GjNxJalsEoey2XwD2O6SCFlV3FoIY6d8WMemPtxN8g/8rkP5jn2SdtC1/PxuG4CC8EJfyxEGDKx2GKBhc2pgRu4nx6wHBKrzxMHC0gAxPn94zipa9O+1BuB4kBiQyWr3Q9X9jfHL8okAivzq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XELRf4FU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XELRf4FU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B591F00A3D;
	Sat,  5 Sep 2026 20:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640004;
	bh=ljZqDnomsr/PzAJ3OgMACOqJ7QipPXHSesCap1Ut72A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XELRf4FUAPre6yzEWl2c6/aeh5N/93qZx0vzARRXYRzgW4uThZBQHwN8ykfTwn/Ed
	 6sf+5Walh50v4Ew0nnhwoRDh7bFlp+OeLpYtIl1nSGIYaRU5UFGNZs7sUntx12/BZG
	 Iv8pO3SkeL/2XjeJQSa5/wnr34PKCbu/PMsJw8L0f4wmY0q4O2dJ0R6limZ2d4kgaj
	 ksbdHFPI6PZkUHbWca4XE+QhhqMro5iuvLAMhlMNqhwlxUfzSte3XSh9uQ3280GYBz
	 g6PLd5YDXIYeBxd0woGysm21P5Kz1vHxwO5LfYScELTGrCbjLVZQYMXx5dGQoHHzy9
	 gF7uC82LlAv6w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] mm/damon/vaddr: extend apply_probes() for hugetlb
Date: Sat,  5 Sep 2026 13:26:26 -0700
Message-ID: <20260905202634.88102-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905202634.88102-1-sj@kernel.org>
References: <20260905202634.88102-1-sj@kernel.org>
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
