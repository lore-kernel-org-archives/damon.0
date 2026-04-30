Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA83428472
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556526; cv=none; b=fgzSTFCPiKUWSquPXNmA0FJbG3R8cXSMbONdSMNjJheAuMxpqS6O2C/k6axXiQrYAEQ3lagaGUQgfjHFuGBDhLgrB33YHDou5lAIHLdTwnF+1AfJv8DOaFvgPqkBLZF+AjmIpRjft92VGQLlYiDlZ/DdZM7eadtOz0hXVhnlj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556526; c=relaxed/simple;
	bh=SIrdoIlbpJ06AoRVHcyA1eDlMDFW0Nda4IoWCumVMME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xf1s8EI5HMMr9ff2qQRjJRErSAP82ZetdE6Gkhfe2PUDBjmw/eWulmdx1wPdEfr4t4KmiU5DbzhAnVb7LMdouV6QuFT0OHaxJuTjdMxmaRbKYs+hXfFHBuaBuskKlumU68seA33svAsfdNOSrhOhDiUHINOPovycB3fWzAxKMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5wLF0n6NzHnGkJ;
	Thu, 30 Apr 2026 21:41:09 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id EE7CC40569;
	Thu, 30 Apr 2026 21:41:54 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 16:41:54 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Thu, 30 Apr 2026 13:41:37 +0000
Message-ID: <20260430134139.2446417-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
References: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
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

Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
metric to measure the amount of huge page consumption to total anonymous
memory consumption ratio.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6..97201e9fa407 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -172,6 +172,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
+	DAMOS_QUOTA_HUGEPAGE,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff71..06547e590ff2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2319,6 +2319,18 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
+/*
+ * Returns anon hugepage memory to total anon memory use ratio.
+ */
+static unsigned int damos_get_used_hugepage_mem_bp(void)
+{
+	unsigned long used_hugepages, total_used;
+ 
+	used_hugepages = global_node_page_state(NR_ANON_THPS);
+	total_used = global_node_page_state(NR_ANON_MAPPED);
+	return mult_frac(used_hugepages, 10000, total_used);
+}
+ 
 static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
@@ -2345,6 +2357,9 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = damos_get_in_active_mem_bp(
 				goal->metric == DAMOS_QUOTA_ACTIVE_MEM_BP);
 		break;
+	case DAMOS_QUOTA_HUGEPAGE:
+		goal->current_value = damos_get_used_hugepage_mem_bp();
+		break;
 	default:
 		break;
 	}
-- 
2.43.0

