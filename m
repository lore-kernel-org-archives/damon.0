Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2D245005;
	Fri, 10 Jul 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643044; cv=none; b=rD2uQbGAnayNm0aZrbXFjaL7HjB+LqknXiju1kADReBsCo1SGtCjG2+H07EQJFe7l7KHmC7vysEk47gTLEomr+5NwlAsm6homUCOLnOb6cOiBp16NXkUtZDlRjpnK7NE1zXUN3I0tSu46jSmMKz+YkBAojDHP7SDSQ9v9dZuACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643044; c=relaxed/simple;
	bh=UPDYBukpzTZm803zMb3HBoM4Yx1CPD0A/mjkTuTsUSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUVmqeL1kQrzNXgrYAOlyQs5/htQfCUHU/qSI9ALxEm1jMUEXyKX3MOwa6YDmwDa8GcBnMQDc82XeHAt1pBqnKRSaxa5JDE5mbPvYpQK4K6R0skgK1V/pblAUuPCh7ydOKm03xgw6JpFtSa7Sfh+Q96hE74Oi0Atngynz5W1wO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSfwDQr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSfwDQr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF5C1F00ACF;
	Fri, 10 Jul 2026 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643043;
	bh=wWo/baeB/+xecwr1CR8NpXyICuKLRcYoU7QPq7PEYE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSfwDQr53AV4/EKb/wGJwj/MufwDBv/yIio9QP/m2187gi7PhPTnD/jorMa9hkoPZ
	 kNDtSw643ahP8tjf5m5KSTtf9s1Ig1OEIe0C11EX91NuFhtF6Go9eQVxNY3+lMnemS
	 68s6UE0Kt15qf0cHOtg0AwDyiQba5SJ94qpcu7i+2hskvDOu1v5grnUFqpV+uhiagP
	 TxAlldIBOWILdk1yJooULBJcPTMr74S2HNPvcpEe7nBZBe7pHBNx+ChQpNWfpk2xvf
	 O2bvs3i15bzIy9c3TyF7CVoJLovHu5EKBCgIgaGAwrXJY9n676bnBPXPaeIy2mgh5N
	 zWpAur5V9iveA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 14/19] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Thu,  9 Jul 2026 17:23:40 -0700
Message-ID: <20260710002349.111414-15-sj@kernel.org>
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
