Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464F48095F;
	Fri, 22 May 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464439; cv=none; b=sZY6D9KB7D/clQ8ZBK5qTzZ2K+yI9aOOnitp/rXX3dT/YJZPgLyZ8oJqgQJ/+gNJwMU9WvMAyEbxaS4a//B1q6K9S+q6zyJTEiihTYTeV/+kSXIBn7azWPI8p5D9SrAUQa7wMUMsDAXboVUbxyACLywNzboYytxNHf4N7cnW0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464439; c=relaxed/simple;
	bh=60hNbVqTSP21yPGuac3bHL+OYhfMoIX08QASyu0GIRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7DNMCFPGjY7FmLYJZc53MgAqNpIp6SQ2iMPScGrnsc8cU4jcA66tjsAG9uWG2UjCuy+vlUv/yuxNe912j6P3yk8ut9B5ffidFBMUpk3Q8NPO+m69RdfpxzjYTVIf2B/KfV2nuel3Xji2eFt22SCy+NwH2+rxEtFUOvFoab7GbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRCm+J+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRCm+J+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5FA1F00A3D;
	Fri, 22 May 2026 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464437;
	bh=rlDrTS/qDNMBtSrkkbpm6odK2sEC/p6nHvamOoXHSXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PRCm+J+mZl77Sc1wSkhjFvMo6gfXN2YkuIeCJ2pHOE8X0WlwQ5pbBuOyF3jt4nZRH
	 ben/v8RpD9Pd9a0vOPWvv/7KDogs4XMbaVgxOaUBnBEBsAYLYfxu2ZzvDwzz7gPfgB
	 Wbemfq7GP0Zvv9mudLM58kVzCVUJrZfRXcwA+KgZCQ8VNMS6PcrhiKXoF7eEDdnZh3
	 KeDyvyuO1x6tv8oXAa9KaW+Ju/0vxydczqLPpjzU9kn60SWU1dqC2p1uaRNfbQG9EU
	 Hgo8plxdJhtTC3ANO7HrR39qRyGH9uagAnkV304IxGfM7N2D6x1iSepAYmeWRyflMy
	 p0Of15I8kFNig==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/14] mm/damon/core: remove damon_verify_nr_regions()
Date: Fri, 22 May 2026 08:40:20 -0700
Message-ID: <20260522154026.80546-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DAMON_DEBUG_SANITY is enabled, damon_verify_nr_regions() is
called for each damon_nr_regions() invocation.  damon_veify_nr_regions()
iterates all regions.  damon_nr_regions() is called for each region in
kdamond_reset_aggregated() and damos_apply_scheme().  Hence it imposes
O(n**2) overhead where n is the number of regions.

Though the verification is enabled only under DAMON_DEBUG_SANITY, which
is not for production use cases, it could be too high overhead.
Meanwhile, damon_verify_ctx() is doing the damon_nr_regions() test.
Because damon_verify_ctx() is called for each kdamond_call(), the test
coverage from damon_verify_ctx() could be sufficient.  Remove
damon_nr_regions() verification.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9cde5b47b9585..265d51ade25bf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -686,27 +686,8 @@ void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx)
 	damon_free_target(t);
 }
 
-#ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_nr_regions(struct damon_target *t)
-{
-	struct damon_region *r;
-	unsigned int count = 0;
-
-	damon_for_each_region(r, t)
-		count++;
-	WARN_ONCE(count != t->nr_regions, "t->nr_regions (%u) != count (%u)\n",
-			t->nr_regions, count);
-}
-#else
-static void damon_verify_nr_regions(struct damon_target *t)
-{
-}
-#endif
-
 unsigned int damon_nr_regions(struct damon_target *t)
 {
-	damon_verify_nr_regions(t);
-
 	return t->nr_regions;
 }
 
-- 
2.47.3
