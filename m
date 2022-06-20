Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C67B
	for <damon@lists.linux.dev>; Mon, 20 Jun 2022 02:34:55 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGpSCch_1655692491;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGpSCch_1655692491)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 10:34:52 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: mike.kravetz@oracle.com,
	songmuchun@bytedance.com,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Use set_huge_pte_at() to make huge pte old
Date: Mon, 20 Jun 2022 10:34:42 +0800
Message-Id: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

The huge_ptep_set_access_flags() can not make the huge pte old according
to the discussion [1], that means we will always mornitor the young state
of the hugetlb though we stopped accessing the hugetlb, as a result DAMON
will get inaccurate accessing statistics.

So changing to use set_huge_pte_at() to make the huge pte old to fix this
issue.

[1] https://lore.kernel.org/all/Yqy97gXI4Nqb7dYo@arm.com/

Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/vaddr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 5767be72c181..d24148a8149f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -337,8 +337,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 	if (pte_young(entry)) {
 		referenced = true;
 		entry = pte_mkold(entry);
-		huge_ptep_set_access_flags(vma, addr, pte, entry,
-					   vma->vm_flags & VM_WRITE);
+		set_huge_pte_at(mm, addr, pte, entry);
 	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-- 
2.27.0

