Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5283BA253;
	Mon, 22 Jun 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138118; cv=none; b=orz5iLuSdBHReAd6HWD0tjI7nhANq8dTjzrmzVxjcvdCe479QABSMyOUTaDPWkdl5BHujjzBP7NXKG0HssHRPmftGgZzFalsnezjuRqh+IPs80Eg6om+pVSdi0qwGyNNk8OhU/CdRCEBcWK6igrDBwFOnq+XPrb/n1BeW3VgcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138118; c=relaxed/simple;
	bh=xxUgHn44WgEd69gBcy1v6BaG0Vdi2KTsEO+IwiP8CLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNWcfWhPAsDQZjav6ttnrpqRRks6RxpMYWtUlwIv8kYi7+Bkp4YrsY/7FhQyN0EMHE0DApNbfiqGWL3JF9B/iaRD2D1XFSkEcKyPpfg8eI0VtVc738UtXWvFs2WIJuTZ7dxfdk1RGROH6DPXZsBGMo8FY8SGF3NEIoATZFW6Xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbt2lS6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbt2lS6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD761F00A3A;
	Mon, 22 Jun 2026 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138117;
	bh=ZCOZ8dxBwUoJ8M+fjsYn5byv+H4mkkcZsSGYh1TwNIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kbt2lS6DaQx9xowI/srvebEIIIeOqimNIqI/OXXQ7p6DXJMjnW6XW/UklKpRdtT+n
	 rISLP286YjPrG003sz3y7V4uuaVElUSbebCJLkb46iojWpPyckJ7YC5o+0VhyaY4DZ
	 h8B5Yh5Yk6TX2hfUIrO7RLlZ0U98pczrZrfAYS1XOmuSA0WL2I3Gw5Gs117JzCcZcR
	 kH7Fyhm5VyH3KrrAF+aGcLEdWpkWs1ucLPB+Ti106cRVhlyH5qwE7fjnJLPgGwgwAR
	 s6Qc6ERWLzkrNl+H5zTd6sYTb08u91RN15X8j/uK4d2GLXho1lTnLkFcuWt5uB9tPd
	 zM0Rqp/KCwtZQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 08/18] mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
Date: Mon, 22 Jun 2026 07:21:28 -0700
Message-ID: <20260622142139.30269-9-sj@kernel.org>
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
index ca68c4835c391..89ac5552085a8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2002,19 +2002,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
@@ -2056,7 +2043,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			trace_damon_region_aggregated(ti, r,
 					damon_nr_regions(t), nr_probes);
-			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
-- 
2.47.3
