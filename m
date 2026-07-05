Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA53A9615;
	Sun,  5 Jul 2026 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285079; cv=none; b=iX22SVs5MdSDF7FWEQj6rky97EPK9qKH8KwE7n7hoLBupGizLMNGpUO78mV+i8Gz4fXJO8CmjD71apsonkpoMJfyacNz0IlUCtVVNVvYGcVztbDC3bYnwP6iiFEEKIuMtDRz7jMctVOd3UaUiuBxNTkKHxj87LIdEOphyAhM7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285079; c=relaxed/simple;
	bh=jSB35PAfxFgFLehBwkbViwLWdTdGcbiSQLNz48YUg5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKw3HZP2Q96oqyR9ul5gjacurBahiRj4jaGFvI/Qa8Ak2atxyWcsyz0FgtwVtWQyponWt6U05qDqy2Uq1TKSmUMsbnMJQQnrjzcJunLpeRGaPedQzkHype8Q3EUtFdwy/2QV1GDtqsXIoYv6Ob+R/JrDsjWxRWwuhjBvoBrFAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVz7gAMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVz7gAMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F21F000E9;
	Sun,  5 Jul 2026 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285077;
	bh=nsWIFasK6BNqNQpHNrMhe6JldAnQbV9yCA0uK0R+9K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IVz7gAMy8tYtuvtWrYqE+U4IJxgtWZVCsu6NBUdkOoiRSnOSeh54+QLPYgWDDa3PM
	 dYlk90ddaT3qO3+wZvCUIJWM2G7S+lwL8PcUimgvGFWrRK+uw7ZhJ3fe970+1bufyL
	 zo7GZIaIetLHcO3tGwUIJ8p6RIJEAVdvTHbc8x2c0e1ny/te7o5Prh2XAXkjXDjzXh
	 807yQmzpQYHPQ4gxlXCrR8p09o5/uBB2VB00bO0wsxWTR//BwTA0+qDuCLXrB4HQgS
	 A24Rv/X5JdHwsM36QunDPr8F9/HVDNlX1cspS4Q1fSIW4zG6jUDR7wTDD4+/cJipRe
	 RH07LkHy4JsXg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/16] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Sun,  5 Jul 2026 13:57:33 -0700
Message-ID: <20260705205743.98656-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
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
index a7ca69ea8e565..83db073c74e2b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3714,7 +3714,8 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
-		unsigned int max_merge_score = 0;
+		unsigned int max_merge_score = 0, max_wsum;
+		bool get_max_wsum;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -3727,9 +3728,18 @@ static int kdamond_fn(void *data)
 
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
