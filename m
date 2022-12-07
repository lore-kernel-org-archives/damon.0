Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC184361
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 00:22:13 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id p24so15568658plw.1
        for <damon@lists.linux.dev>; Tue, 06 Dec 2022 16:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEZ3nXZq4E7igsh2DmFsHgveY1W51E+N0X432dfJHyo=;
        b=nOt7hYfhoJxkHqluSJnxpRExcW/m2quhpIhnCt2VmhwAHoWhp+foIWoMsEF6wIdkvI
         Rbf8GNmAIVnTLG+lIA6ThCYViUdKlHharbhvotCvy2BvDU36itd3ooK0vKMM914ZXS3K
         llSojtAyxUiRTUSgxDaGmOOdKjFCGPZwwkuMLrvFrsKtQhXvutBKuXRg2TdB/B72kQEw
         ueYt6FAFjRVdQ+xVslRGRaDThzeJGgZpIuqzVT7gWw+v991mrr4aqeEw3Ki2PlaLHaFb
         gcvNJY6QM6cXqabzvF8qSR/n2mJeeEOfUOMw5pNtyskDaAD4PBFedJ9w/MKFIIJs30gf
         /R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEZ3nXZq4E7igsh2DmFsHgveY1W51E+N0X432dfJHyo=;
        b=434I8zubgr6Dasrm8P0RZolQujxB0fZSTDEHW8MgPgtKyHPXUNnDdRynqWd9PfD0qm
         hkuXko4GhoXWsNNbwNRO+rVPtzQyyGvR/D4NSuflM5Zf6UDR3gK5ubaYjIm+OQJxCOg/
         gry2RzUM4e+b4tyc9mFPQkM9nj4/nSSbVz5Aze3tGPNb+yhcMrL+mhPfklTylqMQjky/
         uz4YThq0AfJr9NWmLuhML2+WFig/ZXmHxn8O4rgRZkrXpCsNS+/Kz3u3xjeodrSdUeiO
         /WkdN3guu+W+QbNZ12NxnejmWQHCLq7PneRbD5k75wN1InNOFu5SX9xjRF7t43U23RCl
         3Z8w==
X-Gm-Message-State: ANoB5pkw43QLOYdjsglGuM37NBwWx2Hq5PvzL9ZZb60FWok3D54iNkFo
	18O3I7Kp6OQ/Wc9AldhGdXU=
X-Google-Smtp-Source: AA0mqf6Z7Vfk8E9GO2/aJOFHDYEsNCpnkpUq8FGPv4LkM++FMgwrWiZpHKRYzDycb6i+3+PmCuR+9Q==
X-Received: by 2002:a17:902:e411:b0:189:8796:7813 with SMTP id m17-20020a170902e41100b0018987967813mr46531581ple.110.1670372533159;
        Tue, 06 Dec 2022 16:22:13 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:12 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/3] swap: Convert deactivate_page() to deactivate_folio()
Date: Tue,  6 Dec 2022 16:21:58 -0800
Message-Id: <20221207002158.418789-4-vishal.moola@gmail.com>
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

Deactivate_page() has already been converted to use folios, this change
converts it to take in a folio argument instead of calling page_folio().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     |  2 +-
 mm/madvise.c         |  4 ++--
 mm/swap.c            | 14 ++++++--------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..f404790222c0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -409,7 +409,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_page(struct page *page);
+extern void deactivate_folio(struct folio *folio);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 73548bc82297..828961fc7899 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -247,7 +247,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		if (mark_accessed)
 			folio_mark_accessed(folio);
 		else
-			deactivate_page(&folio->page);
+			deactivate_folio(folio);
 		folio_put(folio);
 		applied += folio_nr_pages(folio);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index 59bfc6c9c548..afe957994317 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -397,7 +397,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			deactivate_folio(folio);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -487,7 +487,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			deactivate_folio(folio);
 	}
 
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20..9982469e8da8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -720,17 +720,15 @@ void deactivate_file_folio(struct folio *folio)
 }
 
 /*
- * deactivate_page - deactivate a page
- * @page: page to deactivate
+ * deactivate_folio - deactivate a folio
+ * @folio: folio to deactivate
  *
- * deactivate_page() moves @page to the inactive list if @page was on the active
- * list and was not an unevictable page.  This is done to accelerate the reclaim
- * of @page.
+ * deactivate_folio() moves @folio to the inactive list if @folio was on the
+ * active list and was not an unevictable page. This is done to accelerate
+ * the reclaim of @folio.
  */
-void deactivate_page(struct page *page)
+void deactivate_folio(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
 	    (folio_test_active(folio) || lru_gen_enabled())) {
 		struct folio_batch *fbatch;
-- 
2.38.1

