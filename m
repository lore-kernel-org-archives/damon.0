Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CB1B425C
	for <damon@lists.linux.dev>; Mon,  7 Jul 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856358; cv=none; b=jdxvXxtxNZvabJYP194+Yhqfxk0uJ6g/kYyyIx5RnQV7Zlvt50MuK2M6zvC1CFDXpCo0/BpJZrUoQAKGqST0vRZ/1Fp5L4xt2dir8GTsQ87hcaYN1cc7X5B/ZZQn/mrRvkF8IH3NrcsTOZlN5fzqLLsR/NJzMD56+iJbMMDsFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856358; c=relaxed/simple;
	bh=3byxv6qHXIHZTRZk9B8VEP178bwcBarK4nvhq53XJmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGMGulnbrfJDxyuPiwq13hGCCQfYqITrKC/KBXN1V2AKzLZNnQUOzlBisz6DtlFpz1GFbi/WRBHlvO3p+rJ6gIabcpVl0Srt7+38cKbqLL4vlQ15Rj+aVg4/ehIznGJajUoElNx3hhuRvzJWwhCTlAaQBtX3jkD/ihO38MF97cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-64-686b34dfb6b1
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH mm-new] samples/damon: change enable parameters to enabled
Date: Mon,  7 Jul 2025 11:45:47 +0900
Message-ID: <20250707024548.1964-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXC9ZZnoe4Dk+wMg53vmS3mrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZndN3
	sBfcN6pY2CjewDhTs4uRk0NCwETi+YytbDD2iR/nwWw2ATWJKy8nMXUxcnCICFhJTNsR28XI
	xcEs0MQosfFXJ1iNsICXxPx9S5hBbBYBVYmNDWuZQGxeATOJX31voGZqSjze/pMdIi4ocXLm
	ExYQm1lAXqJ562xmiJqPrBLPHxlA2JISB1fcYJnAyDsLScssJC0LGJlWMQpl5pXlJmbmmOhl
	VOZlVugl5+duYgQG1bLaP9E7GD9dCD7EKMDBqMTDaxCelSHEmlhWXJl7iFGCg1lJhLeNLTtD
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6NfzNEXFfYT
	V++03LyzqU9UmPfitP2f7TnUZh2z/rKyK4Pt/QTXPf2Oig21fdtKzSfemLXdu1Hs0AWTFm0f
	8zul6dKy+npdfD/D19wO05j467xFyPI/04+vvrMhLH7Jo/cL686uC8rgmigRoDn7Y7rSDyHp
	XTfXaHde1b2i90tCS9Phwv7auZxKLMUZiYZazEXFiQBvinqVJgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LhmqGlp3vfJDvDYMNDE4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YHNg8Nq3qBBKfJrF7nJjxm8XjxeaZjB7fbnt4LH7xgSmA
	LYrLJiU1J7MstUjfLoEro3P6DvaC+0YVCxvFGxhnanYxcnJICJhInPhxng3EZhNQk7jychJT
	FyMHh4iAlcS0HbFdjFwczAJNjBIbf3WC1QgLeEnM37eEGcRmEVCV2NiwlgnE5hUwk/jV94YN
	YqamxOPtP9kh4oISJ2c+YQGxmQXkJZq3zmaewMg1C0lqFpLUAkamVYwimXlluYmZOaZ6xdkZ
	lXmZFXrJ+bmbGIFhs6z2z8QdjF8uux9iFOBgVOLhNQjPyhBiTSwrrsw9xCjBwawkwtvGlp0h
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwPgwde4B7fnZ
	1g/04vO+OKl85wwsTtZj2Xjedwq/2Mp6E0cz3c4prxdPXm2w6NXZ8osFMe8tF4U25uzd0xLy
	weOPzWrdu/8KQ+b1OZS7veL9sM0gguP3rc9d51L73i0XCohZ+eH0g6luYovvCafLzNaNFAj/
	dFY/wmX91M9fzWun1Ww0l+ntZFFiKc5INNRiLipOBACXPqd1FwIAAA==
X-CFilter-Loop: Reflected

The damon_{lru_sort,reclaim,stat} kernel modules use "enabled"
parameter knobs as follows.

  /sys/module/damon_lru_sort/parameters/enabled
  /sys/module/damon_reclaim/parameters/enabled
  /sys/module/damon_stat/parameters/enabled

However, other sample modules of damon use "enable" parameter knobs so
it'd be better to rename them from "enable" to "enabled" to keep the
consistency with other damon modules.

Before:
  /sys/module/damon_sample_wsse/parameters/enable
  /sys/module/damon_sample_prcl/parameters/enable
  /sys/module/damon_sample_mtier/parameters/enable

After:
  /sys/module/damon_sample_wsse/parameters/enabled
  /sys/module/damon_sample_prcl/parameters/enabled
  /sys/module/damon_sample_mtier/parameters/enabled

There is no functional changes in this patch.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 samples/damon/mtier.c | 22 +++++++++++-----------
 samples/damon/prcl.c  | 22 +++++++++++-----------
 samples/damon/wsse.c  | 22 +++++++++++-----------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 5e1988697727..041d614e6423 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -38,14 +38,14 @@ module_param(node0_mem_free_bp, ulong, 0600);
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp);
 
-static const struct kernel_param_ops enable_param_ops = {
+static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_sample_mtier_enable_store,
 	.get = param_get_bool,
 };
 
-static bool enable __read_mostly;
-module_param_cb(enable, &enable_param_ops, &enable, 0600);
-MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_MTIER");
 
 static struct damon_ctx *ctxs[2];
 
@@ -167,23 +167,23 @@ static bool init_called;
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool is_enabled = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == is_enabled)
 		return 0;
 
 	if (!init_called)
 		return 0;
 
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-			enable = false;
+			enabled = false;
 		return err;
 	}
 	damon_sample_mtier_stop();
@@ -195,10 +195,10 @@ static int __init damon_sample_mtier_init(void)
 	int err = 0;
 
 	init_called = true;
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-			enable = false;
+			enabled = false;
 	}
 	return 0;
 }
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index d70f47924720..0ac4407e919a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -22,14 +22,14 @@ module_param(target_pid, int, 0600);
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp);
 
-static const struct kernel_param_ops enable_param_ops = {
+static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_sample_prcl_enable_store,
 	.get = param_get_bool,
 };
 
-static bool enable __read_mostly;
-module_param_cb(enable, &enable_param_ops, &enable, 0600);
-MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_WSSE");
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_PRCL");
 
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
@@ -119,23 +119,23 @@ static bool init_called;
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool is_enabled = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == is_enabled)
 		return 0;
 
 	if (!init_called)
 		return 0;
 
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)
-			enable = false;
+			enabled = false;
 		return err;
 	}
 	damon_sample_prcl_stop();
@@ -147,10 +147,10 @@ static int __init damon_sample_prcl_init(void)
 	int err = 0;
 
 	init_called = true;
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)
-			enable = false;
+			enabled = false;
 	}
 	return 0;
 }
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 6037e5f8adf2..b663e206d574 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -23,14 +23,14 @@ module_param(target_pid, int, 0600);
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp);
 
-static const struct kernel_param_ops enable_param_ops = {
+static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_sample_wsse_enable_store,
 	.get = param_get_bool,
 };
 
-static bool enable __read_mostly;
-module_param_cb(enable, &enable_param_ops, &enable, 0600);
-MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_WSSE");
 
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
@@ -99,23 +99,23 @@ static bool init_called;
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool is_enabled = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == is_enabled)
 		return 0;
 
-	if (enable) {
+	if (enabled) {
 		if (!init_called)
 			return 0;
 
 		err = damon_sample_wsse_start();
 		if (err)
-			enable = false;
+			enabled = false;
 		return err;
 	}
 	damon_sample_wsse_stop();
@@ -127,10 +127,10 @@ static int __init damon_sample_wsse_init(void)
 	int err = 0;
 
 	init_called = true;
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_wsse_start();
 		if (err)
-			enable = false;
+			enabled = false;
 	}
 	return err;
 }

base-commit: e1ca48e53d00b97aee427d2108f6058cd9ab4aee
-- 
2.34.1

