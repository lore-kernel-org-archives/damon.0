Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2BA460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:35:10 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so2722642pjd.5
        for <damon@lists.linux.dev>; Thu, 08 Dec 2022 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=Ii3vt0qJdv0V25/feuGUMH7PzkflNrD7g8L2x6z6/EYO9gzRto4zD8ZTJENpqeU8XP
         gLmydlYQJhHXfGq9y5BeriBDQ11jeq2TYMS4ysPrNZ9lPX61JatrrzxhNPq8b43OY+1j
         ptjf++BriBBDjvyJBWStE5HuQ96Co+07MfQnvCs2OW/l8Fnd4dMK7S3wmVg9uQ10eoQe
         daaPLy51OxzLCvTwyZhN2Miw3T/m5LTvMPAIzD6bUUY+4EQQU/bJ69w/ZA8Q6XpK5xLy
         SxVqHOiUx+drkxy5pADNtrFlAQV+RXgMmv1emA5DGz0XXWcWdkZMZTar5/QzNUuvgqaX
         Bdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=QuCjJWC/6VjGSbh0Vq2ectrpVJrNpJkt8yWoxsp5Hy7EMTSeeJznN+ehXQ3ERLjN8X
         zg4HJVvXrCX1rd9HZtkFVPmXcBAYai8ecliencvKUmOjAH7kN5L+Hdr2+kGCnn7j8Hb7
         +YWZ7vw3TDv5AYbIpY9KKRfppNlzkUJkO4SY36038ANg29mQMg9NlBSdIsitG7B+WIel
         p5JdGDIHB0axe0bxLsOUcjLo80QoBml2lL7j76LnF1LCcxQ2lTb6d9foxh67Xjw1froJ
         aCx2vMVZPB3YjJeIewIdKeeA9XHnCalEd8yo7oMm78fghSZEc7Qy5Qw62+vuzE5OaZ54
         zsog==
X-Gm-Message-State: ANoB5plw8bn41wSLjx6ER+RTHJREILO7pMFvD8PJ6lahFAiulhc5z1mx
	uPM7Otq+wkdC/tcMVDFrqYQ=
X-Google-Smtp-Source: AA0mqf4+5Zv1Qu99xU00p+xkeABzV897h+Xfstc+913jbdXvjz2pIi2b+ZYYSdFCNInv+po5xPqf2w==
X-Received: by 2002:a17:902:e806:b0:185:4421:72e5 with SMTP id u6-20020a170902e80600b00185442172e5mr3989355plg.42.1670531709851;
        Thu, 08 Dec 2022 12:35:09 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:09 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 3/4] mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date: Thu,  8 Dec 2022 12:35:02 -0800
Message-Id: <20221208203503.20665-4-vishal.moola@gmail.com>
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

This change replaces 2 calls to compound_head() with one. This is in
preparation for the conversion of deactivate_page() to
folio_deactivate().

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

