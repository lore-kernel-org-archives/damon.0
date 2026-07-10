Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029F23C51D;
	Fri, 10 Jul 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643044; cv=none; b=M98Sczjo2OxBpqKAP0HOeD2hI0LfBPDQr9DQxZCJWDPzdNKppzEKaXc8gAUeDWQwVAYN2TCoPMV2qPxyZK2FZwSFDCQ8mTAcBIlQy7m1Alpa4pSeZeLdEQnhGCZf5Tr1XxW0y9sB8XMS2DrzpD/KBmBlk2yUVvWksp8P3HW8N2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643044; c=relaxed/simple;
	bh=CAFhgrMGc3itfU5+cS4J9LOcbas+kma1EtBrN2JCFh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOxYwszCcMPgKbUdG2VYnYceK4v4KLIka10mFirC1PWi3RYnIZeOaljABHYe6CgWpo70S0zb9ZBZ/5WQaKAwDXjqx/8JN5LlOYXn7VwocQWKgtiSvQ9CNlT7LmFiEQpnDoEDzwlAgX3zosue3a3y0DgO7NcRq6MMPEobWA00nAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AawtbD5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AawtbD5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E0B1F000E9;
	Fri, 10 Jul 2026 00:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643043;
	bh=UYlXBFEEj8Bqit1WCVkStlsJk2B9S/H0owK0kWMcnr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AawtbD5STBYfcSixB/tTmjtfvyloEiP08rldHpcaTOQppP0oCEg9m0xvHNNZe+Oof
	 kcYqmvF3Hx/Lqn7Ge+nJiPY3aiKQvwZkFCSl6A+ApPxONZsQvjgGNAgoeFlznFumnY
	 pdBmnRo5qTJsvE42Nuii6obfmCDbN4OPZt/MCOUUplHFesUD2bN7pOqZoNpTKSU/Ue
	 cjmce34HrF2EHsVMXNr6mwYMtnetMKsWJEp9TX2zqIHbOLxgreONT3zvGQHGDKBBwS
	 9uYrrr69BxnhrhPfRuLA6aSaBr5gTpVJ4dCf1bLFLlpmWT/uxHDk3d3W+0sgDxa85S
	 ZdZnFFngwBgFg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 13/19] mm/damon/core: s/max_nr_accesses/max_merge_score/ in kdamond_fn()
Date: Thu,  9 Jul 2026 17:23:39 -0700
Message-ID: <20260710002349.111414-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
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
