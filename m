Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931F318C22
	for <damon@lists.linux.dev>; Thu, 18 May 2023 11:07:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08C52F4;
	Thu, 18 May 2023 04:08:24 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0033F793;
	Thu, 18 May 2023 04:07:38 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/5] mm: vmalloc must set pte via arch code
Date: Thu, 18 May 2023 12:07:23 +0100
Message-Id: <20230518110727.2106156-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518110727.2106156-1-ryan.roberts@arm.com>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is bad practice to directly set pte entries within a pte table.
Instead all modifications must go through arch-provided helpers such as
set_pte_at() to give the arch code visibility and allow it to check
(and potentially modify) the operation.

Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9683573f1225..48202ec5f79a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2899,10 +2899,16 @@ struct vmap_pfn_data {
 static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
 {
 	struct vmap_pfn_data *data = private;
+	unsigned long pfn = data->pfns[data->idx];
+	pte_t ptent;
 
-	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
+	if (WARN_ON_ONCE(pfn_valid(pfn)))
 		return -EINVAL;
-	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
+
+	ptent = pte_mkspecial(pfn_pte(pfn, data->prot));
+	set_pte_at(&init_mm, addr, pte, ptent);
+
+	data->idx++;
 	return 0;
 }
 
-- 
2.25.1

