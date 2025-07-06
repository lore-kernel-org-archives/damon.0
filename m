Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274F2BCF41;
	Sun,  6 Jul 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832026; cv=none; b=rIMtTg6eayOm3DIlqzNXoMrywz1LDcWIVn46WAyP3ncuCCm/J291BZ33rFCNMlDZ/yCL7sDkI0fQKEQKUX6dtDYpvkycsP4ARTWswI6r0ieWt3r0bn3sV50O/w2Tl4oDPXrpup6cNRUcZFZnQXbaslEi5k/RMHsbSNPINKLXj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832026; c=relaxed/simple;
	bh=xngwQdJg9SStMpbSeT2i8ZuPCcHFD5n4yxQZU8owQpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lr5t0WtwHMQI4xQvewuYol0CArlJ7qfjFoam8hnLMPrV1+7C8TOd4519g8suM1n9AWT9mtQYR47gWGjvCs/WeA3aoCoEOF5wPqY22jjZGKhxcnpHyuTGUzASfdi6JV2SWbIiWmiyH5ipJeUV2tRUv6FbEw3Zg+5hsYiKNzGOj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onb/X5Br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onb/X5Br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CA4C4CEED;
	Sun,  6 Jul 2025 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832026;
	bh=xngwQdJg9SStMpbSeT2i8ZuPCcHFD5n4yxQZU8owQpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Onb/X5BrLg4E4ya9P6ulS89sPP4Wf3LCW6Wvr0VaxdepBIEJ6oHsCTtcztCm87EjM
	 irMxBSOse6pE15vyf1MZcQYCN6T2Xtvmsy1mng+bHPAd6yi9z+exFbFVufLywVrpR2
	 aIIaWYfG4Ch/cHncNLxLhynnGtyRVxQ0GiPxtmaL5Vxfb8PFTAUhjk73xln6imMnDR
	 llK+1H9jIIuyRFbnvgEunMo+namHX+txHLpC/1/LVDaxaPtWwCTWSQyyJ8VJYLtsP0
	 Bz8Jsd9iDFItTMcviDCr4AhVTJOHFTp0cbpzTROESQmYCql3VU6bTZPTrD4pSwXffo
	 Q+JWtYYMZzJ5w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/14] mm/damon: accept parallel damon_call() requests
Date: Sun,  6 Jul 2025 13:00:05 -0700
Message-Id: <20250706200018.42704-2-sj@kernel.org>
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
index accd45f203cd..9176a1c7d5a8 100644
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
index 45c237ade8cf..01e62bdcdd67 100644
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
@@ -1353,14 +1354,11 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
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
@@ -2379,11 +2377,11 @@ static void kdamond_usleep(unsigned long usecs)
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
@@ -2393,21 +2391,24 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
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
