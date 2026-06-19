Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258C383C8D;
	Fri, 19 Jun 2026 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897677; cv=none; b=Bw7LxmypF0+VORdmRNe/8zfsFx8UlEsvamZ03yAoqE2OeFCuOOIyKcdbtjFQLQG+IjfF4PgIP7uVd0C7iOpwGUhfzSeTXlRA2VywTqO1qunsiOaiVAstaC0JwHTmiYlQ3aNGScUz5LG7h8c9zBBBSkZ0NxwWy63AO9csv6cdnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897677; c=relaxed/simple;
	bh=YQbiK5oFrL0PmZXpqXrxUx5dpnf6e2QoA3YU8rx/jWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBocAAjDFW0x8p0peJfpdqLYCEDpCo0nf0ad+7W32a75fYnc2hTUWjcxWXldOVFwxHDV16/qC1634J/Oper6NTy0bZWA35z8TBF0OeyHsLmYVB7pSbm7Yi/a8UNfgfTQVBDBK/CrSQPVpZDAHScDRg3SGGLXBXqM3V4X3rjiwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE8lS8lg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE8lS8lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC31F00A3D;
	Fri, 19 Jun 2026 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897676;
	bh=wn0Yt3L/+VcBwshPHSrlOXJyN82jOMXxHwXqkPJym7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VE8lS8lgX/m+9KZwGEHGAnntHpiikNKYNo4gGbwPDs63d7FaPaZv01ifWhFO42XxY
	 ze3ccSnuoW7FbmekSGApTNtMGHJrVpJaPyYniIUMNbrkVwTcdORlVa2sImaMMJOF8X
	 eSsthRjorUaacPPI1u7tFm7/5zK6tN9kJ9IT6niYOGg8CGr5NWT3zJVUTFQKiqWyff
	 NR7i9MDqvq5qW5+LS40IZalcOVS2A9GFbVUpBU8dcHDo1wL4SQ6GUdYr622GOt2/ti
	 NYabqEFTfGnvXjGhOr6Sm0sxus1SUYKu7i0IMDpds2fL1A2kFo1ik+K9uRltEk6gkW
	 j4x7BxGm+dFww==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/13] mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
Date: Fri, 19 Jun 2026 12:33:51 -0700
Message-ID: <20260619193415.73833-7-sj@kernel.org>
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
index 2eddf2674f4fa..12d09d2f7ea1e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1992,19 +1992,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
@@ -2046,7 +2033,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			trace_damon_region_aggregated(ti, r,
 					damon_nr_regions(t), nr_probes);
-			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
-- 
2.47.3
