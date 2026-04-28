Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FA2D1303;
	Tue, 28 Apr 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340070; cv=none; b=jaL7ByWwuXCpB9xHMX+c7Itl+Uru7SUsomujv9Wp0h+pgA2UrAEihyNr8VxmErLxNwB2Z7ZP2oHM/Qjl6huqEwhXcQPiY2/bEOhM3EjtvXs4103tbvw+2+yYOex4KKs+9jnSVvkoz7pFjVJvNG54TeeUGxVMnPPg4SdZZnSbJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340070; c=relaxed/simple;
	bh=CbuuRamb/kBQi30M9xcMQJVCapHdXjhxNpZwhqf9TZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaMaMod/ZmgXKcDY1mkhksL9NPhN2/XpyW4+FAl0quxB7B1GhAXNB8wdP94t2ZF8ehizQNkfBg1yRWp4uHenPjkCYKWq9PwYpqU+W+RJY473QfG3NytmMWOZzW45thhPR0Z109tEjmXXiNN5W7V0nC28N46Q4eDArpSElicSdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omaAhUye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omaAhUye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE879C2BCB9;
	Tue, 28 Apr 2026 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340070;
	bh=CbuuRamb/kBQi30M9xcMQJVCapHdXjhxNpZwhqf9TZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omaAhUyegFAJx3SDDZ9s6uKHSs/OVhumd7gScii7OT1kQ86yFeNfP5NwgoHvIi0Dt
	 XSPF8wfv0S6k4KUlhaggo5kuqmaygpeNULxi/ncPJvGr90Xp5gHBZweo6qHTrhfQf5
	 MrzZ5BI3Wlk9Z2GZrc0czpa4kR/MwTjcwdlSBuTsqUDFOIN4UBX6W73zRd5eZo2DvP
	 oE/lUwrLarSIlVJ3NAmzIsnKbmVuFO34UzAWcT89kd7lRAwO+KtLAUhpDkUV89zUD8
	 Q2peGg4FMIeuO5NtZ4h0VRVGL0F68DzRi0CmCmPZrmsfLCv8MgZW/SQFvGB8FClP95
	 viYG76miNhlPg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Mon, 27 Apr 2026 18:33:50 -0700
Message-ID: <20260428013402.115171-2-sj@kernel.org>
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

Less than min_region_sz remaining quota effectively means the quota is
fully charged.  In other words, no remaining quota.  This is because
DAMOS actions are applied in the region granularity, and each region
should have min_region_sz or larger size.  However the existing fully
charged quota check, which is also used for setting charge_target_from
and charge_addr_from of the quota, is not aware of the case.  For the
reason, charge_target_from and charge_addr_from of the quota will not be
updated in the case.  This can result in DAMOS action being applied more
frequently to a specific area of the memory.

The case is unreal because quota charging is also made in the region
granularity.  It could be changed in future, though.  Actually, the
following commit will make the change, by allowing users to set
arbitrary quota charging ratio for action-failed regions.  To be
prepared for the change, update the fully charged quota checks to treat
having less than min_region_sz remaining quota as fully charged.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 278594847cf94..888b6ac29feff 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2047,6 +2047,20 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->walk_control_lock);
 }
 
+static bool damos_quota_is_full(struct damos_quota *quota,
+		unsigned long min_region_sz)
+{
+	if (!damos_quota_is_set(quota))
+		return false;
+	if (quota->charged_sz >= quota->esz)
+		return true;
+	/*
+	 * DAMOS action is applied per region, so <min_region_sz remaining
+	 * quota means the quota is effectively full.
+	 */
+	return quota->esz - quota->charged_sz < min_region_sz;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -2104,8 +2118,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		quota->charged_sz += sz;
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz) {
+		if (damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
 		}
@@ -2133,8 +2146,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz)
+		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2460,8 +2472,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!time_in_range_open(jiffies, quota->charged_from,
 				quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz)
+		if (damos_quota_is_full(quota, c->min_region_sz))
 			s->stat.qt_exceeds++;
 		quota->total_charged_sz += quota->charged_sz;
 		quota->charged_from = jiffies;
-- 
2.47.3
