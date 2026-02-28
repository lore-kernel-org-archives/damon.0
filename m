Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3F246BBA;
	Sat, 28 Feb 2026 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317720; cv=none; b=N5zwxGJ+3LEBdA0YrTke3piDfZ9tRIdQEeuCmDH43ttIOZ6eHDQcoBV04XAWTDeqdByA03YG55CTzkoFMkGhxT/RGOBiV48mjnHeI8SnKWFQV1EmXMBLVJId6zjf8lgrNZAHX0MWJpEKyu6n6jFHBYaVJCpyTq9WN5msrXAT/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317720; c=relaxed/simple;
	bh=+qqd/MjUtEwjncKaZxgDH9DLW9LHMFD6sPqL4L5XCQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6NZxcP8v5neMb2WNegWgVMImD9Lde1nZOPh4mj8C9iBPQV9TtL32ge8v4ZPGDB1VWnHH+LPxj7xs9XkCD0yKtSXZ9hQQGXO+0IgwUVCu9KZl1PdIQOTSqS2Li6vinBE4EHozHmhBtRMYLrOlPNJznpAQeQk5bw16jO7kKwiJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt2gpgN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt2gpgN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05A9C19424;
	Sat, 28 Feb 2026 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317720;
	bh=+qqd/MjUtEwjncKaZxgDH9DLW9LHMFD6sPqL4L5XCQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pt2gpgN0mkOfMZvN5XWX4QOywu+PYFU7KTUXBQII6/p15kbbSFLDVYGGrye7EQaR2
	 ooqTABJLu+MAxKxHuyqSepIbWFdrta8ka2ydL+bSNFijGR+GBXR9YDJf1EFCqVkqA+
	 3flOYHpgqPJhwsxc180u0/nik5xlRvyVbSppjOTKo9rz8GU7vhmJ0dxl93bi1Y6X8H
	 Yy+98YLMoh04UWo8KOHyWamh0t8tMtgP1SJvaf3c4n4JZCQkw3ZLgyYLjgFgfGLGlg
	 05WhwDBcFxwRR1Hsng0knE/Ew+E8ZJMBI8aJtv77EazGj7H4YlgANY42g5CvqBqCTP
	 LDw7jKCmTu3gg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/core: split regions for min_nr_regions
Date: Sat, 28 Feb 2026 14:28:25 -0800
Message-ID: <20260228222831.7232-2-sj@kernel.org>
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

DAMON core layer respects the min_nr_regions parameter by setting the
maximum size of each region as total monitoring region size divided by
the parameter value.  And the limit is applied by preventing merge of
regions that result in a region larger than the maximum size.  The limit
is updated per ops update interval, because vaddr updates the monitoring
regions on the ops update callback.

It does nothing for the beginning state.  That's because the users can
set the initial monitoring regions as they want.  That is, if the users
really care about the min_nr_regions, they are supposed to set the
initial monitoring regions to have more than min_nr_regions regions.
The virtual address space operation set, vaddr, has an exceptional case.
Users can ask the ops set to configure the initial regions on its own.
For the case, vaddr sets up the initial regions to meet the
min_nr_regions.  So, vaddr has exceptional support, but basically users
are required to set the regions on their own if they want min_nr_regions
to be respected.

When 'min_nr_regions' is high, such initial setup is difficult.  If
DAMON sysfs interface is used for that, the memory for saving the
initial setup is also a waste.

Even if the user forgives the setup, DAMON will eventually make more
than min_nr_regions regions by splitting operations.  But it will take
time.  If the aggregation interval is long, the delay could be
problematic.  There was actually a report [1] of the case.  The reporter
wanted to do page granular monitoring with a large aggregation interval.

Also, DAMON is doing nothing for online changes on monitoring regions
and min_nr_regions.  For example, the user can remove a monitoring
region or increase min_nr_regions while DAMON is running.

Split regions larger than the size at the beginning of the kdamond main
loop, to fix the initial setup issue.  Also do the split every
aggregation interval, for online changes.  This means the behavior is
slightly changed.  It is difficult to imagine a use case that actually
depends on the old behavior, though.  So this change is arguably fine.

Note that the size limit is aligned by damon_ctx->min_region_sz and
cannot be zero.  That is, if min_nr_region is larger than the total size
of monitoring regions divided by ->min_region_sz, that cannot be
respected.

[1] https://lore.kernel.org/CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dcf7027637550..f1a97e85824ac 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1314,6 +1314,40 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	return sz;
 }
 
+static void damon_split_region_at(struct damon_target *t,
+				  struct damon_region *r, unsigned long sz_r);
+
+/*
+ * damon_apply_min_nr_regions() - Make effect of min_nr_regions parameter.
+ * @ctx:	monitoring context.
+ *
+ * This function implement min_nr_regions (minimum number of damon_region
+ * objects in the given monitoring context) behavior.  It first calculates
+ * maximum size of each region for enforcing the min_nr_regions as total size
+ * of the regions divided by the min_nr_regions.  After that, this function
+ * splits regions to ensure all regions are equal to or smaller than the size
+ * limit.  Finally, this function returns the maximum size limit.
+ *
+ * Returns: maximum size of each region for convincing min_nr_regions.
+ */
+static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
+{
+	unsigned long max_region_sz = damon_region_sz_limit(ctx);
+	struct damon_target *t;
+	struct damon_region *r, *next;
+
+	max_region_sz = ALIGN(max_region_sz, ctx->min_region_sz);
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t) {
+			while (damon_sz_region(r) > max_region_sz) {
+				damon_split_region_at(t, r, max_region_sz);
+				r = damon_next_region(r);
+			}
+		}
+	}
+	return max_region_sz;
+}
+
 static int kdamond_fn(void *data);
 
 /*
@@ -1670,9 +1704,6 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
 	damon_set_attrs(c, &new_attrs);
 }
 
-static void damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
-
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;
@@ -2757,7 +2788,7 @@ static int kdamond_fn(void *data)
 	if (!ctx->regions_score_histogram)
 		goto done;
 
-	sz_limit = damon_region_sz_limit(ctx);
+	sz_limit = damon_apply_min_nr_regions(ctx);
 
 	while (!kdamond_need_stop(ctx)) {
 		/*
@@ -2782,10 +2813,13 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (ctx->passed_sample_intervals >= next_aggregation_sis)
+		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
+			/* online updates might be made */
+			sz_limit = damon_apply_min_nr_regions(ctx);
+		}
 
 		/*
 		 * do kdamond_call() and kdamond_apply_schemes() after
@@ -2842,7 +2876,6 @@ static int kdamond_fn(void *data)
 				sample_interval;
 			if (ctx->ops.update)
 				ctx->ops.update(ctx);
-			sz_limit = damon_region_sz_limit(ctx);
 		}
 	}
 done:
-- 
2.47.3
