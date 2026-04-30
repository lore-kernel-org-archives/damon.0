Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70B427A1C
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556526; cv=none; b=Y1OlBKG8YjOWcRhpuw86hpe03Ngfy+wQtfRZofUqEPc6aPOrzF4wHVlQm1sfsZ2FPl9s0/wmp8Nc3FYpyguCUYTpxr3LQSEwpvog/ODigeAe8Cc9jiyTj1tN4id9ZsWJ2ajKXquHHHDfw5MfSkRLU/m2XnU/O1a1jxL+bHSzcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556526; c=relaxed/simple;
	bh=a/H6IUrK3j+tVSB0rF6xfdCyzJM2+BhT/Br7xejSvak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNAK5+sbpQUmXWrPmPCfM+325aJthn39yeB1R5xqdwIvKI4Qi7QCnsIuav11Dz2yYPWg5+RMj4eDlRUMKD0hsL7kJKoW7YHcZk9I/ru23ptG0RggawgSqDSRX1s0b+j3AO7lNe1ZVsm0iI/4PB3LWPihIFrMM2wIDifEAk7IOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5wLz4LN2zJ46Zq;
	Thu, 30 Apr 2026 21:41:47 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D939140569;
	Thu, 30 Apr 2026 21:41:54 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 16:41:54 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/4] mm/damon: Generalize ctx_target creation for damon_ops_id and add vaddr support
Date: Thu, 30 Apr 2026 13:41:36 +0000
Message-ID: <20260430134139.2446417-2-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
References: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

This patch adds a new function damon_modules_new_vaddr_ctx_target.
Since ctx_target creation for vaddr and  paddr is almost identical,
the logic is extracted to a new function,
damon_modules_new_ctx_target, and vaddr and paddr functions are
left just as interfaces.

This change was suggested earlier1 and it is needed to allow
developers to create DAMON modules that use DAMON_OPS_VADDR targets.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Suggested-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.c | 33 +++++++++++++++++++++++++--------
 mm/damon/modules-common.h |  3 +++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 86d58f8c4f63..35a4a89b6caa 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -9,13 +9,8 @@
 
 #include "modules-common.h"
 
-/*
- * Allocate, set, and return a DAMON context for the physical address space.
- * @ctxp:	Pointer to save the point to the newly created context
- * @targetp:	Pointer to save the point to the newly created target
- */
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+static int _damon_modules_new_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp, enum damon_ops_id id)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -24,7 +19,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+	if (damon_select_ops(ctx, id)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
@@ -40,3 +35,25 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
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
+	return _damon_modules_new_ctx_target(ctxp, targetp, DAMON_OPS_PADDR);
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
+	return _damon_modules_new_ctx_target(ctxp, targetp, DAMON_OPS_VADDR);
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

