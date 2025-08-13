Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F392BE04B
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057162; cv=none; b=m9GkosV8mYEJc4XELweZp1WuecPL8SsO3TC6VKuxWrZGWUS+4mv21eGzRjqC5GDRwqYmVW83ig+nm91QReycBUkCoRClDa0AhnlizuQng83hWvK016yiO4sg/FHcjzrQLrV01wgGtM3sIh8qFI54LtownEn2gm5n4a9s0dlFGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057162; c=relaxed/simple;
	bh=PWVx+knEVZztwvnexj6um5NDbk2aVK8/y7TEP3wE+WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZnxcwHzFIf16USPvNS1BcIqgJIo/eG5npFlP/OKZlSewSnuM2IoCzVCQjcfOGcCMwk/RGfpYQbxOHcGXD+PnHRYWNd4yfOg9uo6KrRt5u0BnjlRbTbuoyJj+ipmkRpdMDgOZvkBlg48qnW0Xj9Hs5jhlX+aVOgvFbyrRs79i7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1vWn3kzRz1R90f;
	Wed, 13 Aug 2025 11:49:41 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EB98180044;
	Wed, 13 Aug 2025 11:52:31 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:30 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 03/16] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Wed, 13 Aug 2025 13:06:53 +0800
Message-ID: <20250813050706.1564229-4-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: <20250813050706.1564229-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

From: SeongJae Park <sj@kernel.org>

Add support of addr_unit for DAMOS_PAGEOUT action handling from the
DAMOS operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 345a0ae63b19..b548813a0472 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -135,10 +135,12 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_pageout(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	phys_addr_t addr;
+	unsigned long applied;
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
@@ -159,8 +161,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_add_filter(s, filter);
 	}
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -311,9 +313,11 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
 {
+	unsigned long aunit = ctx->addr_unit;
+
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme, sz_filter_passed);
+		return damon_pa_pageout(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
-- 
2.34.1

