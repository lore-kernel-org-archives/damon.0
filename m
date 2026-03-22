Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC63630B9
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215400; cv=pass; b=eCMpyqmLxgLgvpfzbZirxTtqPJ+Fuc3ljiq7D7+Kj7MJ20hmqFu34gLOHtuoadblbQaQk6Hry+bh9htmWukqPRu8XFCntnXQ6j2Sv0bmEwUrTf924LPiLDrP0D+eHJlr5z/WkS+LI5dRgBul6a6f9nKD++bvgEPGpjBl1MG+ry4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215400; c=relaxed/simple;
	bh=yEQ0HmqWknkliaUeDQEhusyB8EwptCuwlnXaC/zQt3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZ+/zkdRU1wmUSv7mYyLLN/pmB5WcgEhzPpAt2SyP1VrUrptaTPZ+gBflo4jM2EyjQatj0XQcoFvp5tns05ZIpLj4TZ7PHotn+PUlreXv21PNP9ccKoRHKeKh3tfVgicY9S0aPz3eHu97zM0AOxQqh7suV+mja1VkOqstFW7JCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=AFThKKQX; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="AFThKKQX"
ARC-Seal: i=1; a=rsa-sha256; t=1774215395; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Bg+6s+QUK/mIlYYVa+pEfVGbxTNwLScwr4mjCcNPOzQZ/nwXhdGmHtiKYZ9qF0fF0X5P6lwN4g3UlWcCESqYWyemgxC5VELzU1DBf9vBeb07DyquBCY3SO/fCZRKW/uzcENY1fLEQoRZ4+4HvtLG54L+Ogb4P+b35ASUv+B3C/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215395; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HvXkdekkoCKye7mj9eb/H1RyQQk11r+xEZYMc+3T7us=; 
	b=OWdJR5w7Mo51FYUjy4kJ+1TIXzZmepp5voCjL5t+kVR2sv2TRWvE8S11MKt8Oot+BLAQ+cPelv1oo2gINXiTQaS1iKDxx+1hCLu0hwkTMfAwQWqyw4RwG39NrE17vd55e2I7HvLFYzlCClvDVV+iw0XkCcyRxztcXtTeqbRyPSo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215395;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=HvXkdekkoCKye7mj9eb/H1RyQQk11r+xEZYMc+3T7us=;
	b=AFThKKQXBtmARcSc/AFM8aeiZlC1Ys/8f/hV83hmr2RGTO9Fo9q9IVs7Q6kFZGF9
	a2+jPWdVkTsvns27UN36Oa0maEP9q14e6bGi7MDTXDi35bqhQfp5kI5gzHKd43Oueu6
	/Qz7UcBw87S0z3dKkMk8vHpzH7jR6orRmd5Aihyc=
Received: by mx.zoho.eu with SMTPS id 177421539290970.2907397850829;
	Sun, 22 Mar 2026 22:36:32 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2 1/2] mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme and region loops
Date: Sun, 22 Mar 2026 21:36:30 +0000
Message-Id: <20260322213631.259212-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322213631.259212-1-objecting@objecting.org>
References: <20260322213631.259212-1-objecting@objecting.org>
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
index c884bb31c9b8..dece0da079c8 100644
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
+						s->max_nr_snapshots <= s->stat.nr_snapshots)
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

