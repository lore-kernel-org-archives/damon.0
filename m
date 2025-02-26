Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442B271260;
	Wed, 26 Feb 2025 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551827; cv=none; b=uhyc/+okMwF2HNkQnXlS55U3n3LBLftjyxKMSev11BAvdCD37aq6bsS/RSVN70bEEXoBi7DCTKxBNQb3FroydgoCF6jEn0xpIcVPQ9U8bdNILQpz4QuDtPCWrmol6FuW2CcKQXCPVTUQ6RQPAzXLFCyzGdq0BFED//cc7kHATgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551827; c=relaxed/simple;
	bh=e9BbdG+2vB4mTDRNMra/h/Oi4AJ4RbVhMKgF5wEM9pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpvoInswMcYRIuaXLcebljHZXNQ9Gqf29Uxyn76TajvIhtI386pRIAWC53kjGnu1MqOWXYtYFHrw0duvxJd6TUQLie2/UStvRz50UR6EQnIB0Q9kSP6AZyBUoBjTqHxrBDt/Yu5GbESR9m5vSMZRl4UuijoCY2NLiZGb0RE3jVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo/zDMIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo/zDMIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D24C4AF0D;
	Wed, 26 Feb 2025 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551826;
	bh=e9BbdG+2vB4mTDRNMra/h/Oi4AJ4RbVhMKgF5wEM9pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qo/zDMIbXIg4iDVJoez5QmSFrcvso/zTS3AF0lBT5xEKV2so/jqAzecIE/MA1ci1d
	 8bJb/oeaUeW3UiowG/ACpPzXs+xbCwGERjCC8K12Wb5Yjrh6aHbiosCR3ftS36DTGz
	 ylF/G3Mc532XIVh45Jeoc1Pa5aX88EZZGRQi6YELDM+8AzhT38Pu7TOcS0V2yBZtXW
	 MhCiqCSnls5757YCrjBjTAIWH5o944ZHS/9jHu2fPjSQPpYOaAknFb79Blcc2QtASs
	 RE44cR4n5JTU52dRgQbINPnxtCHGXPdV7oqysRLLjtMUTUcnnHsy9DqCzeOko4MaVC
	 npq+r7YNR8bdA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/13] mm/damon: remove ->before_start of damon_callback
Date: Tue, 25 Feb 2025 22:36:48 -0800
Message-Id: <20250226063651.513178-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pointer field was added to be used as a place to do some
initialization works just before DAMON starts working.  However, nobody
is using it now.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 7 ++-----
 mm/damon/core.c       | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2b783c91cbb5..11cd916b41fb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -598,16 +598,14 @@ struct damon_operations {
 /**
  * struct damon_callback - Monitoring events notification callbacks.
  *
- * @before_start:	Called before starting the monitoring.
  * @after_wmarks_check:	Called after each schemes' watermarks check.
  * @after_sampling:	Called after each sampling.
  * @after_aggregation:	Called after each aggregation.
  * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
  *
- * The monitoring thread (&damon_ctx.kdamond) calls @before_start and
- * @before_terminate just before starting and finishing the monitoring,
- * respectively.
+ * The monitoring thread (&damon_ctx.kdamond) calls @before_terminate just
+ * before finishing the monitoring.
  *
  * The monitoring thread calls @after_wmarks_check after each DAMON-based
  * operation schemes' watermarks check.  If users need to make changes to the
@@ -623,7 +621,6 @@ struct damon_operations {
  * If any callback returns non-zero, monitoring stops.
  */
 struct damon_callback {
-	int (*before_start)(struct damon_ctx *context);
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5b807caaec95..8efb249be855 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2399,8 +2399,6 @@ static int kdamond_fn(void *data)
 
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
-	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
-		goto done;
 	ctx->regions_score_histogram = kmalloc_array(DAMOS_MAX_SCORE + 1,
 			sizeof(*ctx->regions_score_histogram), GFP_KERNEL);
 	if (!ctx->regions_score_histogram)
-- 
2.39.5
