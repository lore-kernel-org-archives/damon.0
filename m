Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C431E83E
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586382; cv=none; b=uwnwj/H+NjdGX9uLlLhVJUHcwdyvRLk7tngjgdagOdA0VDtGN4O/g93YnKfhd6o19e+yq40Hh3V45wtOwaj9o/BmLalUpCbsqvQt1W4IHTZO9l6CBQRD3H+T+1jMylnkraLe0TZZnk8WSfzVFU+/Q/9o+tOjjvJtRwUfFlB7APU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586382; c=relaxed/simple;
	bh=i4gvrQNNK6+MMsCQGn+t9qmcYrXvz2Yw2qMrW6EEorw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc81WtPWpqRaFEbMjZBtHyrp7jkMrXwMgu7BHpOFIuPVgRMwrT5NqCMNDKaSfgmtS3U1LFZ+GTrF8MtNioJRlsRsFS/kk8cT8ArXY9mVMNPS9G7WIH4PxwHWhF4EqTvQxaX19myLIJNTamTv5Ght1WP98yWeYdz5FgTiPJ+WIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWSW75cDQzHnGjF;
	Thu,  4 Jun 2026 23:03:31 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 78C9A40569;
	Thu,  4 Jun 2026 23:04:25 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 18:04:25 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Thu, 4 Jun 2026 15:03:34 +0000
Message-ID: <20260604150338.501128-2-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604150338.501128-1-gutierrez.asier@huawei-partners.com>
References: <20260604150338.501128-1-gutierrez.asier@huawei-partners.com>
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

Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a
new DAMOS quota goal metric to measure the amount of huge
page consumption to total anonymous memory consumption
ratio.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

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
index 9f38deddcb30..7fc7477a353a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2536,6 +2536,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
+static unsigned int damos_hugepage_mem_bp(void)
+{
+	unsigned long thp, total;
+
+	thp = global_node_page_state(NR_ANON_THPS) +
+				global_node_page_state(NR_SHMEM_THPS) +
+				global_node_page_state(NR_FILE_THPS);
+	total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
+	return mult_frac(thp, 10000, total);
+}
+
 static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		struct damos *s, struct damos_quota_goal *goal)
 {
@@ -2567,6 +2578,9 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
 				goal->nid);
 		break;
+	case DAMOS_QUOTA_HUGEPAGE:
+		goal->current_value = damos_hugepage_mem_bp();
+		break;
 	default:
 		break;
 	}
-- 
2.43.0

