Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4627467F;
	Fri, 10 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691226; cv=none; b=LL31pzYw5WyBmMc+YVj2nHHxySU1x+ZhxSLzvdGn4UGR8nw1Uu7Z07wyeGSjEPFzSjyzIYp8dRzXyELsrb5XBggIXPYBF+ocJusrAWYFsUtLPSI4FwPd6PpNlDK3XiWli28AD9WrsK3xrps8tIj2CxP9tvqpOJneFI40DnZOaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691226; c=relaxed/simple;
	bh=CAFhgrMGc3itfU5+cS4J9LOcbas+kma1EtBrN2JCFh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/5WCILsHQO72LF8OfHM1cv99gFjx1EsPtMNs0R1wm2GFXCssPa2tIfV+9IGni/hynG9d0JPbZczOsoi1pccamR/jYcrEhIgnqeO6Z1UAe/DCJxcasF5ZzNlKzZL+iWNLNwgJTLgKziqIY18il5S92BWWacwvDPccVUmtSZ4oRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD47a+pU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD47a+pU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684771F00ACA;
	Fri, 10 Jul 2026 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691224;
	bh=UYlXBFEEj8Bqit1WCVkStlsJk2B9S/H0owK0kWMcnr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QD47a+pU2LC+s0dnvDU7JTzIMPniYub9WoVYKsZACiTjstOYpY53RzuPKXDN16LEt
	 Nge3POqD00YI1QEp/O1DzO0Mtm6BcKmJ3GwyGrb+zWtkczWRzw1m1InFq6UG/Ap912
	 UQVhxwXCdwb8hctwebO2qFH8/EUxPNzih2nRaI5pskEEk3nGnDXjotV4IYNuuVqj68
	 ejn4421GyhreCdu3uvBhgZcKgLxr9WpL4rLuCVivIk05y6VkMPoY+cks/wLyBJljJi
	 yNbNWAy20GQGorLoNAjYUTpfOyiVSbQTscc8j8m/xadq12Li63qwNIpXXbiibK9smi
	 1bdKu6FNPdFyQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/19] mm/damon/core: s/max_nr_accesses/max_merge_score/ in kdamond_fn()
Date: Fri, 10 Jul 2026 06:46:42 -0700
Message-ID: <20260710134651.18084-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probe weights are set, DAMON merge logic works with the probe hits
weighted sum.  The core logic is setting the merge threshold based on
the access frequency, though.  Before using probe hits based threshold,
rename the variables to look more general.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dd0612e1a408b..f7782c69037da 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3730,7 +3730,6 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 static int kdamond_fn(void *data)
 {
 	struct damon_ctx *ctx = data;
-	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
@@ -3764,6 +3763,7 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
+		unsigned int max_merge_score = 0;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -3775,7 +3775,7 @@ static int kdamond_fn(void *data)
 		ctx->passed_sample_intervals++;
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
-			max_nr_accesses = ctx->ops.check_accesses(ctx);
+			max_merge_score = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
 			ctx->ops.apply_probes(ctx, access_check_disabled,
 					false);
@@ -3783,7 +3783,7 @@ static int kdamond_fn(void *data)
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
 			kdamond_merge_regions(ctx,
-					max_nr_accesses / 10,
+					max_merge_score / 10,
 					sz_limit);
 			/* online updates might be made */
 			sz_limit = damon_apply_min_nr_regions(ctx);
-- 
2.47.3
