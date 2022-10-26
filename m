Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1D7B
	for <damon@lists.linux.dev>; Wed, 26 Oct 2022 22:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A76C433C1;
	Wed, 26 Oct 2022 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666825196;
	bh=xh7wrkUfCZyyYQCz1FTbZYGhTBtYeEWznNRmu6lB2kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iT929Iyg7VIVF+XtoOZCDIZ7VUEBLbW2jCx3W7Ewsr5rU+hfe41kcCPbUEGFk+hRS
	 hP2v1ya1nU1ayJdJ6IuzW0p1iP1U7fMeBogqwg2mO/EM7Z+ycHQWGQs13rvCZmyj8J
	 tD/H77e9OBtuoYDA1F7Puk3ZJq16ngy1tojzFMjtcet85BaWbimDvD4e704++rE39c
	 iyT8h1C8MyG4q2bAw0dVoqzPFMiK67vGQ8wo68kRUy6ePchmHJjxWWjrQ+/V2muOpW
	 q7F6eRDvKgJhodfgYyiyNhLaVj1MShih235EUJhhT/DGAQ4H/qeZPiz2ZqzfYf60xD
	 JpiOjaNVwTJaQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 11/12] mm/damon/modules: deduplicate init steps for DAMON context setup
Date: Wed, 26 Oct 2022 22:59:42 +0000
Message-Id: <20221026225943.100429-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT has duplicated code for DAMON context and
target initializations.  Deduplicate the part by implementing a function
for the initialization in 'modules-common.c' and using it.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/Makefile         |  4 ++--
 mm/damon/lru_sort.c       | 17 +++-------------
 mm/damon/modules-common.c | 42 +++++++++++++++++++++++++++++++++++++++
 mm/damon/modules-common.h |  3 +++
 mm/damon/reclaim.c        | 17 +++-------------
 5 files changed, 53 insertions(+), 30 deletions(-)
 create mode 100644 mm/damon/modules-common.c

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 1e86f5253d7f..f7add3f4aa79 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -5,5 +5,5 @@ obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
-obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
-obj-$(CONFIG_DAMON_LRU_SORT)	+= lru_sort.o
+obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
+obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index efbc2bda8b9c..a1896c5acfe9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -314,25 +314,14 @@ static int damon_lru_sort_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_lru_sort_init(void)
 {
-	ctx = damon_new_ctx();
-	if (!ctx)
-		return -ENOMEM;
+	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
-		damon_destroy_ctx(ctx);
-		return -EINVAL;
-	}
+	if (err)
+		return err;
 
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
 
-	target = damon_new_target();
-	if (!target) {
-		damon_destroy_ctx(ctx);
-		return -ENOMEM;
-	}
-	damon_add_target(ctx, target);
-
 	schedule_delayed_work(&damon_lru_sort_timer, 0);
 
 	damon_lru_sort_initialized = true;
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
new file mode 100644
index 000000000000..b2381a8466ec
--- /dev/null
+++ b/mm/damon/modules-common.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Primitives for DAMON Modules
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#include <linux/damon.h>
+
+#include "modules-common.h"
+
+/*
+ * Allocate, set, and return a DAMON context for the physical address space.
+ * @ctxp:	Pointer to save the point to the newly created context
+ * @targetp:	Pointer to save the point to the newly created target
+ */
+int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *target;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+
+	*ctxp = ctx;
+	*targetp = target;
+	return 0;
+}
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 5a4921851d32..f49cdb417005 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -44,3 +44,6 @@
 			0400);						\
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
+
+int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 162c9b1ca00f..3173f373435c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -256,25 +256,14 @@ static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_reclaim_init(void)
 {
-	ctx = damon_new_ctx();
-	if (!ctx)
-		return -ENOMEM;
+	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
-		damon_destroy_ctx(ctx);
-		return -EINVAL;
-	}
+	if (err)
+		return err;
 
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
-	target = damon_new_target();
-	if (!target) {
-		damon_destroy_ctx(ctx);
-		return -ENOMEM;
-	}
-	damon_add_target(ctx, target);
-
 	schedule_delayed_work(&damon_reclaim_timer, 0);
 
 	damon_reclaim_initialized = true;
-- 
2.25.1

