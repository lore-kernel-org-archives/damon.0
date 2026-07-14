Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17843B4BA;
	Tue, 14 Jul 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039757; cv=none; b=emfqMLGsMCffN8P2YUZ3RmTVKWO3q8kkNU329LcC9EiEhVOxFSmlqt36NAaSA/fZj6rH9gBfa+ZXKCdApe94oi6Lyk36OqpjADqqEz1OUoAytOGfYGwrK1hqI8LXeQEf8gRTLUuw1qpbs59Q11IZBLVjI9ilx7P9hYmcutFJdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039757; c=relaxed/simple;
	bh=0jpvCqL7eB2QWrQVfr7eucpCsgZNYXbbp9++ZbaE9zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCtFZjumN2e4pwKKQ8M6oUaE0X4O7UZ9oCjZIckw85Lrf/TwXfnLeXcY/tJqtwJ4uP5f4g59BsyJ3P2zGEEacC3EVE1KFRinCrLqjN1Mi0lseSXvSJayZEmNyrHIhvHMCNNq02x3XKlOQMhh3eQA2oL+eLs0JYdb+qN0WcCG7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWhCyoH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWhCyoH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DD71F00A3E;
	Tue, 14 Jul 2026 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039756;
	bh=t7iohU0bRHpxYfrt1uYJsO4LZsUO4rQ7qDj6JMCliOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWhCyoH6UI55zYnJIRuLEij7M04dcUeXAABRdD0vCF7uiCusH6dL9i7ChxBDBSgNq
	 tjUdicBOB3BwQJDtM9zxykiTxceWYm7/MUf4vOEGSLOw7b5NBP0UZrEPgvWNNleXvb
	 SYXFa3o2FYDdmWeYWDjOIplUISDotw2sdhF323/YKkuXEXA6X5rq2I6QPTcpTM0m7A
	 7bMwgO2xJSW9Zv6Xsv+H5L7vxmEx9yVVgMoK7mttoPBe/nzjkHBnnYKZfJR7BiTxJ8
	 FfQGEkkMbiaYEVSReQuLSKYuSS70q2At3qNKA2Cif0HVSlmTIBuid2F2yrFTspqn4P
	 k9VLUFpi5cvdA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/10] mm/damon/core: hide private damos_quota fields
Date: Tue, 14 Jul 2026 07:35:37 -0700
Message-ID: <20260714143544.101305-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota->goals is intended to be used by only the DAMON core layer.
But it is mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d838cc27ee72a..bd024b89adfa3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -228,7 +228,6 @@ enum damos_quota_goal_tuner {
  * @reset_interval:	Charge reset interval in milliseconds.
  * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
- * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @goal_tuner:		Goal-based @esz tuning algorithm to use.
  * @esz:		Effective size quota in bytes.
  * @fail_charge_num:	Failed regions charge rate numerator.
@@ -255,7 +254,7 @@ enum damos_quota_goal_tuner {
  * the scheme's action.  DAMON then compares it against &sz and uses smaller
  * one as the effective quota.
  *
- * If @goals is not empty, DAMON calculates yet another size quota based on the
+ * If goals is not empty, DAMON calculates yet another size quota based on the
  * goals using its internal feedback loop algorithm, for every @reset_interval.
  * Then, if the new size quota is smaller than the effective quota, it uses the
  * new size quota as the effective quota.
@@ -276,7 +275,7 @@ struct damos_quota {
 	unsigned long reset_interval;
 	unsigned long ms;
 	unsigned long sz;
-	struct list_head goals;
+
 	enum damos_quota_goal_tuner goal_tuner;
 	unsigned long esz;
 
@@ -288,6 +287,8 @@ struct damos_quota {
 	unsigned int weight_age;
 
 /* private: */
+	/* Head of quota tuning goals (&damos_quota_goal) list. */
+	struct list_head goals;
 	/* For throughput estimation */
 	unsigned long total_charged_sz;
 	unsigned long total_charged_ns;
-- 
2.47.3
