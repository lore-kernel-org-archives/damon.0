Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0624683
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 14:22:44 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPtLfkE_1663251760;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPtLfkE_1663251760)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 22:22:41 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH V1 2/2] mm/damon/core: remove duplicate check about THP
Date: Thu, 15 Sep 2022 22:22:37 +0800
Message-Id: <20220915142237.92529-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220915142237.92529-1-xhao@linux.alibaba.com>
References: <20220915142237.92529-1-xhao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_young_pmd_entry(), it calls pmd_trans_huge() to check whether
the OS supports THP, if CONFIG_TRANSPARENT_HUGEPAGE is not included,
the pmd_trans_huge() will return 0.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/vaddr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58bf1bbad530..21daaa5503fb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -434,7 +434,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct page *page;
 	struct damon_young_walk_private *priv = walk->private;

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (!pmd_present(*pmd)) {
@@ -462,7 +461,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}

 regular_page:
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */

 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return -EINVAL;
--
2.31.0
