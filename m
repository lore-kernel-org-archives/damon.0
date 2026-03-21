Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368F307AE3;
	Sat, 21 Mar 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116833; cv=none; b=uMSax/VMmxkFJCho8fg0S1oQGhsWT5KlRmjIYxdnQanL2QAQxMV5H+cGWDxWaHTTnqNCg3Zoo/p4PjM3dGVps13z8XCc0lAcZgkjoss/+YfhmWCq61c6i5PVNm80PpZRUTVyZIyCxUCaXEpyQpbfx2kfeBYDqpyXk5IjSMrsOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116833; c=relaxed/simple;
	bh=In9pNSVI8OEhXXcMpw7pEozpwRJ9LmKQ0qx3IoCdr7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4vYfrjFhzIbJrigp/5DWNX9FzC4e9+tupoQioAFnApqrnrhcRSS/LWI2nJsacWvZWvmbvOtlxWRlNIfCwmAqgFaWM/F3IxAxpURuHIq3yT5fvRJd4PVoxG/gctbRanXK4MEdUdYH1/UdfTPvA9keWrSa000HHfieW9UiJXv60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+dtzIni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+dtzIni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1867AC2BCB2;
	Sat, 21 Mar 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116833;
	bh=In9pNSVI8OEhXXcMpw7pEozpwRJ9LmKQ0qx3IoCdr7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+dtzIniz737VuBV3Q4xy+WjlaM+VX1njXxLuhhyT/HZjtxoReCzvmOvKSGoh9BqM
	 x9OnbfmEMiLjExZia/7q8I/tiEdrsqUzYG3GxRd4ufNQsVPkuGTtlQ2T8DX9ue44R2
	 hCmDAxymFLHvdo6REd+Nd5mg0Sp8jbcL/0nwFaDkBkneSluFQDbNAkFP2/t08z/500
	 5IyBflUpaXg0QFX6Fxj5nGRpf+be31Hj0Cr4wCsGeU/7KGTKUaG7S0BhBRMTd2wqcu
	 I9GmOQz0ciOQVsQOYGG1d6ZXGXuxEctEMCOyN4kHfK3+Dn8ROqUAacJ5D0mxTuGqjl
	 jnqyKlHv91ZTA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sat, 21 Mar 2026 11:13:31 -0700
Message-ID: <20260321181343.93971-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
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
index d9a3babbafc16..ea1649a09395d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -787,6 +787,7 @@ struct damon_attrs {
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
+ * @pause:	Pause kdamond main loop.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -838,6 +839,7 @@ struct damon_ctx {
 	struct damon_operations ops;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
+	bool pause;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index db6c67e52d2b8..ce010009ca136 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1349,6 +1349,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		if (err)
 			return err;
 	}
+	dst->pause = src->pause;
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
@@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
 		kdamond_call(ctx, false);
 		if (ctx->maybe_corrupted)
 			break;
+		while (ctx->pause) {
+			if (kdamond_need_stop(ctx))
+				goto done;
+			kdamond_usleep(ctx->attrs.sample_interval);
+			/* allow caller unset pause via damon_call() */
+			kdamond_call(ctx, false);
+			damos_walk_cancel(ctx);
+		}
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.47.3
