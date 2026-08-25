Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36F442B3E
	for <damon@lists.linux.dev>; Tue, 25 Aug 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661974; cv=none; b=LaqyVzkk0ueiH3RCYjt/2BlQUkN1ZvsVIo8cAiCx/TDD/WGQnl//amjwUNuBSqnl3/COHP2ulnDwOALHF/K5h93/+TWeWucTKg/LLKFpFm98n5f5zOHesH9fWlDiBUDoMr9waQ1DmOgvcXX3cSFwJ0Jmjzz3J0EbRs4eLQuTC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661974; c=relaxed/simple;
	bh=rtRN37WYI8riUWI7m4LZmoEcuADBH39oC6zAOHRif0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D89y/XMDNO13UkxLQXYoutuuqa5OrU4VHd2BBKHtjeDsQADIewJupKHtk44c3yeMTHK6o6KyaLcAq7ETaylY8A9vr+tAyFvSxArmuSK7XFaKFML8gpqG2eV1SKtfgWdIUCd/1SKU4OqfuRkB0zGtCYTJ9/VcyrlZSuJjm8primc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt2P2tRT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt2P2tRT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3900e39d935so5129042a91.0
        for <damon@lists.linux.dev>; Tue, 25 Aug 2026 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661972; x=1788266772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a2Asa4hLurNMrCEVCTFHSXC6wwWf0Qto8+IsnkijKbg=;
        b=Rt2P2tRTEaCVhIea49882f88IyPEIc+5wP9E74cgjms6EMYvWZc20IO2JYDqapnzV3
         1XOhKRuhRhaAXM52QDPss7RguuBO0goJgp+Vo7eABbXKQAKGe8LmIbmiO6L+0x72hekX
         T+d1oVaPMfSSz4QjpX5hhVw8g1kt4OI2rxwsBNTx9u2mqXe8YMCazZ0hppZsdgGhI3Dz
         XKFvnYy9M0RVcWfvmaDTShA/QaJYIjO8Dzblk6/50KY5dIGGNihr6B0HzWhbzGYH1CO1
         WID0z/U1FzdEfEySiSzx70WzoJZgAITWrkwb8j9oaRMSKALDaGH/wK3kQV+HBmaicpq7
         bbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661972; x=1788266772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2Asa4hLurNMrCEVCTFHSXC6wwWf0Qto8+IsnkijKbg=;
        b=f4eeEOLH/qAcpvJG80cjf6cCJ5g2wtjZrMS2TPfm2ik3xfvaklMkURsZyn27LJDPJG
         pU6OLtoAJ2spHrFg0yStSkSsO9Tzra3773k6E9FymP1EnfLiW4CKfHaORlVClozyvQe1
         QE8Amijm3VwKtRxEUBrU93r4K+O9WiiiviWvEgv8yUIqmZIXuFF+jMIsfNk2IxGd5X/j
         3WHmdE7PBwVj70rxN6mqc8LIX+BePxTse9wWM0Ozj8WmK4/KIqKP0riXddMk2OEbHZFz
         VCz09/8pJH1RVrzxpLRci6pXhpfZsIaoMrc+W398UM6OMbipYLkUetT1qoGebP69o6BR
         +7WA==
X-Forwarded-Encrypted: i=1; AHgh+Rrca/Nfm1igEV471E9WcTJ7e+RxORgRmix5oB7vM3DrpTMYheWFVvlG5qQkvi4iMoTH9DuGkg==@lists.linux.dev
X-Gm-Message-State: AFuF++nSVqAt7WgnJiLqJ0js9SV7PWOig+lvXCVu5IK8Gc6xYnFRlYUE
	GyGvBXjJ43+7Swa640TMD1xFm+cO0UZXcp5zmsMeW4JqRHebWxpC34iF
X-Gm-Gg: AR+sD12Wimhi1zJ/kMPMAVcnO/3yMLQ7RN7upkUiu9ab4WmYUtgIXtQx+BB+jneoKp8
	e5PRne6c77RvmDFqTy5Rcoou19PNb5pTZIIkl5wNbnzM4JjyDCCYadDYjf797PtpT01F5MIYUFd
	hL61CjlUOwt/RzIo4UWmjGj6LhDadB/56aLnRFD28Of+JFn7aUyg7kfLeMjOITrpVFtmSfD3SRq
	H9/V1fzUDjDciNhrv985BlEbFrZ+EhaPGkcoygmvvPrlcp/0ueMmgiEsnNfIeQU3vuf6LTK1Fkz
	dnWhHgzK6Wlvpe7ThAl225h61QbyBS7CP7uMN+2kpDVyTmxNNbeAQFwjykhxW6fyGguIvae1Ehd
	Si9Eu6Dst65MAur/RJ4xv5JngE2Ui5gAvchCDyEgSiWrZulsZmwf/r4J9OAQB3tnm9sCdcpEv6w
	SzeM6YLrpsWPL1p8mhW6+GoJSxY+6kEWKXsvlGY0cCYcBqkXMCgzj8YyCS55ghM37omAN2qXoR5
	rJ96apLGgSUtWH/uwBwgQkbOQM=
X-Received: by 2002:a17:90b:3811:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-395df24f20cmr45613753a91.10.1787661972204;
        Tue, 25 Aug 2026 05:46:12 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:c23:7fa2:94a9:2164:3642:a5a8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645c06e02sm3738983a91.17.2026.08.25.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:46:11 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Tue, 25 Aug 2026 20:46:16 +0800
Message-ID: <20260825124616.5129-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS uses charge_target_from/charge_addr_from to remember how far a
quota-limited walk has progressed.  The current implementation has two
problems:

1. Once set, the cursor unconditionally skips and resets at the last
   region of the tracked target, so the last region can be skipped even
   when it has not been processed.

2. The cursor only advances when the quota becomes full.  Regions that
   are filtered out do not move the cursor, and the scheme can remain
   stuck on the same regions.

Fix this by treating the fields as a rotating walk cursor:

- Advance the cursor for every region walked while a quota is set,
  regardless of whether the region is applied or filtered out.
- Remove the unconditional last-region reset.
- Skip regions before the cursor, and rotate to the next valid target
  only after the current target has been fully walked.
- Rename charge_{target,addr}_from to walk_{target,addr}_from and
  damos_skip_charged_region() to damos_skip_walked_region().

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 include/linux/damon.h |   6 +-
 mm/damon/core.c       | 156 +++++++++++++++++++++++++++++-------------
 2 files changed, 111 insertions(+), 51 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..5e0755ebad75 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -296,8 +296,10 @@ struct damos_quota {
 	/* For charging the quota */
 	unsigned long charged_sz;
 	unsigned long charged_from;
-	struct damon_target *charge_target_from;
-	unsigned long charge_addr_from;
+
+	/* For tracking the DAMOS walk position (rotating cursor) */
+	struct damon_target *walk_target_from;
+	unsigned long walk_addr_from;
 
 	/* For prioritization */
 	unsigned int min_score;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..bbdb530513a1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -404,6 +404,52 @@ static bool damon_is_last_region(struct damon_region *r,
 	return list_is_last(&r->list, &t->regions_list);
 }
 
+static bool damos_completely_walked(struct damos *s, struct damon_target *t)
+{
+	/*
+	 * '>=' instead of '==', because the region set of @t could have been
+	 * shrunken by damon_set_regions() after the cursor was saved.
+	 */
+	return s->quota.walk_target_from == t &&
+		s->quota.walk_addr_from >= damon_last_region(t)->ar.end;
+}
+
+static struct damon_target *damon_next_valid_target(struct damon_target *t,
+		struct damon_ctx *c)
+{
+	struct list_head *head = &c->adaptive_targets;
+	struct damon_target *start = t;
+	struct damon_target *next = t;
+
+	while (true) {
+		if (list_is_last(&next->list, head))
+			next = list_first_entry(head, struct damon_target, list);
+		else
+			next = list_next_entry(next, list);
+
+		if (!c->ops.target_valid || c->ops.target_valid(next))
+			return next;
+
+		if (next == start)
+			break;
+	}
+	return NULL;
+}
+
+static void damos_replace_invalid_target(struct damon_ctx *c,
+		struct damon_target *t)
+{
+	struct damos *s;
+
+	damon_for_each_scheme(s, c) {
+		if (s->quota.walk_target_from != t)
+			continue;
+
+		s->quota.walk_target_from = damon_next_valid_target(t, c);
+		s->quota.walk_addr_from = 0;
+	}
+}
+
 /**
  * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
  * @r:		region to get the weighted sum of.
@@ -673,8 +719,8 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 	quota->total_charged_ns = 0;
 	quota->charged_sz = 0;
 	quota->charged_from = 0;
-	quota->charge_target_from = NULL;
-	quota->charge_addr_from = 0;
+	quota->walk_target_from = NULL;
+	quota->walk_addr_from = 0;
 	quota->esz_bp = 0;
 	return quota;
 }
@@ -1628,9 +1674,9 @@ static int damon_commit_targets(
 
 			damon_destroy_target(dst_target, dst);
 			damon_for_each_scheme(s, dst) {
-				if (s->quota.charge_target_from == dst_target) {
-					s->quota.charge_target_from = NULL;
-					s->quota.charge_addr_from = 0;
+				if (s->quota.walk_target_from == dst_target) {
+					s->quota.walk_target_from = NULL;
+					s->quota.walk_addr_from = 0;
 				}
 			}
 		}
@@ -2312,64 +2358,54 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 }
 
 /*
- * damos_skip_charged_region() - Check if the given region or starting part of
- * it is already charged for the DAMOS quota.
+ * damos_skip_walked_region() - Check if the given region or starting part of
+ * it is already walked for the DAMOS quota.
  * @t:	The target of the region.
- * @rp:	The pointer to the region.
+ * @r:	The pointer to the region.
  * @s:	The scheme to be applied.
  * @min_region_sz:	minimum region size.
  *
- * If a quota of a scheme has exceeded in a quota charge window, the scheme's
- * action would applied to only a part of the target access pattern fulfilling
- * regions.  To avoid applying the scheme action to only already applied
- * regions, DAMON skips applying the scheme action to the regions that charged
- * in the previous charge window.
- *
- * This function checks if a given region should be skipped or not for the
- * reason.  If only the starting part of the region has previously charged,
- * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow, and return true.  The
- * caller can see the second one on the next iteration of the region walk.
- * Note that this means the caller should use damon_for_each_region() instead
- * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
- * the second region will just be ignored.
+ * When a quota is configured, DAMON records how far it has walked so that
+ * subsequent quota windows continue from that point instead of re-applying the
+ * same regions.  This function returns true for regions that are before the
+ * recorded cursor and therefore should be skipped.  If only the starting part
+ * has been walked, the region is split so that the remaining part can be
+ * visited.
  *
  * Return: true if the region should be skipped, false otherwise.
  */
-static bool damos_skip_charged_region(struct damon_target *t,
+static bool damos_skip_walked_region(struct damon_target *t,
 		struct damon_region *r, struct damos *s,
 		unsigned long min_region_sz)
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
-	/* Skip previously charged regions */
-	if (quota->charge_target_from) {
-		if (t != quota->charge_target_from)
-			return true;
-		if (r == damon_last_region(t)) {
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
+	if (!damos_quota_is_set(quota))
+		return false;
+
+	/* Skip previously walked regions */
+	if (quota->walk_target_from) {
+		if (t != quota->walk_target_from)
 			return true;
-		}
-		if (quota->charge_addr_from &&
-				r->ar.end <= quota->charge_addr_from)
+		if (quota->walk_addr_from &&
+				r->ar.end <= quota->walk_addr_from)
 			return true;
 
-		if (quota->charge_addr_from && r->ar.start <
-				quota->charge_addr_from) {
-			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
+		if (quota->walk_addr_from && r->ar.start <
+				quota->walk_addr_from) {
+			sz_to_skip = ALIGN_DOWN(quota->walk_addr_from -
 					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_region_sz)
+				if (damon_sz_region(r) <= min_region_sz) {
+					quota->walk_addr_from = r->ar.end;
 					return true;
+				}
 				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			return true;
 		}
-		quota->charge_target_from = NULL;
-		quota->charge_addr_from = 0;
 	}
 	return false;
 }
@@ -2627,10 +2663,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		damos_charge_quota(quota, sz, sz_applied);
-		if (damos_quota_is_full(quota, c->min_region_sz)) {
-			quota->charge_target_from = t;
-			quota->charge_addr_from = r->ar.end;
-		}
 	}
 	if (s->action != DAMOS_STAT)
 		r->age = 0;
@@ -2639,8 +2671,19 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
 }
 
-static void damon_do_apply_schemes(struct damon_ctx *c,
-				   struct damon_target *t,
+static void damos_walk_maybe_rotate(struct damon_ctx *c,
+				    struct damon_target *t,
+				    struct damos *s)
+{
+	struct damos_quota *quota = &s->quota;
+
+	if (damos_completely_walked(s, t)) {
+		quota->walk_target_from = damon_next_valid_target(t, c);
+		quota->walk_addr_from = 0;
+	}
+}
+
+static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_target *t,
 				   struct damon_region *r)
 {
 	struct damos *s;
@@ -2658,18 +2701,31 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
-		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
-			continue;
-
 		if (s->max_nr_snapshots &&
 				s->max_nr_snapshots <= s->stat.nr_snapshots)
 			continue;
 
+		/*
+		 * Skip regions before the cursor.  If the skip makes the cursor
+		 * reach the end of this target, rotate to the next valid target
+		 * before continuing with the next region/scheme.
+		 */
+		if (damos_skip_walked_region(t, r, s, c->min_region_sz)) {
+			damos_walk_maybe_rotate(c, t, s);
+			continue;
+		}
+
 		if (damos_valid_target(c, r, s))
 			damos_apply_scheme(c, t, r, s);
 
 		if (damon_is_last_region(r, t))
 			s->stat.nr_snapshots++;
+
+		if (damos_quota_is_set(quota)) {
+			quota->walk_target_from = t;
+			quota->walk_addr_from = r->ar.end;
+			damos_walk_maybe_rotate(c, t, s);
+		}
 	}
 }
 
@@ -3241,8 +3297,10 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
-		if (c->ops.target_valid && c->ops.target_valid(t) == false)
+		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
+			damos_replace_invalid_target(c, t);
 			continue;
+		}
 		damos_apply_target(c, t, max_region_sz);
 	}
 
-- 
2.55.0

