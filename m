Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6039E196
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592782; cv=none; b=VF5p8CbnURsXgwMPyMyufq142YEFqgVHvgS7/G4UtDL/6SweCCZEp0G9/FyDAzlLaqJBbjJIa4oYhjdGlgi+9NVpaw0wvnl9cY7itxykmVcu+8u3fD0JoKmtbTjObUdmL09DO7lTgyj8a58am5At1iq4ksSyv5usmytzLRXbQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592782; c=relaxed/simple;
	bh=lROjDuSQclBslcaw2FB2Qbyl0xuXRpW1hN9Kd9oOoOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNlkD3TYk3BJ0moIRR6uA3tFkinQrnwK0MWinWVS8KS6c2XhrPZ5kpf3eBaYRUOdT2FogZZlyk/wzuXV+DR7GCj52JOfkC/tTIAbDUbAQZtHnNTecMSXI1iMB8khCX8g3quKo5rGGNRw2kNMDZya/EGFE94ee+RrILJL45nbUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnQ4wMW2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnQ4wMW2"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82a893d289bso789007b3a.0
        for <damon@lists.linux.dev>; Thu, 26 Mar 2026 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774592778; x=1775197578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWkXo7TpBrVMMy5Kx55dRavZnN42vKfpS/87hXsaheU=;
        b=VnQ4wMW25YDkgxuqBQ9kBT4V/3x9lzNDO871MaWKl54jG3/mtsO7G+eXtQ2PhoXXyG
         Y1sRbKO+4/1RhSV2td9VkkmFBJkpHgSK4ks/yLqSwWf8MRsoSw1tSJlZABQDZ/6DWdxF
         hQZ2oKMX0F5RqsaMHlquRTvEPSA2ZUawK8UbLuyI1kqPQBVF0Ba6vIuTe1SVJQ8AvRo1
         fHUdnSQXxFXBsD9gDQRDrpWfX6fdIfJYIJFvMpB89F8rvdV2he8UxhEt3hH+2BI4DZix
         3a7KIHYbNmUIJ3C9WkRh0+z4uHAFZHbkfC+/ddJkSv9KVZi1UMOwiM9Kakq0xVwChr8n
         SgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774592778; x=1775197578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWkXo7TpBrVMMy5Kx55dRavZnN42vKfpS/87hXsaheU=;
        b=mHWkyLtXPX7nlhpxOEVRd1nLczlM39ynLkBwScrSwGCvVxE/jg5K7Skcx1ySQjHKJK
         t+vE8E+S6doZW1mmY3+CWcWcph4hUJwJMFrWRA0VkInrOuRaiIH52VXeDp7eIaceJljg
         OGks6yZnqPyOxykHHflOBB+swIUKRtrd2/GmaQLxG6EZc5ztUpU0kjN8F5GKbpT4rCxU
         032vIkhpp10iTN80v37gmak4LrWZXQcF+8iohbJzDoOTVKT64drQss/Y52eDh3he2sVQ
         MRKDOqcNQPl7EXF4lplexdokF14OwknLnZrYyHpBES85sRV8g1aAR82/aPufPFMl2l6e
         baSA==
X-Gm-Message-State: AOJu0YwgnZ4YTJpZz8mW1IQwadS76l5futospxcEVv4PJt4kdx6bNHfe
	iYI9JMxa/PLpRcyUs5SFi6LFZ7P9A5mogpDZXYB5/9NOuSEZk8DLszlv
X-Gm-Gg: ATEYQzzT2hfbUjqpCyl1P1HSuZcAU0DjPcHlKke7yxGotI8d8Iwx+HEXmd/Z91HHe7n
	s8i1/c70gZUOyKS5GOakca26lsxShduSdtf4BUxNrM75T1P0PU1uEMyuI6CQu6wttS8RAD5yyeb
	ohPfmeey4I/jknP91ZNXW7OOApqE0FGK4EKrXNiNR1LxL8o2xlRpFijrCh4OvUutVC//kFyWnnD
	4oSPK60+KlXSECf3u8xzZv2bCzix4oJIiBG7dk4PGcb31eLs3i0yWAEwDAkiaCwZbxgLzuXHbQh
	mYlvCo6Q4vCKV3hJURpZ5tbz0u4jAx/RxIC+K3Ws6Rf10DKLVRHecHKdPa9dyuyXZPsM6tsopmq
	CezwRqwRTKHeF4Tbx8EZjqOVUFGinNg/d7ZTfAnweZsl9i3Moa8rcoRQS8o0cxY0A3F4qCxkKh6
	fBOp8jmKkkLaxTVn5pyWyc5z0kYIE=
X-Received: by 2002:a05:6a00:bc0b:b0:82a:6f69:7f7b with SMTP id d2e1a72fcca58-82c9600448fmr1313550b3a.37.1774592778348;
        Thu, 26 Mar 2026 23:26:18 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d216a8csm4548702b3a.16.2026.03.26.23.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:26:17 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH v6] mm/damon: add synchronous commit for commit_inputs
Date: Fri, 27 Mar 2026 14:25:58 +0800
Message-ID: <20260327062558.66392-1-aethernet65535@gmail.com>
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
Changes from RFC-v5:
- Removed unnecessary assignment in commit_inputs_store().
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

 mm/damon/lru_sort.c | 42 +++++++++++++++++++++++++++++++++++-------
 mm/damon/reclaim.c  | 42 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..453033f3cb3e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -349,18 +348,47 @@ static int damon_lru_sort_apply_parameters(void)
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
+		return -EINVAL;
+
+	err = damon_call(ctx, &control);
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
@@ -374,7 +402,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 			damon_lru_sort_cold_stat = s->stat;
 	}
 
-	return damon_lru_sort_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..03e3300ce607 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -255,18 +254,47 @@ static int damon_reclaim_apply_parameters(void)
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
+		return -EINVAL;
+
+	err = damon_call(ctx, &control);
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
@@ -276,7 +304,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	damon_for_each_scheme(s, c)
 		damon_reclaim_stat = s->stat;
 
-	return damon_reclaim_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
-- 
2.53.0

