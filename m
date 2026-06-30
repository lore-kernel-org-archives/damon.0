Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705C3DCDA2;
	Tue, 30 Jun 2026 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792507; cv=none; b=b4bJ20P8JQurm8ajrdlvq0CZCOAOp2Pn15ToasgztkYVW01JCC8ZyDgWzHRLaffUkMvK9Grz7nxNMfFwjpBekOvVJmap4dRqAfpKDVuqDklLv598VDW/CJufCGxPpgD26S4U09NIfqZpqNEURz5PcZxT2APjmGu/4HrCGfunv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792507; c=relaxed/simple;
	bh=NdfqHmuFvUTbKmH+z4m8qTmycgi66M1SiKXAm6lkGMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ7exR1jf/w4Yt+o/faTQkgFXdZRHZkJIxJGv9mamPEH8qnKraf78pWr9Xw0DZQ6OmF4cVdLe3wAe88AWKgKLupDN3GvufnWIk8NlSbX9A3w0fFXt5US5qAX43ZPfZiL97mPuj+5fMVkOtdKkfL+LcGNQuCxdw0/7qXPlngPDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+0Jv1tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+0Jv1tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD521F00A3A;
	Tue, 30 Jun 2026 04:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792506;
	bh=ml7y0LvVhQqERVNHIB3ApkqZyRkL9+NFf2FisR6UbJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+0Jv1tMNOwwWRJ+FwBMPxmFvYvnd7TIKabeliF2famUim5vqBZQ8Q1j47gOLNYNp
	 iUdL9jhyoqsGir+hPD1EgW41cvoWcf7iR2u+p9HTbQNSGOoZU7RZpsbCn3M0IkbXEb
	 TZ6bK+wq2Z17kVPdu4GKlnoghfl7rgrZXJp5OJQWsomGo6bM8ZzSMkwXD+ZWrgop/D
	 IBRBSiMZD2CWtvNTjVoPfdMxY7UFQN7OMg0Of55v+5bpCRl3/a6mBdmG7ArtyZakT6
	 0QR+a6RC9pgc3+yPLmy/XDwoZvdxWPbQbQ8+MQeA5/O7hdz8oQGh58iETPNHfRhzOP
	 g3AGnwHZqvCBg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 06/18] mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
Date: Mon, 29 Jun 2026 21:07:59 -0700
Message-ID: <20260630040812.149729-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
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
index 612762490e866..6423e7417c24b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2446,7 +2446,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct damos *siter;		/* schemes iterator */
 	unsigned int sidx = 0;
 	struct damon_target *titer;	/* targets iterator */
-	unsigned int tidx = 0;
+	unsigned int tidx = 0, nr_accesses = 0;
 	bool do_trace = false;
 
 	/* get indices for trace_damos_before_apply() */
@@ -2461,6 +2461,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 				break;
 			tidx++;
 		}
+		nr_accesses = damon_nr_accesses_mvsum(r, c);
 		do_trace = true;
 	}
 
@@ -2476,7 +2477,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
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
