Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31331E048B;
	Mon,  6 Jan 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192052; cv=none; b=rjRrr3WZiNZOnnzrZ66X1x60xAAckXymlqAAX9y+fkc9xs9IQ4U36+zjb4d2xj1pv249mi5tHUvTmT402JAVpyeSRMkf6JsGqiPepGY9klX7q7rJOO7SAKRPagbStirEZX3FERqKYEroer+yU3yvqkPRKSqeq4R+P3jwawqjnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192052; c=relaxed/simple;
	bh=gyDMV+FruyDhiWfk/GjklBAZlivUpb/zLxkaa/kITkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNUIlchrycVumhOL7JubC0cEvBXyZ8nHqfqYwSONmPyaI2S4jIHFhSrdrww4lVR6AMw1Y8B2cNHJKbST1vNwDYHemISw5gbl/IWGX+DFMyMBMZmkwGuWIZWeISs4eZOrtYBr0FV32pRafDLS6FKLqX1SrLXKkLCUqASePi9HGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soICbBBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soICbBBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D61BC4CEE1;
	Mon,  6 Jan 2025 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192052;
	bh=gyDMV+FruyDhiWfk/GjklBAZlivUpb/zLxkaa/kITkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soICbBBh6s9kcuWQgnfb1X77qFDfSe5g4Wyx2wZ8l/+vVknzQlnb6EOPWet++HK/D
	 833R1jvhQ3C8nR3Gp9aV+hilEbMoVTzbMW8Fes+p5nijob1BeP6UK06HiAK9ilzY8p
	 H+Ei6gFOZyK2Fy57LuN9MMMgsIHdZYJx8LMjy0gUb82EcxsChqIEJg5xiVZH8wDvMg
	 ocp3tHQf/mtk54LnOUu18i8wSnGKokU+Oq1BVKE0pqGFdM2JZjcVrTRoBQl+4PrvsI
	 3n2vbt8hCkuqc7/6bUxCmWOovS8Qz+j+eWiv9Kxez3Oj8b9ZFuSBf7UmEBnCzALGub
	 YeKBQnvt/3Kjw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/16] mm/damon: ask apply_scheme() to report filter-passed region-internal bytes
Date: Mon,  6 Jan 2025 11:33:49 -0800
Message-Id: <20250106193401.109161-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DAMOS filter types including those for young page, anon page, and
belonging memcg are handled by underlying DAMON operations set
implementation, via damon_operations->apply_scheme() interface.  How
many bytes of the region have passed the filter can be useful for DAMOS
scheme tuning and access pattern monitoring.  Modify the interface to
let the callback implementation reports back the number if possible.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++--
 mm/damon/core.c       | 4 +++-
 mm/damon/paddr.c      | 2 +-
 mm/damon/vaddr.c      | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b85eae388f5b..da003173210f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -529,7 +529,8 @@ enum damon_ops_id {
  * @apply_scheme is called from @kdamond when a region for user provided
  * DAMON-based operation scheme is found.  It should apply the scheme's action
  * to the region and return bytes of the region that the action is successfully
- * applied.
+ * applied.  It should also report how many bytes of the region has passed
+ * filters (&struct damos_filter) that handled by itself.
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.
@@ -546,7 +547,7 @@ struct damon_operations {
 			struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
-			struct damos *scheme);
+			struct damos *scheme, unsigned long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d02a7d6da855..c6ccb4825c57 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1523,6 +1523,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
+	unsigned long sz_ops_filter_passed = 0;
 	int err = 0;
 	/*
 	 * We plan to support multiple context per kdamond, as DAMON sysfs
@@ -1568,7 +1569,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (!err) {
 			trace_damos_before_apply(cidx, sidx, tidx, r,
 					damon_nr_regions(t), do_trace);
-			sz_applied = c->ops.apply_scheme(c, t, r, s);
+			sz_applied = c->ops.apply_scheme(c, t, r, s,
+					&sz_ops_filter_passed);
 		}
 		damos_walk_call_walk(c, t, r, s);
 		ktime_get_coarse_ts64(&end);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a9ff35341d65..3530ef9c80bd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -477,7 +477,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+		struct damos *scheme, unsigned long *sz_filter_passed)
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b9eaa20b73b9..a6174f725bd7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -655,7 +655,7 @@ static unsigned long damos_madvise(struct damon_target *target,
 
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+		struct damos *scheme, unsigned long *sz_filter_passed)
 {
 	int madv_action;
 
-- 
2.39.5
