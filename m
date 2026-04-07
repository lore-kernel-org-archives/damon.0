Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE22E65D;
	Tue,  7 Apr 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523940; cv=none; b=h93c0i7sPk96gOYeMeE7hGK4cFRRrnBzeCy4EuVOiXx6dqqpRPoBuDfMF7NE2v/BLhlneAVw7NOxkX764kXAfuQU5/m32rRkJKJCnesz5Osou+BuMqQgSxjzHNyzjz8ytlMApffPRkenPAFH+4a6TMek08bYyrKvFfrIoF/ECLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523940; c=relaxed/simple;
	bh=zHTyjXw4y+b0yGyHvR7VlEA/Pe9whFzT7niQ8ge5IZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMLJPAXuWAGkvEFYwVyPOx5LpI8FRUbX/whDknB/2IbJG5HTBxvJE9yXfHWey8wxSCNGIRNEaVTSR4c902c46KctnVTC6/C+zfx/o7pnOg7LpaL9VftSVw2Tey2raz8ZtBbYESI7T2Mi6+V3KVeZA84VQbudNpGHuIlJQycUYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7yb0Cqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7yb0Cqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8ABC2BCAF;
	Tue,  7 Apr 2026 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523940;
	bh=zHTyjXw4y+b0yGyHvR7VlEA/Pe9whFzT7niQ8ge5IZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7yb0CqhTUvm6fdsVbjosf2laMLDVXZ+GXF3roEyy1atQDLruOFhgwXoQcIQYG4iU
	 u1w7FyOk/11obccmkI5MuHXUGxgSgkYudXogh/r0U1okDZdkeQ34d+mrllztFyk7K+
	 mwCNvPQ++cc48LkWawrLW+/TDC7sEgufZMnsYM2ZzMR73aIeLjXUC+2P5Vey6/PN3N
	 YudrR6buqFOU3mtlekY10Il+GOyO0A//fA7QuMsGEbs97/s0nk9jqb4kvYJqom/UGD
	 1TnodkhJrmZjaoyLoczFwmWqouHV06DtzEfX+N9e/vyPdsfEsxuBmpuQNnre1aNJ+h
	 AHW5A/rzIUIeg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 01/10] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Mon,  6 Apr 2026 18:05:23 -0700
Message-ID: <20260407010536.83603-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-1-sj@kernel.org>
References: <20260407010536.83603-1-sj@kernel.org>
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
 mm/damon/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e680716972506..2a2f767d1a46e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2042,6 +2042,14 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->walk_control_lock);
 }
 
+static bool damos_quota_is_full(struct damos_quota *quota,
+		unsigned long min_region_sz)
+{
+	if (!damos_quota_is_set(quota))
+		return false;
+	return quota->charged_sz + min_region_sz > quota->esz;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -2099,8 +2107,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		quota->charged_sz += sz;
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz) {
+		if (damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
 		}
@@ -2128,8 +2135,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz)
+		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2455,8 +2461,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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
