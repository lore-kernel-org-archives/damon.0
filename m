Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E5423779;
	Mon,  6 Jul 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347562; cv=none; b=ulo+U1rK1mWITQXHJZir7nTt1BPzn9wuxXNHCqSq1tgaHFbWNcnaGvn0MyeeGy+I8zZSAD5Hk3VqhR/kZMhuhs36xZHx1j1twHatmGUFpXiKPF17kmctTgb6XVK4tpxup3y1w2XDyoRwYlGp6Pnhg9HP+hZrJTAi8eigl37go2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347562; c=relaxed/simple;
	bh=dAn2kknEL5y8HpQGamzpxhPp5ty80BP4qEbTyv9ZO80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhQ3yxxjUDkAgm72gtl9/5n6uYvBV2inIl8LKEZIWq+oawH5PYfmzT7toHJviU+Ahw9IRuLOrkjbfZ8TcAKFz6zG5OsHSrZL2WzAKK3aXEA6OJWBTZPEh8hJXtGSYakAKw5fHlk2zuvhXdG3imMinK8LNCJAboYFwt7d6q/DknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAIdS8hT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAIdS8hT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39811F00A3E;
	Mon,  6 Jul 2026 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347561;
	bh=MVcZ8SuySZKn8FngCh9i7p2glWkwmhUsyKwlO1n0BtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SAIdS8hTssa89JMZV7IQawnF9hbg/k0YUk20mV/wVERdNlsMEk6/MeH9UMI2RPnwx
	 BRRP9n/9EzQSAdD96+HTSicVA60PYABIEnlxD42tPu1Zp7U2RvJEbLMN1YKt66Yvu4
	 MIL6iD6p5OWF1uF05R7YmsSfu+BRGUsDzFvueWMXgvTk9wcsLq0zAKexzZP8ormfo8
	 HVmDvxF4qY6mfS+CFs2MZxF34wm8kUNwMYDXo02nmLORCrAhE3CIALU3jT9KXejS2e
	 gkQRYAU3xgXZZQyjID4gCR+/lMGvHeSZ9/ktVjPttub+MRkDVknwdfqrB+eSy+4mza
	 PEHLgZ8dBSQtg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 02/16] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Mon,  6 Jul 2026 07:18:56 -0700
Message-ID: <20260706141912.88445-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
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
index 7d0a920fe4b83..4aa606f691f28 100644
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
index ca5c3f3e45fc6..7c0184cb78a50 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3675,7 +3675,7 @@ static int kdamond_fn(void *data)
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
