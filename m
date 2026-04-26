Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA13164C3;
	Sun, 26 Apr 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245390; cv=none; b=sIJ3tp+nEmRDQnRSdMGCPa8e99Ng8iYhj6ynY/JbutN7bvSj7D0aTWq2E0ztZyzXvaJxlsKUKjMlXwwz715J80LjUAmHfIYWxMklQ+QwR1fgDh6WevYM4ZZHwZXELP1UcRxVSKwkf1CH3SMfWyhPr5ZSrGzi9tlydlL+T3HErdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245390; c=relaxed/simple;
	bh=eMKRxQtjjInDnVOx2h98jzHWtRL2G5g4LN0n0AbX9jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erDcTCmOfYu641Fsrj/xd95A5eUN7MGigEKCwg+0E3wmaV7pGEMGaQh0gKm0GCGMj3th+6wK6tD7KYXIVwVORQnGUlg1r6jckqoMFmqMYnOK3QoqMvLEhwQ3JJhn2y3YrjFQ4bgUvLZ2WDTsWHPws5iHfSNjp/XJ0s/wzAkL788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJu28CUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJu28CUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3625C2BCB8;
	Sun, 26 Apr 2026 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245390;
	bh=eMKRxQtjjInDnVOx2h98jzHWtRL2G5g4LN0n0AbX9jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJu28CUlO2hOmn+bHTdHQcqVxSlrGMAd4XKXqIG4p7S2zsN30kD757khd4oSNekN2
	 uI6IiF669T6xUMroAQckUtoeg1ohFrnvkENTNAAbuH0N5UXAhcfWOW0kREAK0hrd4h
	 CzUZvaGI66MXqtiK5/LbP914J26SjRDUXgcpDAnSz7UUM3tJWx/B5uBTsN0f9UMJHc
	 5S5iEFMyYmKxb1o4JLa1k/fttfdZKUyw9bQ+189loLxyixkuwi1xhbp1fd4G9JnhWD
	 idZ5yiWHlwlsxoHfT6yRdJl76evMIS6AQki3xYxC2yNdLWuJHlKfbKTKtjVMVRr6L2
	 DBZtIKm9U5dbA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/4] mm/damon: add synchronous commit for commit_inputs
Date: Sun, 26 Apr 2026 16:16:16 -0700
Message-ID: <20260426231619.107231-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-1-sj@kernel.org>
References: <20260426231619.107231-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

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
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
(https://lore.kernelorg/20260329075415.36775-1-aethernet65535@gmail.com)
- Rebase to latest mm-new.
Changes from v1:
- Restore the KERNEL_PARAM_OPS_FL_NOARG flag to keep the compatibility.
- Link to V1: https://lore.kernel.org/20260328084524.5451-1-aethernet65535@gmail.com
Changes from RFC-v6
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
index 8494040b1ee48..7569e471160a0 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -340,18 +339,51 @@ static int damon_lru_sort_apply_parameters(void)
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
@@ -365,7 +397,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 			damon_lru_sort_cold_stat = s->stat;
 	}
 
-	return damon_lru_sort_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index fe7fce26cf6ce..b330ff1695907 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -246,18 +245,51 @@ static int damon_reclaim_apply_parameters(void)
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
@@ -267,7 +299,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	damon_for_each_scheme(s, c)
 		damon_reclaim_stat = s->stat;
 
-	return damon_reclaim_handle_commit_inputs();
+	return 0;
 }
 
 static struct damon_call_control call_control = {
-- 
2.47.3
