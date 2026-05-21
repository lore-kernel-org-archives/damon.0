Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E2408015;
	Thu, 21 May 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374082; cv=none; b=f2h8Jgfz2F3OlyxO8b8Y8T1Zlz1lJW4hlwu/ZarxM2uNodQKVll2+t5N3ameLer+VXwsIfTJ3onv+LUrRp98r0KD7iJTdwLOXuy08eoXIC1eWNUb1j8DzdxYJ5BH4uCjrJh78GRwvlXedONy4pRipYPuqfPsp1/2MdNgz1c7bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374082; c=relaxed/simple;
	bh=60hNbVqTSP21yPGuac3bHL+OYhfMoIX08QASyu0GIRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPPnAqwdriGDWnxjBe1DrHr5qT+zugSjpKt7H2tbLG4a2KaU0JZs9elxbDegljOBCGtzynhXq+vGT6uMgWTjQBchm87wfZZMV4QtlRjgi0Q9QgcD0E7frvfgTQQL394ewWNQDw15g4KvEooDkfEAHo/qdZuQ6zgtoIMlScdnTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtY5kwgF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtY5kwgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF3F1F00A3E;
	Thu, 21 May 2026 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374080;
	bh=rlDrTS/qDNMBtSrkkbpm6odK2sEC/p6nHvamOoXHSXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtY5kwgF4NwiR351gN+IX2c7r/wJR+0aeF7H+sK8LicM/7/DxyiXigb0TCZ1ozEla
	 0RsIyyO4Lbz+bYSE71gTiHiEncqPdNwEjAwFHjE9PFGwQXfptpQx8MVzKARWNuF4j5
	 bUXioO3JgTlq0Qggl4aqdkeJUsipCmLdCYQHj4ztcuCwMGAMYvGS+k9HedAVX2vIkx
	 qOG7euYJG+CuXuKHcsz+GPig1oDr2n1hMWQtC59Y1CNr0J8yBnRu1umoNlKsHJFzM/
	 SbfuvdcQFxDNkXl7ogp47u87t/ROI5Loqe5V7v/dmaWoOgz8drDrXyVXyc35TDD/p0
	 JUEYKQKQluElw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 09/14] mm/damon/core: remove damon_verify_nr_regions()
Date: Thu, 21 May 2026 07:34:19 -0700
Message-ID: <20260521143428.83157-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
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
