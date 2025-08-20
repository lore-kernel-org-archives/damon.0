Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481F2D94BE
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678015; cv=none; b=lfJpd1VixitdX4SrpzShSHLS5wFH0AavDZTuYvA07Zov+7YSm06Wu+1PBUUunPf0yuCr83gWXnX3b/Lv3IOkIcvqwQYp442BG97pZebd6w5Z3Z6f0YNBaZaNeh4BGzeeqlYmYygGSA/l56rOf7Ft5FPnxUZqPGMfTehCv5joPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678015; c=relaxed/simple;
	bh=7F5lhmH62HaxKnzwNx0Iu23D573HJ9A9prgoK2OLcuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/+xhl6AedNl/GsYmVHm0WQT90fOHKxQXztDZaMdEyYI58gEtyAYwdVjD12vWB9JtOfySt2PcHRaoi7EJbGnMtPJowH7stU+l48ZP1nmyLc3Qxxyv0k1QoW2QDojsR9zubvWFWuc51e3bLDJV5inJN+tIY3GUyY8o48wCHlCM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6K7C1xx3z2gKym;
	Wed, 20 Aug 2025 16:17:11 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D4FF140275;
	Wed, 20 Aug 2025 16:20:04 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 16:20:03 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH mm-next v2 02/12] mm/damon/paddr: support addr_unit for access monitoring
Date: Wed, 20 Aug 2025 16:06:12 +0800
Message-ID: <20250820080623.3799131-3-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820080623.3799131-1-yanquanmin1@huawei.com>
References: <20250820080623.3799131-1-yanquanmin1@huawei.com>
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

From: SeongJae Park <sj@kernel.org>

Add support of addr_unit paramer for access monitoing operations of
paddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/paddr.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0b67d9321460..d497373c2bd2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -18,7 +18,13 @@
 #include "../internal.h"
 #include "ops-common.h"
 
-static void damon_pa_mkold(unsigned long paddr)
+static phys_addr_t damon_pa_phys_addr(
+		unsigned long addr, unsigned long addr_unit)
+{
+	return (phys_addr_t)addr * addr_unit;
+}
+
+static void damon_pa_mkold(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 
@@ -29,11 +35,12 @@ static void damon_pa_mkold(unsigned long paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_region *r)
+static void __damon_pa_prepare_access_check(struct damon_region *r,
+		unsigned long addr_unit)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_pa_mkold(r->sampling_addr);
+	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
 }
 
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
@@ -43,11 +50,11 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(r);
+			__damon_pa_prepare_access_check(r, ctx->addr_unit);
 	}
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -62,23 +69,25 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 }
 
 static void __damon_pa_check_access(struct damon_region *r,
-		struct damon_attrs *attrs)
+		struct damon_attrs *attrs, unsigned long addr_unit)
 {
-	static unsigned long last_addr;
+	static phys_addr_t last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
+	phys_addr_t sampling_addr = damon_pa_phys_addr(
+			r->sampling_addr, addr_unit);
 
 	/* If the region is in the last checked page, reuse the result */
 	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
+				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
 		damon_update_region_access_rate(r, last_accessed, attrs);
 		return;
 	}
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
+	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
 	damon_update_region_access_rate(r, last_accessed, attrs);
 
-	last_addr = r->sampling_addr;
+	last_addr = sampling_addr;
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
@@ -89,7 +98,8 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(r, &ctx->attrs);
+			__damon_pa_check_access(
+					r, &ctx->attrs, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
-- 
2.43.0

