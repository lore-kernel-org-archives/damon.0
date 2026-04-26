Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B92FF66A;
	Sun, 26 Apr 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236757; cv=none; b=eibE7KwEHQDmwLP86pkCCy/yCMtcw6yh3zpDDk6+CiNGu9xitFdf5cRmHSO82d83gxi4Dr8syvJwDDXuOX8HtPOi2nLuKtdcoGCePxQh+HnMDbVwTVEmwmEeO51S79IYjVJYTjeXiFInixrzwOmDDhCva4Af1hQbxfE4IqseF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236757; c=relaxed/simple;
	bh=blGlhx9hlnhuQ75ddAmdhCx+qtv30Q5dipQv2/NkGPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5i1FCtjtcq1KGsnzffXSRgJYsG8GCfei1MyLbdicEVV/baZJbhE10q+dZ8VZ2dPSnd5K4OD+5vkfzFQnPdPp9tdCiAjJYXFnwEwsXuvgl65HBoXBOK9N9u2Km1+1GwUtvXqLJRIK4hiOUa4sAwNfTjBeHcKFlpxeGyQ4ybFgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTRBdK/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTRBdK/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF92C2BCB8;
	Sun, 26 Apr 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236757;
	bh=blGlhx9hlnhuQ75ddAmdhCx+qtv30Q5dipQv2/NkGPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTRBdK/2U3yntQylTgNKqIttVqxCUE3i+E4RHYiq5BGShm5gYKI9lXdpgIG+21tIk
	 /7KmfS3xmC2nVEkKgiFZsJuvygaXRI01ala5hy6z3ZgMSQ+DLOTrEZX+4xClsbHgsc
	 gzs9XEFLxs7viJvj585MSs59aGhoTgBLQjRmb153PNpkemLfR/qoswyWrfXLbWbPRQ
	 mcsbH30utTdYkhvxBQopPL/RhH4AKdX/W6tcjbEzyB3HK+AI0HAurxBQ/5fE7BMtxd
	 YjElo4oWhhqZOSVFxLLON9/MwmI6QCRYjFt/okmA3yjTS3o709v9vGQXLrCnBPCCx2
	 4CNfgwSSHq17A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/19] mm/damon/core: do data attributes monitoring
Date: Sun, 26 Apr 2026 13:52:08 -0700
Message-ID: <20260426205222.93895-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the data attributes monitoring execution.  Update kdamond to
invoke the probes application callback, and reset the aggregated number
of per-region per-probe positive samples for every aggregation interval.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d4779b647a495..fe14971d72747 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1921,10 +1921,14 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
+			int i;
+
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			for (i = 0; i < DAMON_MAX_PROBES; i++)
+				r->probe_hits[i] = 0;
 			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
@@ -3288,6 +3292,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		if (ctx->ops.apply_probes)
+			ctx->ops.apply_probes(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3
