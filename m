Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E6233D88
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487306; cv=none; b=h6XGZEbfsN5usRM0PhLymdENYh1sEkxU8PumsI+7bVmFDqvH2C/YFPs2AybZZEP0S0UPyqWoZ1JrKC/lo/qe8tMVX6/7+g96suY41FZysurr75xpgITHAMX1xerJWDws/8XIIs5oraIutYu7M5ZNrBzHDOnAnCOHISKSckTenMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487306; c=relaxed/simple;
	bh=grkq1k7ZCl4I+T+IgPaviet0IWCAb1IC3dO4Q0rvbR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcvNWd27RYdWOCxy0etCeIsigffXLxH+jckTL8FhaFw0s3adbZNLkUoK+W3mc5vJ8Y3ohDanqPr5M3yJqp/j9QUADHt40ukul2q3nUNhecHAuCo6i5wRX/io2ZaA0uwKya4vvrEyTm6KtymATY6dVwBYQ9AZZjdCs+dpQAIkJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbvDKVvO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbvDKVvO"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70b4e497d96so51156827b3.2
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487303; x=1752092103; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiZANFhzMVZOSV0URi2HW3PqK+ggIehph8dgAXp+7Gc=;
        b=ZbvDKVvOv7L3hAqw6UT1lrYUYAyOMR63KW/UW0u6WPdoqJLseX8+1w/OlOruBH7y0s
         Pv8nh66bafx96AB/q92fIdVgnS/iTqxRW7M+3FBpoZsdJ1h7NctJ+8pvpl5QNPQvWosp
         rscY9zqhGaQSp51exywuxinf1E8H9FLC1muaBLPLfhOZ+ohPZc1XUGZ0AdYstPV8QsHP
         PldCx1lRI40jgJtHNmZW/w4dKhT7DDn5ZvVSRqbW+O2ThEl0QEaPusd2tcyfULVaLohz
         1Tc2rAly7jToJ01cLkCPV8qTnODCDRngo6ZWCT4P9YPtW9lP+DVwM9wpXJzoWPjLuX6G
         cTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487303; x=1752092103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiZANFhzMVZOSV0URi2HW3PqK+ggIehph8dgAXp+7Gc=;
        b=Apk5GJyWPloyBLiffKFyURx8wkfhKWLpIoJsx3CM+U9GMYmUammgV8NS09vpvDlp6B
         my4FfwRqPRAk+sxSlE0ll5ZfLR7HhMpYIXyOtYkG3tDGG52uSqYaTzsFVL9PgyLcqwte
         DKt4Wt8XmFDgfcE+tkzUOmEc3iw08wyjYy9JCRoAw5t43zbB7tcB/7vqgqk0cTBkjwUY
         8CDvyRf4n4uRilqVgqoksbvR7bcJUXICo+b6cZWd06D657NwlGjFDC173GYvEXDMjaMv
         ck0js7NMZzK/6ZhBbJIeBqXX3GYt9HA6Tc5JW2v8Rifp1FZp2MJ1NJjuQSLuvbyfY6Wi
         d1CQ==
X-Gm-Message-State: AOJu0YyVdfv64vRIXYIw4yVOJhl+bpGiHJGhQeyvZVwca53T+Ky42KJQ
	j+sFs59s9QD1ka6kA0c8sifly6AbD9eEQzq51d7K3BopFf5ruqnK/FQDyHEycdzjYow=
X-Gm-Gg: ASbGncvGp5Nuq4PGEuDxE25E5RahaIVp2Cb9dUxjJ10epWHerGth52fueOQfyDrEF77
	Q8y3nXNWoZzyRrvkf1/SH6uaUHhvUNOYClUdmdUJG+6Iq5gD41dZNTQarnUdDz4lyT1v/tJqF8x
	PG74Yb2skXDmIcEfFH1QntfMwKyIxtbWbR7QkglxF751LzgOTyoZAewum+av809JdhqF4NWOig+
	0VL63slGkSwiU7qAuAiJwcpIxU4euAxiXhJUT5l+ik3VQX1lRurSXvTig/YUAzlcIZ4xCUsQkHy
	hNYR1s3AHZg3XeRVW9mfg/y28c0PaHuPFeifqq91B6MzRzgUb5Py2ggdgWgkosGvwCjMAL0Pyew
	AhQCch+0=
X-Google-Smtp-Source: AGHT+IGXljG5fdV2UV7d/ojq16hPZdWQ6hJouShkJiIdv6pbB0txRRUWvUoz7wZX8friaN7DEPp3vw==
X-Received: by 2002:a05:690c:11:b0:712:d473:b802 with SMTP id 00721157ae682-7164d40a305mr64256017b3.18.1751487303270;
        Wed, 02 Jul 2025 13:15:03 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:15:02 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH v3 12/13] mm/damon: Move folio filtering from paddr to ops-common
Date: Wed,  2 Jul 2025 15:13:35 -0500
Message-ID: <20250702201337.5780-13-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patch moves damos_pa_filter_match and the functions it calls to
ops-common, renaming it to damos_folio_filter_match. Doing so allows us
to share the filtering logic for the vaddr version of the
migrate_{hot,cold} schemes.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/ops-common.c | 150 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |   3 +
 mm/damon/paddr.c      | 153 +-----------------------------------------
 3 files changed, 154 insertions(+), 152 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 918158ef3d99..6a9797d1d7ff 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -141,6 +141,156 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 	return DAMOS_MAX_SCORE - hotness;
 }
 
+static bool damon_folio_mkold_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
+{
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte)
+			damon_ptep_mkold(pvmw.pte, vma, addr);
+		else
+			damon_pmdp_mkold(pvmw.pmd, vma, addr);
+	}
+	return true;
+}
+
+void damon_folio_mkold(struct folio *folio)
+{
+	struct rmap_walk_control rwc = {
+		.rmap_one = damon_folio_mkold_one,
+		.anon_lock = folio_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
+		folio_set_idle(folio);
+		return;
+	}
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return;
+
+	rmap_walk(folio, &rwc);
+
+	if (need_lock)
+		folio_unlock(folio);
+
+}
+
+static bool damon_folio_young_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
+{
+	bool *accessed = arg;
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
+	pte_t pte;
+
+	*accessed = false;
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte) {
+			pte = ptep_get(pvmw.pte);
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			*accessed = (pte_present(pte) && pte_young(pte)) ||
+				!folio_test_idle(folio) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+		} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
+				!folio_test_idle(folio) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+#else
+			WARN_ON_ONCE(1);
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+		}
+		if (*accessed) {
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+	}
+
+	/* If accessed, stop walking */
+	return *accessed == false;
+}
+
+bool damon_folio_young(struct folio *folio)
+{
+	bool accessed = false;
+	struct rmap_walk_control rwc = {
+		.arg = &accessed,
+		.rmap_one = damon_folio_young_one,
+		.anon_lock = folio_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
+		if (folio_test_idle(folio))
+			return false;
+		else
+			return true;
+	}
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return false;
+
+	rmap_walk(folio, &rwc);
+
+	if (need_lock)
+		folio_unlock(folio);
+
+	return accessed;
+}
+
+bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio)
+{
+	bool matched = false;
+	struct mem_cgroup *memcg;
+	size_t folio_sz;
+
+	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_ANON:
+		matched = folio_test_anon(folio);
+		break;
+	case DAMOS_FILTER_TYPE_ACTIVE:
+		matched = folio_test_active(folio);
+		break;
+	case DAMOS_FILTER_TYPE_MEMCG:
+		rcu_read_lock();
+		memcg = folio_memcg_check(folio);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
+	case DAMOS_FILTER_TYPE_YOUNG:
+		matched = damon_folio_young(folio);
+		if (matched)
+			damon_folio_mkold(folio);
+		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		folio_sz = folio_size(folio);
+		matched = filter->sz_range.min <= folio_sz &&
+			  folio_sz <= filter->sz_range.max;
+		break;
+	case DAMOS_FILTER_TYPE_UNMAPPED:
+		matched = !folio_mapped(folio) || !folio_raw_mapping(folio);
+		break;
+	default:
+		break;
+	}
+
+	return matched == filter->matching;
+}
+
 static unsigned int __damon_migrate_folio_list(
 		struct list_head *migrate_folios, struct pglist_data *pgdat,
 		int target_nid)
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 54209a7e70e6..61ad54aaf256 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -11,10 +11,13 @@ struct folio *damon_get_folio(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
+void damon_folio_mkold(struct folio *folio);
+bool damon_folio_young(struct folio *folio);
 
 int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 
+bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 48e3e6fed636..53a55c5114fb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -18,45 +18,6 @@
 #include "../internal.h"
 #include "ops-common.h"
 
-static bool damon_folio_mkold_one(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *arg)
-{
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
-
-	while (page_vma_mapped_walk(&pvmw)) {
-		addr = pvmw.address;
-		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma, addr);
-		else
-			damon_pmdp_mkold(pvmw.pmd, vma, addr);
-	}
-	return true;
-}
-
-static void damon_folio_mkold(struct folio *folio)
-{
-	struct rmap_walk_control rwc = {
-		.rmap_one = damon_folio_mkold_one,
-		.anon_lock = folio_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
-		folio_set_idle(folio);
-		return;
-	}
-
-	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio))
-		return;
-
-	rmap_walk(folio, &rwc);
-
-	if (need_lock)
-		folio_unlock(folio);
-
-}
-
 static void damon_pa_mkold(unsigned long paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
@@ -86,75 +47,6 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_folio_young_one(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *arg)
-{
-	bool *accessed = arg;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
-	pte_t pte;
-
-	*accessed = false;
-	while (page_vma_mapped_walk(&pvmw)) {
-		addr = pvmw.address;
-		if (pvmw.pte) {
-			pte = ptep_get(pvmw.pte);
-
-			/*
-			 * PFN swap PTEs, such as device-exclusive ones, that
-			 * actually map pages are "old" from a CPU perspective.
-			 * The MMU notifier takes care of any device aspects.
-			 */
-			*accessed = (pte_present(pte) && pte_young(pte)) ||
-				!folio_test_idle(folio) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
-		} else {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
-				!folio_test_idle(folio) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
-#else
-			WARN_ON_ONCE(1);
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
-		}
-		if (*accessed) {
-			page_vma_mapped_walk_done(&pvmw);
-			break;
-		}
-	}
-
-	/* If accessed, stop walking */
-	return *accessed == false;
-}
-
-static bool damon_folio_young(struct folio *folio)
-{
-	bool accessed = false;
-	struct rmap_walk_control rwc = {
-		.arg = &accessed,
-		.rmap_one = damon_folio_young_one,
-		.anon_lock = folio_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
-		if (folio_test_idle(folio))
-			return false;
-		else
-			return true;
-	}
-
-	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio))
-		return false;
-
-	rmap_walk(folio, &rwc);
-
-	if (need_lock)
-		folio_unlock(folio);
-
-	return accessed;
-}
-
 static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
@@ -205,49 +97,6 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static bool damos_pa_filter_match(struct damos_filter *filter,
-		struct folio *folio)
-{
-	bool matched = false;
-	struct mem_cgroup *memcg;
-	size_t folio_sz;
-
-	switch (filter->type) {
-	case DAMOS_FILTER_TYPE_ANON:
-		matched = folio_test_anon(folio);
-		break;
-	case DAMOS_FILTER_TYPE_ACTIVE:
-		matched = folio_test_active(folio);
-		break;
-	case DAMOS_FILTER_TYPE_MEMCG:
-		rcu_read_lock();
-		memcg = folio_memcg_check(folio);
-		if (!memcg)
-			matched = false;
-		else
-			matched = filter->memcg_id == mem_cgroup_id(memcg);
-		rcu_read_unlock();
-		break;
-	case DAMOS_FILTER_TYPE_YOUNG:
-		matched = damon_folio_young(folio);
-		if (matched)
-			damon_folio_mkold(folio);
-		break;
-	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
-		folio_sz = folio_size(folio);
-		matched = filter->sz_range.min <= folio_sz &&
-			  folio_sz <= filter->sz_range.max;
-		break;
-	case DAMOS_FILTER_TYPE_UNMAPPED:
-		matched = !folio_mapped(folio) || !folio_raw_mapping(folio);
-		break;
-	default:
-		break;
-	}
-
-	return matched == filter->matching;
-}
-
 /*
  * damos_pa_filter_out - Return true if the page should be filtered out.
  */
@@ -259,7 +108,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		return false;
 
 	damos_for_each_ops_filter(filter, scheme) {
-		if (damos_pa_filter_match(filter, folio))
+		if (damos_folio_filter_match(filter, folio))
 			return !filter->allow;
 	}
 	return scheme->ops_filters_default_reject;
-- 
2.43.5

