Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296925B0B3;
	Sun, 21 Jun 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057466; cv=none; b=JdqaSZlcnrKkF8EMGjdJ+wBbtZLybUCd+D9Mn1X51KGCqtl+QF8yyG67Kr4CXoDqy2sp2gwsZROhu1eR5YYTOH5v99MQoOz5NfmBCQSHo6u5EWAFIoNElRUj8fnW7RHWN5FQgdmsvPo3uHPpiI3QdKPXyWOlZtwDQP6kA1Pf5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057466; c=relaxed/simple;
	bh=EtModOMGan7vSQcVFCoMs2YaHjJT74HYwU0tTy77kE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4EmVZcDNLRSzn9SC3mS/Fxig2XxPiu9ZMfx8VYxhHCjeAk6yfYCk4MMpOVJoPp7xr1fGL19C8VMZ0GkRi9QZR1CJKB2PsISxKwGNefP8GhG0fQzBRwcDrARa/WQGSjx3eAvKYgBBYf9x/dscT3B/J8cw7tK0H9s5aV9BYb8xRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieUGizRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieUGizRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E351F00A3A;
	Sun, 21 Jun 2026 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057464;
	bh=sKw7x2CXNs6bqiqh92iTOYiiNqe5DL6LY5pildJccFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ieUGizRaO1O6EdEY+2X9rHBPopLOwwdoscwzW01KVXR38nTeXJNcpIj+qDWGscvcI
	 qkYfmDEJVKIUjAKfpqdTxqgNev6Zzw71Oa9me0SKbegyQqaAHg85/1yS0XrlwDA7oI
	 PCgR1CH9KfCC62S7O4gu6brTsBsFryWo+vS7Deb6W1+YkN1CEr4iXbWUB/NktVUjUt
	 Q5tVQ27jy0JauF1Yf9O48lwmdVBGRVIltbXUXFBlqukfPFnPuDCQt8bWtJHy8FvyTl
	 a1P1Z8Ai21vwwe0o71gPQJebgSMzT2LQuOZeLNOuxjktKSbq+mFs+TMulDwJGsTHu9
	 VJLbNub1ykRlA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 16/17] mm/damon/core: remove damon_moving_sum() and its unit test
Date: Sun, 21 Jun 2026 08:57:12 -0700
Message-ID: <20260621155715.87932-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_moving_sum() is no longer being called for real purpose but its
unit test.  Testing a function that is not being used for real users
makes no sense.  Remove the test and the function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             | 40 -------------------------------------
 mm/damon/tests/core-kunit.h | 16 ---------------
 2 files changed, 56 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6b36e17660c05..6542ebf13d4d8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3724,46 +3724,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 	return damon_set_regions(t, &addr_range, 1, min_region_sz);
 }
 
-/*
- * damon_moving_sum() - Calculate an inferred moving sum value.
- * @mvsum:	Inferred sum of the last @len_window values.
- * @nomvsum:	Non-moving sum of the last discrete @len_window window values.
- * @len_window:	The number of last values to take care of.
- * @new_value:	New value that will be added to the pseudo moving sum.
- *
- * Moving sum (moving average * window size) is good for handling noise, but
- * the cost of keeping past values can be high for arbitrary window size.  This
- * function implements a lightweight pseudo moving sum function that doesn't
- * keep the past window values.
- *
- * It simply assumes there was no noise in the past, and get the no-noise
- * assumed past value to drop from @nomvsum and @len_window.  @nomvsum is a
- * non-moving sum of the last window.  For example, if @len_window is 10 and we
- * have 25 values, @nomvsum is the sum of the 11th to 20th values of the 25
- * values.  Hence, this function simply drops @nomvsum / @len_window from
- * given @mvsum and add @new_value.
- *
- * For example, if @len_window is 10 and @nomvsum is 50, the last 10 values for
- * the last window could be vary, e.g., 0, 10, 0, 10, 0, 10, 0, 0, 0, 20.  For
- * calculating next moving sum with a new value, we should drop 0 from 50 and
- * add the new value.  However, this function assumes it got value 5 for each
- * of the last ten times.  Based on the assumption, when the next value is
- * measured, it drops the assumed past value, 5 from the current sum, and add
- * the new value to get the updated pseduo-moving average.
- *
- * This means the value could have errors, but the errors will be disappeared
- * for every @len_window aligned calls.  For example, if @len_window is 10, the
- * pseudo moving sum with 11th value to 19th value would have an error.  But
- * the sum with 20th value will not have the error.
- *
- * Return: Pseudo-moving average after getting the @new_value.
- */
-static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
-		unsigned int len_window, unsigned int new_value)
-{
-	return mvsum - nomvsum / len_window + new_value;
-}
-
 /**
  * damon_update_region_access_rate() - Update the access rate of a region.
  * @r:		The DAMON region to update for its access check result.
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index d1f019ab6fc25..df16cc070eeb0 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -600,21 +600,6 @@ static void damon_test_set_attrs(struct kunit *test)
 	damon_destroy_ctx(c);
 }
 
-static void damon_test_moving_sum(struct kunit *test)
-{
-	unsigned int mvsum = 50000, nomvsum = 50000, len_window = 10;
-	unsigned int new_values[] = {10000, 0, 10000, 0, 0, 0, 10000, 0, 0, 0};
-	unsigned int expects[] = {55000, 50000, 55000, 50000, 45000, 40000,
-		45000, 40000, 35000, 30000};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(new_values); i++) {
-		mvsum = damon_moving_sum(mvsum, nomvsum, len_window,
-				new_values[i]);
-		KUNIT_EXPECT_EQ(test, mvsum, expects[i]);
-	}
-}
-
 static void damon_test_mvsum(struct kunit *test)
 {
 	unsigned long input_expects[] = {
@@ -1516,7 +1501,6 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
-	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
-- 
2.47.3
