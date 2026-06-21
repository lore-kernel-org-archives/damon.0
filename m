Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84952DB78C;
	Sun, 21 Jun 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057455; cv=none; b=PLjhWGrAhjXVQfTbMU84GSc2BpGSVJAUNOvFHd23kgBYj/5i8DBwjKuK5SquMMgnpf0SlMPHStiRSCatPpGj3H6Dvw9wtsCsbMdAkBqBN2BpmbFc7qURrv4EqrP4FLWSPTqj15p0dwctwS8AbmIDedYjpiqnDwzSoJpZlf9EXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057455; c=relaxed/simple;
	bh=xLv2ZsPItWNa1Bd/DUb2pkZzsyLZff662HVFSw4ZoQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hw5sCFlUTj7Z+bKz/mPntLFqUgUgIhNGQrH/0+BIn4edYPkhg2e6akFDRwD07gttv3wL5aePwC34nAlkSDpz06lKfHliQsoQIMr3vvHqnO4CXI0DPBC3LeClyWqYNHX973iUJUnnH9+AvgGnHw4v4BibOV6fgj9h/ZLYy4KIWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMBje4RB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMBje4RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17111F00A3E;
	Sun, 21 Jun 2026 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057451;
	bh=nXiLtH+Zn2MRUp1wccyuIqHTYFDO5c0rsaJ6q0wXLp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BMBje4RB33lYb1mviROX82s8w7c/xoZi8s5NLWLxs5VcE1Iz8boP7n1ygFuS01NVB
	 XpxBSaPqDpWCiP1bQx2165TNpJzIQtHA7mpjt5X35LytEUJFGhp76aCmFS8miDg+73
	 ACY5jnpcE/IwmFzhja9q8ilO4EudnELunau5Nk2PCDE9Er4PR203UqoOEh0vV19UNP
	 Tam9EJDpWM0J0Qeo/9+LF+F+DTO+A62nk5dyPCjJJ0EKPz9w9XnfAnLBVymoS/5hG7
	 4aUEIIoILsbP+i8yAE8YbPLNasg1oVTEsp6zOoeKbA2f0+Z3tmUJpGURHY6lc3B2JS
	 IViLjaKo6s6yg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v1.2 05/17] mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
Date: Sun, 21 Jun 2026 08:57:01 -0700
Message-ID: <20260621155715.87932-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_mvsum() returns a value same to nr_accesses_bp.  Also
the function is more simple and therefore more tolerant to errors.
Execution of the function would be more expensive than the simple read
of the field, but because the function is quite simple, the overhead
should be negligible.  Use it in the DAMON region exporting trace points
instead of the nr_accesses_bp.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 8 +++++---
 mm/damon/core.c              | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 78388538acf44..8851727ae1627 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -78,9 +78,11 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
 		unsigned int target_idx, struct damon_region *r,
-		unsigned int nr_regions, bool do_trace),
+		unsigned int nr_accesses, unsigned int nr_regions,
+		bool do_trace),
 
-	TP_ARGS(context_idx, scheme_idx, target_idx, r, nr_regions, do_trace),
+	TP_ARGS(context_idx, scheme_idx, target_idx, r, nr_accesses,
+		nr_regions, do_trace),
 
 	TP_CONDITION(do_trace),
 
@@ -101,7 +103,7 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 		__entry->target_idx = target_idx;
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
-		__entry->nr_accesses = r->nr_accesses_bp / 10000;
+		__entry->nr_accesses = nr_accesses;
 		__entry->age = r->age;
 		__entry->nr_regions = nr_regions;
 	),
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8f845bf698b2d..91f137901e726 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2439,7 +2439,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct damos *siter;		/* schemes iterator */
 	unsigned int sidx = 0;
 	struct damon_target *titer;	/* targets iterator */
-	unsigned int tidx = 0;
+	unsigned int tidx = 0, nr_accesses = 0;
 	bool do_trace = false;
 
 	/* get indices for trace_damos_before_apply() */
@@ -2454,6 +2454,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 				break;
 			tidx++;
 		}
+		nr_accesses = damon_nr_accesses_mvsum(r, c);
 		do_trace = true;
 	}
 
@@ -2469,7 +2470,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (damos_core_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
-		trace_damos_before_apply(cidx, sidx, tidx, r,
+		trace_damos_before_apply(cidx, sidx, tidx, r, nr_accesses,
 				damon_nr_regions(t), do_trace);
 		sz_applied = c->ops.apply_scheme(c, t, r, s,
 				&sz_ops_filter_passed);
-- 
2.47.3
