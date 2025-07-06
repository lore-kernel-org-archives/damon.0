Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E42BD01E;
	Sun,  6 Jul 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832027; cv=none; b=B42E/K+5zV2umMr6y22iLHwgqHo8QNlWEglI1sgyNSW8qiW8nwfKe8NQ1jIXG7n7qw7yOxsEDNOxM7UDKLs+vxAL2mldgJI/F0ICQ/GAFje3yBHHDD++UXsDXr9BkG2UXt8S8Nnl6kRWvDxO5P/sEeUuSIdNzNeuYr5UF6IEf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832027; c=relaxed/simple;
	bh=5isUX/qdRWz6RuSCLUkT6PmSqq6/sjQX47PJKxk/1f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4O0ypmZpTOKGUe25XCMKQP5EWfrrF2hmul9DmuGFT/noKZGJJcuNNklTztQwC/JdXOrPGnou4Ns88l7ua1QOlIu5Tk98rYHSrdwUPQkLo3aoHEcqxnLCSkzZrhsY7oFLf4ax0g8I0VklMQ4qUFx0jerzmY0i1y/HNT5Surh7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVFVqjHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVFVqjHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA7DC4CEF3;
	Sun,  6 Jul 2025 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832027;
	bh=5isUX/qdRWz6RuSCLUkT6PmSqq6/sjQX47PJKxk/1f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVFVqjHu6ZkO7yJPWtOZqMA6G9AjWhKGP0HBTOzvLejArhKM0PiTXlmvWo82MLve9
	 CbF7gJxWPPUB87pIZ+b2UU77a7LzhLY1eSKGrO9D+jjxliS630HbmFlbbbv/t8XVki
	 feq7AUbvIxI7icwwZXFPFFNq8YICq8Zrvm6KBM5ZTmCDyKRw8LV+3omANvexbWHrMi
	 p19qWsrp8EOE25923yMHww+e6dMStquIt4jAIGSX1NR7OLP1LuGI2lnJZKIrqH/5sq
	 8k7+fWo5ZXMYyODZvAfyt4gzf2rawoB9JYmPG7uluGBw6jykwwJ0Zdb3qXj1WS9IDY
	 12OmR6OqAzc+w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/14] mm/damon/core: introduce repeat mode damon_call()
Date: Sun,  6 Jul 2025 13:00:06 -0700
Message-Id: <20250706200018.42704-3-sj@kernel.org>
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

damon_call() can be useful for reading or writing DAMON internal data
for one time.  A common pattern of DAMON core usage from DAMON modules
is doing such reads and writes repeatedly, for example, to periodically
update the DAMOS stats.  To do that with damon_call(), callers should
call damon_call() repeatedly, with their own delay loop.  Each caller
doing that is repetitive.  Introduce a repeat mode damon_call().
Callers can use the mode by setting a new field in damon_call_control.
If the mode is turned on, damon_call() returns success immediately, and
DAMON repeats invoking the callback function inside the kdamond main
loop.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9176a1c7d5a8..2d51b575d660 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -659,6 +659,7 @@ struct damon_callback {
  *
  * @fn:			Function to be called back.
  * @data:		Data that will be passed to @fn.
+ * @repeat:		Repeat invocations.
  * @return_code:	Return code from @fn invocation.
  *
  * Control damon_call(), which requests specific kdamond to invoke a given
@@ -667,6 +668,7 @@ struct damon_callback {
 struct damon_call_control {
 	int (*fn)(void *data);
 	void *data;
+	bool repeat;
 	int return_code;
 /* private: internal use only */
 	/* informs if the kdamond finished handling of the request */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 01e62bdcdd67..7a4dc76dd023 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1339,8 +1339,9 @@ bool damon_is_running(struct damon_ctx *ctx)
  *
  * Ask DAMON worker thread (kdamond) of @ctx to call a function with an
  * argument data that respectively passed via &damon_call_control->fn and
- * &damon_call_control->data of @control, and wait until the kdamond finishes
- * handling of the request.
+ * &damon_call_control->data of @control.  If &damon_call_control->repeat of
+ * @control is set, further wait until the kdamond finishes handling of the
+ * request.  Otherwise, return as soon as the request is made.
  *
  * The kdamond executes the function with the argument in the main loop, just
  * after a sampling of the iteration is finished.  The function can hence
@@ -1352,7 +1353,8 @@ bool damon_is_running(struct damon_ctx *ctx)
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 {
-	init_completion(&control->completion);
+	if (!control->repeat)
+		init_completion(&control->completion);
 	control->canceled = false;
 	INIT_LIST_HEAD(&control->list);
 
@@ -1361,6 +1363,8 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	mutex_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
 		return -EINVAL;
+	if (control->repeat)
+		return 0;
 	wait_for_completion(&control->completion);
 	if (control->canceled)
 		return -ECANCELED;
@@ -2389,6 +2393,7 @@ static void kdamond_usleep(unsigned long usecs)
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
 	struct damon_call_control *control;
+	LIST_HEAD(repeat_controls);
 	int ret = 0;
 
 	while (true) {
@@ -2407,8 +2412,18 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 		mutex_lock(&ctx->call_controls_lock);
 		list_del(&control->list);
 		mutex_unlock(&ctx->call_controls_lock);
-		complete(&control->completion);
+		if (!control->repeat)
+			complete(&control->completion);
+		else
+			list_add(&control->list, &repeat_controls);
 	}
+	control = list_first_entry_or_null(&repeat_controls,
+			struct damon_call_control, list);
+	if (!control || cancel)
+		return;
+	mutex_lock(&ctx->call_controls_lock);
+	list_add_tail(&control->list, &ctx->call_controls);
+	mutex_unlock(&ctx->call_controls_lock);
 }
 
 /* Returns negative error code if it's not activated but should return */
-- 
2.39.5
