Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B53806AD;
	Fri, 19 Jun 2026 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897677; cv=none; b=k2ieKruiq1KG2CtlFCYwv/YiSYtoMgEjrCn1YiiEbSe9rPAicD9m5geMwvAkvI4vPdrqX9oGEq9tm1pzi+HndHP9eGPXPJEtPjk2/Nhcn5j0fuEEZZ9BEsu0KGl1TSSZsmJPKCR1xQIm3jp4PXneTpN3VHXTSJnwmVPkjFp/N7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897677; c=relaxed/simple;
	bh=rCL2AQLQW0y0sdWTihLbuB4BOfFHXDQ1V7h+OSDh2XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DydrPtSsGt9p0oqgOngNeBmKFl/AQdxXGNyXOBdNydcTBqn6HnMQWyiRDu3dvLIAlQGGqWFI+0wysG6gsAGSATrqrdlXpCxltqrTfyP1toi5Pkk0PkwmjIedcSNAOlduoEO4zjoNt+LEJN8kMaKUIs+J09wxyqi0GJxi4PS7Vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUrKa3Iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUrKa3Iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9631F000E9;
	Fri, 19 Jun 2026 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897673;
	bh=wBCI0M4GDy8fMB32IVLMHZ/6Fxv+XePbw85r3F9bljU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUrKa3IvwiWu+Q9HsVwBmNvw1qkTmqkjo18eAC8ErsJS15u1kpGpSA5rsr2ZLmI9x
	 p7w+xO/u1LURKNAI7PT+cY5FrPl7+NeFZTnItmlkkpzaGUd2dxNu9RfL3GkvNBA2u1
	 khBeunR373+BGhtrMkLXYQjCp5X3cR/1+PZEFElOkHP6P/NAU14h+r7fvh9/kOTQgn
	 7L9oQnJS2Ecwjjabc2Oui7L5ppJo6CW4HiZKLD9y/LNDmSaLuch1x9mUx7P7/TGziD
	 9jYVErKePaabNjkrxzFjmZCBwxNHYSf6kF2KSOe4+Cqe/2/+9w7RxJ27OwgITNfIMR
	 5GCQG4D1y+diA==
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
Subject: [RFC PATCH 04/13] mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
Date: Fri, 19 Jun 2026 12:33:49 -0700
Message-ID: <20260619193415.73833-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
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
 mm/damon/core.c              | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

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
index 3a6df10ba8548..2eddf2674f4fa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2463,6 +2463,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			return;
 		ktime_get_coarse_ts64(&begin);
 		trace_damos_before_apply(cidx, sidx, tidx, r,
+				damon_nr_accesses_mvsum(r, c),
 				damon_nr_regions(t), do_trace);
 		sz_applied = c->ops.apply_scheme(c, t, r, s,
 				&sz_ops_filter_passed);
-- 
2.47.3
