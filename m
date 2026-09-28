Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA649158C;
	Mon, 28 Sep 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588036; cv=none; b=I1cwK3wEE/gmqOwp2gIgesNNlhrrwHP22vlt1vT+voFYogFyPsyVf2rJNVhk56/wBiylxCxQ68u/FwhcpWS78iJBwyg+e5X1gdhS8G4seuX1wJxWnrnbInLN1UQseYGnTGSPoX+s4+EkXeVK5t2coWtuFrUyg7cMW79OF+dY+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588036; c=relaxed/simple;
	bh=GWCCv2hMG2iFe6Zg05Gof5wYoz/bMfRcm1KUpll6cq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q++9cG2PV8bGwDX7iQGVvcKi7ekIDPnOZtlzNEPnnFx/N+oYECJKk7ZEZ+ghPQRaWNAPtqsnz6pbgAqA2nluTnjlZQ72/H1VdZyNDV5QfpjIsuR4EjQgX27Mfa0r22bBQ4iKsdPYVtsqW2pdSR3QtQTVKfaYB57y2s+sxFDlzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okilBTTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okilBTTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628891F00898;
	Mon, 28 Sep 2026 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588034;
	bh=2NpMGCOOM925wo0xqKha1bWNA/zDBBFGTTeCY9T1jWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=okilBTTTlyeMkcAeyZsb82XvRio2JEg+ow7QSFIa7rQXced2fGDORyZP3V1/oKHDx
	 +rA8MtPGBU7pIX2Aojm8BAh/0kSfgFzwMO4CeJqwPgAppWoH16DSCawz3O2yr8Dfi/
	 rr8H9mq4l6NWTQjG5FWc04lrI+Od4P30c32ah1prxTKzkncdiARbMiwRemRIYi7PL4
	 X2gt4usaC94YM9b0No5O7iDqHek0RXtWtkWKqxpYfngixFd5z8JoBu9pHoJYc+rJPH
	 BWLrcD1sMx2ksWrlt/UYyQ2W20UVFhgBT914BEM52gE0Rza6Zs3HOh2AcsiD3AOXYc
	 gpDzGuUeUHNjg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 2/8] mm/damon/core: add complement argument to damos_new_quota_goal()
Date: Mon, 28 Sep 2026 02:33:34 -0700
Message-ID: <20260928093342.16584-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h | 1 +
 samples/damon/mtier.c       | 2 +-
 7 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 78b227875287..b310c40d6ceb 100644
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
index 270ce9c85a2c..86f13411b91f 100644
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
+		new_goal = damos_new_quota_goal(src_goal->metric,
+				src_goal->complement, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
 		err = damos_commit_quota_goal(new_goal, src_goal);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 273efa3c913e..64e086985eb5 100644
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
index 42a2c9cb1343..014b0779ea6d 100644
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
index bfb6f0bc3f21..06af417bc9a2 100644
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
index df84d9cc7d20..945037fe4be9 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -930,6 +930,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
 		 * Make it kfree()-able.
 		 */
 		goal = damos_new_quota_goal(dst_goals[i].metric,
+				dst_goals[i].complement,
 				dst_goals[i].target_value);
 		if (!goal)
 			goto out;
diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 27dc88bdf7a0..a2e311082cd4 100644
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
