Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F131A554;
	Mon,  8 Dec 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175398; cv=none; b=bV/zLuT3JkSphXncvDUPh/5VjPCAoP60BZ9xKqJZ+YOBj7rEjVI66QZTBHcQIcmLNNm14o0K+mgZe+RXld+yl8xPSvccC6d8hVqi8x6kzhgdt8P52Fo1KVgs1zH5c8wjDhpEX7KZ0Mn2fvFI+I5xffRYogdfsmbi4Me8mlZ8sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175398; c=relaxed/simple;
	bh=FU7PUMIztU6bHn9o0PvCgnBq3cHVYIdbgyjQa5N1taw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqqLyyqmVMa04u32AKqn2KvrpfdATK7qzZzXQZkhdUZigFwa8bJrLu3D0M/3ZaJM6LKEDoKTUmdJIFdOYJ5i1fYtIPKNES1PrlX/MSqODYeYRJqWuNyG5M54SM7C57A8IUGKIJUR6Ex21LJ0VEzjKzW6l/6QrQZ0irs1SVn9qDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChdeafpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChdeafpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52020C4CEF1;
	Mon,  8 Dec 2025 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175398;
	bh=FU7PUMIztU6bHn9o0PvCgnBq3cHVYIdbgyjQa5N1taw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChdeafpH4rH6YL3o1OKRhEuJQnPqQu9MWx0FDHaiJjG2zbJafy/3MUasBBnoQ6ERw
	 8+RMDYPSMQ+pQtclPsOp/r6aNzokcl/inkk19+vYiY8FJ7pA58bWrpi14lANsZukl7
	 v0z7oACIteOEGOzdjcln69EjPOT1UAQIgQ3UbdJWpvjhLq2yZZORheMgWQQGXMNk8L
	 XuziggKbS2BuzHsZ8rl1O+5R28lNck8cQjOZFnftcgl0/ReiHNbauEqMjxBxb1zJbD
	 3Bcuc20nOgtGmJ68jLXrUEyi4yXMNKphfR5Ol8MsHs6c10Qp8xuwzX4+emNNQx3RfG
	 gIuiMu3ys40mQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 06/37] mm/damon/paddr: support page fault access check primitive
Date: Sun,  7 Dec 2025 22:29:10 -0800
Message-ID: <20251208062943.68824-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON operation set for the physical address space (paddr) to
support page fault access check primitive.  When DAMON core layer asks
it to use page fault events as its access check primitive, paddr will
install PROT_NONE protection to access sampling target pages, in a way
similar to NUMA_HINT_FAULTS, using the non-upstreamable hack that was
added by the previous commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 07a8aead439e..698ca6b9dde6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -14,6 +14,7 @@
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
 #include <linux/mm_inline.h>
+#include <asm/tlb.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -56,7 +57,8 @@ static void __damon_pa_prepare_access_check(struct damon_region *r,
 	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
 }
 
-static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+/* Use page table accessed bits */
+static void damon_pa_prepare_access_checks_abit(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -67,6 +69,68 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
+static bool damon_pa_change_protection_one(struct folio *folio,
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
+static void damon_pa_change_protection(unsigned long paddr)
+{
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	struct rmap_walk_control rwc = {
+		.rmap_one = damon_pa_change_protection_one,
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
+static void damon_pa_prepare_access_checks_faults(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+			damon_pa_change_protection(r->sampling_addr);
+		}
+	}
+}
+
+static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+{
+	if (ctx->sample_control.primitives_enabled.page_table)
+		damon_pa_prepare_access_checks_abit(ctx);
+	if (ctx->sample_control.primitives_enabled.page_fault)
+		damon_pa_prepare_access_checks_faults(ctx);
+}
+
 static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
-- 
2.47.3
