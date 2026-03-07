Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75F38B7A3;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912963; cv=none; b=Cl57KFi+DGjVBzbfcnHrOokCN8QqyV6kaf8+25JKsy7AguYF4dozPASL3RqQMGVsu5IeSmIAMh1d743gP9Is2qIyDV9le9Xoqd5kf6MVVIkVxnfqYz4eqHBkwB3wmhtZACOHeObJTh+gdtgymsJfUl3VwoYX4ghcQvfYtKvMw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912963; c=relaxed/simple;
	bh=Za6lpJwLEosOpDlDvwmJC/zKpW4MWLYWLFZqfZ7RdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEoE6FSb62bIxNDJ1Q52mztqd7BwBoHeU2heVS+xHNGHQ94qqD86BnpPBDuqjwOZMiWBbHosGWxJRaf0LCTMu7lpaEGtYD+WcgBTfQBN2w99dj4Nzp5iCGJIoENMcLPFFvU3AAWHVeURxaiTKdlIsE6acbNKFmBEdbn4boPQEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEJvl+YA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEJvl+YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F0C2BCB1;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912963;
	bh=Za6lpJwLEosOpDlDvwmJC/zKpW4MWLYWLFZqfZ7RdwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEJvl+YAbT9PXtUETsi60jcymWiXmgJCPTrhnzWxWSUvDSfTBvVLKFqnSugR1lo0J
	 rOenWaRUaGt7+2tbhuj0RZEyRWW07hUWI+5B9rvZIsh8BN5V8eWZ1mva31S2OEHyn6
	 iQ27N+x8TbtOSdBuPOqhoktX6nl54MzND32DrQqht5jCunuAYhYHU0/EwvSO5MCYIY
	 EMrb25eq3ER+ik+BHGSFW2J/gWAXu/lqPxiU82etKjjbMPNljoNqMwnJQHojEFByA7
	 /znw6AgT8r5mAzZSDUFlNxfTK6M5a5reW1IHQVHd7LwvbO0oIzZ7B4KKlbSHGRpEsn
	 AkGpuQo3l/FrQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/core: use time_after_eq() in kdamond_fn()
Date: Sat,  7 Mar 2026 11:49:14 -0800
Message-ID: <20260307194915.203169-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307194915.203169-1-sj@kernel.org>
References: <20260307194915.203169-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_ctx->passed_sample_intervals and damon_ctx->next_*_sis are
unsigned long.  Those are compared in kdamond_fn() using normal
comparison operators.  It is unsafe from overflow.  Use time_after_eq(),
which is safe from overflows when correctly used, instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4ede733a94cc0..cd2d7a8e3fe92 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2915,7 +2915,8 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
+		if (time_after_eq(ctx->passed_sample_intervals,
+					next_aggregation_sis)) {
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
@@ -2935,10 +2936,12 @@ static int kdamond_fn(void *data)
 
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
-		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
+		if (time_after_eq(ctx->passed_sample_intervals,
+					next_aggregation_sis)) {
 			if (ctx->attrs.intervals_goal.aggrs &&
-					ctx->passed_sample_intervals >=
-					ctx->next_intervals_tune_sis) {
+					time_after_eq(
+						ctx->passed_sample_intervals,
+						ctx->next_intervals_tune_sis)) {
 				/*
 				 * ctx->next_aggregation_sis might be updated
 				 * from kdamond_call().  In the case,
@@ -2972,7 +2975,8 @@ static int kdamond_fn(void *data)
 			kdamond_split_regions(ctx);
 		}
 
-		if (ctx->passed_sample_intervals >= next_ops_update_sis) {
+		if (time_after_eq(ctx->passed_sample_intervals,
+					next_ops_update_sis)) {
 			ctx->next_ops_update_sis = next_ops_update_sis +
 				ctx->attrs.ops_update_interval /
 				sample_interval;
-- 
2.47.3
