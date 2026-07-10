Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294701A9FBA;
	Fri, 10 Jul 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643041; cv=none; b=clJggrZXQRMM9nQ6giTBCJTzj07aFrHKuI2p9KMhwXXzr1e7+dRWDVLAkI3dbHuTRpy3YTeBLx3Hmr6v9zPsNvcuqzrceIHb1+kel0gp+/uBbe8gpZNfVNKFFlEX4BgeQSxUl9kxrTzRkXyPCw+Lq1JzHp/NSaRThGVaIBwWjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643041; c=relaxed/simple;
	bh=loJgvjnHMY9I45QFwnIM12yvHFixonrQ/4hYyj9yi0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXH+IdrMdmmJHvSF/epdEHeT4Iqn4QdOG/KQcKIt+3/j4wpHjvJhyHYklZVQTIM61hF7rLAD7/2wX1b44cEdbnhww2Pe2CV2ysTyXre8OF4R5DoRGtjOuv/gxkLsmSeEh+Lxp8w2KHnJXxiuNTl/dz/ZidyM4dWhQ8/j98rnwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlPeBOmP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlPeBOmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE891F00A3D;
	Fri, 10 Jul 2026 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643040;
	bh=BHaXMaSFXun98IM1jBEMd0RWTSLzKTXiprMB4wea88g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZlPeBOmP7VrmWxAsPH0AVL/fTuec/ABwje3Atq55LH8/QOgdA9eHYpQUneA1dDIEy
	 Vqh036et1+wffuKOl7wjVzEVUbB1kVEJBjLwH19R/V0gsXEygKsfUyldVSihx5iyE1
	 pdb8DnxelviLdiQ5lWnDPzwtrqtyzN2YKVcJXmZ6faFa/dd6fAyWQvcjxRUNDtOZZd
	 ME2O3Tabm3VCKJW6K7ASPJrTFFUcMGlBDqlzNbC3P3qE3fHrnUtt4g9xyH8L/Yn0s6
	 z6aI+/BcFgHc3Y+3pi/yPm5GgaYT+auyxcHxYW5UCqKXjKgqHj/g1R4iH6Zu6cp+sd
	 TeukYMSVTUOfg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 04/19] mm/damon/core: ask apply_probe() to return max probe hits weighted sum
Date: Thu,  9 Jul 2026 17:23:30 -0700
Message-ID: <20260710002349.111414-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_accesses() DAMON ops callback returns the maximum nr_accesses of
regions.  DAMON core uses it to calculate a reasonable region merge
threshold.  The core will need to adjust regions for not nr_accesses but
probe hits weighted sum in future.  For that, the core needs to know the
maximum weighted sum of the regions.  Update the protocol for the task.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 ++++-
 mm/damon/core.c       | 2 +-
 mm/damon/paddr.c      | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index aee28b05acc6c..e7acd8e610a64 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -649,6 +649,8 @@ enum damon_ops_id {
  * @apply_probes should apply the data attribute probes to each region and
  * accordingly update the probe hits counter of the region.  It should also
  * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
+ * It should also return maximum probe hits weighted sum of regions if
+ * ``return_max_wsum`` is true.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -666,7 +668,8 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
-	void (*apply_probes)(struct damon_ctx *context, bool set_samples);
+	unsigned int (*apply_probes)(struct damon_ctx *context,
+			bool set_samples, bool return_max_wsum);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9fbea6204520b..9f6cdd810bd8a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3692,7 +3692,7 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, false);
+			ctx->ops.apply_probes(ctx, false, false);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index ff4fcca949660..3eba3564a31fc 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -166,7 +166,8 @@ static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
 	return pass;
 }
 
-static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
+static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
+		bool set_samples, bool return_max_wsum)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -194,6 +195,7 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
 				folio_put(folio);
 		}
 	}
+	return 0;
 }
 
 /*
-- 
2.47.3
