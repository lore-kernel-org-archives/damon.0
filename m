Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523617B500
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368222; cv=none; b=QIEBDwUvDN3pTMv88wHmQPYM0zcTaIAfriOi+IVUlkiu2Qr03smqm5BHgT/L4jBKJOFhm8GcSDl+ecrw51uAQ7KcXFGN0GpFFzDSTmvVlneicWalEqzbysa4obmvB81MCulhTK+bmOBJeJzrcX7QlPoHyEhRAZ9Oh+UsqUSabNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368222; c=relaxed/simple;
	bh=c2xTNHI8CovG75AGhKvkDolmM50AFA1OHJrsd+yTSiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqriBlaUZDCVO+YFHa+M7J2qXADyJf496KzKSlm9lqHSmDzS6EPTZUkg5+mAGvcdot2hmK0QFlakU4FEoKQy3BoVNV82g8P+etz+5UbHwTQOUExQvwg2pc3IfnY2IPQdfClMGDAYnLS0MkNN8StC11esnp7+PxGD30kEK1FC6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgbSwe6a; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgbSwe6a"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso37868776d6.3
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737368219; x=1737973019; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVrThU83vZ5H73oLhTqtQwzItGk1gBFlj8uzbRxyZks=;
        b=WgbSwe6aZ1wfdqX6U53E0UFGvg6vddAgvupsQD1ff0tgep+QVjFHTGpQmZHM5yP+/+
         VK/fCp36OScfBYT7Ea/OJUI+myvFUkKAoAg03Uh/hyghu7WiBM/XNOYViKEt533G5KtB
         jumdNh7dDnjTGT3CJXYBTc8L1cZziEDfi/Gm+QMpHQ8WYwbivgUvi/RtmzG/0/hEXch3
         9mwJDFjVWTOksGTFC4XuPfz7IGZGg+s1rRiuiTAegdeix/CVXX9OWyfAi+Uks/P46QnH
         7jwt1yXHF2dxF/tkvp/4WKj1TIEJhjKN2E5NHVnp77K84/chCKTWgat09aH8JBs8bSCH
         EWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368219; x=1737973019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVrThU83vZ5H73oLhTqtQwzItGk1gBFlj8uzbRxyZks=;
        b=EIlJmb/RsrjklgQZKQzO+4bwXe3B2Fjp33VubmMPF7dPAXSScamIgojiBtA0jEyyt0
         wHONkLVcQopSNe3EtbIpWrz6uAhqByEU2zqXvIrcpoPFrb+iuhK0lzPnLNPgQLIhbQx5
         3+TdbIhD+UQuamL+JJtBSaI6xpeRCwvvnSf58xWb4cU3VmEFfBw7wAsRFf37q40m3E+7
         TDIUoRexEjX1uNkOt8pTszfsFqR8F8KkiOfRF7reQJ/XiYPKE0efJ3jHIOse8r3pc4wx
         TrfHDrls480w9PJ/2bh27gMcVfdrOt3gRxveVgnQvxq/ye5FqZPjHctd8HmxbG+gM00n
         ZLtg==
X-Gm-Message-State: AOJu0Yx6t7xyImm+UCa23GKbYX9I/gBAYrwm3qAZ/ZXJWiOmhHNBqpCP
	3HI5SaBVUb896BtQf2gTO3OwKMCqIJJ0xi06kEnH7IrQOJ+ag125
X-Gm-Gg: ASbGnctn203rjaCvFnySza6OWqZoe3if/rWaC+sG9j3rI8KXFuY5vKXyB8H6yeqi2/3
	B1DQvDPHpiBKPpUykWAhmP+dilaioXFUTrGG9AeLnRGNBi1+5FbPg1TckNayUNjn3ctHAR33IF4
	u61O26u3y7f/z/f899BvHZ2HMfDgpK39055oAt1gohAA9nZSErF6JVtiecV+3dKBbRm/kRFaqUq
	yiIg0CI425arXyJ2ypGhxA6h9NWGt3PZbPz6eSE3G3xT3jFEFjaM+7BT7/vALTbxYo=
X-Google-Smtp-Source: AGHT+IHWsCDp+rMCIvKd//LQXmnou5+5ZLPiZihGfKVZrHa5E6zB/aee8bOWFYwEgMOAnN9n+FXCwA==
X-Received: by 2002:a05:6214:27e2:b0:6d1:9e72:596a with SMTP id 6a1803df08f44-6e1b21d8673mr217503466d6.37.1737368219411;
        Mon, 20 Jan 2025 02:16:59 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcf4ef9sm39778626d6.111.2025.01.20.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:16:58 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/2] mm/damon: have damon_get_folio return folio even for tail pages
Date: Mon, 20 Jan 2025 10:16:49 +0000
Message-ID: <20250120101650.3761306-1-usamaarif642@gmail.com>
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
Reviewed-by: SeongJae Park <sj@kernel.org>
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

