Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89C33ADB3;
	Wed, 12 Nov 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962140; cv=none; b=GT4Ho0olAC0SPFAD0MggYghytWZQp6q9B8piUyax1vmYIQtWHyPAjuJtoQ1+AtKU/i/xmhB/FBB6yycs9jBR9eo+8XoeRKs78vKzkz3V5FdVUifDDouuYvFo/F1DmQQMDrjxogQN5Gv8hpa38rq22iYYgqTTPPWt5ve+mHsbYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962140; c=relaxed/simple;
	bh=1rHJgGszkdfaLNjPQTgFPJf9bjvlypOeFoo13vrtMto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jlj2XrdsojU7OhGYYHZomEBSW1mcy5Abh9oAwCWy+LRudHmEZB06aXd0MarMNlrPeIUrXeB15ZgdsTH1LzkEsAIIPp9AocV4CI6fDNcI58IzLAjGbm7hfbcxDos2sQlEW0UphM8Er+8cfn9kYF7eY6fqzGhdvCV4xkNhnGgKCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q476rGfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q476rGfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977D6C4CEF5;
	Wed, 12 Nov 2025 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962140;
	bh=1rHJgGszkdfaLNjPQTgFPJf9bjvlypOeFoo13vrtMto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q476rGfTrYl4tz8y5mq9CS1pT/6YlSCHU1cNxcS1yQ8qnfxTacdAaWz1jFQQnceTr
	 DE6zFlkuS6mCsTM0RV0tOC9XXJ23ZVUdZA3ghKdZg2l1qT2gxRJbjIEILdLoh3AEL1
	 2sxKFoTiOAshj+O8U2L4k9I5tRmY/us7DyiDq2OdmzqQZbtILTfbgMTjKDw2hUBPuf
	 OK61rWD5sGnqkImo1IwtrkZRX5ekoiizatRueQLw0LL9bR2v/73lDx2EbZDzJ8czTq
	 yknaZdVaOadcM0nw03uf4QBB/7xIKBAljlfyuQmFHdBl9WMRG3ziJux/jJd9IWeTit
	 JdpXoNuP94qEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 3/9] mm/damon/vaddr: cleanup using pmd_trans_huge_lock()
Date: Wed, 12 Nov 2025 07:41:06 -0800
Message-ID: <20251112154114.66053-4-sj@kernel.org>
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

Three pmd walk functions in vaddr.c are using pmd_trans_huge() and
pmd_lock() to handle THPs.  Simplify the code by replacing the two
function calls with a single pmd_trans_huge_lock() call.

Note that this cleanup is not only reducing the lines of code, but also
simplifies code execution flows for migration entries case, as kindly
explained [1] by Hugh, who suggested this cleanup.

[1] https://lore.kernel.org/296c2b3f-6748-158f-b85d-2952165c0588@google.com

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 48 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7e834467b2d8..0ad1ce120aa1 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -307,24 +307,14 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
 	pte_t *pte;
-	pmd_t pmde;
 	spinlock_t *ptl;
 
-	if (pmd_trans_huge(pmdp_get(pmd))) {
-		ptl = pmd_lock(walk->mm, pmd);
-		pmde = pmdp_get(pmd);
-
-		if (!pmd_present(pmde)) {
-			spin_unlock(ptl);
-			return 0;
-		}
-
-		if (pmd_trans_huge(pmde)) {
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		if (pmd_present(pmdp_get(pmd)))
 			damon_pmdp_mkold(pmd, walk->vma, addr);
-			spin_unlock(ptl);
-			return 0;
-		}
 		spin_unlock(ptl);
+		return 0;
 	}
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
@@ -446,21 +436,12 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(pmdp_get(pmd))) {
-		pmd_t pmde;
-
-		ptl = pmd_lock(walk->mm, pmd);
-		pmde = pmdp_get(pmd);
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		pmd_t pmde = pmdp_get(pmd);
 
-		if (!pmd_present(pmde)) {
-			spin_unlock(ptl);
-			return 0;
-		}
-
-		if (!pmd_trans_huge(pmde)) {
-			spin_unlock(ptl);
-			goto regular_page;
-		}
+		if (!pmd_present(pmde))
+			goto huge_out;
 		folio = damon_get_folio(pmd_pfn(pmde));
 		if (!folio)
 			goto huge_out;
@@ -474,8 +455,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		spin_unlock(ptl);
 		return 0;
 	}
-
-regular_page:
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
@@ -910,13 +889,10 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
 	int nr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(*pmd)) {
-		pmd_t pmde;
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		pmd_t pmde = pmdp_get(pmd);
 
-		ptl = pmd_trans_huge_lock(pmd, vma);
-		if (!ptl)
-			return 0;
-		pmde = pmdp_get(pmd);
 		if (!pmd_present(pmde))
 			goto huge_unlock;
 
-- 
2.47.3
