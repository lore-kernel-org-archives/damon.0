Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281139DBFB
	for <damon@lists.linux.dev>; Wed,  8 Apr 2026 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635980; cv=none; b=okh39ARmIMOjJrBg4Vpm1xvmbZtBpmC447XpCxRvFmeaWdOw1SaJhmFXYJREY/UCjnEEl4XEQrQ/3ng+gywSmru9qYV9hp5evNsq6f0Y/ckV0L+0tBBPdMe9stHqP3cyV3YKf4nJVpgMqY1Wqkqj2/tElxDPoOfNaEhLXljmLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635980; c=relaxed/simple;
	bh=PYXPwETbLUM3DB7HrG4AVDBKhlqeg7uj+L89amm6MYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9yHrzqBDXDMSMVzTZhXZN/y821kmZnuALrvvb0EN7VmXhfS++GuEW7/PP/jUqL2pUITqjAjvwz0NrwpWko85ZBfnie+WIqbZd0clfbTDO4PzaHY+MoEMmTXcTj5qdrStU/NAJSSD/LK1voM30g69sQfGkdGQRXvGHyiql1eUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=d4CwHB7T; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="d4CwHB7T"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=D4Dc8j1nfmErNosxziXn1qD0pEKNNpyJIdOEd8MGydE=;
	b=d4CwHB7T/BfpIiJ9dxUhjmmqhh85oduzMsFRGGSxQM14aLEvKGDhQbZtHwo9cdM7+OPCEiQo1
	BOeFiMsk35DS4SbTbDvGo8RdKJ7naiTIWHP8+Z8wiGU7UcVctaObnlUVr/gZK9yzV3URSaJ0ESc
	RXhfXzEu/dnJZJKe4GacfEc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4frFyM02KHz1prLc;
	Wed,  8 Apr 2026 16:06:35 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id D59DE40576;
	Wed,  8 Apr 2026 16:12:51 +0800 (CST)
Received: from huawei.com (10.50.87.63) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Apr
 2026 16:12:51 +0800
From: Lin Ruifeng <linruifeng4@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <chenjun102@huawei.com>,
	<tongtiangen@huawei.com>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/damon: support freeze kdamond
Date: Wed, 8 Apr 2026 16:06:52 +0800
Message-ID: <20260408080652.1745410-1-linruifeng4@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500012.china.huawei.com (7.185.36.8)

During suspend and resume, the data monitored by kdamond is
no longer meaningful. Meanwhile, since kdamond may involve
I/O operations, it is necessary to freeze it.

Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3e1890d64d06..5cd1f0aed66b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_choices.h>
+#include <linux/freezer.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
@@ -2753,6 +2754,7 @@ static int kdamond_fn(void *data)
 
 	complete(&ctx->kdamond_started);
 	kdamond_init_ctx(ctx);
+	set_freezable();
 
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
@@ -2774,6 +2776,8 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 
+		try_to_freeze();
+
 		if (kdamond_wait_activation(ctx))
 			break;
 
-- 
2.43.0

