Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29B2DEA95
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066852; cv=none; b=ZGr9MTh+bMsbERCSTM7RPZ4y39E2RP65kBQ3+KCNYY973Z38q5f5DC7JKiGTxXu0HtKG+sEIaOmTtrbfcqtUCLNdxKvhtw4Khu3eUaYCNFHaBht29yi+2rnX70VxjE0IlbKecJDN1POjJ8+Ro8X7mBKpohYO4NOrpw6MyZHHMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066852; c=relaxed/simple;
	bh=Q33HR5Se8BzslnbssUes1Zl68yaouorY+HmA1jQ/xyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7EgfdxFK8r5JzJzqnrEb/R6JwHltduMCaKSQFbCD1wS8GBiUa6wVk+1UlMX+sWyVUP4fb0UQsx3ki/LCpMqV7ztvhn3iNxHAuEKmuhWA+D9Vy0nXRNEATdw/TXnbiKPcP9IzNjfc6/r4cksQUxYVN9g5ZsRt67S1iTzZghGYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=MlL6HOvl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="MlL6HOvl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1814304a12.1
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066850; x=1788671650; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJRx0Jd1M2+awD7NVhe4CKIIkdBtWXqqpTIhZLTtZn4=;
        b=MlL6HOvloeGToLINBeHJHPI/oUEVktjiNJo0f0axOlwiODGeRsjoNUM7G6q//+ttQ5
         G3kGt4SeS4eY7eXEloQ5Y8VKeVDEC0WztvKpXdXe+NPFekEmEK08peP8W348g60UoWS/
         MQC//yhvtbxExNZzdeL/aGuxAwhPAuFyQGdFtbxlHi2+65cuCCTb2UJbyrYR31czEHB6
         HmTnjEWJgcp0zlg2EuBd5uM39N0xNVUVgah/YkSo6T1AVxsD9SSVnOmJBsWC3Eri8EHj
         a4JYI7LWNJitHWVmTQJPbqhTxVpA7BxDJEiZV7U2+lrlGcpY9Bd0hu8/dQY0x6/WKrVD
         WgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066850; x=1788671650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJRx0Jd1M2+awD7NVhe4CKIIkdBtWXqqpTIhZLTtZn4=;
        b=Da5jae1g4Rytqyckphv5JZKNKRblo649cHISqepYV4RVeLV60NZxqidkrAFBSXBKNV
         69IpOCJImV+IyrynkHUX6YL7DiLe4CDd2UJtaGPSd4cPgpAY2hYEA8voHxZMsswck2Ym
         XuRYv6BXu/bMoB9T4qOjBrpfA6G1kxcByplSnzTwcero68xo2PjsOzZ7U7/2lUrkpggZ
         82lRqYclMOGJyQN8QcVYSlhXjFjffOQQsBCNK6pYZYxxgnrzfl0OC+dy6We0pl9P4uHa
         1TWfH2TmfKHYYzFjjtrpg1p6h8YEE1E493RrW1EihHfqZeAEwTjhl332L2S1FPj6m863
         VmJg==
X-Forwarded-Encrypted: i=1; AHgh+RrM2bPFEh8d3vv0etzoXOY4FKx64cFg513NS/wlKhMvpiArlpxik18CUha/Y47lem6ZwpPqZw==@lists.linux.dev
X-Gm-Message-State: AFuF++loYKV1gAFyQz5bYJapkGsG/YPHQjUGsjVFZ2tHRfXawutQppoY
	I/bbA29wE0N59584nS4zq9MPX7AkF0u0arlbyps6fI/AdAyD1PY+1xWoDcwoIZPGCRc=
X-Gm-Gg: AR+sD10Ncs3Ynvbi+sp1iBfCO3G27ntQEkzA9YIIvBimYCOf5lcTKOZXNq3gZnpcHlT
	7FZ9A2aGZaexoYZIdS3CJWpvwLNYDjbd2J4VE9O+YJNj80FA5fBJ/9c4SpwmxEmUhT4jK7C8O0X
	/9zZDXiHjoDP/F8nA4HkcMaX2IJ+m4pkrXRs05XDC4t6hGYqvel7nUnXxxUd/n8GamvSlZr1sUZ
	TxqWLonoGtQs7dVnG+d3f9LwElwdsYe6bNnL7WqOZ8tv9MD8MhjyYL28+RWbHaMh60ySbaz9h4h
	CjGECUOWcg4GdoprFW/Mac9G3N6kxGRQwD6sHkkFZqsBrHYpgAoRq2RExOZBKZZR/H7S2kG/vAt
	K6IPDmu4h4lcNcPmzDE6nZd2lzDDjKHXL3GPULC3o3ALxZhxf8EoanVIG7AkHwBWzjBOfKy0Acb
	1rx/WcIf+t48tfBcKpNTKq2N4Gl055Z29ay+TqbspJiqPF+wA3nKSw0a76cnz2IuNKs0pvD4Md5
	LMrpNYU0FhhqREXopgXFMqUIJCubIQfbR0=
X-Received: by 2002:a05:6a21:328b:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3d2688b71f4mr29680395637.18.1788066850343;
        Sat, 29 Aug 2026 22:14:10 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:10 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 1/6] mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
Date: Sat, 29 Aug 2026 22:14:02 -0700
Message-ID: <20260830051407.50008-2-kiyer@crusoe.ai>
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

damon_hugetlb_mkold() clears the accessed bit of a hugetlb-mapping huge
PTE and propagates the aging to secondary MMUs via
mmu_notifier_clear_young(), spanning the whole huge page size.  It
currently lives in vaddr.c, and is thus usable only by the virtual
address space monitoring operations set.

The physical address space monitoring operations set will need the same
logic, to support access monitoring of hugetlb-backed memory.  Move the
function to ops-common as-is, with no behavioral change.  A follow-up
change will use it from the folio-granular rmap walkers.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/ops-common.c | 30 ++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  9 +++++++++
 mm/damon/vaddr.c      | 27 ---------------------------
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index fbda70d8ea4d..f5fe92b825bb 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -3,6 +3,7 @@
  * Common Code for Data Access Monitoring
  */
 
+#include <linux/hugetlb.h>
 #include <linux/migrate.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
@@ -98,6 +99,35 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	bool referenced = false;
+	pte_t entry = huge_ptep_get(mm, addr, pte);
+	struct folio *folio = pfn_folio(pte_pfn(entry));
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	folio_get(folio);
+
+	if (pte_young(entry)) {
+		referenced = true;
+		entry = pte_mkold(entry);
+		set_huge_pte_at(mm, addr, pte, entry, psize);
+	}
+
+	if (mmu_notifier_clear_young(mm, addr,
+				     addr + huge_page_size(hstate_vma(vma))))
+		referenced = true;
+
+	if (referenced)
+		folio_set_young(folio);
+
+	folio_set_idle(folio);
+	folio_put(folio);
+}
+#endif	/* CONFIG_HUGETLB_PAGE */
+
 #define DAMON_MAX_SUBSCORE	(100)
 #define DAMON_MAX_AGE_IN_LOG	(32)
 
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 38d295488fa1..f7811c9c7a02 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -9,6 +9,15 @@ struct folio *damon_get_folio(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
+#ifdef CONFIG_HUGETLB_PAGE
+void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr);
+#else
+static inline void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+}
+#endif	/* CONFIG_HUGETLB_PAGE */
 void damon_folio_mkold(struct folio *folio);
 bool damon_folio_young(struct folio *folio);
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65..15379d984689 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -293,33 +293,6 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
-				struct vm_area_struct *vma, unsigned long addr)
-{
-	bool referenced = false;
-	pte_t entry = huge_ptep_get(mm, addr, pte);
-	struct folio *folio = pfn_folio(pte_pfn(entry));
-	unsigned long psize = huge_page_size(hstate_vma(vma));
-
-	folio_get(folio);
-
-	if (pte_young(entry)) {
-		referenced = true;
-		entry = pte_mkold(entry);
-		set_huge_pte_at(mm, addr, pte, entry, psize);
-	}
-
-	if (mmu_notifier_clear_young(mm, addr,
-				     addr + huge_page_size(hstate_vma(vma))))
-		referenced = true;
-
-	if (referenced)
-		folio_set_young(folio);
-
-	folio_set_idle(folio);
-	folio_put(folio);
-}
-
 static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				     unsigned long addr, unsigned long end,
 				     struct mm_walk *walk)
-- 
2.54.0

