Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446580;
	b=sS9g2kv9IowwNbqYOCYudQuYHJmBJh5P9rohqBShGmjRII6SDq8wDkoNMmFsTewPg69M
	 OgxlTUky9nTgYmLfwuNZiKMyXb9zn0xXyFPBPSoxo+ZRjOJ25MsiTHjNoyZMjjbPkc7Fb
	 LnBJL9ma6A2B2Re4DM+H4lBD7FF/em/JQiNOUkfeh1AcrcAPZvFJkIAbMejdvZUey2a4u
	 Q1c5xnJ2KsQEZMJtEWKMe9kMbBrAY69ulpxJlIa6sZLiZtv5Z2tG9OmlSERELsM1F5Ly4
	 xTz9QmLDuzGXW0HVmQRvLku1bCqgjiclLhC0Cc/X7AtEC3IEIgE+wWBJHs9YvOVBOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NyOktFiiDK2ucPq8E+Ur0m2cBgjFWaJL3PEUR7BXbI8=;
	b=nHc8zChMySZVGuNB7lIoQV2/8WDCMWivc+hpWGLerTKSb2JUeceJbg7rDCEavXH7tReI
	 VnTpnAP6Q9Q64EWZRNEKXbtEajvHcoJzs6hOTdd2TguIJHcgC1IymQ3U3iK44pqQBe5wf
	 NDDx8+fN2kyOdxDGucEPYcDSTnAZAYqgpzg1ORA5H+YKSL49MwyDgP+V/0jjKrcwbreFy
	 /5mHK30Nyx0oPmLy+5KCm4MhrBfWkCohTT7D5tZdUM6ktQCmtKVOp9Ac41uJiWcBM25DF
	 3qlPhRclDAjWcjDzWNeLv6qVKOOI8vGGLPja6W8C5Jyqib33V8H4MAxy1QAevLtCTmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzkwPKUh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE0606A31A;
	Mon, 23 Nov 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzkwPKUh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF45E1F000C6;
	Mon, 23 Nov 2026 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446580;
	bh=NyOktFiiDK2ucPq8E+Ur0m2cBgjFWaJL3PEUR7BXbI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YzkwPKUhz87lk+UO0uia0fJp82Y0FG56zyiDzzVQ4bo4fpAfGMut+r7wsI5F4qdZG
	 fnVZV6VyJ6Mcdydv1gvzbY23GNEwm/JxnLqzRZfZ2fTPtzdDu2fqMcBz+nlUIZ8WDW
	 yhCW38hYEmMyvCD5XXAwRuJMCGObEL/tcbEdukBJLEl+J1H8epYf75pRwKQi12fMUb
	 TPLkrwYN5L7xf7X9uwD8+qi47PnccRxmp7/PwuzcnC1tS8bo591k5zOVBld/Fw53Sp
	 8WquC6AIE7VcJcK/+8Sg4Kx/bNFuvIyMgTi/8zZbMUFjJVt1KzvDjDTjEoxUbLmCpd
	 d8Cm5JH8I5+Pw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Angelov <jasonangelov@ucla.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v3 3/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval changes
Date: Mon, 23 Nov 2026 07:09:27 -0800
Message-ID: <20261123150929.81797-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123150929.81797-1-sj@kernel.org>
References: <20261123150929.81797-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Angelov <jasonangelov@ucla.edu>

DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
milliseconds to filter for target regions. Aggregation interval can be
changed by users or intervals auto-tuning features.

Add a kunit test for each:

- convert region age to milliseconds, correct behavior at boundaries
  for defined filter range
- DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
  aggregation interval changes

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 156f74832c405..3b2b745b85469 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1838,6 +1838,71 @@ static void damos_test_age_ms_filter_is_core(struct kunit *test)
 			damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
 }
 
+static void damos_test_age_ms_filter_interval_changes(struct kunit *test)
+{
+	struct damos_filter filter = {
+		.type = DAMOS_FILTER_TYPE_AGE_MS,
+		.matching = true,
+		.range_min = 200,
+		.range_max = 400,
+	};
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	int err;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(ctx, t);
+	r = damon_new_region(0, DAMON_MIN_REGION_SZ);
+	if (!r) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+	ctx->attrs.aggr_interval = 100000;
+
+	/* An age of 100 ms is below the 200 ms lower bound. */
+	r->age = 1;
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* An age of 200 ms matches the inclusive lower bound. */
+	r->age = 2;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* At a 200 ms interval, age 1 matches the lower bound. */
+	ctx->attrs.aggr_interval = 200000;
+	r->age = 1;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* An age of 400 ms matches the inclusive upper bound. */
+	r->age = 2;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* At a 50 ms interval, age 8 matches the upper bound. */
+	ctx->attrs.aggr_interval = 50000;
+	r->age = 8;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* An age of 450 ms exceeds the 400 ms upper bound. */
+	r->age = 9;
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	damon_destroy_ctx(ctx);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -2600,6 +2665,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_age_ms_filter_is_core),
+	KUNIT_CASE(damos_test_age_ms_filter_interval_changes),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
 	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),
-- 
2.47.3
