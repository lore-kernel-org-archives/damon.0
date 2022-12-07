Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B268F4B
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 23:01:59 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3188366pjm.2
        for <damon@lists.linux.dev>; Wed, 07 Dec 2022 15:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=aRW3STV7RblLr2UZyt0OTfxbCMJqzXcDNCvfPBFSL8j4JPwCmtZkBnAWT2aBKleJxM
         S3/S1x1bm1MpdH3mCRtHaNVJoA9agm3kV/DY2R4ALu1LaFoVxFx25litGpXvg0Pvv3gh
         uoVb7nRNI9Qsr8wEjAMXHbfKT2kJbq0+RJAy9yhPqI+XBxbk4puqiVriF0clbfnRW70s
         BoqZQTnhKW+xtH8CD1pB7fQKPmCtUiJwD+YIRriTaJAr7X6qPNEhR1gMWRbwuwhYFKuc
         8gjib0AzihFb9ybVk0MTROBvleagUuf+5ZDDM3BziLgRNQJLYQgKz7T7B91ISD3U5F+A
         JrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=AGYKssmhXDI1PlPqS02wbUivi31KM/g4A9OgW07zDk/Miyt8HiLXMWAIOYZhIDYs51
         px2cXoKGfAx3lDZPQlZBUfKrnlk4kOkMvvl2RcVEs5dv07x0oUQhFaOgK9FImlq7Plfi
         iKO6hMRq9RdJbzH7NHUrhFH6qucA7bDXop3Lh4U2CEqpaZWPVM3DDOw0fqpq/3SJdgnw
         NFmm3frEiX3H/chO6ri2jECRVmGe07GSaGjhXehcnQxaCh+pBV1YvPWkz0ABsSrlY6Vg
         ztWjzLAcvyTcaStiIBT3JWT0UXgag+waf3oCrc97nidTWK26vNy1pygsvrjMEdHzXbbe
         /Bww==
X-Gm-Message-State: ANoB5pmvPFypKxxwf10bliD3xVtjOFFa7UYkX+qmDsku+1EN3zZtuIfo
	m/GH3xGToVD0/cJ7CODqjRc=
X-Google-Smtp-Source: AA0mqf5OWOMX/v4jZwZzxW/+LnUXUxbUa7hAE7DKvC2Aq3cLs4HP8zm+Fl2Ofy4HrmxmV6JJeb1A1A==
X-Received: by 2002:a05:6a20:a028:b0:9d:efbe:52b2 with SMTP id p40-20020a056a20a02800b0009defbe52b2mr2023625pzj.34.1670454119220;
        Wed, 07 Dec 2022 15:01:59 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5411033pjb.1.2022.12.07.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:01:58 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/3] mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date: Wed,  7 Dec 2022 15:01:51 -0800
Message-Id: <20221207230152.22938-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207230152.22938-1-vishal.moola@gmail.com>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
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

