Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8A187346;
	Wed,  8 Jul 2026 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478945; cv=none; b=sfnHQqZF2qYL784VUwTppbi9awds1dqOp191H6ua2IT6rpUC8z0IG9MpYgelWtQg2VX53Yjdx/cCYjAtMVzpPw88VuL4KUIhTyRYaVigdZizkfjGrKJlyGyhhoPCihzU45XIVgu6VgvNh65pO97F6eYOH7mxx8w6q/giCkgTT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478945; c=relaxed/simple;
	bh=eBwh706E3X6WsH5bMvInECx49yjmnCa1e4AZLckhZIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+bUviqinm5tnUJytTZK0NVtHusbX6ocW+kag489gkQQEVnaCWoiOz47yPhDuQcHyb59GdAsK6mVNFv5sysdhsKZ2TsWPEnMRO6tvqKGQjmJkMXkJ2LwR3ixOu0P+EB3Cba+Fwul1mrD1rJJIxtsr2VjRxoPOT1+k8l2NHiwYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqriC04w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqriC04w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F2C1F00A3D;
	Wed,  8 Jul 2026 02:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478944;
	bh=JCC9FMAOFAsuAQp9u1XHHxd8HHnGHTKjPJp30Yo3v74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZqriC04w3Ae7ID7pH6eyKY1qnkdT8nCo69YhVoPpjA4o6zWTh8u/iana8L6YTXxXS
	 MV+s/CtR9xqcvu8lEavSitFKwh64iW1OSEu730zltUvFhiJhIuNeGeRtYJ2cdE2ZFa
	 t9rDYSnk8NbyEpD9vxX9BBDJ4mCOFEYcJjE8L45qNjzibXSWcQhFFMyXq+0S45rZay
	 Iz7zAkjqWW+onqp9r6m3cC0HjFGxWzlXP3QqtMQ2Or/LChU7487TfT9a4/t1MFDLjZ
	 UmelNBlJdYMy2AD4RF9FvBK7vqU/kUeVaxkzNdmGehy2R0+YAdLzSGo8NbZrY9OdWi
	 xkUK/GBpvmzrg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 1/7] mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero
Date: Tue,  7 Jul 2026 19:48:47 -0700
Message-ID: <20260708024855.116614-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708024855.116614-1-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h | 23 -----------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

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
index 0124f83b39b83..278d46632eff4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -575,28 +575,6 @@ static void damon_test_set_regions(struct kunit *test)
 			}, 3);
 }
 
-static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
-{
-	struct damon_attrs attrs = {
-		.sample_interval = 10,
-		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
-	};
-
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
-
-	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
-}
-
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
@@ -1572,7 +1550,6 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
-	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3
