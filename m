Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48F3BE636;
	Mon, 22 Jun 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138125; cv=none; b=bE1znWfNxG76PeoyZkgnW9jLkUszIiJyuZ58B0vPirVJ8UOaU3rzQx4fv56mtTOUK0lUX1ekQdH7u/JTmL1bvyAqjvF2Vg2eetfjAafpC5gS21DbactQHAD2+mgcQJDI6L6jexn3I9Xu+g5k5+wZUnRQCKcqGXemi5lM+Pwv3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138125; c=relaxed/simple;
	bh=3k5/sgMyEFl7Pm61/oDYcT/SsoNqJArhNImPs3atqMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqi4RcqYyIw7jaeS2Qfbmx/qBGyz7tIdVQy3neopemCc5zdeOAMd//PKmf6Lg+9svwbyCHmP9KWu9THiujKohNWg/Fel3BFMceFgHhFtFq6kSz5PZBzoIR2vg6t2tdh9PW1M+QJrWl4rDoFMihAYXmkGYYDBEtSbiL3TfzS9kPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLzrbKBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLzrbKBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48CD1F00A3A;
	Mon, 22 Jun 2026 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138124;
	bh=ZFWaG18Q1S2T37NGDzr0/yr5IxRaKdmsNfBt6SXMm64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLzrbKBCZEQt7wyxBpv4Q96/r5dgTtOv9wq4fhy50NxZwjlFY92gv75SeROaBvwXj
	 inPw7ndaGjFDP22G+mLlJ0gbKpEtgl3XrdGESAiJhBpO6XcJtILubsitaeEaxL6wLI
	 mfpKglUHuGT/vlemS+kWO4IEC2qjNTAf9YOgjMnncul58DV9fmif1UWsKJEL7GI4bk
	 1DC06Rmj/ugzl9fRfNj75DaH6EQ4R05I/dhrw8QFVZKLmM6sVMo4uLVJccxDrRW0PQ
	 CYb+n19md7+9nx743LuLzujioJetuxLp1FFfO7SsyzmtNpR9uESs1ZyXeSxcZSMnta
	 wN7pFr5j35gsw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 13/18] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Mon, 22 Jun 2026 07:21:33 -0700
Message-ID: <20260622142139.30269-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
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
index 80c1b34062312..b095f053c6fa6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -304,7 +304,6 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-	region->nr_accesses_bp = 0;
 	for (i = 0; i < DAMON_MAX_PROBES; i++)
 		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
@@ -878,20 +877,17 @@ static void damon_update_monitoring_result(struct damon_region *r,
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
 
@@ -3106,7 +3102,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
-	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	/* todo: do this for only installed probes */
@@ -3218,7 +3213,6 @@ static void damon_split_region_at(struct damon_target *t,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
-	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
@@ -3787,18 +3781,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
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
