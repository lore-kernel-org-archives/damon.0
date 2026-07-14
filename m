Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D748B376
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041372; cv=none; b=s3fSp6xn/sJZDdw/FNu9uWj6wVyuiZVEJ+4Ye+hR2bdkBXOQPgba3sJT5IWLD9yJrKm4IT7TvNI/6ygDuACAC6wypig3OY+CBgrjQnoLFUv6/TnJ/QyQhFOIGr1c0ZizyRkNUhIBl3jJjotav6EfLUX4Gh97z6phzMoOVGXSX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041372; c=relaxed/simple;
	bh=nq9tsa0TeFefdVHfC7SXyle/OhrxtDv1fiJB7BcAAWE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7cp+sgozgn7tPzH/dcAqQ1qUDkQqWpGf1MrTtoyM0nsYI116+/lj9F7/MsCESNmMIEKo9keIlg/Lva+pE6FXP7BIeVbnfrhN4PCLjdjnFm4hUZ3jE3LRU1UjoS5CuGIWUjCa1qWYeIsabl3qyPGmWKse4Kdp2VZtcl0+aVL9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=iK7wgLjs; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="iK7wgLjs"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bY0zsgQNRGdot1/GBvs74WqAm7W6VQas7soUq+EVbIg=;
	b=iK7wgLjssLwLPnP0T4ETwFXjueno/++Y7R9yq89uF89iG3mOgLMpDubzCgLnf+c9eFC5jlwhK
	IRSp9FNYEeyjLCgFV0O23LJbJKvYzPycK3u/7mz/DP/oaADJ2Faa9zafnovPsMcLOK9G1tTCNY8
	lC+Sf9o1zI8bihC6/RckxzE=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h02bV00PDzHnH4Z;
	Tue, 14 Jul 2026 23:02:29 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 71A8340584;
	Tue, 14 Jul 2026 23:02:40 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 18:02:40 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<zuoze1@huawei.com>, <damon@lists.linux.dev>, <sj@kernel.org>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2 2/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Tue, 14 Jul 2026 15:01:15 +0000
Message-ID: <20260714150116.382521-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
References: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
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

