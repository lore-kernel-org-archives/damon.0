Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65F15573E
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786714; cv=none; b=t4EXQ2a6YuRxKgFkyct1w/rM5DzmnezCrGB8iQwGFozSrhhpauDk0UdzGKbpNJloWOysKMhcE6Ud1g405FKXoF8nk5CPCQvYpCCcOTQPbMQoEMHrnjZdwMRz6LocIoux0fnc52OTffIth4/HsLdkZGZ0Q3b9XtKgOiGoINXYifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786714; c=relaxed/simple;
	bh=F8r1BqFaFs+GbwujB084oSFOgZhXTcgcVdT344sJA6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saEIVH7IHN3OzWHnLbMn9arbQv3dIosE8IRcd/y0WWuRldg/42wjAk50YD2kzidf/8GNrkVVcyjyeQGZMvIrlZFzizidUOFqV7S/gKDmbXBJ65ODxT6ac/Y+2CM+DZ3stYxobXZBc5LIEIVwUavQPdGknqXtG+zwOAbt8kZuWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZdfErKU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZdfErKU"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f40b5e059so8389146e87.0
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786710; x=1716391510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzasYJfRqKciwCdQnL9VFAj+OYJ4tl4r2d31KURnjAM=;
        b=GZdfErKUugwkP6a8+2du211rK7LenMVxiJ6Aj4Jt1sANvTJG6AzHg50h/ibfsdruI6
         10PmGmK3rIxUHV3C9cZ/Fz+bYpzjJ9ZhHqhwSimCdZtSxtVhRAnHzAIqji8E7ew8ZlQ2
         1tgCrDFLr5cwWX36T4qMDTrJeZda38XgWgo0AUFglY1ye+g1x/9jzDQn2AKz2lBE0ody
         9Yhqbzewysf3t7ddUmXUoQ3DmC1E2eEzw+7sQ9zBmq9llSTxoKkbcIz7jFJg8ToqbuAE
         ig/aM9PRDl/LM4/Zd1YnCZtJ3Efh2ti98sizskaqmX0vlUMht6vPqNdArSH+bVgvdScj
         SCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786710; x=1716391510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzasYJfRqKciwCdQnL9VFAj+OYJ4tl4r2d31KURnjAM=;
        b=ZP8/HBT47Ovgg7VfinXuWINxkkEeX/yqqnPUReGY+Qgc5aH8BmFuctUHVlSziEjm2R
         BK5LUnDMo7yMdv3BGQbG0NzXADax93rg3apsMUVIOYt07pvL9tTX8KvoQDTmT0epiqHC
         YNEq4kQZpLFIbMCCTtZuAAFGW3Ofacxs10t75HLMZF9R101NBIvz28RDJvlKFVe6XAj3
         lLog78M1DbGg479zW5WxaFvuyTu7F8isJPjo6iI8jHaSSEw5pBlaYq3yhH5sNPOsI8Z1
         T2MC/lV7zZtPF4hcKhMdSQEzsdOYqHgliU3Uba68egpqsjnQNN83qvDGKIBhyDeZCWEz
         FumQ==
X-Gm-Message-State: AOJu0YzIX14Su0lqeAA6Cy6fGpugfRN45XsTkudONBpY5LQPSgFrapIm
	ZfF6wY/lbw4ciJfGMjGHO5BdY9IAYgvG4+niwtS81LrC0qc5PEpmDLuBzw==
X-Google-Smtp-Source: AGHT+IHrRZ/rrcrXOi5t23sx+kBnyPeoD8EKz4Dfrh8zcQ7OG0scMGSB/selwKkHx3jkdqJNmyODLw==
X-Received: by 2002:ac2:5331:0:b0:523:96ad:51a8 with SMTP id 2adb3069b0e04-52396ad5348mr1375417e87.7.1715786709500;
        Wed, 15 May 2024 08:25:09 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:08 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 1/7] mm/damon/core: kdamond_struct abstraction layer
Date: Wed, 15 May 2024 18:24:51 +0300
Message-ID: <20240515152457.603724-2-yorha.op@gmail.com>
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

In current implementation kdamond tracks only 1
context, that is kdamond _is_ damon_ctx what makes
it very difficult to implement multiple contexts.

This patch adds another level of abstraction, that is
kdamond_struct - structure which represents kdamond itself.
It holds references to all contexts organized in list.

Few fields like ->kdamond_started and ->kdamond_lock
(just ->lock for kdamond_struct) also has been moved
to kdamond_struct, because they have nothing to do
with the context itself, but with the whole kdamond
daemon.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 include/linux/damon.h |  24 ++++--
 mm/damon/core.c       | 125 +++++++++++++++++-------------
 mm/damon/sysfs.c      | 176 +++++++++++++++++++++++-------------------
 3 files changed, 183 insertions(+), 142 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 886d07294..089d4a9cf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -568,6 +568,18 @@ struct damon_attrs {
 	unsigned long max_nr_regions;
 };
 
+struct kdamond_struct {
+	struct mutex lock;
+	struct task_struct *self;
+	/* TODO: support multiple contexts */
+	struct damon_ctx *ctx;
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
@@ -614,12 +626,9 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
-	/* for waiting until the execution of the kdamond_fn is started */
-	struct completion kdamond_started;
 
 /* public: */
-	struct task_struct *kdamond;
-	struct mutex kdamond_lock;
+	struct kdamond_struct *kdamond;
 
 	struct damon_operations ops;
 	struct damon_callback callback;
@@ -736,7 +745,10 @@ void damon_destroy_target(struct damon_target *t);
 unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
+struct kdamond_struct *damon_new_kdamond(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
+void damon_destroy_kdamond(struct kdamond_struct *kdamond);
+bool damon_kdamond_running(struct kdamond_struct *kdamond);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
 void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
@@ -758,8 +770,8 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 }
 
 
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_start(struct kdamond_struct *kdamond, bool exclusive);
+int damon_stop(struct kdamond_struct *kdamond);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d503c1c1..b592a2865 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -488,8 +488,6 @@ struct damon_ctx *damon_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
-	init_completion(&ctx->kdamond_started);
-
 	ctx->attrs.sample_interval = 5 * 1000;
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
@@ -499,8 +497,6 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->next_aggregation_sis = 0;
 	ctx->next_ops_update_sis = 0;
 
-	mutex_init(&ctx->kdamond_lock);
-
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
@@ -510,6 +506,20 @@ struct damon_ctx *damon_new_ctx(void)
 	return ctx;
 }
 
+struct kdamond_struct *damon_new_kdamond(void)
+{
+	struct kdamond_struct *kdamond;
+
+	kdamond = kzalloc(sizeof(*kdamond), GFP_KERNEL);
+	if (!kdamond)
+		return NULL;
+
+	init_completion(&kdamond->kdamond_started);
+	mutex_init(&kdamond->lock);
+
+	return kdamond;
+}
+
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next_t;
@@ -535,6 +545,13 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	kfree(ctx);
 }
 
+void damon_destroy_kdamond(struct kdamond_struct *kdamond)
+{
+	damon_destroy_ctx(kdamond->ctx);
+	mutex_destroy(&kdamond->lock);
+	kfree(kdamond);
+}
+
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
@@ -676,6 +693,20 @@ int damon_nr_running_ctxs(void)
 	return nr_ctxs;
 }
 
+/**
+ * damon_kdamond_running() - Return true if kdamond is running
+ * false otherwise.
+ */
+bool damon_kdamond_running(struct kdamond_struct *kdamond)
+{
+	bool running;
+
+	mutex_lock(&kdamond->lock);
+	running = kdamond->self != NULL;
+	mutex_unlock(&kdamond->lock);
+	return running;
+}
+
 /* Returns the size upper limit for each monitoring region */
 static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 {
@@ -706,24 +737,24 @@ static int kdamond_fn(void *data);
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int __damon_start(struct damon_ctx *ctx)
+static int __damon_start(struct kdamond_struct *kdamond)
 {
 	int err = -EBUSY;
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (!ctx->kdamond) {
+	mutex_lock(&kdamond->lock);
+	if (!kdamond->self) {
 		err = 0;
-		reinit_completion(&ctx->kdamond_started);
-		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
+		reinit_completion(&kdamond->kdamond_started);
+		kdamond->self = kthread_run(kdamond_fn, kdamond, "kdamond.%d",
 				nr_running_ctxs);
-		if (IS_ERR(ctx->kdamond)) {
-			err = PTR_ERR(ctx->kdamond);
-			ctx->kdamond = NULL;
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
@@ -743,11 +774,16 @@ static int __damon_start(struct damon_ctx *ctx)
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
+int damon_start(struct kdamond_struct *kdamond, bool exclusive)
 {
-	int i;
 	int err = 0;
 
+	BUG_ON(!kdamond);
+	BUG_ON(!kdamon->nr_ctxs);
+
+	if (kdamond->nr_ctxs != 1)
+		return -EINVAL;
+
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_ctxs) ||
 			(!exclusive && running_exclusive_ctxs)) {
@@ -755,12 +791,11 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 		return -EBUSY;
 	}
 
-	for (i = 0; i < nr_ctxs; i++) {
-		err = __damon_start(ctxs[i]);
-		if (err)
-			break;
-		nr_running_ctxs++;
-	}
+	err = __damon_start(kdamond);
+	if (err)
+		return err;
+	nr_running_ctxs++;
+
 	if (exclusive && nr_running_ctxs)
 		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
@@ -768,49 +803,28 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	return err;
 }
 
-/*
- * __damon_stop() - Stops monitoring of a given context.
- * @ctx:	monitoring context
+/**
+ * damon_stop() - Stops the monitorings for a given group of contexts.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int __damon_stop(struct damon_ctx *ctx)
+int damon_stop(struct kdamond_struct *kdamond)
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
@@ -1587,7 +1601,8 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
  */
 static int kdamond_fn(void *data)
 {
-	struct damon_ctx *ctx = data;
+	struct kdamond_struct *kdamond = data;
+	struct damon_ctx *ctx = kdamond->ctx;
 	struct damon_target *t;
 	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
@@ -1595,7 +1610,7 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
-	complete(&ctx->kdamond_started);
+	complete(&kdamond->kdamond_started);
 	kdamond_init_intervals_sis(ctx);
 
 	if (ctx->ops.init)
@@ -1681,9 +1696,9 @@ static int kdamond_fn(void *data)
 		ctx->ops.cleanup(ctx);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
-	mutex_lock(&ctx->kdamond_lock);
-	ctx->kdamond = NULL;
-	mutex_unlock(&ctx->kdamond_lock);
+	mutex_lock(&kdamond->lock);
+	kdamond->self = NULL;
+	mutex_unlock(&kdamond->lock);
 
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6fee383bc..c55c0b200 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -939,7 +939,7 @@ static const struct kobj_type damon_sysfs_contexts_ktype = {
 struct damon_sysfs_kdamond {
 	struct kobject kobj;
 	struct damon_sysfs_contexts *contexts;
-	struct damon_ctx *damon_ctx;
+	struct kdamond_struct *kdamond;
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
+	struct kdamond_struct *kdamond = sys_kdamond->kdamond;
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
+	struct kdamond_struct *kdamond;
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
@@ -1277,33 +1269,33 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
  * callbacks while holding ``damon_syfs_lock``, to safely access the DAMON
  * contexts-internal data and DAMON sysfs variables.
  */
-static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
 
 	if (!ctx)
 		return -EINVAL;
 	damon_sysfs_schemes_update_stats(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
 }
 
 static int damon_sysfs_upd_schemes_regions_start(
-		struct damon_sysfs_kdamond *kdamond, bool total_bytes_only)
+		struct damon_sysfs_kdamond *sys_kdamond, bool total_bytes_only)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
 
 	if (!ctx)
 		return -EINVAL;
 	return damon_sysfs_schemes_update_regions_start(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx,
+			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx,
 			total_bytes_only);
 }
 
 static int damon_sysfs_upd_schemes_regions_stop(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
 
 	if (!ctx)
 		return -EINVAL;
@@ -1311,21 +1303,21 @@ static int damon_sysfs_upd_schemes_regions_stop(
 }
 
 static int damon_sysfs_clear_schemes_regions(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
 
 	if (!ctx)
 		return -EINVAL;
 	return damon_sysfs_schemes_clear_regions(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx);
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
@@ -1351,16 +1343,16 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
  *
  * If the sysfs input is wrong, the kdamond will be terminated.
  */
-static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *sys_kdamond)
 {
-	if (!damon_sysfs_kdamond_running(kdamond))
+	if (!damon_sysfs_kdamond_running(sys_kdamond))
 		return -EINVAL;
 	/* TODO: Support multiple contexts per kdamond */
-	if (kdamond->contexts->nr != 1)
+	if (sys_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	return damon_sysfs_apply_inputs(kdamond->damon_ctx,
-			kdamond->contexts->contexts_arr[0]);
+	return damon_sysfs_apply_inputs(sys_kdamond->kdamond->ctx,
+			sys_kdamond->contexts->contexts_arr[0]);
 }
 
 static int damon_sysfs_commit_schemes_quota_goals(
@@ -1375,7 +1367,7 @@ static int damon_sysfs_commit_schemes_quota_goals(
 	if (sysfs_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	ctx = sysfs_kdamond->damon_ctx;
+	ctx = sysfs_kdamond->kdamond->ctx;
 	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
 	return damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
 }
@@ -1391,14 +1383,14 @@ static int damon_sysfs_commit_schemes_quota_goals(
  * DAMON contexts-internal data and DAMON sysfs variables.
  */
 static int damon_sysfs_upd_schemes_effective_quotas(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
 
 	if (!ctx)
 		return -EINVAL;
 	damos_sysfs_update_effective_quotas(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
 }
 
@@ -1415,7 +1407,7 @@ static int damon_sysfs_upd_schemes_effective_quotas(
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 		bool after_aggregation)
 {
-	struct damon_sysfs_kdamond *kdamond;
+	struct damon_sysfs_kdamond *sys_kdamond;
 	bool total_bytes_only = false;
 	int err = 0;
 
@@ -1423,27 +1415,27 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
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
@@ -1458,15 +1450,15 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
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
@@ -1529,40 +1521,62 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	return ctx;
 }
 
-static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
+static struct kdamond_struct *damon_sysfs_build_kdamond(
+		struct damon_sysfs_context *sys_ctx)
 {
 	struct damon_ctx *ctx;
+	struct kdamond_struct *kdamond = damon_new_kdamond();
+
+	if (!kdamond)
+		return ERR_PTR(-ENOMEM);
+
+	ctx = damon_sysfs_build_ctx(sys_ctx);
+	if (IS_ERR(ctx)) {
+		damon_destroy_kdamond(kdamond);
+		return ERR_PTR(PTR_ERR(ctx));
+	}
+	ctx->kdamond = kdamond;
+
+	kdamond->ctx = ctx;
+	kdamond->nr_ctxs = 1;
+
+	return kdamond;
+}
+
+static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *sys_kdamond)
+{
+	struct kdamond_struct *kdamond;
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
+	kdamond = damon_sysfs_build_kdamond(sys_kdamond->contexts->contexts_arr[0]);
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
@@ -1654,21 +1668,21 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t pid_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+	struct damon_sysfs_kdamond *sys_kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx;
+	struct kdamond_struct *kdamond;
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
@@ -1676,12 +1690,12 @@ static ssize_t pid_show(struct kobject *kobj,
 
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

