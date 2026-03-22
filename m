Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F309255F57
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215814; cv=pass; b=ClsOnM85AGQ8jC+CAcE3l1WT7xDerlHjUv/f+9kC6sdbleO7Ll+LIcGpQAbkN00sryyM9Qsic3fXKCGplHciRVTpuM2iK4IPNm2bTlk1QQ0rK/MZ15kihQRwt6v4bgQjsiHIeXnTfS/Ij/BXa+YQ8B/2fYiTLrAd/Y+6k13e844=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215814; c=relaxed/simple;
	bh=lP0+D38GM3hTFfAprnL5rlYWxycvZUWLVpd/rt2LFbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srh2VJavg5AvFDL7TFtepFAp2Qe7p813G6qfeZk8bH2U47UxYSCP5+Y66L7cG519FRgbd3QcSdKd7yYtTGkDt6VzgHtWMB5Mp3F91jQ++ht60LA2DpDYivQ+R5baEUbUvEO4QLTvqn7fMNGwfW4yw/th4IpBXu4yLW5g+pqTgEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=K5up9Nu5; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="K5up9Nu5"
ARC-Seal: i=1; a=rsa-sha256; t=1774215808; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RtEyUM7kF1Wres3ENYxupv8/htOW0w+G2jklTqUcs5ofUO8fTba5/ugxUEXWGPL6FgPGZTxThnyv3H8/IhFNysEZW64ZmUgFDMar+PG7QOZ2e83wWGAddM9huQBr22YqzmJ4GFFQRQmm9Df49NumTFiPVy4D7RzvVB2+cIaRXb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215808; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QvZxrK6HT4hT8z9a/s0ePK0Xc63KHmmHo3QU5RxikeY=; 
	b=gYNnPMSf36jAt+aB0lYRkhbj/VWet/o3d2augd3LcEiyfPxMcQcRasdBjuxlu/sfnsdiBoirEUjJ0ST7J0Npt/82K2xFdH8XEyNiIzBlH46pEuSCLF4pejREoIM7WH4N1FLieo/xlPgbAJuPJuDBkJF38Jk8hNNirwi3uI2cezs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215808;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=QvZxrK6HT4hT8z9a/s0ePK0Xc63KHmmHo3QU5RxikeY=;
	b=K5up9Nu5/BjQc185idVXkOc9WLuNbJk+gE058sNkDN3qyW6lqYQHurMxU8QbkWZi
	5srI8Njq68sT7B4tqzB91ZHz5Z8UqFbpH0gL+6wrC9MylM6gTBZxNlFIv8lY8mKTYEv
	dHH/jAiSXNER+qZSFcyEgldq8AfO4+wFO2YR2fEA=
Received: by mx.zoho.eu with SMTPS id 1774215806413678.0718747966108;
	Sun, 22 Mar 2026 22:43:26 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 1/2] mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme and region loops
Date: Sun, 22 Mar 2026 21:43:24 +0000
Message-Id: <20260322214325.260007-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322214325.260007-1-objecting@objecting.org>
References: <20260322214325.260007-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Currently, kdamond_apply_schemes() iterates over all targets, then over all
regions, and finally calls damon_do_apply_schemes() which iterates over
all schemes. This nested structure causes scheme-level invariants (such as
time intervals, activation status, and quota limits) to be evaluated inside
the innermost loop for every single region.

If a scheme is inactive, has not reached its apply interval, or has already
fulfilled its quota (quota->charged_sz >= quota->esz), the kernel still
needlessly iterates through thousands of regions only to repeatedly
evaluate these same scheme-level conditions and continue.

This patch inlines damon_do_apply_schemes() into kdamond_apply_schemes()
and inverts the loop ordering. It now iterates over schemes on the outside,
and targets/regions on the inside.

This allows the code to evaluate scheme-level limits once per scheme.
If a scheme's quota is met or it is inactive, we completely bypass the
O(Targets * Regions) inner loop for that scheme. This drastically reduces
unnecessary branching, cache thrashing, and CPU overhead in the kdamond
hot path.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 72 +++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c884bb31c9b8..a9cfbd6ce3d4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2112,40 +2112,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
 }
 
-static void damon_do_apply_schemes(struct damon_ctx *c,
-				   struct damon_target *t,
-				   struct damon_region *r)
-{
-	struct damos *s;
-
-	damon_for_each_scheme(s, c) {
-		struct damos_quota *quota = &s->quota;
-
-		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
-			continue;
-
-		if (!s->wmarks.activated)
-			continue;
-
-		/* Check the quota */
-		if (quota->esz && quota->charged_sz >= quota->esz)
-			continue;
-
-		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
-			continue;
-
-		if (s->max_nr_snapshots &&
-				s->max_nr_snapshots <= s->stat.nr_snapshots)
-			continue;
-
-		if (damos_valid_target(c, r, s))
-			damos_apply_scheme(c, t, r, s);
-
-		if (damon_is_last_region(r, t))
-			s->stat.nr_snapshots++;
-	}
-}
-
 /*
  * damon_feed_loop_next_input() - get next input to achieve a target score.
  * @last_input	The last input.
@@ -2494,17 +2460,39 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		return;
 
 	mutex_lock(&c->walk_control_lock);
-	damon_for_each_target(t, c) {
-		if (c->ops.target_valid && c->ops.target_valid(t) == false)
-			continue;
-
-		damon_for_each_region(r, t)
-			damon_do_apply_schemes(c, t, r);
-	}
-
 	damon_for_each_scheme(s, c) {
+		struct damos_quota *quota = &s->quota;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
+
+		if (!s->wmarks.activated)
+			continue;
+
+		damon_for_each_target(t, c) {
+			if (c->ops.target_valid && c->ops.target_valid(t) == false)
+				continue;
+
+			damon_for_each_region(r, t) {
+				/* Check the quota */
+				if (quota->esz && quota->charged_sz >= quota->esz)
+					goto next_scheme;
+
+				if (s->max_nr_snapshots &&
+				    s->max_nr_snapshots <= s->stat.nr_snapshots)
+					goto next_scheme;
+
+				if (damos_skip_charged_region(t, r, s, c->min_region_sz))
+					continue;
+
+				if (damos_valid_target(c, r, s))
+					damos_apply_scheme(c, t, r, s);
+
+				if (damon_is_last_region(r, t))
+					s->stat.nr_snapshots++;
+			}
+		}
+next_scheme:
 		damos_walk_complete(c, s);
 		damos_set_next_apply_sis(s, c);
 		s->last_applied = NULL;
-- 
2.34.1

