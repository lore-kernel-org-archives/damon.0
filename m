Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF043176EE
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317826; cv=none; b=Lx6HWJDzoVSlMGOV6ct8jwr4/dfPBixp3WoTLaimwZmJ4PKjMatO8v4s4mfjqi71QRvUwxeGR9jBBF5xcaM+wvip/PvGqBy45apFkfNFIizIZoAy6Zft26QuOmYQn37H68JZuE89TckI0hoQUJpOdDk39D7gdSmILx0lAprvcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317826; c=relaxed/simple;
	bh=eBn+z7TlwgewlJK+Ia5ZWGepJjvlAmHD0tU++xL2fWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0a+0FIK/CN9A7WkU5BfyNdvP573WmSNHXYNcnDz9k6YJKk40o0L2hCKdVkrliUJO9DGh684iqwEqytgDTAixei5qZ2D1sxrte3WzhBLkIW5N62qXQ/kqaiObJmOn7N1RAzudAVPOU+ri23+BXU49tJDj/vo4B0QpbpAaPnrb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=IFRIwQAm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="IFRIwQAm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso5590375ad.3
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 19:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788317824; x=1788922624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+aB6s1JzdbmAf+ykqnt3gF+KENR2kL9PYAKepasbfI=;
        b=IFRIwQAmy5vMXghFJdcauNQFNV5TLJWvjuPQKUJTR8NwSsTWf4ZhcdCyBTMRLJZY64
         VMIz7YudnnwkefS++abOFbAfXlWFvPC614hrPWrbajEoz9VuVkIluWoCEDIiVrB3NiIE
         /64+1IxWnr4xnyQga+zsGkXFCp9+2kBfZpoMuahI93Vd+sv8oNkqTs4Io41fkmIiPaH5
         Accxgsmx9Qqdm0pf9o0+lltoLqL+sogeqINiguVQq/VOCwovNXc4H4N1DYgbTfgbA+b7
         pJmCJ1EAXdazo2RnpyQMiaZJcu5Hg0T2aNyLfJ4ejdnKLLDUfcB6BhO4swCJ9MHJtnFD
         m62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317824; x=1788922624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L+aB6s1JzdbmAf+ykqnt3gF+KENR2kL9PYAKepasbfI=;
        b=e4Yc6ZNJGAZXtAHVwBuJVbrUhif09/b55vqLk8jWzxLh1y32cG+QSXbkeZsesH44PW
         wpGQKKfwuwH8tHUtyzB3u9ByyJ0qRGO2Z5Ffe7nVVMZAj3wqAu40fjNKeP50PBQwIsPL
         TwHSfieiiyIlVp+mtbMIAPInExmyjNwgKE685H65jp7kXxRqcfwC644zcAleaH/VjkU5
         tOqNPgV8CUwS0LxKt7Gjct1g2PgMiZJIM/aD875exvGJI52X8N0ufhWXjNGhfwbeOPF6
         pZdVohuIOy3ZA5BKWpXrkYbVUvMKhSBDiUEZNILM0ojT9T7BSx7/J4p9d9fFm4y/nSK2
         rKFw==
X-Forwarded-Encrypted: i=1; AKwUvBzwX2ZMe3Y1HIyWIIRE539acB1QJtUoe4LHUlETlvFbTdCc22WlPzrq5LzMscJoNOWgv3ohWQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kA95iSSQbkifzi3mPbUPrp+MFm9/1YFAtnNRKt34ikMBm+DF+F
	4Ru+JxmU5ZsENZUG0hWb3eCjtzaYwHaYSUsa2EiO4T/pZYKZ7Rdc/RZTbcUO9lld6cg0v0b3+S9
	/ewUi8Gk=
X-Gm-Gg: AYBFou1UUuK4yiVYM0n29Vz/HT3Luggv5+sNFHiK6ZRzfmYShGYuBqz8bkzx6kWox7v
	8fB1D55r34V2dnOXeMmlJLefeSaqhbxnJqpVJBrWSGnIzhb3ORKFxjwSM4uhtN2GZVzWhjvI3xP
	oiy822Cgfyt20JkOyc84LWZYrLMF5SEU9+SjKHtKkPJU1hbqARhGVIoe92TO1RekKOQzcoZtFpK
	j8MrVRc9nE0lzVurggeZTcusp4A+qT5W+9eN1D03Eigp24sRPz2s/TDs82RErqqHKDFVsjCytFO
	1G7xr4R5FHGUrWZwnfGeDSfEg+a64cmM0fjF0MBTuSIKF8/7SYBDHuxByFR3q+w3yehA4tI+oef
	fBk/1bUJ7OS7GrUZiomq1mb/H/K0keieu5+TbIQRXZWEwwU9RoEUl+6FbCU38t7h85ECtmDOw7e
	WMXE9hJb4NAAYzFvOcqyR5lXzcSKJL4vhZprwInFOGGix9+rXcINJWSxTW8d0Xvx6473a0JZBq+
	7iiJn5AtUJ7DTxTxfL5ELsYPZOwC9Q4N5s82g==
X-Received: by 2002:a17:902:e809:b0:2d7:4b42:9352 with SMTP id d9443c01a7336-2daec60af43mr22931655ad.3.1788317824344;
        Tue, 01 Sep 2026 19:57:04 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:a1c2:77c:7ab7:f9a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07bde5bfsm2066469eec.27.2026.09.01.19.57.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 19:57:04 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
Date: Tue,  1 Sep 2026 19:56:58 -0700
Message-ID: <20260902025700.17975-2-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902025700.17975-1-kiyer@crusoe.ai>
References: <20260902025700.17975-1-kiyer@crusoe.ai>
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
Reviewed-by: SJ Park <sj@kernel.org>
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

