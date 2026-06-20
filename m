Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031132B131;
	Sat, 20 Jun 2026 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976189; cv=none; b=DhGjpRKzrBPF2SgPsB+Dal5nokdQGhA92gfsEcxW29reWx8ghSaK4FYXWeNoKlb3muvoWuDy3us8Y5H3T/DdNq2AFzWGyjYtVOfkFr6EvrB5qozJy2jv7NHvF6SfrOPICsyxbc3aZN2UpkfVSENTBx9CnqLw7eHLDEAjAZeFRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976189; c=relaxed/simple;
	bh=2QIirEY2L9zYfvVrltm6Kc1fJSSngofbSznue8tphoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJtwTVljNAiVeqgPTiuDXk9pHK0wcnif/2UM/vLpnpbyWgcn2s1E3D+Nvh1APtOvzAU0r8kp8b8WA9mIyoEHCyIUcnsxynj14M2p1WI5T48akJwdpMKOAnsUT26BWaOjDRcfj50rbS9UwJa1v7n1WapaZ3Ng5aCSyoKbiIa26LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTtfTXie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTtfTXie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA651F00A3E;
	Sat, 20 Jun 2026 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976188;
	bh=Yfz/vcTh4OReLW+aHL+DnaWiXdgfMAGg8KOhU15bMGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTtfTXie4rpOXmDrW7lYvFVx5Ab/UE496E6cBNmBB1TnJIAonQ+ryJd5HhtirwLWa
	 IUZ1Esp4iSqssik3vgktZIj9o+iUTp++faa+XPzj0OQP6RBV6GkkmyTFKvIWAGdnIC
	 pfxXn8gSY9DHzC1hjw7C2z0wFI5Fl0Pxslybcz//GKcuvvYYwXWBYrQHSM+53qgCvi
	 I2A7ZWPa1uLdawkKxOzFBHFelUW+Fpw7J0u1ZCRlwoj8NcU1yksLI9vyo10mtivNn4
	 j7cY0y22vlUARD8B9TzcK1N7VHmQo49jqGJ3P63RFmmPRUtau4JJv6O3Geps2AP3V5
	 oNDIEkaSF6a4w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 11/13] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Sat, 20 Jun 2026 10:22:41 -0700
Message-ID: <20260620172244.90953-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
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
index 6db157ee25129..471b58e8e31b9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -296,7 +296,6 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-	region->nr_accesses_bp = 0;
 	for (i = 0; i < DAMON_MAX_PROBES; i++)
 		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
@@ -871,7 +870,6 @@ static void damon_update_monitoring_result(struct damon_region *r,
 	if (!aggregating) {
 		r->nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->nr_accesses, old_attrs, new_attrs);
-		r->nr_accesses_bp = r->nr_accesses * 10000;
 	} else {
 		/*
 		 * if this is called in the middle of the aggregation, reset
@@ -881,7 +879,6 @@ static void damon_update_monitoring_result(struct damon_region *r,
 		 */
 		r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->last_nr_accesses, old_attrs, new_attrs);
-		r->nr_accesses_bp = r->last_nr_accesses * 10000;
 		r->nr_accesses = 0;
 	}
 	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
@@ -3098,7 +3095,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
-	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	/* todo: do this for only installed probes */
@@ -3210,7 +3206,6 @@ static void damon_split_region_at(struct damon_target *t,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
-	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
 	/* todo: do this for only installed probes */
 	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
@@ -3779,18 +3774,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
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
