Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B522780E6;
	Thu,  6 Mar 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283971; cv=none; b=uomG3EPSsaTK9XlEsyJR2J0y2ewsptAUjyS/uOsSRG3rTJWbWLE4/MY4FhUOQvF5028XXHG01Op8M9XjnSVxh8SySoSEjDAs+dg+rxRxS/DoX7uUOfUTl3sm6OIfbOG8znK3KseF2E5IOjUEWOeQ5A7FKeAebZpzvQFG046p0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283971; c=relaxed/simple;
	bh=QHuacpUAdZsjxvC6RVrkNf1AvYwnsyKAd7KvFaeWUTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfSoThKORySf7nMsUhKnKcXbMOXUd4L9BxqCwkakWBQgF971iH1LlY4qf2CcyWRdTDl0PIxPeKJudcDhI4Pcbt0Hp+vrWGxkXA3utbsE49zFaYYpOEJEy/GEFVdw9zgglRBtD3Si0Fm4R/GrEz3dsc4O3ozdhn0m5S00RuhJi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk3x0+u4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk3x0+u4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAEAC4CEE8;
	Thu,  6 Mar 2025 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283969;
	bh=QHuacpUAdZsjxvC6RVrkNf1AvYwnsyKAd7KvFaeWUTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sk3x0+u4ZcspuwW/TvqCwEpHahJE8ZVI25fbwQsbquSG42WFrMto0jBxMQxX0igvi
	 1jZHAa8jDMwg3U60RsOYxGmdAo7yFx9Y7f5NBx+WMFILCvhl/WgabpvPfI+KY9PZiT
	 dA7wyZ6xfhjD6x3JJg8n643rVm26DxgS+xtQnBwYLRHCSdYSTloha9kmSxomVWg54x
	 Q19q6sw4KIw4dKyoLqU94Gp9mEVkAieXW6kKFgIn1Gk+EFmk2t8sTH7w5GThOTqkgr
	 BkiaP/5lOMx9kAq8uwLj8LUWn43Nl3RcV28Rc0VN1jW4R5LDkNlQkHR0T6oyJo8L6Z
	 NajMWp8fAR+UQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/13] mm/damon: remove damon_callback->before_damos_apply
Date: Thu,  6 Mar 2025 09:59:07 -0800
Message-Id: <20250306175908.66300-13-sj@kernel.org>
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
index 5aa277f4c948..be7b281fb922 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -605,7 +605,6 @@ struct damon_operations {
  *
  * @after_wmarks_check:	Called after each schemes' watermarks check.
  * @after_aggregation:	Called after each aggregation.
- * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
  *
  * The monitoring thread (&damon_ctx.kdamond) calls @before_terminate just
@@ -626,10 +625,6 @@ struct damon_operations {
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
index 726e581904e5..d6271fae4dd4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1731,7 +1731,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
 	unsigned long sz_ops_filter_passed = 0;
-	int err = 0;
 	/*
 	 * We plan to support multiple context per kdamond, as DAMON sysfs
 	 * implies with 'nr_contexts' file.  Nevertheless, only single context
@@ -1771,14 +1770,10 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
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
