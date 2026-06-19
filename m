Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028993B6BF1;
	Fri, 19 Jun 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897688; cv=none; b=peHSisKhuJHJj54c/b6nS8QfoMrlSpJVRGrlG2Y+Fxs/cjvn5+Zo5eyUSGvm2JWFmzn/Ep8nD/C583VPAcR56iuFDuYp4iB0hGFK3BN0jysTl+L3v4Kd8XyYN3+YgnhgwpJxdH71PAJsqohCywWTOXUouJ0pKniVBRH2qshPyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897688; c=relaxed/simple;
	bh=bgLBJ/GXUsvrTf/mTcATgHkmM5FCU8gZ+FjIy9Cv2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbpAqU2j7OqbDu9apKpgasqShPDilyrMZyueXnLhcSDnJy+3B6NDlRNsEK2428XKhPDCcPaNGFIaWuTOpgLokoQhvA6YNnvujsNYZwBH64kQ/Di3bXn3OgxYeXZ6Gc8KdcngagDcdmRSkcdOCSKJOJT4syNi+Qy5PN/GGgTfF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9PKAF4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9PKAF4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0331F00A3D;
	Fri, 19 Jun 2026 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897683;
	bh=Mj0WGbOgmW24rBedByuWyQfl2j0/cU9b+G44I09HpLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b9PKAF4zEoqNsBbqOMqLn6VEvkGq+pyOY+0V/lEGTXhoofxVS5wFTR/lAyQIoohew
	 jzQKCOhleBfcyiZeJOBxZx3t0g2IMJJEYX9f28XoCBL/5WGhKrIkRL/2LTsg7l6N/v
	 OWdDCzIkP4QIVGZuDFQhOdDpalUEPF7RO+FkK9iGIr1MnOMEC4KdoDaIUWcKzftY9Q
	 cGeIsI0WZWFVfV9scjXpfhTNGKOY6Cy2u+K51r5zGs9PNB4LgnDEnRjmu2U1j60Knv
	 EDdJy7d5r667Skm2KKzVlIVvfGlSVdKyF/Kc9eMMJappjIBqUYDaflGWoGjr3CXA5A
	 SDkMnZHhArPTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/13] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Fri, 19 Jun 2026 12:33:56 -0700
Message-ID: <20260619193415.73833-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
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
 mm/damon/core.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f2db39aa34f4c..eb129e3f7029d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -294,7 +294,6 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-	region->nr_accesses_bp = 0;
 	for (i = 0; i < DAMON_MAX_PROBES; i++)
 		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
@@ -869,7 +868,6 @@ static void damon_update_monitoring_result(struct damon_region *r,
 	if (!aggregating) {
 		r->nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->nr_accesses, old_attrs, new_attrs);
-		r->nr_accesses_bp = r->nr_accesses * 10000;
 	} else {
 		/*
 		 * if this is called in the middle of the aggregation, reset
@@ -879,7 +877,6 @@ static void damon_update_monitoring_result(struct damon_region *r,
 		 */
 		r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->last_nr_accesses, old_attrs, new_attrs);
-		r->nr_accesses_bp = r->last_nr_accesses * 10000;
 		r->nr_accesses = 0;
 	}
 	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
@@ -3096,7 +3093,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
-	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	/* todo: do this for only installed probes */
@@ -3208,7 +3204,6 @@ static void damon_split_region_at(struct damon_target *t,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
-	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
@@ -3777,18 +3772,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
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
