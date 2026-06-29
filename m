Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DC4218B5;
	Mon, 29 Jun 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745002; cv=none; b=fPvBvb6dcuhJirfRO95T85qlRRkrPctmTdGby5vDE6vWzNyy1hsOWgPFCp8S4Kuq5100b/aj0oOSoRxb6kQ0tdfrkAmG6+815gDOOUH3Z/ONpZCbZIABIK0LCsoW4uUFzeWnyQmHcyfkvYzbDRkgXtSZNnlpYaG+RaCHDKMXBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745002; c=relaxed/simple;
	bh=iYb14wWPEhz8XfyzAIE9KabxXIwWufN9XYxRAJ2J9hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWhl6CExdSzM6wPYI51gOKiGxlsjNAA5wW/xk1j8Eu+FUey3d9AstnJgBOTiaCep61QqZYlGg6VVbiiHIgKu2tUUWebYcGDEJlhj5+wXNzUFdDq72PgwaHB4NAqqVwFgRfzIgaWROofnLrAd7mLrhsiodEO2JP61BivE1hLdcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJRDV1f4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJRDV1f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75A61F00AC4;
	Mon, 29 Jun 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744999;
	bh=NatPVMmr6lCmbwrlx8nymHKQLSth5j//NGxvrJ4IneU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJRDV1f4my+izevuENYAHKkEumYnZ2U6dtePGJAVwunGLNbZNgrq3imspiQVL6zOw
	 5iV4NRR8ojJUinocwL/VoKfkP9WaqOsroCXEgq6nCNZdkmq3h9lC8/G/6XebN3SHOx
	 eieNMwPMJtATCYbQcn1xrSRqCv3nzrkFoqST+lATlEFCi+C6qCDQkxVQxCaoaJL2Fy
	 03vqCdsqh7tJMDsy79Ee0lWkdBzOQsKgiZ5AtZNq8a9ndiQcE4UxBLpb+4bBAwxiw4
	 rp9ktpeSBiFbmeK1FpPPZ77C0LpwFk1N0cIq+bUt7fVBNZ+GkAlDC4EmneVtg55ZXR
	 IALxxuDZEIquA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SJ Park <sj@kernel.org>,
	Shu Anzai <shu17az@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/2] mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
Date: Mon, 29 Jun 2026 07:56:28 -0700
Message-ID: <20260629145630.134891-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145630.134891-1-sj@kernel.org>
References: <20260629145630.134891-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Link: https://lore.kernel.org/20260626085851.70754-2-jiayuan.chen@linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shu Anzai <shu17az@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ded76719e8a14..972a19fcee3ec 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3240,6 +3240,37 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
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
@@ -3253,25 +3284,33 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
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
2.47.3
