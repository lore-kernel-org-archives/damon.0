Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3943145FE0
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022862; cv=none; b=eo5Ov3YOb2hHrw5wBfxNRjkcD0BMXFAswUEq2DyZ+UtJn4gb/URBp8AuM3CXXMxnMKv4qRTYvclE1nz/q+W7ofd1HPRCNi28KQwXYeNQdW5nck8hZh7lK14GsvO5F949n1SIoiYGHYy17jpF6Azq0nJtCQGLYbJS0fyF9c3xEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022862; c=relaxed/simple;
	bh=2tx63+KdOTObd6zqvCEY/MQ4uDr7hrKI7nGRHNi+LY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZz5GWmhN/Adewk+OEVmXVPSyMUQQoj3Gfqe7LFTaHdd8+HABHhviQVX3Mr0m4saQwq23kbKXbwPjIKevcSn/idXkHOULExwtCH1lPCD8bkNfkitT1LIF2aXsZWm1p4rhBiXuS5qfJm77zb2yxaFqBKLoEIPIVZqNeS/P3JvzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7AvDFBF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7AvDFBF"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e740a09eb00so4418890276.0
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022859; x=1752627659; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcIKbfhzMN50M5LtwAnXxnGE89hsJ21qEPoFUKJgyP0=;
        b=l7AvDFBFsGVh9hLU+N134HACmPnHg10qVj9yyIbgJsz9nXMWBPF6ppXy/Fsa0eFu1d
         nRcwuQlAJoZpqeRTMUQ2+RRA/PoFkiy2Vki2eyhE/ObslGUEcUGsqW1nY4JTWWTgYfkk
         q7meglS4CBCF1lTPc40U+V5k4yAO5iLbuitOGdVJyGQjtzhLyoSoAFt9f4jVi5ycI9KQ
         wlLCZ9ThQrkwzLroySuhLCYyIEkf5FjXUBvagxXGM+goezHXj1i+6fnZ1PNzXISJjxv0
         15TafCIQXD4/yKNkEtzGpbau1OsyvUt+TH1nfZXb9o93f/i086gQwXMV7sKcRWcyKH90
         b9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022859; x=1752627659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcIKbfhzMN50M5LtwAnXxnGE89hsJ21qEPoFUKJgyP0=;
        b=TCwfiGB+BlStvEqs5RsLGaJt//XoZqzMF3BhR1IMQ4Qvn9fw0yYtJXy6kdUhz315oI
         2mxGFupJNjHaaqiKoBW4uQoO5lllffwLY6b8IVuON4yBTH0Y5V0zdPfRw4oe+MlJTmOp
         x8MvhjGpth2FSiGXXqQP39j8eS+cd84S8wn5bBm1BQ4jg5hkHo8NQGxHQldL8wr5RJuQ
         Jb3EmtoqLcRmd9U3sLX5K9DunlwR7iKTfSftI+skaJLwXFY+xxkRMjMoOXKQYQu2V+iq
         YMRfy9ZAxcX1MuRxwZzWRmH/FSYbpc8xHSMzmmqcjone6llp0ZzmkQA77RV9dkdcPEAg
         VgJg==
X-Gm-Message-State: AOJu0Yyo/GUyx6clYhWftw5I1Iz1yZ6boTScet7otunRDjemX7fDp8/v
	B6gjk++88+N+wEO4qN6ZfS6HAMVQZ+z5xjZi8Xsys8z8c+NVDNeddiiTduHHk8sDeOQ=
X-Gm-Gg: ASbGncsQf2+s7Z8QYTEnvZfBr/1Wqsa24Nm2AMcjgrX+03Ur22d4S2e0htDeZBHHMYn
	71cboXzDx5RhieKXPNxwOynYoYVCQd0rDX2RmQ1KoVEym0aw4ApNS6YxeSw7nGoEoBwx4ibJijn
	JHZahfHynu+C1ljj8pLJVCLnznBP66JBQpGTCxigF5HEKR26N5xMtpxAcI8MoHALzptzLpDWj7E
	ineWWdL/Mx7oVTDwvtg6bh+7Fy6xjerGzAEc0x6Nguo9ZI/3NeEueXD39doDjK8gcfOUF8kXfRC
	gisEWiAayAJ28+F1ZsAi3+wlUqfPdCv9cK+RfaKYaUNzOhIFZF5DLfSvUPMwHqCg3cF/J4A658X
	/0/HWVus=
X-Google-Smtp-Source: AGHT+IFYbwWbBORRAOQcUqRSE5nM3ImmXuihNVwFJJ1IgG2vxJBWwJ/OTio7E7L6AtKwcW8L80dpZg==
X-Received: by 2002:a05:6902:2e0b:b0:e84:3657:e50 with SMTP id 3f1490d57ef6-e8b6e0cdb96mr1078235276.3.1752022859283;
        Tue, 08 Jul 2025 18:00:59 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:58 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 09/13] mm/damon/vaddr: Add vaddr versions of migrate_{hot,cold}
Date: Tue,  8 Jul 2025 19:59:39 -0500
Message-ID: <20250709005952.17776-10-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

migrate_{hot,cold} are paddr schemes that are used to migrate hot/cold
data to a specified node. However, these schemes are only available when
doing physical address monitoring. This patch adds an implementation for
them virtual address monitoring as well.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/vaddr.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 46554e49a478..b244ac056416 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -15,6 +15,7 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 
+#include "../internal.h"
 #include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
@@ -610,6 +611,68 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct list_head *migration_list = walk->private;
+	struct folio *folio;
+	spinlock_t *ptl;
+	pmd_t pmde;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
+		goto unlock;
+
+	/* Tell page walk code to not split the PMD */
+	walk->action = ACTION_CONTINUE;
+
+	folio = damon_get_folio(pmd_pfn(pmde));
+	if (!folio)
+		goto unlock;
+
+	if (!folio_isolate_lru(folio))
+		goto put_folio;
+
+	list_add(&folio->lru, migration_list);
+
+put_folio:
+	folio_put(folio);
+unlock:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damos_va_migrate_pmd_entry NULL
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct list_head *migration_list = walk->private;
+	struct folio *folio;
+	pte_t ptent;
+
+	ptent = ptep_get(pte);
+	if (pte_none(ptent) || !pte_present(ptent))
+		return 0;
+
+	folio = damon_get_folio(pte_pfn(ptent));
+	if (!folio)
+		return 0;
+
+	if (!folio_isolate_lru(folio))
+		goto out;
+
+	list_add(&folio->lru, migration_list);
+
+out:
+	folio_put(folio);
+	return 0;
+}
+
 /*
  * Functions for the target validity check and cleanup
  */
@@ -653,6 +716,34 @@ static unsigned long damos_madvise(struct damon_target *target,
 }
 #endif	/* CONFIG_ADVISE_SYSCALLS */
 
+static unsigned long damos_va_migrate(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	LIST_HEAD(folio_list);
+	struct mm_struct *mm;
+	unsigned long applied = 0;
+	struct mm_walk_ops walk_ops = {
+		.pmd_entry = damos_va_migrate_pmd_entry,
+		.pte_entry = damos_va_migrate_pte_entry,
+		.walk_lock = PGWALK_RDLOCK,
+	};
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &folio_list);
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	applied = damon_migrate_pages(&folio_list, s->target_nid);
+	cond_resched();
+
+	return applied * PAGE_SIZE;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -675,6 +766,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_MIGRATE_HOT:
+	case DAMOS_MIGRATE_COLD:
+		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return 0;
 	default:
@@ -695,6 +789,10 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_HOT:
+		return damon_hot_score(context, r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
-- 
2.43.0

