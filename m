Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59D15575A
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786715; cv=none; b=jASPwQwZAjf28FhxVP0hKoZfWnl3ypfLfnwreT/SMBjQ0uP2wPU34komi0Y9pGG7yhCFuqETwK1rlJeUtNx4ifo2qlIlSTsC3RqSbyvYQGIkyEIsR/0AffYwet+HpRdTi1RbD4rzEr1W2T7W/+UbNg+Ze5V/btg9/s7RmsOzx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786715; c=relaxed/simple;
	bh=9e70Vrim5jIcqTp3CcouWXIv4MNXQnMHbq5cxZTOGoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkE9FCpVgBQ0D4PwiSKbDobFHP9KEnWqh2MY2tl2SugKoXYQMaZp2aD4weFHgzdErK7/ZApnQWwr0sboI2vBawd6aqAyIToBQJfHBPbNSf2ThSXaunze4eRiUXGEPuihyabL7xwuLD4GA5pOKC88vuuPMOEzYfjxHhX//92PZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqM+94PY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqM+94PY"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f0602bc58so7019338e87.0
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786711; x=1716391511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/O5vmUEibrKREO3bDjzq4AlG9EFIs64uAChXha0KuQ=;
        b=EqM+94PYYWz8uGEPdgq7c3Ye8r9timipWRq9zMNkxUf/dycxpKp1+QFylBY5ZEnfKQ
         t3Pxts70lBP7sy5umS6Xs8DhcujucTE1AkLtHGBVIu/tn1m0DVtGxllPk7hw8n1dKVQs
         m7nZILFVNZY5v235TJQ0yEOFIU1KTgEkXbZrTkt0a1Q5HX00wo7BefNVbRPrZKAAS3g2
         y9N2ehI9oDdt37A1VspwCdNx3brGEjHc8b3hnXvbdVMHhVbSYoGCFcb5oS06N7g1OFJ7
         4MyESlRzXCuBn4AHL2iCk6F+hQzZ1SZY167s1u2aiuCo9mtFfJJ1vhq+U2kErnxeUFci
         +fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786711; x=1716391511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/O5vmUEibrKREO3bDjzq4AlG9EFIs64uAChXha0KuQ=;
        b=aGbeeDeEDqeMxSGpfn80E4b0bglAwI1sHS2FphBdNgxaDrpdpxT/qk8h8Fr0heMmxI
         vtV8bWsbjZdrVQhqCwG91lt2osGly1c/wSo1m1gkMjzkXtS6HHPIN6Jg6G1FMWVnsV3q
         VFDI2TvinBV+gtPeqiN4EVl5oRbMXMg17h/apuCn6jt/VxklgywyXLPJgTriwuHrc8MI
         YHkqxBJtqthq+KQnNKLeGgIpnipAx0Mehn5yg3aGFBANDPJrz+Wb874c3hZC9NjHvG9H
         tKFO0GZ+j9GmG3GadvPkr9Gs1u/W33ssHFDSF9/wPie8Oz3zmbHbA2XvY5drT3wPkxxI
         0iMQ==
X-Gm-Message-State: AOJu0YyDe2XmXRfJgq3zycomqa4th4/BK6OwsT/9OounH0ORZFqn3QEV
	x+/QmasKL0ZmOWAU0+WzQvkHw+NLt2n5xsjMQPz/sM7g938Zkg7cFz17wg==
X-Google-Smtp-Source: AGHT+IEkMfb6LR27OO0jborcGALWBrLm5UV3kS6fecAu/yxiUhrzZ3mmwD2joGJfM+wsbaWAfVAJYg==
X-Received: by 2002:ac2:4d15:0:b0:51d:7d4a:517e with SMTP id 2adb3069b0e04-521e0c44819mr6115847e87.9.1715786710584;
        Wed, 15 May 2024 08:25:10 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:10 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 2/7] mm/damon/core: list-based contexts organization
Date: Wed, 15 May 2024 18:24:52 +0300
Message-ID: <20240515152457.603724-3-yorha.op@gmail.com>
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

This patch implements list-based approach to manage
damon contexts, described in previous patch.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 include/linux/damon.h |  22 ++++++-
 mm/damon/core.c       |  98 ++++++++++++++++++++++-------
 mm/damon/sysfs.c      | 140 ++++++++++++++++++++++++++++++------------
 3 files changed, 197 insertions(+), 63 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 089d4a9cf..ec291a2eb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -571,8 +571,7 @@ struct damon_attrs {
 struct kdamond_struct {
 	struct mutex lock;
 	struct task_struct *self;
-	/* TODO: support multiple contexts */
-	struct damon_ctx *ctx;
+	struct list_head contexts;
 	size_t nr_ctxs;
 
 /* private: */
@@ -626,9 +625,11 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
+	unsigned long sz_limit;
 
 /* public: */
 	struct kdamond_struct *kdamond;
+	struct list_head list;
 
 	struct damon_operations ops;
 	struct damon_callback callback;
@@ -662,6 +663,15 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+static inline struct damon_target *damon_first_target(struct damon_ctx *ctx)
+{
+	return list_first_entry(&ctx->adaptive_targets, struct damon_target, list);
+}
+
+static inline struct damon_ctx *damon_first_ctx(struct kdamond_struct *kdamond)
+{
+	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
+}
 
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
@@ -684,6 +694,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
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
 
@@ -745,8 +761,10 @@ void damon_destroy_target(struct damon_target *t);
 unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
+void damon_add_ctx(struct kdamond_struct *kdamond, struct damon_ctx *ctx);
 struct kdamond_struct *damon_new_kdamond(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
+void damon_destroy_ctxs(struct kdamond_struct *kdamond);
 void damon_destroy_kdamond(struct kdamond_struct *kdamond);
 bool damon_kdamond_running(struct kdamond_struct *kdamond);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b592a2865..899487f38 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -502,10 +502,17 @@ struct damon_ctx *damon_new_ctx(void)
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
+	INIT_LIST_HEAD(&ctx->list);
 
 	return ctx;
 }
 
+void damon_add_ctx(struct kdamond_struct *kdamond, struct damon_ctx *ctx)
+{
+	list_add_tail(&ctx->list, &kdamond->contexts);
+	++kdamond->nr_ctxs;
+}
+
 struct kdamond_struct *damon_new_kdamond(void)
 {
 	struct kdamond_struct *kdamond;
@@ -517,6 +524,8 @@ struct kdamond_struct *damon_new_kdamond(void)
 	init_completion(&kdamond->kdamond_started);
 	mutex_init(&kdamond->lock);
 
+	INIT_LIST_HEAD(&kdamond->contexts);
+
 	return kdamond;
 }
 
@@ -533,6 +542,11 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
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
@@ -542,12 +556,21 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme_safe(s, next_s, ctx)
 		damon_destroy_scheme(s);
 
+	damon_del_ctx(ctx);
 	kfree(ctx);
 }
 
+void damon_destroy_ctxs(struct kdamond_struct *kdamond)
+{
+	struct damon_ctx *c, *next;
+
+	damon_for_each_context_safe(c, next, kdamond)
+		damon_destroy_ctx(c);
+}
+
 void damon_destroy_kdamond(struct kdamond_struct *kdamond)
 {
-	damon_destroy_ctx(kdamond->ctx);
+	damon_destroy_ctxs(kdamond);
 	mutex_destroy(&kdamond->lock);
 	kfree(kdamond);
 }
@@ -1596,30 +1619,68 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
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
+static bool kdamond_init_ctxs(struct kdamond_struct *kdamond)
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
+static void kdamond_finish_ctxs(struct kdamond_struct *kdamond)
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
 	struct kdamond_struct *kdamond = data;
-	struct damon_ctx *ctx = kdamond->ctx;
-	struct damon_target *t;
-	struct damon_region *r, *next;
+	struct damon_ctx *ctx = damon_first_ctx(kdamond);
 	unsigned int max_nr_accesses = 0;
-	unsigned long sz_limit = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
 	complete(&kdamond->kdamond_started);
-	kdamond_init_intervals_sis(ctx);
-
-	if (ctx->ops.init)
-		ctx->ops.init(ctx);
-	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
+	if (!kdamond_init_ctxs(kdamond))
 		goto done;
 
-	sz_limit = damon_region_sz_limit(ctx);
-
 	while (!kdamond_need_stop(ctx)) {
 		/*
 		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
@@ -1631,6 +1692,7 @@ static int kdamond_fn(void *data)
 		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
+		unsigned long sz_limit = ctx->sz_limit;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -1681,19 +1743,11 @@ static int kdamond_fn(void *data)
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
 	mutex_lock(&kdamond->lock);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c55c0b200..db2d48361 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1271,46 +1271,82 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
  */
 static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	damon_sysfs_schemes_update_stats(
-			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx);
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
 		struct damon_sysfs_kdamond *sys_kdamond, bool total_bytes_only)
 {
-	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
+	int err;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	return damon_sysfs_schemes_update_regions_start(
-			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx,
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
 		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
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
 		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
+	int err;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	return damon_sysfs_schemes_clear_regions(
-			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx);
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
@@ -1345,21 +1381,32 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
  */
 static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *sys_kdamond)
 {
+	struct damon_ctx *c;
+	struct damon_sysfs_context *sysfs_ctx;
+	int err;
+
 	if (!damon_sysfs_kdamond_running(sys_kdamond))
 		return -EINVAL;
 	/* TODO: Support multiple contexts per kdamond */
 	if (sys_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	return damon_sysfs_apply_inputs(sys_kdamond->kdamond->ctx,
-			sys_kdamond->contexts->contexts_arr[0]);
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
@@ -1367,9 +1414,16 @@ static int damon_sysfs_commit_schemes_quota_goals(
 	if (sysfs_kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	ctx = sysfs_kdamond->kdamond->ctx;
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
@@ -1385,12 +1439,19 @@ static int damon_sysfs_commit_schemes_quota_goals(
 static int damon_sysfs_upd_schemes_effective_quotas(
 		struct damon_sysfs_kdamond *sys_kdamond)
 {
-	struct damon_ctx *ctx = sys_kdamond->kdamond->ctx;
+	struct damon_ctx *c;
+	struct damon_sysfs_context **sysfs_ctxs;
 
-	if (!ctx)
+	if (!sys_kdamond->kdamond)
 		return -EINVAL;
-	damos_sysfs_update_effective_quotas(
-			sys_kdamond->contexts->contexts_arr[0]->schemes, ctx);
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
 
@@ -1522,24 +1583,24 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 }
 
 static struct kdamond_struct *damon_sysfs_build_kdamond(
-		struct damon_sysfs_context *sys_ctx)
+		struct damon_sysfs_context **sys_ctx, size_t nr_ctxs)
 {
 	struct damon_ctx *ctx;
-	struct kdamond_struct *kdamond = damon_new_kdamond();
+	struct kdamond_struct *kdamond;
 
+	kdamond = damon_new_kdamond();
 	if (!kdamond)
 		return ERR_PTR(-ENOMEM);
 
-	ctx = damon_sysfs_build_ctx(sys_ctx);
-	if (IS_ERR(ctx)) {
-		damon_destroy_kdamond(kdamond);
-		return ERR_PTR(PTR_ERR(ctx));
+	for (size_t i = 0; i < nr_ctxs; ++i) {
+		ctx = damon_sysfs_build_ctx(sys_ctx[i]);
+		if (IS_ERR(ctx)) {
+			damon_destroy_kdamond(kdamond);
+			return ERR_PTR(PTR_ERR(ctx));
+		}
+		ctx->kdamond = kdamond;
+		damon_add_ctx(kdamond, ctx);
 	}
-	ctx->kdamond = kdamond;
-
-	kdamond->ctx = ctx;
-	kdamond->nr_ctxs = 1;
-
 	return kdamond;
 }
 
@@ -1560,7 +1621,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *sys_kdamond)
 		damon_destroy_kdamond(sys_kdamond->kdamond);
 	sys_kdamond->kdamond = NULL;
 
-	kdamond = damon_sysfs_build_kdamond(sys_kdamond->contexts->contexts_arr[0]);
+	kdamond = damon_sysfs_build_kdamond(sys_kdamond->contexts->contexts_arr,
+					    sys_kdamond->contexts->nr);
 	if (IS_ERR(kdamond))
 		return PTR_ERR(kdamond);
 	err = damon_start(kdamond, false);
-- 
2.42.0

