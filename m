Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5F391E4C;
	Sat, 11 Apr 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926167; cv=none; b=C6AX4GB40g4cvzBrXX9NTQbaSOYASrGRFBDqOUDGuzEnl8X7eNSba2UxEuC5T65VndObTOZzSuKJWANIPqKBYU72MizEYoYM7xn4Fu9+oi5a+IimPpfdgmBPHtk4DGP8FLSLY1K3R8mIbngHTJTAjPxDd7HM/7dgr2VLZQS5fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926167; c=relaxed/simple;
	bh=1jMrLCVmYw2fM2r6kvEbSVD04BTkPY4xDIA5TY8Gmbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUDKycMUVdeRceJLk2Z/M0CgDHF2RSQmdAlAbRIW6O6Km+3mj6tRMeveKKyT16jJsJjoOcjzxHzFL+74nNNL/pbpizkVQtIqt+hAhxYuYV0On5DGQAhsJUsQYhU7T0awsGve1Mwr+kl78KOBSfbXpo5lBjLXd6P6KdkVTto+OzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha7+jjTM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha7+jjTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34266C2BCB0;
	Sat, 11 Apr 2026 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775926167;
	bh=1jMrLCVmYw2fM2r6kvEbSVD04BTkPY4xDIA5TY8Gmbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ha7+jjTMT1s3LneksutlXeFJAp5DX6pt6iLwxi7+58OL/SyxTw14cYfvvDtStyK0R
	 yFnLEUBUPKgZa/UZE56KkujA8POrcMsJnoJ39Ouq80j6Xlu80R2DjON4YnBmOK6vrH
	 ciCvW9xOWcl+m8XZvBWjr7uEQFAu9YvLyksd0B4WAqwXg6a8HkPK7Y0TQpgAdDaqrq
	 QZzdWAnkt5cnk0BqyOQbY1Iy8zGRfwwhz5bClXXnCTbPRhqIL0JU7+WIWgwFM/jir/
	 HooFIlR45wZSsq4mjPEk9oXHSlr7QYrKPfBK5OJzI1gzFgjw2Z0Ws8jRwok9ugRsGo
	 JJWinaUy2BjvQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.1 02/11] mm/damon/core: merge regions after applying DAMOS schemes
Date: Sat, 11 Apr 2026 09:48:55 -0700
Message-ID: <20260411164908.77189-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-1-sj@kernel.org>
References: <20260411164908.77189-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_apply_scheme() could split the given region if applying the
scheme's action to the entire region can result in violating the
quota-set upper limit.  Keeping regions that are created by such split
operations is unnecessary overhead.

The overhead would be negligible in the common case because such split
operations could happen only up to the number of installed schemes per
scheme apply interval.  The following commit could make the impact
larger, though.  The following commit will allow the action-failed
region to be charged in a different ratio.  If both the ratio and the
remaining quota is quite small while the region to apply the scheme is
quite large and the action is nearly always failing, a high number of
split operations could happen.

Remove the unnecessary overhead by merging regions after applying
schemes is done for each region.  The merge operation is made only if it
will not lose monitoring information and keep min_nr_regions constraint.
In the worst case, the max_nr_regions could still be violated until the
next per-aggregation interval merge operation is made.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c7d05d2385fe8..fea1b0722c6bf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2159,6 +2159,37 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	}
 }
 
+static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
+{
+	struct damon_region *r;
+
+	damon_for_each_region(r, t) {
+		struct damon_region *prev_r;
+
+		damon_do_apply_schemes(c, t, r);
+		/*
+		 * damon_do_apply_scheems() could split the region for the
+		 * quota.  Keeping the new slices is an overhead.  Merge back
+		 * the slices into the previous region if it doesn't lose any
+		 * information.
+		 */
+		if (damon_first_region(t) == r)
+			continue;
+		prev_r = damon_prev_region(r);
+		if (prev_r->ar.end != r->ar.start)
+			continue;
+		if (prev_r->age != r->age)
+			continue;
+		if (prev_r->last_nr_accesses != r->last_nr_accesses)
+			continue;
+		if (prev_r->nr_accesses != r->nr_accesses)
+			continue;
+		prev_r->ar.end = r->ar.end;
+		damon_destroy_region(r, t);
+		r = prev_r;
+	}
+}
+
 /*
  * damon_feed_loop_next_input() - get next input to achieve a target score.
  * @last_input	The last input.
@@ -2528,7 +2559,6 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
 
@@ -2551,9 +2581,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	damon_for_each_target(t, c) {
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
-
-		damon_for_each_region(r, t)
-			damon_do_apply_schemes(c, t, r);
+		damos_apply_target(c, t);
 	}
 
 	damon_for_each_scheme(s, c) {
-- 
2.47.3
