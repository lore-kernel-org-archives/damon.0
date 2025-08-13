Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E492BEC44
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057163; cv=none; b=AcInThul9uld9hxthH8vBX21u5kTw9VOAmNs596nWKnOcVlBR4HpYLf5yOR0uPHEbNYfW7XUBdj6/QzsvKSzeMZltQR1Dhyfb9pDD0tXJwIUr9W1AHZJGPbjKMOdjja4B78lesmV3gyRuB/xVLIwb8Xcfv7hm/WBBQwtOqWnYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057163; c=relaxed/simple;
	bh=6OQWbs0ie8Bbvcb/zi1GEW9dbd6YPXGmply5Lej6GMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9E2lo8RRhP39e8LOQkPp8dJd4e77xWYMwZCL7gmOykcFOkkune7/4sd7tbLStbOZiGXwhU01vWoU04b2VmvAbisqcRbOQylfDayJW9tQZ4K2ep4OdUGCOSGSGniUPwfkVny+rF6FRQVR3G5Hi3a4eTYyNvCM1CMxrbPtij0DMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c1vZ26v1JztTC0;
	Wed, 13 Aug 2025 11:51:38 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 37FD5140202;
	Wed, 13 Aug 2025 11:52:39 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:38 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 13/16] mm/damon/sysfs: ensure valid addr_unit setting in damon_sysfs_apply_inputs()
Date: Wed, 13 Aug 2025 13:07:03 +0800
Message-ID: <20250813050706.1564229-14-yanquanmin1@huawei.com>
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

By calling damon_sysfs_turn_damon_on(), the execution of damon_commit_ctx()
can be bypassed. Therefore, it is necessary to prevent ctx->addr_unit from
being set to 0 in damon_sysfs_apply_inputs() and update min_region to avoid
potential issues.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index bea782b0a711..122824776c1d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1422,7 +1422,8 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
-	ctx->addr_unit = sys_ctx->addr_unit;
+	ctx->addr_unit = sys_ctx->addr_unit ? : 1;
+	ctx->min_region = max(DAMON_MIN_REGION / ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.34.1

