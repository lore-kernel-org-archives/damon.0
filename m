Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986751E32A3;
	Mon,  6 Jan 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192063; cv=none; b=XJQTHl8xBnic0jG3OkhR3kaSMZiUKom4+aW1xCigszWTMxB/JtZ9KvHniTzASzBIvAUMWPfWwhsqoFAQE4JtyfVM07mP+6QmTKL96+kE7azZqzJPdyMagRGrUYGnxJBp8hf93DoWad2lgMMkFGLDo76ANobalXDQeHuDMLS5EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192063; c=relaxed/simple;
	bh=9gn2VJXpZEBUyQ5318wgjN/Yy6FG5EGU1q7w81srFoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rl877v/ZnU/o29ljSsXCDqkRMzpPNQG5NwfsWQHB2b2A0jDNPxkCqIQPLzte2IA+z9C0/MDtw8cIkyroVAzal7HQ+zHk7xLJKPxh+cORfzsqhGp76fgsNKKDESTZgKIW2cVSonkgtQZBZpyL+y38tH9kJyJHgP42iBt057SRbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmGp/YSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmGp/YSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F67C4CEE1;
	Mon,  6 Jan 2025 19:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192063;
	bh=9gn2VJXpZEBUyQ5318wgjN/Yy6FG5EGU1q7w81srFoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmGp/YSKlwkmxzXgv/o8J64JhES9W8mZpq1ly1q8cr951yRnCYYBc+G+O9OJo9Ntm
	 ei/6x1XkBqsB7+53WDs/LFeYPYruqAXoFJS4uE0Gh1vNIkawCPg2i3/p5J3QgX5sf5
	 S4zc+/lU3kLflxuXyEviljbr5aGwT6nwZaGGEQ40outywIoBdGmToxaaIaOEXN0/O9
	 PVJE2m5KmRSwKw5n/VVqglh1OsVZcpoIv02xKb5etGU2G7ULwSSVDX6l4fQLj2Cnm3
	 KMHiaNt3n08C3+ZMUULxd1akv1pG4qpHs2SBQFb10qNzaNH/C5EJyFjIR59VMgiBub
	 a/LKIHGFS6zXw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/16] mm/damon/core: pass per-region filter-passed bytes to damos_walk_control->walk_fn()
Date: Mon,  6 Jan 2025 11:33:57 -0800
Message-Id: <20250106193401.109161-13-sj@kernel.org>
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

Total size of memory that passed DAMON operations set layer-handled
DAMOS filters per scheme is provided to DAMON core API and ABI (sysfs
interface) users.  Having it per-region in non-accumulated way can
provide it in finer granularity.  Provide it to damos_walk() core API
users, by passing the data to damos_walk_control->walk_fn().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 7 ++++---
 mm/damon/sysfs.c      | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2a93dbe06ecc..298b1a831e62 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -388,7 +388,7 @@ struct damos;
 struct damos_walk_control {
 	void (*walk_fn)(void *data, struct damon_ctx *ctx,
 			struct damon_target *t, struct damon_region *r,
-			struct damos *s);
+			struct damos *s, unsigned long sz_filter_passed);
 	void *data;
 /* private: internal use only */
 	/* informs if the kdamond finished handling of the walk request */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c4ce72a86d81..52e50f183ffe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1445,7 +1445,8 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
  * installed by damos_walk() and not yet uninstalled, invoke it.
  */
 static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos *s)
+		struct damon_region *r, struct damos *s,
+		unsigned long sz_filter_passed)
 {
 	struct damos_walk_control *control;
 
@@ -1454,7 +1455,7 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
 	mutex_unlock(&ctx->walk_control_lock);
 	if (!control)
 		return;
-	control->walk_fn(control->data, ctx, t, r, s);
+	control->walk_fn(control->data, ctx, t, r, s, sz_filter_passed);
 }
 
 /*
@@ -1574,7 +1575,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			sz_applied = c->ops.apply_scheme(c, t, r, s,
 					&sz_ops_filter_passed);
 		}
-		damos_walk_call_walk(c, t, r, s);
+		damos_walk_call_walk(c, t, r, s, sz_ops_filter_passed);
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index cf8fb5a963d6..224873ca8aa6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1454,7 +1454,7 @@ struct damon_sysfs_schemes_walk_data {
 /* populate the region directory */
 static void damon_sysfs_schemes_tried_regions_upd_one(void *data, struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *s)
+		struct damos *s, unsigned long sz_filter_passed)
 {
 	struct damon_sysfs_schemes_walk_data *walk_data = data;
 	struct damon_sysfs_kdamond *sysfs_kdamond = walk_data->sysfs_kdamond;
-- 
2.39.5
