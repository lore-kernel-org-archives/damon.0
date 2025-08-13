Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3012BE7D0
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057164; cv=none; b=j5zbfVAlRZ1WGcz2PVwr/2Lxwb+vkXJbguUD0lxux7ou3wbZqSAxcPn2pncFJ0ZknCcTdd81P9WOWPPbsqtnjA9JYDQkxxSW15HaxbMWMw7p5tzW9EKOCYlxMyHADMnaBtIJa9iolV8fIBrFv/IastFx0sIv2mUIDwAmHzeAZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057164; c=relaxed/simple;
	bh=K8zueaRJo3gNUjC+lIEOH6g3TS9WguEf58BxphKiDew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvgCZtUzXOG2BJ4ninB9QtaNpDwrkXT2yFWi3ORkGvwf3tHgLOaGcseOKCqY5kXeIWITw0f4jWN5sg8R7/MMpTWy++wmcjYZutmi/EVGeCP+ERkHuGjJdfMQw9RnAuLKBaUb/wHsmLk0NdUgN2PrD8UqTgsfZLc4iDXq9V5RLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c1vZ21RvTztTBG;
	Wed, 13 Aug 2025 11:51:38 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 70073180064;
	Wed, 13 Aug 2025 11:52:38 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:37 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 12/16] mm/damon: add damon_ctx->min_region and damon_target->min_region
Date: Wed, 13 Aug 2025 13:07:02 +0800
Message-ID: <20250813050706.1564229-13-yanquanmin1@huawei.com>
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

Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
bytes and cause data alignment issues[1].

Add damon_ctx->min_region to change DAMON_MIN_REGION from a global
macro value to per-context variable, let target inherit the min_region
from its associated ctx to avoid excessive passing of ctx.

[1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 include/linux/damon.h |  7 ++++++-
 mm/damon/core.c       | 41 +++++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1b7b4cf1a3c5..aa045dcb5b5d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -88,6 +88,7 @@ struct damon_region {
 /**
  * struct damon_target - Represents a monitoring target.
  * @pid:		The PID of the virtual address space to monitor.
+ * @min_region:		Minimum Region Size.
  * @nr_regions:		Number of monitoring target regions of this target.
  * @regions_list:	Head of the monitoring target regions of this target.
  * @list:		List head for siblings.
@@ -95,10 +96,12 @@ struct damon_region {
  * Each monitoring context could have multiple targets.  For example, a context
  * for virtual memory address spaces could have multiple target processes.  The
  * @pid should be set for appropriate &struct damon_operations including the
- * virtual address spaces monitoring operations.
+ * virtual address spaces monitoring operations. The @min_region Keeps consistent
+ * with the associated monitoring context.
  */
 struct damon_target {
 	struct pid *pid;
+	unsigned long min_region;
 	unsigned int nr_regions;
 	struct list_head regions_list;
 	struct list_head list;
@@ -747,6 +750,7 @@ struct damon_attrs {
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
+ * @min_region:		Minimum Region Size.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -789,6 +793,7 @@ struct damon_ctx {
 
 	struct damon_operations ops;
 	unsigned long addr_unit;
+	unsigned long min_region;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 803c30f64b94..b162aa1156fc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -245,16 +245,16 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			/* no region intersects with this range */
 			newr = damon_new_region(
 					ALIGN_DOWN(range->start,
-						DAMON_MIN_REGION),
-					ALIGN(range->end, DAMON_MIN_REGION));
+						t->min_region),
+					ALIGN(range->end, t->min_region));
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-					DAMON_MIN_REGION);
-			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+					t->min_region);
+			last->ar.end = ALIGN(range->end, t->min_region);
 
 			/* fill possible holes in the range */
 			err = damon_fill_regions_holes(first, last, t);
@@ -472,6 +472,7 @@ struct damon_target *damon_new_target(void)
 
 	t->pid = NULL;
 	t->nr_regions = 0;
+	t->min_region = DAMON_MIN_REGION;
 	INIT_LIST_HEAD(&t->regions_list);
 	INIT_LIST_HEAD(&t->list);
 
@@ -480,6 +481,7 @@ struct damon_target *damon_new_target(void)
 
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 {
+	t->min_region = ctx->min_region;
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
 
@@ -545,6 +547,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
+	ctx->min_region = DAMON_MIN_REGION;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
@@ -1181,6 +1184,14 @@ static int damon_commit_targets(
 	return 0;
 }
 
+static void damon_sync_target_min_region(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, ctx)
+		t->min_region = ctx->min_region;
+}
+
 /**
  * damon_commit_ctx() - Commit parameters of a DAMON context to another.
  * @dst:	The commit destination DAMON context.
@@ -1216,6 +1227,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		return err;
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit ? : 1;
+	dst->min_region = max(DAMON_MIN_REGION / dst->addr_unit, 1);
+	damon_sync_target_min_region(dst);
 
 	return 0;
 }
@@ -1248,8 +1261,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < ctx->min_region)
+		sz = ctx->min_region;
 
 	return sz;
 }
@@ -1632,11 +1645,11 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, DAMON_MIN_REGION);
+					r->ar.start, t->min_region);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= DAMON_MIN_REGION)
+				if (damon_sz_region(r) <= t->min_region)
 					return true;
-				sz_to_skip = DAMON_MIN_REGION;
+				sz_to_skip = t->min_region;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			r = damon_next_region(r);
@@ -1678,8 +1691,8 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = target_idx == filter->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
-		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
+		start = ALIGN_DOWN(filter->addr_range.start, t->min_region);
+		end = ALIGN_DOWN(filter->addr_range.end, t->min_region);
 
 		/* inside the range */
 		if (start <= r->ar.start && r->ar.end <= end) {
@@ -1850,7 +1863,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					DAMON_MIN_REGION);
+					c->min_region);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -2302,13 +2315,13 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 		sz_region = damon_sz_region(r);
 
 		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * DAMON_MIN_REGION; i++) {
+				sz_region > 2 * t->min_region; i++) {
 			/*
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
 			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, DAMON_MIN_REGION);
+					sz_region / 10, t->min_region);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
-- 
2.34.1

