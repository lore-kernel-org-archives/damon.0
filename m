Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619B3783C0
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774687531; cv=none; b=QG7mZTWmV55ir5r6ccJbydrNQ4PalmpJZ6OBd8wL9NN7oqkk88i/nPEqmuQ3/fZUr2rRiBqGuufhIGpAE0HuxhJ0/FRForAggN28fUMEljVVOhhlDPsEuomrijQmxNzbhxBUWPYNrCMJoq71lHdEaw0Hu9xAkepTrRQFcmFBfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774687531; c=relaxed/simple;
	bh=sOt+sHTmdTUlV7+L3eKFM5L1NrJBW55VJ3DX7+8t4kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYpNoMY1rM5KTExlyRjCLOiht0emtHXo8BvPEue5u7BzBnTM/DBV6To4nwC5w3GdWJkPS5tiqo2SucSt1jbpcbTUBVWHZlc4VHWYnwB09vbC7qqAE8Im9V1IIhLPaY3OrPC7MjC01xfaun8NfdX+zO8QTMPArnsKJuRit1UE63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRkw1FP4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRkw1FP4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c70e4654eso1259577b3a.2
        for <damon@lists.linux.dev>; Sat, 28 Mar 2026 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774687529; x=1775292329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ni1twoNTLjGzercFouj5YOFeuaTQAAHlu1t1B6ZMur8=;
        b=SRkw1FP4Prlm03nt4gc+LQAVmTZqJWAxFYlEDEThOK6JPZsvHf5E6pmOafT0f4vNGK
         5UUvr5a8iMZBrFaC0n4b41oPSS0ouLPa5zcDZpai5t0EDQeulhkHs9bRZQvAfpD7AsZ/
         O4bkOFYX7JTNz0jQ24sLhte0WIX80ac0IV+rAsTYCLxPtTJG/B6MqpHWsOiz5xL+pkhF
         0Yp1/aveIRf6zDajDCov34KFM5Nf/5k8Wt+1oFFb+vZ7PjhEHUk0AJZl2Njld41bFL9F
         dqTYF1sO0NDPrJis/WTnIJ8Q5peeG/uM4jCDCD+xUxdSwiPnb/rURkJDlRSO5rMmJ9Ud
         74Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774687529; x=1775292329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ni1twoNTLjGzercFouj5YOFeuaTQAAHlu1t1B6ZMur8=;
        b=GV997SADfu+u4Udu9+rtamuaw2idCskTUTmOOjEn2S0OGAZ3Vlb2ak8TljyujBxkyr
         9kvx1yakXXayWx3POmhlB/BUp5YqBXpfo8bq+EoCsXcCzzwqpTkvVKEj4fqo6elqnht0
         vV4kCMrc5xA7V3swlwjxeP1AgwFOCcCUSOtqtghDJd5y1LzSJRHGZKo3EN7UhUzXPVm5
         2xBydxkdRwIZ0yn4lQBEa+iMwoVTHkeBK9kXEvT4hHOjwoNXA5E7xgzr5zWBc3hId2WD
         JmCnJKUxOw/WTG+XP5/bnDFhHuqX14tsDAyaCit3171WG9MPZUoW3KQhIcbmZwOVJL3U
         PhJg==
X-Gm-Message-State: AOJu0YyjFR9XiZFb80kvZ0YHCL7F5PTpfenveJ9vPEF0IpudpLYc/Pnq
	zSLJWyoky2/a7v7d+ZvMbB1rDa89DYvJIfsLURZeICjm1DtVZEpNvRWr
X-Gm-Gg: ATEYQzyAVXxhzVInAvMk0OTq4P+UBH+NNIRIJZjWDHFVuUH0K8wULSWXpznItnXkNFc
	yyKCl7cQv0e0+Y8t7VSDw0bQ3lBTw30V/mG2uAMLwRMnBUrutf2WNCfKJ9AX5Rgi+OxxGC59LpO
	bkZlE79KL2/VnVMAQP3aZ386G8ncz0dVPlQucVqLqZRFjbLMMd6wSwLXKd7yQRHd03xiX/uiQsb
	vmwADP0AQIeIIASTKnnT3cZ4fRq9y05lKPcSWsektghF8sc9YjwAYob9L4+NQh0uzBf479F/kwJ
	gcnoDuSXr9/7iofDKk9aJHD5uQtdu2Y27qN+fQ6yUXaCJjwZoYIX5YFvwhc/AI1cKXJUdw4D7dN
	kf68QYMbrVwaTidDDNYGEmNqN4ukBot1IAoqtCIhNjgzjfEXpX4h4plC7LBudBpEeeqGgnfRT3y
	RNbJ5qJL6KM9UGUVnL5pZhdGXw2xyHRCbZl+kEi3oUQtooo5PkvAS76iJS/R1lJQ==
X-Received: by 2002:a05:6a00:aa03:b0:82c:75df:10ab with SMTP id d2e1a72fcca58-82c960d66a6mr5138693b3a.58.1774687528624;
        Sat, 28 Mar 2026 01:45:28 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8628f39sm1464054b3a.58.2026.03.28.01.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 01:45:28 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] mm/damon: add synchronous commit for commit_inputs
Date: Sat, 28 Mar 2026 16:45:24 +0800
Message-ID: <20260328084524.5451-1-aethernet65535@gmail.com>
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
Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
silently (no error returned to shell), because the validation happens
asynchronously in the kdamond.

Solution
========
To fix this, the commit_inputs_store() callback now uses damon_call() to
synchronously commit parameters in the kdamond thread's safe context.
This ensures that validation errors are returned immediately to
userspace, following the pattern used by DAMON_SYSFS.

Changes
=======
1. Added commit_inputs_store() and commit_inputs_fn() to commit
   synchronously.
2. Removed handle_commit_inputs().

This change is motivated from another discussion [1].

[1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
Changes from RFC-v6:
- Removed unnecessary assignment (repeat) in commit_inputs_store().
- Change the return value; if an error occurs, return the error code.
- Removed the RFC tag.
- Link to RFC-v6: https://lore.kernel.org/20260327062558.66392-1-aethernet65535@gmail.com

Changes from RFC-v5:
- Removed unnecessary assignment (data) in commit_inputs_store().
- Return -EINVAL instead of -EBUSY when 'commit_inputs' is triggered
  while kdamond is not running.
- Link to RFC-v5: https://lore.kernel.org/20260325013939.18167-1-aethernet65535@gmail.com

Changes from RFC-v4:
- Rename the 'yes' variable in commit_inputs_store() to the more
  understandable 'commit_inputs_request'.
- Return -EBUSY instead of -EINVAL when 'commit_inputs' is triggered 
  while kdamond is not running.
- Link to RFC-v4: https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com

Changes from RFC-v3:
- Added checks for 'ctx' and 'damon_is_running()' to prevent NULL
  pointer dereference during early boot. (Found by Sashiko.dev)
- Removed handle_commit_inputs() and its associated polling logic as
  they have become dead code after moving to the synchronous damon_call()
  approach.
- Ensure the 'commit_inputs' is properly updated.
Link to RFC-v3: https://lore.kernel.org/20260322231522.32700-1-aethernet65535@gmail.com

Changes from RFC-v2:
- Removed damon_validate_attrs(), now using damon_commit_ctx() for
  synchronous validation in the kdamond context.
- Following DAMON_SYSFS pattern for synchronous commit via damon_call().
- Link to RFC-v2: https://lore.kernel.org/20260321140926.22163-1-aethernet65535@gmail.com

Changes from RFC-v1:
- Remove question from commit message area.
- Added synchronous validation for DAMON_RECLAIM.
- Rename damon_valid_attrs() -> damon_validate_attrs().
- Exported a new function damon_validate_attrs() and declared it in
  damon.h.
- Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com

 mm/damon/lru_sort.c | 41 ++++++++++++++++++++++++++++++++++-------
 mm/damon/reclaim.c  | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3af6854ba3da 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -349,18 +348,46 @@ static int damon_lru_sort_apply_parameters(void)
 	return err;
 }
 
-static int damon_lru_sort_handle_commit_inputs(void)
+static int damon_lru_sort_commit_inputs_fn(void *arg)
 {
+	return damon_lru_sort_apply_parameters();
+}
+
+static int damon_lru_sort_commit_inputs_store(const char *val,
+					      const struct kernel_param *kp)
+{
+	bool commit_inputs_request;
 	int err;
+	struct damon_call_control control = {
+		.fn = damon_lru_sort_commit_inputs_fn,
+	};
+
+	err = kstrtobool(val, &commit_inputs_request);
+	if (err)
+		return err;
 
-	if (!commit_inputs)
+	if (!commit_inputs_request)
 		return 0;
 
-	err = damon_lru_sort_apply_parameters();
-	commit_inputs = false;
-	return err;
+	/*
+	 * Skip damon_call() if ctx is not initialized to avoid
+	 * NULL pointer dereference.
+	 */
+	if (!ctx)
+		return -EINVAL;
+
+	err = damon_call(ctx, &control);
+
+	return err ? err : control.return_code;
 }
 
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_lru_sort_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_lru_sort_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
@@ -374,7 +401,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 			damon_lru_sort_cold_stat = s->stat;
 	}
 
-	return damon_lru_sort_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..d8398161f091 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -255,18 +254,46 @@ static int damon_reclaim_apply_parameters(void)
 	return err;
 }
 
-static int damon_reclaim_handle_commit_inputs(void)
+static int damon_reclaim_commit_inputs_fn(void *arg)
 {
+	return damon_reclaim_apply_parameters();
+}
+
+static int damon_reclaim_commit_inputs_store(const char *val,
+					     const struct kernel_param *kp)
+{
+	bool commit_inputs_request;
 	int err;
+	struct damon_call_control control = {
+		.fn = damon_reclaim_commit_inputs_fn,
+	};
 
-	if (!commit_inputs)
+	err = kstrtobool(val, &commit_inputs_request);
+	if (err)
+		return err;
+
+	if (!commit_inputs_request)
 		return 0;
 
-	err = damon_reclaim_apply_parameters();
-	commit_inputs = false;
-	return err;
+	/*
+	 * Skip damon_call() if ctx is not initialized to avoid
+	 * NULL pointer dereference.
+	 */
+	if (!ctx)
+		return -EINVAL;
+
+	err = damon_call(ctx, &control);
+
+	return err ? err : control.return_code;
 }
 
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_reclaim_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_reclaim_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
@@ -276,7 +303,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	damon_for_each_scheme(s, c)
 		damon_reclaim_stat = s->stat;
 
-	return damon_reclaim_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
-- 
2.53.0

