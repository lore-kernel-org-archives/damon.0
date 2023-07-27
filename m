Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436DB27159
	for <damon@lists.linux.dev>; Thu, 27 Jul 2023 18:39:10 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso8806825e9.1
        for <damon@lists.linux.dev>; Thu, 27 Jul 2023 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483148; x=1691087948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NF0AAzp00VPKSBWIz1veCNt0J3woGem5lOOY6FNXLkY=;
        b=aqF4+TegclUGZOLtF/MB6RYFv+Nx2SbGXYzuENSiYPwAbk6epOs9CvWFIc+u8lPNRJ
         Xy/WBXKMScoZxNo4XP2hNshAfYRhTNd4OkWGBtLpRwceSafX0NFB1gqZ6ssUcXsc+n7n
         q35C+VpD3mLJblOjzy8FW+CdBvBnqSxIc9HKk05RsqE3TCrGjeudcYRwq6HtqIVCQO8R
         ENblDi74Ul7a51M3D+4drzSY6jnQRxs3wRV11YgyLwHG7RVw8j/OzlGqHiAhp/x1VhVN
         69K11ePcdX4SxLa0EuCenwA42T23J2917FeEwyqwJg1kq2JJ1gtl4xid/IOKfsBRdfFq
         uVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483148; x=1691087948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF0AAzp00VPKSBWIz1veCNt0J3woGem5lOOY6FNXLkY=;
        b=FFsHDrTBPvj8BvJXuxKdovk4QvFXtEATtSf1DSGB8TCmdCDZ/WQnWgQsFS/v9+INkj
         v+NESVp3IVV1iMwA/VQ7Ynuh2UqWiJWu9cmwfzojppIHHHHVWtcl+qsTwdqa3OHhK9qj
         X/G+093xfzoHnlYN1ITOutOQ/2q8a2XuvdAK3qiUjffzBj723kdlsVbiJPr+8lN8wmcB
         hTGmh/pOQP+pslxqCwNlFJbRygk6Tpv8yHDfAF92I2RigOxv7lFniPHE3QIDVSNzxOO1
         yxV2wyL9vnccy1uhQDdHfydfMCPileoCW++zYUQaQwHa2pRjxx4anSQ2oq+htGuhSG+0
         QXMw==
X-Gm-Message-State: ABy/qLZmhQSBGJscx7y4Ju+SFNHgyVTzSSrkOT2VCjsYPjgKSo3Mi6pb
	ATpivLAOpV6A2t1te27KEfk=
X-Google-Smtp-Source: APBJJlEWoFbRwReSvEmnOzCNHN4d6L+Ko4ImG7PEidfC7KxqZCNGdz9ooufvrkKp/Ql+K2+xOrLpkA==
X-Received: by 2002:a05:600c:82c7:b0:3fa:821e:1fb5 with SMTP id eo7-20020a05600c82c700b003fa821e1fb5mr2837725wmb.5.1690483147803;
        Thu, 27 Jul 2023 11:39:07 -0700 (PDT)
Received: from localhost.localdomain (host31-52-141-59.range31-52.btcentralplus.com. [31.52.141.59])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b003fb40ec9475sm2473228wml.11.2023.07.27.11.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:39:07 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
Date: Fri, 28 Jul 2023 03:37:45 +0900
Message-Id: <20230727183745.682880-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As ptep_get, Use the pmdp_get wrapper when we accessing pmdval
instead of direct dereferencing pmd.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/damon/ops-common.c |  2 +-
 mm/damon/paddr.c      |  2 +-
 mm/damon/vaddr.c      | 22 ++++++++++++++--------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e940802a15a4..ac1c3fa80f98 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -54,7 +54,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
+	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
 
 	if (!folio)
 		return;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 40801e38fcf0..909db25efb35 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -94,7 +94,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			*accessed = pmd_young(*pvmw.pmd) ||
+			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 #else
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2fcc9731528a..82f7865719fe 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -301,16 +301,19 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
 	pte_t *pte;
+	pmd_t pmde;
 	spinlock_t *ptl;
 
-	if (pmd_trans_huge(*pmd)) {
+	if (pmd_trans_huge(pmdp_get_lockless(pmd))) {
 		ptl = pmd_lock(walk->mm, pmd);
-		if (!pmd_present(*pmd)) {
+		pmde = pmdp_get(pmd);
+
+		if (!pmd_present(pmde)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (pmd_trans_huge(*pmd)) {
+		if (pmd_trans_huge(pmde)) {
 			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
@@ -434,26 +437,29 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	pte_t *pte;
 	pte_t ptent;
+	pmd_t pmde;
 	spinlock_t *ptl;
 	struct folio *folio;
 	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(*pmd)) {
+	if (pmd_trans_huge(pmdp_get_lockless(pmd))) {
 		ptl = pmd_lock(walk->mm, pmd);
-		if (!pmd_present(*pmd)) {
+		pmde = pmdp_get(pmd);
+
+		if (!pmd_present(pmde)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (!pmd_trans_huge(*pmd)) {
+		if (!pmd_trans_huge(pmde)) {
 			spin_unlock(ptl);
 			goto regular_page;
 		}
-		folio = damon_get_folio(pmd_pfn(*pmd));
+		folio = damon_get_folio(pmd_pfn(pmde));
 		if (!folio)
 			goto huge_out;
-		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
+		if (pmd_young(pmde) || !folio_test_idle(folio) ||
 					mmu_notifier_test_young(walk->mm,
 						addr))
 			priv->young = true;
-- 
2.37.2

