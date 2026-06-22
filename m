Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F43BB66E;
	Mon, 22 Jun 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138114; cv=none; b=pohspEIfSoJunS9TuenlyjUkJfvmff9d+C3M9LqXmGzOVzRGyl17qcBbdbNZriquWoIl+3DprJT8LXgyv+HWIkF9kTKM1ZSF+vweG6eH7dG1rg4BOP3uJH/W2kvQEJDFDZtZfW5yeSvLlfdoc1Xv5DuDLbLh/wcyTuC8cSv4IeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138114; c=relaxed/simple;
	bh=eFuTHjwSJSEE6nOYL5cu1XT5ns3W04UxlySQ6XJwEL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8/Dmac1zG4qytGnyRlSoAmyGDsXE+Aujke3KXOkzeu7roB4KrJEONQWSaOhpEr3DikYwVJSk3SHyaCAYK8FGsSf4sIYNMzfRqkPjtkJVHKoDVPNela0A0+p3868KtYspLoft1c3yLn2pCQuL29alDJnmoOSLLpNiAjU32c8vSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB57kba0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB57kba0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209351F00A3A;
	Mon, 22 Jun 2026 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138113;
	bh=Lm5wAGpq0Z6XqmRl7W0q3ZWgQYc9A8QPdxb8BfmfLMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jB57kba0tQlnTJ+K7ehKkjFZIsdwynDN/cquhdjTv5jVlaGZv9U2NAOLXJboLhoGh
	 jt2kjttE7McYNWnmbXurNuOFJEG1xP/sFf5QP6PPxrcXG/iLgRGmw4c3dIGqGHcejW
	 vW6qZtdUrlsn/Pt+DZNRWYHHb6K2AkcOksjj2ycG7hkOuI0bRWj3VRfUe+jnLP2p0l
	 prFhfvbxx91IAIcra+5oj6g8Ai/pwWCmkleXZnbu6MgRuMXNbki4lR67q5xvoqK6la
	 oDQ5SXPxTTGTKqMxGMCCnHOH08UUCHrj65HXejbXTZk7pVNYLUS+lEdaGUb84qvyu3
	 79FNoJsBVY4nQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 05/18] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Mon, 22 Jun 2026 07:21:25 -0700
Message-ID: <20260622142139.30269-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
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
index 9d501ad34f44c..d6cc538172b40 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2128,10 +2128,11 @@ static noinline_for_stack void kdamond_tune_intervals(struct damon_ctx *c)
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
@@ -2157,7 +2158,7 @@ static bool damos_quota_is_set(struct damos_quota *quota)
 static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 		struct damos *s)
 {
-	bool ret = __damos_valid_target(r, s);
+	bool ret = __damos_valid_target(r, s, c);
 
 	if (!ret || !damos_quota_is_set(&s->quota) || !c->ops.get_scheme_score)
 		return ret;
@@ -2743,7 +2744,7 @@ static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
 		damon_for_each_region(r, t) {
 			phys_addr_t addr, end_addr;
 
-			if (!__damos_valid_target(r, s))
+			if (!__damos_valid_target(r, s, c))
 				continue;
 
 			/* Convert from core address units to physical bytes */
@@ -3032,7 +3033,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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
