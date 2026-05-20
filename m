Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5B37647E;
	Wed, 20 May 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258552; cv=none; b=Ww7JzuaD2AaBMro/KZ9DUlbELn/MCJ1e8Qz99AdfPzG6PGpClAtDY4txpYRUqwEVpAxZGMLw3lzkcNkXLt/vneZCRwkUFVDbkDV5zQ6/9veM1gZEAUXFg83w93rZJmdivYKCrlzonPiiYqFrzYjn4Uj0wy6DDbQpH7f34t/TKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258552; c=relaxed/simple;
	bh=lpSts6uYgJTwQnR0tqrpn9gyftbdM1/PtbAdTF8k4SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I36pBK4kRRPFgq9ikEcKwWcHYabQ12FPm72SbZ3hm1RNr0XPVzY4JwLVgsBzDc3aLaIIWZWkE/jNbkJJZ+lcGZdNb5Q1xWJtBMfXzqG8iJLaq8t9VyNa1NMPR17xn64ESWLLBgSE+P61pSxu2Rc3OA+n+/kuChD+dmZTvsoZY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuffpziA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuffpziA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979101F00894;
	Wed, 20 May 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258550;
	bh=i4QYAEHbDCvNou4iBTdigpX/qcP0blVfRQa9MnkoH2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuffpziAWFwnPx+GwTm5I81IktL90Ytz6cqBL47N2tAApCaD1794IXBGY0MSedK1C
	 rw9QV5bzVvjay2UlCCZh7TRIgnnQK2fbmRifTouq2ueSu7LbHv9LpVsigyUKmgTC3F
	 0qGGzoyErrEbYAcD9JwZvu8YzEgjED1gTzEwTy6Z6ir7jFizIMgUpQGricmQ7asNhx
	 R1OdbxXr1HAzcDYFQi6MxHFUFU9NOfNhWKFX9qS153UpEoNweD36vEjhxg47gsv2Q8
	 qLDyDmf471SMXGT3UL9iSD7QkAUxAxP+hZrJyjlxHi9K4QDMODlGE91820cxFthxKP
	 Z3YKcpdKviQJA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/14] mm/damon/core: remove damon_verify_nr_regions()
Date: Tue, 19 May 2026 23:28:41 -0700
Message-ID: <20260520062858.167011-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
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
index 22327a23c7e57..b2d268c4102db 100644
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
