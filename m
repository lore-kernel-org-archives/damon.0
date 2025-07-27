Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9F23C51D;
	Sun, 27 Jul 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647505; cv=none; b=sGIxeFKCWlZzu3VJQVpPaHlt19X4mWmwKeu+D23Wa56pqX5T4WnHpNU1H9iEBLw9Pnjebys9MumOiBY44FBlDv0cSWRKd1FBMavbAc3O7/187u/uBJpx2tNWPUbW7CxCKHkWSuUP/6XicdhJK8Hw1k/0sjqjidma5nit7v/ApIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647505; c=relaxed/simple;
	bh=7vfSMEb8duHJazLWTg6Sxiv7QWIEANLC0eGbGwST1R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1riQz9OdyiI4lnlf8mR7drI0Fha0PEv2rW5PY4jDEeGADo4pl/OFtRBNejrU8wN+ohxG1xrUB946kYwcLUbSf01X5BU78UgthMKGzXK094wQlclJ9e2OYKPE158+j5uYyUFA3EkHlL26Ym42dIPRX5jqEOw68OesP81JBALQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT6BXn3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT6BXn3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825EFC4CEEF;
	Sun, 27 Jul 2025 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647504;
	bh=7vfSMEb8duHJazLWTg6Sxiv7QWIEANLC0eGbGwST1R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT6BXn3T2PxJzZMoAqtXevwqwvD0Gyq31K8qSyDJpYsJ/9k045auIsH81m+Pq3I0T
	 mGDqfFVI8xSzlY1lokpeUO5BQNWc9vO+D1ePRLAw+YRQMZS+Gryv0WDUhsMLM1ZXJ1
	 Fj3/cF6XKn2aVnVameShRV0FG8QojWhHIWn93EWjpmBcWs0w+ndHpcsainsJsai+OS
	 306+GMjumFB/NtmIfSt2NL6fWtMaus7wszDlQeCzUc20CXMiufGzwpF+4GcO/ZSCX6
	 hQ7VvcqfHOg3+VaL1C/J4QiEgG+P3EKoB/OMPNQyST4hu3eK0US4L1lEi/9aJ7BoR/
	 tTmaJkiTB9ugg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 6/7] mm/damon: implement paddr_fault operations set
Date: Sun, 27 Jul 2025 13:18:12 -0700
Message-Id: <20250727201813.53858-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement an example damon_report_access() based DAMON operations set,
paddr_fault.  It monitors the physical address space accesses, same to
paddr.  Only one difference is that it uses page faults as its access
information source, using damon_report_access() and MM_CP_DAMON based
mechanisms.

This is not to be merged into the mainline as-is, but only for giving an
example of how damon_report_access() based operation sets can be
implemented and extended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  3 ++
 mm/damon/paddr.c      | 77 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8ec49beac573..c35ed89371d0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -574,12 +574,15 @@ struct damos {
  * @DAMON_OPS_FVADDR:	Monitoring operations for only fixed ranges of virtual
  *			address spaces
  * @DAMON_OPS_PADDR:	Monitoring operations for the physical address space
+ * @DAMON_OPS_PADDR_FULAT:	Monitoring operations for the physical address
+ *				space, using page faults as the source
  * @NR_DAMON_OPS:	Number of monitoring operations implementations
  */
 enum damon_ops_id {
 	DAMON_OPS_VADDR,
 	DAMON_OPS_FVADDR,
 	DAMON_OPS_PADDR,
+	DAMON_OPS_PADDR_FAULT,
 	NR_DAMON_OPS,
 };
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..68c309ad1aa4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -14,6 +14,7 @@
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
 #include <linux/mm_inline.h>
+#include <asm/tlb.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -97,6 +98,65 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damon_pa_fault_change_protection_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
+{
+	/* todo: batch or remove tlb flushing */
+	struct mmu_gather tlb;
+
+	if (!vma_is_accessible(vma))
+		return true;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+
+	change_protection(&tlb, vma, addr, addr + PAGE_SIZE, MM_CP_DAMON);
+
+	tlb_finish_mmu(&tlb);
+	return true;
+}
+
+static void damon_pa_fault_change_protection(unsigned long paddr)
+{
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct rmap_walk_control rwc = {
+		.rmap_one = damon_pa_fault_change_protection_one,
+		.anon_lock = folio_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!folio)
+		return;
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
+		return;
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return;
+
+	rmap_walk(folio, &rwc);
+
+	if (need_lock)
+		folio_unlock(folio);
+}
+
+static void __damon_pa_fault_prepare_access_check(struct damon_region *r)
+{
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+
+	damon_pa_fault_change_protection(r->sampling_addr);
+}
+
+static void damon_pa_fault_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			__damon_pa_fault_prepare_access_check(r);
+	}
+}
+
 /*
  * damos_pa_filter_out - Return true if the page should be filtered out.
  */
@@ -355,8 +415,23 @@ static int __init damon_pa_initcall(void)
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
 	};
+	struct damon_operations fault_ops = {
+		.id = DAMON_OPS_PADDR_FAULT,
+		.init = NULL,
+		.update = NULL,
+		.prepare_access_checks = damon_pa_fault_prepare_access_checks,
+		.check_accesses = NULL,
+		.target_valid = NULL,
+		.cleanup = NULL,
+		.apply_scheme = damon_pa_apply_scheme,
+		.get_scheme_score = damon_pa_scheme_score,
+	};
+	int err;
 
-	return damon_register_ops(&ops);
+	err = damon_register_ops(&ops);
+	if (err)
+		return err;
+	return damon_register_ops(&fault_ops);
 };
 
 subsys_initcall(damon_pa_initcall);
-- 
2.39.5
