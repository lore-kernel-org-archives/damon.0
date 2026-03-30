Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D8389E1D
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889030; cv=none; b=p0Ndj7lp7JVgetOb4Ry9wrJfquK6sEWRmRnAnBMkgreHRlZBSbXIeywE0G2HcapcCNLZrFtCIlgVS8lTQY7+HsqvCx2Llcf4qRrs3LHMwhMW2z12vVMN93WGMlTQuTKlBwfbemlZ/nKhUKME+Pt8BjM5moobieYpVzv8x7rGgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889030; c=relaxed/simple;
	bh=KqwBEbASmiUENlQ/fvxLdiCuLA/byDf6vgsBbsx5HUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCKLB68kBFMeBUW+l7AOSiaDQ3/HT0ivOj5a8+7Fp6lCC6s+GWUPiXcW0n0CNlxd9WlFudLM7Op41MQBwsnl4tEikLPWjielfqU1sM2PnLxpmEU/vHlUPD4h/CqPuTk0GHcuxG3LGQZVHQMM14R7ug5nWaYP5GiaLLL12WJOeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRLrfjJK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRLrfjJK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae4816912so29950855ad.2
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774889028; x=1775493828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1ehfC4g4KhB2DB8rwA/DspDLE7lmXPPnBTWqLJgD/k=;
        b=XRLrfjJK8WQHYIG6cHCzw3v8LYnm9fp07TvwmuKyB+CV/XhYxAKAknN06yg5YUO+5d
         rNrDoA1+ADK6FEVXFJzH7Ic5H7UebM96E2ZvGiz4odF+VnJnIRWT1NtRwYeFdzDRnALN
         8q33Dq+mtSOuM+sZBurIM2gy5fWnjec9Tc+0Y/uHn/UYPe0nUR4Al0+rG/cvidaQXC8W
         fh5vEbK10YVxRB7LI/s5Vf8rMHOsFqO+LenBnatw9id+CcuyQwGpfsQHNy+MnZpWlCvQ
         ePl9XhiTchC3QtKxOY5CsNj4uflgDaun+J/60ix/AZZ0o7UyX7yhx7dTL0UWeDyUCDKt
         9CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889028; x=1775493828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1ehfC4g4KhB2DB8rwA/DspDLE7lmXPPnBTWqLJgD/k=;
        b=q8fDIE6gbE4zkvHfpSSGcV5qrSI3/dCU9amGXnA25pl6NYPKBMKeXyCDY4O78EymNw
         dpnDvHKvhoADiM8RpOXu+PMU+HBtaxfb5lIuqtC0LjGRfkoxlvuy4vUNfZo/7wpNxQAZ
         aB0gwN0gWFq2ShwiMA0l+R2A0mW9RdtRQByo7FVoDfYRpqih9yf2UPS3yIk/t+jWCgWz
         wTbh6mrCIF7j4mPuBMNUhjAKJCDWRgr3ekU2qicGIYvyg5+hzQn6v7Er98JslR4AufgJ
         Pza1eQzyztcSS9u//MGnfPPzxikuQQmV4en6k1T5XUGhszZJLNL8LegWStZizPlj/Ugj
         7Nzg==
X-Gm-Message-State: AOJu0YyQtOalkqApTTAYN3sIAuroCKmTOuOxlwUc5v8eXC+itFwiJ4A+
	0UmYrdxUCNwTWHeBxb7scqgFxc+hN5HGkWJHw3zG3C46GVGeQ/r8cYIP
X-Gm-Gg: ATEYQzwoBCVV0eHj9gjT+HFXDbbNkrMCtNQnbCaR1xnwm8ICdztYDTRiwZFrp/6o/Oj
	Necq05kxzGx6NGVcWklYDV5LROQXJ7VL8rqOW+xIItUFv8d+mImCUG4bKcBQbJYGG1KdlejucTK
	oER+MKWcpIxWcsM8EtDH91q/FvQYRB5EaqhblLRgrpVKEFRiDqvAXLISu+FINmCTs0168bLteU4
	P0ZJfYHJpXq8z23F//BLayP4Qx/+zrm+TPgicu46mhoxzcdgwCOBAzqaD/Z8LwzW6kJ2ERwQgKk
	ZQztqnu9QhiNFzmtcy7uM+uCMBeVQYDPfcf6QSJoYbBMtj9j/X9ycAAQvjvZgSLfKCbkQrn9ALg
	GS85UQQY3RFJo8jdKW425Wz+wMXyStS3Qin6pataUUbKMog9DIrE6LFakN4j86pNCLZOShnoxC6
	1ZHmGSgxuuSu4Fflkv0tN+y5rqWy2wIIK8bKkOm7I76xOMWH1l6MY5rUonD+QNzw==
X-Received: by 2002:a17:902:f607:b0:2b0:6829:9414 with SMTP id d9443c01a7336-2b0cdbe9dddmr147340345ad.8.1774889028009;
        Mon, 30 Mar 2026 09:43:48 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765c6fsm104514555ad.52.2026.03.30.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:43:47 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 00:43:47 +0800
Message-ID: <20260330164347.12772-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
kdamond does not actively modify the module's
(DAMON_LRU_SORT/DAMON_RECLAIM) 'enabled' and 'kdamond_pid' after
exiting. After an unexpected termination, user will still see 'enabled'
as 'Y' and 'kdamond_pid' as a value other than -1. Furthermore, user
cannot restart the unexpectedly terminated kdamond by executing 'echo
Y/N > enabled' again.

Solution
========
Introduce a 'thread_status' structure to link the internal kdamond
state with module parameters ('enabled' and 'kdamond_pid').

Specifically:
1. Extend 'struct damon_ctx' to include pointers to the module's
   parameters.
2. Initialize these pointers in damon_lru_sort_apply_parameters()
   and damon_reclaim_apply_parameters() to point the respective
   module variables.
3. Implement damon_update_thread_status() to reset 'enabled' to
   false and 'kdamond_pid' to -1 when the kdamond thread finishes.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 include/linux/damon.h |  7 +++++++
 mm/damon/core.c       | 19 ++++++++++++++++++-
 mm/damon/lru_sort.c   |  5 +++--
 mm/damon/reclaim.c    |  5 +++--
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d9a3babbafc1..66cdac1eea93 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -763,6 +763,11 @@ struct damon_attrs {
 	unsigned long aggr_samples;
 };
 
+struct damon_thread_status {
+	int *kdamond_pid;
+	bool *enabled;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
@@ -841,6 +846,8 @@ struct damon_ctx {
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
+
+	struct damon_thread_status thread_status;
 };
 
 static inline struct damon_region *damon_next_region(struct damon_region *r)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index db6c67e52d2b..6c71203beec5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1353,6 +1353,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
 
+	dst->thread_status.kdamond_pid = src->thread_status.kdamond_pid;
+	dst->thread_status.enabled = src->thread_status.enabled;
+
 	dst->maybe_corrupted = false;
 	return 0;
 }
@@ -2941,6 +2944,14 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	}
 }
 
+static void damon_update_thread_status(struct damon_ctx *ctx)
+{
+	if (ctx->thread_status.kdamond_pid)
+		*ctx->thread_status.kdamond_pid = -1;
+	if (ctx->thread_status.enabled)
+		*ctx->thread_status.enabled = false;
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -3065,17 +3076,23 @@ static int kdamond_fn(void *data)
 	kdamond_call(ctx, true);
 	damos_walk_cancel(ctx);
 
-	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
 
+	if (ctx->thread_status.enabled && *ctx->thread_status.enabled)
+		pr_debug("kdamond (%d) crashed\n", current->pid);
+	else
+		pr_debug("kdamond (%d) finishes\n", current->pid);
+
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
 	if (!nr_running_ctxs && running_exclusive_ctxs)
 		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
+	damon_update_thread_status(ctx);
+
 	return 0;
 }
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..7196010ee9b4 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,9 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	param_ctx->thread_status.kdamond_pid = &kdamond_pid;
+	param_ctx->thread_status.enabled = &enabled;
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
@@ -388,8 +391,6 @@ static int damon_lru_sort_turn(bool on)
 
 	if (!on) {
 		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
 		return err;
 	}
 
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..61592be438d3 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,9 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	param_ctx->thread_status.kdamond_pid = &kdamond_pid;
+	param_ctx->thread_status.enabled = &enabled;
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
@@ -290,8 +293,6 @@ static int damon_reclaim_turn(bool on)
 
 	if (!on) {
 		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
 		return err;
 	}
 
-- 
2.53.0

