Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8922D7804;
	Tue, 28 Apr 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340070; cv=none; b=H/6M7rX+TWqQXw1yJSJjR1HB7bgpw0bO/tnYQMBsBak+EocLaGN7ILio/t9IDDpa99tcAEhSIgjPmc9gXUwQULfxXUJc6M/7H8TuNaGqoQAfXod2tyfUPMGjZbWawan4/hQlnpLQFRJ90E/W7pm8uMhv/NGyMYvyW9ZeESqgu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340070; c=relaxed/simple;
	bh=pId4SoTQNM9qN5MUX4PnLv1gsuVQ5SK5VnLsAsG+C5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICubmbRyQ44W95hdetraP1aGYOmSNBZf396Os6lLysK1HKJpaD1zn9wgoPgLx0PfHE0znvj/LkI7fMUpShZ0bMlN3Q6YxUmeUP6hz0QR8AJrQcPcKfW9bpuZKnsOJTFXGtlxDepU85ypwrDLLlBkq1NY6vrevl+2WL8ghv2QXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfFQDI6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfFQDI6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E8BC2BCB8;
	Tue, 28 Apr 2026 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340070;
	bh=pId4SoTQNM9qN5MUX4PnLv1gsuVQ5SK5VnLsAsG+C5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfFQDI6YTDzLPS/XP/FMb3x24PrEVecSxF9Rdf997bheRPoY/CqhmqbBuKnZsyOz2
	 hyDhsmyG+eeo+DLKpfQ5qBlMuWo/9d9HdortkC5O0vjJ/oDdYYHLqfuy5Pm19PT6Rz
	 lwcY1YlQWCtcn5CxTLvQcCOzpdygM5c9IpwbR2m22C3sLi19KIQzP+ziQXwE2gqSrO
	 SHrjTe+/ycFWPZ0HpMVTcP66dtQg7q2GOpw6JKJ7MWTb2vNwZ9PxJEYAJXzibsDRcR
	 ZPzGAQ3CNCgEB3Grj2Scdr0T/TcX8UbXG856YnI/FbnO513gt66a7HwmETNEOamu2T
	 FH4odM3OvoOmQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] mm/damon/core: merge regions after applying DAMOS schemes
Date: Mon, 27 Apr 2026 18:33:51 -0700
Message-ID: <20260428013402.115171-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
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
 mm/damon/core.c | 59 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 888b6ac29feff..8e1e19611c387 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2164,6 +2164,58 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	}
 }
 
+/*
+ * damos_apply_target() - Apply DAMOS schemes to a given target.
+ * @c:			monitoring context to apply its DAMOS schemes to..
+ * @t:			monitoring target to apply the schemes to.
+ * @max_region_sz:	maximum region size for @c.
+ *
+ * This function could split regions for keeping the quota.  To minimize
+ * overhead from the split operations increased number of regions, this
+ * function will also merge regions after the schemes applying attempt is done,
+ * for each region.  The merge operation is made only when it doesn't lose the
+ * monitoring information and not violating @max_region_sz.
+ *
+ * Hence, after this function is called, the total number of regions could
+ * be increased or reduced.  The increase could make max_nr_regions temporarily
+ * be violated, until the next per-aggregation interval regions merge operation
+ * is executed.  The decrease will not violate min_nr_regions though, since it
+ * keeps @max_region_sz.
+ */
+static void damos_apply_target(struct damon_ctx *c, struct damon_target *t,
+		unsigned long max_region_sz)
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
+		 * information and not violating the max_region_sz.
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
+		if (r->ar.end - prev_r->ar.start > max_region_sz)
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
@@ -2533,9 +2585,9 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
+	unsigned long max_region_sz;
 
 	damon_for_each_scheme(s, c) {
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
@@ -2552,13 +2604,12 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	if (!has_schemes_to_apply)
 		return;
 
+	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
-
-		damon_for_each_region(r, t)
-			damon_do_apply_schemes(c, t, r);
+		damos_apply_target(c, t, max_region_sz);
 	}
 
 	damon_for_each_scheme(s, c) {
-- 
2.47.3
