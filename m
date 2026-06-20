Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98F330D29;
	Sat, 20 Jun 2026 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976181; cv=none; b=lvMl1NoHLgcaJK//suGHpFZNv9aK0a5sZ2KbKCMAp0SZN4T14+Wp7lgAJ5yjBlflgcjTqoKY8fsmi1gSq8XJPM7xkyvAuiibDDEPD7U4NsCufZJQnehk6C3JzFtB84nkpU+QibyEYB0zlC0bt1MR8iYFWCoVpuKkjuE+drC+qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976181; c=relaxed/simple;
	bh=BTnUCNY6QHuEbteXrLAhZ6Igim07NuyYpi9bb25eE2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbYd1XP8MumK+3C8iEDcBrNqoWD0+jklFb0ajExpA6EwmjvPgFNhRXw3/CEhf9KWmQVxDh+KF+rcuO2YDHr97gpWcseBMJ6WxrXQPe1xczUYbx4hz6rIl9v2YhVJB+7Pqf7dunHOC+Oq38liDzfcDao0V4YU6vNLOVUlY7Gm2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaZRgqH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaZRgqH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6361F000E9;
	Sat, 20 Jun 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976179;
	bh=VQ9tcQmAH5LACFHL/fzQkhDxMQKAnhPo6ksNR/v/d70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BaZRgqH3IvDG20Sb4Hu/dcRr0wUFCte532/LnaNz9hQjKqtvEHJjJ1tMSjSp4Sd7A
	 COP7pwGFEujL3BSbDA9BPIaW1ySIgxx6rgigudCBaM2rIHlmna2IaIEDvb5/fwI04n
	 rBqOZtMS3Lm19VoaIJ3zi9W8atG/L7vimE8ggoX8IZl/YaEpXsEB0A4BqrYvWc3WHf
	 sWOdZlj4TowXfNQXKJe+/IsKTAmJluBo+5btL4AlJleZwTogtiBKIF+d8cdu2Eee4t
	 v4G+VnULq/SUgqzm7h1dVIk+ZKv17w5nc4dLf0RBaEy6vjjCGG0Twp9ZhHE5sgycQZ
	 WOddIOusudCYQ==
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
Subject: [RFC PATCH v1.1 04/13] mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
Date: Sat, 20 Jun 2026 10:22:34 -0700
Message-ID: <20260620172244.90953-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
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
index ce0e2a4c1d523..710ec13e98281 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2434,7 +2434,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct damos *siter;		/* schemes iterator */
 	unsigned int sidx = 0;
 	struct damon_target *titer;	/* targets iterator */
-	unsigned int tidx = 0;
+	unsigned int tidx = 0, nr_accesses = 0;
 	bool do_trace = false;
 
 	/* get indices for trace_damos_before_apply() */
@@ -2449,6 +2449,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 				break;
 			tidx++;
 		}
+		nr_accesses = damon_nr_accesses_mvsum(r, c);
 		do_trace = true;
 	}
 
@@ -2464,7 +2465,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
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
