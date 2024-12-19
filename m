Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A31A9B23;
	Thu, 19 Dec 2024 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581033; cv=none; b=g2MOgprP0CVXl99CbX6ZKTnyqdHUWWOBBX3gdfJyzYitm2eSxCq2oM38qYF8mrOv84JlVqU7+HyqfxCgeLGpkVUiqMbM4V2Ji1XlIyPIOVtigxQEeFj6tdlurMGNy42ZVWUlM93+c8BHqzorcbSH8EwYBsMpRE3mSK0trfMwe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581033; c=relaxed/simple;
	bh=uqG8Q9Szz47DcZj8JtbgYt8Z9acAYgWsyXGkRRs6FvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VaIaMDv+433cONm4BzFbrWwZcB4BEcZzOhdh6f3SB9n0khAdSjeCRBK/jkv7cqD6HzNN4yObTyPzBwbQMFRHeb6y8ZtKadaYAnX9XMNeqMIIl018OirueYokFivLw0NbSa42jmemkCn4NuqReRRKZaEHivl3axaTiZ13X/jD0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlLm/A9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlLm/A9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDBAC4CED4;
	Thu, 19 Dec 2024 04:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581033;
	bh=uqG8Q9Szz47DcZj8JtbgYt8Z9acAYgWsyXGkRRs6FvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlLm/A9Al/6Pem+PtlX0UaTXy+7/tQBEeZTMaw6V2dKYfBiM/eFoArYBajWW48+yG
	 OJuFLmwzHsPUEJ9t1o/xV/YzDH9DUoI2zydoHko9m7055yQfxEGs1LlR5irSd/Fx7f
	 DyYVnt4m5Gcr2Bx8EtjWN0rdpxZt72sCi9OokPAhZ3ghi1FydpigdWWAtxImV0fJ3J
	 7fSbm9fyit4hYVtVxlkJcwQKFeHVZYh749/+NXYeXX0nBPfZyzrpVd1itd0ZV8vLpK
	 lO53kuJDNrWkh/j8WoY6LpOaSVoUfvenrhx/c0wHj7Tsb44fdIfxoyNSFf4bEHaOA2
	 kcVb0j5A+7jJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: kernel-team@meta.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/18] mm/damon/core: invoke damos_walk_control->walk_fn() after applying action
Date: Wed, 18 Dec 2024 20:03:22 -0800
Message-Id: <20241219040327.61902-14-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk_control->walk_fn() is called just before a DAMOS action is
applied to a region.  It can be useful if some users want to make some
changes to the region before the scheme's action is applied, but there
is no such real usages.

On the other hand, calling it after the DAMOS action is applied can give
a chance to investigate what happened during applying the action to the
region.  Actually, followup commits will make and pass such information
to walk_fn().  Invoke walk_fn() after applying the action.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8540e8f91260..f7736df4f6c8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1214,7 +1214,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
  * finishes handling of the request.
  *
  * The kdamond executes the given function in the main loop, for each region
- * just before it applies any DAMOS actions of @ctx to it.  The invocation is
+ * just after it applied any DAMOS actions of @ctx to it.  The invocation is
  * made only within one &damos->apply_interval_us since damos_walk()
  * invocation, for each scheme.  The given callback function can hence safely
  * access the internal data of &struct damon_ctx and &struct damon_region that
@@ -1432,11 +1432,9 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
  * @r:		The region of @t that @s will be applied.
  * @s:		The scheme of @ctx that will be applied to @r.
  *
- * This function is called from kdamond whenever it found a region that
- * eligible to apply a DAMOS scheme's action.  If a DAMOS walk request is
- * installed by damos_walk() and its &damos_walk_control->walk_fn has not
- * invoked for the region for the last &damos->apply_interval_us interval,
- * invoke it.
+ * This function is called from kdamond whenever it asked the operation set to
+ * apply a DAMOS scheme action to a region.  If a DAMOS walk request is
+ * installed by damos_walk() and not yet uninstalled, invoke it.
  */
 static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
@@ -1457,8 +1455,8 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
  * @s:		A scheme of @ctx that all walks are now done.
  *
  * This function is called when kdamond finished applying the action of a DAMOS
- * scheme to regions that eligible for the given &damos->apply_interval_us.  If
- * every scheme of @ctx including @s now finished walking for at least one
+ * scheme to all regions that eligible for the given &damos->apply_interval_us.
+ * If every scheme of @ctx including @s now finished walking for at least one
  * &damos->apply_interval_us, this function makrs the handling of the given
  * DAMOS walk request is done, so that damos_walk() can wake up and return.
  */
@@ -1560,7 +1558,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (damos_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
-		damos_walk_call_walk(c, t, r, s);
 		if (c->callback.before_damos_apply)
 			err = c->callback.before_damos_apply(c, t, r, s);
 		if (!err) {
@@ -1569,6 +1566,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			sz_applied = c->ops.apply_scheme(c, t, r, s,
 					&sz_ops_filter_passed);
 		}
+		damos_walk_call_walk(c, t, r, s);
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-- 
2.39.5

