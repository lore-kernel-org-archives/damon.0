Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75523E330;
	Fri, 10 Jul 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691222; cv=none; b=r/hZjonNN5r/I/SM0tySN9woSj+i1oDJ3fm8sjivdoBcJi2ZKtKwF7Z5eeIAciaOyH8F2XmJBUULAfZZtraB5lhsaomoQXIQfsoI5WazSgIYjarOcWPO8roFsq7yd7klKI/oVIyRcUvHI9PeetmbWBJKPyySs7r4MwkxF+GHjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691222; c=relaxed/simple;
	bh=UKo1R/EKs9cTuGDz1STLEQT1oD/C139mx0UO/5pr1As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhGtngn/l3kMRFD/ShSoICXSo3GLGd40i8NMgwYZZYQACm88tZrVdXwjOUq68S+8FQBdP4EJkTkZYAcQigpehry6NWLOpDpNY+3lep9mYdkgQ50/TQswPSk04vQv6HfcU5ahpM22acHb2pu/KGOqxgXH132p9/wpE9KgRF9qj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN6RGv2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN6RGv2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA231F00A3E;
	Fri, 10 Jul 2026 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691221;
	bh=xQG5oz4wU5m7lLv6nGv8jRYxqbEgbwiFogSXia05QXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kN6RGv2kBQYvnluj9kSRwWn/4/aFEUj7Z34Y5X0eVd8qUpPGhMFyuNQevNjFxixuq
	 Y0zPoQw6R6zx43FjqD6+qcXi8jeiqt1a1sm+xtyZ9RAVshdkUwV89cZ4/Akv08x3A8
	 2v2bBTzt7McA7oODOjPbzvnh8vT7wvuoIWfuV0yf+mQ7utlCKHxACrAzcWQgIV1qAb
	 KDDBpgowGiofSckyaaqZ17kLHwH/N7zQ5Sd1KiqYra/SDZejcY2UiL/nsYggVSMyen
	 mPn+ZPygaxFS3V0gTcEmYTtiGzyOpLZAQ3jHs2fMGZbygdnVOl0B7dBpqxKBDCv2VX
	 5Hdsh6MN88BVw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Fri, 10 Jul 2026 06:46:31 -0700
Message-ID: <20260710134651.18084-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
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
index d8251c83e6e55..aee28b05acc6c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -647,7 +647,8 @@ enum damon_ops_id {
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
  * @apply_probes should apply the data attribute probes to each region and
- * accordingly update the probe hits counter of the region.
+ * accordingly update the probe hits counter of the region.  It should also
+ * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
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
