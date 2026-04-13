Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C53469F4
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092494; cv=none; b=UIPi2RPFW8WLlFrg016Ega9iWRSf26eOGSE7LqFV3p6pM5fybbikwkoRJ9uHCgfKqthWMD8C4ghqgZeRHFxo6kHjCBrxRPy14AgCkeqzONf3JQ3OH/kvxbdjHVdVuoalwSFf8O3Q+TdmCM1L/9G5K00hVC0HMk4VsHNyDTBQn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092494; c=relaxed/simple;
	bh=yPetEIMlup6d7Bq8mbtfi3SnpCzoyyyqfMqQj847JVU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CzdDLSV1OZlC+Tzh9q/ejj46HEYRacupbh5oeJAA+KWQFnihdzFA1L8Deroy1nq4ENV/iDNymkBSIxR+0bI58EhepX3SWhgSaXu5NjE21v1qZQUdhvaKrJ8IXse0gJIgcD/KkiaQUsb5R+zTzXeanUO5ATW5e/nab24Ag0dz3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fvVwX3XmBzHnH2m;
	Mon, 13 Apr 2026 23:01:16 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C09974057A;
	Mon, 13 Apr 2026 23:01:28 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 18:01:28 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/1] mm/damon: generalize ctx_target creation for damon_ops_id and add vaddr support
Date: Mon, 13 Apr 2026 14:59:43 +0000
Message-ID: <20260413145943.512192-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

This patch adds a new function damon_modules_new_vaddr_ctx_target.
Since ctx_target creation for vaddr and paddr is almost identical,
the logic is extracted to a new function,
damon_modules_new_ctx_target, and vaddr and paddr functions are left
just as interfaces.

This change was suggested earlier[1] and it is needed to allow
developers to create DAMON modules that use DAMON_OPS_PADDR targets.

[1]: https://lore.kernel.org/damon/20260311005759.90440-1-sj@kernel.org/

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Suggested-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.c | 31 +++++++++++++++++++++++++++----
 mm/damon/modules-common.h |  3 +++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 86d58f8c4f63..fe12d109c87b 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -10,12 +10,13 @@
 #include "modules-common.h"
 
 /*
- * Allocate, set, and return a DAMON context for the physical address space.
+ * Allocate, set, and return a DAMON context.
  * @ctxp:	Pointer to save the point to the newly created context
  * @targetp:	Pointer to save the point to the newly created target
+ * @id:	Set of operations, physical or virtual
  */
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+static int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp, enum damon_ops_id id)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -24,7 +25,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+	if (damon_select_ops(ctx, id)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
@@ -40,3 +41,25 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 	*targetp = target;
 	return 0;
 }
+
+/*
+ * Allocate, set, and return a DAMON context for the physical address space.
+ * @ctxp:	Pointer to save the point to the newly created context
+ * @targetp:	Pointer to save the point to the newly created target
+ */
+int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp)
+{
+	return damon_modules_new_ctx_target(ctxp, targetp, DAMON_OPS_PADDR);
+}
+
+/*
+ * Allocate, set, and return a DAMON context for the virtual address space.
+ * @ctxp:	Pointer to save the point to the newly created context
+ * @targetp:	Pointer to save the point to the newly created target
+ */
+int damon_modules_new_vaddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp)
+{
+	return damon_modules_new_ctx_target(ctxp, targetp, DAMON_OPS_VADDR);
+}
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f103ad556368..324b9cb4957e 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -47,3 +47,6 @@
 
 int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 		struct damon_target **targetp);
+
+int damon_modules_new_vaddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp);
-- 
2.43.0

