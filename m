Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340993D9DCA;
	Thu,  9 Apr 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744518; cv=none; b=jlGCFyrM8pcdsLDeMDNw9LyXyPgdt4XnNazJsdWnY2Ry+ONE3UeZVJJbbNBTL2xEIiaLDLO7UJpZ5q3sl7VjmsEmZXI9DGYhtqIwb8/zeI/sDG+I+AGOKS96PbQ4Th6W1nS1IrVsZ/Nosr5Ye7y/IZ/YQhLkLIL6UkGH7c/6yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744518; c=relaxed/simple;
	bh=npLjo+Ub0jfADcpNQiStOidPGi9YtKWTfRmpcD4bUVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8s9JB1VmOdvm2xflLD7qufMMm6KMCxsePhy1Wv3IPGUq+DFlFuBzedycFH80I4mnyAAPK4fT3ukj1hVuZLDo/qkLITZkQ1bU9eOMhcmNdu627t/OimaDYzApNnZF8O5Vaezek/YXWVWdm1FfgFHw5RHvapk6BtN/UKf4SynoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIxUwKtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIxUwKtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91169C4AF0F;
	Thu,  9 Apr 2026 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744517;
	bh=npLjo+Ub0jfADcpNQiStOidPGi9YtKWTfRmpcD4bUVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIxUwKtOwG4ywbtgEW36oE5+pKMqXVhMcTVuPecSkbxd8ZbD7B6cdkpasYgCYWr9T
	 Ajx3KI+UCIrQIt2IOcu7Bg26hsRAwa44rVpX4OXAjAfQxv0VVqGnz/uOV83o5WONKw
	 oXMIOUB4i7PLiKIlWvIUoSk5vCqBzgr/PCF8qvhT8lhnF5zEuIHn+4fSARhUqhAEfq
	 pJ0rbqdLqGBlE2v32cN0nq3eR62f//CyVOVt98XHsnqv+/X4SEWh3dpxNKTvHcrpBs
	 Lsf7/ctPOZw1v7B9ucRqDo52tH0uVqdNhU4wv7SAqQ3XNv82edAFdglsRGevaNFR3x
	 wUDmpWKt/OWPg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Thu,  9 Apr 2026 07:21:36 -0700
Message-ID: <20260409142148.60652-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-1-sj@kernel.org>
References: <20260409142148.60652-1-sj@kernel.org>
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
index e680716972506..c7d05d2385fe8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2042,6 +2042,20 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
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
@@ -2099,8 +2113,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		quota->charged_sz += sz;
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz) {
+		if (damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
 		}
@@ -2128,8 +2141,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz)
+		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2455,8 +2467,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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
