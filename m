Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712928DF50;
	Sat, 12 Jul 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349822; cv=none; b=B+iuvLNH7rRFzA4ydVylXD3xdT4GOtefbjEHVnjGzFYHOl52jBCIaDD8qLkVLqkBqZlMMpfq3RQQrQlkC/gLhwMrlcSCWw4rDiR5IjTmqI6PopK6PPx8/rfu5ibjpDhwt+titY2HmBg71s96Y1Y2g5+aWPCctcFPPPeFLgx5rHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349822; c=relaxed/simple;
	bh=OtU+NRyCIh0C5uwTmklBNfReGv9IlgGR+JKEfON4Vh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/EJNmmxB5/7tP0b26ZbF3Ku4m7ig3GedLhl/hWN4Kv8t+hUK2v0Ewyv4jWOWZl8xGU9vWObxGuXRbE4R5c35xn6urVnpsjwTTuXMY2awHLwh01diTEXw+D+q3cKizdIuJoh3+P+zbJ20YIZkfmspXu3O3KpoPSPa9hj6AdYUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evOAGIJS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evOAGIJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46295C4CEEF;
	Sat, 12 Jul 2025 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349822;
	bh=OtU+NRyCIh0C5uwTmklBNfReGv9IlgGR+JKEfON4Vh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evOAGIJSbKOfOxDLbqgOJsH3hGip86AqldafX8BSdrC5/Knp7Y1ygDTUGjExVRe8G
	 ZAB3SrqhBChhKnYkASVe6TFRB06jtG1JpvNu4nB8FXLl77hFOqV96oKGZno+fSsC5H
	 zCLa7V0y4yWVNT21+/kVlYbhOnAJmxaPfolF/XAwk6LPMyESEoVLsKEHstH72pAh8C
	 hlsakP6Df8On06CAh9p8hZ7W67q0hK+TaBH+7mVLoKH3xdn0j0K/Afm2/9qf3MHw6+
	 SpeLDPTBxZxdeogCyKebfYwTvxbONKQC0oFx1dzSzDiJE2YJshbERtlu7d9GIXe1HT
	 xDMWYWQU8v31A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/14] mm/damon/core: introduce repeat mode damon_call()
Date: Sat, 12 Jul 2025 12:50:04 -0700
Message-Id: <20250712195016.151108-3-sj@kernel.org>
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
 mm/damon/core.c       | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 562c7876ba88..b83987275ff9 100644
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
index b0a0b98f6889..ffb87497dbb5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1379,8 +1379,9 @@ bool damon_is_running(struct damon_ctx *ctx)
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
@@ -1392,7 +1393,8 @@ bool damon_is_running(struct damon_ctx *ctx)
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 {
-	init_completion(&control->completion);
+	if (!control->repeat)
+		init_completion(&control->completion);
 	control->canceled = false;
 	INIT_LIST_HEAD(&control->list);
 
@@ -1401,6 +1403,8 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	mutex_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
 		return -EINVAL;
+	if (control->repeat)
+		return 0;
 	wait_for_completion(&control->completion);
 	if (control->canceled)
 		return -ECANCELED;
@@ -2429,6 +2433,7 @@ static void kdamond_usleep(unsigned long usecs)
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
 	struct damon_call_control *control;
+	LIST_HEAD(repeat_controls);
 	int ret = 0;
 
 	while (true) {
@@ -2437,7 +2442,7 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 				struct damon_call_control, list);
 		mutex_unlock(&ctx->call_controls_lock);
 		if (!control)
-			return;
+			break;
 		if (cancel) {
 			control->canceled = true;
 		} else {
@@ -2447,8 +2452,18 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
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
