Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE22780E3;
	Thu,  6 Mar 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283971; cv=none; b=a/+5qCaVnR29UjoV7daLxPN3sohn5Oii7ZFAuRaBwtpOsCugicDLzQskV6gJHhniwlq6DiQhvL5srg/49/xFy8+hdNM/R6bwkJjBUlz+IGLnEuqj9N7Pa2wxDql2ghHyhjHsAAwnS1LQMzrKMNAMoeryBsY9TIVSv4lJyViVdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283971; c=relaxed/simple;
	bh=Rn+6YydnhrV6FETkcIfmvP4YuDQr4oebn96i4+L/goY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/aTumtGoGqvUx67dM3vXlueEsoX28guKqhKfo1gd7YhpE8Kl8mNdNI3Uig9ENy6omPiFgJuWYZy4ltXIKyjkCKzNSOuydxzvCQlsdAUr+M2xA6McxjZ/t40vnvaw0YfId2hoRxUV0pcjxPZ26CHkuX0jbuKheSAxgGUcth8ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLOqrOWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLOqrOWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E640C4CEE4;
	Thu,  6 Mar 2025 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283970;
	bh=Rn+6YydnhrV6FETkcIfmvP4YuDQr4oebn96i4+L/goY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLOqrOWmjdNfeRf4uTFfilXrUOaL0GSy6hMQWsxUT2If3kQvq6UTPuQULqnbC0NZn
	 9fo5jXUGPK0CFGpdYaOcnKVIAEj6wx/i3uexc3urCzkplgnA6CiTAnvtxiq2JRXyGR
	 uqK60K9LqCudw0fkFgiyspQa41ohjAmBNmgVfh4u0/PSzjxTlek38b8SFnPpeGeThw
	 FKTmWUH3bxOdyCiVdpMeDsqqEZ0uZuTRsCAbxd5XT8+O2SXNfC/BjX2GgyMl8iM27O
	 gCjMozI7x4UUkqFr3/B1s+4nUS32ekumybJfXPGl99tntavBZW6wAgYyJt+HG5U1Sn
	 hOgCwGYkq6fZA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/13] mm/damon: remove damon_operations->reset_aggregated
Date: Thu,  6 Mar 2025 09:59:08 -0800
Message-Id: <20250306175908.66300-14-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The operations layer hook was introduced to let operations set do any
aggregation data reset if needed.  But it is not really be used now.
Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 7 +------
 mm/damon/core.c       | 2 --
 mm/damon/paddr.c      | 1 -
 mm/damon/vaddr.c      | 1 -
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index be7b281fb922..3db4f77261f5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -542,7 +542,6 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
- * @reset_aggregated:		Reset aggregated accesses monitoring results.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -554,8 +553,7 @@ enum damon_ops_id {
  * (&damon_ctx.kdamond) calls @init and @prepare_access_checks before starting
  * the monitoring, @update after each &damon_attrs.ops_update_interval, and
  * @check_accesses, @target_valid and @prepare_access_checks after each
- * &damon_attrs.sample_interval.  Finally, @reset_aggregated is called after
- * each &damon_attrs.aggr_interval.
+ * &damon_attrs.sample_interval.
  *
  * Each &struct damon_operations instance having valid @id can be registered
  * via damon_register_ops() and selected by damon_select_ops() later.
@@ -570,8 +568,6 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
- * @reset_aggregated should reset the access monitoring results that aggregated
- * by @check_accesses.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -589,7 +585,6 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
-	void (*reset_aggregated)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d6271fae4dd4..db357892da74 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2489,8 +2489,6 @@ static int kdamond_fn(void *data)
 
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
-			if (ctx->ops.reset_aggregated)
-				ctx->ops.reset_aggregated(ctx);
 		}
 
 		if (ctx->passed_sample_intervals >= next_ops_update_sis) {
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fba8b3c8ba30..b08847ef9b81 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -621,7 +621,6 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
-		.reset_aggregated = NULL,
 		.target_valid = NULL,
 		.cleanup = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index a6174f725bd7..e6d99106a7f9 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -710,7 +710,6 @@ static int __init damon_va_initcall(void)
 		.update = damon_va_update,
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
-		.reset_aggregated = NULL,
 		.target_valid = damon_va_target_valid,
 		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
-- 
2.39.5
