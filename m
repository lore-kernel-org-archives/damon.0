Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D3291C1A;
	Sat, 12 Jul 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349826; cv=none; b=h3FTTmPaGHcw5ixA+63Rtw/N9L/lAJx6q5VQ21d30kNuYsiB5OhiNyKNdH/e15nH35srNb13IwwSfguEnSHq9s2pG5VtAWi7BPXLfjTVSOL+uY/Sk8rG9iIpjUyW75xlL+Ow5TXRcnDh3EVoUISgbfXkjX0Nen8TkI7VeXX6R6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349826; c=relaxed/simple;
	bh=fAIXtGREPARQvCC1/X313DQcYGh4YYVNrncF7IRNX5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKLn+1VIw7WsCQNCXG11QQMJlLgcwCaSbf4gFFlP9Cgk/Z5KOsgPRiMJ2ilNaGKsGhFQHCkASVaaPoLQ7We+1Zsyc3jX3DU0l5xpNr1Rq5gXXvUhIf4Zg8L+uzCbjktR7ehWtct7H0jy/ml+Ua6PngKLHQlXDoahMzJ19XVlh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnBXbj9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnBXbj9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F0CC4CEF5;
	Sat, 12 Jul 2025 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349825;
	bh=fAIXtGREPARQvCC1/X313DQcYGh4YYVNrncF7IRNX5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnBXbj9JLQ/68/CzvkH51wlCIhPyiwg8gTXIEr4W7DaJ8ASkufZ3vJ3yZBm2RI+9E
	 +GyAELXBJre+9ftd1CCJU53fepM+WY1a0WDjQVRPvvVecuRWJvFwc6blCwn1IjyiXN
	 /SSnQpWYVxbVqYJi6iS9cdvvXXgCkOs7LWpn00YpARWLYhlzmW3TH9FC6k9WqqM1KV
	 95ZFzjgtQBENj88W2DdFytayi5LoJb38TaT3cw/dsU/VyuTwIcdY9gZImUzV6n/jfw
	 J854wJCjwLUf66wJl0v/6I61VTSml4gfmx57e6M5HRP3P9K9LrHH3qbEIPVm98W73/
	 VJRlj62cabWpw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/14] mm/damon/reclaim: use damon_call() repeat mode instead of damon_callback
Date: Sat, 12 Jul 2025 12:50:06 -0700
Message-Id: <20250712195016.151108-5-sj@kernel.org>
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
