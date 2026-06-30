Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274B3DB980;
	Tue, 30 Jun 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792511; cv=none; b=cwhV6ScUKU6xnYv/iLKlbM/dFVEgEdsoS87w2g9es+CfA3TrIPcapZw833I7SLw3iU+6eOY3uEJDsK86eu4x6uOtUBqKFmBqlPy1d/Wk/HaJQb1oO8LGH0IWZ+aYoWdYMHx/SEnkV4FGUYdiXty4KvoPp3rrR0kJIP6YN0iNUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792511; c=relaxed/simple;
	bh=jS4uL8HqEfFXspqlq5sLj/7oRX78/zw9vA1W3pExdXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHFRMSkMhS1wguONBR0STNAHYWOyWL2i9mUoRGexONezFqshvfflnfx0Pt0gzbZE/V/OY7R+7uEFJ5R+vPy9RLWiXg67wfDWYaXjJy2zshpAV9EiUcnsF3+rIPfxbkaINdbpPXLt7p4KZFsNh64vGtCClb7mEVjFQj9/iT+JmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw63Lx7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw63Lx7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C501F00A3D;
	Tue, 30 Jun 2026 04:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792510;
	bh=ISgM0/IpFYdSGK1NuzNK8sv6iik/7pwEzAP44Tm5nXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fw63Lx7akv48hSwtD/WuDicFwfkoCl91ylnECKFw+TiGqiD2mHcHh1ipb9VvgwOKa
	 YVDD+BBHiDHLSmMnR1fbrtrytq80tHi77Ze0VYxdazJTMDP12U69JuGAt9v65jsYAB
	 X/WC3KZjelGUvsw3vq8UZxe7rdOlI361ClhdrtxTou7BwZaepJkjC9rX3dvDB7ULl+
	 rIW4O/LQnQnq0U5wIkVJEtQ5TiHzRMBKphLXCfcp/GVBpPoMvhu0jS/uA74dHb1EcF
	 G6/KJbKegj4/IgojjMdm4SvUvMwFzTfihg9cdvtxki0rye5UweV5XXiT58JfoAu2UE
	 DPENrFlPK0OgQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/18] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Mon, 29 Jun 2026 21:08:06 -0700
Message-ID: <20260630040812.149729-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 78c32ee45d28b..dcd5e484fa442 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -302,7 +302,6 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-	region->nr_accesses_bp = 0;
 	for (i = 0; i < DAMON_MAX_PROBES; i++)
 		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
@@ -882,20 +881,17 @@ static void damon_update_monitoring_result(struct damon_region *r,
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
 
@@ -3110,7 +3106,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
-	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	/* todo: do this for only installed probes */
@@ -3222,7 +3217,6 @@ static void damon_split_region_at(struct damon_target *t,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
-	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
@@ -3830,18 +3824,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
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
