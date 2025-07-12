Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4729DB8F;
	Sat, 12 Jul 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349836; cv=none; b=jdQSKdbvc21Qz/RTIUw5H1rv5rSV9faIkfA724MPiJhm75FXhgLlsyHVZ+Bqa3iqCI6tz7xrus7O4VQFa0QtqPBz2T1BN49id9qjmxtRB0irvF6fDicunhbLUYrsSN0mgg15bg+YyEVyALrBuDeNMG9Jv0J8amokYT4grTgYp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349836; c=relaxed/simple;
	bh=N6UgM+GaU7C25cINsCnFK+jRBTnhXf4uYeOYOmlqYds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBQQplNgTYcJmFWyC7NlO9HzyzMHvhuazUanGkT6t2ZshltuD4PtWpETaLTNg5B2ltruqmf+u+8KLRdYQWq9KqitNXTJ/+KwaGfejhmuWhdjpf/eUTZ002usjcM7TD7o9j1hscOoLB2QvT0CV3E4MJmhD3CV/zs3QQkQjl5Hk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI3qg08J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI3qg08J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA8C4CEF1;
	Sat, 12 Jul 2025 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349836;
	bh=N6UgM+GaU7C25cINsCnFK+jRBTnhXf4uYeOYOmlqYds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jI3qg08JH6ttnI0W7A3bfseSky7pZofrGzwYc23N1TYIhYlE50n3BH3z0aleDvYIL
	 kVvS56Apd0e1nEiBhzPjcLz5g2vQPEdiIBivrjAU61AAWaPDBgbQt6iivdKxQvQAS3
	 agMj7LmG+f+kKCQPh9IgGiWrBdpHy1Izu248+N8QXR+7eV4FQb2ALB3fVlKTeZtHuy
	 7zbGBW5g82RZtaTtfczGkMs6L2ReRL5a94IIJWpjna/XZtPBBbMcV3KcFIcZfuNlGM
	 d9K3EPVqvl6T0H2/DqgmKTg36JYgkcgOPSi3RtxuXyIEi55drBeAYkhpsV6m/TYFrL
	 2bGhRqQG30ZsA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/14] mm/damon/core: remove damon_callback
Date: Sat, 12 Jul 2025 12:50:16 -0700
Message-Id: <20250712195016.151108-15-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195016.151108-1-sj@kernel.org>
References: <20250712195016.151108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All damon_callback usages are replicated by damon_call() and
damos_walk().  Time to say goodbye.  Remove damon_callback.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 31 +------------------------------
 mm/damon/core.c       | 26 +++++++-------------------
 2 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 27305d39f600..34fc5407f98e 100644
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
index ffd1a061c2cb..f3ec3bd736ec 100644
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
@@ -1177,7 +1175,7 @@ static int damon_commit_targets(
  * in-place updates.
  *
  * This function should be called from parameters-update safe context, like
- * DAMON callbacks.
+ * damon_call().
  */
 int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
@@ -2484,9 +2482,6 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 
 		kdamond_usleep(min_wait_time);
 
-		if (ctx->callback.after_wmarks_check &&
-				ctx->callback.after_wmarks_check(ctx))
-			break;
 		kdamond_call(ctx, false);
 		damos_walk_cancel(ctx);
 	}
@@ -2543,10 +2538,9 @@ static int kdamond_fn(void *data)
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
@@ -2564,14 +2558,10 @@ static int kdamond_fn(void *data)
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
@@ -2637,8 +2627,6 @@ static int kdamond_fn(void *data)
 			damon_destroy_region(r, t);
 	}
 
-	if (ctx->callback.before_terminate)
-		ctx->callback.before_terminate(ctx);
 	if (ctx->ops.cleanup)
 		ctx->ops.cleanup(ctx);
 	kfree(ctx->regions_score_histogram);
-- 
2.39.5
