Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3EDF71
	for <damon@lists.linux.dev>; Tue, 28 Oct 2025 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632334; cv=none; b=vAYgeA2KlYv9dMBJ1F8qnvQ7nOEn/C03lgtfP2VUb6pBSNAxJ9n+dwLw2ta+wK4+fTtV1qAY9ilGuMCe/XjuwnUDcsztfaKtxGHikPJXmHiHxoRF6HgBsLojB3+ZqugawxI78n9hIqWE5cZI9iQAPJVHesu4gccCsfc/NSQnWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632334; c=relaxed/simple;
	bh=4nEEcZQrJS15+2zFMypct11dj67w7o5mAkbMFUFV+rY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bmJlEY2xfwOklgW77ZUznknPf3mEyQGCd2HOIES++R0EdvCjDbNF+3cKxRTaW9IE6C4icIkq0Xg05Juizu0y3l5s2Sn4D/Zr7AUpYpnpZUSkafhHAwe9VR9NVvJA7rNoPzRgumgA3i9xQZqCc7WIEPB6sKurjju7uRsPP9sdCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q0zkTcDR; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q0zkTcDR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Xq9ZpBKijRP4yN0dW1eTvhFf2QVdu1P/bLYVpE2xac4=;
	b=Q0zkTcDRWzoy2qrLKW917T7U0pYBoZvoP+MlBy/OSKPYNdKxaJLI58w5moDfgBIUk9jUqXyF2
	u9/Cuuw3E29oFpSTKnQNPBWxdV9+opsJQreD3AtklCeJT7zqWgXUP6IHN1cGUbHVY3L1h+Kv5yb
	QHr/QpepM3Q34x9FoTwZLLc=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cwgDC3bNxzKm6s;
	Tue, 28 Oct 2025 14:18:19 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 9087F14027A;
	Tue, 28 Oct 2025 14:18:47 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 14:18:46 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH] mm/damon/stat: set last_refresh_jiffies to jiffies at startup
Date: Tue, 28 Oct 2025 14:19:27 +0800
Message-ID: <20251028061927.1378746-1-yanquanmin1@huawei.com>
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
 dggpemf200018.china.huawei.com (7.185.36.31)

In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
avoid unnecessarily frequent stat update.

On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
jiffies wrap bugs appear earlier. However, this causes time_before_eq()
in DAMON_STAT to unexpectedly return true during the first 5 minutes
after boot on 32-bit systems (see [1] for more explanation, which fixes
another jiffies-related issue in DAMON). As a result, DAMON_STAT does not
update any monitoring results during that period, which can be more
confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.

Fix it by setting last_refresh_jiffies to jiffies at startup.

[1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com

Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 6c4503d2aee3..6dc3e18de910 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -132,6 +132,9 @@ static int damon_stat_damon_call_fn(void *data)
 	struct damon_ctx *c = data;
 	static unsigned long last_refresh_jiffies;
 
+	if (unlikely(!last_refresh_jiffies))
+		last_refresh_jiffies = jiffies;
+
 	/* avoid unnecessarily frequent stat update */
 	if (time_before_eq(jiffies, last_refresh_jiffies +
 				msecs_to_jiffies(5 * MSEC_PER_SEC)))
-- 
2.43.0

