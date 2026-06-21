Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F39443;
	Sun, 21 Jun 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057454; cv=none; b=NjlIJWTgtPqo8tJx2sI+ULIc5KUwlmKczAf86n5ttTBE77MhP8BJPpNYy2F6Jr1tPG0OaR1O3zVfju24C9C3iTDTB1gD3MRyudYQSrfgNXJyYZKrxyA8m4goSDAQb2NFBXda0bsthWf4ukn39t9rXEPStHvuuWwJVjytINFLD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057454; c=relaxed/simple;
	bh=3NjNWJxfgyJB2dOKmiQIbYz3fgr/Wy3JOgLkGb1hHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFAbFaughHkYl+3nSVcYiNrhxijAMgmBWXxHtg7G85e7KOrdsdAjhW2afYAYwfGWRgKHtEI/ds+tebleYw8BThIUhtf4khcXGD8IeoVY49SF0bfSAQ/H5wlJcVjje6Ox5NS701n0O2FqArHW0e1c7nB8serZBYlaxW6wEdW+jyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKWiK91Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKWiK91Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BABF1F000E9;
	Sun, 21 Jun 2026 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057453;
	bh=/R/pq+g2xJuXFKABLKe9iXG6iO9DKEbOOAgRIn0eX/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKWiK91QfC7/8cLbBlQbo4JQLVIxl7WbduoJ9nVsRJ/y89pm5BNzTeHKj/f7MClzl
	 HepNdwgwaBiY0QTABhqTd9+vP1TBeRDS08hYbu3mUPwLrnOovXbsSGX7wDRNhIOZSF
	 wJ9mHEobp1fa9feiC4L7yfnJostMEkp3hxI0RfNkV9SQdCsF/yHDgCa0TFAbPEJL2L
	 zcgB7W4zfPaS6TMh3++YeTLNfqLYzdxm+fegcMSydqpVLrNfOPoEc1kEGamZmk541x
	 5tWfWzUKCc0jE+jvVgUUvwTgEbJQudvdQcreyaELtGLK0KL50lxKoTbxVfkXoFR0r0
	 sPocYqpuH85rg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 07/17] mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
Date: Sun, 21 Jun 2026 08:57:03 -0700
Message-ID: <20260621155715.87932-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_accesses_bp is delicate.  Once it is corrupted, the consequence is
the bad madness of DAMON monitoring results.  From developments of
features of size, we historically found nr_accesses_bp can be corrupted
by complicated bugs that are not easy to debug.  Hence we added a
function for finding the corruption and fixing it right away.

There are no more uses of nr_accesses_bp.  Hence the function for
corruption detection and fix is no more needed.  Rip it out.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91f137901e726..1a10eb0694aca 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1999,19 +1999,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
-/*
- * Warn and fix corrupted ->nr_accesses[_bp] for investigations and preventing
- * the problem being propagated.
- */
-static void damon_warn_fix_nr_accesses_corruption(struct damon_region *r)
-{
-	if (r->nr_accesses_bp == r->nr_accesses * 10000)
-		return;
-	WARN_ONCE(true, "invalid nr_accesses_bp at reset: %u %u\n",
-			r->nr_accesses_bp, r->nr_accesses);
-	r->nr_accesses_bp = r->nr_accesses * 10000;
-}
-
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_reset_aggregated(struct damon_region *r,
 		struct damon_ctx *c)
@@ -2053,7 +2040,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			trace_damon_region_aggregated(ti, r,
 					damon_nr_regions(t), nr_probes);
-			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
-- 
2.47.3
