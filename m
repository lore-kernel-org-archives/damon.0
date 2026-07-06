Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89D42F719;
	Mon,  6 Jul 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347565; cv=none; b=peMGu1ETwQ0ibXsy2s8TLyMQL02JhOAVSeWGYpAz3+TzRyb6WfRlN+wZoJnbXLD8KCUDAiYkCt2XeUH0gHik6xkjRi71Ox3omfCfSd9mw8tYT/V+x4tZRABWof81atfVJVDWQQKSaveJsUfHV2Y97Bp6vrYm2VkzKT/xjaaqkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347565; c=relaxed/simple;
	bh=3/yZyPWVptKudoQ6ARAaxUzO/pV7bi2Bdsgdn/cK8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dygEpi08pkJOvpf/zcBJo1PPrXf7ERBoqeGIwC1DuXGAOtNqcBkFuj6xaHEZG8f5CKp+wZdxNxxnG5BEUT3noIjymm7Rwg0P7crbW9LBRF5hf8OSdtbxP/278QO6LjOL/tIeo97/7o/aDXnzf7sT2TBydpPOBLmJaQIazQqjFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfwDclfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfwDclfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7169A1F00AC4;
	Mon,  6 Jul 2026 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347563;
	bh=OzzZd8DigQnVYbi2j1POHwqutTVJPfVsJOTUlbgk6WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfwDclfGvrh2DaiGg5vexq+MFhTZzvTR81fc3DKhg5C9oFBmKjitsY00wlpHrnTJr
	 xgAzvTmF0ysFf1HPqZlR5faZTQQUghibGPSsNFNL8E+gMbZNMLqjaA6cAes38i73k5
	 EI8y8toe8kBZn7npOjILOGFYexPaYd3SLPrQILRtRIeSfzqU4o5nF0w3k4+Xoi3epN
	 HDPHTw24Lg7bnyE5m++zD51LvErNVHTIpDCau2B5lbAx39iXQhnB3ZZNyl03N88S0p
	 2A5hr5lLOekmoN3kDr/fW5PZnFb+Kp7bJNctobzyqOyNzbY1Ka5JdpIf4SbzIuFXFH
	 66uY/vreLLlGQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 10/16] mm/damon/core: s/max_nr_accesses/max_merge_score/ in kdamond_fn()
Date: Mon,  6 Jul 2026 07:19:04 -0700
Message-ID: <20260706141912.88445-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
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
index 71008ee6ca243..a7ca69ea8e565 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3681,7 +3681,6 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 static int kdamond_fn(void *data)
 {
 	struct damon_ctx *ctx = data;
-	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
@@ -3715,6 +3714,7 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
+		unsigned int max_merge_score = 0;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -3726,7 +3726,7 @@ static int kdamond_fn(void *data)
 		ctx->passed_sample_intervals++;
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
-			max_nr_accesses = ctx->ops.check_accesses(ctx);
+			max_merge_score = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
 			ctx->ops.apply_probes(ctx, access_check_disabled,
 					false);
@@ -3734,7 +3734,7 @@ static int kdamond_fn(void *data)
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
