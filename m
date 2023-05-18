Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9411C91
	for <damon@lists.linux.dev>; Thu, 18 May 2023 11:07:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 311D91595;
	Thu, 18 May 2023 04:08:30 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB3943F793;
	Thu, 18 May 2023 04:07:43 -0700 (PDT)
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
	damon@lists.linux.dev
Subject: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully encapsulate pte_t
Date: Thu, 18 May 2023 12:07:26 +0100
Message-Id: <20230518110727.2106156-5-ryan.roberts@arm.com>
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

There are many call sites that directly dereference a pte_t pointer.
This makes it very difficult to properly encapsulate a page table in the
arch code without having to allocate shadow page tables. ptep_deref()
aims to solve this by replacing all direct dereferences with a call to
this function.

The default implementation continues to just dereference the pointer
(*ptep), so generated code should be exactly the same. However, it is
possible for the architecture to override the default with their own
implementation, that can (e.g.) hide certain bits from the core code, or
determine young/dirty status by mixing in state from another source.

While ptep_get() and ptep_get_lockless() already exist, these are
implemented as atomic accesses (e.g. READ_ONCE() in the default case).
So rather than using ptep_get() and risking performance regressions,
introduce an new variant.

Call sites will be converted to use the accessor in future commits.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..1161beab2492 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -204,6 +204,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef ptep_deref
+static inline pte_t ptep_deref(pte_t *ptep)
+{
+	return *(pte_t *)ptep;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
-- 
2.25.1

