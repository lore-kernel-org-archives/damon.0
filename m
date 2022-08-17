Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3252561
	for <damon@lists.linux.dev>; Wed, 17 Aug 2022 06:26:43 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMUBGX4_1660717281;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMUBGX4_1660717281)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 14:21:22 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Validate if the pmd entry is present before accessing
Date: Wed, 17 Aug 2022 14:21:12 +0800
Message-Id: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

The pmd_huge() is used to validate if the pmd entry is mapped by a huge
page, also including the case of non-present (migration or hwpoisoned)
pmd entry on arm64 or x86 architectures. Thus we should validate if it
is present before making the pmd entry old or getting young state,
otherwise we can not get the correct corresponding page.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/vaddr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6..1d16c6c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_present(*pmd)) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (pmd_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
 			spin_unlock(ptl);
@@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_present(*pmd)) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (!pmd_huge(*pmd)) {
 			spin_unlock(ptl);
 			goto regular_page;
-- 
1.8.3.1

