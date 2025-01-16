Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCE22B8A0
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038686; cv=none; b=EBUQqRUWFm7UpNI5EUNDKI400RbUJEhHjeItpaOM6QyFgJhi6OtlEi96oB+/lxYYOaS4TZK1XcYe9C3YPR90lZ22kseSVacTsTDkONyyH8oV7oTNByWKqtabPwOZr//If1Wkv1p34dnwSnQclknfOD/lcXKvYiyQRN63NS+FH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038686; c=relaxed/simple;
	bh=iPvlsp7J/9PbqEqt3qcRpCTG1CO7EWdZ4KMm5TEtv/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFpbuSLIWYV3NBjSQwYGJ1GQIkkIbpjw5ZMDgUaX74z+IhIPh4B1q9U2yR/9YpOfBt6pXjQI8gf45unnGv4phYT/s9RxHjNOaTPL2wKBtQiIzn1EDjXSD7O3/iDNNzdXRJ1NjGVnn3bLw8BXI3v8bQzB2qVpPrR5TiA8iyL0ORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2uLIhF+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2uLIhF+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46c7855df10so17486221cf.3
        for <damon@lists.linux.dev>; Thu, 16 Jan 2025 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737038684; x=1737643484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qBRxGOqRj/BiiIpTnOTMTghJc9OOxuTBkEh32b4BHo=;
        b=i2uLIhF+O+Z1xh4wj2zfbtbtsA8rGhUP5vEz6Ybb1oIOyvJj7opw9Egy2AGHGpD8Ny
         RjOEAtfewQLF0FtNrZ7EybxQ2aM38AkAZGNb8kktBBqyI8fCWWukmyDMq+MybACZ/NBM
         N2jKgUlFtoxPFSItkjlI9lDtCUXxwEh5Pu21i44gjdU+0e7XvirRRXutc+Ehoy+qjVO1
         zAw5XTgBKP3age7xVpgSf1bOFFQ6lw7kAxTG1AvW7YSGTFNeQrg9Fz2CtLNgFPIwv86z
         jN2ax0vrweLDPKg6M0nWzMDFh+P9yycRB/fgeuRKTNGWwow4MeIq3kXoXckSpFhdatR1
         BK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038684; x=1737643484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qBRxGOqRj/BiiIpTnOTMTghJc9OOxuTBkEh32b4BHo=;
        b=pSi/LV98qB3Wlr+D504osDg9DtpZuPweYUGPRy61GH2QXVG4aOD4m+NhLU684ncq0O
         zsR7eMFo4KU0ybJ2/iYnGktRkEXiVU1hgH0HcO0++RMTTBi8C/Jxo95i1Z6xiO8gHDh0
         zsv5qo9bNSoOo4cWbxd3YT8WZ4sRteYN6g0oaHP0FHTEitZitCByMy6Fs7SEjhfZE/r9
         bdwrr9uqjpvRTcsfS2Qj8BcvxX+nrQq51xz5VsfqqwWpIo/IPMoOKWTpglHwbZ7BzDwa
         RGJJnShPVd8rl1q4SNiZ8Co4VONCHkJNAOMC72OeqrPY3uWgondJLRm3Kg2AsljMBRI7
         ZHQQ==
X-Gm-Message-State: AOJu0Yz9UzQGJZ0HanvxyuHpMfe9VNCiNiBsPMHu3LwX5k3Tz0DvBsuM
	R5m/JivHV5ddU3ha1EN3y6qizVuF4FEnA6rhvR6lXwIz3K4we+/q
X-Gm-Gg: ASbGncsYtoXai/3EkeYDKgNd5LlzPYCfItXZA2wvlVh/peZ2gbBCF/v7mRQBDELn80G
	lo596Y9r/WupGE5xj69UM18jMHo7YgzECERXOSHVL1op1zPGEqCNaVjvLu5LM67lY8coGPAhg0u
	NnvNkR7fDQx1kNdmGtWXMoVXNgse+FUn7n4VNFQBbV/50Dr5OouCjJBxp7Bz3Yl0l+eQO9dR2dP
	ZaeNO4PeoTujfywGPNph+eolqOauLzySOHJQAFjoVuFjFNLQsbtAg==
X-Google-Smtp-Source: AGHT+IFoL7VpAVfqxDqGv6+fM/ykqbHT2KJT9u/FoMGsdyegmHbkvZkYFe7oA5X2KWAfOc78pbZ53w==
X-Received: by 2002:a05:622a:1a19:b0:467:7fbf:d115 with SMTP id d75a77b69052e-46c71003ad4mr490164081cf.12.1737038683857;
        Thu, 16 Jan 2025 06:44:43 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:9::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10436015sm80071cf.77.2025.01.16.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:44:43 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [v1 1/2] mm/damon: have damon_get_folio return folio even for tail pages
Date: Thu, 16 Jan 2025 14:44:35 +0000
Message-ID: <20250116144436.3947318-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This effectively adds support for large folios in damon for paddr,
as damon_pa_mkold/young won't get a null folio from this function
and won't ignore it, hence access will be checked and reported.
This also means that larger folios will be considered for
different DAMOS actions like pageout, prioritization and migration.
As these DAMOS actions will consider larger folios, iterate through
the region at folio_size and not PAGE_SIZE intervals.
This should not have an affect on vaddr, as damon_young_pmd_entry
considers pmd entries.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/damon/ops-common.c |  2 +-
 mm/damon/paddr.c      | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2b..d511be201c4c 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -24,7 +24,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
 
-	if (!page || PageTail(page))
+	if (!page)
 		return NULL;
 
 	folio = page_folio(page);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index bd8cfe10121b..c0ccf4fade24 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -266,11 +266,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_add_filter(s, filter);
 	}
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -286,6 +289,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -301,11 +305,14 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 {
 	unsigned long addr, applied = 0;
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -318,6 +325,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
@@ -464,11 +472,14 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -479,6 +490,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 			goto put_folio;
 		list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
-- 
2.43.5

