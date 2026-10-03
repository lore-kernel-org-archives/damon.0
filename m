Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05333D6FD
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059253; cv=none; b=GkMWF9k5L9NulDsDRgRuGd6VvAMdwMYE7XEdV+Y5+rQsMClQEM94a2K9cLsSns+Z94ZkySwrV6qGL303aqcq9jIdySALhAr4oxLG1dBHLRjnJ8adotw+Bb+14Q16UOaighs1akPifs4QYnMh9wKp7zb0YykUZg5yIvSm0oMQszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059253; c=relaxed/simple;
	bh=qw1YGHR5szNuGFQTU6mwuicpfah1VyNrKo4cH5Yu2Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gd9gD5KIgS8sOIrox37QVALQJfKk58TGynRaMgdbhh8kWYlQDhAX/5Is3f4LGFEqwmaLrM9Ss3o8IUndnljLwV8fdatgGZgTjvH4mvOCt5Yh1p5vkzYJxqATRCXmnmaG6ue1VPVn4h3d6NsH+FCM9AgXyrjdrK1v7ZeVwmgGxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2eyw3Ty; arc=none smtp.client-ip=74.125.224.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2eyw3Ty"
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8949fcc5ea0so797917b3.0
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791059251; x=1791664051; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdO1qiLDUurZfNdh4Bo7wDLkgu1IWEB9hS1GOH9sv2Y=;
        b=D2eyw3Ty7DQcJ+0MNJFmmY7Xx9amb8WfEgqaREYsK31W7/Z7tA49Q9FHKxzKL53r6B
         0Eo9NkXJxHAkY8JsrmMdXCCgi4Jxsom8evoyjwr2kFdX/ml8hJNYjrUQ/po3kQOkMr0T
         RK57LJD7uUD8b+BWwJA4qWZZJka7cJShXp2jxgNudIcIhUKMBBI70FtRHb/TVhZtZ9kN
         jR3ZmJnYDM+2z2qZRdp25iYw7DIzPDRPB77Kp2bcg26VEwh+CW4Q7HSRI2haBJWlmKG6
         fAJoO4OQYuXVbxStlxcGi5TYlwUIovRXcPBQtq5urDu5gXlLQm3SxEPAFitH9Qtb4Prq
         YrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791059251; x=1791664051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdO1qiLDUurZfNdh4Bo7wDLkgu1IWEB9hS1GOH9sv2Y=;
        b=Yf+oU+a7tEKsU6Fx9HwGbSD1Vf9ClmZ3glqa2q1MjntofYaAV1OobWx9+p8PmQYlPP
         SZvsy2yq5SUHa7B1Xulw7FSQO+HMmC1N42gFBVpUMIjfUKcUh5Lyc4Rfl3kxXEkESPGZ
         n36J540ydgA6W3Pdr9sw+RXeifF1tQtwz/XwKpo4BA3tAW2Uq+lF2yPBa3M1sLPdKCm+
         pmIrPS90Y2Nb9o/PlbplJitvSJNniVeHjaPwap8m/ibCuR31VR/pWDsej7MPLk4w2L4U
         HCYcVHJyzNOJTLWB+vMEoE29SXFQ2Z0e4+aAfWCZIrt5bVuQPmuNOnBLep6nQspeiqQP
         9uYw==
X-Forwarded-Encrypted: i=1; AKwUvBxhxKqsIiUbyBDxZ44Wiqltm4is7cYNSk7m0xHegFsq8C221LMCr7d37yKcxF9/qfyqBmYfkQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLEgkTjkzn7XSiZHrKqy5K5X3fib77cPd2ulLU9yhpIZApt4EDk
	q8FH39kPo2kBghayg9347yensCAOtJsDhssio4KVm1DBenzrrk4v5b8=
X-Gm-Gg: AYBFou2KJTwqpBzoJpVNHlYiXlJTQkeKxJHK0dtoNRyQ0Fh0GSstM+ViyxPKZqbGWri
	EeMRsmi32qPHRmaolEY0FIJtuVkBK3NkxqeaiLpgi69eoYHI/f03Led8PE4Knz/60xPfb/A1pL7
	YQsE4FkP8MckIfbVQry3HXs2eINb0kzaGxZE5kZfO0YKTkTUO49lbeuqBA1Icc+3wJJ7SZE9N/A
	AgZOlTHmBIbIxQ9Pv852kV6JNlplCPSzPnulq83BWPeJhGZ0N/9V7WhVtvbUTV3Pc3Aflk77GYB
	pW84Fo8N4doYYBVOzGv1FyDZ6ndwb8O9Fv+/hEEFEhoeNYNGGkZV8Z5g+V1pS4mJGuY0osUIHb3
	WTFHJOtJ3ABXT4DYRlaW+uRNvE1EpWoF0QgE7h4yca7zrYBDG7hag0yeLb3YfGAcDDiOmxR8ms4
	nonmEAxfjn+KUIEIC0cUj+ib5mEwePYZdAoKwiX1KD4+byZsL/wNrHotPTwezw4AZx3bV75ViPe
	00Oz6fPswrSNcB85/Ywbq4p6aiPuxzuS9eKw4oX4w==
X-Received: by 2002:a05:690c:ec4:b0:8a8:93e9:3824 with SMTP id 00721157ae682-8ae95ad61e8mr14431447b3.62.1791059251099;
        Sat, 03 Oct 2026 13:27:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm23389887b3.47.2026.10.03.13.27.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 13:27:30 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Sat,  3 Oct 2026 13:27:27 -0700
Message-ID: <20261003202727.3673-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
evaluation.  The tracepoint fires once per quota-score computation when
the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
context_idx, scheme_idx, nid, target_value, and current_value.
current_value is reported as the quota tuning sees it, after the goal's
complement setting is applied.

The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
occupancy as basis points of eligible bytes.  This information is not
exposed through any existing external interface (perf stat, /proc, or
sysfs), so the tracepoint is the only way for userspace to observe the
target and current eligible-memory basis point values at quota-scoring
time.

Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/trace/events/damon.h | 31 +++++++++++++++++++++++++++++++
 mm/damon/core.c              | 16 ++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 8851727ae162..2c7249cc7c88 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -74,6 +74,37 @@ TRACE_EVENT(damos_esz,
 			__entry->esz)
 );
 
+/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
+TRACE_EVENT(damos_node_eligible_mem_bp,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		int nid,
+		unsigned long target_value, unsigned long current_value),
+
+	TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(int, nid)
+		__field(unsigned long, target_value)
+		__field(unsigned long, current_value)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->nid = nid;
+		__entry->target_value = target_value;
+		__entry->current_value = current_value;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u nid=%d target_value=%lu current_value=%lu",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->nid,
+			__entry->target_value, __entry->current_value)
+);
+
 TRACE_EVENT_CONDITION(damos_before_apply,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef8990..6ddd15dc4f55 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3294,6 +3294,22 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
 		highest_score = max(highest_score,
 				mult_frac(goal->current_value, 10000,
 					goal->target_value));
+
+		if (goal->metric == DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP &&
+		    trace_damos_node_eligible_mem_bp_enabled()) {
+			unsigned int cidx = 0, sidx = 0;
+			struct damos *siter;
+
+			damon_for_each_scheme(siter, c) {
+				if (siter == s)
+					break;
+				sidx++;
+			}
+			trace_damos_node_eligible_mem_bp(cidx, sidx,
+					goal->nid,
+					goal->target_value,
+					goal->current_value);
+		}
 	}
 
 	return highest_score;

base-commit: 763ad0211c7b587344f03bc4d1299810aeb736f4
-- 
2.54.0 (Apple Git-157)

