Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342D32C924;
	Sat, 20 Jun 2026 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976184; cv=none; b=pRJZD1eOhnWLR73yv0rq6bihVnvJD04KsiyjPZ3uDiUyyrKFWTaZGR5mvzpemA/FsKo8roJNYZ+n8/v8wtwe+ISjHv6rztnyL2udzRFuyLLQ5Ilhw3HkNN4L6gm0RO1wS2tP0l78KrtzlFLL9guzChd1/lG1wWrvzv7UHqGqlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976184; c=relaxed/simple;
	bh=CuDlzn5CJNLWiVf6bZnHOgx/xkqsBcpUdP8tmFWbwoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdFp9CKTctiT0EIaTskssNSrS3w+NC4mFtjHvib1YsfgKQrzXNAexZbLzqORvca0LqeGqWrR4Nst8lgPhNrLukyHxfdM+KG8AAMRlpKqhjL7leJmkLyy+FHr+/mmLLISiKa/oG3enD6AnNTbpqdaI25+c+IC8BAJnuSticuump8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEV10JUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEV10JUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8277C1F00A3E;
	Sat, 20 Jun 2026 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976182;
	bh=rVGel8Xthk94BnCmBjFUhK6aLAO3CRB18f6Lt1KpdKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEV10JUy6FdPxIWX4PQwCvuclIdXPLxMB26RvQIZVL31yXPvflaDij92TmbrvHV3C
	 U+cjiaVIVw6HRs/J727yIKVAZhtnlILFR6V+1nSTsLM1iNm9UWIWhmUWDiCdasj1AJ
	 0lw5vVTMBusDbBm9aVaQF76ocThApg/zkmc7Ime0y8RwJnTqta5ch8+jroE9M6Tybk
	 GmfJ78/u9AW4MwMrooVBnX43VQuMq7UFWY6DicBaKJUOPdGI16u93S9ftfDZmSneNd
	 VCC4D5NsZ5j+fH1Mt+cD49meAEtWiVD2MwgMkCgeWOajrgWzmtvdPR1bdC0AwxG+QE
	 SwDbxC1DE9zTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 06/13] mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
Date: Sat, 20 Jun 2026 10:22:36 -0700
Message-ID: <20260620172244.90953-7-sj@kernel.org>
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
index 710ec13e98281..e144f0079322d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1994,19 +1994,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
@@ -2048,7 +2035,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			trace_damon_region_aggregated(ti, r,
 					damon_nr_regions(t), nr_probes);
-			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
-- 
2.47.3
