Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A53E63B9
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947040; cv=none; b=rrfnIzgDBbadTdODJf3ZVz9puJUnp9+fW3dekqbh/KwN/1+2DAEhGbcYfZS5GU/D/IBF6x/gk8cuqhkxf/1KWcp7NfcITVZwb2nM5IwPSKT2NJQqdEJY94axTklg1roz+Lo7/AcfpcFH7b1g9a2GM+MWABzfw9msLDosHmxhnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947040; c=relaxed/simple;
	bh=09VA4F8253MU/4y7yANN5k7XYmZmAUzCSvvnMw2grNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geGK5Qua0a9rGFk+UYkb2fXDuXQZwf/SHtnSNrpVRI1hWkhJf4VhzhThPShKREHZB5vzwWvMe/q0usSHluZvyl00N3E+QSqgccdAP1mZzZFcvSzsN1eQt/0hYq2CnUM1cqeF9GMV7Y01ZQOP2vIjjnUtj6awxwzkiFO+bf4R6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJQehRic; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJQehRic"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776947035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9HHheyubYHNtwYDlBDwk1vL1ZesRzJTzCNuH8uQVt7c=;
	b=vJQehRicMhgAhQdXdxNyu6owWRyeyTuDctl2aSxFB4G9d11PJViHkFBimbloLLQnnxQe8i
	s8WLRRqLrQJn2ZGAsZ5GSC56yXRfsag5L64IulT/5GMR0VCe8MnRtj4XNyU/uLZ6/V4OLK
	YNfNgrstc7I4cFiiB0sTY49a0e+z/dM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon: introduce damon_rand_fast() for per-ctx PRNG
Date: Thu, 23 Apr 2026 20:23:36 +0800
Message-ID: <20260423122340.138880-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

damon_rand() on the sampling_addr hot path calls get_random_u32_below(),
which takes a local_lock_irqsave() around a per-CPU batched entropy pool
and periodically refills it with ChaCha20.  On workloads with large
nr_regions (20k+), this shows up as a large fraction of kdamond CPU
time: the lock_acquire / local_lock pair plus __get_random_u32_below()
dominate perf profiles.

Introduce damon_rand_fast(), which uses a lockless lfsr113 generator
(struct rnd_state) held per damon_ctx and seeded from get_random_u64()
in damon_new_ctx().  kdamond is the sole consumer of a given ctx, so no
synchronization is required.  Range mapping uses Lemire's
(u64)rnd * span >> 32 to avoid a 64-bit division; residual bias is
bounded by span / 2^32, negligible for statistical sampling.

The new helper is intended for the sampling-address hot path only.
damon_rand() is kept for call sites that run outside the kdamond loop
and/or have no ctx available (damon_split_regions_of(), kunit tests).

Convert the two hot callers:

  - __damon_pa_prepare_access_check()
  - __damon_va_prepare_access_check()

lfsr113 is a linear PRNG and MUST NOT be used for anything
security-sensitive.  DAMON's sampling_addr is not exposed to userspace
and is only consumed as a probe point for PTE accessed-bit sampling, so
a non-cryptographic PRNG is appropriate here.

Tested with paddr monitoring and max_nr_regions=20000: kdamond CPU
usage reduced from ~72% to ~50% of one core.

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 include/linux/damon.h | 28 ++++++++++++++++++++++++++++
 mm/damon/core.c       |  2 ++
 mm/damon/paddr.c      | 10 +++++-----
 mm/damon/vaddr.c      |  9 +++++----
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6..0afdc08119c8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -10,6 +10,7 @@
 
 #include <linux/memcontrol.h>
 #include <linux/mutex.h>
+#include <linux/prandom.h>
 #include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/random.h>
@@ -843,8 +844,35 @@ struct damon_ctx {
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
+
+	/*
+	 * Per-ctx lockless PRNG state for damon_rand_fast(). Seeded from
+	 * get_random_u64() in damon_new_ctx(). Owned exclusively by the
+	 * kdamond thread of this ctx, so no locking is required.
+	 */
+	struct rnd_state rnd_state;
 };
 
+/*
+ * damon_rand_fast - per-ctx PRNG variant of damon_rand() for hot paths.
+ *
+ * Uses the lockless lfsr113 state kept in @ctx->rnd_state. Safe because
+ * kdamond is the single consumer of a given ctx, so no synchronization
+ * is required. Quality is sufficient for statistical sampling; do NOT
+ * use for any security-sensitive randomness.
+ *
+ * Range mapping uses Lemire's (u64)rnd * span >> 32 to avoid a division;
+ * bias is bounded by span / 2^32, negligible for DAMON.
+ */
+static inline unsigned long damon_rand_fast(struct damon_ctx *ctx,
+					    unsigned long l, unsigned long r)
+{
+	u32 rnd = prandom_u32_state(&ctx->rnd_state);
+	u32 span = (u32)(r - l);
+
+	return l + (unsigned long)(((u64)rnd * span) >> 32);
+}
+
 static inline struct damon_region *damon_next_region(struct damon_region *r)
 {
 	return container_of(r->list.next, struct damon_region, list);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff71..c3779c674601 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -607,6 +607,8 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
+	prandom_seed_state(&ctx->rnd_state, get_random_u64());
+
 	return ctx;
 }
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5cdcc5037cbc..b5e1197f2ba2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -48,12 +48,12 @@ static void damon_pa_mkold(phys_addr_t paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_region *r,
-		unsigned long addr_unit)
+static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
+					    struct damon_region *r)
 {
-	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+	r->sampling_addr = damon_rand_fast(ctx, r->ar.start, r->ar.end);
 
-	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
+	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, ctx->addr_unit));
 }
 
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
@@ -63,7 +63,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(r, ctx->addr_unit);
+			__damon_pa_prepare_access_check(ctx, r);
 	}
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b069dbc7e3d2..6cf06ffdf880 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -332,10 +332,11 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
  * Functions for the access checking of the regions
  */
 
-static void __damon_va_prepare_access_check(struct mm_struct *mm,
-					struct damon_region *r)
+static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
+					    struct mm_struct *mm,
+					    struct damon_region *r)
 {
-	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+	r->sampling_addr = damon_rand_fast(ctx, r->ar.start, r->ar.end);
 
 	damon_va_mkold(mm, r->sampling_addr);
 }
@@ -351,7 +352,7 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			__damon_va_prepare_access_check(mm, r);
+			__damon_va_prepare_access_check(ctx, mm, r);
 		mmput(mm);
 	}
 }
-- 
2.43.0

