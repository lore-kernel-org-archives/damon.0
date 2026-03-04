Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584422EAB61;
	Wed,  4 Mar 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635902; cv=none; b=duwd5byU8Dbk3bJvQDuAiUsNz9pD9XUIwvhFdg4jVAIBk7ESQ55yTL4dUY9Jv3HObL2WThnA5pJswuREmS2oiRh8zAQwDLQLvno+e70uomiZG30UKTVArWsJz+ipHGo65NviE7GWy5TFFWKbwhfg11zPnNZksfUA8aK0pNF2pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635902; c=relaxed/simple;
	bh=AXcGOV3rxB0t3xLwBtUstDgx4cx8kG184IK+T6OhDic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My5Lws1Rz6jMDwnnIR8MMouvqwqn4v17frjKqGYuL33EIa+4NMCCY93WdAN71PLeIkmLnk0/g+E9z1INj+32juZWdHDT1zsR/uR0L52GsieTM6JfNEY5e5/lYZN7p7pVuLUxKnZNipB0J+4qrEouIesETniAlBxd8P+lO/pVmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcvONXz6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcvONXz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE61FC19423;
	Wed,  4 Mar 2026 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772635902;
	bh=AXcGOV3rxB0t3xLwBtUstDgx4cx8kG184IK+T6OhDic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AcvONXz6T5whljb9Qjj+WgDoNq1cZjnLZS2qowLy0d71QtwIsMlIkiqZUzllY+Ql2
	 e3/shG0jjz6LnHB1A4NskTc5n7opsjWQEi3x5U1LStETOPymKX4Mx+OzR9njBKuqPA
	 cEQQkOtvo7YkFK8cIZdGN1wfWIOKVGSq8X5sgVLUqekkQHKLCiIQFg0yZEsOLYbekZ
	 IiGVDf/lsTPCFKbWI+lFm6+Vw0YgkpBNuBlrOKEscdr6XHH9wqF9tNeEyGUYIPgBra
	 Ow4r7YNnAewNV1aYTd7WBIthl0oRMjzsqPLNcPM8dPcaKiqSc+uIdHwxDyRDfMtuEu
	 9RDdAGyWBBhHA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 02/10] mm/damon/core: allow quota goals set zero effective size quota
Date: Wed,  4 Mar 2026 06:51:39 -0800
Message-ID: <20260304145140.172293-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <abdb1acc-5f88-483f-af49-45276ab66ff0@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Mar 2026 13:18:16 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 3/4/2026 7:41 AM, SeongJae Park wrote:
> 
> I find the name of this function confusing. The function doesn't
> actually set anything. Maybe better damos_quota_is_set()
> > +/*
> > + * damos_quota_set() - Return if the given quota is actually set.
> > + * @quota:	The quota to check.
> > + *
> > + * Returns true if the quota is set, false otherwise.
> > + */
> > +static bool damos_quota_set(struct damos_quota *quota)
> > +{
> > +	return quota->esz || quota->sz || quota->ms ||
> > +		!damos_quota_goals_empty(quota);
> > +}
> > +

Thank you for the nice suggestion, I agree your points and like the suggested
name!

Andrew, if you pick this patch to mm-new for more reviews, could you please add
below attaching fixup together?


Thanks,
SJ

[...]
=== >8 ===
From 9599524cc5e5bbe8263c847b6f20f0aa919b3853 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 4 Mar 2026 06:46:55 -0800
Subject: [PATCH] mm/damon/core: rename damos_quota_set() to
 damos_quota_is_set()

damos_quota_set() can be confused as a sort of setter function.  Rename.

Suggested-by: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d657b87dd99e8..c58430a4cd6ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1788,12 +1788,12 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 }
 
 /*
- * damos_quota_set() - Return if the given quota is actually set.
+ * damos_quota_is_set() - Return if the given quota is actually set.
  * @quota:	The quota to check.
  *
  * Returns true if the quota is set, false otherwise.
  */
-static bool damos_quota_set(struct damos_quota *quota)
+static bool damos_quota_is_set(struct damos_quota *quota)
 {
 	return quota->esz || quota->sz || quota->ms ||
 		!damos_quota_goals_empty(quota);
@@ -1804,7 +1804,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 {
 	bool ret = __damos_valid_target(r, s);
 
-	if (!ret || !damos_quota_set(&s->quota) || !c->ops.get_scheme_score)
+	if (!ret || !damos_quota_is_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
 
 	return c->ops.get_scheme_score(c, r, s) >= s->quota.min_score;
@@ -2074,7 +2074,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	}
 
 	if (c->ops.apply_scheme) {
-		if (damos_quota_set(quota) &&
+		if (damos_quota_is_set(quota) &&
 				quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
 					c->min_region_sz);
@@ -2094,7 +2094,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		quota->charged_sz += sz;
-		if (damos_quota_set(quota) &&
+		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
@@ -2123,7 +2123,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (damos_quota_set(quota) && quota->charged_sz >= quota->esz)
+		if (damos_quota_is_set(quota) &&
+				quota->charged_sz >= quota->esz)
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2408,7 +2409,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-		if (damos_quota_set(quota) && quota->charged_sz >= quota->esz)
+		if (damos_quota_is_set(quota) &&
+				quota->charged_sz >= quota->esz)
 			s->stat.qt_exceeds++;
 		quota->total_charged_sz += quota->charged_sz;
 		quota->charged_from = jiffies;
-- 
2.47.3

