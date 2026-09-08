Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324C53ED08;
	Tue,  8 Sep 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875530; cv=none; b=QOz2sb+LyUZMgClZqIvvt5nr6gY+pKMbU1srDwsRIPreX57lpddJt+6NMnS8QsgU5EZTCqmefXurCJIjOpc030Alb93U8NnFVZOz7mfIolz8SAULk6SKs/grt+vPk9uJYj9Y2MbKKXKf5ahZh2w0p/VyDLXLJpzBsFiEP4KXluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875530; c=relaxed/simple;
	bh=+K4xTvSkKif75qG4vxNMmd1if/dED4tM7Xr2M32c6SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmnpVUJOr7HGv3kv2WVzLLC/cz8esy501wRu9nl+ifyCxw0qrWMT6x7CyXOdogk5aDYlnlDceINfoLfn7nfzlv1gt/9xGK9cnxRJXE4rgaBNlOuRASBbmJbLVkTkdCr8nVK74bM3Wkwm8TUyfdHc3J+69Vu+19A13JEyd3dGUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3+r43w9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3+r43w9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25521F00ACA;
	Tue,  8 Sep 2026 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875524;
	bh=hbhWqGHP3IwdcG31EliQltqMq/ikBw+QUFL967DHBK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3+r43w92haZ4/6h+NEX+yvlEVncdTDrKytnbWI0M8fT87s/vDS11yKyUCSiOlDm0
	 iyO0FmIXd//l+XRftblxtTIl8OTR5E2rj9iuLrwXYP1KY4sPbbqNtGHxImzC8jp6jz
	 qVPtLROBDJZnukrHdgtAXZusmW7LJeRt/Ka9J4bQkPAfCLByACdIpBfT2sKnsK53Af
	 xKjO6a1A8b+xui07xjlORaH2lkzvAQ7JywBg7EJ16r//tDIg03FHGcJ6KPYJth0LuI
	 ZCwxELgh+DrFXUbnEdOcv5L0cAngD/p1QoCfSMQeO0v1f8P6SO+J1Jd6bTlqHk5lcf
	 NFya6CFQn33bw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Krishna Iyer <kiyer@crusoe.ai>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/3] mm/damon/paddr: support hugetlb folios in access monitoring
Date: Tue,  8 Sep 2026 06:51:55 -0700
Message-ID: <20260908135156.97481-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908135156.97481-1-sj@kernel.org>
References: <20260908135156.97481-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krishna Iyer <kiyer@crusoe.ai>

DAMON's physical address space monitoring is blind to hugetlb-backed
memory.  Every access check starts at damon_get_folio(), which rejects
folios that are not on the LRU lists.  Hugetlb folios are managed
outside of the LRU by design, so every sampling attempt on
hugetlb-backed memory silently fails and the pages are reported as
never accessed.

This is a significant blind spot on virtualization hosts.  Cloud
hypervisor hosts commonly back guest memory with 1 GiB hugetlbfs pages,
covering the vast majority of the machine's memory.  On such hosts,
modules like DAMON_STAT observe only the host-side remainder (page
cache, daemons) and report all guest working sets as permanently
idle, defeating the purpose of host-level access monitoring.  In
testing on a 1 TiB host, an hour of 4-thread random access over 842 GiB
inside a guest was statistically indistinguishable from an idle host,
while a 40x smaller host-side workload produced a quantitatively
correct response.

Add damon_get_monitor_folio(), which additionally accepts hugetlb
folios, and use it in the two paddr access monitoring primitives,
damon_pa_mkold() and damon_pa_young().  With the previous commit
teaching the folio-granular rmap walkers to age huge PTEs and to call
the mmu notifiers spanning the whole huge page, this makes guest
accesses visible through secondary MMU (e.g. KVM/EPT) young bits.

Free hugetlb pool folios have a zero refcount, so folio_try_get()
naturally keeps rejecting them.

The DAMOS action appliers (damon_pa_pageout(),
damon_pa_mark_accessed_or_deactivate(), damon_pa_migrate(),
damon_pa_stat()) keep using damon_get_folio(): reclaim, LRU
manipulation and migration cannot act on hugetlb folios, so their
behavior is unchanged.

Note that the access check granularity for hugetlb-backed memory is the
huge page size: one touched byte reports the whole (up to 1 GiB) page
as accessed.  Also, DAMON now consumes secondary MMU young bits that
KVM's own aging uses; at DAMON's sampling rate (one page per region per
sampling interval) the interference is negligible.

Link: https://lore.kernel.org/20260902025700.17975-4-kiyer@crusoe.ai
Cc: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 25 +++++++++++++++++++++----
 mm/damon/ops-common.h |  1 +
 mm/damon/paddr.c      |  4 ++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 349e1604cc1b1..acf8f216c51cc 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -15,14 +15,20 @@
 #include "../internal.h"
 #include "ops-common.h"
 
+static bool damon_folio_acceptable(struct folio *folio, bool monitor)
+{
+	return folio_test_lru(folio) ||
+		(monitor && folio_test_hugetlb(folio));
+}
+
 /*
- * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
- * NULL.
+ * Get an online page for a pfn if it's in the LRU list, or a hugetlb folio if
+ * @monitor is set.  Otherwise, returns NULL.
  *
  * The body of this function is stolen from the 'page_idle_get_folio()'.  We
  * steal rather than reuse it because the code is quite simple.
  */
-struct folio *damon_get_folio(unsigned long pfn)
+static struct folio *__damon_get_folio(unsigned long pfn, bool monitor)
 {
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
@@ -33,13 +39,24 @@ struct folio *damon_get_folio(unsigned long pfn)
 	folio = page_folio(page);
 	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
+	if (unlikely(page_folio(page) != folio) ||
+			!damon_folio_acceptable(folio, monitor)) {
 		folio_put(folio);
 		folio = NULL;
 	}
 	return folio;
 }
 
+struct folio *damon_get_folio(unsigned long pfn)
+{
+	return __damon_get_folio(pfn, false);
+}
+
+struct folio *damon_get_monitor_folio(unsigned long pfn)
+{
+	return __damon_get_folio(pfn, true);
+}
+
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
 	pte_t pteval = ptep_get(pte);
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index f7811c9c7a024..172f0f17c4a84 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -6,6 +6,7 @@
 #include <linux/damon.h>
 
 struct folio *damon_get_folio(unsigned long pfn);
+struct folio *damon_get_monitor_folio(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index c1e7d7a4f40df..d2173a448d0b0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -37,7 +37,7 @@ static unsigned long damon_pa_core_addr(
 
 static void damon_pa_mkold(phys_addr_t paddr)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
 
 	if (!folio)
 		return;
@@ -67,7 +67,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 static bool damon_pa_young(phys_addr_t paddr)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
 	bool accessed;
 
 	if (!folio)
-- 
2.47.3
