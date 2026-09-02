Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7038E12D;
	Wed,  2 Sep 2026 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328078; cv=none; b=DzOe+Yqx5BY/VIuxdvSSgHWXROHMdWNVsZAmGLduNDxF3K1iMfAiQaI+U5Rg/9hiwKAiyep/Tkw2RXteyciTb9pB9JTCX4XNL5AXPcfVLFyd6LJYY/VFeAWc4zq9JFgUFleaQQo0s0CWEUSQUZ1TZhda+5Hj/kIW4CvQ6RGsLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328078; c=relaxed/simple;
	bh=WrB6oaGrtV4BjGgUUluWgpUehInC5OR0jmjceXAKFUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3j3tTM2QS+EEEjha9KWnyGLal/6eSWrc519Ngr65dc27Lo0WBs+HjPTt9jWubAonCrCdSedjIfGIy8wDOYKBoqEqdEZ7pqYVvQYtyAD2OZSp7Lsx0OgM5qwzb1CzTBRvyYOTYYHdycrY+z5OjsdQtI1S6bf9RKMbo/6+JXVtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J02qS4mG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J02qS4mG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBDB1F00ACA;
	Wed,  2 Sep 2026 05:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328076;
	bh=/OzGA+O2Q4uOwSPOS2Cbn9lXzmSaQwiafB86MxgZx8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J02qS4mG49amT9aL3qy0N/9i1yyI4Gsah5BLEvacx1Fg8/zXD2kzAp0KNcl+fhWuM
	 Je22SK57DqL931haIX85t07X3Ih44MaXddzyX10Ta5vD8SRZ9JLbgybXeIwfhFWfKR
	 TvPESGAR9FjLzwGiy17s6hZ+bHJpi5smnek79MCQaS7uGa/15Jt5Jcw9p84ZcJOMPK
	 X6y4deFY7ltvG+x4scupqqLvulP7xDPYrI9DtvYdSh/ABSCwjNEayrv+abxdqsWehe
	 3FXyr5T22Ay4KFIPEoqjDAdGkIhRuIwCThrf2+WG4+HDGpjkv/k2aQ1K2/S1YtLzmm
	 WCnOIT6zg1bLg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/12] mm/damon/tests/core-kunit: extend set_regions() test for error case
Date: Tue,  1 Sep 2026 22:47:39 -0700
Message-ID: <20260902054747.99370-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_set_regions_for() is designed to test only success-expected
damon_set_regions() calls.  Extend it to cover error-expected calls,
too.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index af26b3d60957b..2bcf3bafe2e29 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -469,11 +469,12 @@ static void damon_test_set_regions_for(struct kunit *test,
 		struct damon_addr_range *old_ranges, int sz_old_ranges,
 		struct damon_addr_range *new_ranges, int sz_new_ranges,
 		unsigned long min_region_sz,
-		struct damon_addr_range *expect_ranges, int sz_expect_ranges)
+		struct damon_addr_range *expect_ranges, int sz_expect_ranges,
+		int expect_err)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	int i;
+	int i, err;
 
 	t = damon_new_target();
 	if (!t)
@@ -487,7 +488,8 @@ static void damon_test_set_regions_for(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, new_ranges, sz_new_ranges, min_region_sz);
+	err = damon_set_regions(t, new_ranges, sz_new_ranges, min_region_sz);
+	KUNIT_EXPECT_EQ(test, err, expect_err);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), sz_expect_ranges);
 	if (damon_nr_regions(t) != sz_expect_ranges) {
@@ -516,7 +518,7 @@ static void damon_test_set_regions(struct kunit *test)
 			(struct damon_addr_range[]){
 			{.start = 5, .end = 15},
 			{.start = 15, .end = 25},
-			}, 2);
+			}, 2, 0);
 	/* Un-intersecting regions should be removed. */
 	damon_test_set_regions_for(test,
 			(struct damon_addr_range[]){
@@ -529,7 +531,7 @@ static void damon_test_set_regions(struct kunit *test)
 			1,
 			(struct damon_addr_range[]){
 			{.start = 18, .end = 23},
-			}, 1);
+			}, 1, 0);
 	/*
 	 * Holes should be filled up with new regions.
 	 *
@@ -550,7 +552,7 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 8, .end = 16},
 			{.start = 16, .end = 24},
 			{.start = 24, .end = 28},
-			}, 3);
+			}, 3, 0);
 	/*
 	 * New regions should be able to be appended.
 	 *
@@ -572,7 +574,7 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 0, .end = 4},
 			{.start = 4, .end = 15},
 			{.start = 25, .end = 40},
-			}, 3);
+			}, 3, 0);
 	/*
 	 * New regions should be able to be inserted.
 	 *
@@ -595,7 +597,7 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 0, .end = 15},
 			{.start = 25, .end = 40},
 			{.start = 44, .end = 50},
-			}, 3);
+			}, 3, 0);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
-- 
2.47.3
