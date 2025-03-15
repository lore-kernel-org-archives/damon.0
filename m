Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA574A06;
	Sat, 15 Mar 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742077574; cv=none; b=BNPMuKmLf7fNrDLZTO351LHVDvBR0EnaTZNoKy297JA1fHnWBssB9l4p/MQmr7BXmgFgUsyg4+IB8ARK87recSvLE1bwZPAGiRo7DyUG1Xd2WV3yvGSiu7llr5fkTpbqyehjTQ5TyMbyxDHGZdYeppqASLfoeqqLcCj2MJ8kQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742077574; c=relaxed/simple;
	bh=IZ7hQqeuHwLTEWeBLXMbvbomiMzODFwSXk5X/rK2CMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltIMr7oWxc1Yuxiwm9nUff/mSTzh2drCAGnXaIyZLyOnNwkue7OnWzxvc118uO9/6Y8h9akCQ9i4jeiTwcF7G8Zr2syaNxSpNFthhzT5xEO6KY/MKpCIptDeSFeu/MixDydiPUY2tL09+qTi0kVpZdfUHAfxckX6UFKPgCBmKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVsETmf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVsETmf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB96C4CEE5;
	Sat, 15 Mar 2025 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742077573;
	bh=IZ7hQqeuHwLTEWeBLXMbvbomiMzODFwSXk5X/rK2CMA=;
	h=From:To:Cc:Subject:Date:From;
	b=IVsETmf8VXTNv10R1QyakcVyZ0QyqiDn17KQ7av61sPG/+ZuURXTIB4VP+wGFEBQ9
	 YMOy84MrD/eRJqKiY29TY2AklMco5VtKGqPwpAn14mHq8LhtozaIcai5r7Uj+sNlU9
	 ITut/M5SaQwmxHenFNit57E84kDeChrjkQNDz1q2/XHS4gbB/Wb9vKGqXvf9vDATs8
	 g0dz+r3U52XVWmuIUxcaA4AjlBYF4PsyqBQee1Oh+T14MduW3rUY78E4fCkRaSUDaB
	 4HgbproOICNJz/GdzNzON83XzBKavX2rWa/9qZ85q6vYvXZnlm1B8rfu9c07Zvi4r7
	 gDGmJj3I7FRbA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-unstable] mm/damon/core: setup damos->{core,ops}_filters_default_reject for initial start
Date: Sat, 15 Mar 2025 15:26:10 -0700
Message-Id: <20250315222610.35245-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6a0f07289bc7 ("mm/damon/core: set damos_filter default allowance
behavior based on installed filters") on mm-unstable sets
damos->{core,ops}_filters_default_reject fields on only
damon_commit_ctx() code path, which is called for only online parameters
update.  Hence, users who set filters from the beginning could set it
not properly initialized.  As a result, unnnecessarily DAMOS target
regions can be rejected.  Set the fields at the beginning of DAMON
worker thread execution, too.

Fixes: 6a0f07289bc7 ("mm/damon/core: set damos_filter default allowance behavior based on installed filters") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index db357892da74..fc1eba3da419 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -525,7 +525,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
 
 	ctx->passed_sample_intervals = 0;
-	/* These will be set from kdamond_init_intervals_sis() */
+	/* These will be set from kdamond_init_ctx() */
 	ctx->next_aggregation_sis = 0;
 	ctx->next_ops_update_sis = 0;
 
@@ -2363,7 +2363,7 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
-static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
+static void kdamond_init_ctx(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
 		ctx->attrs.sample_interval : 1;
@@ -2381,6 +2381,7 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 		apply_interval = scheme->apply_interval_us ?
 			scheme->apply_interval_us : ctx->attrs.aggr_interval;
 		scheme->next_apply_sis = apply_interval / sample_interval;
+		damos_set_filters_default_reject(scheme);
 	}
 }
 
@@ -2398,7 +2399,7 @@ static int kdamond_fn(void *data)
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
 	complete(&ctx->kdamond_started);
-	kdamond_init_intervals_sis(ctx);
+	kdamond_init_ctx(ctx);
 
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);

base-commit: dba212acaa779ea422b1c0653951af5fdf837314
-- 
2.39.5
