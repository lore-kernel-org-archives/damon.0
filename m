Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6243148D3;
	Sun, 26 Apr 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236760; cv=none; b=JIODRI0Svsp/sOr15Wn0sJhWx44V+Zd9zt++s9SaDj7ElzNU9KJwDb0NmU6Yf6WQSyDcIigRJTHYIzBjACvL9P/OB+NLwgsW0H/gnMSwKDQVX/oNlX/sjJQKsf0usMdYPbsj3vVtZa+UBCcrp1Z23n9E483mx2MtqLKsDq+HIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236760; c=relaxed/simple;
	bh=+a7yddQciqqedy5ZtwOx7GN0gf1QkvZ1siaztRsfHgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTXcZ3hOxt5+crOAFBvDmUWmi74ts8j2T7ghtQGYU165NHJz+MnfFgaotm55sFr/RZQ16XZ9qT8QjZ8JS2IumgC6+J1wiR9eLf5GlcIxq4KDmUioOuJnfCAHFbYULfXEzBJQYBJx3GShLNRYSkAnoEgugtJByC6xOZc+Drt7tDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XueNJUqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XueNJUqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18EC2BCB9;
	Sun, 26 Apr 2026 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236760;
	bh=+a7yddQciqqedy5ZtwOx7GN0gf1QkvZ1siaztRsfHgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XueNJUqJZxVOF0+nCu81W73Mun0zKB4VqEyoU8g4s5CAtrjiTruK9zvTirpu4L8cJ
	 jBBt/Evy/xW27IQjHPwK49MHrkWVWLb+jkvgXH/bdIK9UON6ceLjLnrjG0X6QUKxdD
	 PmLFt0zBMdWppzB8Pgc8QXExTy4exESNBfaWrxNo2vLjfifc1XznkA7lg3MYou2edR
	 rULL3h6aQbqYiLlveadLZsukd7kQyGQMtVk6YQWnirRHV9PFfqJa6YxJUkahzYfh9f
	 wzhQhh5ypTUQ3UP7s0cdmKfiTg93GOEdrJVKoTYCFtGCJm9tcU3J9M5Zzkj0jCpnPd
	 95hpqoQGgQUuA==
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
Subject: [RFC PATCH 16/19] mm/damon: trace probe_hits
Date: Sun, 26 Apr 2026 13:52:17 -0700
Message-ID: <20260426205222.93895-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
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
 include/trace/events/damon.h | 41 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              |  1 +
 2 files changed, 42 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 7e25f4469b81b..121d7bc3a2c27 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -130,6 +130,47 @@ TRACE_EVENT(damon_monitor_intervals_tune,
 	TP_printk("sample_us=%lu", __entry->sample_us)
 );
 
+TRACE_EVENT(damon_aggregated_v2,
+
+	TP_PROTO(unsigned int target_id, struct damon_region *r,
+		unsigned int nr_regions),
+
+	TP_ARGS(target_id, r, nr_regions),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, target_id)
+		__field(unsigned int, nr_regions)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+		__field(unsigned int, age)
+		__field(unsigned char, probe_hit0)
+		__field(unsigned char, probe_hit1)
+		__field(unsigned char, probe_hit2)
+		__field(unsigned char, probe_hit3)
+	),
+
+	TP_fast_assign(
+		__entry->target_id = target_id;
+		__entry->nr_regions = nr_regions;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+		__entry->age = r->age;
+		__entry->probe_hit0 = r->probe_hits[0];
+		__entry->probe_hit1 = r->probe_hits[1];
+		__entry->probe_hit2 = r->probe_hits[2];
+		__entry->probe_hit3 = r->probe_hits[3];
+	),
+
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u %hhu %hhu %hhu %hhu",
+			__entry->target_id, __entry->nr_regions,
+			__entry->start, __entry->end,
+			__entry->nr_accesses, __entry->age,
+			__entry->probe_hit0, __entry->probe_hit1,
+			__entry->probe_hit2, __entry->probe_hit3)
+);
+
 TRACE_EVENT(damon_aggregated,
 
 	TP_PROTO(unsigned int target_id, struct damon_region *r,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fe14971d72747..54834b74efef4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1924,6 +1924,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			int i;
 
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			trace_damon_aggregated_v2(ti, r, damon_nr_regions(t));
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
-- 
2.47.3
