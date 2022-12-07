Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E4366
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 00:22:12 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id w23so15532496ply.12
        for <damon@lists.linux.dev>; Tue, 06 Dec 2022 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFy10fUQvAp0c5CDE+pRKnURMHNPhPlaSgCKw+V2Qs=;
        b=YHl28cpdsLfmOjfipvqjWtXAOa0AMP8kDcueiJ2N/YI83AXK8AqWr/PutrLcLlXgWJ
         6+oMgPZlwTZh56uWh1rOpt8mEc1ZKR5Y0LX4C1FdfryzT1T1yTtNZ1my5/TzolFCJPGj
         8AMBoHbKNuHITSlPhfWgrrjoRrPaAkSr07h69DbLlVEoMAbBdKq5YyTT67xyp5jauvLQ
         imF0VJ4E31XeS909T0Ldb2JbgeDlNv45Jjr4N6f2BuVNBMf80lbVAcHnzhMKW4/Hcy3g
         3I6djJdxa4FDRbQumuumNsGYUIgLJxYdme/OkCtciK0AFWkjDy3HYydVxd6qwRzG52Av
         2EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cFy10fUQvAp0c5CDE+pRKnURMHNPhPlaSgCKw+V2Qs=;
        b=6kwXDmrC+INAKHzlCqex3MAA5R75sN9oQuWpsSOhFLwGq56hJqsHzjrFxIqazFDixO
         u1+AcP//DasyAuwD8KRnOrRgP4Pcxo29tA6KYYQwIr5z9OOePraXEn69G6icwiqx2RkX
         GK6/N+eW/tmwmQ15p++GrjHy8gImk60/QuW0m9PJfMyNrcTLs43NaY6c/WBB7eo9W7xk
         FCSGwoiMepCS/lAMC2lLPs4PwFz1Vog3n11ZqHmIFkTLKe1gpCx1f2mcivQrphqoBkd5
         cqGPMx2Yv80/tiyCNY6Ie/DKNAEI5EmNWgKBid2KBg0+7nnp8KQjbvaXQ4oZ29+JGDgE
         FC2A==
X-Gm-Message-State: ANoB5pmWvJopgaimexmH06WgvhLyG1w/czxg5e6TWP+D2LgCfpTW0BtQ
	vcBoh1r/ci5ecDr8bu5pHLc=
X-Google-Smtp-Source: AA0mqf4U7jtXadsQFblEfRvObGZVDvFuMgI1hcOxiUE1ZCQI629UmVFG5eKkyUOBNlVLoCV4mPWkgA==
X-Received: by 2002:a17:90a:5787:b0:218:8398:5846 with SMTP id g7-20020a17090a578700b0021883985846mr93924762pji.241.1670372532129;
        Tue, 06 Dec 2022 16:22:12 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:11 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date: Tue,  6 Dec 2022 16:21:57 -0800
Message-Id: <20221207002158.418789-3-vishal.moola@gmail.com>
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

This change replaces 2 calls to compound_head() with one. This is in
preparation for the conversion of deactivate_page() to
deactivate_folio().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/damon/paddr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..73548bc82297 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -238,15 +238,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct page *page = damon_get_page(PHYS_PFN(addr));
+		struct folio *folio;
 
 		if (!page)
 			continue;
+		folio = page_folio(page);
+
 		if (mark_accessed)
-			mark_page_accessed(page);
+			folio_mark_accessed(folio);
 		else
-			deactivate_page(page);
-		put_page(page);
-		applied++;
+			deactivate_page(&folio->page);
+		folio_put(folio);
+		applied += folio_nr_pages(folio);
 	}
 	return applied * PAGE_SIZE;
 }
-- 
2.38.1

