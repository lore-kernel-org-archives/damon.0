Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636119511
	for <damon@lists.linux.dev>; Mon, 12 Jun 2023 15:16:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B86513D5;
	Mon, 12 Jun 2023 08:16:56 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 929F13F5A1;
	Mon, 12 Jun 2023 08:16:06 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: [PATCH v3 2/3] mm: Move ptep_get() and pmdp_get() helpers
Date: Mon, 12 Jun 2023 16:15:44 +0100
Message-Id: <20230612151545.3317766-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230612151545.3317766-1-ryan.roberts@arm.com>
References: <20230612151545.3317766-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are many call sites that directly dereference a pte_t pointer.
This makes it very difficult to properly encapsulate a page table in the
arch code without having to allocate shadow page tables.

We will shortly solve this by replacing all the call sites with
ptep_get() calls. But there are call sites above the function definition
in the header file, so let's move ptep_get() to an earlier location to
solve that problem. And move pmdp_get() at the same time to keep it
close to ptep_get().

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a1326e61d7ee..fc06f6419661 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,6 +212,20 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+#endif
+
+#ifndef pmdp_get
+static inline pmd_t pmdp_get(pmd_t *pmdp)
+{
+	return READ_ONCE(*pmdp);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
@@ -317,20 +331,6 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 	ptep_get_and_clear(mm, addr, ptep);
 }
 
-#ifndef ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-#endif
-
-#ifndef pmdp_get
-static inline pmd_t pmdp_get(pmd_t *pmdp)
-{
-	return READ_ONCE(*pmdp);
-}
-#endif
-
 #ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
 /*
  * For walking the pagetables without holding any locks.  Some architectures
-- 
2.25.1

