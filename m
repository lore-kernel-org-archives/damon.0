Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2A13C82E;
	Thu, 13 Feb 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411095; cv=none; b=qSxLBfTEixwfE9g+Zh48lyZYw8rbMCGOYGf9NkDAeYipwtXaLS63LfIspAC1NiMMhihTCYryTCh6vkEnYhml0qwPQz4PlpS1WJu6tD+bciZxh+CnmNfv1z4dST6Dpr8VOuVWctWRamD2uWTzEYxTC4O6u/A3YrXJb+XNBJ0LYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411095; c=relaxed/simple;
	bh=W/Z4Pz7/0rKa1NitqjDRMCIfBla8IOcoTknAAfohU00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFjgzJPK6MMENlGHIMikns7oH0Gop8bjXguXaLN3Gjm4Jkw8rmj8eoY759BozUzYf4q3IoIPdXoIzwDja0HQQw60ybq2apNh4xGwltHhsr62/W31GMIfFKorhLa6eyqtseak3B/sr6ujDdnVL3xeOFWXG7/nqLHLGPGmMMIN4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw5STQf0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw5STQf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F5CC4CEDF;
	Thu, 13 Feb 2025 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411094;
	bh=W/Z4Pz7/0rKa1NitqjDRMCIfBla8IOcoTknAAfohU00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw5STQf0kp1MAge7MPXqyEykadpvLLsK9LJzEH3HX/d5PDfTYcUUAcSYKI2bzds0S
	 Ics9c0nN69O9/PqA6WGdmU5mXEBSiGYvCUDE1qRPQj+LFaHTLwcsPYyAmUYIV9Jq5x
	 lRwuo/Mw1/V21QX1zkJT4bmAk2jxFgJH26tSPEXEWgfxoMi6VPv5D9qVVUaX/rs/y8
	 ++2bmuXGygdL7Jcgn/pkwtAu3t8uzFMpIJl8csUcEtF+zvdtaQTLLHSa9BXPNGcy0s
	 CYerbKo85s0tLT7IFeR4YF2cBVmkQYKGeaBGcZNY1dBJfx/ubtXdlQWCrlrHfp0JUC
	 mIo6KqW1VDLsQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/8] mm/damon/core: implement intervals auto-tuning
Date: Wed, 12 Feb 2025 17:44:32 -0800
Message-Id: <20250213014438.145611-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DAMON sampling and aggregation intervals auto-tuning
mechanism as designed on the cover letter of this patch series.  The
mechanism reuses the feedback loop function for DAMOS quotas
auto-tuning.  Unlike the DAMOS quotas auto-tuning use case, limit the
maximum decreasing amount after the adjustment to 50% of the current
value.  This is because the intervals have no good merits at rapidly
reducing, and it is assumed the user will set the range of tunable
values not very wide.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 16 ++++++++++
 mm/damon/core.c       | 68 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4368ba1a942f..a205843fcf5a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -705,6 +705,17 @@ struct damon_attrs {
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
@@ -753,6 +764,11 @@ struct damon_ctx {
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
index 2fad800271a4..227bdb856157 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -663,6 +663,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
+	/* calls from core-external doesn't set this. */
+	if (!attrs->aggr_samples)
+		attrs->aggr_samples = attrs->aggr_interval / sample_interval;
+
 	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
 		attrs->aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
@@ -1300,6 +1304,60 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+static unsigned long damon_feed_loop_next_input(unsigned long last_input,
+		unsigned long score);
+
+static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long nr_regions = 0, access_samples = 0;
+	struct damon_intervals_goal *goal = &c->attrs.intervals_goal;
+	unsigned long max_samples, target_samples, score_bp;
+	unsigned long adaptation_bp;
+
+	damon_for_each_target(t, c) {
+		nr_regions = damon_nr_regions(t);
+		damon_for_each_region(r, t)
+			access_samples += r->nr_accesses;
+	}
+	max_samples = nr_regions * c->attrs.aggr_samples;
+	target_samples = max_samples * goal->samples_bp / 10000;
+	score_bp = access_samples * 10000 / target_samples;
+	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
+		10000;
+	/*
+	 * adaptaion_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
+	 * the intervals by rescaling [1,10,000] to [5000, 10,000].
+	 */
+	if (adaptation_bp <= 10000)
+		adaptation_bp = 5000 + adaptation_bp / 2;
+
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
+	new_attrs.sample_interval = min(
+			c->attrs.sample_interval * adaptation_bp / 10000,
+			goal->max_sample_us);
+	new_attrs.sample_interval = max(new_attrs.sample_interval,
+			goal->min_sample_us);
+	new_attrs.aggr_interval = new_attrs.sample_interval *
+		c->attrs.aggr_samples;
+	damon_set_attrs(c, &new_attrs);
+}
+
 static void damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
@@ -2204,6 +2262,8 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
 		sample_interval;
+	ctx->next_intervals_tune_sis = ctx->next_aggregation_sis *
+		ctx->attrs.intervals_goal.aggrs;
 
 	damon_for_each_scheme(scheme, ctx) {
 		apply_interval = scheme->apply_interval_us ?
@@ -2290,6 +2350,14 @@ static int kdamond_fn(void *data)
 		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			ctx->next_aggregation_sis = next_aggregation_sis +
 				ctx->attrs.aggr_interval / sample_interval;
+			if (ctx->attrs.intervals_goal.aggrs &&
+					ctx->passed_sample_intervals >=
+					ctx->next_intervals_tune_sis) {
+				ctx->next_intervals_tune_sis +=
+					ctx->attrs.aggr_samples *
+					ctx->attrs.intervals_goal.aggrs;
+				kdamond_tune_intervals(ctx);
+			}
 
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
-- 
2.39.5
