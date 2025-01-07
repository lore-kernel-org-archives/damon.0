Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2E1F75B1;
	Tue,  7 Jan 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281092; cv=none; b=L1LOXYW7Jm/oYt5op06Dnm+kC3X06HweC2QZYHkDOHXlJ9/HkQWuicKtDpS3YClHS5hlT9FkdVl1u2C/Xzx4yXeL0yxPrimvAKFHVFtNCvyw1JB3RJKs+chFW5xwFhOq0tJl0eY0Bcef1IipjRXR14nhII0XziM4R/VxGeKSSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281092; c=relaxed/simple;
	bh=8dJ+7o3sCM8L0VHB+MIi4xnhlr9EGI5a92hneWpjd7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubfw2OckpW63zX4Q1PgwFPZvyEfdeehFqYWSgsbe8TUTL69dPWN7KHH+UafR3UUzq0lCds9JNCkclUBFUGhM/B5RkEQGueiwyX7thwykNX36vIjsclsxOTbFbylQ+ce0+WOXzHxyhNJ0Cj5G1ybUkUYa346j1qiFcfjB9t4OpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWU0WB/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWU0WB/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6731EC4CEE4;
	Tue,  7 Jan 2025 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281091;
	bh=8dJ+7o3sCM8L0VHB+MIi4xnhlr9EGI5a92hneWpjd7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWU0WB/NlOmPRlgpVp5m6RizW/pJ7oVD8+xl/FMKgbU+0l849UfMQ+bx5pW52r/0c
	 BhraHHr+hJTeDKyZWncd/S20vMMjbhTnHWP80XDrChQe5eXeoDOqFUHwSXm4oYxeW9
	 OIei9pW07xsVcqt8umUfH4Aq2WKPjmPC8JR3CjgGOSgM0M5+LbKE1Zvlz418cHYKy9
	 O+dLe6tmh+Gf+eEUjfh7ilHJL8FKyHiTpBstSaqYLvEphpK2h5W3+UCowXPsKMPrB+
	 IApVUYru99Kv9kHVsac+1s1qT3KXq6ayNiit4h1VoypnP+BdLicKGj95Vu012enfPx
	 3KtCbp1sNaPHQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/10] mm/damon/core: support damos_filter->pass
Date: Tue,  7 Jan 2025 12:17:32 -0800
Message-Id: <20250107201739.79484-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Respect damos_filter->pass from core layer's DAMOS filed handling logic,
by making the decision to pass a region in the middle of the filters
evaluation depending on the damos_filter->pass field.

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
