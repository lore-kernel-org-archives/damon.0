Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739C383C8D;
	Fri, 19 Jun 2026 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897673; cv=none; b=p/rTMWG3OHpaTthAvk9xcsdgFJETjf4dr/I/RBExvgFbGZlymcWQc6alR/BkOgNTrQpeH6Wp5/aPdcpUEtAVNA57Xuj1f0rKCPXHc1mTEK4PwkgkGYcT8p0Ysb9XByiMi6DDE90VAxWJ7OJOTZpv3h23fo/0hnyro1jabk1ioAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897673; c=relaxed/simple;
	bh=IKiZdh1AoETXGhdvtwp48om5bDgvA2SWr0xRUTlgORQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwnjq7xkXk0q2IDb9py7757BipNWG4QVy/cDf6NaAImvBQxzeVofnmbSDJPTfgQvb6Jx5E5ABYisS+tUY70+SEhLR6A/MjUbxD7EPOCzYmYBobqulloI6Ne5xOs1R9aVjntzKz5YAbsJmnntAenOVL7wklwOwN31NRyfufES3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2c3r13Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2c3r13Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E768C1F00A3D;
	Fri, 19 Jun 2026 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897672;
	bh=5x+9CpZ9d2FO068E6zHl4d9tkv4JzmSmiMeF2MwjyZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J2c3r13Zy1XW8Qda6rMF/lRYXRZ13GQFRZL6BlrWo6S7BUgystLOnkMtMCgiOH7p+
	 2B75iOiW0U6MfmSjfXawwSrOp+iSuFDHTWbmUx8nCBpdyKl8Zl3zekxPNndSFftylr
	 JmIJnlXuiGpaj9VFoPeYF3v7mAP8RjdLRSBkV7Qn5b2BzUeJKO8Gb0YCwr7Ul4s59l
	 XJ9iGLiZkEdvfWom0b0YF1iVQgEamb0w9xP+8Sgk7twsg6TVNWVbRTSfEp5cJkVucE
	 b/vGy1jvu/YDbhsmWuq0YhUrOQOVebpiaTvbMumq7JHcgKWViZ0H3XxEHs2W+xxA4Q
	 aaNXnhYqSIT4A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/13] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Fri, 19 Jun 2026 12:33:48 -0700
Message-ID: <20260619193415.73833-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_mvsum() returns a value same to nr_accesses_bp.  Also
the function is more simple and therefore more tolerant to errors.
Execution of the function would be more expensive than the simple read
of the field, but because the function is quite simple, the overhead
should be negligible.  Use it in __damos_valid_target() instead of the
nr_accesses_bp.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index afb00f9bf7856..3a6df10ba8548 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2118,10 +2118,11 @@ static noinline_for_stack void kdamond_tune_intervals(struct damon_ctx *c)
 	damon_set_attrs(c, &new_attrs);
 }
 
-static bool __damos_valid_target(struct damon_region *r, struct damos *s)
+static bool __damos_valid_target(struct damon_region *r, struct damos *s,
+		struct damon_ctx *c)
 {
 	unsigned long sz;
-	unsigned int nr_accesses = r->nr_accesses_bp / 10000;
+	unsigned int nr_accesses = damon_nr_accesses_mvsum(r, c);
 
 	sz = damon_sz_region(r);
 	return s->pattern.min_sz_region <= sz &&
@@ -2147,7 +2148,7 @@ static bool damos_quota_is_set(struct damos_quota *quota)
 static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 		struct damos *s)
 {
-	bool ret = __damos_valid_target(r, s);
+	bool ret = __damos_valid_target(r, s, c);
 
 	if (!ret || !damos_quota_is_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
@@ -2733,7 +2734,7 @@ static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
 		damon_for_each_region(r, t) {
 			phys_addr_t addr, end_addr;
 
-			if (!__damos_valid_target(r, s))
+			if (!__damos_valid_target(r, s, c))
 				continue;
 
 			/* Convert from core address units to physical bytes */
@@ -3022,7 +3023,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			(DAMOS_MAX_SCORE + 1));
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t) {
-			if (!__damos_valid_target(r, s))
+			if (!__damos_valid_target(r, s, c))
 				continue;
 			if (damos_core_filter_out(c, t, r, s))
 				continue;
-- 
2.47.3
