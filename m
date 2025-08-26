Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27912D2496
	for <damon@lists.linux.dev>; Tue, 26 Aug 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179392; cv=none; b=NJ8pfV4w5NUy8Vurumz79O2QYP5RWAEm9oxgOcDcIIP8VhzIgoB8hVWrw9BhwyI3KSwPzDtG2iZobCewHcUGeTjJlwbwnc1F6m/M8MA2SQJX7n9D/MQHncaF/CLOAbD/YBPLhZC5h2bfUfwITmbwJfNXqzErogIASvGqXWcWGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179392; c=relaxed/simple;
	bh=ySM69bXIvk0YaFDj5KM1EUvQTSmjmg/cctFtcMlj3as=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHcKfi7PO3O2pLn9W87THIfCwacHOaxFvkhYY9NucaE4a9JhvVOJtTpVn7ui4U4iNbR0wPWh4PlcZXGoUpn/1L6u52m0Na9W3X6x4Zw3SKhQUnpbWmw9KIu8w/fSsYLcgBOS4pY94OYzWKneoZWx9YaWFGeVNWbcggZTdtvsKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c9tWR53yPz2CgDN;
	Tue, 26 Aug 2025 11:32:03 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D7AA1A016C;
	Tue, 26 Aug 2025 11:36:29 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 11:36:28 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH 2/2] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Tue, 26 Aug 2025 11:36:53 +0800
Message-ID: <20250826033653.1208227-3-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826033653.1208227-1-yanquanmin1@huawei.com>
References: <20250826033653.1208227-1-yanquanmin1@huawei.com>
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

When creating a new scheme of DAMON_RECLAIM, the calculation
of 'min_age_region' uses 'aggr_interval' as the divisor, which
may lead to division-by-zero errors. Fix it by directly returning
-EINVAL when such a case occurs.

Fixes: f5a79d7c0c87 ("mm/damon: introduce struct damos_access_pattern")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3c71b4596676..fb7c982a0018 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -194,6 +194,11 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;
-- 
2.43.0

