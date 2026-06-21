Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCE2459E1;
	Sun, 21 Jun 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057462; cv=none; b=B/7m8wanf1gotIZ5yRRkwLujZl5bybJZ5XqzLxuZEkZw7RV0XH1jggr+mb2BLV+45V5w1rFAAsc230kvGa7mmQ+g7JIqTr3+MMKmtUTw2ofYF4OtPRkScD/6mTBFgMiH88434irMBmdt9L0YCeOU7rvI/mam1K4oaeZueL13PGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057462; c=relaxed/simple;
	bh=zJqm1adsIS5HEif7Eb/DN7AiXXEatUoLj8AlNis5xDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRktdQNPAp2jff41L73N7Zzq4VLfmbWnCWGV3LDQyRWcxhq8j8JIdAMlNtdc8HWYWrrIjLR0MBqJBd5P6hfc2Oz9wVT2Ff+ushT3jxBhH79rDt2twi246nyB8Qh9zik0hyvRbMIVbndGFf4y3xl+Q9PoHJjLdz5PFPc42PSanyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bic3bOc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bic3bOc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85BD1F000E9;
	Sun, 21 Jun 2026 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057460;
	bh=pZ+M6B9rIjrwF8KBw1ippRvOtN9mQ1VfyOBQJ+Ky9uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bic3bOc+7MqO9Am0FvLYr3v1YRndBTbKdZxnFGv0alNSNreSH/E8jC5eKlnQYEPL1
	 XW6FGiwkz5D4WJXFtyfzGYhfT8anUc4/SNmvmuSvK5X01tzNv5pcx7WSYx++9w6Buv
	 3McFZ/ZcMddHweS0ulqgNa4lNlCuWDWlxxfBMupSaIIkKXHPqzn/tCxqoD2TfM5B4q
	 +CwQ8iNOvOuf+r14D3Ia2Yl7yTX+el2HWA+Gi82lILt87OCsF3Wmm6zgsdbDBPaNA1
	 yO77s6MchmATVf7Ck+1PG6SwP/Kc4Zji86BVT7yGpkGQE2PYotbqgK1ikTHALOTOH9
	 nHSZcfBprXaug==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 12/17] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Sun, 21 Jun 2026 08:57:08 -0700
Message-ID: <20260621155715.87932-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core sets and updates nr_accesses_bp in multiple places.  It
explains how delicate it is.  The field is no more being used for any
real purpose, and replaced by a simpler function.  Remove the setups and
updates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 76ac58bf3dff9..c3c8e83234011 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -301,7 +301,6 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-	region->nr_accesses_bp = 0;
 	for (i = 0; i < DAMON_MAX_PROBES; i++)
 		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
@@ -875,20 +874,17 @@ static void damon_update_monitoring_result(struct damon_region *r,
 {
 	r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
 			r->last_nr_accesses, old_attrs, new_attrs);
-	if (!aggregating) {
+	if (!aggregating)
 		r->nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->nr_accesses, old_attrs, new_attrs);
-		r->nr_accesses_bp = r->nr_accesses * 10000;
-	} else {
+	else
 		/*
 		 * if this is called in the middle of the aggregation, reset
 		 * the aggregations we made so far for this aggregation
 		 * interval.  In other words, make the status like
 		 * kdamond_reset_aggregated() is called.
 		 */
-		r->nr_accesses_bp = r->last_nr_accesses * 10000;
 		r->nr_accesses = 0;
-	}
 	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
 }
 
@@ -3103,7 +3099,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
-	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	/* todo: do this for only installed probes */
@@ -3215,7 +3210,6 @@ static void damon_split_region_at(struct damon_target *t,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
-	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
@@ -3784,18 +3778,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs)
 {
-	unsigned int len_window = 1;
-
-	/*
-	 * sample_interval can be zero, but cannot be larger than
-	 * aggr_interval, owing to validation of damon_set_attrs().
-	 */
-	if (attrs->sample_interval)
-		len_window = damon_max_nr_accesses(attrs);
-	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
-			r->last_nr_accesses * 10000, len_window,
-			accessed ? 10000 : 0);
-
 	if (accessed)
 		r->nr_accesses++;
 }
-- 
2.47.3
