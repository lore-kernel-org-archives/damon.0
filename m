Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF817ABA
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 09:30:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19B1E12FC;
	Fri,  2 Jun 2023 02:30:51 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C874E3F7BD;
	Fri,  2 Jun 2023 02:30:03 -0700 (PDT)
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
	Yu Zhao <yuzhao@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] mm: vmalloc must set pte via arch code
Date: Fri,  2 Jun 2023 10:29:46 +0100
Message-Id: <20230602092949.545577-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602092949.545577-1-ryan.roberts@arm.com>
References: <20230602092949.545577-1-ryan.roberts@arm.com>
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
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
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

