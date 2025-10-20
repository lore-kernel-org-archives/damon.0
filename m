Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532C2FD7C7
	for <damon@lists.linux.dev>; Mon, 20 Oct 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966235; cv=none; b=M8tk57y3ReGr+cTbKrta7tmg/JDOyrGVpjoTOJ1vR8Ghe31BEIMh0yr+3iCg1w+e2dux3BRMGhG8Xcsb21pEaVzf38w9MziI+dvraY+m6RxbuB22re4SJ2p1AXYHAlp74xl7hVhEgnw2ZPqmBqSGmBwIVjIUQOBL0ZKyrvPGE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966235; c=relaxed/simple;
	bh=72/eKEewF1yLnofGStpeC9RG258u5h/4R3ySthE2qHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfImY3TgEOHZQtlxLE9toMRwlDKRZ2QdQiOpEteDuIe1ITN9k7TDHSuDLi+s08RPQcdb/Ql5yQ9de26J4fCGSgg9yScvNTkpAnjiH9dIxvy+LL5cdY5K7erG/FhBX8E3jpliX2TCvgSn/lkNqtu2L5xijYODsFvbTepa6I4bQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g5VLyWi4; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g5VLyWi4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+hzZWxSIYi+JVfYnlDNwIrYbUMB0DxpyA9gkTSqNtlA=;
	b=g5VLyWi4O3Y2K82/N8WkX2UDJiZzoqRrDR//Q0iFzgGbzZgbzTwvVJMK3qwqrUOoygL+6+O2v
	9urAr0RbXO4rpJavMpmvC+3IDBpAlVjfNd27zafHeGB+sy2nRUvpyeIaqRnVuV1pktTmbljmF4J
	oKKv/7Eug7rrK8tUO/gXiNk=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cqwtb2lHtz1prQ0;
	Mon, 20 Oct 2025 21:16:39 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DE621402DA;
	Mon, 20 Oct 2025 21:17:03 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 21:17:02 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 2/2] mm/damon/reclaim: use min_sz_region for core address alignment when setting regions
Date: Mon, 20 Oct 2025 21:01:25 +0800
Message-ID: <20251020130125.2875164-3-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020130125.2875164-1-yanquanmin1@huawei.com>
References: <20251020130125.2875164-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

When setting regions in DAMON_RECLAIM, DAMON_MIN_REGION will be applied
as the core address alignment, and the monitoring target address ranges
would be aligned on DAMON_MIN_REGION * addr_unit. When users 1) set
addr_unit to a value larger than 1, and 2) set the monitoring target
address range as not aligned on DAMON_MIN_REGION * addr_unit, it will
cause DAMON_RECLAIM to operate on unexpectedly large physical address
ranges.

For example, if the user sets the monitoring target address range to
[4, 8) and addr_unit as 1024, the aimed monitoring target address range
is [4 KiB, 8 KiB). Assuming DAMON_MIN_REGION is 4096, so resulting
target address range will be [0, 4096) in the DAMON core layer address
system, and [0, 4 MiB) in the physical address space, which is an
unexpected range.

To fix the issue, use min_sz_region for core address alignment when
setting regions.

Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e30811cafe90..36a582e09eae 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -251,7 +251,7 @@ static int damon_reclaim_apply_parameters(void)
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
-					DAMON_MIN_REGION);
+					param_ctx->min_sz_region);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
-- 
2.43.0

