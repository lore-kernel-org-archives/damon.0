Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482B345CC7;
	Tue, 16 Dec 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872126; cv=none; b=B6gvJjkTrUSEjPfxV7+pBe6ctI1f5/ycmWCxRxw/mPdFjNpsmzcHnw+D+SWzbladn3IuJYHpVOndMAg3R+tSnWj1iz2BatcKn4dHdyHWVYN4I+V4K620FUoBmVsJMO0FSsnqodCvINj81jsE+ZJBmN1FjFvmlOgTSRmPZT18gbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872126; c=relaxed/simple;
	bh=UYABSgwRGNA1IWS8REj5rib/2rvNak+2C8vgI6LoV8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp18okNhIaRLcYrykOH8gOR6yBsBo/v9gNIho+8XA9JtYCJkh8cFWXRgmw5E22VO2Z623GFMAr9HZjGj7cGiYNPJGG2kbYij07VwjG0U6xUcIAsZqkgscUH//fLJN/xfa4aiLc4SeoAXCCNZqoI8ZYhXAOIAckiO7f4+Qfa0mTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiWaYlDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiWaYlDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E6AC113D0;
	Tue, 16 Dec 2025 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872125;
	bh=UYABSgwRGNA1IWS8REj5rib/2rvNak+2C8vgI6LoV8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiWaYlDd5Ydpl3Fdoh6hNRSX4IIqyP1tMJTKMFAIBbhSq7b/kZO0WM1EwS/8d5h2k
	 0FaQ3b495L08nxbjgFYMklrV6IEiQUT7MHMx2eSWmEKkhKduhVPjMJS/2IEbPLUs8e
	 c7hNfBFezqp0gEjMEaJCi+7hxBiyEvF5GgYZC8jLMMwBCxrXhFj9mOAUIAat55lo4T
	 FbJe81yWXQbMQcpKD3CCUKkmYKJOCJ//rVEYhs60amSrL5c95DBaKSp/3R1UaXsWib
	 mZWA19JgWS6ISxh1jLy/9lz9OtXMnHEz3v5so8OUJ2UXJGk+5qd2bjHhreUHGm8U1W
	 u6eG0yfCi7j4w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 12/12] mm/damon/core: add trace point for damos stat per apply interval
Date: Tue, 16 Dec 2025 00:01:25 -0800
Message-ID: <20251216080128.42991-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON users can read DAMOS stats via DAMON sysfs interface.  It enables
efficient, simple and flexible usages of the stats.  Especially for
systems not having advanced tools like perf or bpftrace, that can be
useful.  But if the advanced tools are available, exposing the stats via
tracepoint can reduce unnecessary reimplementation of the wheels.  Add a
new tracepoint for DAMOS stats, namely damos_stat_after_apply_interval.
The tracepoint is triggered for each scheme's apply interval and exposes
the whole stat values.  If the user needs sub-apply interval information
for any chance, damos_before_apply tracepoint could be used.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 41 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              | 17 +++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 852d725afea2..24fc402ab3c8 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -9,6 +9,47 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(damos_stat_after_apply_interval,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		struct damos_stat *stat),
+
+	TP_ARGS(context_idx, scheme_idx, stat),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(unsigned long, nr_tried)
+		__field(unsigned long, sz_tried)
+		__field(unsigned long, nr_applied)
+		__field(unsigned long, sz_applied)
+		__field(unsigned long, sz_ops_filter_passed)
+		__field(unsigned long, qt_exceeds)
+		__field(unsigned long, nr_snapshots)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->nr_tried = stat->nr_tried;
+		__entry->sz_tried = stat->sz_tried;
+		__entry->nr_applied = stat->nr_applied;
+		__entry->sz_applied = stat->sz_applied;
+		__entry->sz_ops_filter_passed = stat->sz_ops_filter_passed;
+		__entry->qt_exceeds = stat->qt_exceeds;
+		__entry->nr_snapshots = stat->nr_snapshots;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
+			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
+			"qt_exceeds=%lu nr_snapshots=%lu",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->nr_tried, __entry->sz_tried,
+			__entry->nr_applied, __entry->sz_applied,
+			__entry->sz_ops_filter_passed, __entry->qt_exceeds,
+			__entry->nr_snapshots)
+);
+
 TRACE_EVENT(damos_esz,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8908aec6670f..68dd2f7acba2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2256,6 +2256,22 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	quota->min_score = score;
 }
 
+static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
+{
+	unsigned int cidx = 0, sidx = 0;
+	struct damos *siter;
+
+	if (!trace_damos_stat_after_apply_interval_enabled())
+		return;
+
+	damon_for_each_scheme(siter, c) {
+		if (siter == s)
+			break;
+		sidx++;
+	}
+	trace_damos_stat_after_apply_interval(cidx, sidx, &s->stat);
+}
+
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
@@ -2297,6 +2313,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
 		s->last_applied = NULL;
+		damos_trace_stat(c, s);
 	}
 	mutex_unlock(&c->walk_control_lock);
 }
-- 
2.47.3
