Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD8338939;
	Sat, 28 Feb 2026 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317720; cv=none; b=Hgp51cP/va3NBYsxYzuYpHf4sJFA8GkTAeGIIEitrY7eftZQyASvuQ+/yuhC54Yw/Exay0MQHU/GrhVcNuTR2/V04rMIiHfQ0tCrQAgcB9GRmIkZaoRafOcdNkUi+VGujvv7LYm8xaEELhzpGegxsvN1snnmnDAuZuKb0/r9qPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317720; c=relaxed/simple;
	bh=KfT9nJeTJCe56p+SPhAqwenoi3eGOWr/fZ5jtO4mm40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMIn1F8Fs/73s7fvFYRt3RtsQLCbCQ1490/Gzf8Kqgb2qQHOxtC0N+2KXEnWf/StOoJlwdO3bsgiyASjfN/0j1Chg8FZuiCWE7/rUns4n5ts7TzpZLYzYDuzJKxYYfLRuNNt6FZXNiA6LyUdZ5q4rI7zskJdpuqXw7MaPrfwfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8lIYuQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8lIYuQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3316BC2BC9E;
	Sat, 28 Feb 2026 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317720;
	bh=KfT9nJeTJCe56p+SPhAqwenoi3eGOWr/fZ5jtO4mm40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8lIYuQsGzvV67CbVGFm0yN9GQr68kEnaIcvIXk7t30Rrl6Iv5B4R1J23SgdgckC5
	 dzSKdX8LWChQR8MKnaXacDJIBNSLWUAia9IVvEk16/Ij8CmgMgfS1VMTp7AlG4oG/H
	 CcRKgWqyXVGyUxqrlZO6Pexq5clyEFCHdM/9xBlcldZkl+hsONx6dTzmHO3Fa/ZhP2
	 oTz4SWep/4AHPOumZqqQQGclMNAIxd5yCIBr8wSXX5kF/jO6Sw1812xD56sYSFhPt0
	 qU0pHIxWo0ODQdADPm90jTO2dhjUI3cIqOj6fjGDa+pjIGD3gb02hbOPGy6Qkkc1jw
	 zUHrzJmrOX7MA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm/damon/vaddr: do not split regions for min_nr_regions
Date: Sat, 28 Feb 2026 14:28:26 -0800
Message-ID: <20260228222831.7232-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228222831.7232-1-sj@kernel.org>
References: <20260228222831.7232-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit made DAMON core split regions at the beginning for
min_nr_regions.  The virtual address space operation set (vaddr) does
similar work on its own, for a case user delegates entire initial
monitoring regions setup to vaddr.  It is unnecessary now, as DAMON core
will do similar work for any case.  Remove the duplicated work in vaddr.

Also, remove a helper function that was being used only for the work,
and the test code of the helper function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 76 ------------------------------------
 mm/damon/vaddr.c             | 70 +--------------------------------
 2 files changed, 2 insertions(+), 144 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index cfae870178bfd..98e734d77d517 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -252,88 +252,12 @@ static void damon_test_apply_three_regions4(struct kunit *test)
 			new_three_regions, expected, ARRAY_SIZE(expected));
 }
 
-static void damon_test_split_evenly_fail(struct kunit *test,
-		unsigned long start, unsigned long end, unsigned int nr_pieces)
-{
-	struct damon_target *t = damon_new_target();
-	struct damon_region *r;
-
-	if (!t)
-		kunit_skip(test, "target alloc fail");
-
-	r = damon_new_region(start, end);
-	if (!r) {
-		damon_free_target(t);
-		kunit_skip(test, "region alloc fail");
-	}
-
-	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test,
-			damon_va_evenly_split_region(t, r, nr_pieces), -EINVAL);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
-
-	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->ar.start, start);
-		KUNIT_EXPECT_EQ(test, r->ar.end, end);
-	}
-
-	damon_free_target(t);
-}
-
-static void damon_test_split_evenly_succ(struct kunit *test,
-	unsigned long start, unsigned long end, unsigned int nr_pieces)
-{
-	struct damon_target *t = damon_new_target();
-	struct damon_region *r;
-	unsigned long expected_width = (end - start) / nr_pieces;
-	unsigned long i = 0;
-
-	if (!t)
-		kunit_skip(test, "target alloc fail");
-	r = damon_new_region(start, end);
-	if (!r) {
-		damon_free_target(t);
-		kunit_skip(test, "region alloc fail");
-	}
-	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test,
-			damon_va_evenly_split_region(t, r, nr_pieces), 0);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
-
-	damon_for_each_region(r, t) {
-		if (i == nr_pieces - 1) {
-			KUNIT_EXPECT_EQ(test,
-				r->ar.start, start + i * expected_width);
-			KUNIT_EXPECT_EQ(test, r->ar.end, end);
-			break;
-		}
-		KUNIT_EXPECT_EQ(test,
-				r->ar.start, start + i++ * expected_width);
-		KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
-	}
-	damon_free_target(t);
-}
-
-static void damon_test_split_evenly(struct kunit *test)
-{
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
-			-EINVAL);
-
-	damon_test_split_evenly_fail(test, 0, 100, 0);
-	damon_test_split_evenly_succ(test, 0, 100, 10);
-	damon_test_split_evenly_succ(test, 5, 59, 5);
-	damon_test_split_evenly_succ(test, 4, 6, 1);
-	damon_test_split_evenly_succ(test, 0, 3, 2);
-	damon_test_split_evenly_fail(test, 5, 6, 2);
-}
-
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_three_regions_in_vmas),
 	KUNIT_CASE(damon_test_apply_three_regions1),
 	KUNIT_CASE(damon_test_apply_three_regions2),
 	KUNIT_CASE(damon_test_apply_three_regions3),
 	KUNIT_CASE(damon_test_apply_three_regions4),
-	KUNIT_CASE(damon_test_split_evenly),
 	{},
 };
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4d6d8251d4199..b069dbc7e3d25 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -53,52 +53,6 @@ static struct mm_struct *damon_get_mm(struct damon_target *t)
 	return mm;
 }
 
-/*
- * Functions for the initial monitoring target regions construction
- */
-
-/*
- * Size-evenly split a region into 'nr_pieces' small regions
- *
- * Returns 0 on success, or negative error code otherwise.
- */
-static int damon_va_evenly_split_region(struct damon_target *t,
-		struct damon_region *r, unsigned int nr_pieces)
-{
-	unsigned long sz_orig, sz_piece, orig_end;
-	struct damon_region *n = NULL, *next;
-	unsigned long start;
-	unsigned int i;
-
-	if (!r || !nr_pieces)
-		return -EINVAL;
-
-	if (nr_pieces == 1)
-		return 0;
-
-	orig_end = r->ar.end;
-	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION_SZ);
-
-	if (!sz_piece)
-		return -EINVAL;
-
-	r->ar.end = r->ar.start + sz_piece;
-	next = damon_next_region(r);
-	for (start = r->ar.end, i = 1; i < nr_pieces; start += sz_piece, i++) {
-		n = damon_new_region(start, start + sz_piece);
-		if (!n)
-			return -ENOMEM;
-		damon_insert_region(n, r, next, t);
-		r = n;
-	}
-	/* complement last region for possible rounding error */
-	if (n)
-		n->ar.end = orig_end;
-
-	return 0;
-}
-
 static unsigned long sz_range(struct damon_addr_range *r)
 {
 	return r->end - r->start;
@@ -240,10 +194,8 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 				     struct damon_target *t)
 {
 	struct damon_target *ti;
-	struct damon_region *r;
 	struct damon_addr_range regions[3];
-	unsigned long sz = 0, nr_pieces;
-	int i, tidx = 0;
+	int tidx = 0;
 
 	if (damon_va_three_regions(t, regions)) {
 		damon_for_each_target(ti, ctx) {
@@ -255,25 +207,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		return;
 	}
 
-	for (i = 0; i < 3; i++)
-		sz += regions[i].end - regions[i].start;
-	if (ctx->attrs.min_nr_regions)
-		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION_SZ)
-		sz = DAMON_MIN_REGION_SZ;
-
-	/* Set the initial three regions of the target */
-	for (i = 0; i < 3; i++) {
-		r = damon_new_region(regions[i].start, regions[i].end);
-		if (!r) {
-			pr_err("%d'th init region creation failed\n", i);
-			return;
-		}
-		damon_add_region(r, t);
-
-		nr_pieces = (regions[i].end - regions[i].start) / sz;
-		damon_va_evenly_split_region(t, r, nr_pieces);
-	}
+	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
 }
 
 /* Initialize '->regions_list' of every target (task) */
-- 
2.47.3
