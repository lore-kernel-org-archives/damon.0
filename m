Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC332BF24;
	Mon, 27 Apr 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302760; cv=none; b=fI4WlWA0RoxYSC+4JjbQC1u27KcePq11fRaZYkav/PYr6twwu5liQAdWvN3XY4reyb5TV/OmobCBHPMavKTk+gi+z8AofQMhQawVWpJqCtKumoe9coJnqPjPf0fgxNRlROv8PhinQzzPeqkQi4Vzp4sU0YSICOa8NyTZ2aCCyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302760; c=relaxed/simple;
	bh=Apk+eXvqRSR2+iwL/Aa86zOSrOeZDT/qkO72pSDz9VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/k5UhgRcbC90e/8ImuCTdigE3nYnrya3B20nG9YcbesjtC7vRWQD/1lAopt8570sC7HvnHQmNf+YYdofsHLSs5EH0beZYS9gXCqCa+cozGBnzBG6BUTEEciKfa8lo2050Amov4dTICsVqyCuFmMkeibb5pyhcHpEN86QSfUH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn9gY+7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn9gY+7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125B6C19425;
	Mon, 27 Apr 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302760;
	bh=Apk+eXvqRSR2+iwL/Aa86zOSrOeZDT/qkO72pSDz9VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mn9gY+7I7sI26P7ezwJ2NpPolcRAG32kCfn1mjgOoxVb39gIYIj/4VVLIcj4vFJjy
	 bXHRaA3FjLPqXHZNyZiHoR+dyaiFpj4o7qlF0zaevuHjbdjHYnh5nOM5n61iauBDcG
	 yPhPh8ErL5Cxb0FgUySj5MnS0rZxpywCJBCNgJmnFfZYUHVp9uP9wNuiO0aS9ptlG8
	 fw/6hhVyU3n3DWe6bx7jkyWqSB6i4yQojLKipW9AUZnjN1ow7e3ycBX1n1JdyKXHAP
	 2jB/2g2iqtEr4nXSSKCooQXtFAcqH+RsLKkemrxRvMk9Ji1QhqMgzYqwuH1P5ESm83
	 R9WS5MJwi5eBw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Mon, 27 Apr 2026 08:12:20 -0700
Message-ID: <20260427151231.113429-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON supports only start and stop of the execution.  When it is
stopped, its internal data that it self-trained goes away.  It will be
useful if the execution can be paused and resumed with the previous
self-trained data.

Introduce per-context API parameter, 'paused', for the purpose.  The
parameter can be set and unset while DAMON is running and paused, using
the online parameters commit helper functions (damon_commit_ctx() and
damon_call()).  Once 'paused' is set, the kdamond_fn() main loop does
only limited works with sampling interval sleep during the works.  The
limited works include the handling of the online parameters update, so
that users can unset the 'pause' and resume the execution when they
want.  It also keep checking DAMON stop conditions and handling of it,
so that DAMON can be stopped while paused if needed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5e2fee6f517ae..82dd43fb639ad 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -792,6 +792,7 @@ struct damon_attrs {
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
+ * @pause:	Pause kdamond main loop.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -845,6 +846,7 @@ struct damon_ctx {
 	struct damon_operations ops;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
+	bool pause;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9a4220174a61a..00ff1a1c92e73 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1368,6 +1368,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		if (err)
 			return err;
 	}
+	dst->pause = src->pause;
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
@@ -3156,6 +3157,14 @@ static int kdamond_fn(void *data)
 		kdamond_call(ctx, false);
 		if (ctx->maybe_corrupted)
 			break;
+		while (ctx->pause) {
+			damos_walk_cancel(ctx);
+			kdamond_usleep(ctx->attrs.sample_interval);
+			/* allow caller unset pause via damon_call() */
+			kdamond_call(ctx, false);
+			if (kdamond_need_stop(ctx) || ctx->maybe_corrupted)
+				goto done;
+		}
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.47.3
