Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFE41DEFDD
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594228; cv=none; b=SHNzHyeSDyBo6ZbCvkT5Kf3aSOjEcVsWnUMzXnd7wqPkogLgtkxPX/djUCtkZJtulHOrEKPpVvLzElkHfWvudTvkUJFlySVepsSMoKAwnZnuOax9N2hCWJWsXWASetuo+KjaRp9PatCLMCTODMwnVFG906FXIa4OpfqpGcnn6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594228; c=relaxed/simple;
	bh=EsrKz7FxO6+5EbWWzdlFoTOolNKqHp+W2/eUkjTj3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT8kTzRDHaR6UKMHl4OQ0FiRxsFfVhyNocF6Cc29vw8FmpOFfhfgoLjJ0tJv/+KnrhhiNSFJFRFjtnIk+JwNeoSN7aflThLl/NPIQ3KDw33F2QV/J6DZ9n2OnmYjJlBac1RFKRKirErEJCNS44n8Yoj8SOvKbHSVizAUKLJz0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-38-6857f2ae2233
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: [PATCH 2/3] samples/damon: change enable parameters to enabled
Date: Sun, 22 Jun 2025 21:09:24 +0900
Message-ID: <20250622120926.1712-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250622120926.1712-1-honggyu.kim@sk.com>
References: <20250622120926.1712-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnke66T+EZBut6zSzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZty41
	sRRs0az497WggfGMUhcjJ4eEgInEqUfNLDD2lLmLWEFsNgE1iSsvJzF1MXJwiAhYSUzbEQsS
	ZhZYwSgxb0UciC0s4C6xfnoLO4jNIqAqcWD3HbBWXgEziaYT61ghRmpKPN7+E6yGU8BcYv2a
	88wgthBQzdeDP6DqBSVOznzCAjFfXqJ562ygGi6g3h42iQed26AGSUocXHGDZQIj/ywkPbOQ
	9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERiEy2r/RO9g/HQh+BCjAAejEg/vi4NhGUKs
	iWXFlbmHGCU4mJVEeA85AYV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1I
	LYLJMnFwSjUwxoR3pK46tzr8h+xj/1dVIh1Vp10nBGlMzElNe7TaesXcwDW3PZbMuuuVu+uj
	e0Ge0XfGP9vnRZ0s7nJ/y3+8iuu5z4k5N3Ie+P956RYm+mOVtaDeob83HUrMLlW1Tp26dp6l
	g1vKGV7ur/5lmpVLlzlesT3peVn0o5PFj9wXUwXMiqzOyHwIUWIpzkg01GIuKk4EAHyF10k+
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsXCNUNLT3fdp/AMg00nNS3mrF/DZvHk/29W
	i8/PXjNbHJ57ktXi3pr/rBaHv75hsvi9bQWbA7vHplWdbB6bPk1i9zgx4zeLx4vNMxk9vt32
	8Fj84gNTAFsUl01Kak5mWWqRvl0CV8atS00sBVs0K/59LWhgPKPUxcjJISFgIjFl7iJWEJtN
	QE3iystJTF2MHBwiAlYS03bEgoSZBVYwSsxbEQdiCwu4S6yf3sIOYrMIqEoc2H0HrJVXwEyi
	6cQ6VoiRmhKPt/8Eq+EUMJdYv+Y8M4gtBFTz9eAPqHpBiZMzn7BAzJeXaN46m3kCI88sJKlZ
	SFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbbsto/E3cwfrnsfohRgINRiYf35cGw
	DCHWxLLiytxDjBIczEoivIecgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNT
	UwtSi2CyTBycUg2M4io/1pUWxjN+aMwtquvLq5n+7njC7PU9dx6fmlNbOYWBpcNNVHzlrKDz
	iet6r0ed/uC3Y3ZXy5/SOA2tksVSZZ+qJ82RdN03VdDit/ban4sO2O5xX91j83XC09wlj1/N
	vbhn85Z8o6XnL7xbf2HazgT2dVJXQzcdYbnNe/9WajF75qXgukaDQ0osxRmJhlrMRcWJAPRm
	45QzAgAA
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
  /sys/module/wsse/parameters/enable
  /sys/module/prcl/parameters/enable
  /sys/module/mtier/parameters/enable

After:
  /sys/module/wsse/parameters/enabled
  /sys/module/prcl/parameters/enabled
  /sys/module/mtier/parameters/enabled

There is no functional changes in this patch.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>
---
 samples/damon/mtier.c | 16 ++++++++--------
 samples/damon/prcl.c  | 16 ++++++++--------
 samples/damon/wsse.c  | 16 ++++++++--------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index f3220d6e6739..cb273bf4b5c2 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -33,14 +33,14 @@ module_param(node0_mem_free_bp, ulong, 0600);
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
 
@@ -160,17 +160,17 @@ static void damon_sample_mtier_stop(void)
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool enable = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == enable)
 		return 0;
 
-	if (enable)
+	if (enabled)
 		return damon_sample_mtier_start();
 	damon_sample_mtier_stop();
 	return 0;
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 056b1b21a0fe..e8fe596704cc 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -17,14 +17,14 @@ module_param(target_pid, int, 0600);
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
@@ -112,17 +112,17 @@ static void damon_sample_prcl_stop(void)
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool enable = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == enable)
 		return 0;
 
-	if (enable)
+	if (enabled)
 		return damon_sample_prcl_start();
 	damon_sample_prcl_stop();
 	return 0;
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 11be25803274..5039d534fdb6 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -18,14 +18,14 @@ module_param(target_pid, int, 0600);
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
@@ -92,17 +92,17 @@ static void damon_sample_wsse_stop(void)
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool enable = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == enable)
 		return 0;
 
-	if (enable)
+	if (enabled)
 		return damon_sample_wsse_start();
 	damon_sample_wsse_stop();
 	return 0;
-- 
2.34.1

