Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DD3CEB94;
	Fri, 10 Apr 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830845; cv=none; b=ukovvVuA53bKmG2x+D3o+xNg+5rh2JqU7qGafZEa1juUHqd5vL8/2h4RYuMCymO9AGvuO9noTs6VcFguvOGxhCUWv9iXl/m6MoQGH7L7P18uPwCRKyEdiOwXNYFoIwSK/D0pGzET0DVFvLg3S0r4EbXkKTbDtckG7et7XkNg7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830845; c=relaxed/simple;
	bh=npLjo+Ub0jfADcpNQiStOidPGi9YtKWTfRmpcD4bUVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvsSxZvq2A0pGp9a5xc0b8cUnl12Cq81ZWRGKp0JVeBERxQTT/DbTSegEFNyHj8kBbbmqNi+JDVnvxpG+T5ZDeR8ihfBEVVMWJ6+kC8jKp01C5Z5805toKyDvCPG5xdTFyESJy8sUfht4q8kS/PuAd/Wv9yvEWxxfNOUz9grnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDrBY6lO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDrBY6lO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1137C2BCB0;
	Fri, 10 Apr 2026 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830844;
	bh=npLjo+Ub0jfADcpNQiStOidPGi9YtKWTfRmpcD4bUVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDrBY6lOoLv0eknGY/5lH/M+dAhl5dR7PLZ9iP3lwd7QKN1UqPn/aKWLblnDSRCUr
	 QQvNk3xVRS78algihfZ0I7CwtG5xL2DsT3fshLJNdqaoW+ynBJJx8ZlvNOuyPmCAuT
	 tVcCD8RqfDPBaXpkCcljnK/8UrAxVfVRHWCOYK1YatS+pB+OQKqQTIUJLaG0aYG2mK
	 h6QRGDGQJyPTG1y7Muo+uItkLOtqILvTl04kxAFBhIHj25QOXQGHN3blBOsG2OGQg0
	 9mTxZwrlzlxtseYUR0R4DsAecbVuBdd0If+utR5vVuG30BLKVb/hAl0n2LSHZB5n7H
	 Y8glsMn4WEDEQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Fri, 10 Apr 2026 07:20:22 -0700
Message-ID: <20260410142034.83798-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-1-sj@kernel.org>
References: <20260410142034.83798-1-sj@kernel.org>
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
