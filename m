Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8163DB97A;
	Tue, 30 Jun 2026 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792506; cv=none; b=ultP3OZkuC7hY7l8zgsSorKCNf2WWJqClQu5wPZ7nxrr3vzM1EVZzcPUwMYshfcgHG4qkrz2Xh5XdbKt9rz4ffwrVCm94Vn1nyGhJJ9byQC9+tTuBx1kA1X5RxW9MtyXQdhHwaKCWP6rZlDAiyL+CrVARBTNbgK9eOBKZ4ISjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792506; c=relaxed/simple;
	bh=sT2ithQbDRjWkl3Wlkt2tf063U6GOJHK3PwWwtkMA+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ2LJPyeglZSYhBs26l3c62/9e60CAq/Jj0wwP7DMmtSNWJR+iNAO9J1DI17uCnOvVzDx7PoYqfPtdItf8w6wia9wPI2OJY86CMpQQhmdhcuXF7wXSq9Wr57y17voE6gv8FfDJ3kNSoq+eXRy9O7HfvO8SFnNyH6+vvDTTVmwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn96ilo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn96ilo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8791F000E9;
	Tue, 30 Jun 2026 04:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792505;
	bh=1Ke0BSVs6s8s77whU08OQcfHx1Y/NV39ljz5Tc9+fVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bn96ilo7xCkVl4QWUbwCr4S+UCNx6NUT5nOwaauTVtWzh2Fg8izzYvLrkSS5Ewf1Y
	 PtqepMWWVoxyt4L1VZChljBgfMwJDzyCG37uwCzZxrZC7kjTsD9JpQYxGsMemFTzy0
	 vIVCXBu1ThspUf0mOfug04432v2/wyXpSNi+o5AqhfINQAGmipbk8OSeSNSTGJYrwE
	 zM7X4n3hAN1Fh71grKWNi0MIwechL8fd5bKDsv+ERzR09JJtHgpH9kDCJ0XppTxmbP
	 vzwEK2mw8Gtg5gsiz7L5NE9XWD/U+DyMqgKhih/gDV6HOMYJiKPi9FyjqEdtG8FGRJ
	 UBUIBhsik7Eqw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/18] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Mon, 29 Jun 2026 21:07:58 -0700
Message-ID: <20260630040812.149729-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 70cbc382bec04..612762490e866 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2132,10 +2132,11 @@ static noinline_for_stack void kdamond_tune_intervals(struct damon_ctx *c)
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
@@ -2161,7 +2162,7 @@ static bool damos_quota_is_set(struct damos_quota *quota)
 static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 		struct damos *s)
 {
-	bool ret = __damos_valid_target(r, s);
+	bool ret = __damos_valid_target(r, s, c);
 
 	if (!ret || !damos_quota_is_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
@@ -2747,7 +2748,7 @@ static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
 		damon_for_each_region(r, t) {
 			phys_addr_t addr, end_addr;
 
-			if (!__damos_valid_target(r, s))
+			if (!__damos_valid_target(r, s, c))
 				continue;
 
 			/* Convert from core address units to physical bytes */
@@ -3036,7 +3037,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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
