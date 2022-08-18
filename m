Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6423C8
	for <damon@lists.linux.dev>; Thu, 18 Aug 2022 07:38:05 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VMZnOiw_1660808276;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMZnOiw_1660808276)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 15:37:57 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev,
	mike.kravetz@oracle.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon: replace pmd_huge() with pmd_trans_huge() for THP
Date: Thu, 18 Aug 2022 15:37:44 +0800
Message-Id: <a9e010ca5d299e18d740c7c52290ecb6a014dde6.1660805030.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

The pmd_huge() is usually used to indicate if a pmd level hugetlb,
however a pmd mapped huge page can only be THP in damon_mkold_pmd_entry()
or damon_young_pmd_entry(), so replacing pmd_huge() with pmd_trans_huge()
in this case to make code more readable according to the discussion [1].

[1] https://lore.kernel.org/all/098c1480-416d-bca9-cedb-ca495df69b64@linux.alibaba.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 - New patch in v2.
---
 mm/damon/vaddr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1d16c6c..cc04d46 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -302,14 +302,14 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (pmd_huge(*pmd)) {
+	if (pmd_trans_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (!pmd_present(*pmd)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (pmd_huge(*pmd)) {
+		if (pmd_trans_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
 			spin_unlock(ptl);
 			return 0;
@@ -434,14 +434,14 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_huge(*pmd)) {
+	if (pmd_trans_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (!pmd_present(*pmd)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (!pmd_huge(*pmd)) {
+		if (!pmd_trans_huge(*pmd)) {
 			spin_unlock(ptl);
 			goto regular_page;
 		}
-- 
1.8.3.1

