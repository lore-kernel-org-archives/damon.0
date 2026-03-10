Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D63BF690
	for <damon@lists.linux.dev>; Tue, 10 Mar 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159939; cv=none; b=tR+1SKMBNLrfdFCV6jdQvZR+Vqs06dbl1X6ankPnf+ko5nIpgQnBrC2jO5p+IflB6OvQhLsN17XhWbzkTwLGOT4p0aw4F2XIgHrjbM4+jY7rVBr9eMbJqEOjH/pDufzdNTEDzj06Xs7xM+Zsnfxlsx96WUvJVn4ENZPKAN7Uc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159939; c=relaxed/simple;
	bh=IXH2O5agTgh9CJ1mRB/AuCT8El7x5dwINlrV7qaZ+5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xm9VfXRLgx+FbT6PEFOtDV5dLBqwf6vRCl3Fe2mwSNQg+k+ykJrTg10rcAIy38usNVmr1qz1dbC1l28W5zK/0qL/iAuIPJ4ucQ+kCQ4R3EglqXViXKSLkHlV94ln0g7UmlJ1e+SQvmadFhClYXo76Z36xxpjFbgt5zUjZJtx590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fVfNd1dkxzJ467N;
	Wed, 11 Mar 2026 00:24:49 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F59840086;
	Wed, 11 Mar 2026 00:25:34 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 19:25:33 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/4] mm/damon: Generic context creation for modules
Date: Tue, 10 Mar 2026 16:24:17 +0000
Message-ID: <20260310162420.4180562-2-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310162420.4180562-1-gutierrez.asier@huawei-partners.com>
References: <20260310162420.4180562-1-gutierrez.asier@huawei-partners.com>
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

It is more elegant to have a generic version of new context creation
which receives the mode as a parameter.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
---
 mm/damon/lru_sort.c       | 5 +++--
 mm/damon/modules-common.c | 6 +++---
 mm/damon/modules-common.h | 4 ++--
 mm/damon/reclaim.c        | 5 +++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 7bc5c0b2aea3..143ee0b21da6 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -287,7 +287,8 @@ static int damon_lru_sort_apply_parameters(void)
 	unsigned int hot_thres, cold_thres;
 	int err;
 
-	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
+	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
+				DAMON_OPS_PADDR);
 	if (err)
 		return err;
 
@@ -479,7 +480,7 @@ static int __init damon_lru_sort_init(void)
 		err = -ENOMEM;
 		goto out;
 	}
-	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);
 	if (err)
 		goto out;
 
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 86d58f8c4f63..ae50b2fa3a86 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -14,8 +14,8 @@
  * @ctxp:	Pointer to save the point to the newly created context
  * @targetp:	Pointer to save the point to the newly created target
  */
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp, enum damon_ops_id mode)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -24,7 +24,7 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+	if (damon_select_ops(ctx, mode)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f103ad556368..379b49c6a617 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -45,5 +45,5 @@
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
 
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp);
+int damon_modules_new_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp, enum damon_ops_id mode);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 43d76f5bed44..24786a58683a 100644
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
 
@@ -381,7 +382,7 @@ static int __init damon_reclaim_init(void)
 		err = -ENOMEM;
 		goto out;
 	}
-	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	err = damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_PADDR);
 	if (err)
 		goto out;
 
-- 
2.43.0

