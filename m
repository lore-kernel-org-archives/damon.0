Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB72F8BD3;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912963; cv=none; b=d6WFNFhdBvo/LDx0oXlDkYwSrQHaSvQjs1dv2muYkC6+36aBvygVxsfsBYTuEilGraForxaSiA7XO+NWl+EDkA5I3SFpuQcHBrvzBT0JNxhgq/6NDxV7zQWQKwcsUZWdOkuYpUpy/u2X7ayw0cdj2H9mw0+52L9kskU44/NkN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912963; c=relaxed/simple;
	bh=AJMBL1nNdjGC0+4eccv0L3v64yl/CaBJKvNB19kiMwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXV0nfG4Aqh44Un7M1YXj6SCfvXzC5GP03ENrTiVWyygT9bH5kLWGdaCEtyoWKo5m/IvEY5rfvsJfK1WXTNPhWJ3S5HYTg9iU8PFh4hjFfv2dWoyevgZEBJ29sFJ2Iu1XrQXKaS8xN6XXb+BvOlNpZ9f5Xiat/s5dLxaq8BvEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emdN8l1G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emdN8l1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B9C19423;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912963;
	bh=AJMBL1nNdjGC0+4eccv0L3v64yl/CaBJKvNB19kiMwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emdN8l1GafabJYJm9JIqEG+XGtuLJmZKKmtcfgcPtSLlJwl65IknEczw+BGHKkE/i
	 gNKs0q8kTJbvvKKfgQ2VHnrurATgBPeQ9Ys//vKQ532fgcAcXBmdmxWLGmvcs5kJeN
	 PTLCyp0A/gVhqjpQ/mPNgPzNM0PpGZm+cl5G+mPa/Kw29iM/nrB/xwYKjwZJNXG6Ns
	 vfduOaGcQsNkVXYH9EHqDiRgoJHt5Tq05LJzhSv4X62Gv+65AdUKVwf1q78S1zhqTM
	 fdUjhx+9llwZ3aBJshEaW0b/tlrixr77+w2e1Ais95/95ovQP6Zvq03tZV4n6FdBDT
	 d/3lAanMSBL9Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/core: remove damos_set_next_apply_sis() duplicates
Date: Sat,  7 Mar 2026 11:49:12 -0800
Message-ID: <20260307194915.203169-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307194915.203169-1-sj@kernel.org>
References: <20260307194915.203169-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a function for damos->next_apply_sis setup.  But some places
are open-coding it.  Consistently use the helper.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e8c44541754f7..c4c30824465ee 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2450,8 +2450,6 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damon_region *r;
 	struct damos *s;
-	unsigned long sample_interval = c->attrs.sample_interval ?
-		c->attrs.sample_interval : 1;
 	bool has_schemes_to_apply = false;
 
 	damon_for_each_scheme(s, c) {
@@ -2482,9 +2480,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (c->passed_sample_intervals < s->next_apply_sis)
 			continue;
 		damos_walk_complete(c, s);
-		s->next_apply_sis = c->passed_sample_intervals +
-			(s->apply_interval_us ? s->apply_interval_us :
-			 c->attrs.aggr_interval) / sample_interval;
+		damos_set_next_apply_sis(s, c);
 		s->last_applied = NULL;
 		damos_trace_stat(c, s);
 	}
@@ -2858,7 +2854,6 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
 		ctx->attrs.sample_interval : 1;
-	unsigned long apply_interval;
 	struct damos *scheme;
 
 	ctx->passed_sample_intervals = 0;
@@ -2869,9 +2864,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 		ctx->attrs.intervals_goal.aggrs;
 
 	damon_for_each_scheme(scheme, ctx) {
-		apply_interval = scheme->apply_interval_us ?
-			scheme->apply_interval_us : ctx->attrs.aggr_interval;
-		scheme->next_apply_sis = apply_interval / sample_interval;
+		damos_set_next_apply_sis(scheme, ctx);
 		damos_set_filters_default_reject(scheme);
 	}
 }
-- 
2.47.3
