Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B74368D57;
	Sat, 19 Sep 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780459; cv=none; b=iT3Qvuv4R2eEECsur/27bloNsgOVZJovXVMN/mXBnHzfXKsPKXZIb8mUkcBKY2K5swttacMUmfh0WD9/0lErPvHiu84OgRdhpifrMvC41wGAqFxGPiVhU5GCjKC5Va6llBDS7wiDPBB2c6s0KEdtsoONTLJcBgWbfVZs4LBkEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780459; c=relaxed/simple;
	bh=gwzBIb29CwSjFHYSiYcuuFJbqtQJQdHAyfcjLdO6F/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNSyGuHqAOIgD5skunIgysJgmyGTDkSBuGqcPPeuOtYhnACaSh4t3iaTKlP8MiMPKsYuzlk+Xb2oQCjEJsGQ7vFHJr+Ytl49BUo8IXwUxFyv4EnPugjxHABKRuuUDKn+Lev14xoIg3XjkvDTkOEpVbOrrew1SsgNVjfr1dskZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqO4ICle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqO4ICle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D5B1F00898;
	Sat, 19 Sep 2026 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780448;
	bh=3raBbLeFpTIEpJmm1pMj76F/nXAbwXFIKp8E2V5BGiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqO4ICleDn04jVg5zhWHwehwHDU0WF2G/I+I0ErBEEf+c7KVG6T43uwRsFl3jzFZ0
	 9CL8SlLYi0AfO2OQHJGTIWZa3yLiCGfLr8clgSBSkLpdiKkiYjoNbviz7FlZaQrlJs
	 APO4es4P8iEKKBcCjItp1v7O79fsuZblBr53gAh9rig/Bxv4QGswkWbR6nOW6YLVRW
	 kKpvMt2thVVecm6WSu4IFidy3ELN2M1Hamfg7ehvYshfQFmJTDxZszsYH1CB/U+bUc
	 CLswOk8SJSlAJ0r9UM5MDI32EDnkBKB0xAt43vcU1//ozNxaEP3BwufV+CnzeIhOx9
	 4+YSIX4R3EwMQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/7] mm/damon: add complement argument to damos_new_quota_goal()
Date: Fri, 18 Sep 2026 18:13:51 -0700
Message-ID: <20260919011359.88921-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919011359.88921-1-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_goal->complement needs to be manually set by each API
callers.  It is easy to make mistakes.  Extend the quota goal
constructor, damos_new_quota_goal() to receive and set the complement
flag value. Also update all callers to use the new signature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h       | 2 +-
 mm/damon/core.c             | 7 ++++---
 mm/damon/lru_sort.c         | 5 +++--
 mm/damon/reclaim.c          | 5 +++--
 mm/damon/sysfs-schemes.c    | 2 +-
 mm/damon/tests/core-kunit.h | 2 +-
 samples/damon/mtier.c       | 2 +-
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 78b227875287d..b310c40d6cebd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1098,7 +1098,7 @@ bool damos_filter_for_ops(enum damos_filter_type type);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos_quota_goal *damos_new_quota_goal(
-		enum damos_quota_goal_metric metric,
+		enum damos_quota_goal_metric metric, bool complement,
 		unsigned long target_value);
 void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
 void damos_destroy_quota_goal(struct damos_quota_goal *goal);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 05d1df3746e83..570891a15e2f8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -691,7 +691,7 @@ void damos_destroy_filter(struct damos_filter *f)
 }
 
 struct damos_quota_goal *damos_new_quota_goal(
-		enum damos_quota_goal_metric metric,
+		enum damos_quota_goal_metric metric, bool complement,
 		unsigned long target_value)
 {
 	struct damos_quota_goal *goal;
@@ -700,6 +700,7 @@ struct damos_quota_goal *damos_new_quota_goal(
 	if (!goal)
 		return NULL;
 	goal->metric = metric;
+	goal->complement = complement;
 	goal->target_value = target_value;
 	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
 		goal->last_psi_total = U64_MAX;
@@ -1262,8 +1263,8 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 	damos_for_each_quota_goal_safe(src_goal, next, src) {
 		if (j++ < i)
 			continue;
-		new_goal = damos_new_quota_goal(
-				src_goal->metric, src_goal->target_value);
+		new_goal = damos_new_quota_goal(src_goal->metric, false,
+				src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
 		err = damos_commit_quota_goal(new_goal, src_goal);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 273efa3c913ed..64e086985eb55 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -233,12 +233,13 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
 
 	if (!active_mem_bp)
 		return 0;
-	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
+	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, false,
+			active_mem_bp);
 	if (!goal)
 		return -ENOMEM;
 	damos_add_quota_goal(&hot_scheme->quota, goal);
 	/* aim 0.2 % goal conflict, to keep little ping pong */
-	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
+	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP, false,
 			10000 - active_mem_bp + 2);
 	if (!goal)
 		return -ENOMEM;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 42a2c9cb13431..014b0779ea6dd 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -233,7 +233,7 @@ static int damon_reclaim_apply_parameters(void)
 	damon_set_schemes(param_ctx, &scheme, 1);
 
 	if (quota_mem_pressure_us) {
-		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
+		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US, false,
 				quota_mem_pressure_us);
 		if (!goal)
 			goto out;
@@ -241,7 +241,8 @@ static int damon_reclaim_apply_parameters(void)
 	}
 
 	if (quota_autotune_feedback) {
-		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
+		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, false,
+				10000);
 		if (!goal)
 			goto out;
 		goal->current_value = quota_autotune_feedback;
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bfb6f0bc3f213..06af417bc9a2f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2869,7 +2869,7 @@ static int damos_sysfs_add_quota_score(
 		if (!sysfs_goal->target_value)
 			continue;
 
-		goal = damos_new_quota_goal(sysfs_goal->metric,
+		goal = damos_new_quota_goal(sysfs_goal->metric, false,
 				sysfs_goal->target_value);
 		if (!goal)
 			return -ENOMEM;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index df84d9cc7d204..e8290a2c6f343 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -929,7 +929,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
 		 * damos_commit_quota_goals() will kfree() the dst goals.
 		 * Make it kfree()-able.
 		 */
-		goal = damos_new_quota_goal(dst_goals[i].metric,
+		goal = damos_new_quota_goal(dst_goals[i].metric, false,
 				dst_goals[i].target_value);
 		if (!goal)
 			goto out;
diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 27dc88bdf7a0e..a2e311082cd4b 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -163,7 +163,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	damon_set_schemes(ctx, &scheme, 1);
 	quota_goal = damos_new_quota_goal(
 			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
-			DAMOS_QUOTA_NODE_MEM_FREE_BP,
+			DAMOS_QUOTA_NODE_MEM_FREE_BP, false,
 			promote ? node0_mem_used_bp : node0_mem_free_bp);
 	if (!quota_goal)
 		goto free_out;
-- 
2.47.3
