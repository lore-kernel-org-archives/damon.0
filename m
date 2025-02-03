Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B561D5CD4
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623380; cv=none; b=doViSxY3oT6O4UcRN+52Eu/Tn3A0AF5YFIiL3ATy+cMQnM/BGkVLfVLI3GoIInDub6LpzxW6WlTfzF9YyJ/k4WWiZNC0mKm+K2r3Eq8I9txxfnVzhKEVGmDGBg9INT6cti+YOiEDoW/TZj/mAkRZG/Tseehq2GM7aFTqkaQwYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623380; c=relaxed/simple;
	bh=B9fi34J8ZHgYj8UL865twWDYpooNUbMZWZ5vm5iqczc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCk0xTYgkqH45xxJ34L8ZrgWq4VIUj8uw5uiNJF8JpGfiGzvzr1Z35YVZBKC7Js15lnf299CQuN/DTr5mGb66sasPmgmeSFfAiuE6nHLv3CzMMbv1/ddqByxeLOTIaZce+FEu0v5R7OaOM1+SQZKm2Clf8Zc5pOZWhtgTGdvc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmbQogqv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmbQogqv"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6f7d7e128so557840885a.1
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623377; x=1739228177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvJt+fEruqngkpaxyGnr3ktUZyTGWut/bbCY8AbcNuM=;
        b=SmbQogqvaAzynG+ob4xzLV1qaNYI1GpbVSImrl3Z5PZEt1rrs2Kaq6E6j/GEt4iN4b
         OeuBNhp0B+n8O5KBGybAvGmfW4sdzoXbZe0t4YttlAt62Ww30UrfFe9KRKXmdulGUYLU
         7CQTXKzHX2V3defng099Gd0LroYNQLUOlNQfQWe0nwT2lTWCPFsgThovmu7v1jRkO7sh
         w5hFyMvzoO16xRRBq5vj/AtFFSDODwUsa7+V2seWXsCzGCXOklpVxTLwSOjlErjyICs6
         42EeM3CLoLaO8UINe+ePA1qXjWz9D/SNPQSWQVTGg6cCWC/d5qOhCO1LKOlBj3gWkefq
         EvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623377; x=1739228177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvJt+fEruqngkpaxyGnr3ktUZyTGWut/bbCY8AbcNuM=;
        b=n2nF6CvI8a2U83x0OaYnA2uSqVgbCZ/v5Rc1hXGzoVHvLU0odDnCTCCtlq/xd/OyAk
         MHpiNGbtrc0lHIN0UvVm6vHbpZBFuykDaRE5QvunwlQBklcgcYs3kHhRkiTokPyJF4Dy
         CsxhO0PiPNloK8+FwqWgsmRcOWTH6jHAOWcK8eHinOse/VUzRC5DzDV8FtI8DL9KNTXh
         uWNqB0eiwbkmeOBegSxDIa08P0QoKsBsqPhVVzSiZvKbMKoSWsxKV+xjvoeVOjk3p3Yr
         qLfOoiRnuMXeS78WGNEg5nfT5l2Rd9KJXZ3EsqjOa+FCz+q891Hatw0+ULs2cCTUyFDV
         pC5g==
X-Gm-Message-State: AOJu0Yz6JaGqmATKNe/Lge/+ssXcWe04jTjtKncsdRlmc2j7eDZb2DwB
	jkFKCWxmr9Ay4uDlX/zOF39PKZ8vMciYI6tFN24ku2xSDCkKm/xO
X-Gm-Gg: ASbGncvlSFLvdjaCD0TIVXQytZvpGGmdP499oLqMrXJKfPQuiMGqpm7sBH87oBO0Xt5
	MP6Qkxvm2D+VIfctc8rNBEiBVbE1gZqwPgvW+K3FaKALRiA3RgxBbXRd50zxsMEXPKpBjU3RGcT
	GikgO5H9vBXwc/JMGwc2U+YCDXpftASJ5jynn7cHcGRccbfMv71DQvnW+Wklu7sUrBFzaMvxmXW
	31MeqqgtFIRPqZFXc1CLPWqW+VHQo/YeUgLGuMWFiaxbolzNVdZlozLSF0aVh0QsaOfUF+pgo9X
	vyyFdOguPyAtOA==
X-Google-Smtp-Source: AGHT+IGZGiDWsAItpMx6EqpFdOI9RwZXbh1AnvXhNiaoicoO9ioWU9y5O0LcM7+GW7aqKjxfh7rJbQ==
X-Received: by 2002:ad4:542b:0:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e420f70692mr17900976d6.15.1738623377338;
        Mon, 03 Feb 2025 14:56:17 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814d0csm55155536d6.43.2025.02.03.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:16 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 2/6] mm/damon/paddr: use damon_get_folio_in_region to obtain folio
Date: Mon,  3 Feb 2025 22:55:29 +0000
Message-ID: <20250203225604.44742-3-usamaarif642@gmail.com>
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

This is introduced for larger folios. If a large folio has subpages
present in multiple regions, it will be considered multiple times.
This can be when checking access or applying DAMOS schemes. For e.g.
in pa_stat, folios split across N regions will be counted N times,
giving inaccurate results. Hence, only consider a page for access
check/DAMOS scheme only if the head page is part of that region as
well.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/damon/paddr.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0fb61f6ddb8d..3f59a3fdc391 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -19,6 +19,30 @@
 #include "../internal.h"
 #include "ops-common.h"
 
+/*
+ * Get an online page for a paddr if it's in the LRU list and if the head page is
+ * before region_start. Otherwise, returns NULL.
+ */
+static struct folio *damon_get_folio_in_region(unsigned long addr, unsigned long region_start)
+{
+	struct page *page = pfn_to_online_page(PHYS_PFN(addr));
+	struct folio *folio;
+
+	if (!page)
+		return NULL;
+
+	folio = page_folio(page);
+	if (addr - folio_page_idx(folio, page) * PAGE_SIZE < region_start)
+		return NULL;
+	if (!folio_test_lru(folio) || !folio_try_get(folio))
+		return NULL;
+	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+		folio_put(folio);
+		folio = NULL;
+	}
+	return folio;
+}
+
 static bool damon_folio_mkold_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
@@ -58,9 +82,9 @@ static void damon_folio_mkold(struct folio *folio)
 
 }
 
-static void damon_pa_mkold(unsigned long paddr)
+static void damon_pa_mkold(unsigned long paddr, unsigned long region_start)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio_in_region(paddr, region_start);
 
 	if (!folio)
 		return;
@@ -73,7 +97,7 @@ static void __damon_pa_prepare_access_check(struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_pa_mkold(r->sampling_addr);
+	damon_pa_mkold(r->sampling_addr, r->ar.start);
 }
 
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
@@ -148,9 +172,9 @@ static bool damon_folio_young(struct folio *folio)
 	return accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz, unsigned long region_start)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio_in_region(paddr, region_start);
 	bool accessed;
 
 	if (!folio)
@@ -176,7 +200,7 @@ static void __damon_pa_check_access(struct damon_region *r,
 		return;
 	}
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
+	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz, r->ar.start);
 	damon_update_region_access_rate(r, last_accessed, attrs);
 
 	last_addr = r->sampling_addr;
@@ -268,7 +292,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+		struct folio *folio = damon_get_folio_in_region(addr, r->ar.start);
 
 		if (!folio) {
 			addr += PAGE_SIZE;
@@ -307,7 +331,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+		struct folio *folio = damon_get_folio_in_region(addr, r->ar.start);
 
 		if (!folio) {
 			addr += PAGE_SIZE;
@@ -474,7 +498,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+		struct folio *folio = damon_get_folio_in_region(addr, r->ar.start);
 
 		if (!folio) {
 			addr += PAGE_SIZE;
@@ -518,7 +542,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+		struct folio *folio = damon_get_folio_in_region(addr, r->ar.start);
 
 		if (!folio) {
 			addr += PAGE_SIZE;
-- 
2.43.5

