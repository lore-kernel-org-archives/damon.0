Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BC1FFC71
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623378; cv=none; b=fA34FpM9zaD9sdsyPfR+Hs+oI11CseXGfbej3R0dz0/wI5PKOLnMoI7y/kkgpwEyDP6CQspKy7/gpXi5fQjRqpVV5dY2sc7x5TcJfQ+ky/6E1pAP9b+S9b80pua0snf9e9Q9KKBSe65Zx0i1SEKnxKCWkJh4DGcpSl/K/FyVS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623378; c=relaxed/simple;
	bh=+ukYk0751rxUsGiHvAsG+TDvJEyM1y3UT5ZuUFtqdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2M7TRmk+mX2jyfLFTeZ7Ed9JUxV7SQtjbksC1iKGnqx+mdls+/f9SbuEc33ruV5pMiN9jy8avElSguSUQPtxJr1JLyWGyMjv48FAeA5FSjuPn3kW5MFGFdqUmnDkdEJGA+LLZDCxLqFrmHAo9+Qa75JcZkpD6oyHIe06sXmfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOlpj3tA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOlpj3tA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46785fbb949so57202121cf.3
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623376; x=1739228176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41tMxJUWugj4muQLNlfvYZtegLPJnS/0DzPLe1FwwWo=;
        b=HOlpj3tAzzxY2RQsRcqe3U0XYYzvMFoUfi377+9jbSqlwePwIWXJ+K8qYrQYSR4rNd
         FNQQ6bMKp5id/DNDS04/hdE56PTNC241FuacFR2jVK0FLvHwF5zNjm/71SObVAodX/X5
         RYNBPFu5ZsmH/sdYMuym5Zovq6AlhbpPQDCnx+UIy5YJnl49Qh+1+vZhgyDernAnKqsp
         3Ons2EfKICgtobhGbyHpIoG7nGG2B0h99puAFqTUnEXLGc5MJItj3etsd0KpbAyDePjG
         +fCvafZkjHy+bb2TTCmWgoJUyhTj/CtBtyT4y45qs19VcrJ3ZQWeBZJ/tN8CFvTW/dzd
         vUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623376; x=1739228176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41tMxJUWugj4muQLNlfvYZtegLPJnS/0DzPLe1FwwWo=;
        b=dzkSvLhVCC9CiB6EmiwbnIi4fK7QZ1EEv0W8owuo1WhjP5sf3o900AqMx4KVda5s0A
         UfbW4uqDOCA368OIXWYj+Y+m6pnWeE4qf21dIjtvlQ9Bnd3G+777uJ3iJa2OTAocgADU
         wZiYKag8VdgYpUaMGkZL5tnFyRzFZXbKxPy5XC4ZnP02epk+e46l+uAyJrkGYOdIe/vn
         kan1WW8EoX6u2/XBs5jAOxi63wqsyeEZ37ZmuApYWuDNJpd0+O5oZuBuSKcxscIZ3x4y
         8CUtxCFBktZCPPc5dhP+l1UEXdg2FYW094FLf5HbhuLLdNrK8KZa9gMuGBiuNX0bR1hu
         bQWA==
X-Gm-Message-State: AOJu0YySktAT1e6FW93nWhMKQ550Agn5P1vhVC0grx/AkL2h1qxjw/cz
	Cs24ylyc9HYPDJUzCiS5yLuQFP7km53V5p9zrhBqMxqVf9k7r36/
X-Gm-Gg: ASbGncvRfkebFzqW4pPgRPExjC0cZdLkkAm/2pkXNxyk7v2/4ZEL8q7vXFqIcHV/N0L
	JsERhNLJ9nFHlglGPK+gkdJNKHZWli4cRA8f9HjDBuk/kPCvpgcim6AYfMcXcuf2e00mkMTyspL
	i60eGRN1ix+gBB8gWTPSGCUW8UM6hC2tOaNG7GQy/5cFULAV1w9DHXRnRP1g6E745a6h+/f+8jP
	LNERIgfI/FS6aCaN9rMnWxfaXZWYoHgKKv8pwKzv3N7BdObSOlBb9uPflG7amHefZnFzmNavujF
	qcbr7xPgfw==
X-Google-Smtp-Source: AGHT+IHEyMAxtPn4mYYMqnCdQIZdRu7V7ahosAsbjAMTD4Ru1PKvmdma8lTgGBBBhUTzDhEWxaAU/A==
X-Received: by 2002:a05:6214:3bca:b0:6d8:9ab7:adcc with SMTP id 6a1803df08f44-6e243c37f22mr385613186d6.22.1738623375949;
        Mon, 03 Feb 2025 14:56:15 -0800 (PST)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e42370f364sm538906d6.106.2025.02.03.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:15 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 1/6] mm/damon: have damon_get_folio return folio even for tail pages
Date: Mon,  3 Feb 2025 22:55:28 +0000
Message-ID: <20250203225604.44742-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203225604.44742-1-usamaarif642@gmail.com>
References: <20250203225604.44742-1-usamaarif642@gmail.com>
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
index 0f9ae14f884d..0fb61f6ddb8d 100644
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

