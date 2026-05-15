Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1A36BCF5;
	Fri, 15 May 2026 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805896; cv=none; b=fQRwNnq5Bx04l/Ho/JJqm+SsWmdCqEC4WH4oP2Ed4trFK6yIT51kr8gmW064j2sWOnIfnGDKNG9i2L2+SRcR6Hgnnivw6FyfBDHLn5izaMrk2a9OTepIR1WsxGGB5l53r+trvbi0OHQMtUIjcvu0kAR1H6IrWG4CDG1a5BlZlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805896; c=relaxed/simple;
	bh=O6Hl0Mh7Nxw8m7P+hZlG7JicrW7ipkVD+m8lBYL3rME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgLlEohmWhrPeYZIXKLuKS2OJDHjUmSyU8+1Un7NyO3lQYCDvt8+KXnF4uYLn+9/YPgLERF328BnIzM4//+3NzXGzpMBaAT79LYMTayVv0sjk6197PDtMv4pvnYmf1iUojnAqLXTUL9hEhKp/EQOO405AgEmgBKehEf5FRzxwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwg9Kxxy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwg9Kxxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7233AC2BCB3;
	Fri, 15 May 2026 00:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805893;
	bh=O6Hl0Mh7Nxw8m7P+hZlG7JicrW7ipkVD+m8lBYL3rME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jwg9Kxxyp5SiFWyPel8l0mDAk7ys3Acb2RUOzTSm9Zbjp0NCywgHIm0e71oWxPoOa
	 /MR06AYDIZMsnHne9/DRPkuwuIKS+i1bAOFv9boEKqLPy+p65t0GVhg3QCMY6bZxcr
	 mvtkEB4O3u42wydFD1ryEEzGi9t/fEMeJ9yEittT+Klo7hbpWqmqo1zJiiyijvFHT9
	 IzsP4ozltwnkSolKLVlg15pg88U+q7O/a9VSFFL+A3aAKbcpPF8QzbrR/leL44Rhm7
	 MmIIX+8XH/RXkeUSV1+Iwp5VNeAiiOGhU2MmEItoI98Mt56V5TULNeFXQujxRlbA5a
	 qoTB6HGcFM/lg==
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
Subject: [RFC PATCH v2.2 18/28] mm/damon: trace probe_hits
Date: Thu, 14 May 2026 17:44:19 -0700
Message-ID: <20260515004433.128933-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index 24fc402ab3c85..ec1e317923fd3 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -130,6 +130,44 @@ TRACE_EVENT(damon_monitor_intervals_tune,
 	TP_printk("sample_us=%lu", __entry->sample_us)
 );
 
+TRACE_EVENT_CONDITION(damon_aggregated_v2,
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
index 1c9d2fb69f98d..ab8ac9ec8450d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1881,6 +1881,13 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	unsigned int ti = 0;	/* target's index */
+	unsigned int nr_probes = 0;
+	struct damon_probe *probe;
+
+	if (trace_damon_aggregated_v2_enabled()) {
+		damon_for_each_probe(probe, c)
+			nr_probes++;
+	}
 
 	damon_for_each_target(t, c) {
 		struct damon_region *r;
@@ -1889,6 +1896,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			int i;
 
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			trace_damon_aggregated_v2(ti, r, damon_nr_regions(t),
+					nr_probes);
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
-- 
2.47.3
