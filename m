Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C323F40D;
	Fri, 10 Jul 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691223; cv=none; b=AWYtJcv++cgEKCYJ321z6fof8+RS0G6++Y1HgYfYGmtaJbOmT6lCIk3eKWihXE8bEYIjG7k6FAokmPHwZf5cqg6BIH0KFe6LvkzssX+IuOE8vionBbAlzsa2dO1wPoWWfpZ2Qkf6pOL9FdjDQHS/1C22vqKZ2hwkXuLK9NUC7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691223; c=relaxed/simple;
	bh=loJgvjnHMY9I45QFwnIM12yvHFixonrQ/4hYyj9yi0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEIZ3va0tb9Dff3NmNzWGcvacWdaH2dGRJ6OfkJfZs5mCcw2uFgoExqyJAQlVGl51dUN+S+LD3fcdOx6ZOBZn7ydyWzR7qOOwL3c1YwzOTme8Oh23ez+LjkbMxcRr6Rkd7nsVw60pZI/PkYzt7/nAPidgNKHVK6Ke0ex0q3ifHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHxRw0gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHxRw0gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D9C1F00A3D;
	Fri, 10 Jul 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691221;
	bh=BHaXMaSFXun98IM1jBEMd0RWTSLzKTXiprMB4wea88g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHxRw0gbEz2oo8IGMbq4HFpYn3QULBg5mOP1bP43qWUDI2fVVLfdMjpi+lCV4g/ph
	 V5F3g2pFhkAp3EwoLJMLJGxGpwXPYXFWm73RN1g3zMN9tmZLo3CI5mx2Yr4Lt2sWg2
	 z0M5wwDydnNkQtByBMGjdbCfuaQpte/h3ba38jYNHmOJZu1dyEI63y1svbm7zYsv8u
	 2n6JznenesYig83C1IedBKRsTzu3ZhJKS40Be4hdalr9vayM3DG5yen7nX0/94sGdX
	 eosUQWPioGHR9mjN8wBfwNn70Cxnc+CW8EQslecLxrv4ZVTL9sgAqKG7xu5tWIEMeT
	 jNTmxajOnKkWQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/19] mm/damon/core: ask apply_probe() to return max probe hits weighted sum
Date: Fri, 10 Jul 2026 06:46:33 -0700
Message-ID: <20260710134651.18084-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
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
