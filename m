Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F32BCFC
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774770861; cv=none; b=g3TI8SX76qsipztvuLHBketMqB/dL+2jBhEPvDcRdpmwoscZ2HG6pfEmklFMuF6K19OSE15alwOqfkVr9NbLDrKIrIBIWlmnxu2sLfgoF6LAnFTATIqxi6aTl71kavUCugmBLP8raES8ogLwTP064oenzLzQXZP+r+npwAmxdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774770861; c=relaxed/simple;
	bh=wX68+6bF2Q9OfpYV5Y/YzG4AAvOlF0dp4g/N8P/aTMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/6+BG3sYb8Dhi0xf/Bug9wnhcXquxB5USp95fpiaa3IjsKqIfhigfqF7jfgM67D7AkjrGk0jp1FwRIUTSndi9fDNK3kNvOCW19cJGIw0FNpR451lRgLJU5z3OBV/aBJAuJ3gOA9RK41kdc6rq7Md1qqiezAebDd7ST+J5QlGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCfnYhnM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCfnYhnM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab39b111b9so15254755ad.1
        for <damon@lists.linux.dev>; Sun, 29 Mar 2026 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774770859; x=1775375659; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5O5VqXLb1ZUzBeNeL2huf0mC4t2aOi14GMpW6fANEw=;
        b=KCfnYhnMTwZGu1b8ht+hdEQ1cHlQIMIxi4O5cBOHGsLPTOCrUiqOTYsD/dhPsE5eIf
         E/nMok7u1iBZlRXD7G8Pvgpz7j904zWaZMkHYhkzk9dzPAlD2/rZO+ZptvS9s6+vbWTt
         1UpPpa9PGTC5ABwRDw6gMAD2xY75zLlhWuozdT48w+FFvJRoSFjBzRpcp2LwX6/h9MfQ
         Ujwyk7MwlFloY+uT7bgguzCA4nlqVt9677cOx0VtNMnd9HOH4leVTt6ID2OFDjSQS/dK
         x85qqGtJ0Fs/uIYilLgWwqFjQeCTIR2CZphNMDimuoaUau+ZsVJ25QoZ5sdhf8YfeFAo
         9Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774770859; x=1775375659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5O5VqXLb1ZUzBeNeL2huf0mC4t2aOi14GMpW6fANEw=;
        b=XcfEokZzY+kMu+Bv2ltCY/DsGLd7pBZF5tcppBJsP7yq6QfxVrDYGwm7/7jbW9ivA3
         JE7Sr3egcF7phwO6qovVBkLBP9OkFyDwTyLyD8lAvuADUr9ImU25R8WNPAxj7a42MJKO
         8KZ9ko5Moh/UvUluq5mavGLHo0xYpHNB4HusU09DqZ1O+375tlOYIstzx6erupbRgbYE
         zvX6ZxztxOmHQUzF/awfyJHQ22rjiA+BAUHCCA9x/uSdlUD223kwj3GquBUDn1peaRZV
         NNFcqNA7yqAmsy5vt7BVEcwvI0SqO3YmbTSibsTV7ZLlvOwSe+UNN78cbfpvp5ufPMs5
         +0/Q==
X-Gm-Message-State: AOJu0Ywechu4v1MEQuPxPfeP+ugy3TSks+aPv5ny12S4J2HvJXwphIUF
	ASP+f1C2NUUmyWWk36SK3v4t4l66z/+sB+XP79JplLvSuzTKARWQy8K4
X-Gm-Gg: ATEYQzzf8MoS2pyir10O1MeIF7oRucN9an/I/rid/ttf2MN7Es9TCbYdcR28hk1tsox
	GbfFrXXRJhOwfinvyhxGgcEF2haIedYGz76eapy8/epCq2BIsXSHWf5ljnjW4Ub5c/kLND0Npp3
	nrXNUDoqN5HfiyMzaeNowuHC0cqgwI9OsaJuW8OceZx6GrMLoDzv527MPjWwb1W36U4X4Y8+zLr
	oxcI0S/W0kM0enQQVkvmT/DYNHygBDHO4MWMFJWfbGU0HT2hdg2UadaLD2Ieb5gjTKPRD/OK1KG
	x07SdD7tBu34L1BnhZ2u9PZ6cq5aeDRQlsHIEgFXsVZhMeMdh4GbX1MU7aVPNajeu2jkkKBQELa
	nqivwGhyi/MzhBcWA5DOJtGGuzW9RnL6nfnQy0qImXmMard6sSif2n7Nr7VxR1luaRue/X/HWw/
	xgww/nGa8nkFJq/Jteslg6eNunIxqtIHHVu96WIbMBD5HypU3OoFc=
X-Received: by 2002:a17:903:2f87:b0:2ae:5a55:3ded with SMTP id d9443c01a7336-2b0cdd037c9mr83556355ad.45.1774770859281;
        Sun, 29 Mar 2026 00:54:19 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242643381sm45565725ad.5.2026.03.29.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:54:18 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2] mm/damon: add synchronous commit for commit_inputs
Date: Sun, 29 Mar 2026 15:54:15 +0800
Message-ID: <20260329075415.36775-1-aethernet65535@gmail.com>
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
Changes from v1:
- Restore the KERNEL_PARAM_OPS_FL_NOARG flag to keep the compatibility.
- Link to V1: https://lore.kernel.org/20260328084524.5451-1-aethernet65535@gmail.com

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

 mm/damon/lru_sort.c | 46 ++++++++++++++++++++++++++++++++++++++-------
 mm/damon/reclaim.c  | 46 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..641af42cc2d1 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -349,18 +348,51 @@ static int damon_lru_sort_apply_parameters(void)
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
+	if (!val) {
+		commit_inputs_request = true;
+	} else {
+		err = kstrtobool(val, &commit_inputs_request);
+		if (err)
+			return err;
+	}
 
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
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = damon_lru_sort_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_lru_sort_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
@@ -374,7 +406,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 			damon_lru_sort_cold_stat = s->stat;
 	}
 
-	return damon_lru_sort_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..31cf3c45dc72 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -255,18 +254,51 @@ static int damon_reclaim_apply_parameters(void)
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
+	if (!val) {
+		commit_inputs_request = true;
+	} else {
+		err = kstrtobool(val, &commit_inputs_request);
+		if (err)
+			return err;
+	}
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
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = damon_reclaim_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_reclaim_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
@@ -276,7 +308,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	damon_for_each_scheme(s, c)
 		damon_reclaim_stat = s->stat;
 
-	return damon_reclaim_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
-- 
2.53.0

