Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76F9463;
	Tue, 17 Feb 2026 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286655; cv=none; b=b3qUTfdRdbk4hOk6lKd4VBKtWmwdBNqTg9jya+cOAqtDShWJlqoETzdd/9kjkEzQeSZpXFiW7Z9ANO1B+KrjGRSYdAqU90lMY7xafqQjw7ubWzTfja0R3XKqR28T53x/wJhvvd49oOIE+KCnFjSh2GavjnMm/3Sw+WXu3msyFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286655; c=relaxed/simple;
	bh=W6nulmGrrmE7k9MEnSpX5twJqtrvmVNeuzTOrdWQozo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/yONsq1V1+FzzmZI+ag3UieeQ8mHRLo0hNffb4Jo6Q/shSaFKXK2bGioedNJkzteeF3zEcUFd3OmUbqckoZ7ZVSSUZ5X0qzu87WluGGIBIyr+rYerySx2sfQ1SUK3TxIGvwFo9VKIFt3p2n8QhL3VL06yg1SWkikXRBB83ObuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWfNZiS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWfNZiS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D63EC19425;
	Tue, 17 Feb 2026 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771286655;
	bh=W6nulmGrrmE7k9MEnSpX5twJqtrvmVNeuzTOrdWQozo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWfNZiS3gY9KlFzteZh2ELLL3hk0S3hE5o3vrCUgBfPuYzem+aAo/GjzMBrcfrW8n
	 pP8+kNhZcgF0xzqNG3JGhl47FQOpYLs88Yj7k6lf6C8Wfn2k+TP+mZrul8ZbSj0Fhz
	 m9XplAoaMk1orhNX0WUT/p5K+HSbkcjIdkc1zTiarQFpLCNpibHg6nwX1hYYSzgFSK
	 S3fbg4nD5zAZNlpEnpRYLHxX3Av39ja0ogAcckKLxdCDFf4N3UGOEAbhp82t8HG8TN
	 jRdi48vEzPB27Umh6/9XWrEM01pGxI/u2y7REeEnLIWaf08rG94KmoJL5pFa2GHXwe
	 Fc1lc+Bdos50g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/3] mm/damon/core: split regions for min_nr_regions at beginning
Date: Mon, 16 Feb 2026 16:03:56 -0800
Message-ID: <20260217000400.69056-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217000400.69056-1-sj@kernel.org>
References: <20260217000400.69056-1-sj@kernel.org>
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
regions that result in a region larger than the maximum size.

It does nothing for the beginning state.  That's because the users can
set the initial monitoring regions as they want.  That is, if the users
really care about the min_nr_regions, they are supposed to set the
initial monitoring regions to have more than min_nr_regions regions.

When 'min_nr_regions' is high, such initial setup is difficult.  Even in
the case, DAMON will eventually make more than min_nr_regions regions,
but it will take time.  If the aggregation interval is long, the delay
could be problematic.  There was actually a report [1] of the case.

Split regions larger than the size at the beginning of the kdamond main
loop, to fix the problem.  This means the behavior is slightly changed.
That is, the initial monitoring regions that the user set ain't be
strictly respected, in terms of the number of the regions.  It is
difficult to imagine a use case that actually depends on the behavior,
though, so this change should be fine.

Note that the size limit is aligned by damon_ctx->min_region_sz and
cannot be zero.  That is, if min_nr_region is larger than the total size
of monitoring regions divided by ->min_region_sz, that cannot be
respected.

[1] https://lore.kernel.org/CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8e4cf71e2a3ed..fd1b2cbfe2c80 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1316,6 +1316,40 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
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
@@ -1672,9 +1706,6 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
 	damon_set_attrs(c, &new_attrs);
 }
 
-static void damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
-
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;
@@ -2778,7 +2809,7 @@ static int kdamond_fn(void *data)
 	if (!ctx->regions_score_histogram)
 		goto done;
 
-	sz_limit = damon_region_sz_limit(ctx);
+	sz_limit = damon_apply_min_nr_regions(ctx);
 
 	while (!kdamond_need_stop(ctx)) {
 		/*
-- 
2.47.3
