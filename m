Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768B1C3BF4;
	Thu, 26 Dec 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251302; cv=none; b=CE9WOOS0V21cTQExrIBVSh0elDPLGnBINA4SN4+ZwoxlzPJMM9NZKaHfFgYbUZ9GXb3C3YMSgGjDEY6t0qVUFSbKPkw8ttg0rLV1NG3qJU/KpMFHSKxBPBQdAEvij5FmdYkxQlyoXj3g0zCqFjjTXrR3q6FEU5W7OdC4FFUGaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251302; c=relaxed/simple;
	bh=8lAFL71XcvweH0oiSZgfTeKqV2YhADAZUO4RhEVof+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1+WKKMx4UtlRmDaVuuVd57yqs2kkNClBVoitNCcgtCiil6Y86rchHsZ2CaqaYJapDEHjfrnogvuOv+UQxehZnJMHy+pGuOL7Kgpctc3mZwLWTA99wIdJwAYpJ5RhDiz65hz/aa/LSOBbJkYJQJY7LIU2IDqBGccigIvd4fWYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9IcquRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9IcquRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0557DC4CEE0;
	Thu, 26 Dec 2024 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251302;
	bh=8lAFL71XcvweH0oiSZgfTeKqV2YhADAZUO4RhEVof+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9IcquRomrqtfrXinUoNaq9+LqgDLr3RafzI/eSAraalwzMf6S7fnPCgPAl5KxSFw
	 zsy+A0+Lm/+DNxEl1afKWgykWPImxukIdQbwmZrIaOVNqmkekNg+PrRtZa3NB09Bo4
	 dkkUjqXopVWZuXiesXbcCrfoVIDtX/vEtdmG1Qv3TO8cgEz5GG+AFAMDYUqDo/39AM
	 q5X04z4lqWR+cqzPaEqYKmJPkvF+FBDIAuwvhSoghnIpb35DoI48ewPfAtnXIwaZbO
	 78on1CmjcqmTiT9gA90Lgk8Q6EzNCuxGWCkduYpYcP4+n0dmibxe7Nwul8pTFb1KWK
	 StPoR5Bi2E2ZA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/10] mm/damon/core: support damos_filter->pass
Date: Thu, 26 Dec 2024 14:14:38 -0800
Message-Id: <20241226221445.78433-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core logic is ignoring damos_filter->pass by assuming the value
will be false.  Respect it by dropping the assumption and reading the
field when making the decision to whether filter out or in a region.

Note that DAMOS action can be applied to any memory if no filter is
installed, and DAMOS filters work only for memory that satisfies the
'type' and 'matching'.  Hence installing pass filters without any block
filter after them makes no filter-behavioral change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             |  6 +++---
 mm/damon/tests/core-kunit.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e54bd19d6f06..71db2c754e6d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1374,7 +1374,7 @@ static void damos_update_stat(struct damos *s,
 	s->stat.sz_ops_filter_passed += sz_ops_filter_passed;
 }
 
-static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter)
 {
 	bool matched = false;
@@ -1428,8 +1428,8 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, s) {
-		if (__damos_filter_out(ctx, t, r, filter))
-			return true;
+		if (damos_filter_match(ctx, t, r, filter))
+			return !filter->pass;
 	}
 	return false;
 }
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index cf22e09a3507..8f58d3424c21 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -434,25 +434,25 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 2;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = DAMON_MIN_REGION * 6;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 4;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
@@ -465,7 +465,7 @@ static void damos_test_filter_out(struct kunit *test)
 	/* region started in the range */
 	r->ar.start = DAMON_MIN_REGION * 2;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
-- 
2.39.5
