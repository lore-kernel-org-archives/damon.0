Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02001DE4C7;
	Fri, 28 Feb 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780213; cv=none; b=EyS8kRee2mwU2aOmnkEaqldRLJr5EJD1GOAi0xpmM0s4lBUNYmIyEJfqZQdGgqXhXnlUNQovu8eenlgihnBgDaZKby7PhiMUUOVg3qja/GQDAw9UQghlHQyFOd3zmmnGEaaUvytZGLbOrH3uLsUIZjcaXJdsEctsESW4lAN0oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780213; c=relaxed/simple;
	bh=w21tstzzb4FfHupcVwHDLvqkq/QXU7C/Es38OxUzGJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDRoVDhNiixbCxXbND9qsXwv6OMUbzuGMpxbGmfhhYVgSoNCeHdawxcdK6XL4xOBz7IHytXg7AOtGMMLstkOtsoR+0OvmUW9CyIExKJu2Jb5xUWVgDOdlV/GZyp21rLMO7CMRWcH0v8iLaONjOZm/erN/FLBliX1RYx8WwDW9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGfRkR+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGfRkR+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781B7C4CEE2;
	Fri, 28 Feb 2025 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780213;
	bh=w21tstzzb4FfHupcVwHDLvqkq/QXU7C/Es38OxUzGJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGfRkR+YJIBl3Vea7jC1iBcMljBOVbkTePmmNC8lkKlsV7rX0LY8snKXVd+qbhs/0
	 uMu5P8J3qPX6bnBq+lua2Djqx6g/S5QxO6G2/wGhW9ze/UmZOUqmW27vQbSnQPyp8v
	 AxZUiJSIOp5uGFJDYsRcTrIi4aSBY9Se+BZeT9HplmzY02OL3VR512RWaaQgVeWCZ4
	 G+r3xT2IcgOR1AAilvNuSDoEb1zLS5rW6Vop0tRrfA6lauWKbkTwho6XF5uqmjcP3u
	 BH2nWDJZD6DegKZqBfPB2ulMTD1R+0JGgNmUT/ks4s9JK36V76ceRgGMbp5BWR1ujv
	 sv1J4TYVU+Y+g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/8] mm/damon/core: implement intervals auto-tuning
Date: Fri, 28 Feb 2025 14:03:22 -0800
Message-Id: <20250228220328.49438-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DAMON sampling and aggregation intervals auto-tuning
mechanism as briefly described on 'struct damon_intervals_goal'.  The
core part for deciding the direction and amount of the changes is
implemented reusing the feedback loop function which is being used for
DAMOS quotas auto-tuning.  Unlike the DAMOS quotas auto-tuning use case,
limit the maximum decreasing amount after the adjustment to 50% of the
current value, though.  This is because the intervals have no good
merits at rapid reductions since it could unnecessarily increase the
monitoring overhead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 16 +++++++++
 mm/damon/core.c       | 76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 130c3e01089c..eed008b64a23 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -718,6 +718,17 @@ struct damon_attrs {
 	struct damon_intervals_goal intervals_goal;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
+/* private: internal use only */
+	/*
+	 * @aggr_interval to @sample_interval ratio.
+	 * Core-external components call damon_set_attrs() with &damon_attrs
+	 * that this field is unset.  In the case, damon_set_attrs() sets this
+	 * field of resulting &damon_attrs.  Core-internal components such as
+	 * kdamond_tune_intervals() calls damon_set_attrs() with &damon_attrs
+	 * that this field is set.  In the case, damon_set_attrs() just keep
+	 * it.
+	 */
+	unsigned long aggr_samples;
 };
 
 /**
@@ -766,6 +777,11 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
+	/*
+	 * number of sample intervals that should be passed before next
+	 * intervals tuning
+	 */
+	unsigned long next_intervals_tune_sis;
 	/* for waiting until the execution of the kdamond_fn is started */
 	struct completion kdamond_started;
 	/* for scheme quotas prioritization */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b11595c01c37..d4fc2c907cfc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -687,6 +687,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
+	/* calls from core-external doesn't set this. */
+	if (!attrs->aggr_samples)
+		attrs->aggr_samples = attrs->aggr_interval / sample_interval;
+
 	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
 		attrs->aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
@@ -1392,6 +1396,65 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+static unsigned long damon_get_intervals_score(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long sz_region, max_access_events = 0, access_events = 0;
+	unsigned long target_access_events;
+	unsigned long goal_bp = c->attrs.intervals_goal.access_bp;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			sz_region = damon_sz_region(r);
+			max_access_events += sz_region * c->attrs.aggr_samples;
+			access_events += sz_region * r->nr_accesses;
+		}
+	}
+	target_access_events = max_access_events * goal_bp / 10000;
+	return access_events * 10000 / target_access_events;
+}
+
+static unsigned long damon_feed_loop_next_input(unsigned long last_input,
+		unsigned long score);
+
+static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
+{
+	unsigned long score_bp, adaptation_bp;
+
+	score_bp = damon_get_intervals_score(c);
+	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
+		10000;
+	/*
+	 * adaptaion_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
+	 * the intervals by rescaling [1,10,000] to [5000, 10,000].
+	 */
+	if (adaptation_bp <= 10000)
+		adaptation_bp = 5000 + adaptation_bp / 2;
+	return adaptation_bp;
+}
+
+static void kdamond_tune_intervals(struct damon_ctx *c)
+{
+	unsigned long adaptation_bp;
+	struct damon_attrs new_attrs;
+	struct damon_intervals_goal *goal;
+
+	adaptation_bp = damon_get_intervals_adaptation_bp(c);
+	if (adaptation_bp == 10000)
+		return;
+
+	new_attrs = c->attrs;
+	goal = &c->attrs.intervals_goal;
+	new_attrs.sample_interval = min(goal->max_sample_us,
+			c->attrs.sample_interval * adaptation_bp / 10000);
+	new_attrs.sample_interval = max(goal->min_sample_us,
+			new_attrs.sample_interval);
+	new_attrs.aggr_interval = new_attrs.sample_interval *
+		c->attrs.aggr_samples;
+	damon_set_attrs(c, &new_attrs);
+}
+
 static void damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
@@ -2300,6 +2363,8 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
 		sample_interval;
+	ctx->next_intervals_tune_sis = ctx->next_aggregation_sis *
+		ctx->attrs.intervals_goal.aggrs;
 
 	damon_for_each_scheme(scheme, ctx) {
 		apply_interval = scheme->apply_interval_us ?
@@ -2384,6 +2449,17 @@ static int kdamond_fn(void *data)
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
 		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
+			if (ctx->attrs.intervals_goal.aggrs &&
+					ctx->passed_sample_intervals >=
+					ctx->next_intervals_tune_sis) {
+				ctx->next_intervals_tune_sis +=
+					ctx->attrs.aggr_samples *
+					ctx->attrs.intervals_goal.aggrs;
+				kdamond_tune_intervals(ctx);
+				sample_interval = ctx->attrs.sample_interval ?
+					ctx->attrs.sample_interval : 1;
+
+			}
 			ctx->next_aggregation_sis = next_aggregation_sis +
 				ctx->attrs.aggr_interval / sample_interval;
 
-- 
2.39.5
