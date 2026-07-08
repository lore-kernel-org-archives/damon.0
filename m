Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6A176FB1;
	Wed,  8 Jul 2026 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474379; cv=none; b=OsC+O4/D1eRT78yhrXIxQO+ZDk8MVHKKfrt3v9POZqTTmRC5S28Bzol39rz2RnwCgBfa+LukELugfaISTu5xyrgcBLi9S+2Uja+zhKLP2MFAQmoQn0EuLsmAUca38ajsXGpawjMhOQe8hVUaq/nn5YEZ8PXxm8OnvkmSTHcFpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474379; c=relaxed/simple;
	bh=6iKjiQV6+UkInWLgBZgPoEs6/o3+KWbOih+UnuvMqvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTWYs12PYZ73afeGDUkeWZmJXyJeaRCJZ2XhDBdtEo7SxJdAxv2dumtWjuATY+oX7fafQWb8ndYhYvgS1jQ65hpy91XuFv6xSf44JqHU4MBkuNxn5b6Ko9v/lhUvUWb+SoDDdBOEMhHsZ41Qe9KUg8R72AZF7UD1QH6o7VCTsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESVkzhHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESVkzhHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC02E1F00A3A;
	Wed,  8 Jul 2026 01:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474378;
	bh=T+VOUcpSDlU3fuzMuw/UnhEEzVcjPNsnHwRJeSaH3SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESVkzhHw0s2qBTPVfEyF/jPjOX+JKGUFB47v8c78YsrlEtdX4+3//kpYIvSWvNl7m
	 kNS8q5Kx4OFadZm/wdtDw8Ql755HvxiUI949gn8+rMy+af7fWGts3/8sMkjzyph6Z3
	 sRpj08NMY9XKUFqH9NHRhf/Qjbdys99kUGRQMXQhY6RIotJqoTTQfdKACgpD0m2yHb
	 l9GJhMKUdGzs+N/9mg0nqCXJAVtBKSemJX20twrXm6L8ohkjIXqN6BfOGPHfqkK75e
	 1Pka7mi1nzq88ogt+z1ijBo2LwMLnvaWNM2zL6v7Fj/+mpdeYTRJ+kAuRaI0smBQIX
	 +0Q5aZNvFdHpQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 1/7] mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero
Date: Tue,  7 Jul 2026 18:32:44 -0700
Message-ID: <20260708013252.95888-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708013252.95888-1-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments on damon_nr_accesses_to_accesses_bp() and its unit test
warn it can trigger division-by-zero when the aggregation interval is
zero.  Commit 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme
intervals in damon_hot_score()") modified damon_nr_samples_per_aggr() to
always return non-zero.  Hence no division-by-zero of the note can
happen.  Remove the obsolete comment on the function.  The test code was
written to test the division-by-zero case, which cannot happen anymore.
Having it makes no sense.  Entirely remove the test code and its
comment.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             |  8 +-------
 mm/damon/tests/core-kunit.h | 25 +++++++++----------------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 390e00b3685ef..a15005db82899 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,13 +883,7 @@ static unsigned int damon_accesses_bp_to_nr_accesses(
 	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
 }
 
-/*
- * Convert nr_accesses to access ratio in bp (per 10,000).
- *
- * Callers should ensure attrs.aggr_interval is not zero, like
- * damon_update_monitoring_results() does .  Otherwise, divide-by-zero would
- * happen.
- */
+/* Convert nr_accesses to access ratio in bp (per 10,000) */
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0124f83b39b83..b2a280556b841 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -575,26 +575,20 @@ static void damon_test_set_regions(struct kunit *test)
 			}, 3);
 }
 
-static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
+static void damon_test_max_nr_accesses(struct kunit *test)
 {
 	struct damon_attrs attrs = {
-		.sample_interval = 10,
-		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
+		.sample_interval = 0,
+		.aggr_interval = 0,
 	};
 
-	/*
-	 * In some cases such as 32bit architectures where UINT_MAX is
-	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
-	 * damon_nr_accesses_to_accesses_bp() in the case will cause
-	 * divide-by-zero.  Such case is prohibited in normal execution since
-	 * the caution is documented on the comment for the function, and
-	 * damon_update_monitoring_results() does the check.  Skip the test in
-	 * the case.
-	 */
-	if (!attrs.aggr_interval)
-		kunit_skip(test, "aggr_interval is zero.");
+	/* Zero aggregation interval doesn't cause division by zero */
+	KUNIT_EXPECT_EQ(test, damon_max_nr_accesses(attrs), 1);
 
-	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
+	/* Too large aggregation interval doesn't cause overflow */
+	attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
+	KUNIT_EXPECT_GE(test, damon_max_nr_accesses(attrs), 0);
+	KUNIT_EXPECT_LE(test, damon_max_nr_accesses(attrs), UINT_MAX);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
@@ -1572,7 +1566,6 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
-	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3
