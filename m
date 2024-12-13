Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67385197512;
	Fri, 13 Dec 2024 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126800; cv=none; b=QHz6NtsLV0iM8j/So4lB6F1AYQMGY0qu/vSafrL93XjQwSBCJy2MqA6TIRdBlWaQX9W1VKJ0f+WpToQr3hyCXrfFupKAdrJDoh1Yp0tpdVckUYCbLXUpvw9QICWLx4+DZe4MOA9WoRuSJm/t4yOkIIV1onjd0WSyhzSKUIsEtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126800; c=relaxed/simple;
	bh=CuegZeDM4FxKE/fdac0FkRb85mikc51KmPkJxxesedI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJGP21GynPJR68RghVIUeFRCm3bPh4y4qQ+jFtgG4fMTZjycQjuhkFjPpkZKBkA7AxKP9SrMgmU+8J2RkVXy+k9vRgp/o4QLU3thO4UF3kG/5VtdBj+B/hyBvbBrgVEt3T2MzmlgBalv1MP7pXxZmqIrmqKXcF06TNTcsKdfqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Hv9Kwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Hv9Kwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C1C4CED6;
	Fri, 13 Dec 2024 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126800;
	bh=CuegZeDM4FxKE/fdac0FkRb85mikc51KmPkJxxesedI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7Hv9Kwf5zS9WP/rJRXgSfMY+UFevhNx7vSTcspG6xNCHaSbxxbX2m3bTvmne9I0G
	 BEvAeYFmxKA621fItAOJdn4kpDz0A4qUQUeXuluyldhTqUnDKw7BwOuVF8wFUfs6Yl
	 3Cl5lVBeiP4uU7Rq9MSLiaMXsTNTIls70NWqvi+EcxgSt7vlJ5IYqBrWStt0jb/5VJ
	 7xaL2ZIRyCgzR5tL2wNDcrbyHFcGZs9+rQ3CQFLgF2c5x7vl7hljZaNitST7UlmboJ
	 eSj3i3dA2IJNvIsqZYMVBY0Inj6CPul/Wu5Q1UoFb3hKd+ZAPBjyzbsXV+zkcXZlkd
	 gUqLS67FqgmNQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/9] mm/damon/core: implement damon_call()
Date: Fri, 13 Dec 2024 13:53:00 -0800
Message-Id: <20241213215306.54778-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213215306.54778-1-sj@kernel.org>
References: <20241213215306.54778-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new DAMON core API function, damon_call().  It aims to
replace some damon_callback usages that access damon_ctx of ongoing
kdamond with additional synchronizations.  It receives a function
pointer, let the parallel kdamond invokes the function, and returns
after the invocation is finished, or canceled due to some races.

kdamond invokes the function inside the main loop after sampling is
done.  If it is deactivated by DAMOS watermarks or already out of the
main loop, mark the request as canceled so that damon_call() can wakeup
and return.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 26 +++++++++++++
 mm/damon/core.c       | 86 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 10fc6df52111..529ea578f2d5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -590,6 +590,27 @@ struct damon_callback {
 	void (*before_terminate)(struct damon_ctx *context);
 };
 
+/*
+ * struct damon_call_control - Control damon_call().
+ *
+ * @fn:			Function to be called back.
+ * @data:		Data that will be passed to @fn.
+ * @return_code:	Return code from @fn invocation.
+ *
+ * Control damon_call(), which requests specific kdamond to invoke a given
+ * function.  Refer to damon_call() for more details.
+ */
+struct damon_call_control {
+	int (*fn)(void *data);
+	void *data;
+	int return_code;
+/* private: internal use only */
+	/* informs if the kdamond finished handling of the request */
+	struct completion completion;
+	/* informs if the kdamond canceled @fn infocation */
+	bool canceled;
+};
+
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
@@ -670,6 +691,9 @@ struct damon_ctx {
 	/* for scheme quotas prioritization */
 	unsigned long *regions_score_histogram;
 
+	struct damon_call_control *call_control;
+	struct mutex call_control_lock;
+
 /* public: */
 	struct task_struct *kdamond;
 	struct mutex kdamond_lock;
@@ -817,6 +841,8 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
+int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
+
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index bf04987a91c6..89a679c06e30 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -533,6 +533,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->next_ops_update_sis = 0;
 
 	mutex_init(&ctx->kdamond_lock);
+	mutex_init(&ctx->call_control_lock);
 
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
@@ -1183,6 +1184,54 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
+static bool damon_is_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+	return running;
+}
+
+/**
+ * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
+ * @ctx:	DAMON context to call the function for.
+ * @control:	Control variable of the call request.
+ *
+ * Ask DAMON worker thread (kdamond) of @ctx to call a function with an
+ * argument data that respectively passed via &damon_call_control->fn and
+ * &damon_call_control->data of @control, and wait until the kdamond finishes
+ * handling of the request.
+ *
+ * The kdamond executes the function with the argument in the main loop, just
+ * after a sampling of the iteration is finished.  The function can hence
+ * safely access the internal data of the &struct damon_ctx without additional
+ * synchronization.  The return value of the function will be saved in
+ * &damon_call_control->return_code.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
+{
+	init_completion(&control->completion);
+	control->canceled = false;
+
+	mutex_lock(&ctx->call_control_lock);
+	if (ctx->call_control) {
+		mutex_unlock(&ctx->call_control_lock);
+		return -EBUSY;
+	}
+	ctx->call_control = control;
+	mutex_unlock(&ctx->call_control_lock);
+	if (!damon_is_running(ctx))
+		return -EINVAL;
+	wait_for_completion(&control->completion);
+	if (control->canceled)
+		return -ECANCELED;
+	return 0;
+}
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1970,6 +2019,39 @@ static void kdamond_usleep(unsigned long usecs)
 		usleep_range_idle(usecs, usecs + 1);
 }
 
+/*
+ * kdamond_call() - handle damon_call_control.
+ * @ctx:	The &struct damon_ctx of the kdamond.
+ * @cancel:	Whether to cancel the invocation of the function.
+ *
+ * If there is a &struct damon_call_control request that registered via
+ * &damon_call() on @ctx, do or cancel the invocation of the function depending
+ * on @cancel.  @cancel is set when the kdamond is deactivated by DAMOS
+ * watermarks, or the kdamond is already out of the main loop and therefore
+ * will be terminated.
+ */
+static void kdamond_call(struct damon_ctx *ctx, bool cancel)
+{
+	struct damon_call_control *control;
+	int ret = 0;
+
+	mutex_lock(&ctx->call_control_lock);
+	control = ctx->call_control;
+	mutex_unlock(&ctx->call_control_lock);
+	if (!control)
+		return;
+	if (cancel) {
+		control->canceled = true;
+	} else {
+		ret = control->fn(control->data);
+		control->return_code = ret;
+	}
+	complete(&control->completion);
+	mutex_lock(&ctx->call_control_lock);
+	ctx->call_control = NULL;
+	mutex_unlock(&ctx->call_control_lock);
+}
+
 /* Returns negative error code if it's not activated but should return */
 static int kdamond_wait_activation(struct damon_ctx *ctx)
 {
@@ -1994,6 +2076,7 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 		if (ctx->callback.after_wmarks_check &&
 				ctx->callback.after_wmarks_check(ctx))
 			break;
+		kdamond_call(ctx, true);
 	}
 	return -EBUSY;
 }
@@ -2065,6 +2148,7 @@ static int kdamond_fn(void *data)
 		if (ctx->callback.after_sampling &&
 				ctx->callback.after_sampling(ctx))
 			break;
+		kdamond_call(ctx, false);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
@@ -2126,6 +2210,8 @@ static int kdamond_fn(void *data)
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
 
+	kdamond_call(ctx, true);
+
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
 	if (!nr_running_ctxs && running_exclusive_ctxs)
-- 
2.39.5

