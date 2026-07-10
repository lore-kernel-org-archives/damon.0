Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711701FC110;
	Fri, 10 Jul 2026 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643043; cv=none; b=CSlSS+RChdTF2ZZoE32GrA/PPj8as5ukFFYJ+QzSS0KNz8HEIYLqHlgqbV6KXZsL8rmW9Rgk2KM+ZUhzRZLDXVFPImyKduh7ES5xwxuEwJUoaCnhAwHw7F09ktGJHCzwPOVMZ/Oyfvj6+lI2n9NXXy8N0Sc0gIH1DsLRwCHBbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643043; c=relaxed/simple;
	bh=V7Wm8cvBC8lESuZWW2qGFHiwjBepSAz+Y4B0+x2OUOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRP1z5spDgC8ov7KUQpkT/rUO5A26J4anMI8nPOjccEJAnWNuGul1uJbXqQPKQAyknXAur4XCh+o290MkzZlXB/rqD+oIEpZQ8vjt9OwPc8oJSQDicuYqRxX9rv/sxScBwAxLiso/Be7sa3pU0ZhYmSf4ilfLS6A3X5FRrXRxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKL+7zeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKL+7zeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F47E1F00A3E;
	Fri, 10 Jul 2026 00:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643041;
	bh=7ywtTSlgg2gQ8bR9Osnueml1K534EMkMwLNfCemx+LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKL+7zeL8+ZL+GjUzfwQqm3Ct7BGBlRgX4ZKsDixFpponI4Tok+9YZzpNFHP3Mk+f
	 aXSRxRNLkABQHOM1rw7VYwt+PJQvWuk69He9ZU+ckmNGJTzdWawTy1xMi0ooQFomOd
	 qx+7C7tpAyrqb7OkfTfkOvAIjXZhShImnG26Md8SHsalxrNzTzMaBUww5vtoLZkmfh
	 bp/nZ3TOFN99T/Sp+uXJSfTbgQyM2VLyIo6U5kBqRo1mzoARm8uVmNjRe8HhRSyO+q
	 RaMZj8UTZooroWJq04ITWaEfucF8co4B9gyL/Ba6AClWueU9jbG+2tmYXmHOaEL1uy
	 yPpmVLEByYzfQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 08/19] mm/damon/core: extend merge function to work with probe hits
Date: Thu,  9 Jul 2026 17:23:34 -0700
Message-ID: <20260710002349.111414-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probe weights are set, users may want DAMON monitoring results to
be optimized for the weights.  For that, regions adjustment should work
for the weighted sum of probe hits.  Extend damon_merge_regions_of() to
detect if the weights are set, and work with probe hits in the case.

The weights setup detection function is incomplete.  It always returns
false.  It is intentional, so that more changes to completely support
weights can be made in an incremental but safe way.  Until the function
is completed, all changes depend on it is no-op, so DAMON works in the
current mode.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 49 +++++++++++++++++++++++++++++--------
 mm/damon/tests/core-kunit.h | 13 ++++++++--
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4c7e8a12a9b67..7d49420ea26c4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -209,6 +209,11 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
+static bool damon_has_probe_weights(struct damon_ctx *c)
+{
+	return false;
+}
+
 /*
  * damon_mvsum() - Returns pseudo moving sum value for a time window.
  * @current_nr:		The value of the current aggregation window.
@@ -3248,6 +3253,16 @@ static void damon_merge_two_regions(struct damon_target *t,
 	damon_destroy_region(r, t);
 }
 
+static unsigned int damon_merge_score(struct damon_region *r, bool last,
+		struct damon_ctx *ctx, bool use_probe_hits)
+{
+	if (use_probe_hits)
+		return damon_probe_hits_wsum(r, last, ctx);
+	if (last)
+		return r->last_nr_accesses;
+	return r->nr_accesses;
+}
+
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -3256,24 +3271,38 @@ static void damon_merge_two_regions(struct damon_target *t,
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-				   unsigned long sz_limit)
+		unsigned long sz_limit, struct damon_ctx *ctx)
 {
 	struct damon_region *r, *prev = NULL, *next;
+	bool use_probe_hits = damon_has_probe_weights(ctx);
 
 	damon_for_each_region_safe(r, next, t) {
-		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
+		unsigned int score, last_score, diff;
+
+		score = damon_merge_score(r, false, ctx, use_probe_hits);
+		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
+
+		if (abs_diff(score, last_score) > thres)
 			r->age = 0;
-		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
+		else if ((score == 0) != (last_score == 0))
 			r->age = 0;
 		else
 			r->age++;
 
-		if (prev && prev->ar.end == r->ar.start &&
-		    abs_diff(prev->nr_accesses, r->nr_accesses) <= thres &&
-		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
-			damon_merge_two_regions(t, prev, r);
-		else
-			prev = r;
+		if (!prev)
+			goto set_prev_continue;
+		if (prev->ar.end != r->ar.start)
+			goto set_prev_continue;
+		diff = abs_diff(score, damon_merge_score(prev, false, ctx,
+					use_probe_hits));
+		if (diff > thres)
+			goto set_prev_continue;
+		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
+			goto set_prev_continue;
+		damon_merge_two_regions(t, prev, r);
+		continue;
+set_prev_continue:
+		prev = r;
 	}
 }
 
@@ -3306,7 +3335,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit);
+			damon_merge_regions_of(t, threshold, sz_limit, c);
 			nr_regions += damon_nr_regions(t);
 		}
 		threshold = max(1, threshold * 2);
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index d97280270c27b..6ad73559dd8ea 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -226,6 +226,7 @@ static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
 
 static void damon_test_merge_regions_of(struct kunit *test)
 {
+	struct damon_ctx *ctx;
 	struct damon_target *t;
 	struct damon_region *r;
 	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184, 230};
@@ -236,20 +237,27 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	unsigned long eaddrs[] = {112, 130, 156, 170, 230, 10170};
 	int i;
 
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target();
-	if (!t)
+	if (!t) {
+		damon_destroy_ctx(ctx);
 		kunit_skip(test, "target alloc fail");
+	}
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
 		if (!r) {
 			damon_free_target(t);
+			damon_destroy_ctx(ctx);
 			kunit_skip(test, "region alloc fail");
 		}
 		r->nr_accesses = nrs[i];
 		damon_add_region(r, t);
 	}
 
-	damon_merge_regions_of(t, 9, 9999);
+	damon_merge_regions_of(t, 9, 9999, ctx);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
 	for (i = 0; i < 6; i++) {
@@ -258,6 +266,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
 	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static void damon_test_split_regions_of(struct kunit *test)
-- 
2.47.3
