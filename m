Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333A1F940
	for <damon@lists.linux.dev>; Thu, 11 May 2023 13:21:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA32B165C;
	Thu, 11 May 2023 06:22:08 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F4EA3F5A1;
	Thu, 11 May 2023 06:21:23 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	SeongJae Park <sj@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Date: Thu, 11 May 2023 14:21:09 +0100
Message-Id: <20230511132113.80196-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511132113.80196-1-ryan.roberts@arm.com>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is bad practice to directly set pte entries within a pte table.
Instead all modifications must go through arch-provided helpers such as
set_pte_at() to give the arch code visibility and allow it to validate
(and potentially modify) the operation.

Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9683573f1225..d8d2fe797c55 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
 static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
 {
 	struct vmap_pfn_data *data = private;
+	pte_t ptent;

 	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
 		return -EINVAL;
-	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
+
+	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
+	set_pte_at(&init_mm, addr, pte, ptent);
 	return 0;
 }

--
2.25.1

