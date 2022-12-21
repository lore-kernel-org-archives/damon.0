Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5942F30
	for <damon@lists.linux.dev>; Wed, 21 Dec 2022 18:10:02 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id n4so16326869plp.1
        for <damon@lists.linux.dev>; Wed, 21 Dec 2022 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxCbMv7vN+MZYskgQiQXZaUsiwZjC8DQb1oWsEzg+wg=;
        b=SVH+DMt9Og+wCpl3/C5BsDiXi0R8onKGMrhpkd4hAlX8bvnTiVKmDxskppX9IQkPrD
         8Sd4evv36aHQ13uRz8HuvrhsBcWuFhUALcpXcURwBX6tiFSJpCU0wdSdBmhHkx7XIrr/
         JyVRdZoqnokcrqk6Trie7l/7hWBpcvarMU2OLhZ6kJiKEYRNdIksrOfLjFawMwNn6O2p
         jCmneIA6JP/TtPv5fncfMTNDHOeJ+bi0Qpz3foORBcwYPuBPLReKoQaHUJw3l+w3OALk
         SUx0tixRN0rcqO5jTqxXfiyWmYW2jH8GSWHBLkGTNVr9roslowxH0YAB3zgJLd+OW8R5
         o8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxCbMv7vN+MZYskgQiQXZaUsiwZjC8DQb1oWsEzg+wg=;
        b=7Vk6ddBJvqLFCqxFT2fHS4/5uBcR7dhSMDXSkCOWPwtaPqnk/HrzRrvReJ2P8fRehB
         t4qSlYuZ4yN2yr9c5nk51d65cnju4T1GHcNZAuFMTz/winYbgThBNRwfN57UtLDbp+Ny
         gk3zotFohzBnql+9SxeVIgh+NNOG1Hk/cV88ztqBYCwbfN2jj0B6ptkn+/sZUpf952NR
         efwAfRFzE3RU/PVNFLtPnOq5HI3Y3Qs1m5SLPiHhhx+H/eECgS8gkf7FGUhuEHFNdfMX
         1laqtc1Om0OO+klv1la3SzP65ZId+Oc6OYK1w0suya9zV7R+Es0giWxXE56kMOAL9Q+h
         ciKg==
X-Gm-Message-State: AFqh2kovgI9+eJ1gkeYlPud6Qv1sj/xRnwPzhLQawIt+jix51eME4G17
	bLACKUyVBefwMPYjcaxXQONTKAgY3D+iSA==
X-Google-Smtp-Source: AMrXdXu7sLHZOSQkUqGfVCYqV1RGYszssajWNznlILD5f7tvBuIfHAUntNoH41lSWlaha/5S+8g8uQ==
X-Received: by 2002:a05:6a20:2a09:b0:ac:44ab:33fa with SMTP id e9-20020a056a202a0900b000ac44ab33famr3315612pzh.37.1671646202232;
        Wed, 21 Dec 2022 10:10:02 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:10:01 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
Date: Wed, 21 Dec 2022 10:08:48 -0800
Message-Id: <20221221180848.20774-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221180848.20774-1-vishal.moola@gmail.com>
References: <20221221180848.20774-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deactivate_page() has already been converted to use folios, this change
converts it to take in a folio argument instead of calling page_folio().
It also renames the function folio_deactivate() to be more consistent
with other folio functions.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     |  2 +-
 mm/madvise.c         |  4 ++--
 mm/swap.c            | 14 ++++++--------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f965786710b0..209a425739a9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -401,7 +401,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_page(struct page *page);
+void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 extern void swap_setup(void);
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 884c8bf18b12..6334c99e5152 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -297,7 +297,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		if (mark_accessed)
 			folio_mark_accessed(folio);
 		else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 		folio_put(folio);
 		applied += folio_nr_pages(folio);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index 851d977b9b03..025be3517af1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -416,7 +416,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -510,7 +510,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 	}
 
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/swap.c b/mm/swap.c
index 5e5eba186930..e54e2a252e27 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -733,17 +733,15 @@ void deactivate_file_folio(struct folio *folio)
 }
 
 /*
- * deactivate_page - deactivate a page
- * @page: page to deactivate
+ * folio_deactivate - deactivate a folio
+ * @folio: folio to deactivate
  *
- * deactivate_page() moves @page to the inactive list if @page was on the active
- * list and was not an unevictable page.  This is done to accelerate the reclaim
- * of @page.
+ * folio_deactivate() moves @folio to the inactive list if @folio was on the
+ * active list and was not unevictable. This is done to accelerate the
+ * reclaim of @folio.
  */
-void deactivate_page(struct page *page)
+void folio_deactivate(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
 	    (folio_test_active(folio) || lru_gen_enabled())) {
 		struct folio_batch *fbatch;
-- 
2.38.1

