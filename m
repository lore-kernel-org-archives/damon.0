Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD25028C;
	Sun, 12 May 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536497; cv=none; b=B+/vGS4oU5ZFjkCICzkJWoHTWm0JYA8ax97CHY8U4oZD9/LWx2IZZMDSlgh1u7GMrOTnIHZ73NrZQPGceTbHhwCAHpC7qu+G7Y/59toMQI5a82k1oCkIMEAirRmYoLmwLzqM39pDXH5xQm0DDrJrwuT/SUtHJz+YSh+QhEC0+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536497; c=relaxed/simple;
	bh=0nYpdJNOcVsAetSwCRBcYWpfg7K4GaKZMal/LiW2aDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xop1mDoxZy+RAxFYZgzr1B/9/kQk0lRwvjf8bsCB6i8n/xf9X4H8yTArNUWncOCntj7jHXW7gqzCjr8f24RT0lakobIiqp+eyu9F050ypB7WHA9VnBxD/38w5cb1uuWLeGMNqczkhWkVc6ev6vjJ6K6aAA2yfQtlB1op04RE6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiCeiPqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiCeiPqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC4CC4AF08;
	Sun, 12 May 2024 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536496;
	bh=0nYpdJNOcVsAetSwCRBcYWpfg7K4GaKZMal/LiW2aDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiCeiPqcqV3HR6k9NGEGmv4MbUCDzmuxGtuizXoVn0cPcZ2oH7D0dAD2qaL9JevbA
	 2/PofgQ5iNSARyYqrbxl48ZFFfT0CGlMaaT0tgpiFcmpGWnUYnlZsmMxAnBupiQA5B
	 8ZUMqtWE2Gpr66DPiyuAbwLu///LkQbyiD29BfRtrL40kVnknmVPavydG9qYWh6U+E
	 AINgYWGQP/LzlQjCbobJc7kgKHZeh8a4B1Y2QTxPaqPnmTu4n4hmdswrnyM1A3JsK9
	 SWEZD9x+rYdlDmywxX7FvHgs7UlmCh8pgn5y2ZzCwA02OkVzGfOjj22voQEi+7xy7x
	 ZuQzZOOofKOIg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH v4 3/5] mm/migrate: add MR_DAMON to migrate_reason
Date: Sun, 12 May 2024 10:54:45 -0700
Message-Id: <20240512175447.75943-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512175447.75943-1-sj@kernel.org>
References: <20240512175447.75943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Honggyu Kim <honggyu.kim@sk.com>

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
2.39.2

