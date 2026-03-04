Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71571364E9E;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599288; cv=none; b=bpHZpzWU/UhqCYqOwjLjBfQZiyszAeZ/EI/2DU3e3bFWkgk6YzDxTdcWOkLvcsO+bocdu9/+1OANvDvmUlty30+08pEv0vKNru7JTdqE9UlR1213d0j6YmoYDtJ6Bt+LhvVktD+MlDwfhXV7i7Miq8PvY2rB38nl2mf0ePl2TgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599288; c=relaxed/simple;
	bh=FSeP1l4raWSiTzOnRD3+mpl3eioMh5Ef7ZEq1X1JgZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI6R8O1NQD5CVA8TTW4UVwRvGW8dorxRHF74jDs8XoDqwz49WWRgXIrRYng0rCMK7O6Jg7byIsKkDmy00kgPIqyd1/Tw8jM6ra0rwbJKEYyZY7r8t2m8Ab200MSPbqcHs0Tj6cMUVluq+BsQzF6NkrIQ+Y9KanKnXhdoXdSc6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3ep8KwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3ep8KwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B473C2BCB4;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599288;
	bh=FSeP1l4raWSiTzOnRD3+mpl3eioMh5Ef7ZEq1X1JgZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3ep8KwJcHwF+wcxjnesOCYJHluM81kV9IESbDiVACHnoP/1vN/7revdp1jrXupSL
	 IXD2vIgFe+xnhLsU/0exnuEVJuOwkxWCK/wiQPxYoeJMKvYle9XBJ/9O/G5w5qSdnY
	 Z2SqdIVlDKGqEwfr6V2XcJsyN2cNrrXsopyAycqdaQ7vjs28flwVP48nY/iTeS34+j
	 cj+7/1SdDdkFae2S6szZcsj7bGK/tbHw9Si4BcEAXGAu9XVRjZ+Gu447DuVO3iuYSS
	 j2Jev7XRN7xc/R8LCQup2APC2B4PP7XpGqfRHmNhc2eRFR1nzir17GAofvPlRRmEpj
	 R1eNG/e8mYXlA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 02/10] mm/damon/core: allow quota goals set zero effective size quota
Date: Tue,  3 Mar 2026 20:41:11 -0800
Message-ID: <20260304044122.79394-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User-explicit quotas (size and time quotas) having zero value means the
quotas are unset.  And, effective size quota is set as the minimum value
of the explicit quotas.  When quota goals are set, the goal-based quota
tuner can make it lower.  But the existing only single tuner never sets
the effective size quota zero.  Because of the fact, DAMON core assumes
zero effective quota means the user has set no quota.

Multiple tuners are now allowed, though.  In the future, some tuners
might want to set a zero effective size quota.  There is no reason to
restrict that.  Meanwhile, because of the current implementation, it
will only deactivate all quotas and make the scheme work at its full
speed.

Introduce a dedicated function for checking if no quota is set.  The
function checks the fact by showing if the user-set explicit quotas are
zero and no goal is installed.  It is decoupled from zero effective
quota, and hence allows future tuners set zero effective quota for
intentionally deactivating the scheme by a purpose.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c5503fdb10bb7..d657b87dd99e8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -387,6 +387,11 @@ void damos_destroy_quota_goal(struct damos_quota_goal *g)
 	damos_free_quota_goal(g);
 }
 
+static bool damos_quota_goals_empty(struct damos_quota *q)
+{
+	return list_empty(&q->goals);
+}
+
 /* initialize fields of @quota that normally API users wouldn't set */
 static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 {
@@ -1782,12 +1787,24 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 		r->age <= s->pattern.max_age_region;
 }
 
+/*
+ * damos_quota_set() - Return if the given quota is actually set.
+ * @quota:	The quota to check.
+ *
+ * Returns true if the quota is set, false otherwise.
+ */
+static bool damos_quota_set(struct damos_quota *quota)
+{
+	return quota->esz || quota->sz || quota->ms ||
+		!damos_quota_goals_empty(quota);
+}
+
 static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 		struct damos *s)
 {
 	bool ret = __damos_valid_target(r, s);
 
-	if (!ret || !s->quota.esz || !c->ops.get_scheme_score)
+	if (!ret || !damos_quota_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
 
 	return c->ops.get_scheme_score(c, r, s) >= s->quota.min_score;
@@ -2057,7 +2074,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	}
 
 	if (c->ops.apply_scheme) {
-		if (quota->esz && quota->charged_sz + sz > quota->esz) {
+		if (damos_quota_set(quota) &&
+				quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
 					c->min_region_sz);
 			if (!sz)
@@ -2076,7 +2094,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		quota->charged_sz += sz;
-		if (quota->esz && quota->charged_sz >= quota->esz) {
+		if (damos_quota_set(quota) &&
+				quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
 		}
@@ -2104,7 +2123,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (quota->esz && quota->charged_sz >= quota->esz)
+		if (damos_quota_set(quota) && quota->charged_sz >= quota->esz)
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2389,7 +2408,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-		if (quota->esz && quota->charged_sz >= quota->esz)
+		if (damos_quota_set(quota) && quota->charged_sz >= quota->esz)
 			s->stat.qt_exceeds++;
 		quota->total_charged_sz += quota->charged_sz;
 		quota->charged_from = jiffies;
-- 
2.47.3
