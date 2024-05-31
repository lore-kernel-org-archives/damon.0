Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F0158847
	for <damon@lists.linux.dev>; Fri, 31 May 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158321; cv=none; b=Z4I1nJxT25Pb/x0QBf2Epi49vLMmmEnDdduFWB3H9uzeNzLMlBUcwtioDlS7QUnGWxxgVLuPxUkPE0OrpnvuiNpW82tYYY4ekS2BQ7i9s5m4uniOFC/oAExKpTQ/ZgW4M3KdDefhllusD6NTIprPaHhb8je+/eddK0Spkx6u7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158321; c=relaxed/simple;
	bh=Kuqbau0xoMhN2XqRd8u2oTAfdJWjYmeaVGcId0c3pnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM/xd4c06j842BEGr5YKGyVgU88P4cqh1JET3Bn2PVynC9KibyUHDwch3+4AgaIELwR7fDJd8b/iHVTLhYeL+X5h81MkcQ4Zyxe79L5q1sRAEJb19EG/eTh9q/UUmZ7LW5FO59AHF4XPGhXrJ+OQ06eEuqIw4g7/BfdPcVzCFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE/tA76K; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE/tA76K"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b7b4812f3so1859735e87.0
        for <damon@lists.linux.dev>; Fri, 31 May 2024 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158316; x=1717763116; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HttxiipCFC0fTtaO1SHHV2ZPZYCvUJPTS0rjpUsYeog=;
        b=CE/tA76KbLqNVulZymJ30c1LePkAGI20v1COFYtyxqA9o+I+EYI3ixNiSxjp/daEEJ
         uzJ2eCi+Fid3a3HBrjGgGBVHdQkXIoVT1gm9s2nlVpLAGfgUJgvCOaFg4jBS+GER6xSW
         UVLzkpIzZmFaQWE01m7C1cRpG+wWKVZg8nZUlmq4Q5jcItgfr4puozbAv7EhBguT7DEn
         tUgy/2yF60w3wo5qqVsmAW69mmuS9JazdbuRnbSZMc8aiGt7BdEEOA0JS1OKGMQ0Z6ST
         92+yDH7K2k/VX/vlarcTR0Anaf5TU2p7KGgd7BtmH5kNMnb4qFlG6ZgcZVxDYUH/21zh
         euTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158316; x=1717763116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HttxiipCFC0fTtaO1SHHV2ZPZYCvUJPTS0rjpUsYeog=;
        b=EP3Cfyu3mOS3TSuFskjCgsPnXl1nMTeRxeKVhczblGQ2Psm+KcEnI9qJGAC5sVXWjK
         IhFX0YFXnB/c7vo1xh8iDHPRmavGXQe/ZsCJOyEH5rRxmeSC2JhwlWyLSEg0JrwQlrV6
         dYcXL/Ez2zmUOw7H3SN2D3cplQc4L2vOeuTzsfjN2zxUTMprBulYI1vDKdQpKtiYzNZr
         qhyYA/ChiRe8zquuhZJvmYK5bDQtm6fhO9NqTjoQxc/Kmw/89ymE49Fp4npmi+q/FV55
         XbO9lPFdL2WW7Rdl8Q60DWfBe24r70dFunUesLtz5c5gmBVCwaPMmw+lv0YV1s8DscXc
         iTqQ==
X-Gm-Message-State: AOJu0YzZxfcaJnoFEeUzk8ALMQQT1phKYjmu0cCjTUe0zAk06rl00Crx
	Uvg+7cYBzZYivZY7Gey5/QUFKtRjeGI6wIPwzzlHILXOQy5jVUnSExCR5A==
X-Google-Smtp-Source: AGHT+IHMugkpXgUM+nV7vs6PvgjXwQcn9NlekpLVXLqivZdaSMFqMASpdA+QI7IlWiyG0ZjXCcdcFA==
X-Received: by 2002:ac2:51a1:0:b0:524:4a7:5f1 with SMTP id 2adb3069b0e04-52b887403cdmr659150e87.2.1717158315985;
        Fri, 31 May 2024 05:25:15 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8ce24d60sm71688e87.290.2024.05.31.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:25:15 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Date: Fri, 31 May 2024 15:23:20 +0300
Message-ID: <20240531122320.909060-3-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240531122320.909060-1-yorha.op@gmail.com>
References: <20240531122320.909060-1-yorha.op@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This patch actually implements support for
multi-context design for kdamond daemon.

In pseudo code previous versions worked like
the following:

    while (!kdamond_should_stop()) {

	/* prepare accesses for only 1 context */
	prepare_accesses(damon_context);

	sleep(sample_interval);

	/* check accesses for only 1 context */
	check_accesses(damon_context);

	...
    }

With this patch kdamond workflow will look
like the following:

    while (!kdamond_shoule_stop()) {

	/* prepare accesses for all contexts in kdamond */
	damon_for_each_context(ctx, kdamond)
	    prepare_accesses(ctx);

	sleep(sample_interval);

	/* check_accesses for all contexts in kdamond */
	damon_for_each_context(ctx, kdamond)
	    check_accesses(ctx);

	...
    }

Another point to note is watermarks. Previous versions
checked watermarks on each iteration for current context
and if matric's value wan't acceptable kdamond waited
for watermark's sleep interval.

Now there's no need to wait for each context, we can
just skip context if watermark's metric isn't ready,
but if there's no contexts that can run we
check for each context's watermark metric and
sleep for the lowest interval of all contexts.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 include/linux/damon.h        |  11 +-
 include/trace/events/damon.h |  14 +-
 mm/damon/core-test.h         |   2 +-
 mm/damon/core.c              | 286 +++++++++++++++++------------
 mm/damon/dbgfs-test.h        |   4 +-
 mm/damon/dbgfs.c             | 342 +++++++++++++++++++++--------------
 mm/damon/modules-common.c    |   1 -
 mm/damon/sysfs.c             |  47 +++--
 8 files changed, 431 insertions(+), 276 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7cb9979a0..2facf3a5f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -575,7 +575,6 @@ struct damon_attrs {
  * @lock:	Kdamond's global lock, serializes accesses to any field.
  * @self:	Kernel thread which is actually being executed.
  * @contexts:	Head of contexts (&damon_ctx) list.
- * @nr_ctxs:	Number of contexts being monitored.
  *
  * Each DAMON's background daemon has this structure. Once
  * configured, daemon can be started by calling damon_start().
@@ -589,7 +588,6 @@ struct kdamond {
 	struct mutex lock;
 	struct task_struct *self;
 	struct list_head contexts;
-	size_t nr_ctxs;
 
 /* private: */
 	/* for waiting until the execution of the kdamond_fn is started */
@@ -634,7 +632,10 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
+	/* upper limit for each monitoring region */
 	unsigned long sz_limit;
+	/* marker to check if context is valid */
+	bool valid;
 
 /* public: */
 	struct kdamond *kdamond;
@@ -682,6 +683,12 @@ static inline struct damon_ctx *damon_first_ctx(struct kdamond *kdamond)
 	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
 }
 
+static inline bool damon_is_last_ctx(struct damon_ctx *ctx,
+				     struct kdamond *kdamond)
+{
+	return list_is_last(&ctx->list, &kdamond->contexts);
+}
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 23200aabc..d5287566c 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -50,12 +50,13 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 
 TRACE_EVENT(damon_aggregated,
 
-	TP_PROTO(unsigned int target_id, struct damon_region *r,
-		unsigned int nr_regions),
+	TP_PROTO(unsigned int context_id, unsigned int target_id,
+		struct damon_region *r, unsigned int nr_regions),
 
-	TP_ARGS(target_id, r, nr_regions),
+	TP_ARGS(context_id, target_id, r, nr_regions),
 
 	TP_STRUCT__entry(
+		__field(unsigned long, context_id)
 		__field(unsigned long, target_id)
 		__field(unsigned int, nr_regions)
 		__field(unsigned long, start)
@@ -65,6 +66,7 @@ TRACE_EVENT(damon_aggregated,
 	),
 
 	TP_fast_assign(
+		__entry->context_id = context_id;
 		__entry->target_id = target_id;
 		__entry->nr_regions = nr_regions;
 		__entry->start = r->ar.start;
@@ -73,9 +75,9 @@ TRACE_EVENT(damon_aggregated,
 		__entry->age = r->age;
 	),
 
-	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
-			__entry->target_id, __entry->nr_regions,
-			__entry->start, __entry->end,
+	TP_printk("context_id=%lu target_id=%lu nr_regions=%u %lu-%lu: %u %u",
+			__entry->context_id, __entry->target_id,
+			__entry->nr_regions, __entry->start, __entry->end,
 			__entry->nr_accesses, __entry->age)
 );
 
diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 0cee634f3..7962c9a0e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -99,7 +99,7 @@ static void damon_test_aggregate(struct kunit *test)
 		}
 		it++;
 	}
-	kdamond_reset_aggregated(ctx);
+	kdamond_reset_aggregated(ctx, 0);
 	it = 0;
 	damon_for_each_target(t, ctx) {
 		ir = 0;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index cfc9c803d..ad73752af 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -500,6 +500,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	ctx->valid = true;
+
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 	INIT_LIST_HEAD(&ctx->list);
@@ -513,7 +515,7 @@ struct damon_ctx *damon_new_ctx(void)
 void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx)
 {
 	list_add_tail(&ctx->list, &kdamond->contexts);
-	++kdamond->nr_ctxs;
+	ctx->kdamond = kdamond;
 }
 
 struct kdamond *damon_new_kdamond(void)
@@ -567,10 +569,8 @@ void damon_destroy_ctxs(struct kdamond *kdamond)
 {
 	struct damon_ctx *c, *next;
 
-	damon_for_each_context_safe(c, next, kdamond) {
+	damon_for_each_context_safe(c, next, kdamond)
 		damon_destroy_ctx(c);
-		--kdamond->nr_ctxs;
-	}
 }
 
 void damon_destroy_kdamond(struct kdamond *kdamond)
@@ -735,6 +735,20 @@ bool damon_kdamond_running(struct kdamond *kdamond)
 	return running;
 }
 
+/**
+ * kdamond_nr_ctxs() - Return number of contexts for this kdamond.
+ */
+static int kdamond_nr_ctxs(struct kdamond *kdamond)
+{
+	struct list_head *pos;
+	int nr_ctxs = 0;
+
+	list_for_each(pos, &kdamond->contexts)
+		++nr_ctxs;
+
+	return nr_ctxs;
+}
+
 /* Returns the size upper limit for each monitoring region */
 static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 {
@@ -793,11 +807,11 @@ static int __damon_start(struct kdamond *kdamond)
  * @exclusive:	exclusiveness of this contexts group
  *
  * This function starts a group of monitoring threads for a group of monitoring
- * contexts.  One thread per each context is created and run in parallel.  The
- * caller should handle synchronization between the threads by itself.  If
- * @exclusive is true and a group of threads that created by other
+ * contexts. If @exclusive is true and a group of contexts that created by other
  * 'damon_start()' call is currently running, this function does nothing but
- * returns -EBUSY.
+ * returns -EBUSY, if @exclusive is true and a given kdamond wants to run
+ * several contexts, then this function returns -EINVAL. kdamond can run
+ * exclusively only one context.
  *
  * Return: 0 on success, negative error code otherwise.
  */
@@ -806,10 +820,6 @@ int damon_start(struct kdamond *kdamond, bool exclusive)
 	int err = 0;
 
 	BUG_ON(!kdamond);
-	BUG_ON(!kdamond->nr_ctxs);
-
-	if (kdamond->nr_ctxs != 1)
-		return -EINVAL;
 
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_kdamonds) ||
@@ -818,6 +828,11 @@ int damon_start(struct kdamond *kdamond, bool exclusive)
 		return -EBUSY;
 	}
 
+	if (exclusive && kdamond_nr_ctxs(kdamond) > 1) {
+		mutex_unlock(&damon_lock);
+		return -EINVAL;
+	}
+
 	err = __damon_start(kdamond);
 	if (err)
 		return err;
@@ -857,7 +872,7 @@ int damon_stop(struct kdamond *kdamond)
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
-static void kdamond_reset_aggregated(struct damon_ctx *c)
+static void kdamond_reset_aggregated(struct damon_ctx *c, unsigned int ci)
 {
 	struct damon_target *t;
 	unsigned int ti = 0;	/* target's index */
@@ -866,7 +881,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
-			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			trace_damon_aggregated(ci, ti, r, damon_nr_regions(t));
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
@@ -1033,21 +1048,15 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	return false;
 }
 
-static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
-		struct damon_region *r, struct damos *s)
+static void damos_apply_scheme(unsigned int cidx, struct damon_ctx *c,
+			       struct damon_target *t, struct damon_region *r,
+			       struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
 	int err = 0;
-	/*
-	 * We plan to support multiple context per kdamond, as DAMON sysfs
-	 * implies with 'nr_contexts' file.  Nevertheless, only single context
-	 * per kdamond is supported for now.  So, we can simply use '0' context
-	 * index here.
-	 */
-	unsigned int cidx = 0;
 	struct damos *siter;		/* schemes iterator */
 	unsigned int sidx = 0;
 	struct damon_target *titer;	/* targets iterator */
@@ -1103,7 +1112,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	damos_update_stat(s, sz, sz_applied);
 }
 
-static void damon_do_apply_schemes(struct damon_ctx *c,
+static void damon_do_apply_schemes(unsigned int ctx_id,
+				   struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
 {
@@ -1128,7 +1138,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!damos_valid_target(c, t, r, s))
 			continue;
 
-		damos_apply_scheme(c, t, r, s);
+		damos_apply_scheme(ctx_id, c, t, r, s);
 	}
 }
 
@@ -1309,7 +1319,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	quota->min_score = score;
 }
 
-static void kdamond_apply_schemes(struct damon_ctx *c)
+static void kdamond_apply_schemes(struct damon_ctx *c, unsigned int ctx_id)
 {
 	struct damon_target *t;
 	struct damon_region *r, *next_r;
@@ -1335,7 +1345,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	damon_for_each_target(t, c) {
 		damon_for_each_region_safe(r, next_r, t)
-			damon_do_apply_schemes(c, t, r);
+			damon_do_apply_schemes(ctx_id, c, t, r);
 	}
 
 	damon_for_each_scheme(s, c) {
@@ -1505,22 +1515,35 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
  *
  * Returns true if need to stop current monitoring.
  */
-static bool kdamond_need_stop(struct damon_ctx *ctx)
+static bool kdamond_need_stop(void)
 {
-	struct damon_target *t;
-
 	if (kthread_should_stop())
 		return true;
+	return false;
+}
+
+static bool kdamond_valid_ctx(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
 
 	if (!ctx->ops.target_valid)
-		return false;
+		return true;
 
 	damon_for_each_target(t, ctx) {
 		if (ctx->ops.target_valid(t))
-			return false;
+			return true;
 	}
 
-	return true;
+	return false;
+}
+
+static void kdamond_usleep(unsigned long usecs)
+{
+	/* See Documentation/timers/timers-howto.rst for the thresholds */
+	if (usecs > 20 * USEC_PER_MSEC)
+		schedule_timeout_idle(usecs_to_jiffies(usecs));
+	else
+		usleep_idle_range(usecs, usecs + 1);
 }
 
 static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
@@ -1569,41 +1592,25 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 	return 0;
 }
 
-static void kdamond_usleep(unsigned long usecs)
-{
-	/* See Documentation/timers/timers-howto.rst for the thresholds */
-	if (usecs > 20 * USEC_PER_MSEC)
-		schedule_timeout_idle(usecs_to_jiffies(usecs));
-	else
-		usleep_idle_range(usecs, usecs + 1);
-}
-
-/* Returns negative error code if it's not activated but should return */
-static int kdamond_wait_activation(struct damon_ctx *ctx)
+/**
+ * Returns minimum wait time for monitoring context if it hits watermarks,
+ * otherwise returns 0.
+ */
+static unsigned long kdamond_wmark_wait_time(struct damon_ctx *ctx)
 {
 	struct damos *s;
 	unsigned long wait_time;
 	unsigned long min_wait_time = 0;
 	bool init_wait_time = false;
 
-	while (!kdamond_need_stop(ctx)) {
-		damon_for_each_scheme(s, ctx) {
-			wait_time = damos_wmark_wait_us(s);
-			if (!init_wait_time || wait_time < min_wait_time) {
-				init_wait_time = true;
-				min_wait_time = wait_time;
-			}
+	damon_for_each_scheme(s, ctx) {
+		wait_time = damos_wmark_wait_us(s);
+		if (!init_wait_time || wait_time < min_wait_time) {
+			init_wait_time = true;
+			min_wait_time = wait_time;
 		}
-		if (!min_wait_time)
-			return 0;
-
-		kdamond_usleep(min_wait_time);
-
-		if (ctx->callback.after_wmarks_check &&
-				ctx->callback.after_wmarks_check(ctx))
-			break;
 	}
-	return -EBUSY;
+	return min_wait_time;
 }
 
 static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
@@ -1672,14 +1679,41 @@ static void kdamond_finish_ctxs(struct kdamond *kdamond)
 		kdamond_finish_ctx(c);
 }
 
+static bool kdamond_prepare_access_checks_ctx(struct damon_ctx *ctx,
+					      unsigned long *sample_interval,
+					      unsigned long *min_wait_time)
+{
+	unsigned long wait_time = 0;
+
+	if (!ctx->valid || !kdamond_valid_ctx(ctx))
+		goto invalidate_ctx;
+
+	wait_time = kdamond_wmark_wait_time(ctx);
+	if (wait_time) {
+		if (!*min_wait_time || wait_time < *min_wait_time)
+			*min_wait_time = wait_time;
+		return false;
+	}
+
+	if (ctx->ops.prepare_access_checks)
+		ctx->ops.prepare_access_checks(ctx);
+	if (ctx->callback.after_sampling &&
+			ctx->callback.after_sampling(ctx))
+		goto invalidate_ctx;
+	*sample_interval = ctx->attrs.sample_interval;
+	return true;
+invalidate_ctx:
+	ctx->valid = false;
+	return false;
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
 static int kdamond_fn(void *data)
 {
+	struct damon_ctx *ctx;
 	struct kdamond *kdamond = data;
-	struct damon_ctx *ctx = damon_first_ctx(kdamond);
-	unsigned int max_nr_accesses = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
@@ -1687,69 +1721,85 @@ static int kdamond_fn(void *data)
 	if (!kdamond_init_ctxs(kdamond))
 		goto done;
 
-	while (!kdamond_need_stop(ctx)) {
-		/*
-		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
-		 * be changed from after_wmarks_check() or after_aggregation()
-		 * callbacks.  Read the values here, and use those for this
-		 * iteration.  That is, damon_set_attrs() updated new values
-		 * are respected from next iteration.
-		 */
-		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
-		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
-		unsigned long sample_interval = ctx->attrs.sample_interval;
-		unsigned long sz_limit = ctx->sz_limit;
-
-		if (kdamond_wait_activation(ctx))
-			break;
+	while (!kdamond_need_stop()) {
+		unsigned int ctx_id = 0;
+		unsigned long nr_valid_ctxs = 0;
+		unsigned long min_wait_time = 0;
+		unsigned long sample_interval = 0;
 
-		if (ctx->ops.prepare_access_checks)
-			ctx->ops.prepare_access_checks(ctx);
-		if (ctx->callback.after_sampling &&
-				ctx->callback.after_sampling(ctx))
-			break;
+		damon_for_each_context(ctx, kdamond) {
+			if (kdamond_prepare_access_checks_ctx(ctx, &sample_interval,
+							      &min_wait_time))
+				nr_valid_ctxs++;
+		}
 
+		if (!nr_valid_ctxs) {
+			if (!min_wait_time)
+				break;
+			kdamond_usleep(min_wait_time);
+			continue;
+		}
 		kdamond_usleep(sample_interval);
-		ctx->passed_sample_intervals++;
 
-		if (ctx->ops.check_accesses)
-			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		damon_for_each_context(ctx, kdamond) {
+			/*
+			 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
+			 * be changed from after_wmarks_check() or after_aggregation()
+			 * callbacks.  Read the values here, and use those for this
+			 * iteration.  That is, damon_set_attrs() updated new values
+			 * are respected from next iteration.
+			 */
+			unsigned int max_nr_accesses = 0;
+			unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
+			unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
+			unsigned long sz_limit = ctx->sz_limit;
+			unsigned long sample_interval = ctx->attrs.sample_interval ?
+							ctx->attrs.sample_interval : 1;
+
+			if (!ctx->valid)
+				goto next_ctx;
+
+			ctx->passed_sample_intervals++;
+
+			if (ctx->ops.check_accesses)
+				max_nr_accesses = ctx->ops.check_accesses(ctx);
+
+			if (ctx->passed_sample_intervals == next_aggregation_sis) {
+				kdamond_merge_regions(ctx,
+						max_nr_accesses / 10,
+						sz_limit);
+				if (ctx->callback.after_aggregation &&
+						ctx->callback.after_aggregation(ctx))
+					goto next_ctx;
+			}
+
+			/*
+			 * do kdamond_apply_schemes() after kdamond_merge_regions() if
+			 * possible, to reduce overhead
+			 */
+			if (!list_empty(&ctx->schemes))
+				kdamond_apply_schemes(ctx, ctx_id);
 
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
-			kdamond_merge_regions(ctx,
-					max_nr_accesses / 10,
-					sz_limit);
-			if (ctx->callback.after_aggregation &&
-					ctx->callback.after_aggregation(ctx))
-				break;
-		}
+			if (ctx->passed_sample_intervals == next_aggregation_sis) {
+				ctx->next_aggregation_sis = next_aggregation_sis +
+					ctx->attrs.aggr_interval / sample_interval;
 
-		/*
-		 * do kdamond_apply_schemes() after kdamond_merge_regions() if
-		 * possible, to reduce overhead
-		 */
-		if (!list_empty(&ctx->schemes))
-			kdamond_apply_schemes(ctx);
-
-		sample_interval = ctx->attrs.sample_interval ?
-			ctx->attrs.sample_interval : 1;
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
-			ctx->next_aggregation_sis = next_aggregation_sis +
-				ctx->attrs.aggr_interval / sample_interval;
-
-			kdamond_reset_aggregated(ctx);
-			kdamond_split_regions(ctx);
-			if (ctx->ops.reset_aggregated)
-				ctx->ops.reset_aggregated(ctx);
-		}
+				kdamond_reset_aggregated(ctx, ctx_id);
+				kdamond_split_regions(ctx);
+				if (ctx->ops.reset_aggregated)
+					ctx->ops.reset_aggregated(ctx);
+			}
 
-		if (ctx->passed_sample_intervals == next_ops_update_sis) {
-			ctx->next_ops_update_sis = next_ops_update_sis +
-				ctx->attrs.ops_update_interval /
-				sample_interval;
-			if (ctx->ops.update)
-				ctx->ops.update(ctx);
-			ctx->sz_limit = damon_region_sz_limit(ctx);
+			if (ctx->passed_sample_intervals == next_ops_update_sis) {
+				ctx->next_ops_update_sis = next_ops_update_sis +
+					ctx->attrs.ops_update_interval /
+					sample_interval;
+				if (ctx->ops.update)
+					ctx->ops.update(ctx);
+				ctx->sz_limit = damon_region_sz_limit(ctx);
+			}
+next_ctx:
+			++ctx_id;
 		}
 	}
 done:
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 2d85217f5..52745ed1d 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -70,7 +70,7 @@ static void damon_dbgfs_test_str_to_ints(struct kunit *test)
 
 static void damon_dbgfs_test_set_targets(struct kunit *test)
 {
-	struct damon_ctx *ctx = dbgfs_new_ctx();
+	struct damon_ctx *ctx = dbgfs_new_damon_ctx();
 	char buf[64];
 
 	/* Make DAMON consider target has no pid */
@@ -88,7 +88,7 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
 
-	dbgfs_destroy_ctx(ctx);
+	dbgfs_destroy_damon_ctx(ctx);
 }
 
 static void damon_dbgfs_test_set_init_regions(struct kunit *test)
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 2461cfe2e..7dff8376b 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -20,9 +20,13 @@
 	"to DAMON_SYSFS. If you cannot, please report your usecase to "	\
 	"damon@lists.linux.dev and linux-mm@kvack.org.\n"
 
-static struct damon_ctx **dbgfs_ctxs;
-static int dbgfs_nr_ctxs;
-static struct dentry **dbgfs_dirs;
+struct damon_dbgfs_ctx {
+	struct kdamond *kdamond;
+	struct dentry *dbgfs_dir;
+	struct list_head list;
+};
+
+static LIST_HEAD(damon_dbgfs_ctxs);
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
 static void damon_dbgfs_warn_deprecation(void)
@@ -30,6 +34,65 @@ static void damon_dbgfs_warn_deprecation(void)
 	pr_warn_once(DAMON_DBGFS_DEPRECATION_NOTICE);
 }
 
+static struct damon_dbgfs_ctx *dbgfs_root_dbgfs_ctx(void)
+{
+	return list_first_entry(&damon_dbgfs_ctxs,
+				struct damon_dbgfs_ctx, list);
+}
+
+static void dbgfs_add_dbgfs_ctx(struct damon_dbgfs_ctx *dbgfs_ctx)
+{
+	list_add_tail(&dbgfs_ctx->list, &damon_dbgfs_ctxs);
+}
+
+static struct damon_dbgfs_ctx *
+dbgfs_lookup_dbgfs_ctx(struct dentry *dbgfs_dir)
+{
+	struct damon_dbgfs_ctx *dbgfs_ctx;
+
+	list_for_each_entry(dbgfs_ctx, &damon_dbgfs_ctxs, list)
+		if (dbgfs_ctx->dbgfs_dir == dbgfs_dir)
+			return dbgfs_ctx;
+	return NULL;
+}
+
+static void dbgfs_stop_kdamonds(void)
+{
+	struct damon_dbgfs_ctx *dbgfs_ctx;
+	int ret = 0;
+
+	list_for_each_entry(dbgfs_ctx, &damon_dbgfs_ctxs, list)
+		if (damon_kdamond_running(dbgfs_ctx->kdamond))
+			ret |= damon_stop(dbgfs_ctx->kdamond);
+	if (ret)
+		pr_err("%s: some running kdamond(s) failed to stop!\n", __func__);
+}
+
+
+static int dbgfs_start_kdamonds(void)
+{
+	int ret;
+	struct damon_dbgfs_ctx *dbgfs_ctx;
+
+	list_for_each_entry(dbgfs_ctx, &damon_dbgfs_ctxs, list) {
+		ret = damon_start(dbgfs_ctx->kdamond, false);
+		if (ret)
+			goto err_stop_kdamonds;
+	}
+	return 0;
+
+err_stop_kdamonds:
+	dbgfs_stop_kdamonds();
+	return ret;
+}
+
+static bool dbgfs_targets_empty(struct damon_dbgfs_ctx *dbgfs_ctx)
+{
+	struct damon_ctx *ctx = damon_first_ctx(dbgfs_ctx->kdamond);
+
+	return damon_targets_empty(ctx);
+}
+
 /*
  * Returns non-empty string on success, negative error code otherwise.
  */
@@ -60,15 +123,16 @@ static ssize_t dbgfs_attrs_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	char kbuf[128];
 	int ret;
 
-	mutex_lock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
 	ret = scnprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
 			ctx->attrs.sample_interval, ctx->attrs.aggr_interval,
 			ctx->attrs.ops_update_interval,
 			ctx->attrs.min_nr_regions, ctx->attrs.max_nr_regions);
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 
 	return simple_read_from_buffer(buf, count, ppos, kbuf, ret);
 }
@@ -77,6 +141,7 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	struct damon_attrs attrs;
 	char *kbuf;
 	ssize_t ret;
@@ -94,8 +159,8 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 		goto out;
 	}
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond) {
+	mutex_lock(&kdamond->lock);
+	if (kdamond->self) {
 		ret = -EBUSY;
 		goto unlock_out;
 	}
@@ -104,7 +169,7 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 	if (!ret)
 		ret = count;
 unlock_out:
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 out:
 	kfree(kbuf);
 	return ret;
@@ -173,6 +238,7 @@ static ssize_t dbgfs_schemes_read(struct file *file, char __user *buf,
 		size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	char *kbuf;
 	ssize_t len;
 
@@ -180,9 +246,9 @@ static ssize_t dbgfs_schemes_read(struct file *file, char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	mutex_lock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
 	len = sprint_schemes(ctx, kbuf, count);
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	if (len < 0)
 		goto out;
 	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
@@ -298,6 +364,7 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 		size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	char *kbuf;
 	struct damos **schemes;
 	ssize_t nr_schemes = 0, ret;
@@ -312,8 +379,8 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond) {
+	mutex_lock(&kdamond->lock);
+	if (kdamond->self) {
 		ret = -EBUSY;
 		goto unlock_out;
 	}
@@ -323,13 +390,16 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 	nr_schemes = 0;
 
 unlock_out:
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	free_schemes_arr(schemes, nr_schemes);
 out:
 	kfree(kbuf);
 	return ret;
 }
 
+#pragma GCC push_options
+#pragma GCC optimize("O0")
+
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
 	struct damon_target *t;
@@ -360,18 +430,21 @@ static ssize_t dbgfs_target_ids_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	ssize_t len;
 	char ids_buf[320];
 
-	mutex_lock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
 	len = sprint_target_ids(ctx, ids_buf, 320);
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	if (len < 0)
 		return len;
 
 	return simple_read_from_buffer(buf, count, ppos, ids_buf, len);
 }
 
+#pragma GCC pop_options
+
 /*
  * Converts a string into an integers array
  *
@@ -491,6 +564,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	bool id_is_pid = true;
 	char *kbuf;
 	struct pid **target_pids = NULL;
@@ -514,8 +588,8 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		}
 	}
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond) {
+	mutex_lock(&kdamond->lock);
+	if (kdamond->self) {
 		if (id_is_pid)
 			dbgfs_put_pids(target_pids, nr_targets);
 		ret = -EBUSY;
@@ -542,7 +616,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		ret = count;
 
 unlock_out:
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	kfree(target_pids);
 out:
 	kfree(kbuf);
@@ -575,6 +649,7 @@ static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
 		size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	char *kbuf;
 	ssize_t len;
 
@@ -582,15 +657,15 @@ static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	mutex_lock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
 	if (ctx->kdamond) {
-		mutex_unlock(&ctx->kdamond_lock);
+		mutex_unlock(&kdamond->lock);
 		len = -EBUSY;
 		goto out;
 	}
 
 	len = sprint_init_regions(ctx, kbuf, count);
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	if (len < 0)
 		goto out;
 	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
@@ -670,6 +745,7 @@ static ssize_t dbgfs_init_regions_write(struct file *file,
 					  loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	char *kbuf;
 	ssize_t ret = count;
 	int err;
@@ -678,8 +754,8 @@ static ssize_t dbgfs_init_regions_write(struct file *file,
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond) {
+	mutex_lock(&kdamond->lock);
+	if (kdamond->self) {
 		ret = -EBUSY;
 		goto unlock_out;
 	}
@@ -689,7 +765,7 @@ static ssize_t dbgfs_init_regions_write(struct file *file,
 		ret = err;
 
 unlock_out:
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	kfree(kbuf);
 	return ret;
 }
@@ -698,6 +774,7 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	struct kdamond *kdamond = ctx->kdamond;
 	char *kbuf;
 	ssize_t len;
 
@@ -705,12 +782,12 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 	if (!kbuf)
 		return -ENOMEM;
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond)
-		len = scnprintf(kbuf, count, "%d\n", ctx->kdamond->pid);
+	mutex_lock(&kdamond->lock);
+	if (kdamond->self)
+		len = scnprintf(kbuf, count, "%d\n", ctx->kdamond->self->pid);
 	else
 		len = scnprintf(kbuf, count, "none\n");
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 	if (!len)
 		goto out;
 	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
@@ -773,19 +850,30 @@ static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 static void dbgfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
+	struct kdamond *kdamond = ctx->kdamond;
 
 	if (!damon_target_has_pid(ctx))
 		return;
 
-	mutex_lock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
 	damon_for_each_target_safe(t, next, ctx) {
 		put_pid(t->pid);
 		damon_destroy_target(t);
 	}
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
+}
+
+static struct kdamond *dbgfs_new_kdamond(void)
+{
+	struct kdamond *kdamond;
+
+	kdamond = damon_new_kdamond();
+	if (!kdamond)
+		return NULL;
+	return kdamond;
 }
 
-static struct damon_ctx *dbgfs_new_ctx(void)
+static struct damon_ctx *dbgfs_new_damon_ctx(void)
 {
 	struct damon_ctx *ctx;
 
@@ -802,11 +890,19 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	return ctx;
 }
 
-static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
+static void dbgfs_destroy_damon_ctx(struct damon_ctx *ctx)
 {
 	damon_destroy_ctx(ctx);
 }
 
+static void dbgfs_destroy_dbgfs_ctx(struct damon_dbgfs_ctx *dbgfs_ctx)
+{
+	debugfs_remove(dbgfs_ctx->dbgfs_dir);
+	damon_destroy_kdamond(dbgfs_ctx->kdamond);
+	list_del(&dbgfs_ctx->list);
+	kfree(dbgfs_ctx);
+}
+
 static ssize_t damon_dbgfs_deprecated_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
@@ -824,47 +920,56 @@ static ssize_t damon_dbgfs_deprecated_read(struct file *file,
  */
 static int dbgfs_mk_context(char *name)
 {
-	struct dentry *root, **new_dirs, *new_dir;
-	struct damon_ctx **new_ctxs, *new_ctx;
+	int rc;
+	struct damon_dbgfs_ctx *dbgfs_root_ctx, *new_dbgfs_ctx;
+	struct dentry *root, *new_dir;
+	struct damon_ctx *new_ctx;
+	struct kdamond *new_kdamond;
 
 	if (damon_nr_running_ctxs())
 		return -EBUSY;
 
-	new_ctxs = krealloc(dbgfs_ctxs, sizeof(*dbgfs_ctxs) *
-			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
-	if (!new_ctxs)
+	new_dbgfs_ctx = kmalloc(sizeof(*new_dbgfs_ctx), GFP_KERNEL);
+	if (!new_dbgfs_ctx)
 		return -ENOMEM;
-	dbgfs_ctxs = new_ctxs;
 
-	new_dirs = krealloc(dbgfs_dirs, sizeof(*dbgfs_dirs) *
-			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
-	if (!new_dirs)
-		return -ENOMEM;
-	dbgfs_dirs = new_dirs;
-
-	root = dbgfs_dirs[0];
-	if (!root)
-		return -ENOENT;
+	rc = -ENOENT;
+	dbgfs_root_ctx = dbgfs_root_dbgfs_ctx();
+	if (!dbgfs_root_ctx || !dbgfs_root_ctx->dbgfs_dir)
+		goto destroy_new_dbgfs_ctx;
+	root = dbgfs_root_ctx->dbgfs_dir;
 
 	new_dir = debugfs_create_dir(name, root);
 	/* Below check is required for a potential duplicated name case */
-	if (IS_ERR(new_dir))
-		return PTR_ERR(new_dir);
-	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
-
-	new_ctx = dbgfs_new_ctx();
-	if (!new_ctx) {
-		debugfs_remove(new_dir);
-		dbgfs_dirs[dbgfs_nr_ctxs] = NULL;
-		return -ENOMEM;
+	if (IS_ERR(new_dir)) {
+		rc = PTR_ERR(new_dir);
+		goto destroy_new_dbgfs_ctx;
 	}
+	new_dbgfs_ctx->dbgfs_dir = new_dir;
+
+	rc = -ENOMEM;
+	new_kdamond = damon_new_kdamond();
+	if (!new_kdamond)
+		goto destroy_new_dir;
+
+	new_ctx = dbgfs_new_damon_ctx();
+	if (!new_ctx)
+		goto destroy_new_kdamond;
+	damon_add_ctx(new_kdamond, new_ctx);
+	new_dbgfs_ctx->kdamond = new_kdamond;
 
-	dbgfs_ctxs[dbgfs_nr_ctxs] = new_ctx;
-	dbgfs_fill_ctx_dir(dbgfs_dirs[dbgfs_nr_ctxs],
-			dbgfs_ctxs[dbgfs_nr_ctxs]);
-	dbgfs_nr_ctxs++;
+	dbgfs_fill_ctx_dir(new_dir, new_ctx);
+	dbgfs_add_dbgfs_ctx(new_dbgfs_ctx);
 
 	return 0;
+
+destroy_new_kdamond:
+	damon_destroy_kdamond(new_kdamond);
+destroy_new_dir:
+	debugfs_remove(new_dir);
+destroy_new_dbgfs_ctx:
+	kfree(new_dbgfs_ctx);
+	return rc;
 }
 
 static ssize_t dbgfs_mk_context_write(struct file *file,
@@ -910,64 +1015,35 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
  */
 static int dbgfs_rm_context(char *name)
 {
-	struct dentry *root, *dir, **new_dirs;
+	struct dentry *root, *dir;
 	struct inode *inode;
-	struct damon_ctx **new_ctxs;
-	int i, j;
+	struct damon_dbgfs_ctx *dbgfs_root_ctx;
+	struct damon_dbgfs_ctx *dbgfs_ctx;
 	int ret = 0;
 
 	if (damon_nr_running_ctxs())
 		return -EBUSY;
 
-	root = dbgfs_dirs[0];
-	if (!root)
+	dbgfs_root_ctx = dbgfs_root_dbgfs_ctx();
+	if (!dbgfs_root_ctx || !dbgfs_root_ctx->dbgfs_dir)
 		return -ENOENT;
+	root = dbgfs_root_ctx->dbgfs_dir;
 
 	dir = debugfs_lookup(name, root);
 	if (!dir)
 		return -ENOENT;
 
+	dbgfs_ctx = dbgfs_lookup_dbgfs_ctx(dir);
+	if (!dbgfs_ctx)
+		return -ENOENT;
+
 	inode = d_inode(dir);
 	if (!S_ISDIR(inode->i_mode)) {
 		ret = -EINVAL;
 		goto out_dput;
 	}
+	dbgfs_destroy_dbgfs_ctx(dbgfs_ctx);
 
-	new_dirs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_dirs),
-			GFP_KERNEL);
-	if (!new_dirs) {
-		ret = -ENOMEM;
-		goto out_dput;
-	}
-
-	new_ctxs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_ctxs),
-			GFP_KERNEL);
-	if (!new_ctxs) {
-		ret = -ENOMEM;
-		goto out_new_dirs;
-	}
-
-	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
-		if (dbgfs_dirs[i] == dir) {
-			debugfs_remove(dbgfs_dirs[i]);
-			dbgfs_destroy_ctx(dbgfs_ctxs[i]);
-			continue;
-		}
-		new_dirs[j] = dbgfs_dirs[i];
-		new_ctxs[j++] = dbgfs_ctxs[i];
-	}
-
-	kfree(dbgfs_dirs);
-	kfree(dbgfs_ctxs);
-
-	dbgfs_dirs = new_dirs;
-	dbgfs_ctxs = new_ctxs;
-	dbgfs_nr_ctxs--;
-
-	goto out_dput;
-
-out_new_dirs:
-	kfree(new_dirs);
 out_dput:
 	dput(dir);
 	return ret;
@@ -1024,6 +1100,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 {
 	ssize_t ret;
 	char *kbuf;
+	struct damon_dbgfs_ctx *dbgfs_ctx;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -1037,18 +1114,16 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 
 	mutex_lock(&damon_dbgfs_lock);
 	if (!strncmp(kbuf, "on", count)) {
-		int i;
-
-		for (i = 0; i < dbgfs_nr_ctxs; i++) {
-			if (damon_targets_empty(dbgfs_ctxs[i])) {
+		list_for_each_entry(dbgfs_ctx, &damon_dbgfs_ctxs, list) {
+			if (dbgfs_targets_empty(dbgfs_ctx)) {
 				kfree(kbuf);
 				mutex_unlock(&damon_dbgfs_lock);
 				return -EINVAL;
 			}
 		}
-		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs, true);
+		ret = dbgfs_start_kdamonds();
 	} else if (!strncmp(kbuf, "off", count)) {
-		ret = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
+		dbgfs_stop_kdamonds();
 	} else {
 		ret = -EINVAL;
 	}
@@ -1088,27 +1163,20 @@ static const struct file_operations monitor_on_fops = {
 
 static int __init __damon_dbgfs_init(void)
 {
-	struct dentry *dbgfs_root;
+	struct dentry *dbgfs_root_dir;
+	struct damon_dbgfs_ctx *dbgfs_root_ctx = dbgfs_root_dbgfs_ctx();
+	struct damon_ctx *damon_ctx = damon_first_ctx(dbgfs_root_ctx->kdamond);
 	const char * const file_names[] = {"mk_contexts", "rm_contexts",
 		"monitor_on_DEPRECATED", "DEPRECATED"};
 	const struct file_operations *fops[] = {&mk_contexts_fops,
 		&rm_contexts_fops, &monitor_on_fops, &deprecated_fops};
-	int i;
-
-	dbgfs_root = debugfs_create_dir("damon", NULL);
 
-	for (i = 0; i < ARRAY_SIZE(file_names); i++)
-		debugfs_create_file(file_names[i], 0600, dbgfs_root, NULL,
+	dbgfs_root_dir = debugfs_create_dir("damon", NULL);
+	for (int i = 0; i < ARRAY_SIZE(file_names); i++)
+		debugfs_create_file(file_names[i], 0600, dbgfs_root_dir, NULL,
 				fops[i]);
-	dbgfs_fill_ctx_dir(dbgfs_root, dbgfs_ctxs[0]);
-
-	dbgfs_dirs = kmalloc(sizeof(dbgfs_root), GFP_KERNEL);
-	if (!dbgfs_dirs) {
-		debugfs_remove(dbgfs_root);
-		return -ENOMEM;
-	}
-	dbgfs_dirs[0] = dbgfs_root;
-
+	dbgfs_fill_ctx_dir(dbgfs_root_dir, damon_ctx);
+	dbgfs_root_ctx->dbgfs_dir = dbgfs_root_dir;
 	return 0;
 }
 
@@ -1118,26 +1186,38 @@ static int __init __damon_dbgfs_init(void)
 
 static int __init damon_dbgfs_init(void)
 {
+	struct damon_dbgfs_ctx *dbgfs_ctx;
+	struct damon_ctx *damon_ctx;
 	int rc = -ENOMEM;
 
 	mutex_lock(&damon_dbgfs_lock);
-	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
-	if (!dbgfs_ctxs)
+	dbgfs_ctx = kmalloc(sizeof(*dbgfs_ctx), GFP_KERNEL);
+	if (!dbgfs_ctx)
 		goto out;
-	dbgfs_ctxs[0] = dbgfs_new_ctx();
-	if (!dbgfs_ctxs[0]) {
-		kfree(dbgfs_ctxs);
-		goto out;
-	}
-	dbgfs_nr_ctxs = 1;
+
+	dbgfs_ctx->kdamond = dbgfs_new_kdamond();
+	if (!dbgfs_ctx->kdamond)
+		goto bad_kdamond;
+
+	damon_ctx = dbgfs_new_damon_ctx();
+	if (!damon_ctx)
+		goto destroy_kdamond;
+	damon_add_ctx(dbgfs_ctx->kdamond, damon_ctx);
+
+	dbgfs_add_dbgfs_ctx(dbgfs_ctx);
 
 	rc = __damon_dbgfs_init();
 	if (rc) {
-		kfree(dbgfs_ctxs[0]);
-		kfree(dbgfs_ctxs);
 		pr_err("%s: dbgfs init failed\n", __func__);
+		goto destroy_kdamond;
 	}
+	mutex_unlock(&damon_dbgfs_lock);
+	return 0;
 
+destroy_kdamond:
+	damon_destroy_kdamond(dbgfs_ctx->kdamond);
+bad_kdamond:
+	kfree(dbgfs_ctx);
 out:
 	mutex_unlock(&damon_dbgfs_lock);
 	return rc;
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 436bb7948..6a7c0a085 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -53,7 +53,6 @@ int damon_modules_new_paddr_kdamond(struct kdamond **kdamondp)
 		damon_destroy_kdamond(kdamond);
 		return err;
 	}
-	kdamond->nr_ctxs = 1;
 
 	*kdamondp = kdamond;
 	return 0;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index bfdb979e6..41ade0770 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -897,8 +897,7 @@ static ssize_t nr_contexts_store(struct kobject *kobj,
 	err = kstrtoint(buf, 0, &nr);
 	if (err)
 		return err;
-	/* TODO: support multiple contexts per kdamond */
-	if (nr < 0 || 1 < nr)
+	if (nr < 0)
 		return -EINVAL;
 
 	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
@@ -1381,23 +1380,48 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
  */
 static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *sys_kdamond)
 {
+	unsigned long ctx_id = 0;
 	struct damon_ctx *c;
-	struct damon_sysfs_context *sysfs_ctx;
+	struct damon_sysfs_context **sysfs_ctxs;
 	int err;
 
 	if (!damon_sysfs_kdamond_running(sys_kdamond))
 		return -EINVAL;
-	/* TODO: Support multiple contexts per kdamond */
-	if (sys_kdamond->contexts->nr != 1)
-		return -EINVAL;
 
-	sysfs_ctx = sys_kdamond->contexts->contexts_arr[0];
+	sysfs_ctxs = sys_kdamond->contexts->contexts_arr;
 	damon_for_each_context(c, sys_kdamond->kdamond) {
+		struct damon_sysfs_context *sysfs_ctx = *sysfs_ctxs;
+		struct damon_sysfs_intervals *sys_intervals =
+			sysfs_ctx->attrs->intervals;;
+
+		if (sys_kdamond->contexts->nr > 1 &&
+				sys_intervals->sample_us != c->attrs.sample_interval) {
+			pr_err("context_id=%lu: "
+				"multiple contexts must have equal sample_interval\n",
+					ctx_id);
+			/*
+			 * since multiple contexts expect equal
+			 * sample_intervals, try to fix it here
+			 */
+			sys_intervals->sample_us = c->attrs.sample_interval;
+		}
+
 		err = damon_sysfs_apply_inputs(c, sysfs_ctx);
 		if (err)
 			return err;
-		++sysfs_ctx;
+		++sysfs_ctxs;
+
+		/* sysfs_ctx may be NIL, so check if it is the last */
+		if (sys_kdamond->contexts->nr > 1 && sysfs_ctxs &&
+				!damon_is_last_ctx(c, sys_kdamond->kdamond)) {
+			sysfs_ctx = *sysfs_ctxs;
+			sys_intervals = sysfs_ctx->attrs->intervals;
+			/* We somehow failed in fixing sample_interval above */
+			BUG_ON(sys_intervals->sample_us != c->attrs.sample_interval);
+		}
+		++ctx_id;
 	}
+
 	return 0;
 }
 
@@ -1410,9 +1434,6 @@ static int damon_sysfs_commit_schemes_quota_goals(
 
 	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
 		return -EINVAL;
-	/* TODO: Support multiple contexts per kdamond */
-	if (sysfs_kdamond->contexts->nr != 1)
-		return -EINVAL;
 
 	sysfs_ctxs = sysfs_kdamond->contexts->contexts_arr;
 	damon_for_each_context(c, sysfs_kdamond->kdamond) {
@@ -1598,7 +1619,6 @@ static struct kdamond *damon_sysfs_build_kdamond(
 			damon_destroy_kdamond(kdamond);
 			return ERR_PTR(PTR_ERR(ctx));
 		}
-		ctx->kdamond = kdamond;
 		damon_add_ctx(kdamond, ctx);
 	}
 	return kdamond;
@@ -1613,9 +1633,6 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *sys_kdamond)
 		return -EBUSY;
 	if (damon_sysfs_cmd_request.kdamond == sys_kdamond)
 		return -EBUSY;
-	/* TODO: support multiple contexts per kdamond */
-	if (sys_kdamond->contexts->nr != 1)
-		return -EINVAL;
 
 	if (sys_kdamond->kdamond)
 		damon_destroy_kdamond(sys_kdamond->kdamond);
-- 
2.42.0

