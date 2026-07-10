Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA527B4F7;
	Fri, 10 Jul 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691227; cv=none; b=QFwIpEzDrw0xcnl+OkAbBelu6J3hk6+iIVkT6YQr1/1ksvUYL39Q/fXT5Rx6m6MPi09jgd72aN3OuNqzQ4dPxTDQ6TsT4Y4dld3tP48/ow+SFBSsUMDv2JzContRUcjCiVYRvB9hVlo3J2jspTEhASXVEAbAjaOErMmIjqKWVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691227; c=relaxed/simple;
	bh=UPDYBukpzTZm803zMb3HBoM4Yx1CPD0A/mjkTuTsUSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk19luEy3JfTs4pmXXf5rxOLC+Z6FGJ+K8lmHDcR2pRwux+0d6SCov4GMUntsTp3k/Hq3PsEN4BXYJA3XyGQmm8SjcaTCkmaNG3qLONAOheO5kth0Ejr8aJMPu5TaAi9y9ydo5dZyw+TEqniL/UJEyIQ0G2dpe5OEgtLcLRU9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgN3vABS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgN3vABS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CA11F00ACF;
	Fri, 10 Jul 2026 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691224;
	bh=wWo/baeB/+xecwr1CR8NpXyICuKLRcYoU7QPq7PEYE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MgN3vABS6/mROQHiY2SVPzVsZ58e2dAD9UmVZhgwnBiVd6yNeZ6APcel/2iNfy8rX
	 7VCsY/C2KJAOQs56Kt07iLDIbC2uS/R697jBaRjJs43AQY5NXgLpPNHgFtFkGBuWZa
	 u6A87pmd4g4zp7AymKHIE1+ukoMvbAGob9rKSd5kt4Ju1Y2/cIFyiMvs+PvfBXzHcU
	 al2IhbgS9/7lt/6MkZNoAQd7UUs1uHhMER3ntmQ6aD45X6Id+uavfUWpMyNFWKtbqs
	 q/oJL0a14vEHt7F+2evpj+IRnmBV65NBthOF8mJXEnTr8VlgDnpiBU9OWkabm6HBjI
	 xQk+zazV/9/CA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/19] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Fri, 10 Jul 2026 06:46:43 -0700
Message-ID: <20260710134651.18084-15-sj@kernel.org>
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

When probe weights are set, DAMON merges regions based on their probe
hits weighted sum.  But the merge threshold is calculated based on the
access frequency.  Update it to retrieve the maximum probe hits weighted
sum in the snapshot from apply_probes() ops callback, and generate the
threshold based on it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f7782c69037da..91964336ce31e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3763,7 +3763,8 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
-		unsigned int max_merge_score = 0;
+		unsigned int max_merge_score = 0, max_wsum;
+		bool get_max_wsum;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_merge_score = ctx->ops.check_accesses(ctx);
-		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, access_check_disabled,
-					false);
+		if (ctx->ops.apply_probes) {
+			if (time_after_eq(ctx->passed_sample_intervals,
+						next_aggregation_sis) &&
+					access_check_disabled)
+				get_max_wsum = true;
+			else
+				get_max_wsum = false;
+			max_wsum = ctx->ops.apply_probes(ctx,
+					access_check_disabled, get_max_wsum);
+			if (get_max_wsum)
+				max_merge_score = max_wsum;
+		}
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3
