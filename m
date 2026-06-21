Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDD23507B;
	Sun, 21 Jun 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057456; cv=none; b=Be53tMyCKZwriR1hxCZcvI+zklIYYXAg+ecjvVYFUdAi/QtoKJkdjcY5HKCLNRxJE0q8l/YGPPdr4HK76zim0hjpluQCytgWxx45k9c5Z8tuaIkQC+APdImQOVl2QWOST5ro5IwU3iNm0GJCOZduWJzDViMCbTVSnLYtrDyDh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057456; c=relaxed/simple;
	bh=1xloznShsPaRhrvASD16OJM7AzsURaUokYBiDt13F2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2fHVd3CrNRlXcEwMaEAofAqQu882GTNwVDDVvQ9Vy4HpNrUukE5i8ARmBvEfGZlZOTvzu4YaBGECzLdnVvvS6AN7JbtoRWlurExccysDULmECXTD5v11ZLyKPn1C38q7FDyLUEBbe3kmF11mP7iuI8z9/BfHNYfhgYGSrG/RRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW2GoLyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW2GoLyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E81F00A3A;
	Sun, 21 Jun 2026 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057454;
	bh=R/pl2bi5tI7QFS3HurXX2t06T9A2H6ZIRc1GLfHuo8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cW2GoLyIwZhzSxBjM55UKe8LNQBbiM6mjjKGIS5BgZbuLVKbyAhzyKvs2HebegsTZ
	 Ch8xWIjjJl+BQI4gqQEV1ENiC5Deq//NlPLugx8jIQn69gZBcWfiHqxPfOnYecDD/N
	 AqE7R5btOOxRZ30u2z8Lg7obzt1s1AN0IY+jmKtf+Kz8EC97Ppz+739WVDYAfjjk/w
	 OKN2rUVkoH/A98Qfv72+EW4RJd+Z8j7GzP4U/vbIAS19dq0Zlb3yA/Ds5p3S7uOmB9
	 ZDJZKcDwY4y3sxzg7dNPeqS/d147Y6d0lsN6Z1l5V4NNo9Fph56avb4lWlY22pp1cA
	 L2ziKBy+93NTg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 08/17] mm/damon/core: remove damon_verify_reset_aggregated()
Date: Sun, 21 Jun 2026 08:57:04 -0700
Message-ID: <20260621155715.87932-9-sj@kernel.org>
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

nr_accesse_bp is no longer being used in real use cases.  Remove its
validation function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1a10eb0694aca..7bb9b3c32d6fc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1999,23 +1999,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
@@ -2044,7 +2027,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
 				r->probe_hits[i] = 0;
-			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
