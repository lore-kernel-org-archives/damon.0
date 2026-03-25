Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C82066DE
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402788; cv=none; b=fOwnkkKBg4uR4FYkljiGkhb/w+bwwGPrF2qnHKRtE+vE0GnajxkRkgzrdCHSZVfbwbioIa3oxhIPtWT+XX8KOJG8ZJcZ/AN4lcHgsayQ1Jk7OzK6+2rO1dAbtHzdPbCRiY9kmJzL1vW9LZSyMz+4ODFTv2sM7muW+Ua5di1L1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402788; c=relaxed/simple;
	bh=GgNHX/7uQHLubMwPxoUYXOcObSlIYacei34TdUm0Uns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZG7P/1VCfFd34tSjM8caJHpqdPpTRMkQoCumv4q/QMl4jdHEPfJSSkLAYZc7/uT+sR4WNsN9hG76Ons75omDGLB61rHiA0G7bER0MMIhx6jUWbAgLvggrtwbDcQiWrvUuvCs7qxFF1jUVNHkXc9rp6sVi5C5d+0KQMq2D/9z4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCUqDwvl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCUqDwvl"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso243554b3a.1
        for <damon@lists.linux.dev>; Tue, 24 Mar 2026 18:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774402786; x=1775007586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0lb1fwwGhgf5ADRsUJX20lMn7/h+aTx638YqSGGiQ8=;
        b=RCUqDwvlb4t/LAngLfyDiQpDYKEsAgjZO0Amv/jbZaaJNU2UU8phoXJGe774ejFcsm
         XQSOAL1GhQJ6BEFrTZIcH/ZH82siGeWFFQcp1zuEa0WEO6bse1Of81IrI7R17gKMTnGx
         bk8kQXQI4HaCVBp8M3AIMv7eBBN8Gh4WFtwuWdL2YlzGvOfPERWzIwBUiDg7eneTxaao
         ACY3tuiVUhr1swfMwMZf/8URd7h9cIzhZIhGC6oaGicfeQuzCckW95yTwnwt8on7p6j1
         px7unfkD5X1XaKLTdAwyT8myOzIj2VbfCujlRtpLpjB3n0Xla95hnLrsvXVxgwjTZg6P
         1iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402786; x=1775007586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0lb1fwwGhgf5ADRsUJX20lMn7/h+aTx638YqSGGiQ8=;
        b=IhH0kOd6v73GfQAeq2oqoR4apm7Hg1wqUdm3ZLMsNv6wd1OgUDbhacFr8/ohLEYLDc
         XBfyZQ+Yiqh4b9MYGy5S+yqzu+96+U8bmcG7P4nYDe6LXn1hwNyFQvzG9NAANFPHwY9B
         EzovVuboEGm/NktrykVwgn1Gyp/7kgJKdb38YTDwrs4kZnJ2CyP3SeuCPN/9nobEm9it
         sbjlJVGzoq+gbZVFFoTpMoX9t07rZJGPf/x9vFiwuz6Z6L92nI0wfBPUJVjPxUu3kQ2T
         qoDhb1h8MV7XfUZSKrjxRFEjYyS/zovKpERPGl6g/UoWp6hdxhh/VUr1puC6gKZ5aBD7
         q9KQ==
X-Gm-Message-State: AOJu0YwU3P3uUrqHod5I5/+BzeObXdWb/ixV0n9SVIrhB32nm+aYKyFz
	HoArGcHOTMXjoMJIhugktdYVsR8w1EHlBgVcutHaPvSmbtlUnrzu6tpb
X-Gm-Gg: ATEYQzzJB9lXSLX27zXjlFyiiTSLDx17Ym6S9Xu1Chnsb2vQmijSMP6VKYTeKGy33Ak
	p6Ak6HKgC6liOvOwuyAVJm1x+ALyMU2ZBedpQhL8/lvolg7Q8j8TbA4yP75gkSun9mGZ2277+dW
	Y2zkG50UNz6tFJegjato3LD1g2jQvgKId3Utk5+o/+UwW3HQQv0yPjEXBLfPl2I8tBKsN0F/fsx
	/laTiVPn6NWIhYhMcUfOOwOPw2V5SL77IczwQB4A3DVhBSXGFdRyd7B/6MAbrErjJpEJ1i3L9vP
	4rFW493ei+4yItxcDInR23Tw6+95hM3VjNA/kRkn0wWj0uJs6Q7aNX15GuYPqcAGwh+0tjbTfSs
	UpThdC57e6lyoXhYp5vLkzXhirm8vAWT5Z1yT3bPR70lhnh6kgjZGjY4ThvYUH2hZPwkorKWJQg
	x7CWltPGRoU5o+OuNrq+z94UBuUa2K836lqq+1C9ruTf1hyhhdpB99JIXvnb6JGg==
X-Received: by 2002:a05:6a20:6a2b:b0:39c:3f34:7e06 with SMTP id adf61e73a8af0-39c4abb7d92mr1746911637.4.1774402785894;
        Tue, 24 Mar 2026 18:39:45 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443ccbf0sm11654417a12.26.2026.03.24.18.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 18:39:45 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Wed, 25 Mar 2026 09:39:39 +0800
Message-ID: <20260325013939.18167-1-aethernet65535@gmail.com>
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

 mm/damon/lru_sort.c | 54 +++++++++++++++++++++++++++++++++++++++------
 mm/damon/reclaim.c  | 54 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..a2410f648b51 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -349,18 +348,59 @@ static int damon_lru_sort_apply_parameters(void)
 	return err;
 }
 
-static int damon_lru_sort_handle_commit_inputs(void)
+static int damon_lru_sort_commit_inputs_fn(void *arg)
 {
+	return damon_lru_sort_apply_parameters();
+}
+
+static int damon_lru_sort_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	bool commit_inputs_request;
 	int err;
+	struct damon_call_control control = {
+		.fn = damon_lru_sort_commit_inputs_fn,
+		.data = ctx,
+		.repeat = false,
+	};
 
-	if (!commit_inputs)
+	err = kstrtobool(val, &commit_inputs_request);
+	if (err)
+		return err;
+
+	if (!commit_inputs_request)
 		return 0;
 
-	err = damon_lru_sort_apply_parameters();
-	commit_inputs = false;
-	return err;
+	/*
+	 * Skip damon_call() during early boot or when kdamond is
+	 * not running to avoid NULL pointer dereference.
+	 */
+	if (!ctx)
+		return -EBUSY;
+
+	err = damon_call(ctx, &control);
+	if (err) {
+		/*
+		 * If kdamond is not running, damon_call() returns -EINVAL.
+		 * Remap it to -EBUSY to better reflect that the operation
+		 * failed due to the current state of the system.
+		 */
+		if (err == -EINVAL && !damon_is_running(ctx))
+			return -EBUSY;
+
+		return err;
+	}
+
+	return control.return_code;
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
@@ -374,7 +414,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 			damon_lru_sort_cold_stat = s->stat;
 	}
 
-	return damon_lru_sort_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..4cbd67e08d56 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -255,18 +254,59 @@ static int damon_reclaim_apply_parameters(void)
 	return err;
 }
 
-static int damon_reclaim_handle_commit_inputs(void)
+static int damon_reclaim_commit_inputs_fn(void *arg)
 {
+	return damon_reclaim_apply_parameters();
+}
+
+static int damon_reclaim_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	bool commit_inputs_request;
 	int err;
+	struct damon_call_control control = {
+		.fn = damon_reclaim_commit_inputs_fn,
+		.data = ctx,
+		.repeat = false,
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
+	 * Skip damon_call() during early boot or when kdamond is
+	 * not running to avoid NULL pointer dereference.
+	 */
+	if (!ctx)
+		return -EBUSY;
+
+	err = damon_call(ctx, &control);
+	if (err) {
+		/*
+		 * If kdamond is not running, damon_call() returns -EINVAL.
+		 * Remap it to -EBUSY to better reflect that the operation
+		 * failed due to the current state of the system.
+		 */
+		if (err == -EINVAL && !damon_is_running(ctx))
+			return -EBUSY;
+
+		return err;
+	}
+
+	return control.return_code;
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
@@ -276,7 +316,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	damon_for_each_scheme(s, c)
 		damon_reclaim_stat = s->stat;
 
-	return damon_reclaim_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
-- 
2.53.0

