Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD463AA9F3
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622265; cv=none; b=aqCN7NKjDu7vASimAVmcuCtktIWwjaUYeZtcIayaeTJf1ZBGePxsjyi64iAFq3AnVpleBB3eoB//xLFjsFqiC6npIpLyNGg1STFMwCiw5+W4XCvB2OetFiMKPwr0+R8K7rzA9V/xRw1NrRKoTaxrEt8dZedIZfF5osjskFpz3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622265; c=relaxed/simple;
	bh=nt7ikHYxsbo7RzaYQxATR43Fz7l/ET2fE25UZGbMggI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9nUVnnGIXgv8dapEXt/bgtV/ExzJnvwz2U8IhcEGqN3WdpFh5n36y6CH6/dTcxMIOVegKRQp3rZERvWWrScwoAQ8DRRL/JgqmcDYB1fOHK/OOvg0VGOCANhsmSwkCuIrvNgLbiGBQBOWASi6QtSKhm6wtfhrCQzsk4v75fknWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gfqxz2cnWzJ46ck;
	Tue, 16 Jun 2026 23:03:51 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id DA63440575;
	Tue, 16 Jun 2026 23:04:14 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:04:14 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Tue, 16 Jun 2026 15:03:16 +0000
Message-ID: <20260616150316.580819-4-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616150316.580819-1-gutierrez.asier@huawei-partners.com>
References: <20260616150316.580819-1-gutierrez.asier@huawei-partners.com>
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

DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.

Add the "hugepage_mem_bp" to the sysfs-schemes interface.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 mm/damon/sysfs-schemes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..4b5429a5b415 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
 		.name = "node_eligible_mem_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
+		.name = "hugepage_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
-- 
2.43.0

