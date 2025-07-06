Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45C2C08C5;
	Sun,  6 Jul 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832040; cv=none; b=huJkqEryuTjHIwxs5UHbElHVWoH594NIslkNBZSHMI8tpZ8dQq9rOzKGrcUaY5/aO2BDUvPmaabZnw1msKCaGM3m25zQHQOCD3N5Iy6U8xH+7zuPzKqCBhMH3NAhyQPXEuk62LCOQtN1T7yB0rQiDiMqdQSGgsWLijB2DP7DAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832040; c=relaxed/simple;
	bh=UY8idiDxx1z6VY897USN60G0+UWHNTZfcQ9JenDI6ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koX5fa+Kma7pfBtz5yGEKdq6MCG01rFMSZ2V9CUY81OGIW5lofpyCTBCe6M4wnkczWWlQkSCWo/w6iDxWxns2scoaTTbNi6KxxumGqOfnVxwueb1m3DV76mDKBcq7Eqp7zsQCjCQaTcLqcVlatKVP0mZ4MsPbfAM0f4Ubk13z9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUKnQNA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUKnQNA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4271C4CEED;
	Sun,  6 Jul 2025 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832040;
	bh=UY8idiDxx1z6VY897USN60G0+UWHNTZfcQ9JenDI6ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUKnQNA15EstRNmSOh/lfXnqionSWBjs/fTP4t7hUoev5c8hq4F8mFMi7xh5Ieopx
	 RQCOssCOkluQz/JD3vSkmQRnjIzettO5FOhFk7ojmODcJ243GO6R7kf0B1l6IgUGjs
	 FkVVJnhAPAt9n5LhRjaeiMDFQ20wHC8odD4p/pAAT+8qKCKqB7n9GAoEQoNhuVpYYz
	 g/rFh/3XJ8ftoGa4gB/nmmyD1Bp1uST+0vOWYzsLl6txc2eXxsx92z+5FKf6b1cdsv
	 kIoFJD6l7LyFzWuLy3j+8PjVOA1d6HpLDi8TJO6JFXz/uo/QNS3zThRu7SzCZxmk8I
	 hI1L8tqJj9vHw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 14/14] mm/damon/core: remove damon_callback
Date: Sun,  6 Jul 2025 13:00:18 -0700
Message-Id: <20250706200018.42704-15-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All damon_callback usages are replicated by damon_call() and
damos_walk().  Remove damon_callback.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 31 +------------------------------
 mm/damon/core.c       | 26 +++++++-------------------
 2 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 52b307db63de..5e5cabbf8190 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -628,34 +628,6 @@ struct damon_operations {
 	void (*cleanup)(struct damon_ctx *context);
 };
 
-/**
- * struct damon_callback - Monitoring events notification callbacks.
- *
- * @after_wmarks_check:	Called after each schemes' watermarks check.
- * @after_aggregation:	Called after each aggregation.
- * @before_terminate:	Called before terminating the monitoring.
- *
- * The monitoring thread (&damon_ctx.kdamond) calls @before_terminate just
- * before finishing the monitoring.
- *
- * The monitoring thread calls @after_wmarks_check after each DAMON-based
- * operation schemes' watermarks check.  If users need to make changes to the
- * attributes of the monitoring context while it's deactivated due to the
- * watermarks, this is the good place to do.
- *
- * The monitoring thread calls @after_aggregation for each of the aggregation
- * intervals.  Therefore, users can safely access the monitoring results
- * without additional protection.  For the reason, users are recommended to use
- * these callback for the accesses to the results.
- *
- * If any callback returns non-zero, monitoring stops.
- */
-struct damon_callback {
-	int (*after_wmarks_check)(struct damon_ctx *context);
-	int (*after_aggregation)(struct damon_ctx *context);
-	void (*before_terminate)(struct damon_ctx *context);
-};
-
 /*
  * struct damon_call_control - Control damon_call().
  *
@@ -726,7 +698,7 @@ struct damon_intervals_goal {
  * ``mmap()`` calls from the application, in case of virtual memory monitoring)
  * and applies the changes for each @ops_update_interval.  All time intervals
  * are in micro-seconds.  Please refer to &struct damon_operations and &struct
- * damon_callback for more detail.
+ * damon_call_control for more detail.
  */
 struct damon_attrs {
 	unsigned long sample_interval;
@@ -816,7 +788,6 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct damon_operations ops;
-	struct damon_callback callback;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 719373bcfaad..ebf483fc0b76 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -680,9 +680,7 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
  * @attrs:		monitoring attributes
  *
  * This function should be called while the kdamond is not running, an access
- * check results aggregation is not ongoing (e.g., from &struct
- * damon_callback->after_aggregation or &struct
- * damon_callback->after_wmarks_check callbacks), or from damon_call().
+ * check results aggregation is not ongoing (e.g., from damon_call().
  *
  * Every time interval is in micro-seconds.
  *
@@ -778,7 +776,7 @@ static void damos_commit_quota_goal(
  * DAMON contexts, instead of manual in-place updates.
  *
  * This function should be called from parameters-update safe context, like
- * DAMON callbacks.
+ * damon_call().
  */
 int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 {
@@ -1137,7 +1135,7 @@ static int damon_commit_targets(
  * in-place updates.
  *
  * This function should be called from parameters-update safe context, like
- * DAMON callbacks.
+ * damon_call().
  */
 int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
@@ -2444,9 +2442,6 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 
 		kdamond_usleep(min_wait_time);
 
-		if (ctx->callback.after_wmarks_check &&
-				ctx->callback.after_wmarks_check(ctx))
-			break;
 		kdamond_call(ctx, false);
 		damos_walk_cancel(ctx);
 	}
@@ -2503,10 +2498,9 @@ static int kdamond_fn(void *data)
 	while (!kdamond_need_stop(ctx)) {
 		/*
 		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
-		 * be changed from after_wmarks_check() or after_aggregation()
-		 * callbacks.  Read the values here, and use those for this
-		 * iteration.  That is, damon_set_attrs() updated new values
-		 * are respected from next iteration.
+		 * be changed from kdamond_call().  Read the values here, and
+		 * use those for this iteration.  That is, damon_set_attrs()
+		 * updated new values are respected from next iteration.
 		 */
 		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
@@ -2524,14 +2518,10 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
+		if (ctx->passed_sample_intervals >= next_aggregation_sis)
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
-			if (ctx->callback.after_aggregation &&
-					ctx->callback.after_aggregation(ctx))
-				break;
-		}
 
 		/*
 		 * do kdamond_call() and kdamond_apply_schemes() after
@@ -2597,8 +2587,6 @@ static int kdamond_fn(void *data)
 			damon_destroy_region(r, t);
 	}
 
-	if (ctx->callback.before_terminate)
-		ctx->callback.before_terminate(ctx);
 	if (ctx->ops.cleanup)
 		ctx->ops.cleanup(ctx);
 	kfree(ctx->regions_score_histogram);
-- 
2.39.5
