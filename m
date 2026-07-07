Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA92BE035;
	Tue,  7 Jul 2026 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399144; cv=none; b=mpjaE98MIZEJwBSKiKUeF7BbeYwvTJNRCbM3FAd4Sun4LADwutH2Kxk349DIAIFYvAmW5q+StYNGiXSPctTKAFHG2m4rqfQWap9dOjvhPXb7CFLc+VRWeysPzoCC+fwT6011GGKrt0fs44cgq044RxNx03UJ1yc8lPeh+uu/yVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399144; c=relaxed/simple;
	bh=LLkKANrqXdvg8cpLtMyNHNqOVuMAHRBha4e9Br5Xtqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owp+bnPX1vp4ThmDVyGNQvQXhFbnHGM+6QBIw6ImIqWwrwQlfNnXQeCBiDFYgkglLt0KM0E/d2wybxAFC9x5QSwk+FxNcVsCUyISpUdgKCPy7WdQd5aPYL6DWhfSMOCQx7QOeZnoSuYf1M6tPyOhwooU9B8//YrJFp0eUkOihTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/aHaq+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/aHaq+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D285A1F000E9;
	Tue,  7 Jul 2026 04:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399143;
	bh=ZVvyX+i9YcLqEI8iUP4HbyOAHEh9sHxlQLlUbuG5jmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/aHaq+Oq59ENwXN1PSrrleajOoCVvnhCLjcreyOXd1DAVEfnapa2aTv80PrsuAea
	 KWV/VLnGtFuYtyepU7XkL1YqNvYvyY6hs0WkCit7ck1sH0CEY8M4hjMBu6UKTRfOUg
	 rPlMb83mqr4PnCrEK5F3iCl2kwmgavBNqfBuV4KYx2s1C2Z3Wtj7HWo04kThNAevIM
	 08b8JoqL79+Yz6lj0FbfSJe+Mp24tdc/y5CMeDWhEHekjSfw2Yj1GSbiyl/w2HMZhA
	 zRTNXzC7KAOO0hd4v+p5i29LdKwzKDeoM+vSykmnhPuFU8u3Ke5Y8UX3W3/1YRfPzK
	 o9n+pAby5fZTQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/6] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Mon,  6 Jul 2026 21:38:23 -0700
Message-ID: <20260707043828.97900-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707043828.97900-1-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_to_accesses_bp() actually converts a positive sample
count to the ratio.  Rename it to better describe what it really does
and not confusing for more general uses.

Also remove the obsolete comment about division-by-zero.  Commit
35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
damon_hot_score()") modified damon_nr_samples_per_aggr() to always
return non-zero.  Hence no division-by-zero of the note can happen.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 17 +++++------------
 mm/damon/tests/core-kunit.h |  8 ++++----
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ca530faaa4f83..718268df27fa7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,25 +883,18 @@ static unsigned int damon_sample_bp_to_count(
 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
-/*
- * Convert nr_accesses to access ratio in bp (per 10,000).
- *
- * Callers should ensure attrs.aggr_interval is not zero, like
- * damon_update_monitoring_results() does .  Otherwise, divide-by-zero would
- * happen.
- */
-static unsigned int damon_nr_accesses_to_accesses_bp(
-		unsigned int nr_accesses, struct damon_attrs *attrs)
+/* convert sample count to ratio in bp (per 10,000) */
+static unsigned int damon_sample_count_to_bp(
+		unsigned int count, struct damon_attrs *attrs)
 {
-	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
+	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
 	return damon_sample_bp_to_count(
-			damon_nr_accesses_to_accesses_bp(
-				nr_accesses, old_attrs),
+			damon_sample_count_to_bp(nr_accesses, old_attrs),
 			new_attrs);
 }
 
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0124f83b39b83..86eae3a590354 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -575,7 +575,7 @@ static void damon_test_set_regions(struct kunit *test)
 			}, 3);
 }
 
-static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
+static void damon_test_sample_count_to_bp(struct kunit *test)
 {
 	struct damon_attrs attrs = {
 		.sample_interval = 10,
@@ -585,7 +585,7 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 	/*
 	 * In some cases such as 32bit architectures where UINT_MAX is
 	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
-	 * damon_nr_accesses_to_accesses_bp() in the case will cause
+	 * damon_sample_count_to_bp() in the case will cause
 	 * divide-by-zero.  Such case is prohibited in normal execution since
 	 * the caution is documented on the comment for the function, and
 	 * damon_update_monitoring_results() does the check.  Skip the test in
@@ -594,7 +594,7 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 	if (!attrs.aggr_interval)
 		kunit_skip(test, "aggr_interval is zero.");
 
-	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
+	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(123, &attrs), 0);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
@@ -1572,7 +1572,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
-	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
+	KUNIT_CASE(damon_test_sample_count_to_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3
