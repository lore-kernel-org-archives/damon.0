Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309140B6FB
	for <damon@lists.linux.dev>; Fri, 22 May 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461765; cv=none; b=crIjBRyWCwN+0+SFeT4tWOQ2TvkB7E9Vl0oMkM5D2CPef2G+gRBfXdhK9gHFLAInvrLyg1UvkOrVWAMGZ2D+IANjkRPkyZXSnBiw6i3ea3tw+CdKnNPn81VentSVlCCD28K1vlFka+X8fmbss9FeQ7L1Ixvkwo76yZBik4XOF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461765; c=relaxed/simple;
	bh=N7l9RViDNHQ0LgRz4YPcQPkV/R75tA1dTGKSIKgVTQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMADeMazVO0CWAxzSOBKPpY8tvKSev48QvepW1oX/yW/oB2qnZQcQLZ6ZBgKHCx4SdnE0Ok7Ub9i33nM4bm0bNxch49DbGps2vYLo41Dlqja/a9FTNxhjiCCtdaCZm0ZpwNoG+57softKCK+W0f2VfbF7B4JGc65F97/UPL6I8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gMSxW09mfzJ46DW;
	Fri, 22 May 2026 22:55:11 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D36D40569;
	Fri, 22 May 2026 22:55:54 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 17:55:54 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Fri, 22 May 2026 14:55:16 +0000
Message-ID: <20260522145518.158910-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145518.158910-1-gutierrez.asier@huawei-partners.com>
References: <20260522145518.158910-1-gutierrez.asier@huawei-partners.com>
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

Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
metric to measure the amount of huge page consumption to total
anonymous memory consumption ratio.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c7a31572689b..8e15a674e893 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -177,6 +177,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
 	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+	DAMOS_QUOTA_HUGEPAGE,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9f38deddcb30..1f1cf10aa241 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2536,6 +2536,18 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
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
 static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		struct damos *s, struct damos_quota_goal *goal)
 {
@@ -2567,6 +2579,9 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
 				goal->nid);
 		break;
+	case DAMOS_QUOTA_HUGEPAGE:
+		goal->current_value = damos_get_used_hugepage_mem_bp();
+		break;
 	default:
 		break;
 	}
-- 
2.43.0

