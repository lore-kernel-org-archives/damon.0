Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E274271282;
	Wed, 26 Feb 2025 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551828; cv=none; b=BZrRC1AXhAQCL4qG9KrzFiC597ZFmv/U9dJAEZ5ovSxcy3gmZkACW4doueGm/bdrVyIlvGS8IbOFIjnp2RAi08km+MTKyIcP9HBh+8tKl9mTRZc+A4iXgPIeHTXGZ5CWGObVwX3pkNaj+UnE9n0OG5ZRuJl2rBgtP2aOakjKZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551828; c=relaxed/simple;
	bh=0JELExNnHyeZjbeP5ZoxjubmzZrKIkH6IvMexJsNwbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyOiPsCVPWDnIq73RUN4X9lE2L34k84Z4jvBLg6w4qb750QZrb0Ycvkb02/VanQZmru2AWelssM3Ko8vQay/ci7etsb/x7iWPEnHKm4rXniCuh/SjrY6FoExTb/T9Db1KIV4GPAk7ZNMd12QgUlQM2k78WXTtrGEAg0Bj1JyR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG7uDphF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG7uDphF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29484C4CED6;
	Wed, 26 Feb 2025 06:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551828;
	bh=0JELExNnHyeZjbeP5ZoxjubmzZrKIkH6IvMexJsNwbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pG7uDphFQhxUNLwpk3/l2bizP+t02fv/8iSWqdIx3jv5WH+6lNDCOI7SFur64oCT8
	 J74ndxyjuJMt7aHCM4EyDV3q0OwVWBneiXZQkCfslrPhaqeVCkFu/1WAMRxkMiHOOM
	 SQChpQWk/q96/Fu+jSgqmBINCXbmOKuQYvAUM2fWwirYqQmZY5cJWRpAa7sDK4Ios7
	 2RIt1aw29LGdueGRMwQRPSuo741vZsF8C1QCw3tJbhzVA7U2n+ACJNOgSTd7V8Ctl+
	 q9YQpLx8CUfcQ2+O2B4lMv88KXkZkBiXwvFz0OieBicaTO7zO0JYI+vT8MxAMsIi/P
	 nO/Kos09Tn5lQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 12/13] mm/damon: remove damon_callback->before_damos_apply
Date: Tue, 25 Feb 2025 22:36:50 -0800
Message-Id: <20250226063651.513178-13-sj@kernel.org>
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

The hook was introduced to let DAMON kernel API users access DAMOS
schemes-eligible regions in a safe way.  Now it is no more used by
anyone, and the functionality is provided in a better way by
damos_walk().  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  5 -----
 mm/damon/core.c       | 13 ++++---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c9abacf16d88..2808ea07e1cc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -600,7 +600,6 @@ struct damon_operations {
  *
  * @after_wmarks_check:	Called after each schemes' watermarks check.
  * @after_aggregation:	Called after each aggregation.
- * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
  *
  * The monitoring thread (&damon_ctx.kdamond) calls @before_terminate just
@@ -621,10 +620,6 @@ struct damon_operations {
 struct damon_callback {
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
-	int (*before_damos_apply)(struct damon_ctx *context,
-			struct damon_target *target,
-			struct damon_region *region,
-			struct damos *scheme);
 	void (*before_terminate)(struct damon_ctx *context);
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 14e4122464a1..22f90666fe16 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1723,7 +1723,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
 	unsigned long sz_ops_filter_passed = 0;
-	int err = 0;
 	/*
 	 * We plan to support multiple context per kdamond, as DAMON sysfs
 	 * implies with 'nr_contexts' file.  Nevertheless, only single context
@@ -1763,14 +1762,10 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (damos_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
-		if (c->callback.before_damos_apply)
-			err = c->callback.before_damos_apply(c, t, r, s);
-		if (!err) {
-			trace_damos_before_apply(cidx, sidx, tidx, r,
-					damon_nr_regions(t), do_trace);
-			sz_applied = c->ops.apply_scheme(c, t, r, s,
-					&sz_ops_filter_passed);
-		}
+		trace_damos_before_apply(cidx, sidx, tidx, r,
+				damon_nr_regions(t), do_trace);
+		sz_applied = c->ops.apply_scheme(c, t, r, s,
+				&sz_ops_filter_passed);
 		damos_walk_call_walk(c, t, r, s, sz_ops_filter_passed);
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
-- 
2.39.5
