Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DE1FDF
	for <damon@lists.linux.dev>; Mon, 11 Sep 2023 04:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D71C433CA;
	Mon, 11 Sep 2023 04:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694408352;
	bh=K9lgc7x4dZgenqq4OTRXq794HZJJ71R2FcZ9X3jYc3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8oSqJr6ToHgqtmreNWd7i9mI3hWW/YHUOWB3BBt6N5c0ltuTPl65Eol9sroTYQgj
	 WrWC/T7TWJJHaaVIS/jtkfPPZM1JZ3fy2MGI5wwyNPS39axeVXnQZGMhcupjt4KDZH
	 BbyG/QMXrLQkxsfkuODSQGBwws0vyt192WB3fWBWy8p35b96O8ER7MgOHQqGEBQWNV
	 TRen1RmVJcLD8rijpg2VDGiceZgWPttWeAT5tYxITsP9Fu9i1+8f077aAgsmBbDVvp
	 KzZ2Cscq1r/0XaINUrS+OlXnk6OWRUUaT64nZr9FwyHZmOTlHaAAp/WCuUh8LN3zBX
	 09mLr3nl0WOHA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date: Mon, 11 Sep 2023 04:59:07 +0000
Message-Id: <20230911045908.97649-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911045908.97649-1-sj@kernel.org>
References: <20230911045908.97649-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON provides damon_aggregated tracepoint, which exposes details of
each region and its access monitoring results.  It is useful for
getting whole monitoring results, e.g., for recording purposes.

For investigations of DAMOS, DAMON Sysfs interface provides DAMOS
statistics and tried_regions directory.  But, those provides only
statistics and snapshots.  If the scheme is frequently applied and if
the user needs to know every detail of DAMOS behavior, the
snapshot-based interface could be insufficient and expensive.

As a last resort, userspace users need to record the all monitoring
results via damon_aggregated tracepoint and simulate how DAMOS would
worked.  It is unnecessarily complicated.  DAMON kernel API users,
meanwhile, can do that easily via before_damos_apply() callback field of
'struct damon_callback', though.

Add a tracepoint that will be called just after before_damos_apply()
callback for more convenient investigations of DAMOS.  The tracepoint
exposes all details about each regions, similar to damon_aggregated
tracepoint.

Please note that DAMOS is currently not only for memory management but
also for query-like efficient monitoring results retrievals (when 'stat'
action is used).  Until now, only statistics or snapshots were
supported.  Addition of this tracepoint allows efficient full recording
of DAMOS-based filtered monitoring results.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 37 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              | 27 +++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 0b8d13bde17a..9e7b39495b05 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -9,6 +9,43 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(damos_before_apply,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		unsigned int target_idx, struct damon_region *r,
+		unsigned int nr_regions),
+
+	TP_ARGS(context_idx, target_idx, scheme_idx, r, nr_regions),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(unsigned long, target_idx)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+		__field(unsigned int, age)
+		__field(unsigned int, nr_regions)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->target_idx = target_idx;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+		__entry->age = r->age;
+		__entry->nr_regions = nr_regions;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u target_idx=%lu nr_regions=%u %lu-%lu: %u %u",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->target_idx, __entry->nr_regions,
+			__entry->start, __entry->end,
+			__entry->nr_accesses, __entry->age)
+);
+
 TRACE_EVENT(damon_aggregated,
 
 	TP_PROTO(unsigned int target_id, struct damon_region *r,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ca631dd88b33..aa7fbcdf7310 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -950,6 +950,28 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
 	int err = 0;
+	/*
+	 * We plan to support multiple context per kdamond, as DAMON sysfs
+	 * implies with 'nr_contexts' file.  Nevertheless, only single context
+	 * per kdamond is supported for now.  So, we can simply use '0' context
+	 * index here.
+	 */
+	unsigned int cidx = 0;
+	struct damos *siter;		/* schemes iterator */
+	unsigned int sidx = 0;
+	struct damon_target *titer;	/* targets iterator */
+	unsigned int tidx = 0;
+
+	damon_for_each_scheme(siter, c) {
+		if (siter == s)
+			break;
+		sidx++;
+	}
+	damon_for_each_target(titer, c) {
+		if (titer == t)
+			break;
+		tidx++;
+	}
 
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
@@ -964,8 +986,11 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		ktime_get_coarse_ts64(&begin);
 		if (c->callback.before_damos_apply)
 			err = c->callback.before_damos_apply(c, t, r, s);
-		if (!err)
+		if (!err) {
+			trace_damos_before_apply(cidx, sidx, tidx, r,
+					damon_nr_regions(t));
 			sz_applied = c->ops.apply_scheme(c, t, r, s);
+		}
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-- 
2.25.1

