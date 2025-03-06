Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4C270EC9;
	Thu,  6 Mar 2025 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283964; cv=none; b=BVWRtzL1SfBxdP9p+/n4WLOknk3S1LkD1PTPHOgHeL1Dn7ocY3+dHoR/yKHU19NPL+HZG5VlU/W2O3vQKAiiJ8tONEeW+r8cS2iQDhQOM/A8vxoEuZol15ovXp6+uVywdLiFDKqiySvGX5bTPuKQ356hGIkd6G55YIfVtD1c3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283964; c=relaxed/simple;
	bh=S+TNIBRN6YsZ8tOcYDy9gAmvy6YsqhXhgFNOQBl/SdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aN0RyuaZGbRh/jilwUQA4gmpIwnYEuPrlZ1dPWhpZMUmTmrfZzwS/UQtys0eN89co1+3sQbSXWyoARNRET7guVHq9JDRhN8PGxKqmsYzIBwrhrxqXGeEPjVUANfRetekIEXbm14W0ncV8BQ0AulTC7TsQcRnGqaT/rw+qVqVNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S14s7Ljy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S14s7Ljy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3196FC4CEEB;
	Thu,  6 Mar 2025 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283964;
	bh=S+TNIBRN6YsZ8tOcYDy9gAmvy6YsqhXhgFNOQBl/SdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S14s7LjyIEJw6vYOzHXcs45rJA5HM0smXIDKTwtGIGtVg5j4Sxt57Tb2BNY0Wgjwn
	 xdgaz6Fw4jpwFIPd5XPf6KLq/W/hF9v2XhGQIy3gCw0x3sdRU4rGi4SwT91xRrwwOH
	 KX3cZ0lWMRUJhp+OpdXdF4cviM/flmortjg5iANDvX4Ia+0gNzA/yQqhLzEY8LBBDp
	 TY27V/oidghlrJ2674LYT4BZqSH+9+a2LBo+rApY0WnHbBOcSemaaayM0B11vDngc9
	 z0arz79RE8XCm17cIDz6LQwfsUJD3k6SJEWsh4QHFeKFBgHxYxBZQlfaPzrPXSg7IK
	 V1xIHhSvP40rw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/13] mm/damon: remove ->before_start of damon_callback
Date: Thu,  6 Mar 2025 09:59:05 -0800
Message-Id: <20250306175908.66300-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
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
index dab4bb0fe39d..043de2408c65 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -603,16 +603,14 @@ struct damon_operations {
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
@@ -628,7 +626,6 @@ struct damon_operations {
  * If any callback returns non-zero, monitoring stops.
  */
 struct damon_callback {
-	int (*before_start)(struct damon_ctx *context);
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index de30b788e13a..8904b3c079e6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2407,8 +2407,6 @@ static int kdamond_fn(void *data)
 
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
-	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
-		goto done;
 	ctx->regions_score_histogram = kmalloc_array(DAMOS_MAX_SCORE + 1,
 			sizeof(*ctx->regions_score_histogram), GFP_KERNEL);
 	if (!ctx->regions_score_histogram)
-- 
2.39.5
