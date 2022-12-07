Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2C361
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 00:22:11 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id k79so16075423pfd.7
        for <damon@lists.linux.dev>; Tue, 06 Dec 2022 16:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoYl04wmxXLxezPOZ+70Ro47XrPK1TtSWHCWNCKBtck=;
        b=gBamaz4OVaEVv9YnAytPCavKroW8kAh0EpjPfndUHawsWX+Te45e0LTcygfzxt8QE1
         2SqiGRJcTWSCe+7cD3rFTWy6y+tYqHCvXgbJn+r4VQFX9HnuyvW8NZJ9lLFTWfnmkcmE
         MMe2xsoL8lhOPC+CRDfEqdjzr18ZgvwViZoUlSeR/Zo9B1Hp6uxR7DCzEGnBB8tYFU/Q
         2AzyPIkz77tzkdOVaKf+MI5ugr+rsOEWFabgMLVJaRBaDHs2x7YAnjXbYL/4n9bexpZK
         YzC2T83N0X1QGW2u7NSK3lLFlSrooexvnhal3jwHDd5x9guBM1nkqYqdiQceIRsbYvYm
         D4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoYl04wmxXLxezPOZ+70Ro47XrPK1TtSWHCWNCKBtck=;
        b=PC+8cXXmLxoOFQIOEMeq9JgfZzS6PkHJi/2QoWfQ+6gX5nC2Q3wO5MqrLHsQKOVIy/
         xK1PIiSrgQPEinJTTFFRnD643ZmpIzI1WbBLgSEfTrAMn6u9ZGAMHMJ6bRY+YWiCGzMK
         11kWaaZZeJSBRR7e+fUNgqrl3vtpF5wt9C4kMlW1jLfxaC/4nnTqbd8ZlFOPCXduh6Kp
         J9vVoHEPYeydnMDTv4oBdG4gCmWZJB0Sdxxs2LRv47rQqUImsuKxXVE6g3wM7DlbEykk
         SCE27upREOOCLW0yUQG+/es095W1YihQXbSKwcE8+Y23aiEdNG1KvxUFnADMZI4uLriK
         XsRQ==
X-Gm-Message-State: ANoB5pkQxo+NHdHXbO9I6PoBFoyAlvZy1PbJa+9ALwjwwTHCJInF/Y8i
	DPx0vPKSVoOXYvjgqVOS1q9w9h82dUM=
X-Google-Smtp-Source: AA0mqf6EdiHewDQc4qwEXQ+ag0vm95jDVzDY/1oaMRvcZpUYxt8oTIUgeuu68qGZp6quL3u90D6TUA==
X-Received: by 2002:a63:1464:0:b0:46a:f665:ed96 with SMTP id 36-20020a631464000000b0046af665ed96mr63031285pgu.486.1670372530940;
        Tue, 06 Dec 2022 16:22:10 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:10 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/3] madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
Date: Tue,  6 Dec 2022 16:21:56 -0800
Message-Id: <20221207002158.418789-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207002158.418789-1-vishal.moola@gmail.com>
References: <20221207002158.418789-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change removes a number of calls to compound_head(), and saves 1319
bytes of kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/madvise.c | 88 +++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..59bfc6c9c548 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -332,8 +332,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
+	struct folio *folio = NULL;
 	struct page *page = NULL;
-	LIST_HEAD(page_list);
+	LIST_HEAD(folio_list);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -358,23 +359,23 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			goto huge_unlock;
 		}
 
-		page = pmd_page(orig_pmd);
+		folio = pfn_folio(pmd_pfn(orig_pmd));
 
-		/* Do not interfere with other mappings of this page */
-		if (page_mapcount(page) != 1)
+		/* Do not interfere with other mappings of this folio */
+		if (folio_mapcount(folio) != 1)
 			goto huge_unlock;
 
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
-			get_page(page);
+			folio_get(folio);
 			spin_unlock(ptl);
-			lock_page(page);
-			err = split_huge_page(page);
-			unlock_page(page);
-			put_page(page);
+			folio_lock(folio);
+			err = split_folio(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 			if (!err)
-				goto regular_page;
+				goto regular_folio;
 			return 0;
 		}
 
@@ -386,25 +387,25 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
 		if (pageout) {
-			if (!isolate_lru_page(page)) {
-				if (PageUnevictable(page))
-					putback_lru_page(page);
+			if (!folio_isolate_lru(folio)) {
+				if (folio_test_unevictable(folio))
+					folio_putback_lru(folio);
 				else
-					list_add(&page->lru, &page_list);
+					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(page);
+			deactivate_page(&folio->page);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&page_list);
+			reclaim_pages(&folio_list);
 		return 0;
 	}
 
-regular_page:
+regular_folio:
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
@@ -424,28 +425,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		page = vm_normal_page(vma, addr, ptent);
 		if (!page || is_zone_device_page(page))
 			continue;
+		folio = page_folio(page);
 
 		/*
 		 * Creating a THP page is expensive so split it only if we
 		 * are sure it's worth. Split it if we are only owner.
 		 */
-		if (PageTransCompound(page)) {
-			if (page_mapcount(page) != 1)
+		if (folio_test_large(folio)) {
+			if (folio_mapcount(folio) != 1)
 				break;
-			get_page(page);
-			if (!trylock_page(page)) {
-				put_page(page);
+			folio_get(folio);
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
 				break;
 			}
 			pte_unmap_unlock(orig_pte, ptl);
-			if (split_huge_page(page)) {
-				unlock_page(page);
-				put_page(page);
+			if (split_folio(folio)) {
+				folio_unlock(folio);
+				folio_put(folio);
 				orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 				break;
 			}
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 			pte--;
 			addr -= PAGE_SIZE;
@@ -453,13 +455,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		/*
-		 * Do not interfere with other mappings of this page and
-		 * non-LRU page.
+		 * Do not interfere with other mappings of this folio and
+		 * non-LRU folio.
 		 */
-		if (!PageLRU(page) || page_mapcount(page) != 1)
+		if (!folio_test_lru(folio))
 			continue;
 
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+		VM_BUG_ON_PAGE(folio_test_large(folio), folio);
 
 		if (pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
@@ -470,28 +472,28 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		/*
-		 * We are deactivating a page for accelerating reclaiming.
-		 * VM couldn't reclaim the page unless we clear PG_young.
+		 * We are deactivating a folio for accelerating reclaiming.
+		 * VM couldn't reclaim the folio unless we clear PG_young.
 		 * As a side effect, it makes confuse idle-page tracking
 		 * because they will miss recent referenced history.
 		 */
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
 		if (pageout) {
-			if (!isolate_lru_page(page)) {
-				if (PageUnevictable(page))
-					putback_lru_page(page);
+			if (!folio_isolate_lru(folio)) {
+				if (folio_test_unevictable(folio))
+					folio_putback_lru(folio);
 				else
-					list_add(&page->lru, &page_list);
+					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(page);
+			deactivate_page(&folio->page);
 	}
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
-		reclaim_pages(&page_list);
+		reclaim_pages(&folio_list);
 	cond_resched();
 
 	return 0;
-- 
2.38.1

