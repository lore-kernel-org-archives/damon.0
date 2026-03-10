Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7793093DF;
	Tue, 10 Mar 2026 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104739; cv=none; b=MDgYiY95nbjBYAH4YBKXHLykJomhzizyxZlS03A7UhPuU/QXC4UJYBhRlxHy7FoiqhAJnc+I+xMAALsPg1Kl9jmF0q0uK8Z9KkgADyluARlC1KUWTQQbwAT0sJ7Pcj9kyOF7S0D+M+gxnpxz9DAPGW8eG/eCERb5OcXJNQpPfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104739; c=relaxed/simple;
	bh=L8f/ifxCU2NPf0V1A0Et6pf5vfY3OtYSlSoZEdh8jTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCg8wZpHgHegaxs1kuVzxvvRy19yyUbwaKTh2gYsk3lv4x7ZBEvs1quwtaSV8QBMKE/MN7D666dcps+g86+3fQISSwHkaw6NBvQPcBwP5KSI/OaDgr+1PHZcsIEABoz5DU7BYekW+q9ErmItX8qj5NWPUWXp0AViyIOkI6mDkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwHQBb75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwHQBb75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C506C2BCAF;
	Tue, 10 Mar 2026 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104739;
	bh=L8f/ifxCU2NPf0V1A0Et6pf5vfY3OtYSlSoZEdh8jTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwHQBb75BCYx3628Zxc7T+Zu7KR5tq2xk1nZTwDdDxBbqgbplC7OkjNBj7MMlW7ZM
	 LB1wwsCjxl/y9HM4kkxf6lHsvgWZBKZbKk7q0H7y0a8R7qDqGhR7Rgmgongi6RxHAW
	 hbFIeMezZBsnj/i/tponGizAAugNueUtKN/8Oeg7YpJji5Fd2wDDclB/Jq/Q7g/Nb0
	 xMPcV2kruZHaqsrTijWC6Oob73912ZbNlLS9HOn5mzhrlq8lAsSD8AwXUPFrnDrZrP
	 ad0wz24W24FIfBZ/U52FUnSigozYkRza7zPOXaDrOQ8T5/4YE11Q3BRfBDetveZKKb
	 SOpTYoAY+OZjQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] mm/damon/core: allow quota goals set zero effective size quota
Date: Mon,  9 Mar 2026 18:05:18 -0700
Message-ID: <20260310010529.91162-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
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
 mm/damon/core.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c16a390152790..d351ef3bcf4e9 100644
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
@@ -1789,12 +1794,24 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 		r->age <= s->pattern.max_age_region;
 }
 
+/*
+ * damos_quota_is_set() - Return if the given quota is actually set.
+ * @quota:	The quota to check.
+ *
+ * Returns true if the quota is set, false otherwise.
+ */
+static bool damos_quota_is_set(struct damos_quota *quota)
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
+	if (!ret || !damos_quota_is_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
 
 	return c->ops.get_scheme_score(c, r, s) >= s->quota.min_score;
@@ -2064,7 +2081,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	}
 
 	if (c->ops.apply_scheme) {
-		if (quota->esz && quota->charged_sz + sz > quota->esz) {
+		if (damos_quota_is_set(quota) &&
+				quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
 					c->min_region_sz);
 			if (!sz)
@@ -2083,7 +2101,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		quota->charged_sz += sz;
-		if (quota->esz && quota->charged_sz >= quota->esz) {
+		if (damos_quota_is_set(quota) &&
+				quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
 		}
@@ -2111,7 +2130,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (quota->esz && quota->charged_sz >= quota->esz)
+		if (damos_quota_is_set(quota) &&
+				quota->charged_sz >= quota->esz)
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2396,7 +2416,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-		if (quota->esz && quota->charged_sz >= quota->esz)
+		if (damos_quota_is_set(quota) &&
+				quota->charged_sz >= quota->esz)
 			s->stat.qt_exceeds++;
 		quota->total_charged_sz += quota->charged_sz;
 		quota->charged_from = jiffies;
-- 
2.47.3
