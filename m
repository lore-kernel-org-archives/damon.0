Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20853291C36;
	Sat, 12 Jul 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349827; cv=none; b=TzU63yaLuTmVpNNP71hZJ+UVTo11/sZ/bKHd4a7K+5eyzBTTEdaLlJpkC+qZ+QE42qYWvFZCMRcEFB3Cv51621oF1CUWyJhgyWoXKmhmvPIeRmrUOwmJtKRU/tLHc0GsaVOS3oEKggftk27lQSytOB7pLriAIX+oP8QqKKbLhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349827; c=relaxed/simple;
	bh=8BmJeyRI+t+rJLAQd+/Sf188h6vX4h9leuX/fdJu7n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dy2u0NQ3LpSbCV+FSKTODoznLES/iCdG5fPJj12mZ31hiI/uzBxplGBj9L2dCUXCEL+bPbtdJq3m2xOKHYzShCCpcYjzboHyM6HXWUc70Cotmu0PwV3AdqvDOCaglAfsBPjEHClB/jrM3dx7/NC1bG9VQtOOyaDZevvxxMqQKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlT5K1qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlT5K1qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D780C4CEF7;
	Sat, 12 Jul 2025 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349826;
	bh=8BmJeyRI+t+rJLAQd+/Sf188h6vX4h9leuX/fdJu7n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlT5K1qiBV0RHGAA/07WZGIywH1FpMj7f3h2LS1ztccSE95zqwui6wMnVj+hjadWa
	 wmYVhMJ8J9fR7w6RwmDd3u2AIzufI7gimqcKwQlW/PNTfcIibHTFaicSG2bMMIb8IJ
	 VIuXlbisNF8xHh5Yxa+cLuJU8U9s5TZfLbxmHLPmH4Y213HfYQVOdYIc6o8BG99Z4Y
	 MfuixWL+Ds2olswgaCRAZobNECvnX4xrqFhOLLrBBHjfex6gldDrrJL7tcdmMHWjD1
	 8p/h7cn0NXMAzK310FxmhpTl9VUQc+SD65u7+oG8QPOFO0CH6Oig+MDeCDfMeFzx26
	 EAm7Dm8lIj/fg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/14] mm/damon/lru_sort: use damon_call() repeat mode instead of damon_callback
Date: Sat, 12 Jul 2025 12:50:07 -0700
Message-Id: <20250712195016.151108-6-sj@kernel.org>
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

DAMON_LRU_SORT uses damon_callback for periodically reading and writing
DAMON internal data and parameters.  Use its alternative, damon_call()
repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index dcac775eaa11..621f19546596 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -230,6 +230,39 @@ static int damon_lru_sort_apply_parameters(void)
 	return err;
 }
 
+static int damon_lru_sort_handle_commit_inputs(void)
+{
+	int err;
+
+	if (!commit_inputs)
+		return 0;
+
+	err = damon_lru_sort_apply_parameters();
+	commit_inputs = false;
+	return err;
+}
+
+static int damon_lru_sort_damon_call_fn(void *arg)
+{
+	struct damon_ctx *c = arg;
+	struct damos *s;
+
+	/* update the stats parameter */
+	damon_for_each_scheme(s, c) {
+		if (s->action == DAMOS_LRU_PRIO)
+			damon_lru_sort_hot_stat = s->stat;
+		else if (s->action == DAMOS_LRU_DEPRIO)
+			damon_lru_sort_cold_stat = s->stat;
+	}
+
+	return damon_lru_sort_handle_commit_inputs();
+}
+
+static struct damon_call_control call_control = {
+	.fn = damon_lru_sort_damon_call_fn,
+	.repeat = true,
+};
+
 static int damon_lru_sort_turn(bool on)
 {
 	int err;
@@ -249,7 +282,7 @@ static int damon_lru_sort_turn(bool on)
 	if (err)
 		return err;
 	kdamond_pid = ctx->kdamond->pid;
-	return 0;
+	return damon_call(ctx, &call_control);
 }
 
 static int damon_lru_sort_enabled_store(const char *val,
@@ -288,38 +321,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_LRU_SORT (default: disabled)");
 
-static int damon_lru_sort_handle_commit_inputs(void)
-{
-	int err;
-
-	if (!commit_inputs)
-		return 0;
-
-	err = damon_lru_sort_apply_parameters();
-	commit_inputs = false;
-	return err;
-}
-
-static int damon_lru_sort_after_aggregation(struct damon_ctx *c)
-{
-	struct damos *s;
-
-	/* update the stats parameter */
-	damon_for_each_scheme(s, c) {
-		if (s->action == DAMOS_LRU_PRIO)
-			damon_lru_sort_hot_stat = s->stat;
-		else if (s->action == DAMOS_LRU_DEPRIO)
-			damon_lru_sort_cold_stat = s->stat;
-	}
-
-	return damon_lru_sort_handle_commit_inputs();
-}
-
-static int damon_lru_sort_after_wmarks_check(struct damon_ctx *c)
-{
-	return damon_lru_sort_handle_commit_inputs();
-}
-
 static int __init damon_lru_sort_init(void)
 {
 	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
@@ -327,8 +328,7 @@ static int __init damon_lru_sort_init(void)
 	if (err)
 		goto out;
 
-	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
-	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
+	call_control.data = ctx;
 
 	/* 'enabled' has set before this function, probably via command line */
 	if (enabled)
-- 
2.39.5
