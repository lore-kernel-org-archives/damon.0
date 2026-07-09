Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB7263F34;
	Thu,  9 Jul 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605966; cv=none; b=WJCEXjno3SpC/t6kSSNCA4EdhtpqmcUI9eWFvuxO9FclJJ7LUR/dSATM7Av/fTMZSkunCx+ThUpdUJ0pv6GUpAwvRJoAInlGjneyBEL9JEoIW21r35gnefbp6Cu6lL2Ehc0XVyYIXLs1Mid1WZhU47LRx9rdzUrJQlCMCux34mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605966; c=relaxed/simple;
	bh=IXEhpOqYcdTgEn6nsmJ4Y7FJQxo4rk1b4Ym9lYrppt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhjLMCl/zIvl5RNiyrGvNrSkOS2kSjiOTYT6n+h7jm0gZRP8UCUbFJihKIKBLrlH312TtnoFo7NDLQQmGj7aP+S0ivge1Spfv0R9JvRkUw0O1DqhXmT36ftRPvGJyxPbrSFfT4Xb/ADbwhO8YpLbOa18lEY7varHn4XlNj5S36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBsgvH0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBsgvH0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCC71F00A3A;
	Thu,  9 Jul 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605964;
	bh=jJNYExS7CnlzY009dkSGfruSxfsJLZfZ15sXl05bwnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBsgvH0EWMMjf9mbnDY1TkxSj6Yc5IvgBOeP6z2tDe0akHiqMKPt4R/5kh7QYTd8H
	 nHvVSzwRJ160hNmD9i4x9kMEalX7KimkFX3jv/4gEO6bq7XzwaOcdR89S9DWSx2Q5Z
	 QbYXdTJWLmPhUssnB668gR74pahm7gGjteN4GjOUH77ngXv5fki4u1H0wD5zLb9BBf
	 hl0IteuyWdDpjEi7w0EGVtKlNK6/mS+7tu2PBzDBsW2YzIB/EfID6Xmd7ONJPs4qtj
	 tgwmA3Q0pYrKdFEWTyUKe4y5hmdC/43g6iB3CwmmOQ0pjcx0+nt8MUnt6W8liH9hWi
	 TDRSZPQqe5orw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Thu,  9 Jul 2026 07:05:40 -0700
Message-ID: <20260709140600.90950-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prepare_access_checks() DAMON ops callback sets the monitoring sampling
address per region.  In future, DAMON will be able to call only
apply_probes().  In this case, applyy_probes() may need to do the
sampling address setup, to minimize unnecessary regions iteration.
Update the protocol for the request.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++--
 mm/damon/core.c       | 2 +-
 mm/damon/paddr.c      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d8251c83e6e55..3c2a4d673bf62 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -647,7 +647,8 @@ enum damon_ops_id {
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
  * @apply_probes should apply the data attribute probes to each region and
- * accordingly update the probe hits counter of the region.
+ * accordingly update the probe hits counter of the region.  It should also
+ * &set sampling_addr of each region if ``set_samples`` is true.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -665,7 +666,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
-	void (*apply_probes)(struct damon_ctx *context);
+	void (*apply_probes)(struct damon_ctx *context, bool set_samples);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 327398fa4ee56..9fbea6204520b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3692,7 +3692,7 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx);
+			ctx->ops.apply_probes(ctx, false);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6172464981730..b13bf7c6eade3 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -166,7 +166,7 @@ static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
 	return pass;
 }
 
-static void damon_pa_apply_probes(struct damon_ctx *ctx)
+static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-- 
2.47.3
