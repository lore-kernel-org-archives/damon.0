Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793073278;
	b=lE21BjlwGWmJJvLyovTuppP7g5u7XNyMRbVk0QJORQKh0UHDmowbDcoSZ8wVOfBUxd6U
	 kzxkY8NlNen3Y839aP+lO2IISzLfEk4oLgQzXqzfv3ImhC8ZfOnxDr41QZ9VFeLH1mnUC
	 lQegrtJH3SYwQoMU5fdLUbdGtU05O9vbJaslTkGAd3D8MGhjG9v84I/jAiqnjbjSPs06H
	 cPFbBcya5ypUEQCuR8pQnvH0bSZBEPewTop7ricD33PxOvxiv2N3K2Xo+b6V8CREZAnSQ
	 ZReTXGGqZE7TLbgDSL92WDV00Q3qpMv76OWh/eM9on+LN6sZSgZjatXeqTdqN8Hpkfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793073278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2AEMzOaulMq/RsoCrjXdy/D9LsLssAz3PfPw5l67yFs=;
	b=yVy6EclsVqEFFqlINi8RLLiLG27fHvHs6TV+J6MHxVQDHqeoleSmrSsdXAoaskID78KF
	 i1pdI+7lf1zVuR23y/aBpK/T+fbNPiSNia+PdtbhU82j2fNY7jRomWF1ir84I02vwHSr5
	 h/TqCVZYXpH2py/qOTQrD8w/wITYw468VOQjo2rLctRC7KUAGAtguUQDkeUO+j3tZ0kiV
	 D7N66skJjf+N1ObUvUMx8g9nIJ+JpiCN6Y8CkM1R3LPrVwTAQ/7PBkjTqhuokhUPXl/h0
	 WIh6g87NscRGPwrU5pvUvy/k8QYajqQUJMw5PKY516B7CwfApSWUSv3Is0ii4j9QE9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eqZasIgu;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78913606A31D
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 03:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78913606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eqZasIgu
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8ad5b2f61so6531245ad.2
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793073278; x=1793678078; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AEMzOaulMq/RsoCrjXdy/D9LsLssAz3PfPw5l67yFs=;
        b=eqZasIgufeLBJLrFNgXRn/GpwT/vfBEvGPbkAIW5ZGPTNFBLR0aySQaFcPXF4RGbSj
         ewpJIIv0wth3Opnxdo/R6Ffix3p5THXMcewps8MI3+8PiVFtwE4yVgY/hnX4YIttpLNT
         U+1eIG4R1/hkL8rMTHBUtu+ltxEzVNxJgRmoX8U0JZ3v4sJSi9XnMC8bsoNBNLu/XXXE
         W7BW7CaUm1SdomJrBaWoSm9vxQugKTiFXIvTTo3cQCnSJvo2Rep5CLQKjdOIoyp07FWo
         xPlylil/5n9/eiGx7wKn+jTMDxujy9Qob3Q9z3Iu/I3kHbJmtL8jZv2EEFFzVuPPz1bB
         jXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793073278; x=1793678078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AEMzOaulMq/RsoCrjXdy/D9LsLssAz3PfPw5l67yFs=;
        b=lA3ycEbLY8HRRnd09oEE1YiYKYn0HiPenyVz8bSonbWLbRCt9v2jUKt8fBaxD9/rp+
         vrN8EoePl7tT2Dof1Cvu8V//Hnnwl+k/Yb3r6+EE7BXKHb+VpEeMRSCLu82i+GbSaZYD
         fMB+BCIVxNjx7bJmUk321yMVghWj69S03FxIAQ3AL+JxHsP8Jk7tp2HtTmFSMsbnAJ9G
         IhZsfvccQgm4FldeQgL4GDLrApBjAjEtJJgpxX+ePBC414Q/3mc1frURrC+qvO0ekSYu
         1zi6w+I9Eh1c/pZQ5L5Z3H5Eo/xEUuTBghU9Z7FPDvJWrt54+A49UtI5GkVK3l51aNdQ
         Inhw==
X-Forwarded-Encrypted: i=1; AKwUvByuFQREY1AMHWGNn0aYPXNT267nHChKDyaHHILM6St6mnUYsD4k2b5r0f/TalgXR1kZR36OXA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJUsCktIP50hplluxOkPUiHVQMrLRDrs3M7YL9Z1L7SYN4RChGa
	wJZenovxjZkKL7VLSg4NbwFSxCAQkpTdddAtFagc+TRO/g4Pd7rfN6La
X-Gm-Gg: AYBFou1/Sr95E+BzX/hd1DiauwIR//i+cpfpU+1hQKInUE5PudYeVdx7tAWH8kcS4bI
	eu7k/YNQz7XfYny6Aa1HTHL+qUiCq/a6XTujYES4dHcItuo//hsohwZlOmFl2cgr+CLktZbvwcg
	6B4djYDlZc4hPp44EZSx5+pKjN78mNTFiaezrYPPRnSstc5X5Gp0mG8mkU3ZuyWqo/qxrQqIpaL
	HdOO0bL5yrFjYVje7NEZXjwDusqZSrXe+Bd4rY5CZS5Pl1XBuCtFxKJlGKXtNa+IqutCnSp+dsc
	mNKfK1ubug70thNnR7joOUqeSz3osGwCCvHKiMIb4MtwPnBky7y8bPWfHrSzU9NBjMPIg8hUlIX
	4vOBLuSTchtwa1MwZEji6zvqoAo5qgNGySiyr8bYhnOx+7II5WPTGXCXJPcCL5HyPjrFmpVA7CE
	IuV2eOdme+rl4KkvAyja3idpogPiDiCJ659Pyb73ryMXFw7pM4p/9msJ29N48oaL2PA/Mw6fhUH
	tzD2D8iAJB+pYaCda8ZXpAstJSe5EugcVlbd6DIO3RnPcmj
X-Received: by 2002:a17:90b:2d84:b0:3a8:736e:c19b with SMTP id 98e67ed59e1d1-3adeaf9ce48mr12810128a91.4.1793073277737;
        Mon, 26 Oct 2026 20:54:37 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae406153fesm1657632a91.5.2026.10.26.20.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:54:37 -0700 (PDT)
From: Daemyung Kang <charsyam@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	bijantabatab@micron.com,
	ravis.opensrc@micron.com,
	Daemyung Kang <charsyam@gmail.com>
Subject: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
Date: Tue, 27 Oct 2026 12:54:31 +0900
Message-ID: <20261027035431.1007584-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS migration accepts an unsigned int weight for each destination,
but sums the weights into an unsigned int.  If the total wraps to zero,
no folio is migrated.  Other wrapped totals select the wrong node.

Sum weights into a u64 once per migration walk.  Keep the existing
32-bit divisor path for totals up to UINT_MAX and use a 64-bit remainder
for larger totals.  Add KUnit coverage for the actual summing path and
for destination selection at the overflow boundary.

Fixes: 19c1dc15c859 ("mm/damon/vaddr: use damos->migrate_dests in migrate_{hot,cold}")
Signed-off-by: Daemyung Kang <charsyam@gmail.com>
---
 mm/damon/tests/vaddr-kunit.h | 35 +++++++++++++++++++
 mm/damon/vaddr.c             | 65 +++++++++++++++++++++++-------------
 2 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index d61b503..f67f1a0 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -266,12 +266,47 @@ static void damon_test_apply_three_regions4(struct kunit *test)
 			new_three_regions, expected, ARRAY_SIZE(expected));
 }
 
+static void damon_test_migrate_dests_idx(struct kunit *test)
+{
+	unsigned int weights[] = { UINT_MAX, 1 };
+	struct damos_migrate_dests dests = {
+		.weight_arr = weights,
+		.nr_dests = ARRAY_SIZE(weights),
+	};
+	u64 total = damos_va_migrate_weight_total(&dests);
+
+	KUNIT_EXPECT_EQ(test, total, (u64)UINT_MAX + 1);
+	KUNIT_EXPECT_EQ(test, damos_va_migrate_dests_idx(&dests, 0, total), 0);
+	KUNIT_EXPECT_EQ(test, damos_va_migrate_dests_idx(&dests,
+			UINT_MAX, total), 1);
+
+	weights[1] = 2;
+	total = damos_va_migrate_weight_total(&dests);
+	KUNIT_EXPECT_EQ(test, total, (u64)UINT_MAX + 2);
+	KUNIT_EXPECT_EQ(test, damos_va_migrate_dests_idx(&dests,
+			UINT_MAX, total), 1);
+
+	weights[0] = 0;
+	weights[1] = 0;
+	total = damos_va_migrate_weight_total(&dests);
+	KUNIT_EXPECT_EQ(test, total, 0ULL);
+	KUNIT_EXPECT_EQ(test, damos_va_migrate_dests_idx(&dests, 0, total), -1);
+
+	weights[0] = 1;
+	weights[1] = 3;
+	total = damos_va_migrate_weight_total(&dests);
+	KUNIT_EXPECT_EQ(test, total, 4ULL);
+	KUNIT_EXPECT_EQ(test, damos_va_migrate_dests_idx(&dests, 1, total), 1);
+	KUNIT_EXPECT_EQ(test, damos_va_migrate_dests_idx(&dests, 4, total), 0);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_three_regions_in_vmas),
 	KUNIT_CASE(damon_test_apply_three_regions1),
 	KUNIT_CASE(damon_test_apply_three_regions2),
 	KUNIT_CASE(damon_test_apply_three_regions3),
 	KUNIT_CASE(damon_test_apply_three_regions4),
+	KUNIT_CASE(damon_test_migrate_dests_idx),
 	{},
 };
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d5dde97..279dbc6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -7,6 +7,7 @@
 
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
+#include <linux/math64.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
@@ -774,8 +775,41 @@ static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
+	u64 weight_total;
 };
 
+static u64 damos_va_migrate_weight_total(struct damos_migrate_dests *dests)
+{
+	u64 total = 0;
+	size_t i;
+
+	for (i = 0; i < dests->nr_dests; i++)
+		total += dests->weight_arr[i];
+	return total;
+}
+
+static int damos_va_migrate_dests_idx(struct damos_migrate_dests *dests,
+		pgoff_t ilx, u64 weight_total)
+{
+	u64 target;
+	int i;
+
+	if (!weight_total)
+		return -1;
+
+	if (weight_total <= UINT_MAX)
+		target = ilx % (unsigned int)weight_total;
+	else
+		div64_u64_rem(ilx, weight_total, &target);
+
+	for (i = 0; i < dests->nr_dests; i++) {
+		if (target < dests->weight_arr[i])
+			return i;
+		target -= dests->weight_arr[i];
+	}
+	return -1;
+}
+
 /*
  * Place the given folio in the migration_list corresponding to where the folio
  * should be migrated.
@@ -784,13 +818,11 @@ struct damos_va_migrate_private {
  */
 static void damos_va_migrate_dests_add(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr,
-		struct damos_migrate_dests *dests,
-		struct list_head *migration_lists)
+		struct damos_va_migrate_private *priv)
 {
+	struct damos_migrate_dests *dests = &priv->scheme->migrate_dests;
 	pgoff_t ilx;
 	int order;
-	unsigned int target;
-	unsigned int weight_total = 0;
 	int i;
 
 	/*
@@ -806,20 +838,10 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	ilx = vma_start_pgoff(vma) >> order;
 	ilx += linear_page_delta(vma, addr) >> order;
 
-	for (i = 0; i < dests->nr_dests; i++)
-		weight_total += dests->weight_arr[i];
-
-	/* If the total weights are somehow 0, don't migrate at all */
-	if (!weight_total)
+	i = damos_va_migrate_dests_idx(dests, ilx, priv->weight_total);
+	if (i < 0)
 		return;
 
-	target = ilx % weight_total;
-	for (i = 0; i < dests->nr_dests; i++) {
-		if (target < dests->weight_arr[i])
-			break;
-		target -= dests->weight_arr[i];
-	}
-
 	/* If the folio is already in the right node, don't do anything */
 	if (folio_nid(folio) == dests->node_id_arr[i])
 		return;
@@ -829,16 +851,14 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 		return;
 	node_stat_add_folio(folio, NR_ISOLATED_ANON +
 			folio_is_file_lru(folio));
-	list_add(&folio->lru, &migration_lists[i]);
+	list_add(&folio->lru, &priv->migration_lists[i]);
 }
 
 static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
 	struct damos_va_migrate_private *priv = walk->private;
-	struct list_head *migration_lists = priv->migration_lists;
 	struct damos *s = priv->scheme;
-	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
@@ -856,8 +876,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
-		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
-				migration_lists);
+		damos_va_migrate_dests_add(folio, walk->vma, addr, priv);
 huge_out:
 		spin_unlock(ptl);
 		return 0;
@@ -881,8 +900,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
-		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
-				migration_lists);
+		damos_va_migrate_dests_add(folio, walk->vma, addr, priv);
 		page_idx = folio_page_idx(folio, pte_page(ptent));
 		nr = folio_nr_pages(folio) - page_idx;
 	}
@@ -958,6 +976,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	use_target_nid = dests->nr_dests == 0;
 	nr_dests = use_target_nid ? 1 : dests->nr_dests;
 	priv.scheme = s;
+	priv.weight_total = damos_va_migrate_weight_total(dests);
 	priv.migration_lists = kmalloc_objs(*priv.migration_lists, nr_dests);
 	if (!priv.migration_lists)
 		return 0;
-- 
2.43.0

