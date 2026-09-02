Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3233BBCF
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317828; cv=none; b=hJFaGmfBhZb1V/Br0KMPKfJ98n5vUwOgY6nNxDjPT6P3Q8IybayrJ83Iq9xWXIeca7id/zhQ/g7elgWpLpfAzePwuLLGU/zlJoW5Stgdl+LW3t8y9GXQH+9rsnkhx0mSXFTvlk7GIsI2GPCjdpv4bviXY2USxqGSuMVQ26aDsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317828; c=relaxed/simple;
	bh=YUh9slrTr+SNxFLwIMsCiObfpgORuC7MY3O0OmU/RY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N27N72MKCubvS0M2j0g/1ufzsTmvkQUtyvBowCKlntPhV8H2XpSTmfhR6VPr0YErdMQM0B0K0R4AN8zfZ+3HcfcIiRgqGGdGyFYl2FBjn46+VQVDKswTgvxXW0RULyZTsju1l5vH/8Uq+vVDde1XI1YGeRMWTITvlXq/THdSizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=SUQwTjo1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="SUQwTjo1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d8f265cbe6so4884505ad.0
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788317826; x=1788922626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdt9O9DrbfD0+uxbYBw0LbC/ktAZ2LjIUSYy5m+59wc=;
        b=SUQwTjo17pstsYbVrGFCRco1FobI1pEsgrNLtpwJNOAgqg8g+NNcZeC59gy8EcoGYY
         uKko8JwPBMc3wJQCQTYrWapt30k8nGQqApfiG8nLhuTOCUbbB5xdBE/3CR6abFhoYcwM
         7ZPWlIKF0idpquETWHuMuvCwqg5xFmfX1O3OphpEoj9lA35yY5gj6sEXBUbi55i8KsqG
         0KW/YGPinXFHzX34PI5+OP6u8NK0aMaECIciraA2i5K9N9C+XFqWusArwxak5GFm6S2J
         ZNDQRfHIdW4r4tkZMoav70GHwZtS2qbdjm2n6/rzwAH6J5DasCh5UPl8+EImMByznHx4
         H0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317826; x=1788922626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gdt9O9DrbfD0+uxbYBw0LbC/ktAZ2LjIUSYy5m+59wc=;
        b=mTdkTuYr9gnmtMe0tj5HfoVYhGxTQe8OWqDBu7Hmo3frOiSrYi3ge1HIqpQZDpwUAB
         mb2TSlnyUjZHt/e/Wr1ibCK1BneFnio1LCAqB4+1sTIYF9YTeLve6WpeB2YZvbRZyqbo
         aDjNra/eU3kmQcPRpTDNvBeS6NQnxRCddvBY1Ou0U5beTwrfnGbsEfhus4LeEuN5ddo7
         BzQ8hGw7Cwivkp8xwpBo3tv9pENlgxu+pdUCXjOiBcoVDYRlViKctPVUP/q1Qk1t8zZJ
         xxkrbyK34DyqK6YnTFX9zZ+1TJXrjsxYgaVj/cXJsA/C17+tuKZ13rhJlfkv4v4jmnGy
         J7Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxfPZWAiSCmZLWxoLklzNHC1sjrbGWhPrRu2sbPPknCm/Pa4JS5JPfGlAZdgTX10i+L/jjXRw==@lists.linux.dev
X-Gm-Message-State: AFuF++moW7KCU6HN0Z4+Uq6OEqlpNg9VIkh/JHU7SL92Q50CoP8NRkc4
	LLnmndxu5kAVDJvZ02kfNX0fJoXkEsC9ogSMD18Lvp5QRdbsPtmpu99MzBzPEURruHE=
X-Gm-Gg: AYBFou1zLXtAy4SWfTs+D0SitVJ+8aZBdHZNaAp0Qu/nWQkGaZjBxHKOhrqjx8qaQ2A
	fFW4IZ+dLWfYF4KlFxbUfMggtjnq6zDX8Qk9ENd9WbJ1X5uxwOL7d2IOjO0jBzEV/5sGpFmSIsX
	JLzp9siKVLFnAHoCAV6VXaKu62vr7FByCDOAjQBhvuXfYlKjwfC9EEjqLQ7jpYkIg9RMJTpoDK3
	W0heNX7EWmKD2GtH1x7OBPH66eQAd9JmymKmUQ3SK/vCKZ7w4ly3U6ZNEIO0edGzFxZQtmy++Iq
	gMLWkafAmrPpK5i2CYDmbcQ5UHRz2HG5R4wyIh8zWRKoKLFsn//cJsLZGjU/3W5fmud9CzhsU/y
	trq9km1zLvdCX1Et1zK6S1U2JH/dsRoF/r8kPIjMWnxtMR0PPS0plq+au7oYsQLp0XhoD9AZLJU
	a7zV0ReVfVZZ4RG+X/XGVhJ74RYR2CXyqye1UEwMiGRYnmia/l8dt8wi90TTG4G7fVRYyRP/tNF
	gMSt7X8OGbyXBUafS7X9pOT/RSWC108FRxR
X-Received: by 2002:a17:90b:52c8:b0:398:9be9:ab8f with SMTP id 98e67ed59e1d1-39aee125891mr2168853a91.20.1788317826404;
        Tue, 01 Sep 2026 19:57:06 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:a1c2:77c:7ab7:f9a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07bde5bfsm2066469eec.27.2026.09.01.19.57.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 19:57:06 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm/damon/paddr: support hugetlb folios in access monitoring
Date: Tue,  1 Sep 2026 19:57:00 -0700
Message-ID: <20260902025700.17975-4-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902025700.17975-1-kiyer@crusoe.ai>
References: <20260902025700.17975-1-kiyer@crusoe.ai>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's physical address space monitoring is blind to hugetlb-backed
memory.  Every access check starts at damon_get_folio(), which rejects
folios that are not on the LRU lists.  Hugetlb folios are managed
outside of the LRU by design, so every sampling attempt on
hugetlb-backed memory silently fails and the pages are reported as
never accessed.

This is a significant blind spot on virtualization hosts.  Cloud
hypervisor hosts commonly back guest memory with 1 GiB hugetlbfs pages,
covering the vast majority of the machine's memory.  On such hosts,
modules like DAMON_STAT observe only the host-side remainder (page
cache, daemons) and report all guest working sets as permanently
idle, defeating the purpose of host-level access monitoring.  In
testing on a 1 TiB host, an hour of 4-thread random access over 842 GiB
inside a guest was statistically indistinguishable from an idle host,
while a 40x smaller host-side workload produced a quantitatively
correct response.

Add damon_get_monitor_folio(), which additionally accepts hugetlb
folios, and use it in the two paddr access monitoring primitives,
damon_pa_mkold() and damon_pa_young().  With the previous commit
teaching the folio-granular rmap walkers to age huge PTEs and to call
the mmu notifiers spanning the whole huge page, this makes guest
accesses visible through secondary MMU (e.g. KVM/EPT) young bits.

Free hugetlb pool folios have a zero refcount, so folio_try_get()
naturally keeps rejecting them.

The DAMOS action appliers (damon_pa_pageout(),
damon_pa_mark_accessed_or_deactivate(), damon_pa_migrate(),
damon_pa_stat()) keep using damon_get_folio(): reclaim, LRU
manipulation and migration cannot act on hugetlb folios, so their
behavior is unchanged.

Note that the access check granularity for hugetlb-backed memory is the
huge page size: one touched byte reports the whole (up to 1 GiB) page
as accessed.  Also, DAMON now consumes secondary MMU young bits that
KVM's own aging uses; at DAMON's sampling rate (one page per region per
sampling interval) the interference is negligible.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/ops-common.c | 31 +++++++++++++++++++++++++++----
 mm/damon/ops-common.h |  1 +
 mm/damon/paddr.c      |  4 ++--
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 373b25db5950..80207b56c6fd 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -15,14 +15,20 @@
 #include "../internal.h"
 #include "ops-common.h"
 
+static bool damon_folio_acceptable(struct folio *folio, bool monitor)
+{
+	return folio_test_lru(folio) ||
+		(monitor && folio_test_hugetlb(folio));
+}
+
 /*
- * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
- * NULL.
+ * Get an online page for a pfn if it's in the LRU list, or a hugetlb folio if
+ * @monitor is set.  Otherwise, returns NULL.
  *
  * The body of this function is stolen from the 'page_idle_get_folio()'.  We
  * steal rather than reuse it because the code is quite simple.
  */
-struct folio *damon_get_folio(unsigned long pfn)
+static struct folio *__damon_get_folio(unsigned long pfn, bool monitor)
 {
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
@@ -33,13 +39,30 @@ struct folio *damon_get_folio(unsigned long pfn)
 	folio = page_folio(page);
 	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
+	if (unlikely(page_folio(page) != folio) ||
+			!damon_folio_acceptable(folio, monitor)) {
 		folio_put(folio);
 		folio = NULL;
 	}
 	return folio;
 }
 
+struct folio *damon_get_folio(unsigned long pfn)
+{
+	return __damon_get_folio(pfn, false);
+}
+
+/*
+ * Same to damon_get_folio(), but also accepts hugetlb folios, which are
+ * managed outside of the LRU lists.  Aimed to be used by access monitoring
+ * primitives.  DAMOS actions that assume LRU-managed folios should keep using
+ * damon_get_folio().
+ */
+struct folio *damon_get_monitor_folio(unsigned long pfn)
+{
+	return __damon_get_folio(pfn, true);
+}
+
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
 	pte_t pteval = ptep_get(pte);
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index f7811c9c7a02..172f0f17c4a8 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -6,6 +6,7 @@
 #include <linux/damon.h>
 
 struct folio *damon_get_folio(unsigned long pfn);
+struct folio *damon_get_monitor_folio(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0..ed7b7f31291a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -37,7 +37,7 @@ static unsigned long damon_pa_core_addr(
 
 static void damon_pa_mkold(phys_addr_t paddr)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
 
 	if (!folio)
 		return;
@@ -67,7 +67,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 static bool damon_pa_young(phys_addr_t paddr)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
 	bool accessed;
 
 	if (!folio)
-- 
2.54.0

