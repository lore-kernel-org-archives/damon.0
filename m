Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229D32B127;
	Sat, 20 Jun 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976179; cv=none; b=VEZcy1OVumO6y0GVTND7YB0Kv65dTVT60waN21W7yZjYh6j3ZUDIYzDWXkPZkhwspslu8jpNaYV4w61nuKUwcCbIyoiNn/fLwS9g6I28UU3lUkSGVZXAjfrQDqkVvT+Gr3apwWzADjthwHDrbnOFKF21vXINf3ur0fnq1hp11mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976179; c=relaxed/simple;
	bh=90YUAQ0i8wuFZjslVsFGdFWXLBfEPgIUyW8yJ2f9+24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvUrljdD5spWlbSmGx/iaHgB3pJm8Ae3ww6MGams22LD4ePU8uA2+DktGaWk+sabLZiYBBxHzZdgbWfdt3Ud3fHx3UXRC4JEMmi5r4tAa2cTR3C0bVd87dz9/cA2J/witrmKC6tc3q7f6U1FfdVPU+T2shnNdspeE9jYwHD1ilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVNrz1gC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVNrz1gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0B51F00A3D;
	Sat, 20 Jun 2026 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976178;
	bh=zSgj5Q1lJXKb2smRSTNEFl3wFQBmUv230OpsOgctQ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVNrz1gCKXXiDVJKN+W3DUXEZyv0fRAutNmwo93fxkEWFqIXR1uEr/mpqkpuOKwq+
	 AE9Q9aTk21q+5iShcW5iiIiPNH75Iv6ZLWrmL8TsS3bNUWiQqOtupuwUgFJ4neZE4r
	 tz3XPCkXqkkvtRvhbYe+BPBxC7j9ucjI2gtTO1O42xCUAIb4nnc8aRvV90FBw5iGq9
	 S/bddDJQddqevyxg6VHK0fbxxugyW2HKJhHWE2p4Vk3YDrqJsnnfSiVFXhHyO+N8Wx
	 /qgoza4KlqFGKBkw4tSuBw93ZEgNjfrNC/5FeMXwiL65c6ECU1gusS5dzKQ+ThZnJD
	 +w9/V/LX37Nwg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/13] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Sat, 20 Jun 2026 10:22:33 -0700
Message-ID: <20260620172244.90953-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
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
index 687aa2ea1d013..ce0e2a4c1d523 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2120,10 +2120,11 @@ static noinline_for_stack void kdamond_tune_intervals(struct damon_ctx *c)
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
@@ -2149,7 +2150,7 @@ static bool damos_quota_is_set(struct damos_quota *quota)
 static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 		struct damos *s)
 {
-	bool ret = __damos_valid_target(r, s);
+	bool ret = __damos_valid_target(r, s, c);
 
 	if (!ret || !damos_quota_is_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
@@ -2735,7 +2736,7 @@ static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
 		damon_for_each_region(r, t) {
 			phys_addr_t addr, end_addr;
 
-			if (!__damos_valid_target(r, s))
+			if (!__damos_valid_target(r, s, c))
 				continue;
 
 			/* Convert from core address units to physical bytes */
@@ -3024,7 +3025,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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
