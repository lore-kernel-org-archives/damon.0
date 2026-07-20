Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0639A7FE
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548912; cv=none; b=bFXgecHAZ3j8MrHYhhCZc3a2hvVaDVPLtYNiSBVjbmfkfMVpX9WrXHQ+xQMx/6uAhR4LRrmc5U7dGGEm9gdPfdsXKpbV2AkJSloG0eSOS6zQeyYaOoZ1bhNFrhf0B02Xc7e9V4I0tj5Tq0kFmt8l7ekBYZGJTJPPNXWdnPqpTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548912; c=relaxed/simple;
	bh=iCkOj4E5pGJbFL+6/u+llz5h/zsnyXDsF8Qojj1TzdU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1ZimGgYobiTrN78Y/EGid2yObqL/XZsz58OMuybOiNfMAyjadxcsAgMOplwFPwbDB5Fz1AD+GhTfHVuz2ozHkLjGxIlQxwPQuC0FqHH89B8y9IdS4kwV08d+74YTPnRWd93oXQ7kguB6zKKZed3zdqb76dtK3zGB1M8LwkE760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=SGkHzx+b; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="SGkHzx+b"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e/YQPAgOQrSG3+15c/29ezD+K1P4Be7L3Rah6eZxjWc=;
	b=SGkHzx+bvAljk7vLYPDLYWTY4AOlUJMnF4SxiBBhsMs+N1EGfkuJHrhuX6BK8GCMbieshH7jK
	MXy49TjA8IS8HSv8n4PsRWpp38+49jqt5DxMNGGBnHeBC0/DtJqc5E6CTr2H7MgRD8OJE/DiuP6
	Pr5Eq4Xzngm19FJexNco4Tk=
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h3fHj6HJVzHnH4x;
	Mon, 20 Jul 2026 20:01:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D8BD40571;
	Mon, 20 Jul 2026 20:01:44 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 15:01:43 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Mon, 20 Jul 2026 12:01:39 +0000
Message-ID: <20260720120140.881468-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
References: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
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
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 32f495a96b17..d9b81d7b5910 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
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

