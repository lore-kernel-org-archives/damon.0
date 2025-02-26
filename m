Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295C271816;
	Wed, 26 Feb 2025 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551829; cv=none; b=oOokVmsrldH42XI1vZYfy3j3x9MFBWFbRkWnJtqEm9FwW48GOugCzessHFQX705tagpS0kT9fjHaaYiv/wLBJ4VpXdDbCDNfpu44ln+W8eVImKsIR2ShNfjqa8Z1C31d6BG3/u+ljeGfTwzFDFufEHoYaF7hIEnu5B/3qkqXnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551829; c=relaxed/simple;
	bh=tR7XrAvAqL9tgp0wezUMza5484QErgFfXZf5Rw+Zt88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMqtNqsMSoXcSFOaLPK5hIeOWNH1dd7ZGIb4AwUsHG4KseVzn0usiDIGVunHNWnDOt1vGUh+P+0eWtQW726wGgn7H4WlSxIZUPc9ELG4aJROxTpYtKNfQJtRsleuRCh6s/vrdbxaYk4kqXUmi6Hz/fBRh5iXMsV2S3VyYq78uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkC3trE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkC3trE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C407C4CEE2;
	Wed, 26 Feb 2025 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551829;
	bh=tR7XrAvAqL9tgp0wezUMza5484QErgFfXZf5Rw+Zt88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkC3trE48rYxCFFDy66tykiWPjoMbZBsb/HBH52ZAkninFLJ0O7MByribphGwbMXz
	 KLyVk3wtX2t/4Y0G1+C3lCFJJtVUbu69r17GBdwwItO1VXWf3YcRODWw7dXkn0AuAE
	 phXZP9tRtyKsqQZ0MbG+9Qfyf7IP+CPFby3/BLT18JYgoBHCuZks1Cw+zk79o+PzpW
	 uSl6vMNooIM3pr8B6TzmOWAUwvxvYIavDbJQouMkMxLaR7GHAXpqTFmi/H1u6KuAFm
	 zTkjponpdS4dehkyARKICzrcYji2/gmUJN+SIFQgkB1I12AaeUXdMzH/18G3MFPeHx
	 9yDRcptpIKLMg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 13/13] mm/damon: remove damon_operations->reset_aggregated
Date: Tue, 25 Feb 2025 22:36:51 -0800
Message-Id: <20250226063651.513178-14-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
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
index 2808ea07e1cc..957c7f3af80f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -537,7 +537,6 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
- * @reset_aggregated:		Reset aggregated accesses monitoring results.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -549,8 +548,7 @@ enum damon_ops_id {
  * (&damon_ctx.kdamond) calls @init and @prepare_access_checks before starting
  * the monitoring, @update after each &damon_attrs.ops_update_interval, and
  * @check_accesses, @target_valid and @prepare_access_checks after each
- * &damon_attrs.sample_interval.  Finally, @reset_aggregated is called after
- * each &damon_attrs.aggr_interval.
+ * &damon_attrs.sample_interval.
  *
  * Each &struct damon_operations instance having valid @id can be registered
  * via damon_register_ops() and selected by damon_select_ops() later.
@@ -565,8 +563,6 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
- * @reset_aggregated should reset the access monitoring results that aggregated
- * by @check_accesses.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -584,7 +580,6 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
-	void (*reset_aggregated)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 22f90666fe16..6f821a579257 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2463,8 +2463,6 @@ static int kdamond_fn(void *data)
 
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
-			if (ctx->ops.reset_aggregated)
-				ctx->ops.reset_aggregated(ctx);
 		}
 
 		if (ctx->passed_sample_intervals >= next_ops_update_sis) {
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fee66a3cc82b..e5b532340102 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -618,7 +618,6 @@ static int __init damon_pa_initcall(void)
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
