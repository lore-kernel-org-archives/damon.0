Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C933A6EEE;
	Sun,  5 Jul 2026 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285077; cv=none; b=BockHfvmqD/tn2C3eKZWBbKUPww6KJqpqx2ckc9yifDFk5j4Oe3hQbxkyAYGfgJ60yfxCE4TFox7PYqCbam5x6R1lJjcJN+xNQwRe+ElKJDPLPKdLzWOIFNy8zaG+XydLGEtGuPasNuNpTUX9zdD6IrxPjLgJNtRPEhJSoyqdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285077; c=relaxed/simple;
	bh=41NjS+2Z8tpYQB/gJVbUQh+Ikjtoxcx5S4sNhH1RQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCtU9lq248jLEbdGscRFwnhOFQbY8uCijiwLxrZx3Eg8G0h4cbBhIMpwIt71rfer2oh7wyzst4uhpdGML6+a4AmFo4HEpOXITjlsRUCfid49pDmTcxNTC64CyiHWXQMn2y8WWs100+y19bg1akiNpnODQPKY8l9RZQDPRHpbacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjv1oc/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjv1oc/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E41F00A3A;
	Sun,  5 Jul 2026 20:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285075;
	bh=htrax+YEkIpwzkVsZ772n3CN6MFRqmzSggoIknmGl8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mjv1oc/pY7TfEO0YiU0zPERP+Mcq0Z/w0USJfgQy9jPMz3AO59Dah6TbwUa8zgVvw
	 6hLFaaQyIoGwXxj/Tbk4HImIUBsetghMUNnk+Ppx/eRHGH6/PNo12oheUcQFfdGMz9
	 3mXDYvpZ+0k7I631PZgtOiX9615szMMmS6aYONAQXMZfyFqpBfpdWJbjyO2EPXwLzO
	 xmPb3Wb2Fz0Sj7ZpQV7e6Rep1nOOXZbayToaf+i9gHHKvHirRH9BCMqEfrG9yEeNUh
	 lJ2HTW+bSwmeV9drH0h0FKlExQL0mP2gWtZcRNGtU5wcBxlaZUd7S3ig2pHe+uuElb
	 ACqRxrkzOxroA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/16] mm/damon/core: extend merge function to work with probe hits
Date: Sun,  5 Jul 2026 13:57:29 -0700
Message-ID: <20260705205743.98656-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
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
 mm/damon/core.c             | 48 +++++++++++++++++++++++++++++--------
 mm/damon/tests/core-kunit.h | 13 ++++++++--
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d7d1e27d767eb..9bb884ab135ec 100644
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
@@ -3231,6 +3236,16 @@ static void damon_merge_two_regions(struct damon_target *t,
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
@@ -3239,24 +3254,37 @@ static void damon_merge_two_regions(struct damon_target *t,
  * sz_limit	size upper limit of each region
  */
 static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
-				   unsigned long sz_limit)
+		unsigned long sz_limit, struct damon_ctx *ctx)
 {
 	struct damon_region *r, *prev = NULL, *next;
+	bool use_probe_hits = damon_has_probe_weights(ctx);
 
 	damon_for_each_region_safe(r, next, t) {
-		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
+		unsigned int score, last_score;
+
+		score = damon_merge_score(r, false, ctx, use_probe_hits);
+		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
+
+		if (abs(score - last_score) > thres)
 			r->age = 0;
-		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
+		else if ((score == 0) != (last_score == 0))
 			r->age = 0;
 		else
 			r->age++;
 
-		if (prev && prev->ar.end == r->ar.start &&
-		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
-		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
-			damon_merge_two_regions(t, prev, r);
-		else
-			prev = r;
+		if (!prev)
+			goto set_prev_continue;
+		if (prev->ar.end != r->ar.start)
+			goto set_prev_continue;
+		if (abs(damon_merge_score(prev, false, ctx, use_probe_hits) -
+					score) > thres)
+			goto set_prev_continue;
+		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
+			goto set_prev_continue;
+		damon_merge_two_regions(t, prev, r);
+		continue;
+set_prev_continue:
+		prev = r;
 	}
 }
 
@@ -3289,7 +3317,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit);
+			damon_merge_regions_of(t, threshold, sz_limit, c);
 			nr_regions += damon_nr_regions(t);
 		}
 		threshold = max(1, threshold * 2);
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0124f83b39b83..fe948000b72cf 100644
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
