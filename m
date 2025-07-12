Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A028D8F2;
	Sat, 12 Jul 2025 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349822; cv=none; b=G/6x6uxV1Zjfc7vwMOGeDfoSg9xXGDlEPN42xEWTYOrs+FWaYiIGDx+/iMCgzlmfxcIZ+KaP9zs5xo5CIPbJJZTFT3FMPN5wW/ULIiOc6/BgTvYj5TuH4eZ1LYgh+I335+in6SoWW3CKFGMSYf4647gTFVxzV0yhFj0dHDJrmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349822; c=relaxed/simple;
	bh=JQzHUCo6E86SNxkHiwVE3u7TqJ48m1u5XQT+KNsWP+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQtF4BNV62rzehQa3uSdNWQHfLvZQpYDWnuLE3wEONu3abNnUvihzt4N2JtHJS03ldahlKSMBgIW/qphviz1h4U3wbe9bLcRFfoMdsW/xTAwl1XEi32Ko9l12IIYmaCvtX4AUcshjxahXeHp4tcqvD0VSWBHvWxDdT1u6Moej6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0tX2vnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0tX2vnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3772BC4CEEF;
	Sat, 12 Jul 2025 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349821;
	bh=JQzHUCo6E86SNxkHiwVE3u7TqJ48m1u5XQT+KNsWP+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0tX2vnZvDL78oHqrWl4XfFPryieDDWOCjoRhH6amuntAiXHntNr8T0qLl8KNKmi/
	 JTE1i/Lp9CTrR7iv4tibfJF/5dyCcTIRWZ2p0BP/AgJzsQmkHwU4FPA5ZoRkR6ZRwp
	 VPYju7t0X3AakzFacunJto2cws3sivEGWD4KXlaVbkpz8OHdEHnuYb1sJb+ILv7Scm
	 HqLKG9rsF92ztUSnC5Ec/0jm6vwSbHjuEUa5f7o0kf/ApI5ARfc9zhZhxWy1g+c1mJ
	 Lkn9/LGNRGzjyCG1FQ7V7NucTYJG35NVq00e43Ge62zFvc4w69UJ2cgt77krVUYjiA
	 Ud0TMwFlW2aXA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/14] mm/damon: accept parallel damon_call() requests
Date: Sat, 12 Jul 2025 12:50:03 -0700
Message-Id: <20250712195016.151108-2-sj@kernel.org>
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

Calling damon_call() while it is serving for another parallel thread
immediately fails with -EBUSY.  The caller should call it again, later.
Each caller implementing such retry logic would be redundant.  Accept
parallel damon_call() requests and do the wait instead of the caller.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  7 +++++--
 mm/damon/core.c       | 49 ++++++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1f425d830bb9..562c7876ba88 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -673,6 +673,8 @@ struct damon_call_control {
 	struct completion completion;
 	/* informs if the kdamond canceled @fn infocation */
 	bool canceled;
+	/* List head for siblings. */
+	struct list_head list;
 };
 
 /**
@@ -798,8 +800,9 @@ struct damon_ctx {
 	/* for scheme quotas prioritization */
 	unsigned long *regions_score_histogram;
 
-	struct damon_call_control *call_control;
-	struct mutex call_control_lock;
+	/* lists of &struct damon_call_control */
+	struct list_head call_controls;
+	struct mutex call_controls_lock;
 
 	struct damos_walk_control *walk_control;
 	struct mutex walk_control_lock;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2714a7a023db..b0a0b98f6889 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -533,7 +533,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->next_ops_update_sis = 0;
 
 	mutex_init(&ctx->kdamond_lock);
-	mutex_init(&ctx->call_control_lock);
+	INIT_LIST_HEAD(&ctx->call_controls);
+	mutex_init(&ctx->call_controls_lock);
 	mutex_init(&ctx->walk_control_lock);
 
 	ctx->attrs.min_nr_regions = 10;
@@ -1393,14 +1394,11 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 {
 	init_completion(&control->completion);
 	control->canceled = false;
+	INIT_LIST_HEAD(&control->list);
 
-	mutex_lock(&ctx->call_control_lock);
-	if (ctx->call_control) {
-		mutex_unlock(&ctx->call_control_lock);
-		return -EBUSY;
-	}
-	ctx->call_control = control;
-	mutex_unlock(&ctx->call_control_lock);
+	mutex_lock(&ctx->call_controls_lock);
+	list_add_tail(&ctx->call_controls, &control->list);
+	mutex_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
 		return -EINVAL;
 	wait_for_completion(&control->completion);
@@ -2419,11 +2417,11 @@ static void kdamond_usleep(unsigned long usecs)
 }
 
 /*
- * kdamond_call() - handle damon_call_control.
+ * kdamond_call() - handle damon_call_control objects.
  * @ctx:	The &struct damon_ctx of the kdamond.
  * @cancel:	Whether to cancel the invocation of the function.
  *
- * If there is a &struct damon_call_control request that registered via
+ * If there are &struct damon_call_control requests that registered via
  * &damon_call() on @ctx, do or cancel the invocation of the function depending
  * on @cancel.  @cancel is set when the kdamond is already out of the main loop
  * and therefore will be terminated.
@@ -2433,21 +2431,24 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 	struct damon_call_control *control;
 	int ret = 0;
 
-	mutex_lock(&ctx->call_control_lock);
-	control = ctx->call_control;
-	mutex_unlock(&ctx->call_control_lock);
-	if (!control)
-		return;
-	if (cancel) {
-		control->canceled = true;
-	} else {
-		ret = control->fn(control->data);
-		control->return_code = ret;
+	while (true) {
+		mutex_lock(&ctx->call_controls_lock);
+		control = list_first_entry_or_null(&ctx->call_controls,
+				struct damon_call_control, list);
+		mutex_unlock(&ctx->call_controls_lock);
+		if (!control)
+			return;
+		if (cancel) {
+			control->canceled = true;
+		} else {
+			ret = control->fn(control->data);
+			control->return_code = ret;
+		}
+		mutex_lock(&ctx->call_controls_lock);
+		list_del(&control->list);
+		mutex_unlock(&ctx->call_controls_lock);
+		complete(&control->completion);
 	}
-	complete(&control->completion);
-	mutex_lock(&ctx->call_control_lock);
-	ctx->call_control = NULL;
-	mutex_unlock(&ctx->call_control_lock);
 }
 
 /* Returns negative error code if it's not activated but should return */
-- 
2.39.5
