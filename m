Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E33B389E;
	Tue, 28 Jul 2026 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216499; cv=none; b=W8QUp+dBb/bz/ZoTvRKZfbfu6Y8JyPkgC5IEtpTB5UjkMs1PiR7gzeFZ7YbK486Eymcsrr4Dy3VT7YPswATeK7DZ+6XLdcNRqafwsA4Pp+BSGdUZG7K8V3rQUGivkfb66SJg6APWU3lBB8/b/w1UxK6MRVqAp9Q2oBSV9CGiZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216499; c=relaxed/simple;
	bh=ksm+5qWtlIDNUE4ZcDY7dBLrbws8QRNf1G00ZxOqvQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jy/XOQqqjXDDbgTLsqurevWNCd26ym3uKba8pE+uAIa/U3MzSz7lc0vzpCs0zOTBMjH5GEMeE+nwt/76szdZ6/uD/rJOm9uNPYTH0NSsa8TkWamCsB+Hy8WQS4wAT64WnlCjam+FlgFELG/E6DfXNgDhkjd/5bmPMAwLZPmLY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWKgF+b5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWKgF+b5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E12D1F00ACF;
	Tue, 28 Jul 2026 05:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216497;
	bh=Q+iR0WBRty/9e25KNHH96FJIzOaYrwS/QZZkMmGIIoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HWKgF+b568A7QXZBkiF6lBSFi8YLqZvmU8wFu/o14NdL5JyEo2ZNhbjRpC8EJn1xW
	 gJ+aItnXdaYO3v5jdY/kKKNPFsYntTrHQffTswsvCIhrMAWMkbTOAURt1hhGTYUOtO
	 DUgta5B9pZCYoyWRUMa1rVv9CYtI+/Dr6BusFHeKSqnwGbnKHVzwKHiSwTz+UhpgBi
	 y1fHXM1jXSn1UhwVCGAv2wsUG48f7ZvWZg6+p+d6k0wBXL9TNs2zswV+h6HzJkk2Sr
	 1rCtZHnrtHNR12Hz+qz577qmJyNZw4Vp0S/SLt9ti5gWwKda7pX5tmUkUkkAaXe3Zd
	 qBrNad4sl8izw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/10] mm/damon/tests/core-kunit: extend set_regions() test for error case
Date: Mon, 27 Jul 2026 22:28:03 -0700
Message-ID: <20260728052811.192712-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
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
index 4a536d41cdb2d..befc1196d6d60 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -463,11 +463,12 @@ static void damon_test_set_regions_for(struct kunit *test,
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
@@ -481,7 +482,8 @@ static void damon_test_set_regions_for(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, new_ranges, sz_new_ranges, min_region_sz);
+	err = damon_set_regions(t, new_ranges, sz_new_ranges, min_region_sz);
+	KUNIT_EXPECT_EQ(test, err, expect_err);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), sz_expect_ranges);
 	if (damon_nr_regions(t) != sz_expect_ranges) {
@@ -510,7 +512,7 @@ static void damon_test_set_regions(struct kunit *test)
 			(struct damon_addr_range[]){
 			{.start = 5, .end = 15},
 			{.start = 15, .end = 25},
-			}, 2);
+			}, 2, 0);
 	/* Un-intersecting regions should be removed. */
 	damon_test_set_regions_for(test,
 			(struct damon_addr_range[]){
@@ -523,7 +525,7 @@ static void damon_test_set_regions(struct kunit *test)
 			1,
 			(struct damon_addr_range[]){
 			{.start = 18, .end = 23},
-			}, 1);
+			}, 1, 0);
 	/*
 	 * Holes should be filled up with new regions.
 	 *
@@ -544,7 +546,7 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 8, .end = 16},
 			{.start = 16, .end = 24},
 			{.start = 24, .end = 28},
-			}, 3);
+			}, 3, 0);
 	/*
 	 * New regions should be able to be appended.
 	 *
@@ -566,7 +568,7 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 0, .end = 4},
 			{.start = 4, .end = 15},
 			{.start = 25, .end = 40},
-			}, 3);
+			}, 3, 0);
 	/*
 	 * New regions should be able to be inserted.
 	 *
@@ -589,7 +591,7 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 0, .end = 15},
 			{.start = 25, .end = 40},
 			{.start = 44, .end = 50},
-			}, 3);
+			}, 3, 0);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
-- 
2.47.3
