Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F71D7E5C;
	Fri,  4 Jul 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751667256; cv=none; b=mWmgGFpzINZsLPbAnTPY1MaPG+SchibbreVp+fjkNrWwXyMpjk/c9mjzC/hP+hr5RtOFJP0ZJLWnTvYfDXa4FZp2rjDHVhNg5lacXnS90kE3Nb39xxCVaf6zds6350yqZlKDwswwsdJ0w4mTYAtLMjB7s6Hq+YguUQ5apTsmkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751667256; c=relaxed/simple;
	bh=i4kVmwYYJvbGjW13oTsr6Z3ar3qE24r2fehpO6C3TQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jV1tX617ZRH1j4iwxdJfiDZ5KD3ZfpDfVMvFcRR6Crz1mZ9Kt+6k1Zagq4hk1NRC3qjiUcYNpJUK4OT4hSlpiuz8BBiPb6veZw6NcbJve6WvNFwxqHm9zgvedTZzIaOIHmaQtvshYR1BRVkSC7mBWfV454VMqw/525vSRgAn0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgAEPQBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgAEPQBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D502C4CEE3;
	Fri,  4 Jul 2025 22:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751667255;
	bh=i4kVmwYYJvbGjW13oTsr6Z3ar3qE24r2fehpO6C3TQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgAEPQBtRLpmCaGFxRT8Oo59TvtLlP2zpM0NfePZsyd0x4yCx3ffAzZI9kRC+q1jE
	 VuAxxRQOiV3tgom2qEq6ODaJZeB0jz+vqndDUU3jQ5WwmvDE1Rc2pC5uAJxhOYd94K
	 HI/s5iiw955ielbthQ7MHpS77IVEYtORmaI2indIDSC0bfW/pm1MYYzYwPEqxqhj0R
	 uakb6FmuJ9GBTq7zyCxsU3lG4jZ3VM7ZiU6PiKcfYpezRJb6fUiwE70PykLYXGeLuh
	 qsrMV/XNNveEfSZDy17DFMiqJyBXi9ZlhpkVAH9JKiII0quwI29nJgWNFH4oRaeIR7
	 F1fwTd267fZ6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon: add trace event for effective size quota
Date: Fri,  4 Jul 2025 15:14:08 -0700
Message-Id: <20250704221408.38510-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704221408.38510-1-sj@kernel.org>
References: <20250704221408.38510-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aim-oriented DAMOS quota auto-tuning is an important and recommended
feature for DAMOS users.  Add a trace event for the observability of the
tuned quota and tuning itself.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 26 ++++++++++++++++++++++++++
 mm/damon/core.c              | 20 +++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 32c611076023..36b2cdf47dce 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -9,6 +9,32 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT_CONDITION(damos_esz,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		unsigned long esz, bool do_trace),
+
+	TP_ARGS(context_idx, scheme_idx, esz, do_trace),
+
+	TP_CONDITION(do_trace),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(unsigned long, esz)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->esz = esz;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u esz=%lu",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->esz)
+);
+
 TRACE_EVENT_CONDITION(damos_before_apply,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 57a1ace4d10d..6019b8ec4bba 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2011,12 +2011,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	quota->esz = esz;
 }
 
+static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
+		struct damos_quota *quota)
+{
+	unsigned int cidx = 0, sidx;
+	struct damos *siter;
+
+	damon_for_each_scheme(siter, c) {
+		if (siter == s)
+			break;
+		sidx++;
+	}
+	trace_damos_esz(cidx, sidx, quota->esz, true);
+}
+
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long cumulated_sz;
+	unsigned long cumulated_sz, cached_esz;
 	unsigned int score, max_score = 0;
 
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
@@ -2030,7 +2044,11 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->total_charged_sz += quota->charged_sz;
 		quota->charged_from = jiffies;
 		quota->charged_sz = 0;
+		if (trace_damos_esz_enabled())
+			cached_esz = quota->esz;
 		damos_set_effective_quota(quota);
+		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
+			damos_trace_esz(c, s, quota);
 	}
 
 	if (!c->ops.get_scheme_score)
-- 
2.39.5
