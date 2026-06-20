Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A724677B;
	Sat, 20 Jun 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976189; cv=none; b=A5ZPIUzWDIe+6+osqv6RmMww6VFRSf7K4MmydSr38tpVMLjfHoZiwqsbP5ZWSn/quRRDEi80y/Ut2W5imfyK8xE1sB0qWzYRySrtqEozH3Ux70vlDpZsoD+d5DN87H80hVpfNMdhysi+5XoZsy/d25vLrQMyNEV53Dcy2YN861A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976189; c=relaxed/simple;
	bh=zORuLPHhWwztqzOn4OQADATmgwaYlArsjvad0SpTv7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js2t4aZns6+a+X7g7+WvRVAGKqqLF9OwY78zr4aJC2G3NRMX4PWo9xnyqPysLG/qbQI6o7YjS9/OmJpGs6UdDKFvM6Nb+F2jP4+JsEndQKmNh7zb8nrFTBx90hKWTxnOHqusMxCSweucefd+//5oR9QAK751qdVrfqjeqV/FGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6wxCoYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6wxCoYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AD51F000E9;
	Sat, 20 Jun 2026 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976183;
	bh=Sujpg8EOXMvmjbaw+/ZJc10siqtH9D9cGIEwTN+7yDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6wxCoYXeaugNmXmBmuLBnsrFXDfDWeLHmywRaLuM/D+sPKdlx1OnYMKJK6onA9CB
	 c/GLyeh9IY4Cb+7HAHScmLVUaL2B2Sakh0mplCyc9+7Jd0vH0LNhTjUGAoR0bZ5bLl
	 Tt4vg58ZhTJ5eWgyf95uE15nomiYgUXbqyLpIuRDjd3GvZ87PERXCAyMr3P0sOisSo
	 KtNQIyKiBAwMP55iyCSF00unQTjsXrTCERVHaECOXZyfWnCd8WEopSYduMsECmtsSm
	 d5y6/jLKD+oWtpwOkXuauFlcsfY/m0qjNNmxmGAlzKx6mkuxh8P5OXzSXqJEkwqvsf
	 C+WCS7lXwYyPQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/13] mm/damon/core: remove damon_verify_reset_aggregated()
Date: Sat, 20 Jun 2026 10:22:37 -0700
Message-ID: <20260620172244.90953-8-sj@kernel.org>
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

nr_accesse_bp is no longer being used in real use cases.  Remove its
validation function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e144f0079322d..84d21d21ed6c9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1994,23 +1994,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
-#ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-	WARN_ONCE(r->nr_accesses_bp != r->last_nr_accesses * 10000,
-			"nr_accesses_bp %u last_nr_accesses %u sis %lu %lu\n",
-			r->nr_accesses_bp, r->last_nr_accesses,
-			c->passed_sample_intervals, c->next_aggregation_sis);
-}
-#else
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-}
-#endif
-
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -2039,7 +2022,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
 				r->probe_hits[i] = 0;
-			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
