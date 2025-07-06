Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F12BE025;
	Sun,  6 Jul 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832030; cv=none; b=qzLVzsDB+WkJ/kZakO8SmBuGnHnPtqRR57YIGlnm91K1vAZwkRrrn/XURN6Z/1uPHO5ywOIIAjP/qkOv84edQ7V2SUsA4IddyufCJq53OTvcdknrqxT+74hgv9qCddLbWlriqH5C1OA27rBiDKxBHqal2z/FgKVrQq7GrdaLDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832030; c=relaxed/simple;
	bh=8BmJeyRI+t+rJLAQd+/Sf188h6vX4h9leuX/fdJu7n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMyQzQHM+4xi7Lg148G5ZxS2Y0ureZYQTxG8/4Hgh3RPdr6tyHVaR+v5clFEu9UbhwVFDsE8YatrIZkdqkeyS/NROcpxI/pdnIllp3nJzLhF2HV+esKQw1V70E+LayuiKksa/AtOl3NkM0hwkXCFzCKRZqIHNaIdOnh35N045Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNetGueO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNetGueO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39236C4CEF1;
	Sun,  6 Jul 2025 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832030;
	bh=8BmJeyRI+t+rJLAQd+/Sf188h6vX4h9leuX/fdJu7n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNetGueOoHKanG9mUzlnRfLDtfMrit02JswGEmbInvJ85dfZl/Wf0abkAi/EZmchO
	 Y0GloZ2cQ8lw+lC6rUb+L0UTl3brkJGcAxee2uX2JFxCuAb11Vj1bM/LfDhD/Yf25v
	 nB8Pf4OwaBI+INgAcsZJDg8eybijqPzrNuJ35jTzUD38DKfJJrSZLWP6cgEDn5EGOC
	 psjnjL+pVz0uwuTkfCti6qM9L6ky69AccMZ66DTZfpCVEt4HPx4rJmo1IOyaKWvs96
	 GmDv8ptuqKDffYWUaNgUXI19BZyVRWq8G2WGboOV5EUOAEib02fuql9ZLX2yfGUjrj
	 wrT7Tgi3ymv1g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/14] mm/damon/lru_sort: use damon_call() repeat mode instead of damon_callback
Date: Sun,  6 Jul 2025 13:00:09 -0700
Message-Id: <20250706200018.42704-6-sj@kernel.org>
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
