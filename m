Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7E7DA82
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397207; cv=none; b=W1FEM9vnos467GAfGUe3KMi0o2Ir7xKeICTkB8j2Fq/HincbEbdlRA2syRFCAZGjYqKfp2NO9S+68btK8REW23rt0QXCyJKOUjsFDGBaUOGdGoDYndr3WAvkd4FEbExkmStZMd6AoluQmw7WQSOaFLI4ACAASMza1HuatuGRhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397207; c=relaxed/simple;
	bh=c2xTNHI8CovG75AGhKvkDolmM50AFA1OHJrsd+yTSiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o71J44qV1979/oYk7jTx1mAGjvKFgEgqjS5FNIKG4Zc07k2Nmy6ZnPTnIros5ympKdmE8X3ANvwrHsZ/ttMDgPHYSpKZ5E8udMV/Zk17i0JuOn55wZMYxKMybQ/sSWrZ7b2F8/pboUKM7Lhkw8jhTwnZ4chibN5DEOQelHeAmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlxsxbyN; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlxsxbyN"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6f7d7e128so557302785a.1
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737397205; x=1738002005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVrThU83vZ5H73oLhTqtQwzItGk1gBFlj8uzbRxyZks=;
        b=hlxsxbyNpttUhAkwHr9jiDpXWWRSAQf/NeBv+V/s3En85mz/4+8fPS5gvQE3TbAQTV
         XARafGnpTZ2Co9xxi1er+KibFU2YXPHYgQPQlSBkwSDkApK0AvFyCh47G4sCZ4vamS2M
         CSjw5cXZ5UEpyFAhiSLwjOAa8o36n83yium2BWHMsv4n/S2tsjVzfmSGQXEwDhoPG6Po
         4ys9Y0qU8xsZxvkEAIPLfjB/l1ubcVk63Sv+d5QBpRpL0GNHWVwxAVbxvCHmUGS7q7BW
         Cb39TD8U7E9daJFOF5h4LjUcBp2hPq9EbYWgDkkCofkLm6OWTlMBpZurY2iVYM8CuKGc
         DIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737397205; x=1738002005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVrThU83vZ5H73oLhTqtQwzItGk1gBFlj8uzbRxyZks=;
        b=jPNFKn1S34ZE4JAM6LukCOcDxbKHlGTFhHEKTkTSQYV2ThFRRE2F/OdSmc5j1/Z0QY
         tdVlprWcNhRXs53QhJGOmHZn7bsRbvnoDDLy7bQtMA/kGE4xxUHXejqWpqzDXD2OdafA
         jq20fUBErZdgE/nr6ZPCYhWrBB5dRHVjH967puVusTMobem0Yp1/eByAbp+ytX3r06b8
         cUoG4Cb/LnDMg2UwfgjKhnop2MZmSpFmaKDRLLMDW2bxSyeLYvS/mkgAJPQbZDAvTw+W
         8Yh7IzhPeRuhZtLmtMby6w1kMLiCCHnm4eb/Z7GzOaleaT6ufhoXBCKOqDfzLaDBIUjz
         ngAQ==
X-Gm-Message-State: AOJu0Ywux4DM+2ysTJa30sKz4qZjoweCIBUR9kj+Tym8mIJx4B53ZIaL
	Ao4kM02x6nNaMwU9VJEgWcJYtn5569KvsD6p6z+RNpQtwUyH7uG2n0UC9vfn
X-Gm-Gg: ASbGnctq0fcfncHMO9LbwLKTDacMhM6e37rU2xeQgERYs17DvSq008IfySKMx0+Lnft
	HMGKPWpZJYGYJ9edj6bnC+uwbzHBN2HW8f77ZkuJOdVyoE2WF+kyPxtJL0PN30Trzjh47aEXe7i
	BFK2ojMvP+Z/UZG7alUoQ6qrm8YLZhE1iX3fd2qN0C+dCZPJSzNtcNxpShCIuS1Ia1J/iOBW0L/
	2nPpuaIy+aQNHIxd4Em7y3HJzBkfPU4Xm9YQEeXSA0B36xaygFivRh+E0ON3z0hS3s=
X-Google-Smtp-Source: AGHT+IHWKPSR5z9JA6koDvNP81QlnTvc47HRNzCL+8YDLseL8aIfUAnt2oN7O0sCFq1Zh0xaT9RoHg==
X-Received: by 2002:a05:6214:5c01:b0:6d8:b733:47c with SMTP id 6a1803df08f44-6e1b27a48fcmr243385356d6.22.1737397204636;
        Mon, 20 Jan 2025 10:20:04 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afb1b293sm43501026d6.0.2025.01.20.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 10:20:04 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 1/2] mm/damon: have damon_get_folio return folio even for tail pages
Date: Mon, 20 Jan 2025 18:19:58 +0000
Message-ID: <20250120181959.2564362-1-usamaarif642@gmail.com>
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

