Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A13351C0C;
	Mon, 18 May 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147690; cv=none; b=nQOgqN0IpfxO4Lb8xdMVzWfDNGqTNw6jl/ypK72E1Cc8hvzsqfpOgzRH0kHwUCZaKicKImh0KO0cPoMdCdL/GBkEmT0r4IEB1cs+g0V9Zo6OD2JmO3p0ntS3vFl7qWhP5GtLEczTyRVtnZjdjhRa0MINqAtZlTZle561qQWUSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147690; c=relaxed/simple;
	bh=oi/JcE35e0BkzNgUR9uyr6y/BZqSFxdfd3cKlzhvFvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbSCrInWZ/QpCeZTBv0IjOHhDy+E4hKpQnXt9v2vHVljgz3VAKFV563FCZ/tIVjq/X4Tud3zYWE2bI8z9lfmRctR1NdpF/O83ivyanE3JyjkOihA6n9VL+9vhEnB50ba9IQW4yDmzs/f8HD/QXSOE2PQ36hrUGDwc65x2EMthUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPuKh+sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPuKh+sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D0EC2BCF6;
	Mon, 18 May 2026 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147690;
	bh=oi/JcE35e0BkzNgUR9uyr6y/BZqSFxdfd3cKlzhvFvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPuKh+sfRjGLW/nvTDitPAIw3lLZyXsSmvIzv4jkG6j5f2mhGzq50UVbZ8zELzgsI
	 ydxwT4tUwTYrmkVtqAKm9VhqZxZjEq1fYn/pZi0UxjeY2y6XzT6BTft0sLxvHxhFZy
	 Jk+qq8C9LAJ06MZ+WehePbeI/4xcRDffel7hdE4ZgLHi/e60FRqpQkvaKPZI0jSfPE
	 eSpWwEHe0VWNjpJFkXUvgQddPfIBbVSML/9IiCgsRW3AVqSjFi0lvCDGnA5A9X//PP
	 8hewp/LLn1WxCQ4/2yBzmhr+Cj9U2yq1Pxyel1/Vq3MVqB4A+4b6YS5DG3Y6UKrsOt
	 6sn7E7PZgRiPQ==
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
Subject: [PATCH 18/28] mm/damon: trace probe_hits
Date: Mon, 18 May 2026 16:41:06 -0700
Message-ID: <20260518234119.97569-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
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
 include/trace/events/damon.h | 38 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              |  9 +++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 7e25f4469b81b..78388538acf44 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -130,6 +130,44 @@ TRACE_EVENT(damon_monitor_intervals_tune,
 	TP_printk("sample_us=%lu", __entry->sample_us)
 );
 
+TRACE_EVENT_CONDITION(damon_region_aggregated,
+
+	TP_PROTO(unsigned int target_id, struct damon_region *r,
+		unsigned int nr_regions, unsigned int nr_probes),
+
+	TP_ARGS(target_id, r, nr_regions, nr_probes),
+
+	TP_CONDITION(nr_probes > 0),
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
index 433da8781e255..5ba7ad4df4351 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1908,6 +1908,13 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	unsigned int ti = 0;	/* target's index */
+	unsigned int nr_probes = 0;
+	struct damon_probe *probe;
+
+	if (trace_damon_region_aggregated_enabled()) {
+		damon_for_each_probe(probe, c)
+			nr_probes++;
+	}
 
 	damon_for_each_target(t, c) {
 		struct damon_region *r;
@@ -1916,6 +1923,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			int i;
 
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			trace_damon_region_aggregated(ti, r,
+					damon_nr_regions(t), nr_probes);
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
-- 
2.47.3
