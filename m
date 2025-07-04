Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3328983F;
	Fri,  4 Jul 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751667254; cv=none; b=dHidhJHHM4OR7xHlReX4Hwr5mKEfE9baqD5ABWY2WpfGaeOAof0HuaG/peeqd/4C3GduUFwGUiibkIxMu+2gSNHuS8hU4DgIEbKTZIVcVJi6taL7Hl+jjFvA9QAG3yO2kubEkeDLMKQemZGMINrGf9PEXJdt/C8ZYzWTN6mgwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751667254; c=relaxed/simple;
	bh=/5CFWtg/RaFEpwdd6ARNdP/CgJAOsslo+1EYnA8neGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3fbEWIvk36rnvNlrV+bub6vwFfqwq/o14CqGKGq+iAVa9GluKdKIdtmqYONZT224wEnTg0VC6iGRLTPEs16tf9nX90tKGNDE20CW+GyZ03e6QOt1e4G1e4+dPZqRLj9CGAPHfnOHoimXTy1RI/9l9bHdTOrudO50/PJjuLV7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwfi0RHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwfi0RHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DD1C4CEEE;
	Fri,  4 Jul 2025 22:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751667254;
	bh=/5CFWtg/RaFEpwdd6ARNdP/CgJAOsslo+1EYnA8neGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwfi0RHGn03WWT4i9KSEiakwBG1MOYOhRZkG0Q/MZ9Eg97vDwDDuCSTturpHTUOHl
	 8iGbD0MY0683tJkjAiuJdllNJpvM/E8s4GiuM3l3Q6fzxD6XyosNI5wFGTozg6qzr0
	 jzX4J9MPCbFkxDIgIWEfkACtXtXvlwPfs6ZW2WeJ+YlYySvcbuqrtTm3hLiNqEM94T
	 Rx5RezFD8TfAHMZdxSfOYUIfj7onCSEtNth5NYUiFJ/rY/WIooEtLt+7NacTr8PsCf
	 BfhYCZlPtmJZ4Km9Hu1hE/PtHQUB2RH+1dU0WXed0WIgvEnmZuKT5BNB6v6gJMbtyz
	 MfRgwwo9SVjuw==
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
Subject: [PATCH 1/2] mm/damon: add trace event for auto-tuned monitoring intervals
Date: Fri,  4 Jul 2025 15:14:07 -0700
Message-Id: <20250704221408.38510-2-sj@kernel.org>
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

Aim-oriented monitoring intervals auto-tuning is an important and
recommended feature for DAMON users.  Add a trace event for the
observability of the tuned intervals and tuning itself.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 17 +++++++++++++++++
 mm/damon/core.c              |  1 +
 2 files changed, 18 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index da4bd9fd1162..32c611076023 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -48,6 +48,23 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 			__entry->nr_accesses, __entry->age)
 );
 
+TRACE_EVENT(damon_monitor_intervals_tune,
+
+	TP_PROTO(unsigned long sample_us),
+
+	TP_ARGS(sample_us),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, sample_us)
+	),
+
+	TP_fast_assign(
+		__entry->sample_us = sample_us;
+	),
+
+	TP_printk("sample_us=%lu", __entry->sample_us)
+);
+
 TRACE_EVENT(damon_aggregated,
 
 	TP_PROTO(unsigned int target_id, struct damon_region *r,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 979b29e16ef4..57a1ace4d10d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1490,6 +1490,7 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
 			new_attrs.sample_interval);
 	new_attrs.aggr_interval = new_attrs.sample_interval *
 		c->attrs.aggr_samples;
+	trace_damon_monitor_intervals_tune(new_attrs.sample_interval);
 	damon_set_attrs(c, &new_attrs);
 }
 
-- 
2.39.5
