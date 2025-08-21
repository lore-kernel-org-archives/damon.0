Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9330E0EF
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774385; cv=none; b=VhtKkEMzBPFVWD7Q4FD5H41wgkw2v4Fi1C2zS0Ril/01Ue6zUUgoXF2JDQECfO47XI8C93SGCtZyQQkHzXllLmooOmZkuXijzg4Q6VMotE1OrzUR3etwECClVvysbbHqCu209Ui1AentEfFhyUYZ06UHjcVQkH4xp9/jTNkOnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774385; c=relaxed/simple;
	bh=kqnBYhIo4vIFGFEmrBFFNZvMTh7eSL8e5UmHnXwEYL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqF7Xesjg+XIZrw7zfebVaRGC2GuqILrh1Ihg6bnaUDmAb8Y3GsLlyhA72RJexrGkAGSa4hZHU675Gq9hPosDBR3EoUsAOHMyfrn7hOk4YT5YlBITvAWbkOuAwwfoUvUCGImpj54Yn+E8cN7ad3DZMZWrmoJ/YJHyGTZa3B8aaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c70rT0CPQz27jH5;
	Thu, 21 Aug 2025 19:06:49 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 821041400DA;
	Thu, 21 Aug 2025 19:05:43 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 19:05:42 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 01/11] mm/damon/core: add damon_ctx->addr_unit
Date: Thu, 21 Aug 2025 18:51:49 +0800
Message-ID: <20250821105159.2503894-2-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821105159.2503894-1-yanquanmin1@huawei.com>
References: <20250821105159.2503894-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200018.china.huawei.com (7.185.36.31)

From: SeongJae Park <sj@kernel.org>

In some cases, some of the real address that handled by the underlying
operations set cannot be handled by DAMON since it uses only 'unsinged
long' as the address type.  Using DAMON for physical address space
monitoring of 32 bit ARM devices with large physical address extension
(LPAE) is one example[1].

Add a parameter name 'addr_unit' to core layer to help such cases.
DAMON core API callers can set it as the scale factor that will be used
by the operations set for translating the core layer's addresses to the
real address by multiplying the parameter value to the core layer
address.  Support of the parameter is up to each operations set layer.
The support from the physical address space operations set (paddr) will
be added with following commits.

[1] https://lore.kernel.org/20250408075553.959388-1-zuoze1@huawei.com

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 include/linux/damon.h | 3 ++-
 mm/damon/core.c       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d01bfee80bd6..6fa52f7495d9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -746,7 +746,7 @@ struct damon_attrs {
  * Accesses to other fields must be protected by themselves.
  *
  * @ops:	Set of monitoring operations for given use cases.
- *
+ * @addr_unit:	Scale factor for core to ops address conversion.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -788,6 +788,7 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct damon_operations ops;
+	unsigned long addr_unit;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index cb41fddca78c..8f8aa84953ac 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -544,6 +544,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	ctx->addr_unit = 1;
+
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
@@ -1245,6 +1247,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 			return err;
 	}
 	dst->ops = src->ops;
+	dst->addr_unit = src->addr_unit;
 
 	return 0;
 }
-- 
2.43.0

