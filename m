Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BAB37649B
	for <damon@lists.linux.dev>; Mon,  2 Feb 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044258; cv=none; b=j9GvL5tjSuQulx9u2DTasJslnyNR122v1uL21PUVhblblTInXTpWfv44magTvfEeb2CR8RgqpOvXojX5YZrwvhCX4M+gDuzxPQPbAUrhHLPHpSs64kivr9p+qeI+2hlwYEkMo0umhbOPuN9tEU20aaZNer1dFx6auVE84ZbmgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044258; c=relaxed/simple;
	bh=jvIqWr/roJaqitIQaLbC5TmcuXVJ+whYeT8cykKkXQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utvNWqDBZbbtrSjXCJfSAMoaBK4nEJQtVFWWiGOw11xzcAcK9mn5mNSWPB6D4yHg2ifZRrlUdkrbGx8HNYAUBYWO6ca5o0XU+JPcV17jhXhYgP6F0krPvWxjEFhlOpIKsnbYRN5AB2UJdnOnlMYcLxdmAN658mV/1FC5nXH2uG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4V7Q6JvLzHnH83;
	Mon,  2 Feb 2026 22:56:34 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F48440584;
	Mon,  2 Feb 2026 22:57:32 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 17:57:32 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <sj@kernel.org>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/4] mm/damon: Generic context creation for modules
Date: Mon, 2 Feb 2026 14:56:46 +0000
Message-ID: <20260202145650.1795854-2-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
References: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
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

Damon_modules_new_paddr_ctx_target. This works  only for physical contexts.
In case of virtual addresses, we should  duplicate the code.

It is more elegant to have a generic version of new context creation which
receives the mode as a parameter.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
---
 mm/damon/lru_sort.c       | 6 ++++--
 mm/damon/modules-common.c | 7 ++++---
 mm/damon/modules-common.h | 5 +++--
 mm/damon/reclaim.c        | 5 +++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 49b4bc294f4e..ac34b02dace8 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -201,7 +201,8 @@ static int damon_lru_sort_apply_parameters(void)
 	unsigned int hot_thres, cold_thres;
 	int err;
 
-	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
+	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
+				DAMON_OPS_PADDR);
 	if (err)
 		return err;
 
@@ -375,7 +376,8 @@ static int __init damon_lru_sort_init(void)
 		err = -ENOMEM;
 		goto out;
 	}
-	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	err = damon_modules_new_ctx_target(&ctx, &target,
+				DAMON_OPS_PADDR);
 	if (err)
 		goto out;
 
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 86d58f8c4f63..5ba24e0ad9a1 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -14,8 +14,9 @@
  * @ctxp:	Pointer to save the point to the newly created context
  * @targetp:	Pointer to save the point to the newly created target
  */
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
+				struct damon_target **targetp,
+				enum damon_ops_id mode)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -24,7 +25,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+	if (damon_select_ops(ctx, mode)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f103ad556368..87d8058d7d85 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -45,5 +45,6 @@
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
 
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp);
+int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
+				struct damon_target **targetp,
+				enum damon_ops_id mode);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 36a582e09eae..b64fb810e096 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -197,7 +197,8 @@ static int damon_reclaim_apply_parameters(void)
 	struct damos_filter *filter;
 	int err;
 
-	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
+	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
+				DAMON_OPS_PADDR);
 	if (err)
 		return err;
 
@@ -379,7 +380,7 @@ static int __init damon_reclaim_init(void)
 		err = -ENOMEM;
 		goto out;
 	}
-	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);
 	if (err)
 		goto out;
 
-- 
2.43.0

