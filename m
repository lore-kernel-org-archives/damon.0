Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BF33DEE1
	for <damon@lists.linux.dev>; Thu, 21 May 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339184; cv=none; b=FC0NupEncfDSDdLL//KjjUnTk0QUgsGBFtqkEJTIRiSViDwfrme5ZgliosvNWptn06VJaPv/JdBVC+C493rUcjzPp20wmIFy3GDblxLkm15CRL4OUU5YbDY6fpjHOuycgtk9GNnKNlUYQX1M8X+i48TmRHZnOVihD7HX2ZLIQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339184; c=relaxed/simple;
	bh=BBIRbu7OFErK/KKz4QUAx+oIApZCly2X+pCMd+7ysNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhtfcbEDG/Pv1b4ZTJyoSpUTwNTFEQhwtQcBoVwIFjo3OYJFMMmQoboaLqskHbElu/JxgYuE54r/psvK6KHeeHpk0vI4mDz0kJi1Jlhp5WrbmjUz0TyEKBtCA1RAjl1pStDb7dTJOuDBatF5ROL/y1P6ujNt3P1iiJfzcPBTNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYn1BTHX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYn1BTHX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779339179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihrvNaIXgM84SacKpF3s4jv+T6hZY9k+429hTF/wmxo=;
	b=nYn1BTHXkkqEjDgxljj9bDe0WsfSvO90O7O5eLgE5ADHDmQIk0G1lF9ndyAgb4SBD+BF/0
	AWZSrY5kzkRHp1hpEAMdArAoK4YUnIbPi6iUYhVBqHh8mhGwflzQ3Ef9TwvzZumdHX62aM
	ZKTUcyi7PoolOGHSSVAvyCCdP+DFgtY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: split age==0 regions when nr_regions exceeds max/2
Date: Thu, 21 May 2026 12:52:23 +0800
Message-ID: <20260521045236.115749-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260521045236.115749-1-jiayuan.chen@linux.dev>
References: <20260521045236.115749-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

kdamond_split_regions() returns early when nr_regions is above
max_nr_regions / 2, leaving internal access variation inside a large
region undetected.

Such a layout is common with damon-paddr on hugepage workloads or
damon-vaddr on processes with a large anonymous mmap.

For example, with max_nr_regions == 1500, a target may end up with
799 small alternating-temperature regions plus one large region that
absorbed a uniformly-accessed range during an earlier merge:

H:hot
C:cold

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|

    nr_regions = 800  >  max_nr_regions / 2 = 750

If a cold subarea later emerges inside r800:

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|

The small regions cannot merge with each other (different access
counts), so the budget stays full.  r800 cannot be split because
nr_regions > max_nr_regions / 2 causes an early return.  The cold
subarea is never discovered.

Split regions whose access pattern has just changed (age == 0) on
this path, up to the remaining budget against max_nr_regions.  An
unnecessary split is reverted by the next kdamond_merge_regions().

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/damon/core.c | 68 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6b8af7f956b7..442a6c323aeb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3452,37 +3452,81 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 }
 
 /*
- * Split every target region into randomly-sized small regions
+ * Split each region whose access pattern has just changed (age == 0)
+ * into two, until @budget new regions have been produced or no eligible
+ * region remains.
+ */
+static void damon_split_zero_age_regions(struct damon_ctx *ctx,
+					 unsigned long budget)
+{
+	struct damon_target *t;
+	struct damon_region *r, *next;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t) {
+			unsigned long sz_region, sz_sub;
+
+			if (!budget)
+				return;
+			if (r->age != 0)
+				continue;
+			sz_region = damon_sz_region(r);
+			if (sz_region < 2 * ctx->min_region_sz)
+				continue;
+
+			sz_sub = ALIGN_DOWN(damon_rand(ctx, 1, 10) *
+					sz_region / 10, ctx->min_region_sz);
+			/* Do not allow blank region */
+			if (sz_sub == 0 || sz_sub >= sz_region)
+				continue;
+
+			damon_split_region_at(t, r, sz_sub);
+			budget--;
+		}
+	}
+}
+
+/*
+ * Split target regions to refine the monitoring resolution under
+ * dynamically changing access patterns.
  *
- * This function splits every target region into random-sized small regions if
- * current total number of the regions is equal or smaller than half of the
- * user-specified maximum number of regions.  This is for maximizing the
- * monitoring accuracy under the dynamically changeable access patterns.  If a
- * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
- * it.
+ * When the total region count leaves room for a blanket doubling
+ * (nr_regions <= max_nr_regions / 2), every region is randomly split.
+ * Otherwise, only regions whose access pattern has just changed
+ * (age == 0) are split, up to the remaining budget against
+ * max_nr_regions.
+ *
+ * Unnecessary splits are reverted by a later kdamond_merge_regions().
  */
 static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
-	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
+	unsigned long nr_regions = 0;
+	unsigned long max_nr_regions = ctx->attrs.max_nr_regions;
+	static unsigned long last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
 		nr_regions += damon_nr_regions(t);
 
-	if (nr_regions > ctx->attrs.max_nr_regions / 2)
-		return;
+	if (nr_regions >= max_nr_regions)
+		goto done;
+
+	if (nr_regions > max_nr_regions / 2) {
+		damon_split_zero_age_regions(ctx, max_nr_regions - nr_regions);
+		goto done;
+	}
 
 	/* Maybe the middle of the region has different access frequency */
 	if (last_nr_regions == nr_regions &&
-			nr_regions < ctx->attrs.max_nr_regions / 3)
+			nr_regions < max_nr_regions / 3)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
 		damon_split_regions_of(ctx, t, nr_subregions,
 				       ctx->min_region_sz);
 
+done:
 	last_nr_regions = nr_regions;
 }
 
-- 
2.43.0

