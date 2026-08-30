Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0BA2E7396
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066854; cv=none; b=eWMEZpuRJCsITMqUE7eyi1/KcgzN7BL4VGaNXZABpX+4ryxW+cenndCEYCgvTOEGxfFi0h9W8wDEv+KTEB8H8ckrjQkLXgin7P5HVMMtNwzOw/mGNF0F0QRsj5BO0caZSHmWJscZ+m6WROc3tJpVXaD8QIAxql7b7pY3SbG/KPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066854; c=relaxed/simple;
	bh=qDar28JySQZOFBLHqw4DU1n4wiE0RevwYt64tfL76/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPT20RN9wNMDCSR8slbT00virl+plyO2LnbEaEFIwBKjF4OqdOex47y7Bs66fAAqwxEILS1XjNKR0WE99Dsp7tqvIbNbsRJblxvwqlJtzSUH/I1usWbios2vpVZyknZYHkDeXuKVFw0K/jW3g5tULyJec6j7hb4OOLAtv3XVEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=XtCGPnSl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="XtCGPnSl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d71a50caa9so29616165ad.0
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066852; x=1788671652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ezj01Z6T9okgOiQa4EOGNSsW3Mil1bOoLksIRT0LM8A=;
        b=XtCGPnSlonoIn46VhR/1kXvjhtV992bK2GAa1sez7P13VTOYRenmbM4tjhut9O+2Qu
         IBEMAPkayXzmi3IExNCD++DJHyzZGaNbOZAVbA17eOjP0tFFxcumcqrjgN2tu8O5dfNa
         gdCg8pDotG58vJHloCPZYx8pROl3xBm7UHCJm8xxDjZdiXLVtfYO648HECh6kuCK14Zb
         Xbq1yL08A1pm5fcVmBDD1Rb/xB8EqZxwUKQzShryl61uOPiK2JeQxuBWic64O6ZDARKe
         B2GW2zMuA27yP7m1X3rLwq/PZDt9LIZEwIMQS3rqlqf7agjJWTdA+Ua4DD44VyQYirNK
         bG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066852; x=1788671652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ezj01Z6T9okgOiQa4EOGNSsW3Mil1bOoLksIRT0LM8A=;
        b=FIZa7PJ+oBT/9Ayy96Jj/mrAvuDU+CHBQM2GnftA6gS97vD4IUx/NxBmIDo401m3+R
         W6y7rgWYbG1+b3xT2fNo7Tpz4DXx8sqh7TZivJvqfAUqxeEfNy8gHTzNrVEvDD+HW9DD
         a0FSb3yFFDKM1XhpM73iT9g3/uJq+OdDCK/Ioj3mwATy8pfAMjZNryVYwUjhVj4FOSV5
         VM6zxGjaShdy6GeBd+Yk0uzru4akbrGcxZBqpVXkPPP29ePvKpSfotOVina2gaQUydHu
         BRZZdGgA/vjTQpc2VEB05BkFlYdKaIJqL1P1g4/fA6TsXRdnHuiZu4wdaWS5NR7+nKcI
         8Cgg==
X-Forwarded-Encrypted: i=1; AKwUvBz/fGPeRzuB18931mIREIOkX7MlXll0dnoli5tNjS/QwByJ2NRcOQHXHGAzEDt2Mac3v4urWA==@lists.linux.dev
X-Gm-Message-State: AFuF++mP5QGNtUsDhuSEZKvHkMlVeu02cRQKwclw17V8UsjKSX5LQUyf
	suU9CKub1q3/gTxQzZGqqdUSedOJ/ngiijRRbn9sUsrdNCQZ8nuoblxj93yP8eU+mko7mJiA39n
	fLHg15VHN4g==
X-Gm-Gg: AR+sD11joVOsainIt/0G+rRRjnDd0foPbVFDd90xreprvsaMOM3nQzKvnhAABiOHP/b
	Sh5jRYe1ceaizChy87+UMLTquBrBe2iJerLvwUUbja65p+cx22SdPkylvqUR3aCEXHryeE2gOU4
	zt2oD9MAKOEThT6S0UZVD9XwO10TZ81mpWZ4AbOxfOtOpIyUxdi91TaHwneLwdfDbSbUDcse28o
	fWyaRohWetdwohaA5XbPJ56dEF9YAVOMREvk16wLvv/xRXSLqW80jeETsiyVCJBKchKDdS35XMC
	JZuglijTz+qSKCgm+OwYXvIgnPsf5tTKDJ1HVTSUId6aHYooSyAgANWIda2CGvU3VMuDaWFxyzV
	ZqopOGFzELeq6dce5t74z+kLlORK958+Y2SQTAxZwA5PCTO1UiWMTIc4UjLY7ncCrZOEOBKYXlM
	UJusUcCjvR/PfeBXwKIqI51IsI8WhLQa8iBMe6Ktyp1/lkf7lSTi8RLOjId81o3X1ud20vQL2Ht
	t1cSwLyk0BetoA4L5ta1Y23WELKUQBBiIh3
X-Received: by 2002:a17:903:2342:b0:2d7:414e:f2f with SMTP id d9443c01a7336-2d74def676fmr265059445ad.14.1788066852465;
        Sat, 29 Aug 2026 22:14:12 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:12 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 3/6] mm/damon/paddr: support hugetlb folios in access monitoring
Date: Sat, 29 Aug 2026 22:14:04 -0700
Message-ID: <20260830051407.50008-4-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260830051407.50008-1-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's physical address space monitoring is blind to hugetlb-backed
memory.  Every access check starts at damon_get_folio(), which rejects
folios that are not on the LRU lists.  Hugetlb folios are managed
outside of the LRU by design, so every sampling attempt on
hugetlb-backed memory silently fails and the pages are reported as
never accessed.

This is a significant blind spot on virtualization hosts.  Cloud
hypervisor hosts commonly back guest memory with 1 GiB hugetlbfs pages,
covering the vast majority of the machine's memory.  On such hosts,
modules like DAMON_STAT observe only the host-side remainder (kernel,
page cache, daemons) and report all guest working sets as permanently
idle, defeating the purpose of host-level access monitoring.  In
testing on a 1 TiB host, an hour of 4-thread random access over 842 GiB
inside a guest was statistically indistinguishable from an idle host,
while a 40x smaller host-side workload produced a quantitatively
correct response.

Add damon_get_folio_incl_hugetlb(), which additionally accepts hugetlb
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

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/ops-common.c | 31 +++++++++++++++++++++++++++----
 mm/damon/ops-common.h |  1 +
 mm/damon/paddr.c      |  4 ++--
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 62004206ca31..ece101d34684 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -15,14 +15,20 @@
 #include "../internal.h"
 #include "ops-common.h"
 
+static bool damon_folio_observable(struct folio *folio, bool incl_hugetlb)
+{
+	return folio_test_lru(folio) ||
+		(incl_hugetlb && folio_test_hugetlb(folio));
+}
+
 /*
- * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
- * NULL.
+ * Get an online page for a pfn if it's in the LRU list, or a hugetlb folio if
+ * @incl_hugetlb is set.  Otherwise, returns NULL.
  *
  * The body of this function is stolen from the 'page_idle_get_folio()'.  We
  * steal rather than reuse it because the code is quite simple.
  */
-struct folio *damon_get_folio(unsigned long pfn)
+static struct folio *__damon_get_folio(unsigned long pfn, bool incl_hugetlb)
 {
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
@@ -33,13 +39,30 @@ struct folio *damon_get_folio(unsigned long pfn)
 	folio = page_folio(page);
 	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
+	if (unlikely(page_folio(page) != folio) ||
+			!damon_folio_observable(folio, incl_hugetlb)) {
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
+/*
+ * Same to damon_get_folio(), but also accepts hugetlb folios, which are
+ * managed outside of the LRU lists.  Aimed to be used by access monitoring
+ * primitives.  DAMOS actions that assume LRU-managed folios should keep using
+ * damon_get_folio().
+ */
+struct folio *damon_get_folio_incl_hugetlb(unsigned long pfn)
+{
+	return __damon_get_folio(pfn, true);
+}
+
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
 	pte_t pteval = ptep_get(pte);
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index f7811c9c7a02..68d7de49c87a 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -6,6 +6,7 @@
 #include <linux/damon.h>
 
 struct folio *damon_get_folio(unsigned long pfn);
+struct folio *damon_get_folio_incl_hugetlb(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0..09d418b2874b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -37,7 +37,7 @@ static unsigned long damon_pa_core_addr(
 
 static void damon_pa_mkold(phys_addr_t paddr)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio_incl_hugetlb(PHYS_PFN(paddr));
 
 	if (!folio)
 		return;
@@ -67,7 +67,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 static bool damon_pa_young(phys_addr_t paddr)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio_incl_hugetlb(PHYS_PFN(paddr));
 	bool accessed;
 
 	if (!folio)
-- 
2.54.0

