Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C72DE709
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066853; cv=none; b=l4JFXK0pXukAggx2mQrJ1FefJ7rE5itKmnRMbBr2+JD2bLSNCIeHGCU2t+vvl6rv50dc2BlcyrF61rO3YUUBXVJQ4ZlDQkmu3i4ATHEC73D0e81hlngBH+9aTeco/z218ac9/94CdwXcjkZ6U/nLS5wia10cCuzvTuXsCtyn++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066853; c=relaxed/simple;
	bh=HkCP7VGJZpo8tqbPFVRl/GGgUC8qiBQ05t6gcGsjZ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvcAlzCt8fx4yH0Gcn7XldpQYUe52Yn/gllwWS2Z/jcheDSxq0CGoiGPdrP3vscyf6rNCafNr1O8JzAZsOThIev4LObOyQBF2/8pIntyt/SPb7y0NHsb7u3c0P8bDVQshlnEYO0JKjGggkto/6P4WIGW21dyPi6N0GFDR0H/Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=U/xzYK6/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="U/xzYK6/"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-85339ed040aso2036763b3a.1
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066851; x=1788671651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Qq90Jf7KadtS5HpHzOCYry3UrGmes12BSmNzbFVazM=;
        b=U/xzYK6/BlKqYHft0QZ/4ooXfWQj82h0Tqjc/5DKU3amq9NWOtfR5pgvV0OFAeFEpo
         KF4jpe0NLqN1Q7NzwdZ7EIrK4HyoeVl+Oq5EHpl3jvVKXiduSHNOoXvZPI1nmL04XYub
         xwy6rPOyMvinjblSNul6sDGm/voNckpYAIkAw0jSHpgpXaveLR5TFkaNPjdF5ixPbqJD
         UjtYfpFG4yVtBz8D02g9r0cWtjRMUaNtpUTl8RdMeIA8yiPs/Ep6oZZds3HU73r+fdYA
         gm4gMbmGwWl8CL3WBZM0dWvitM5cxHl8wB5gplfXDoAcAInvdPubKF066adYsUB5VKfO
         wHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066851; x=1788671651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Qq90Jf7KadtS5HpHzOCYry3UrGmes12BSmNzbFVazM=;
        b=NITYWE9OG36IWuWsGL5lNWKk8X3+QhfGw2f78kTrjsGbX/5J7WY2Ft8y49trj2uBHT
         bJdvEEaSINePalvrs+IC1Y8gaKxeVB42ICMTk/PtIQTRIcw4oandT5qspNwVWrKwQj7H
         n7AOtFoJRxgIvMQ2+PENpZxxNH1x9wuR7AzcjfTjhs+LxFp4Z+idBUKUjTRktTfZ9JBb
         ajQkThBoNynEypDnpcNuD83qHTAh4pqorpMtft7NDZiXUxkqccT7/SmPIoD76ygW9PBl
         6uOhCPbJoTCo4oVt3c08dcRyMZVi/lr2y4LYzIu1p7vSCRZbM9b++dfox0ezTT3ojaBc
         crAg==
X-Forwarded-Encrypted: i=1; AHgh+RpMpcAPLKe6O2/HIJsGhl6USyuN/LZgIkb+6sZexzOrhCVmMD1sb/X7fVJFC/wZFDRxkiNA+Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kRTByLngQAZIXY0UkTImczLNHbuViDtCyM6rUvpaiu1tjtoxd2
	aiQzvJ00yXpMU7GBf/8MJD7vTOcAYxAqlNFQPszwKgdfb2sBswCpgGw3t+0UPheCxdw=
X-Gm-Gg: AR+sD12QrSBlWkOliUn4HZaCWyxoI+7xG7Y14zNeXjXjyKtxEdH0w4yyEyxs9rDIVy4
	h+KY+U6qDq4uHA9ZPx0A3RUc4vTVXhEk3jAtWGU06nO8v1QwXnVzRDrkkn8h1I79iKeF5JleuJe
	drshDXjC2SfhXgWMDpsgb6xO2pxOkkEL+AF1ikwYk3YRuG/aMi/LRGrmKlOlinv0jDcloEpg3DG
	24s0ViVJIxii7s5Wdn6hVjriXI3YHtYqtxAL7kRKdo3pPJLq2iZWevX69hY6hjmvBHPTAeFINL3
	oEDO5PPcM77qfvnFZj+rr6VWBsuWfYb42hcJn6KK8qNaQTptEn2Z7Yr+kt/YERxdH7RhsZCTMP9
	kypRRrwBlXXNqBqKth897r/9P5Dlo5KI3JImXiFTvw2XUk9bLzDS4j0kYB17VfAb7KGYiDXNEH2
	DfT+PNFP3YnPXRj9pYkWG5XsV0h4nyPcyMsPwn57cBWByJw/jcNzToG472hZxNCCA5b3ksh8qn9
	i8N/c6Ig1AUqtSxTmMGmGkOSy7JPm2cdjZT
X-Received: by 2002:a05:6a21:998a:b0:3c4:2b8b:e88f with SMTP id adf61e73a8af0-3d26646a960mr24213242637.5.1788066851383;
        Sat, 29 Aug 2026 22:14:11 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:11 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 2/6] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Sat, 29 Aug 2026 22:14:03 -0700
Message-ID: <20260830051407.50008-3-kiyer@crusoe.ai>
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

damon_folio_mkold_one() and damon_folio_young_one() assume the folios
they walk are mapped by normal PTEs or THP PMDs.  When the folio is a
hugetlb folio, page_vma_mapped_walk() returns the huge PTE in pvmw.pte
with its page table lock held, but the walkers treat it as a normal
PTE: they read and age it with PAGE_SIZE-granularity helpers, which is
wrong for huge PTEs (up to PUD level), and notify secondary MMUs for
only PAGE_SIZE of the mapping.

Add hugetlb branches to both walkers.  The mkold walker reuses
damon_hugetlb_mkold(), which the virtual address space operations set
has been using for hugetlb aging: it clears the young bit of the huge
PTE via set_huge_pte_at() and calls mmu_notifier_clear_young() spanning
the whole huge page size.  The young walker gets an equivalent new
helper, damon_hugetlb_young(), which reads the huge PTE with
huge_ptep_get() and consults the page idle flag and
mmu_notifier_test_young() like the existing PTE branch.

Locking mirrors what page_vma_mapped_walk() provides: the huge PTE's
page table lock is held inside the walk, and for shared hugetlb
mappings (the only ones subject to huge PMD sharing), rmap_walk_file()
already holds i_mmap_rwsem, satisfying hugetlb_walk()'s locking
requirements.

This is currently dead code: both rmap walkers are only reachable
through damon_get_folio(), which rejects hugetlb folios since they are
not on the LRU lists.  A following commit will let the physical address
space monitoring primitives opt in to hugetlb folios.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/ops-common.c | 63 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index f5fe92b825bb..62004206ca31 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -193,10 +193,20 @@ static bool damon_folio_mkold_one(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
-		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma, addr);
-		else
+		if (pvmw.pte) {
+			/*
+			 * For hugetlb folios, page_vma_mapped_walk() sets
+			 * pvmw.pte to the huge PTE with its page table lock
+			 * held.
+			 */
+			if (folio_test_hugetlb(folio))
+				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
+						addr);
+			else
+				damon_ptep_mkold(pvmw.pte, vma, addr);
+		} else {
 			damon_pmdp_mkold(pvmw.pmd, vma, addr);
+		}
 	}
 	return true;
 }
@@ -221,6 +231,24 @@ void damon_folio_mkold(struct folio *folio)
 
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
+		unsigned long addr, struct folio *folio)
+{
+	pte_t entry = huge_ptep_get(vma->vm_mm, addr, pte);
+
+	return (pte_present(entry) && pte_young(entry)) ||
+		!folio_test_idle(folio) ||
+		mmu_notifier_test_young(vma->vm_mm, addr);
+}
+#else
+static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
+		unsigned long addr, struct folio *folio)
+{
+	return false;
+}
+#endif	/* CONFIG_HUGETLB_PAGE */
+
 static bool damon_folio_young_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
@@ -232,16 +260,29 @@ static bool damon_folio_young_one(struct folio *folio,
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			pte = ptep_get(pvmw.pte);
-
 			/*
-			 * PFN swap PTEs, such as device-exclusive ones, that
-			 * actually map pages are "old" from a CPU perspective.
-			 * The MMU notifier takes care of any device aspects.
+			 * For hugetlb folios, page_vma_mapped_walk() sets
+			 * pvmw.pte to the huge PTE with its page table lock
+			 * held.
 			 */
-			*accessed = (pte_present(pte) && pte_young(pte)) ||
-				!folio_test_idle(folio) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
+			if (folio_test_hugetlb(folio)) {
+				*accessed = damon_hugetlb_young(pvmw.pte, vma,
+						addr, folio);
+			} else {
+				pte = ptep_get(pvmw.pte);
+
+				/*
+				 * PFN swap PTEs, such as device-exclusive
+				 * ones, that actually map pages are "old"
+				 * from a CPU perspective. The MMU notifier
+				 * takes care of any device aspects.
+				 */
+				*accessed = (pte_present(pte) &&
+						pte_young(pte)) ||
+					!folio_test_idle(folio) ||
+					mmu_notifier_test_young(vma->vm_mm,
+							addr);
+			}
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			pmd_t pmd = pmdp_get(pvmw.pmd);
-- 
2.54.0

