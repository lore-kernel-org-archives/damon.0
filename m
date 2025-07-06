Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC327453;
	Sun,  6 Jul 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832029; cv=none; b=fRtd2xQVyDWFXsfONjxkk0nExJrmO0o6TfYEZZfI6AmTBB2E0ezafzTMmIzg3OHnH6bnIzkHxQb918C/JTwTjCJCVTodqN30wB4gePbW2qEI98vnKLiuCP7glaXLzH0OWbSsmjcPI90zcX1LOA2WgLYZu930IL+nurSsYjZ9MtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832029; c=relaxed/simple;
	bh=fAIXtGREPARQvCC1/X313DQcYGh4YYVNrncF7IRNX5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/yHlFoy5pESgQyQuF/8zSNGR1frb5slyipReNPGB/+aIwra6oqdFcoxmxan0sZDx9aEHOlriHFBNjMnPl70pnCVViNgNPpJ+EYLkC8znhwhDVPoUdGaR+LzFnACC9yATa3A3TalyzUmzil6SHq5xv949brtmN8YABbpC/Bt3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXdaIZkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXdaIZkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B73C4CEF1;
	Sun,  6 Jul 2025 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832029;
	bh=fAIXtGREPARQvCC1/X313DQcYGh4YYVNrncF7IRNX5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXdaIZkNlkgZ1r227EoMFkd/phUYdd18Gs4t6OMVdKw9jA/2XC8RQwJT54vFPN+3g
	 pWlz8hbAcTv/weQ62NPfEDEzkE2tcZSP7QazS6zidY8eKdCjpFLDx951laieehu33L
	 mMwPs9QOm4lZqmgOZwYajcCWfnYrHu1lDF7fAJAel86dZySEG+TQhZYhJHuSQnjI4I
	 nh20kKvS6ahdi8AYjYEl2JfqxA/4eR7OFuWFwrZmJY5ciL+rxRAWu2x1BKzizPTcLb
	 GOeLJf3RGLTlKxj9JX5+bgIq9S+7vJl83ILJ2ylz4MEjSESHwEwb18Y3+qZpi1RltU
	 6UKa6++4gD1+A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/14] mm/damon/reclaim: use damon_call() repeat mode instead of damon_callback
Date: Sun,  6 Jul 2025 13:00:08 -0700
Message-Id: <20250706200018.42704-5-sj@kernel.org>
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

DAMON_RECLAIM uses damon_callback for periodically reading and writing
DAMON internal data and parameters.  Use its alternative, damon_call()
repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 62 +++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 0fe8996328b8..3c71b4596676 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -238,6 +238,35 @@ static int damon_reclaim_apply_parameters(void)
 	return err;
 }
 
+static int damon_reclaim_handle_commit_inputs(void)
+{
+	int err;
+
+	if (!commit_inputs)
+		return 0;
+
+	err = damon_reclaim_apply_parameters();
+	commit_inputs = false;
+	return err;
+}
+
+static int damon_reclaim_damon_call_fn(void *arg)
+{
+	struct damon_ctx *c = arg;
+	struct damos *s;
+
+	/* update the stats parameter */
+	damon_for_each_scheme(s, c)
+		damon_reclaim_stat = s->stat;
+
+	return damon_reclaim_handle_commit_inputs();
+}
+
+static struct damon_call_control call_control = {
+	.fn = damon_reclaim_damon_call_fn,
+	.repeat = true,
+};
+
 static int damon_reclaim_turn(bool on)
 {
 	int err;
@@ -257,7 +286,7 @@ static int damon_reclaim_turn(bool on)
 	if (err)
 		return err;
 	kdamond_pid = ctx->kdamond->pid;
-	return 0;
+	return damon_call(ctx, &call_control);
 }
 
 static int damon_reclaim_enabled_store(const char *val,
@@ -296,34 +325,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_RECLAIM (default: disabled)");
 
-static int damon_reclaim_handle_commit_inputs(void)
-{
-	int err;
-
-	if (!commit_inputs)
-		return 0;
-
-	err = damon_reclaim_apply_parameters();
-	commit_inputs = false;
-	return err;
-}
-
-static int damon_reclaim_after_aggregation(struct damon_ctx *c)
-{
-	struct damos *s;
-
-	/* update the stats parameter */
-	damon_for_each_scheme(s, c)
-		damon_reclaim_stat = s->stat;
-
-	return damon_reclaim_handle_commit_inputs();
-}
-
-static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
-{
-	return damon_reclaim_handle_commit_inputs();
-}
-
 static int __init damon_reclaim_init(void)
 {
 	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
@@ -331,8 +332,7 @@ static int __init damon_reclaim_init(void)
 	if (err)
 		goto out;
 
-	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
-	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
+	call_control.data = ctx;
 
 	/* 'enabled' has set before this function, probably via command line */
 	if (enabled)
-- 
2.39.5
