Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719F2D94BA;
	Sun, 12 Apr 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010802; cv=none; b=XID3B91TYv2q2/i31ZJj3tgjiwzCULb50DrPe9FGgtc2nUbkK1ED8xwpAsJz8Ac1ZnIcyIbHbr4+U0az+0bROSRjQuiWyMTX5Q4vubx96Evtigck7W4UDoJrS8cbXYThvrl9vskQsdHXSHs9sYIBytU4Y2ONQDwNAxd0SbfXWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010802; c=relaxed/simple;
	bh=lVvvJyXXUULYKYNrOl6GeL91WhrIsl7oASNCEnlmdDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJgO3QWdlYVR+HhkCLbhNjnD/YlZcDesZI30cRSfZjmIdLtXpM4R2Y0qTgeOjyPmybrSKYBNdnjraZI1AmjVLu4YFYKgkZLRvEt0SicngYpLNtUnXo8Dr1PDmP96gGxez2vc8Q15MQfDjFnWOWd0qU/LZmfZYYwxbdmdkCO0fRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO14dbmL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO14dbmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915C9C2BCB1;
	Sun, 12 Apr 2026 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010802;
	bh=lVvvJyXXUULYKYNrOl6GeL91WhrIsl7oASNCEnlmdDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FO14dbmLsSeIyks0o1fyBOx0o6ED0i+x/tg7Dv/bLqHGRpVQXmHnigqT572YdYGqR
	 u/jsRXM3ZcRziNURVJb4yzmEcXAELby6RsT8/y0f/8lBYJLmGrObZVp5fLxrOduOKk
	 c1dWf317Foejk2icmKjgb0BBB6iNZWPuJV9SagzZhDhZ3NjQ94tdZcLp9/vLq6M/A5
	 EdzWESLSBa3e5kZgcHLsFdcjmUFM++iPhHBGiW+kmEUh3M/Wuc/0dRB//qU5cssSuP
	 4L6ZsbOcXBjwN44Oi4tmkXs+EINs2mn3K91o7CnTX1dAyOwHG4gRIYuYW1SuLeMvGM
	 FW24Mmg6QOt1w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.2 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Sun, 12 Apr 2026 09:19:46 -0700
Message-ID: <20260412161957.82835-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412161957.82835-1-sj@kernel.org>
References: <20260412161957.82835-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS quota is charged to all DAMOS action application attempted memory,
regardless of how much of the memory the action was successful and
failed.  This makes understanding quota behavior without DAMOS stat but
only with end level metrics (e.g., increased amount of free memory for
DAMOS_PAGEOUT action) difficult.  Also, charging action-failed memory
same as action-successful memory is somewhat unfair, as successful
action application will induce more overhead in most cases.

Introduce DAMON core API for setting the charge ratio for such
action-failed memory.  It allows API callers to specify the ratio in a
flexible way, by setting the numerator and the denominator.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  9 +++++++++
 mm/damon/core.c       | 21 ++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d3054af1d964f..5fb1dc585658b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -235,6 +235,8 @@ enum damos_quota_goal_tuner {
  * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @goal_tuner:		Goal-based @esz tuning algorithm to use.
  * @esz:		Effective size quota in bytes.
+ * @fail_charge_num:	Failed regions charge rate numerator.
+ * @fail_charge_denom:	Failed regions charge rate denominator.
  *
  * @weight_sz:		Weight of the region's size for prioritization.
  * @weight_nr_accesses:	Weight of the region's nr_accesses for prioritization.
@@ -264,6 +266,10 @@ enum damos_quota_goal_tuner {
  *
  * The resulting effective size quota in bytes is set to @esz.
  *
+ * For DAMOS action applying failed amount of regions, charging those same to
+ * those that the action has successfully applied may be unfair.  For the
+ * reason, 'the size * @fail_charge_num / @fail_charge_denom' is charged.
+ *
  * For selecting regions within the quota, DAMON prioritizes current scheme's
  * target memory regions using the &struct damon_operations->get_scheme_score.
  * You could customize the prioritization logic by setting &weight_sz,
@@ -278,6 +284,9 @@ struct damos_quota {
 	enum damos_quota_goal_tuner goal_tuner;
 	unsigned long esz;
 
+	unsigned int fail_charge_num;
+	unsigned int fail_charge_denom;
+
 	unsigned int weight_sz;
 	unsigned int weight_nr_accesses;
 	unsigned int weight_age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0654caa904c8c..48633da449104 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -918,6 +918,8 @@ static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
 	if (err)
 		return err;
 	dst->goal_tuner = src->goal_tuner;
+	dst->fail_charge_num = src->fail_charge_num;
+	dst->fail_charge_denom = src->fail_charge_denom;
 	dst->weight_sz = src->weight_sz;
 	dst->weight_nr_accesses = src->weight_nr_accesses;
 	dst->weight_age = src->weight_age;
@@ -2047,6 +2049,23 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->walk_control_lock);
 }
 
+static void damos_charge_quota(struct damos_quota *quota,
+		unsigned long sz_region, unsigned long sz_applied)
+{
+	/*
+	 * sz_applied could be bigger than sz_region, depending on ops
+	 * implementation of the action, e.g., damos_pa_pageout().  Charge only
+	 * the region size in the case.
+	 */
+	if (!quota->fail_charge_denom || sz_applied > sz_region)
+		quota->charged_sz += sz_region;
+	else
+		quota->charged_sz += sz_applied + mult_frac(
+				(sz_region - sz_applied),
+				quota->fail_charge_num,
+				quota->fail_charge_denom);
+}
+
 static bool damos_quota_is_full(struct damos_quota *quota,
 		unsigned long min_region_sz)
 {
@@ -2117,7 +2136,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-		quota->charged_sz += sz;
+		damos_charge_quota(quota, sz, sz_applied);
 		if (damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
-- 
2.47.3
