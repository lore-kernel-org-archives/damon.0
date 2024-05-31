Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBA1586CD
	for <damon@lists.linux.dev>; Fri, 31 May 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158319; cv=none; b=W6K58XkguYljhCbm/BYSYhL9S+yT+BdbZB7wocjwyNgjglKL99Hs5woWbK2rZb7rE2i/8cREd9kkaT1q9d+himjKHAHN5PvwiUYSJ2m12JgB/x+kHWqu73a8I5hzoRRPAEV7ogWkYGWk8LJ5Hjf0m/ab9sLNmafpt3amoSqpKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158319; c=relaxed/simple;
	bh=Zg27Kas9zczRf9tfTNAOW/3U3g5K5HVeJvsk0aE9t8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVcjU37FazTDJZEuBy8nx6zKFhIZlBorUzcKWJ24OhHIWXjWbdBD0IB1NS1ZhgVHfHHKfNZU9FX1SXv27csxubGvTwXlZ+FOwMhMlVw4UlW3tf/MiCuVQ/JYXKDzzedDRzI961vL82KN9cUZkL6pUSIOljiSo6q3cTINuFvZ3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBjaxcbW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBjaxcbW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b78c65cadso2631035e87.0
        for <damon@lists.linux.dev>; Fri, 31 May 2024 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158315; x=1717763115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqvTbELB5ae5p6LVzGb7NuLsg4X4tCUb9QHEKajAhlo=;
        b=FBjaxcbWUi00mutzlMj9L6fpUiz4/gOmfJlE9lenxc+/lA9Sbxb7NAbp+xaiH5XPq6
         IMuNJgPIxfIOsTN7lnqO+IvGHBB/oOQkjQBJ+9aazVqC0Dc3O3vEn4h3P2J83gaauZYE
         Prfm8tmANl/OPTcuJUhABxU+BKfu55obFeODxLfucFlKOaVPt/RI0DH12Uq7VaeeyW62
         iO6OXKBJ3pFbvbJIeCa8zROTKvf0QM3ylJTR7Ww2OIs7KAoEiWD6TBlGBvqEkpGY9yCA
         OwpENJF/sZeNVbrQ5u+4luz84rKacN+AvsNzptSvdNUfpnHB2bbfSfvMm2HdLYAcgnga
         Z0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158315; x=1717763115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqvTbELB5ae5p6LVzGb7NuLsg4X4tCUb9QHEKajAhlo=;
        b=IOeSVi6xZyRcI9gCFWCvNbcMX9aTPa/JRl6Pho2Gwyda6FlBfyoJc8e9Bx2XN0psT6
         sttr55XsMoNRIZyLDuxIYmu6ZYRtwYYGuuVxUIVxN9hqytpwTkM+32xdKbs9HrOefOpx
         VJSZioNMX7HMUZzISplZCHgLVCxc/2p83BXGJ1I5VxCJajGjHCcjVEugvb/wC617bR50
         BUGjn8ZQqbujblALR5EoXxQVSJTeaTkskUwzgdQt7RXbsOV20y+GFXQLGu2QLBRKpA9Z
         MumTIMwCtC8gz9aHA97/Cb9ZZz9beT2ht403TAoYquad7jcELlzS/0A2daD12/JuMUON
         XAgg==
X-Gm-Message-State: AOJu0YwxUpUI4wsMcIB52Zew/GUJhp1UEvMAsJu9BHfCApiFL/mSA4cj
	50VNPwmEpaWWJResVtxsVVI/1GUJGRkGeTd6unoqKIhuF2Pt1PMPYGJiew==
X-Google-Smtp-Source: AGHT+IF6ILD0Y2frfN0K17m2BZ1c8K6ij0z8vqIj7EMGMTF/ZMMqSkq4RL+Fs0k0kZKbX9j6QVzTAg==
X-Received: by 2002:a05:6512:b9d:b0:52b:8255:71d4 with SMTP id 2adb3069b0e04-52b8956093emr1743359e87.3.1717158314158;
        Fri, 31 May 2024 05:25:14 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8ce24d60sm71688e87.290.2024.05.31.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:25:13 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon/core: add 'struct kdamond' abstraction layer
Date: Fri, 31 May 2024 15:23:19 +0300
Message-ID: <20240531122320.909060-2-yorha.op@gmail.com>
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

In current implementation kdamond tracks only 1
context, that is kdamond _is_ damon_ctx what makes
it very difficult to implement multiple contexts.

This patch adds another level of abstraction, that is
'struct kdamond' - structure which represents kdamond itself.
It holds references to all contexts organized in list.

Few fields like ->kdamond_started and ->kdamond_lock
(just ->lock for 'struct kdamond') also has been moved
to 'struct kdamond', because they have nothing to do
with the context itself, but with the whole kdamond
daemon.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 include/linux/damon.h     |  73 ++++++++---
 mm/damon/core.c           | 249 ++++++++++++++++++++++-------------
 mm/damon/lru_sort.c       |  31 +++--
 mm/damon/modules-common.c |  36 +++--
 mm/damon/modules-common.h |   3 +-
 mm/damon/reclaim.c        |  30 +++--
 mm/damon/sysfs.c          | 268 ++++++++++++++++++++++++--------------
 7 files changed, 463 insertions(+), 227 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 886d07294..7cb9979a0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -568,29 +568,49 @@ struct damon_attrs {
 	unsigned long max_nr_regions;
 };
 
+/**
+ * struct kdamond - Represents a background daemon that is responsible
+ * for executing each context.
+ *
+ * @lock:	Kdamond's global lock, serializes accesses to any field.
+ * @self:	Kernel thread which is actually being executed.
+ * @contexts:	Head of contexts (&damon_ctx) list.
+ * @nr_ctxs:	Number of contexts being monitored.
+ *
+ * Each DAMON's background daemon has this structure. Once
+ * configured, daemon can be started by calling damon_start().
+ *
+ * Monitoring can be explicitly stopped by calling damon_stop(). Once
+ * daemon is terminated @self is set to NULL, so users can know if
+ * monitoring is stopped by reading @self pointer. Access to @self
+ * must also be protected by @lock.
+ */
+struct kdamond {
+	struct mutex lock;
+	struct task_struct *self;
+	struct list_head contexts;
+	size_t nr_ctxs;
+
+/* private: */
+	/* for waiting until the execution of the kdamond_fn is started */
+	struct completion kdamond_started;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
  * of the monitoring.
  *
  * @attrs:		Monitoring attributes for accuracy/overhead control.
- * @kdamond:		Kernel thread who does the monitoring.
- * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
+ * @kdamond:		Back reference to daemon who is the owner of this context.
+ * @list:		List head of siblings.
  *
  * For each monitoring context, one kernel thread for the monitoring is
  * created.  The pointer to the thread is stored in @kdamond.
  *
  * Once started, the monitoring thread runs until explicitly required to be
  * terminated or every monitoring target is invalid.  The validity of the
- * targets is checked via the &damon_operations.target_valid of @ops.  The
- * termination can also be explicitly requested by calling damon_stop().
- * The thread sets @kdamond to NULL when it terminates. Therefore, users can
- * know whether the monitoring is ongoing or terminated by reading @kdamond.
- * Reads and writes to @kdamond from outside of the monitoring thread must
- * be protected by @kdamond_lock.
- *
- * Note that the monitoring thread protects only @kdamond via @kdamond_lock.
- * Accesses to other fields must be protected by themselves.
+ * targets is checked via the &damon_operations.target_valid of @ops.
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
@@ -614,12 +634,11 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
-	/* for waiting until the execution of the kdamond_fn is started */
-	struct completion kdamond_started;
+	unsigned long sz_limit;
 
 /* public: */
-	struct task_struct *kdamond;
-	struct mutex kdamond_lock;
+	struct kdamond *kdamond;
+	struct list_head list;
 
 	struct damon_operations ops;
 	struct damon_callback callback;
@@ -653,6 +672,15 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+static inline struct damon_target *damon_first_target(struct damon_ctx *ctx)
+{
+	return list_first_entry(&ctx->adaptive_targets, struct damon_target, list);
+}
+
+static inline struct damon_ctx *damon_first_ctx(struct kdamond *kdamond)
+{
+	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
+}
 
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
@@ -675,6 +703,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damon_for_each_scheme_safe(s, next, ctx) \
 	list_for_each_entry_safe(s, next, &(ctx)->schemes, list)
 
+#define damon_for_each_context(c, kdamond) \
+	list_for_each_entry(c, &(kdamond)->contexts, list)
+
+#define damon_for_each_context_safe(c, next, kdamond) \
+	list_for_each_entry_safe(c, next, &(kdamond)->contexts, list)
+
 #define damos_for_each_quota_goal(goal, quota) \
 	list_for_each_entry(goal, &quota->goals, list)
 
@@ -736,7 +770,12 @@ void damon_destroy_target(struct damon_target *t);
 unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
+void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx);
+struct kdamond *damon_new_kdamond(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
+void damon_destroy_ctxs(struct kdamond *kdamond);
+void damon_destroy_kdamond(struct kdamond *kdamond);
+bool damon_kdamond_running(struct kdamond *kdamond);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
 void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
@@ -758,8 +797,8 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 }
 
 
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_start(struct kdamond *kdamond, bool exclusive);
+int damon_stop(struct kdamond *kdamond);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d503c1c1..cfc9c803d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -24,7 +24,7 @@
 #endif
 
 static DEFINE_MUTEX(damon_lock);
-static int nr_running_ctxs;
+static int nr_running_kdamonds;
 static bool running_exclusive_ctxs;
 
 static DEFINE_MUTEX(damon_ops_lock);
@@ -488,8 +488,6 @@ struct damon_ctx *damon_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
-	init_completion(&ctx->kdamond_started);
-
 	ctx->attrs.sample_interval = 5 * 1000;
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
@@ -499,17 +497,41 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->next_aggregation_sis = 0;
 	ctx->next_ops_update_sis = 0;
 
-	mutex_init(&ctx->kdamond_lock);
-
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
+	INIT_LIST_HEAD(&ctx->list);
 
 	return ctx;
 }
 
+/**
+ * Adds newly allocated and configured @ctx to @kdamond.
+ */
+void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx)
+{
+	list_add_tail(&ctx->list, &kdamond->contexts);
+	++kdamond->nr_ctxs;
+}
+
+struct kdamond *damon_new_kdamond(void)
+{
+	struct kdamond *kdamond;
+
+	kdamond = kzalloc(sizeof(*kdamond), GFP_KERNEL);
+	if (!kdamond)
+		return NULL;
+
+	init_completion(&kdamond->kdamond_started);
+	mutex_init(&kdamond->lock);
+
+	INIT_LIST_HEAD(&kdamond->contexts);
+
+	return kdamond;
+}
+
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next_t;
@@ -523,6 +545,11 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 		damon_destroy_target(t);
 }
 
+static inline void damon_del_ctx(struct damon_ctx *ctx)
+{
+	list_del(&ctx->list);
+}
+
 void damon_destroy_ctx(struct damon_ctx *ctx)
 {
 	struct damos *s, *next_s;
@@ -532,9 +559,27 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme_safe(s, next_s, ctx)
 		damon_destroy_scheme(s);
 
+	damon_del_ctx(ctx);
 	kfree(ctx);
 }
 
+void damon_destroy_ctxs(struct kdamond *kdamond)
+{
+	struct damon_ctx *c, *next;
+
+	damon_for_each_context_safe(c, next, kdamond) {
+		damon_destroy_ctx(c);
+		--kdamond->nr_ctxs;
+	}
+}
+
+void damon_destroy_kdamond(struct kdamond *kdamond)
+{
+	damon_destroy_ctxs(kdamond);
+	mutex_destroy(&kdamond->lock);
+	kfree(kdamond);
+}
+
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
@@ -667,13 +712,27 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
  */
 int damon_nr_running_ctxs(void)
 {
-	int nr_ctxs;
+	int nr_kdamonds;
 
 	mutex_lock(&damon_lock);
-	nr_ctxs = nr_running_ctxs;
+	nr_kdamonds = nr_running_kdamonds;
 	mutex_unlock(&damon_lock);
 
-	return nr_ctxs;
+	return nr_kdamonds;
+}
+
+/**
+ * damon_kdamond_running() - Return true if kdamond is running
+ * false otherwise.
+ */
+bool damon_kdamond_running(struct kdamond *kdamond)
+{
+	bool running;
+
+	mutex_lock(&kdamond->lock);
+	running = kdamond->self != NULL;
+	mutex_unlock(&kdamond->lock);
+	return running;
 }
 
 /* Returns the size upper limit for each monitoring region */
@@ -700,38 +759,37 @@ static int kdamond_fn(void *data);
 
 /*
  * __damon_start() - Starts monitoring with given context.
- * @ctx:	monitoring context
+ * @kdamond:	daemon to be started
  *
  * This function should be called while damon_lock is hold.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int __damon_start(struct damon_ctx *ctx)
+static int __damon_start(struct kdamond *kdamond)
 {
 	int err = -EBUSY;
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (!ctx->kdamond) {
+	mutex_lock(&kdamond->lock);
+	if (!kdamond->self) {
 		err = 0;
-		reinit_completion(&ctx->kdamond_started);
-		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
-				nr_running_ctxs);
-		if (IS_ERR(ctx->kdamond)) {
-			err = PTR_ERR(ctx->kdamond);
-			ctx->kdamond = NULL;
+		reinit_completion(&kdamond->kdamond_started);
+		kdamond->self = kthread_run(kdamond_fn, kdamond, "kdamond.%d",
+				nr_running_kdamonds);
+		if (IS_ERR(kdamond->self)) {
+			err = PTR_ERR(kdamond->self);
+			kdamond->self = NULL;
 		} else {
-			wait_for_completion(&ctx->kdamond_started);
+			wait_for_completion(&kdamond->kdamond_started);
 		}
 	}
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 
 	return err;
 }
 
 /**
  * damon_start() - Starts the monitorings for a given group of contexts.
- * @ctxs:	an array of the pointers for contexts to start monitoring
- * @nr_ctxs:	size of @ctxs
+ * @kdamond:	a daemon that contains list of monitoring contexts
  * @exclusive:	exclusiveness of this contexts group
  *
  * This function starts a group of monitoring threads for a group of monitoring
@@ -743,74 +801,59 @@ static int __damon_start(struct damon_ctx *ctx)
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
+int damon_start(struct kdamond *kdamond, bool exclusive)
 {
-	int i;
 	int err = 0;
 
+	BUG_ON(!kdamond);
+	BUG_ON(!kdamond->nr_ctxs);
+
+	if (kdamond->nr_ctxs != 1)
+		return -EINVAL;
+
 	mutex_lock(&damon_lock);
-	if ((exclusive && nr_running_ctxs) ||
+	if ((exclusive && nr_running_kdamonds) ||
 			(!exclusive && running_exclusive_ctxs)) {
 		mutex_unlock(&damon_lock);
 		return -EBUSY;
 	}
 
-	for (i = 0; i < nr_ctxs; i++) {
-		err = __damon_start(ctxs[i]);
-		if (err)
-			break;
-		nr_running_ctxs++;
-	}
-	if (exclusive && nr_running_ctxs)
+	err = __damon_start(kdamond);
+	if (err)
+		return err;
+	nr_running_kdamonds++;
+
+	if (exclusive && nr_running_kdamonds)
 		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
 
 	return err;
 }
 
-/*
- * __damon_stop() - Stops monitoring of a given context.
- * @ctx:	monitoring context
+/**
+ * damon_stop() - Stops the monitorings for a given group of contexts.
+ * @kdamond:	a daemon (that contains list of monitoring contexts)
+ * to be stopped.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int __damon_stop(struct damon_ctx *ctx)
+int damon_stop(struct kdamond *kdamond)
 {
 	struct task_struct *tsk;
 
-	mutex_lock(&ctx->kdamond_lock);
-	tsk = ctx->kdamond;
+	mutex_lock(&kdamond->lock);
+	tsk = kdamond->self;
 	if (tsk) {
 		get_task_struct(tsk);
-		mutex_unlock(&ctx->kdamond_lock);
+		mutex_unlock(&kdamond->lock);
 		kthread_stop_put(tsk);
 		return 0;
 	}
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_unlock(&kdamond->lock);
 
 	return -EPERM;
 }
 
-/**
- * damon_stop() - Stops the monitorings for a given group of contexts.
- * @ctxs:	an array of the pointers for contexts to stop monitoring
- * @nr_ctxs:	size of @ctxs
- *
- * Return: 0 on success, negative error code otherwise.
- */
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
-{
-	int i, err = 0;
-
-	for (i = 0; i < nr_ctxs; i++) {
-		/* nr_running_ctxs is decremented in kdamond_fn */
-		err = __damon_stop(ctxs[i]);
-		if (err)
-			break;
-	}
-	return err;
-}
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1582,29 +1625,68 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 	}
 }
 
+static bool kdamond_init_ctx(struct damon_ctx *ctx)
+{
+	if (ctx->ops.init)
+		ctx->ops.init(ctx);
+	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
+		return false;
+
+	kdamond_init_intervals_sis(ctx);
+	ctx->sz_limit = damon_region_sz_limit(ctx);
+
+	return true;
+}
+
+static bool kdamond_init_ctxs(struct kdamond *kdamond)
+{
+	struct damon_ctx *c;
+
+	damon_for_each_context(c, kdamond)
+		if (!kdamond_init_ctx(c))
+			return false;
+	return true;
+}
+
+static void kdamond_finish_ctx(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r, *next;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r, t);
+	}
+
+	if (ctx->callback.before_terminate)
+		ctx->callback.before_terminate(ctx);
+	if (ctx->ops.cleanup)
+		ctx->ops.cleanup(ctx);
+}
+
+static void kdamond_finish_ctxs(struct kdamond *kdamond)
+{
+	struct damon_ctx *c;
+
+	damon_for_each_context(c, kdamond)
+		kdamond_finish_ctx(c);
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
 static int kdamond_fn(void *data)
 {
-	struct damon_ctx *ctx = data;
-	struct damon_target *t;
-	struct damon_region *r, *next;
+	struct kdamond *kdamond = data;
+	struct damon_ctx *ctx = damon_first_ctx(kdamond);
 	unsigned int max_nr_accesses = 0;
-	unsigned long sz_limit = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
-	complete(&ctx->kdamond_started);
-	kdamond_init_intervals_sis(ctx);
-
-	if (ctx->ops.init)
-		ctx->ops.init(ctx);
-	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
+	complete(&kdamond->kdamond_started);
+	if (!kdamond_init_ctxs(kdamond))
 		goto done;
 
-	sz_limit = damon_region_sz_limit(ctx);
-
 	while (!kdamond_need_stop(ctx)) {
 		/*
 		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
@@ -1616,6 +1698,7 @@ static int kdamond_fn(void *data)
 		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
+		unsigned long sz_limit = ctx->sz_limit;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -1666,28 +1749,20 @@ static int kdamond_fn(void *data)
 				sample_interval;
 			if (ctx->ops.update)
 				ctx->ops.update(ctx);
-			sz_limit = damon_region_sz_limit(ctx);
+			ctx->sz_limit = damon_region_sz_limit(ctx);
 		}
 	}
 done:
-	damon_for_each_target(t, ctx) {
-		damon_for_each_region_safe(r, next, t)
-			damon_destroy_region(r, t);
-	}
-
-	if (ctx->callback.before_terminate)
-		ctx->callback.before_terminate(ctx);
-	if (ctx->ops.cleanup)
-		ctx->ops.cleanup(ctx);
+	kdamond_finish_ctxs(kdamond);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
-	mutex_lock(&ctx->kdamond_lock);
-	ctx->kdamond = NULL;
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
+	kdamond->self = NULL;
+	mutex_unlock(&kdamond->lock);
 
 	mutex_lock(&damon_lock);
-	nr_running_ctxs--;
-	if (!nr_running_ctxs && running_exclusive_ctxs)
+	nr_running_kdamonds--;
+	if (!nr_running_kdamonds && running_exclusive_ctxs)
 		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a6..76c20098a 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -142,8 +142,18 @@ static struct damos_access_pattern damon_lru_sort_stub_pattern = {
 	.max_age_region = UINT_MAX,
 };
 
-static struct damon_ctx *ctx;
-static struct damon_target *target;
+static struct kdamond *kdamond;
+
+static inline struct damon_ctx *damon_lru_sort_ctx(void)
+{
+	return damon_first_ctx(kdamond);
+}
+
+static inline struct damon_target *damon_lru_sort_target(void)
+{
+	return damon_first_target(
+			damon_lru_sort_ctx());
+}
 
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
@@ -201,6 +211,7 @@ static int damon_lru_sort_apply_parameters(void)
 	struct damos *scheme, *hot_scheme, *cold_scheme;
 	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
 	unsigned int hot_thres, cold_thres;
+	struct damon_ctx *ctx = damon_lru_sort_ctx();
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
@@ -237,7 +248,8 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(ctx, &hot_scheme, 1);
 	damon_add_scheme(ctx, cold_scheme);
 
-	return damon_set_region_biggest_system_ram_default(target,
+	return damon_set_region_biggest_system_ram_default(
+					damon_lru_sort_target(),
 					&monitor_region_start,
 					&monitor_region_end);
 }
@@ -247,7 +259,7 @@ static int damon_lru_sort_turn(bool on)
 	int err;
 
 	if (!on) {
-		err = damon_stop(&ctx, 1);
+		err = damon_stop(kdamond);
 		if (!err)
 			kdamond_pid = -1;
 		return err;
@@ -257,10 +269,11 @@ static int damon_lru_sort_turn(bool on)
 	if (err)
 		return err;
 
-	err = damon_start(&ctx, 1, true);
+	err = damon_start(kdamond, true);
 	if (err)
 		return err;
-	kdamond_pid = ctx->kdamond->pid;
+
+	kdamond_pid = kdamond->self->pid;
 	return 0;
 }
 
@@ -279,7 +292,7 @@ static int damon_lru_sort_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!kdamond)
 		goto set_param_out;
 
 	err = damon_lru_sort_turn(enable);
@@ -334,11 +347,13 @@ static int damon_lru_sort_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_lru_sort_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	struct damon_ctx *ctx;
+	int err = damon_modules_new_paddr_kdamond(&kdamond);
 
 	if (err)
 		return err;
 
+	ctx = damon_lru_sort_ctx();
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
 
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 7cf96574c..436bb7948 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -9,13 +9,7 @@
 
 #include "modules-common.h"
 
-/*
- * Allocate, set, and return a DAMON context for the physical address space.
- * @ctxp:	Pointer to save the point to the newly created context
- * @targetp:	Pointer to save the point to the newly created target
- */
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+static int __damon_modules_new_paddr_kdamond(struct kdamond *kdamond)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -34,9 +28,33 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 		damon_destroy_ctx(ctx);
 		return -ENOMEM;
 	}
+
 	damon_add_target(ctx, target);
+	damon_add_ctx(kdamond, ctx);
+
+	return 0;
+}
+
+/*
+ * Allocate, set, and return a DAMON daemon for the physical address space.
+ * @kdamondp:	Pointer to save the point to the newly created kdamond
+ */
+int damon_modules_new_paddr_kdamond(struct kdamond **kdamondp)
+{
+	int err;
+	struct kdamond *kdamond;
+
+	kdamond = damon_new_kdamond();
+	if (!kdamond)
+		return -ENOMEM;
+
+	err = __damon_modules_new_paddr_kdamond(kdamond);
+	if (err) {
+		damon_destroy_kdamond(kdamond);
+		return err;
+	}
+	kdamond->nr_ctxs = 1;
 
-	*ctxp = ctx;
-	*targetp = target;
+	*kdamondp = kdamond;
 	return 0;
 }
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417..5fc5b8ae3 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -45,5 +45,4 @@
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
 
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp);
+int damon_modules_new_paddr_kdamond(struct kdamond **kdamondp);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9bd341d62..f6540ef1a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -150,8 +150,18 @@ static struct damos_stat damon_reclaim_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
 
-static struct damon_ctx *ctx;
-static struct damon_target *target;
+static struct kdamond *kdamond;
+
+static inline struct damon_ctx *damon_reclaim_ctx(void)
+{
+	return damon_first_ctx(kdamond);
+}
+
+static inline struct damon_target *damon_reclaim_target(void)
+{
+	return damon_first_target(
+			damon_reclaim_ctx());
+}
 
 static struct damos *damon_reclaim_new_scheme(void)
 {
@@ -197,6 +207,7 @@ static int damon_reclaim_apply_parameters(void)
 	struct damos *scheme, *old_scheme;
 	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
+	struct damon_ctx *ctx = damon_reclaim_ctx();
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -244,7 +255,8 @@ static int damon_reclaim_apply_parameters(void)
 	}
 	damon_set_schemes(ctx, &scheme, 1);
 
-	return damon_set_region_biggest_system_ram_default(target,
+	return damon_set_region_biggest_system_ram_default(
+					damon_reclaim_target(),
 					&monitor_region_start,
 					&monitor_region_end);
 }
@@ -254,7 +266,7 @@ static int damon_reclaim_turn(bool on)
 	int err;
 
 	if (!on) {
-		err = damon_stop(&ctx, 1);
+		err = damon_stop(kdamond);
 		if (!err)
 			kdamond_pid = -1;
 		return err;
@@ -264,10 +276,10 @@ static int damon_reclaim_turn(bool on)
 	if (err)
 		return err;
 
-	err = damon_start(&ctx, 1, true);
+	err = damon_start(kdamond, true);
 	if (err)
 		return err;
-	kdamond_pid = ctx->kdamond->pid;
+	kdamond_pid = kdamond->self->pid;
 	return 0;
 }
 
@@ -286,7 +298,7 @@ static int damon_reclaim_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!kdamond)
 		goto set_param_out;
 
 	err = damon_reclaim_turn(enable);
@@ -337,11 +349,13 @@ static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_reclaim_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	struct damon_ctx *ctx;
+	int err = damon_modules_new_paddr_kdamond(&kdamond);
 
 	if (err)
 		return err;
 
+	ctx = damon_reclaim_ctx();
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6fee383bc..bfdb979e6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -939,7 +939,7 @@ static const struct kobj_type damon_sysfs_contexts_ktype = {
 struct damon_sysfs_kdamond {
 	struct kobject kobj;
 	struct damon_sysfs_contexts *contexts;
-	struct damon_ctx *damon_ctx;
+	struct kdamond *kdamond;
 };
 
 static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
@@ -974,16 +974,6 @@ static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
 	kobject_put(&kdamond->contexts->kobj);
 }
 
-static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
-{
-	bool running;
-
-	mutex_lock(&ctx->kdamond_lock);
-	running = ctx->kdamond != NULL;
-	mutex_unlock(&ctx->kdamond_lock);
-	return running;
-}
-
 /*
  * enum damon_sysfs_cmd - Commands for a specific kdamond.
  */
@@ -1065,15 +1055,15 @@ static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+	struct damon_sysfs_kdamond *sys_kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct kdamond *kdamond = sys_kdamond->kdamond;
 	bool running;
 
-	if (!ctx)
+	if (!kdamond)
 		running = false;
 	else
-		running = damon_sysfs_ctx_running(ctx);
+		running = damon_kdamond_running(kdamond);
 
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
@@ -1242,13 +1232,15 @@ static bool damon_sysfs_schemes_regions_updating;
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
-	struct damon_sysfs_kdamond *kdamond;
+	struct damon_sysfs_kdamond *sys_kdamond;
+	struct kdamond *kdamond;
 	enum damon_sysfs_cmd cmd;
 
 	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
-	kdamond = damon_sysfs_cmd_request.kdamond;
+	kdamond = ctx->kdamond;
+	sys_kdamond = damon_sysfs_cmd_request.kdamond;
 	cmd = damon_sysfs_cmd_request.cmd;
-	if (kdamond && ctx == kdamond->damon_ctx &&
+	if (sys_kdamond && kdamond == sys_kdamond->kdamond &&
 			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
 			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES) &&
 			damon_sysfs_schemes_regions_updating) {
@@ -1260,12 +1252,12 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
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
 }
 
 /*
@@ -1277,55 +1269,91 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
  * callbacks while holding ``damon_syfs_lock``, to safely access the DAMON
  * contexts-internal data and DAMON sysfs variables.
  */
-static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	damon_sysfs_schemes_update_stats(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+
+	sysfs_ctxs = sys_kdamond->contexts->contexts_arr;
+	damon_for_each_context(c, sys_kdamond->kdamond) {
+		struct damon_sysfs_context *sysfs_ctx = *sysfs_ctxs;
+
+		damon_sysfs_schemes_update_stats(sysfs_ctx->schemes, c);
+		++sysfs_ctxs;
+	}
 	return 0;
 }
 
 static int damon_sysfs_upd_schemes_regions_start(
-		struct damon_sysfs_kdamond *kdamond, bool total_bytes_only)
+		struct damon_sysfs_kdamond *sys_kdamond, bool total_bytes_only)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
+	int err;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	return damon_sysfs_schemes_update_regions_start(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx,
-			total_bytes_only);
+
+	sysfs_ctxs = sys_kdamond->contexts->contexts_arr;
+	damon_for_each_context(c, sys_kdamond->kdamond) {
+		struct damon_sysfs_context *sysfs_ctx = *sysfs_ctxs;
+
+		err = damon_sysfs_schemes_update_regions_start(sysfs_ctx->schemes, c,
+							       total_bytes_only);
+		if (err)
+			return err;
+		++sysfs_ctxs;
+	}
+	return 0;
 }
 
 static int damon_sysfs_upd_schemes_regions_stop(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *c;
+	int err;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	return damon_sysfs_schemes_update_regions_stop(ctx);
+
+	damon_for_each_context(c, sys_kdamond->kdamond) {
+		err = damon_sysfs_schemes_update_regions_stop(c);
+		if (err)
+			return err;
+	}
+	return 0;
 }
 
 static int damon_sysfs_clear_schemes_regions(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
+	int err;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	return damon_sysfs_schemes_clear_regions(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+
+	sysfs_ctxs = sys_kdamond->contexts->contexts_arr;
+	damon_for_each_context(c, sys_kdamond->kdamond) {
+		struct damon_sysfs_context *sysfs_ctx = *sysfs_ctxs;
+
+		err = damon_sysfs_schemes_clear_regions(sysfs_ctx->schemes, c);
+		if (err)
+			return err;
+		++sysfs_ctxs;
+	}
+	return 0;
 }
 
 static inline bool damon_sysfs_kdamond_running(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	return kdamond->damon_ctx &&
-		damon_sysfs_ctx_running(kdamond->damon_ctx);
+	return sys_kdamond->kdamond &&
+		damon_kdamond_running(sys_kdamond->kdamond);
 }
 
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
@@ -1351,23 +1379,34 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
  *
  * If the sysfs input is wrong, the kdamond will be terminated.
  */
-static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *sys_kdamond)
 {
-	if (!damon_sysfs_kdamond_running(kdamond))
+	struct damon_ctx *c;
+	struct damon_sysfs_context *sysfs_ctx;
+	int err;
+
+	if (!damon_sysfs_kdamond_running(sys_kdamond))
 		return -EINVAL;
 	/* TODO: Support multiple contexts per kdamond */
-	if (kdamond->contexts->nr != 1)
+	if (sys_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	return damon_sysfs_apply_inputs(kdamond->damon_ctx,
-			kdamond->contexts->contexts_arr[0]);
+	sysfs_ctx = sys_kdamond->contexts->contexts_arr[0];
+	damon_for_each_context(c, sys_kdamond->kdamond) {
+		err = damon_sysfs_apply_inputs(c, sysfs_ctx);
+		if (err)
+			return err;
+		++sysfs_ctx;
+	}
+	return 0;
 }
 
 static int damon_sysfs_commit_schemes_quota_goals(
 		struct damon_sysfs_kdamond *sysfs_kdamond)
 {
-	struct damon_ctx *ctx;
-	struct damon_sysfs_context *sysfs_ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
+	int err;
 
 	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
 		return -EINVAL;
@@ -1375,9 +1414,16 @@ static int damon_sysfs_commit_schemes_quota_goals(
 	if (sysfs_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	ctx = sysfs_kdamond->damon_ctx;
-	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
-	return damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
+	sysfs_ctxs = sysfs_kdamond->contexts->contexts_arr;
+	damon_for_each_context(c, sysfs_kdamond->kdamond) {
+		struct damon_sysfs_context *sysfs_ctx = *sysfs_ctxs;
+
+		err = damos_sysfs_set_quota_scores(sysfs_ctx->schemes, c);
+		if (err)
+			return err;
+		++sysfs_ctxs;
+	}
+	return 0;
 }
 
 /*
@@ -1391,14 +1437,21 @@ static int damon_sysfs_commit_schemes_quota_goals(
  * DAMON contexts-internal data and DAMON sysfs variables.
  */
 static int damon_sysfs_upd_schemes_effective_quotas(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	damos_sysfs_update_effective_quotas(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+
+	sysfs_ctxs = sys_kdamond->contexts->contexts_arr;
+	damon_for_each_context(c, sys_kdamond->kdamond) {
+		struct damon_sysfs_context *sysfs_ctx = *sysfs_ctxs;
+
+		damos_sysfs_update_effective_quotas(sysfs_ctx->schemes, c);
+		++sysfs_ctxs;
+	}
 	return 0;
 }
 
@@ -1415,7 +1468,7 @@ static int damon_sysfs_upd_schemes_effective_quotas(
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 		bool after_aggregation)
 {
-	struct damon_sysfs_kdamond *kdamond;
+	struct damon_sysfs_kdamond *sys_kdamond;
 	bool total_bytes_only = false;
 	int err = 0;
 
@@ -1423,27 +1476,27 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 	if (!damon_sysfs_schemes_regions_updating &&
 			!mutex_trylock(&damon_sysfs_lock))
 		return 0;
-	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (!kdamond || kdamond->damon_ctx != c)
+	sys_kdamond = damon_sysfs_cmd_request.kdamond;
+	if (!sys_kdamond || !c || sys_kdamond->kdamond != c->kdamond)
 		goto out;
 	switch (damon_sysfs_cmd_request.cmd) {
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
-		err = damon_sysfs_upd_schemes_stats(kdamond);
+		err = damon_sysfs_upd_schemes_stats(sys_kdamond);
 		break;
 	case DAMON_SYSFS_CMD_COMMIT:
 		if (!after_aggregation)
 			goto out;
-		err = damon_sysfs_commit_input(kdamond);
+		err = damon_sysfs_commit_input(sys_kdamond);
 		break;
 	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
-		err = damon_sysfs_commit_schemes_quota_goals(kdamond);
+		err = damon_sysfs_commit_schemes_quota_goals(sys_kdamond);
 		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
 		total_bytes_only = true;
 		fallthrough;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
 		if (!damon_sysfs_schemes_regions_updating) {
-			err = damon_sysfs_upd_schemes_regions_start(kdamond,
+			err = damon_sysfs_upd_schemes_regions_start(sys_kdamond,
 					total_bytes_only);
 			if (!err) {
 				damon_sysfs_schemes_regions_updating = true;
@@ -1458,15 +1511,15 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 			 */
 			if (active && !damos_sysfs_regions_upd_done())
 				goto keep_lock_out;
-			err = damon_sysfs_upd_schemes_regions_stop(kdamond);
+			err = damon_sysfs_upd_schemes_regions_stop(sys_kdamond);
 			damon_sysfs_schemes_regions_updating = false;
 		}
 		break;
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
-		err = damon_sysfs_clear_schemes_regions(kdamond);
+		err = damon_sysfs_clear_schemes_regions(sys_kdamond);
 		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
-		err = damon_sysfs_upd_schemes_effective_quotas(kdamond);
+		err = damon_sysfs_upd_schemes_effective_quotas(sys_kdamond);
 		break;
 	default:
 		break;
@@ -1529,40 +1582,63 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	return ctx;
 }
 
-static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
+static struct kdamond *damon_sysfs_build_kdamond(
+		struct damon_sysfs_context **sys_ctx, size_t nr_ctxs)
 {
 	struct damon_ctx *ctx;
+	struct kdamond *kdamond;
+
+	kdamond = damon_new_kdamond();
+	if (!kdamond)
+		return ERR_PTR(-ENOMEM);
+
+	for (size_t i = 0; i < nr_ctxs; ++i) {
+		ctx = damon_sysfs_build_ctx(sys_ctx[i]);
+		if (IS_ERR(ctx)) {
+			damon_destroy_kdamond(kdamond);
+			return ERR_PTR(PTR_ERR(ctx));
+		}
+		ctx->kdamond = kdamond;
+		damon_add_ctx(kdamond, ctx);
+	}
+	return kdamond;
+}
+
+static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *sys_kdamond)
+{
+	struct kdamond *kdamond;
 	int err;
 
-	if (damon_sysfs_kdamond_running(kdamond))
+	if (damon_sysfs_kdamond_running(sys_kdamond))
 		return -EBUSY;
-	if (damon_sysfs_cmd_request.kdamond == kdamond)
+	if (damon_sysfs_cmd_request.kdamond == sys_kdamond)
 		return -EBUSY;
 	/* TODO: support multiple contexts per kdamond */
-	if (kdamond->contexts->nr != 1)
+	if (sys_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	if (kdamond->damon_ctx)
-		damon_destroy_ctx(kdamond->damon_ctx);
-	kdamond->damon_ctx = NULL;
+	if (sys_kdamond->kdamond)
+		damon_destroy_kdamond(sys_kdamond->kdamond);
+	sys_kdamond->kdamond = NULL;
 
-	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
-	err = damon_start(&ctx, 1, false);
+	kdamond = damon_sysfs_build_kdamond(sys_kdamond->contexts->contexts_arr,
+					    sys_kdamond->contexts->nr);
+	if (IS_ERR(kdamond))
+		return PTR_ERR(kdamond);
+	err = damon_start(kdamond, false);
 	if (err) {
-		damon_destroy_ctx(ctx);
+		damon_destroy_kdamond(kdamond);
 		return err;
 	}
-	kdamond->damon_ctx = ctx;
+	sys_kdamond->kdamond = kdamond;
 	return err;
 }
 
-static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *sys_kdamond)
 {
-	if (!kdamond->damon_ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	return damon_stop(&kdamond->damon_ctx, 1);
+	return damon_stop(sys_kdamond->kdamond);
 	/*
 	 * To allow users show final monitoring results of already turned-off
 	 * DAMON, we free kdamond->damon_ctx in next
@@ -1654,21 +1730,21 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t pid_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+	struct damon_sysfs_kdamond *sys_kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx;
+	struct kdamond *kdamond;
 	int pid = -1;
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
-	ctx = kdamond->damon_ctx;
-	if (!ctx)
+	kdamond = sys_kdamond->kdamond;
+	if (!kdamond)
 		goto out;
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond)
-		pid = ctx->kdamond->pid;
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
+	if (kdamond->self)
+		pid = kdamond->self->pid;
+	mutex_unlock(&kdamond->lock);
 out:
 	mutex_unlock(&damon_sysfs_lock);
 	return sysfs_emit(buf, "%d\n", pid);
@@ -1676,12 +1752,12 @@ static ssize_t pid_show(struct kobject *kobj,
 
 static void damon_sysfs_kdamond_release(struct kobject *kobj)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+	struct damon_sysfs_kdamond *sys_kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
 
-	if (kdamond->damon_ctx)
-		damon_destroy_ctx(kdamond->damon_ctx);
-	kfree(kdamond);
+	if (sys_kdamond->kdamond)
+		damon_destroy_kdamond(sys_kdamond->kdamond);
+	kfree(sys_kdamond);
 }
 
 static struct kobj_attribute damon_sysfs_kdamond_state_attr =
-- 
2.42.0

