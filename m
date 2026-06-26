Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC13E8345
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464398; cv=none; b=O5xJA4aA7mbiJ5RbYg81SXjTL1gTRoMG+sSYkgpIcY/urpTOYsoXuweZZ0k5Jg33scTzov09IFHbX873rdMfh/5TnP3CZD76bVHkgG+GbRBWH1oJtXZaRqPvwCK4/IrWCwffLtQYGBVjZEcgS8apOl7uyHuhLQhY2g+FkI3cSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464398; c=relaxed/simple;
	bh=SPCcEpGfkluEqaIPY1rO0mYTGBVaaXe+Br7oVTeZiFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPe1sWUNNDc6rbUQLWSO0RAzP716JLhkHOxSSPOcnpgvggAlOO//GJar5Dna823Y/N6CvYJGAPH5HXtup9w0+S+gE4/SwsLlfmr2V5TY6iXPwogAKKiyaR7qUk0kzrovlmYnIgbuOlO4X+z2PmiQaJOEDFVEwin4CXEShNoxmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TWTPuoHN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TWTPuoHN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782464393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/AKESdZLDH+aWzHoqnqaRdmen2KGUt9vPtou3JWZ00=;
	b=TWTPuoHNMpUrutD9Nj5/mAVZStDcfAmZBTehgtlcu4Pw1KjmDMv6X8cIENgSdluXtb2DiO
	rDcUEbC/8L/P7nXqzUCERKrX1CMhLuZ9eCdUtfE2U6eDRoiN4Arr85sfdy+2e/dFL205//
	v6ZGeIiQGRf1NGv6mLwnvxX3zOCHK3w=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: jiayuan.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
Date: Fri, 26 Jun 2026 16:58:37 +0800
Message-ID: <20260626085851.70754-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260626085851.70754-1-jiayuan.chen@linux.dev>
References: <20260626085851.70754-1-jiayuan.chen@linux.dev>
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

When nr_regions is above max_nr_regions / 2 but still under the
maximum, split only a fraction of the regions instead of returning.
One region in every 'max_nr_regions / budget' regions is split, where
budget is the remaining room (max_nr_regions - nr_regions), starting
from a rotating offset so different regions get picked over time.  The
fraction shrinks as the budget shrinks, so the region count keeps
refining while approaching max_nr_regions smoothly rather than
overshooting it.  An unnecessary split is reverted by the next
kdamond_merge_regions().

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/damon/core.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d0cbfb6d1e4c..26a2cdb935f5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3712,6 +3712,37 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 	}
 }
 
+/* Split one in every @split_step regions into two, from a rotating offset */
+static void damon_split_some_regions(struct damon_ctx *ctx,
+				     unsigned long split_step)
+{
+	static unsigned long rotation;
+	struct damon_target *t;
+	struct damon_region *r, *next;
+	unsigned long offset = rotation++ % split_step;
+	unsigned long idx = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t) {
+			unsigned long sz_region, sz_sub;
+
+			if (idx++ % split_step != offset)
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
+		}
+	}
+}
+
 /*
  * Split every target region into randomly-sized small regions
  *
@@ -3725,25 +3756,33 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
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
+		damon_split_some_regions(ctx,
+			max_nr_regions / (max_nr_regions - nr_regions));
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

