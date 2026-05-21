Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A2385D9A;
	Thu, 21 May 2026 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335644; cv=none; b=Hi2jtTFhMjLfXr+5DZgadcjhp+VMmzj2/kyukEzahN8RdcIY3I+zAx7ZsPlZtJwCJmO2DRAG42EZsHZb7O0iyA0/U8HcDUs9ZxPB0AKOUgInk8/U0a/ED9NOLwuuEBJyhw0XwJ/VBoNwm7/+/3Sr0uyxgGcTWu1eSOLSeUKOmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335644; c=relaxed/simple;
	bh=60hNbVqTSP21yPGuac3bHL+OYhfMoIX08QASyu0GIRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKpaH1fbE1QM0eRK7SWBqbI2VJzS12No7+ZMC9yHNjcW/STwgG3OnoeGW0gCQVorIupJmw4NG0bxr3HtBr5nhvOHd9f5IIF9xMLEV0Bht3Bjf4WVDRboGv2xUzSbTCC8Ysvo8SR+G2sGsEllRhGPvFPO9L8wiSk/w94/W1d0FgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MljEHJLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MljEHJLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD591F00A3E;
	Thu, 21 May 2026 03:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335643;
	bh=rlDrTS/qDNMBtSrkkbpm6odK2sEC/p6nHvamOoXHSXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MljEHJLPdHlsbffSNnQPQqAl/ys71TtEecpF6sfGRJrYEPiXomGdTfS3q42D4sRTn
	 VlaX6Sawr9YNeS/6jnCc1lDbUCj1dm8rt+NEr2W7/zQN0WoUX/D31yjMiIrrnVcGIz
	 TNm1YW+rquPrFqUktF5qEoTca7UZjWIalqKArT1Usfca1FBP1wUQ8qDcnPNpkB4aKP
	 wigTtk1u0z2M5bp3s935yV/68gr+GwcB07H2NbxCBRARW+xU9pg9p/Sl0PYMu0c6mw
	 oLthl4minkCOPyQosegn/93FXSfId2/M08NvGpGmU1FFWE79BrfXpnTx4xVsO56Kzl
	 U4IbFMbQsoJoQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 09/14] mm/damon/core: remove damon_verify_nr_regions()
Date: Wed, 20 May 2026 20:53:43 -0700
Message-ID: <20260521035349.87565-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
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
