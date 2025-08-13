Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C822BE620
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057162; cv=none; b=Iegvgcf6gLEeLpO4920zrAxqOogWI+wlocXvbnDMws2x+xpK76FIwBOseaDDOFqRDZSBvJWk+PubMAoX/uBtZ/NGqEoJIsgTI1dp9h6DOOMbZdOxRlB5sftX5hGQWCpxe5UWTIqKK7V6WvqzBtY1eY9jA8t6lWhC88RQoryO6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057162; c=relaxed/simple;
	bh=NPl6Roqme+Eca9XUDIdnx22Kx5TjGaW/ZJ+9UNI8550=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhdwd/MSlqcf3ecLq72qi1KLETdJqcJhF9kIg5SuDf2TesVjpoWTnZPqX329Bm0Mvi+3tJPhOQTx9wLmOPJ+JhgG+/BWa6iUqt40geyOWKyve9kOsnqW7tZswMe30fjm4M8pYOvmLfoqLoBOpJY+ADAXVGp66eCVRcD1euq0hmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1vWv5tP6z1R902;
	Wed, 13 Aug 2025 11:49:47 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id AB8D114027A;
	Wed, 13 Aug 2025 11:52:37 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:36 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 11/16] mm/damon: add addr_unit for DAMON_RECLAIM and LRU_SORT
Date: Wed, 13 Aug 2025 13:07:01 +0800
Message-ID: <20250813050706.1564229-12-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: <20250813050706.1564229-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

In module DAMON_RECLAIM and DAMON_LRU_SORT, the damon_ctx is
independent of the core, necessitating dedicated addr_unit
integration for these features.
Additionally, if the input monitor_region_start and monitor_region_end
are both 0 while addr_unit is set to a non-zero valuethe default
system RAM range should be divided by addr_unit.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 include/linux/damon.h     |  4 +++-
 mm/damon/core.c           | 14 ++++++++++----
 mm/damon/lru_sort.c       | 16 +++++++++++++---
 mm/damon/modules-common.c |  5 ++++-
 mm/damon/modules-common.h |  2 +-
 mm/damon/reclaim.c        | 16 +++++++++++++---
 mm/damon/stat.c           |  2 +-
 7 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b85c6c669cd0..1b7b4cf1a3c5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -942,7 +942,9 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-				unsigned long *start, unsigned long *end);
+						unsigned long *start,
+						unsigned long *end,
+						unsigned long addr_unit);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1a8d3009d606..803c30f64b94 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2714,6 +2714,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * @t:		The monitoring target to set the region.
  * @start:	The pointer to the start address of the region.
  * @end:	The pointer to the end address of the region.
+ * @addr_unit:	Scale factor for core to ops address conversion.
  *
  * This function sets the region of @t as requested by @start and @end.  If the
  * values of @start and @end are zero, however, this function finds the biggest
@@ -2724,16 +2725,21 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-			unsigned long *start, unsigned long *end)
+						unsigned long *start,
+						unsigned long *end,
+						unsigned long addr_unit)
 {
 	struct damon_addr_range addr_range;
 
 	if (*start > *end)
 		return -EINVAL;
 
-	if (!*start && !*end &&
-		!damon_find_biggest_system_ram(start, end))
-		return -EINVAL;
+	if (!*start && !*end) {
+		if (!damon_find_biggest_system_ram(start, end) || !addr_unit)
+			return -EINVAL;
+		*start /= addr_unit;
+		*end /= addr_unit;
+	}
 
 	addr_range.start = *start;
 	addr_range.end = *end;
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 151a9de5ad8b..8107d08c5e4b 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -111,6 +111,14 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
+/*
+ * Scale factor for DAMON_LRU_SORT to ops address conversion.
+ *
+ * This parameter is used to convert to the actual physical address.
+ */
+static unsigned long addr_unit __read_mostly = 1;
+module_param(addr_unit, ulong, 0600);
+
 /*
  * PID of the DAMON thread
  *
@@ -194,7 +202,8 @@ static int damon_lru_sort_apply_parameters(void)
 	unsigned int hot_thres, cold_thres;
 	int err;
 
-	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
+	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target,
+			addr_unit);
 	if (err)
 		return err;
 
@@ -221,7 +230,8 @@ static int damon_lru_sort_apply_parameters(void)
 
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
-					&monitor_region_end);
+					&monitor_region_end,
+					addr_unit);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
@@ -323,7 +333,7 @@ MODULE_PARM_DESC(enabled,
 
 static int __init damon_lru_sort_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	int err = damon_modules_new_paddr_ctx_target(&ctx, &target, 1);
 
 	if (err)
 		goto out;
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 86d58f8c4f63..613b7cc99368 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -13,9 +13,10 @@
  * Allocate, set, and return a DAMON context for the physical address space.
  * @ctxp:	Pointer to save the point to the newly created context
  * @targetp:	Pointer to save the point to the newly created target
+ * @addr_unit:	Scale factor for modules to ops address conversion.
  */
 int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+		struct damon_target **targetp, unsigned long addr_unit)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -24,6 +25,8 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->addr_unit = addr_unit;
+
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f103ad556368..c7048a449321 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -46,4 +46,4 @@
 			0400);
 
 int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp);
+		struct damon_target **targetp, unsigned long addr_unit);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3c71b4596676..0e11b121d693 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -128,6 +128,14 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
+/*
+ * Scale factor for DAMON_RECLAIM to ops address conversion.
+ *
+ * This parameter is used to convert to the actual physical address.
+ */
+static unsigned long addr_unit __read_mostly = 1;
+module_param(addr_unit, ulong, 0600);
+
 /*
  * Skip anonymous pages reclamation.
  *
@@ -190,7 +198,8 @@ static int damon_reclaim_apply_parameters(void)
 	struct damos_filter *filter;
 	int err;
 
-	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
+	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target,
+			addr_unit);
 	if (err)
 		return err;
 
@@ -229,7 +238,8 @@ static int damon_reclaim_apply_parameters(void)
 
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
-					&monitor_region_end);
+					&monitor_region_end,
+					addr_unit);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
@@ -327,7 +337,7 @@ MODULE_PARM_DESC(enabled,
 
 static int __init damon_reclaim_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	int err = damon_modules_new_paddr_ctx_target(&ctx, &target, 1);
 
 	if (err)
 		goto out;
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 87bcd8866d4b..ae7377e7409f 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -181,7 +181,7 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	if (damon_set_region_biggest_system_ram_default(target, &start, &end))
+	if (damon_set_region_biggest_system_ram_default(target, &start, &end, ctx->addr_unit))
 		goto free_out;
 	return ctx;
 free_out:
-- 
2.34.1

