Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1E3C5835;
	Tue, 12 May 2026 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596624; cv=none; b=FT3OzWTQGIjzslA12iJQ9Yv5LnLm7t5SrfxOpB1Ktmvk0KeXbOe50iWK+XCrlXlPGKpKrh0qInGronpLKZu1urS+JmKJWH4zOlZMJHGEKFjDpLmigitGYUhEtq0LjpiPbOBeJK/skDU+7Qw7tPCGfoA5FSKXeNojMSd0GvHbEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596624; c=relaxed/simple;
	bh=kbCsWU0mjnq37gAs52jkDtzKMzPSB8TXwCEtlj7DRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfIbdf//rwY5ZDvhqPgYsHZi1qe0XbYAaIGt3f46ipO9/zqLUeqrVPddjdC3AHsN+bzCQ7l9rG7EDNQhqFyffetcbS6TNbmGJc+n6GLJLJ0637eCx6lFuyfDYxV98QgTzIDnXz0dkNXt+E8jRqfZxKXtU6fUiDXYU/t/g+iELiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spSgCZBl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spSgCZBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF347C2BCF7;
	Tue, 12 May 2026 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596624;
	bh=kbCsWU0mjnq37gAs52jkDtzKMzPSB8TXwCEtlj7DRH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spSgCZBlv4Hw/H2wyZrkqs9weh8VNtljwJlInhjXMHp673abph/08TnrZHosupZl5
	 HRXgvXApLzfbzFhDrDX+TT6poh+nVz7hMM/IpOkO2h690KQqsPfJ+xoKDUB1Yf3uqI
	 zuU3zFXMDtcn1WU6O17k7dy3Liz3xcCFiiACcUWoPzZvf6arPSEkYuIQVQrq6NY0D/
	 5IbhcHhGzsb3QZv4BzpIPxPc4dORLDFo8kW066JPz9i08qlhJSObnhefma5HAVFVT/
	 iFbVG60r0Dznc2myihg9RO1m/LiOJRBvM+iuN69Kn5nMqxiwlYiJBJ0zZWSmxGU0ip
	 F1rH8Cj/gsphw==
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
Subject: [RFC PATCH v2 18/28] mm/damon: trace probe_hits
Date: Tue, 12 May 2026 07:36:33 -0700
Message-ID: <20260512143645.113201-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new tracepoint for exposing the per-region per-probe
positive sample count via tracefs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 7e25f4469b81b..d7b94c7640217 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -130,6 +130,42 @@ TRACE_EVENT(damon_monitor_intervals_tune,
 	TP_printk("sample_us=%lu", __entry->sample_us)
 );
 
+TRACE_EVENT(damon_aggregated_v2,
+
+	TP_PROTO(unsigned int target_id, struct damon_region *r,
+		unsigned int nr_regions, unsigned int nr_probes),
+
+	TP_ARGS(target_id, r, nr_regions, nr_probes),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, target_id)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_regions)
+		__field(unsigned int, nr_accesses)
+		__field(unsigned int, age)
+		__dynamic_array(unsigned char, probe_hits, nr_probes)
+	),
+
+	TP_fast_assign(
+		__entry->target_id = target_id;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_regions = nr_regions;
+		__entry->nr_accesses = r->nr_accesses;
+		__entry->age = r->age;
+		memcpy(__get_dynamic_array(probe_hits), r->probe_hits,
+			sizeof(*r->probe_hits) * nr_probes);
+	),
+
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u probe_hits=%s",
+			__entry->target_id, __entry->nr_regions,
+			__entry->start, __entry->end,
+			__entry->nr_accesses, __entry->age,
+			__print_hex(__get_dynamic_array(probe_hits),
+				__get_dynamic_array_len(probe_hits)))
+);
+
 TRACE_EVENT(damon_aggregated,
 
 	TP_PROTO(unsigned int target_id, struct damon_region *r,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fe6c789f2cecb..14b15c9876516 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1905,6 +1905,11 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	unsigned int ti = 0;	/* target's index */
+	unsigned int nr_probes = 0;
+	struct damon_probe *probe;
+
+	damon_for_each_probe(probe, c)
+		nr_probes++;
 
 	damon_for_each_target(t, c) {
 		struct damon_region *r;
@@ -1913,6 +1918,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			int i;
 
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			trace_damon_aggregated_v2(ti, r, damon_nr_regions(t),
+					nr_probes);
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
-- 
2.47.3
