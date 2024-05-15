Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DB15573E
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786723; cv=none; b=EW1x3iR4Oxjd0SDEwR4Ddf1cR90g0I09JfwkvnG7xyJBxkeJKSsukwiY/jNkqTa1xD5kQRRINPfevRDJNyUVhJicCl1Jwzs+4/q7IVeYlYgGoEzocIB2A804w41ubbHjUuiFDxsJcWoGw+2iQ8LRJZXf1OH55S24W3/nbf+9Dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786723; c=relaxed/simple;
	bh=qYrsW5cS94SAZr985eCbDUcYIYWOx5khUYDVgevQPTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrImC2gwd+6d3Va5JBZhvVsh+VGZMbuwRXSl484gf+Dl/Q55YiLEzXAWVrbt6Iy2wOb3WbfqKjqvkpDGOAqd6PiNXqwS1vMgN6dPZidBtj4FDAWd4BW/GGL+1o82NidyPajERxOEI5FOyUE7K4DERSyhgUAZGXoKNxaxdMqjdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9SfNxnM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9SfNxnM"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52389c1308dso1634089e87.3
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786718; x=1716391518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOzAvpsQ0tq2arrABRfr1v67Oj39+lQ4GvuIGBRhfLg=;
        b=J9SfNxnMoKOEpBTg3YhBpc0/5syIX5amWS313xvnDzJalbXvDEVsl2uZDEmeZlf3Ft
         Vx+sHGDUkOkNRrPrfXFvpVJ2iWbBp2vFrfluPmhaGxN97Q9j/o9cQOf7jU1ldqyJRvWx
         mKEdYMK3r54cW1ULki48vn/xWS311icMzkFri8xDn0uhxdddVjs5qBt96IdfE0Z0BaAE
         EboUof55MTLo3XOgUPNWgEGI5JGwtTf2C9QtKXRk4V7c9JMMZbvADYS14hSzSAqcUI1/
         OdbMIm30+qfdrBlekh6ptAPXjjAbwGmg+ohmwpyVFp2S0/wuFnFq4RlSw0dllmKvaXQh
         oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786718; x=1716391518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOzAvpsQ0tq2arrABRfr1v67Oj39+lQ4GvuIGBRhfLg=;
        b=gS8pX1bpmsxANtTS+uRXen2fywrnUqg0WGFD1G4TnPyNnzSloml7NIx5166RIWsnZN
         cX6lyNOqK4FOiEkHLGfWKdRi0xxje8Is9lSoGZqZWcm30L6fhpqutDmd9x9ZQmCnGwHw
         UOi8Eb9VOZi0+OjrOMS6oGoRtTd0KZcSyH+JNz7iyNCsbqV0V27MIr/LxpquWZ+IDEfA
         HH3fUSskcMe4eZqF3a4ndDvkBogp41uWhye+JEZ92bOV5YCY789IqIFDHouNmh4sYO/F
         E1CT68wIo1ZxfcQu7HClOef5xQwguUX+DAvxQnd7OX5NFtJWo3QTyeOQMmQm9lmUFltx
         6p9A==
X-Gm-Message-State: AOJu0YyFW87mtHMLwwohCKZ19fWHIaoPwOKKtyCZooHR9Q4PL1Th9vIt
	tWFtzh0SS08hNUZlglxKDfI9ZADZpv4+dRcPx48hu1dGYPP3gbv7h6ANnA==
X-Google-Smtp-Source: AGHT+IGJgXgKo8RHx0J5k+dSVX6XFdEyfnnHi+iYYpXpIBznDs5K6BDTyg4/gUWBbYkBR9YvWHBCTQ==
X-Received: by 2002:a05:6512:39c9:b0:522:33dd:dcd9 with SMTP id 2adb3069b0e04-52233dddd7amr10791518e87.33.1715786718097;
        Wed, 15 May 2024 08:25:18 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:17 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 6/7] mm/damon/core: multi-context support
Date: Wed, 15 May 2024 18:24:56 +0300
Message-ID: <20240515152457.603724-7-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240515152457.603724-1-yorha.op@gmail.com>
References: <20240515152457.603724-1-yorha.op@gmail.com>
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
 include/linux/damon.h     |   8 +-
 mm/damon/core.c           | 255 +++++++++++++++++++++++---------------
 mm/damon/modules-common.c |   1 -
 mm/damon/sysfs.c          |  48 ++++---
 4 files changed, 194 insertions(+), 118 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ec291a2eb..972ecf509 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -572,7 +572,6 @@ struct kdamond_struct {
 	struct mutex lock;
 	struct task_struct *self;
 	struct list_head contexts;
-	size_t nr_ctxs;
 
 /* private: */
 	/* for waiting until the execution of the kdamond_fn is started */
@@ -626,6 +625,7 @@ struct damon_ctx {
 	 */
 	unsigned long next_ops_update_sis;
 	unsigned long sz_limit;
+	bool valid;
 
 /* public: */
 	struct kdamond_struct *kdamond;
@@ -673,6 +673,12 @@ static inline struct damon_ctx *damon_first_ctx(struct kdamond_struct *kdamond)
 	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
 }
 
+static inline bool damon_is_last_ctx(struct damon_ctx *ctx,
+				     struct kdamond_struct *kdamond)
+{
+	return list_is_last(&ctx->list, &kdamond->contexts);
+}
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 822e54f29..dc92a8703 100644
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
@@ -510,7 +512,6 @@ struct damon_ctx *damon_new_ctx(void)
 void damon_add_ctx(struct kdamond_struct *kdamond, struct damon_ctx *ctx)
 {
 	list_add_tail(&ctx->list, &kdamond->contexts);
-	++kdamond->nr_ctxs;
 }
 
 struct kdamond_struct *damon_new_kdamond(void)
@@ -730,6 +731,20 @@ bool damon_kdamond_running(struct kdamond_struct *kdamond)
 	return running;
 }
 
+/**
+ * kdamond_nr_ctxs() - Return number of contexts for this kdamond.
+ */
+static int kdamond_nr_ctxs(struct kdamond_struct *kdamond)
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
@@ -784,16 +799,14 @@ static int __damon_start(struct kdamond_struct *kdamond)
 
 /**
  * damon_start() - Starts the monitorings for a given group of contexts.
- * @ctxs:	an array of the pointers for contexts to start monitoring
- * @nr_ctxs:	size of @ctxs
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
@@ -802,10 +815,6 @@ int damon_start(struct kdamond_struct *kdamond, bool exclusive)
 	int err = 0;
 
 	BUG_ON(!kdamond);
-	BUG_ON(!kdamon->nr_ctxs);
-
-	if (kdamond->nr_ctxs != 1)
-		return -EINVAL;
 
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_kdamonds) ||
@@ -814,6 +823,11 @@ int damon_start(struct kdamond_struct *kdamond, bool exclusive)
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
@@ -1499,22 +1513,35 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
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
@@ -1563,41 +1590,22 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
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
+/* context must be valid */
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
@@ -1666,14 +1674,42 @@ static void kdamond_finish_ctxs(struct kdamond_struct *kdamond)
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
+	ctx->prepared = true;
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
 	struct kdamond_struct *kdamond = data;
-	struct damon_ctx *ctx = damon_first_ctx(kdamond);
-	unsigned int max_nr_accesses = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
@@ -1681,69 +1717,84 @@ static int kdamond_fn(void *data)
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
 
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
-			kdamond_merge_regions(ctx,
-					max_nr_accesses / 10,
-					sz_limit);
-			if (ctx->callback.after_aggregation &&
-					ctx->callback.after_aggregation(ctx))
-				break;
-		}
+			/*
+			 * do kdamond_apply_schemes() after kdamond_merge_regions() if
+			 * possible, to reduce overhead
+			 */
+			if (!list_empty(&ctx->schemes))
+				kdamond_apply_schemes(ctx);
 
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
+			if (ctx->passed_sample_intervals == next_aggregation_sis) {
+				ctx->next_aggregation_sis = next_aggregation_sis +
+					ctx->attrs.aggr_interval / sample_interval;
+
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
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index a70b4fc7a..0fa53bc43 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -53,7 +53,6 @@ int damon_modules_new_paddr_kdamond(struct kdamond_struct **kdamondp)
 		damon_destroy_kdamond(kdamond);
 		return err;
 	}
-	kdamond->nr_ctxs = 1;
 
 	*kdamondp = kdamond;
 	return 0;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index db2d48361..b473a1e6d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
  */
 
+#define pr_fmt(fmt) "damon-sysfs: " fmt
+
 #include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -897,8 +899,7 @@ static ssize_t nr_contexts_store(struct kobject *kobj,
 	err = kstrtoint(buf, 0, &nr);
 	if (err)
 		return err;
-	/* TODO: support multiple contexts per kdamond */
-	if (nr < 0 || 1 < nr)
+	if (nr < 0)
 		return -EINVAL;
 
 	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
@@ -1381,23 +1382,48 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
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
 
@@ -1410,9 +1436,6 @@ static int damon_sysfs_commit_schemes_quota_goals(
 
 	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
 		return -EINVAL;
-	/* TODO: Support multiple contexts per kdamond */
-	if (sysfs_kdamond->contexts->nr != 1)
-		return -EINVAL;
 
 	sysfs_ctxs = sysfs_kdamond->contexts->contexts_arr;
 	damon_for_each_context(c, sysfs_kdamond->kdamond) {
@@ -1613,9 +1636,6 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *sys_kdamond)
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

