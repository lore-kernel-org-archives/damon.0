Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7540801B;
	Thu, 21 May 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374083; cv=none; b=lT+7S0+OQoY96HZjzvk+tia327UeY6qTivY5UgxKWEzwULb+vcEaJvPKbiMeYWR2cD5+bT72UMDqB8yj/noY3sVapaIKAHQ1EahOz9gkMASN0ucixTyFDfs/U3rfR+IJSDzbzYzL39rL0Xu1W/slOFrgKRjPPxPi84jf3XZ5sxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374083; c=relaxed/simple;
	bh=APLmcBIo1O/M2Pv9o2Vdrv9QdP3CWdcypcr8bidZpQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa/cWRAz9lU6D/YQwFEW07A4wK1aiohhPFNl5SaGYEq6N8c7SLDEfIvqf/E6ehKy1LMkGPPKhUrqTrQD+XQM5UcJzVEIhx+zgj4Lsp1jJIbGCmW+CWOZhVjHF8dpMh+daqfqHebk4Kv1FmGKPMtM6AcoyqAb6M7y3fboaxFhaqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzdDcdIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzdDcdIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF16F1F00A3C;
	Thu, 21 May 2026 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374081;
	bh=rIvjFu8eu4Q0A0nJgGFhpNwMfwikQRRw8RbElJURXJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZzdDcdIQERBkcPS+c3Xdfq2mJl9Iazp9/dme8M6FhGjAXPYTuUg71RZM2JuuZSU5z
	 TIO446K+cyJOang2ILC+ntls5a66HbUsd8CSc6hzJeQoYYfNHqVPiWrWPaXEA4DU7F
	 m3MqBPEJXg9S/IN3nqH3cmucS/VShH/Ts/HP/k0PmkMtMrylhvzbv11/InfM+larIO
	 SUwv5FvQylO8QE37HeWHiy2teZZgxArhPa3Fph+1JTlvv8PRDetnKgMBWRdZ0YWajo
	 pxGjF1CRk0aZWmOjlokfJNhxTahBwSxQUsq6sK1k2C0Dbyt6A1CSmcA3cWA3cUKSoS
	 +9FSMjAyB/plg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 10/14] mm/damon/tests/core-kunit: add damon_set_regions() test cases
Date: Thu, 21 May 2026 07:34:20 -0700
Message-ID: <20260521143428.83157-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() is one of the main DAMON kernel API functions that
set up the monitoring target memory region boundaries.  Implement unit
tests for verifying its basic functionalities.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 142 ++++++++++++++++++++++++++++++------
 1 file changed, 120 insertions(+), 22 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 866f716e5760d..1cfb8c176b873 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -390,41 +390,139 @@ static void damon_test_ops_registration(struct kunit *test)
 	}
 }
 
-static void damon_test_set_regions(struct kunit *test)
+static void damon_test_set_regions_for(struct kunit *test,
+		struct damon_addr_range *old_ranges, int sz_old_ranges,
+		struct damon_addr_range *new_ranges, int sz_new_ranges,
+		unsigned long min_region_sz,
+		struct damon_addr_range *expect_ranges, int sz_expect_ranges)
 {
-	struct damon_target *t = damon_new_target();
-	struct damon_region *r1, *r2;
-	struct damon_addr_range range = {.start = 8, .end = 28};
-	unsigned long expects[] = {8, 16, 16, 24, 24, 28};
-	int expect_idx = 0;
+	struct damon_target *t;
 	struct damon_region *r;
+	int i;
 
+	t = damon_new_target();
 	if (!t)
 		kunit_skip(test, "target alloc fail");
-	r1 = damon_new_region(4, 16);
-	if (!r1) {
-		damon_free_target(t);
-		kunit_skip(test, "region alloc fail");
-	}
-	r2 = damon_new_region(24, 32);
-	if (!r2) {
-		damon_free_target(t);
-		damon_free_region(r1);
-		kunit_skip(test, "second region alloc fail");
+	for (i = 0; i < sz_old_ranges; i++) {
+		r = damon_new_region(old_ranges[i].start, old_ranges[i].end);
+		if (!r) {
+			damon_destroy_target(t, NULL);
+			kunit_skip(test, "%d-th r alloc fail\n", i);
+		}
+		damon_add_region(r, t);
 	}
 
-	damon_add_region(r1, t);
-	damon_add_region(r2, t);
-	damon_set_regions(t, &range, 1, 1);
+	damon_set_regions(t, new_ranges, sz_new_ranges, min_region_sz);
 
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), sz_expect_ranges);
+	if (damon_nr_regions(t) != sz_expect_ranges) {
+		damon_destroy_target(t, NULL);
+		return;
+	}
+	i = 0;
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
-		KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
+		KUNIT_EXPECT_EQ(test, r->ar.start, expect_ranges[i].start);
+		KUNIT_EXPECT_EQ(test, r->ar.end, expect_ranges[i++].end);
 	}
+
 	damon_destroy_target(t, NULL);
 }
 
+static void damon_test_set_regions(struct kunit *test)
+{
+	/* Initial build up on empty target. */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){}, 0,
+			(struct damon_addr_range[]){
+			{.start = 5, .end = 15},
+			{.start = 15, .end = 25},
+			}, 2,
+			1,
+			(struct damon_addr_range[]){
+			{.start = 5, .end = 15},
+			{.start = 15, .end = 25},
+			}, 2);
+	/* Un-intersecting regions should be removed. */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){
+			{.start = 4, .end = 16},
+			{.start = 24, .end = 32},
+			}, 2,
+			(struct damon_addr_range[]){
+			{.start = 18, .end = 23},
+			}, 1,
+			1,
+			(struct damon_addr_range[]){
+			{.start = 18, .end = 23},
+			}, 1);
+	/*
+	 * Holes should be filled up with new regions.
+	 *
+	 * old:       [4,   16)        [24,     32)
+	 * new:         [8,                 28)
+	 * expect:      [8, 16)[16,24),[24, 28)
+	 */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){
+			{.start = 4, .end = 16},
+			{.start = 24, .end = 32},
+			}, 2,
+			(struct damon_addr_range[]){
+			{.start = 8, .end = 28},
+			}, 1,
+			1,
+			(struct damon_addr_range[]){
+			{.start = 8, .end = 16},
+			{.start = 16, .end = 24},
+			{.start = 24, .end = 28},
+			}, 3);
+	/*
+	 * New regions should be able to be appended.
+	 *
+	 * old:       [0, 4)[4,    17)
+	 * new:       [0,       15)     [25, 40)
+	 * expect:    [0, 4)[4, 15)     [25, 40)
+	 */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){
+			{.start = 0, .end = 4},
+			{.start = 4, .end = 17},
+			}, 2,
+			(struct damon_addr_range[]){
+			{.start = 0, .end = 15},
+			{.start = 25, .end = 40},
+			}, 2,
+			1,
+			(struct damon_addr_range[]){
+			{.start = 0, .end = 4},
+			{.start = 4, .end = 15},
+			{.start = 25, .end = 40},
+			}, 3);
+	/*
+	 * New regions should be able to be inserted.
+	 *
+	 * old:       [0, 4)                      [42,    52)
+	 * new:       [0,       15)     [25, 40)    [44, 50)
+	 * expect:    [0,       15)     [25, 40)    [44, 50)
+	 */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){
+			{.start = 0, .end = 4},
+			{.start = 42, .end = 52},
+			}, 2,
+			(struct damon_addr_range[]){
+			{.start = 0, .end = 15},
+			{.start = 25, .end = 40},
+			{.start = 44, .end = 50},
+			}, 3,
+			1,
+			(struct damon_addr_range[]){
+			{.start = 0, .end = 15},
+			{.start = 25, .end = 40},
+			{.start = 44, .end = 50},
+			}, 3);
+}
+
 static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 {
 	struct damon_attrs attrs = {
-- 
2.47.3
