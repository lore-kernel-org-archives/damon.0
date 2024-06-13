Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD3144D18
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284697; cv=none; b=Jqs/RSreEiSagZw/N0AomnOa89KfYBl9eccyBkV3LCqaNNanjj7H72ww1FjVzF9lru1vksjGCkQO62fM8h+BVoou13O1boF4al8FArWHhUv3fHsR2wR+RVBO2O0Oq7SYNacex9eYMm4CswbUJY6ld0WQYDwRmHMe04AVs5kugDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284697; c=relaxed/simple;
	bh=ZfLljOt/MQv0L/bYy4Os+q7oWfrMxhmdpGjsjZA0zWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aveVFOMpA1y23SlW3UfWGlQH2NHGikTtH3N5EgPak4nRbD9CSZ36PlQRdA6zTxpeN6kzvyAdW2DbRpam/6BJ8GblS+oanbtLOz9rH2/qkWxSE+f3iYxiZRoRIgTnYKkqCYa6sxy97w13SsFVfxfGjnUqTGM/41hZPZaR3mA2r8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3a-666af18f9bbd
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 4/8] mm/migrate: add MR_DAMON to migrate_reason
Date: Thu, 13 Jun 2024 22:17:35 +0900
Message-ID: <20240613131741.513-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613131741.513-1-honggyu.kim@sk.com>
References: <20240613131741.513-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnkW7/x6w0g3UvxS0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M6U07mAsauCoaZixkbmBcx9HFyMkhIWAi8WXGTUYY++nyvewgNpuAmsSVl5OY
	uhg5OEQErCSm7YjtYuTiYBbYwCwx6dwLJpAaYQF7iQUHLzKD2CwCqhLvN60Am8MrYCox99Fs
	doiZmhKPt/8EszkFzCTWfbsPViMEVNPx/xkzRL2gxMmZT1hAbGYBeYnmrbOZQZZJCDxnk7j3
	ZBozxCBJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECo2BZ7Z/o
	HYyfLgQfYhTgYFTi4fV4lpUmxJpYVlyZe4hRgoNZSYR31kKgEG9KYmVValF+fFFpTmrxIUZp
	DhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsaK5Vw7li85IvLbel3Egpr0L3nRLMEet3qq
	z05I2rNQPXHm9/ccNsouk4RY3Vtq9531Y5j8uGF15sfpE///3eqYfYdh1cLQPccyN3vZVE3q
	NQouEm82V9HvE2dV3t0zy+rj3wOs/VtfiW1UX+G1/1rvvBmCV2b0hApe3Lrl9oHspc/S1A5c
	NIpVYinOSDTUYi4qTgQAAwjJXH4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNLT7f/Y1aawetPbBYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDKmN+1gLmjgqmiYsZC5gXEdRxcjJ4eEgInE
	0+V72UFsNgE1iSsvJzF1MXJwiAhYSUzbEdvFyMXBLLCBWWLSuRdMIDXCAvYSCw5eZAaxWQRU
	Jd5vWsEIYvMKmErMfTSbHWKmpsTj7T/BbE4BM4l13+6D1QgB1XT8f8YMUS8ocXLmExYQm1lA
	XqJ562zmCYw8s5CkZiFJLWBkWsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREY5Mtq/0zcwfjl
	svshRgEORiUeXo9nWWlCrIllxZW5hxglOJiVRHhnLQQK8aYkVlalFuXHF5XmpBYfYpTmYFES
	5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MGb0F0Y3rGq+7HBaZTtb6e0Ni/wnXc+4+swjmWl7
	0kSjZsHtTNFHZm9uCp2zofrEKZv3apdFF8arRP6zWSdj1DNhh8HZh21HsnLWm4SkufrmymSq
	pz+znrHu+cay8kvHa7eHfWueukSKm6GUIXSOyOUHpwxa463t3zi4vEyt3crTwHYi8XTvLSWW
	4oxEQy3mouJEAILNfGxuAgAA
X-CFilter-Loop: Reflected

The current patch series introduces DAMON based migration across NUMA
nodes so it'd be better to have a new migrate_reason in trace events.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/migrate_mode.h   | 1 +
 include/trace/events/migrate.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..cec36b7e7ced 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_DAMON,
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 0190ef725b43..cd01dd7b3640 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -22,7 +22,8 @@
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
 	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
-	EMe(MR_DEMOTION,	"demotion")
+	EM( MR_DEMOTION,	"demotion")			\
+	EMe(MR_DAMON,		"damon")
 
 /*
  * First define the enums in the above macros to be exported to userspace
-- 
2.34.1

