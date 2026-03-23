Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CA6FBF
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232215; cv=none; b=HP7iViWIL8eyk5QHoFEcylsCfEWsnLXQxOvTvZ7S2c2Jjzj3KjRx6iUt/fUKtwyiQEi7WY5yVgo1ga/99g5VMAJB3dS7MHO1MS4sUUIp+HyXoKi33vz193lRaRfZtV3A7RYK/LKEb92z8qFZskhw3e7W4w5x1gp4GFO0oydjXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232215; c=relaxed/simple;
	bh=rJXLibpYv9w5S0hecD8vh7HngGvVizYY65DIcXTV1pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2c3tycY8owJUwXGaCnI+trUjTdwWIUmKAubRywFsh8XOF+OEPo5frfF52HYUoWzg+tevvBk5g4J2mU4NyFh9dEZcuCrEyyXQgQPdJNP38w5C41Hcvvp0UyhkNCl1ccbaB6FAZ9h0u6lPr0G+8jnnjQx929vtuGUTrxHdbO00+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUoj4wWO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUoj4wWO"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c73c990a96dso845270a12.0
        for <damon@lists.linux.dev>; Sun, 22 Mar 2026 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774232213; x=1774837013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aD2K9zVwkcG/aoV5QlS2HrGagpzh6CFCZ3rQ7wiRaPA=;
        b=bUoj4wWO+HZziLEx15fZl3x9OWo6QX6c60/xb9VJXu9TuNrDcIj5US1sR4gcmIGidQ
         K+2FgefCgq7Us9sZTWskk3nHDj87MtgptfBalwbFY48mZBbCvuIN9tBNymuVwHt4XlzZ
         WIbtAiTc7ypA3tuFLB50Dhf5ThJ/BRPXKzm9o3Yy+o7zMsf63AZSk4Gehp/RSYI4mow2
         E4ej9Gul7acePHDMPlLUHoH3xxDzCfC9Ze85gf5JiG0vHslecU3CLT5rRT9EvfUaq5BL
         N94TW49QDL7MXmTTwmZSo5XpoQrG3j0cTX1iHwl+ERIfoIUhDeOvxyZD25xlZTPQQrBx
         AjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774232213; x=1774837013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD2K9zVwkcG/aoV5QlS2HrGagpzh6CFCZ3rQ7wiRaPA=;
        b=eqAcdiansP2PyrH5djin2KoyKaJDm5Cdpni8K5HJDjCuAFHR61WMftlysL1G6qbWNU
         rRRahmIwdpr64MnqDpRPPmhbQToc4KL2Fn5WIPH4mDYtIC1W5fyx+Mg4nwPlUSpiIQeZ
         r+hq4s8uIooO/NadRGqAdYwNeoZ+BcnYbCzM4D8gm6KUksufjNQhMqqjdp5YRBvXjC+s
         vfmsVUE30DvIVKBtHbdd0H4+RlqvFTqX0EOQynHNdasAorpQS8GQM9cDIUUC0Nsz7Jjr
         zX9P7/koNuQAYgAUqXYvyg5Ea56HFSs7q2itn9ib2JL4e32Q5k2cobgcWfwnpXsbyn1s
         bJjw==
X-Gm-Message-State: AOJu0YyXqbZzgJI3P5KLftKOU7ts6oPbG0qqFYoR9zzhQ0VnCvH2Dxyz
	BCJsMQL3XP4G6VWTuN0WO6b/Khtd6v5/lxnZnSQNlcOdZ+CrT0EuH4G2
X-Gm-Gg: ATEYQzzaIPLy+3xsCwrDEeP7Q1u4y2zUXi+JYpYX//MNISkeeBlNiz+vLn5XK01dify
	jm0WqnKZwCVduiKvpiA8ftd250tv/9+NpA2PlPboWGVjudzVfy/Vgr8+Qo0SSyDT3Fk0nJ53qV/
	DpypuWAEtspLKoFiUg8w8PH/gxqNWJTMqeKj3tpuHUHFcAzec+/GBwBm+TPBPk1KkdgS6d+r9hF
	BTvyqojA+Ob1j+UmHIFoRfCvOSgqUztbPb4XM8czQMFY0f2v4DFOJPnHK+XRgDhlxLdoTEPKgj0
	Wb815TPC+FM27M9QDMLAFLyrZg76fZ3BcVBKY4U6Ow7pZ0nhNqGZYuJiToAaNLoLM3NxqW5SMdf
	ix0zWVXaGyzGtrq29HGRsx7KpRwLIb0U3wnBhV5OrvtuYmwdkTwL7Zls80dhFXU/F7fbFAgDmdA
	E5wXjJknEu02daC2Qq8RP3b511uWkVJmwPkiWAsu2rvnCR7qNxfb1WMYViX31X7Q==
X-Received: by 2002:a17:902:f60a:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b09a611475mr19378405ad.32.1774232213156;
        Sun, 22 Mar 2026 19:16:53 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655474sm114373405ad.48.2026.03.22.19.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 19:16:52 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 10:16:48 +0800
Message-ID: <20260323021648.6590-1-aethernet65535@gmail.com>
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

 mm/damon/lru_sort.c | 49 +++++++++++++++++++++++++++++++++++++++------
 mm/damon/reclaim.c  | 49 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..37b3c897e822 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -349,18 +348,56 @@ static int damon_lru_sort_apply_parameters(void)
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
+	bool yes;
 	int err;
+	struct damon_call_control control = {
+		.fn = damon_lru_sort_commit_inputs_fn,
+		.data = ctx,
+		.repeat = false,
+	};
 
-	if (!commit_inputs)
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
 		return 0;
 
-	err = damon_lru_sort_apply_parameters();
+	if (!yes) {
+		commit_inputs = false;
+		return 0;
+	}
+
+	commit_inputs = yes;
+
+	/*
+	 * Skip damon_call() during early boot or when kdamond is idle
+	 * to avoid NULL pointer dereference or unexpected -EINVAL.
+	 */
+	if (!ctx || !damon_is_running(ctx))
+		return 0;
+
+	err = damon_call(ctx, &control);
 	commit_inputs = false;
-	return err;
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
@@ -374,7 +411,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 			damon_lru_sort_cold_stat = s->stat;
 	}
 
-	return damon_lru_sort_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..441d5d9f9eab 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -255,18 +254,56 @@ static int damon_reclaim_apply_parameters(void)
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
+	bool yes;
 	int err;
+	struct damon_call_control control = {
+		.fn = damon_reclaim_commit_inputs_fn,
+		.data = ctx,
+		.repeat = false,
+	};
 
-	if (!commit_inputs)
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
 		return 0;
 
-	err = damon_reclaim_apply_parameters();
+	if (!yes) {
+		commit_inputs = false;
+		return 0;
+	}
+
+	commit_inputs = yes;
+
+	/*
+	 * Skip damon_call() during early boot or when kdamond is idle
+	 * to avoid NULL pointer dereference or unexpected -EINVAL.
+	 */
+	if (!ctx || !damon_is_running(ctx))
+		return 0;
+
+	err = damon_call(ctx, &control);
 	commit_inputs = false;
-	return err;
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
@@ -276,7 +313,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	damon_for_each_scheme(s, c)
 		damon_reclaim_stat = s->stat;
 
-	return damon_reclaim_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
-- 
2.53.0

