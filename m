Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69397368
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:35:09 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id jn7so2656373plb.13
        for <damon@lists.linux.dev>; Thu, 08 Dec 2022 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHUznzZJR/+2eFOYGxPgX5SObHA9uL1BQ/OTB3xHgrA=;
        b=NEepa2sCfJJvgnX3ejRFOGPrjMYmgXnKRjN5unAOsJ/tE/BFewdxSNeEpPh1ad1sGm
         sIvarvzBcw9Q3fQ8zNawaQb5T7z+NwATAYhUr1/Zzfia5k8LSv8jP7nLAWj12z2ly+ZT
         f1GUI5W5sCMhxUsXXmc3IaXRX1EDRvErMLIqll3a5CVIKNBy+z+Ps/lbk08QQ9KaT7Xk
         XnMYibTX66/3+am1vVR/kGAVRT7Ww4h9duW2iIIY993dThq5e7aPSkAMZ/4u08o/kpj9
         hMuvayRPzWZ61DFZfjIkSk7CofF4B5i1NolYOU2OWLJeiOsFr0kMvqfSPwlc83/zYe2K
         Aagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHUznzZJR/+2eFOYGxPgX5SObHA9uL1BQ/OTB3xHgrA=;
        b=BDWjl9Jnj062eB1E8+7BI56QN7L7DwjtpTs4Q2oH9UzxfZgmFnF9TdPKRcmldoRPz1
         9dKUfhrrw3MEzYBPEE6vscicJSOWk9fXwBp89ZRAvTQ+epRXw2NHFIAFv2CvsRqUfdki
         BCOPPcQAdWT6bm5NALQH9F5HE1ISqYp8ybOvqif3lpPYz+tUgOKZNl0BAPkpB5M1jfAg
         Ee798juXZ1s9tetBAqDR2+J6PgUoYfyhvI0UcqpyqXrZrqUgXTvE99lSBbog4Jv3MMLQ
         ypX8+WmNSZuwMOPSn3BCXaT8s4ihro4vbxqcLZfyha2vNXHE5OqWJPHhsjE2QRDj7tqs
         mOIw==
X-Gm-Message-State: ANoB5pmVmljIQg7bTS57GHA9/2zWk9I6JWXP2NRJ+ucOlQpJtu9vlBGb
	SRDdHBcoczXswQvOzsxhoNg=
X-Google-Smtp-Source: AA0mqf5+O1BZXrE1YEC4dz/Cxj4pggZ4XHVB3Kve73sA6I4CTYSn6JfKCq6XbOm2qlu7J9B/7TW1zQ==
X-Received: by 2002:a17:902:d58a:b0:189:a11e:9995 with SMTP id k10-20020a170902d58a00b00189a11e9995mr3527512plh.13.1670531708818;
        Thu, 08 Dec 2022 12:35:08 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:08 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/4] madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
Date: Thu,  8 Dec 2022 12:35:01 -0800
Message-Id: <20221208203503.20665-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208203503.20665-1-vishal.moola@gmail.com>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
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
 mm/madvise.c | 92 ++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..2a84b5dfbb4c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -332,8 +332,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
-	struct page *page = NULL;
-	LIST_HEAD(page_list);
+	struct folio *folio = NULL;
+	LIST_HEAD(folio_list);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -358,23 +358,23 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
 
@@ -386,25 +386,25 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
@@ -421,31 +421,31 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (!pte_present(ptent))
 			continue;
 
-		page = vm_normal_page(vma, addr, ptent);
-		if (!page || is_zone_device_page(page))
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio || folio_is_zone_device(folio))
 			continue;
 
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
@@ -453,13 +453,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		/*
-		 * Do not interfere with other mappings of this page and
-		 * non-LRU page.
+		 * Do not interfere with other mappings of this folio and
+		 * non-LRU folio.
 		 */
-		if (!PageLRU(page) || page_mapcount(page) != 1)
+		if (!folio_test_lru(folio) || folio_mapcount(folio) != 1)
 			continue;
 
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
 		if (pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
@@ -470,28 +470,28 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

