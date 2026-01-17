Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E02C159E;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672387; cv=none; b=b4CXmh3nUJPbpTGtdM1NAcfhfPvqqGHpeQz2X+cnvljxlCwljd9AWxXxGLm/uuNZV141ux7KHi2y77FEPZLqpQNN0V8hprMvizaVjYZ3IVini4wXDyGdWl4ni4wSQL5vxrrCWCzeZpFZYVYCHz5pQncsrErbJHKjgcz25QPITOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672387; c=relaxed/simple;
	bh=euB34KBwMNH0Wmqe09qNX0ZCrnsNrl1erm4orWgN94Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZbQ4hL7sqDSAXee3JBb81g9cXXPzJcS6jp5w/P2G1vMzjmfw434fa9iCuxXbCE9cGeI/2ebtEgew8OVm7b0OJlVo/LWtXsfo+RG9RmAlCOKwEieyEFpCavcDadjRIRSqeYsxjmqQfaK1IOCnkNSUmPjh5YGcENjzr5KsJkC8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XboQCrWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XboQCrWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5BCC4CEF7;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672386;
	bh=euB34KBwMNH0Wmqe09qNX0ZCrnsNrl1erm4orWgN94Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XboQCrWpygsXWUjCYZVHfl5v6h5r9fiD6ifKt80zLkTMGFDUSmCGP5PYKYDhHFTgM
	 Tt/u0qYPIMoD+UclftBK5uQdkLia/RsRXVgGT9nS1fqqL2pWnqNKhVmB2tCMQPUXxx
	 OHsj9gfoZnPkc84FvGPlNg4gcIOvFUA9Y0MSuIGZ4r2oDPBhgiEwHq0zANajbp+RLN
	 3Ex1lNfEyplsnndPlWjavIo2BNqiOo3L5d6eLZ3bgrlQyY9VwogwMFowiI8eyS2XA5
	 Pje3NQ5m2nDj9V5cv5xVaUUmzrZ977ne5oN+COC1hWjwiHVRsosiuJYL8xF5DJYAEX
	 SqlZ4IPbsCEyg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/8] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Sat, 17 Jan 2026 09:52:54 -0800
Message-ID: <20260117175256.82826-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is for the default minimum size of each DAMON region.  There
was a case that a reader was confused if it is the minimum number of
total DAMON regions, which is set on damon_attrs->min_nr_regions.  Make
the name more explicit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h        |  2 +-
 mm/damon/core.c              |  2 +-
 mm/damon/lru_sort.c          |  2 +-
 mm/damon/reclaim.c           |  2 +-
 mm/damon/sysfs.c             |  2 +-
 mm/damon/tests/vaddr-kunit.h |  2 +-
 mm/damon/vaddr.c             | 24 ++++++++++++------------
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bdca28e15e40..5bf8db1d78fe 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -15,7 +15,7 @@
 #include <linux/random.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
-#define DAMON_MIN_REGION	PAGE_SIZE
+#define DAMON_MIN_REGION_SZ	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ae5b772ceffb..5508bc794172 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -553,7 +553,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
-	ctx->min_sz_region = DAMON_MIN_REGION;
+	ctx->min_sz_region = DAMON_MIN_REGION_SZ;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index bedb9134d286..9dde096a9064 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -298,7 +298,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 55df43e241c5..c343622a2f52 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -208,7 +208,7 @@ static int damon_reclaim_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 4de25708b05a..57d36d60f329 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1470,7 +1470,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_sz_region = max(
-				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
+				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 30dc5459f1d2..cfae870178bf 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -147,7 +147,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 40c73adf1946..83ab3d8c3792 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -19,8 +19,8 @@
 #include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
+#undef DAMON_MIN_REGION_SZ
+#define DAMON_MIN_REGION_SZ 1
 #endif
 
 /*
@@ -78,7 +78,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION_SZ);
 
 	if (!sz_piece)
 		return -EINVAL;
@@ -161,12 +161,12 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 		swap(first_gap, second_gap);
 
 	/* Store the result */
-	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION);
-	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION);
-	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION);
-	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION);
+	regions[0].start = ALIGN(start, DAMON_MIN_REGION_SZ);
+	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION_SZ);
+	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION_SZ);
+	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION_SZ);
+	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION_SZ);
+	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION_SZ);
 
 	return 0;
 }
@@ -259,8 +259,8 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < DAMON_MIN_REGION_SZ)
+		sz = DAMON_MIN_REGION_SZ;
 
 	/* Set the initial three regions of the target */
 	for (i = 0; i < 3; i++) {
@@ -299,7 +299,7 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
-		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 	}
 }
 
-- 
2.47.3
