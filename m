Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE725B1DA
	for <damon@lists.linux.dev>; Thu, 16 Oct 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612571; cv=none; b=j1yZbGhwsXmPeRAkJprBqZLWXxb2pRi4P3w+fKQkRc0qWf2CvjsDnTabIL7Fr/l1gE15Wlgcz4x4+maaArUz/3M8pFd6DD+zOqbuvIaZjBOIEHxO+Oxklck+i2WBQ0aaxQqQlir9pVBsXxPdE/fH2j8aR56hb1mzpl8rSSJ+eiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612571; c=relaxed/simple;
	bh=3U6mKEsp/xuVHLB2nhHRtmgO0ouTQPLIP8tq4d9tIAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pXswoTZExpxBQz+6v3+AdpBDnvLoELkDGijmRsC0LjnEP6yfPc5EPeqjl6mxNYjwYqjMTcbUpD3ugJ5KZB0pBmQNhUnbFNPdXFECSQHNrnsGmNJz5Qov0mi39xkBLXYE8f5xmPVcg89OpLmPltXhb84KUy4PjkvBOAssAB9e5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PVH3AjvB; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PVH3AjvB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YA8D5I96zsXRtdPpR5at9hJZuoUIlUR0M7FDNK1mdqI=;
	b=PVH3AjvBH98EWotO5/VLOPldqTmMmYiNlNV+Bl1atBgPKDreShqY5goNPA2WDOeykki2sMx+v
	HuoZc/ZGEjExlvoTSYoJa2ZX9GHgzDRJIWJJHOQd0P/bluTH5tSy0cGYmZjBO7pIiUhiKfbS7wf
	J9/mqUs/wLmtNaO3PU/CgS4=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cnQ4l3rHFzpSv6;
	Thu, 16 Oct 2025 19:01:43 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id EBF2F18048B;
	Thu, 16 Oct 2025 19:02:39 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Oct
 2025 19:02:39 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH] mm/damon: add a min_sz_region parameter to damon_set_region_biggest_system_ram_default()
Date: Thu, 16 Oct 2025 18:47:17 +0800
Message-ID: <20251016104717.2194909-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
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

After adding addr_unit support for DAMON_LRU_SORT and DAMON_RECLAIM,
the related region setup now requires alignment based on min_sz_region.

Add min_sz_region to damon_set_region_biggest_system_ram_default()
and use it when calling damon_set_regions(), replacing the previously
hardcoded DAMON_MIN_REGION.

Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 include/linux/damon.h | 3 ++-
 mm/damon/core.c       | 6 ++++--
 mm/damon/lru_sort.c   | 3 ++-
 mm/damon/reclaim.c    | 3 ++-
 mm/damon/stat.c       | 3 ++-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cae8c613c5fc..1ce75a20febf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -947,7 +947,8 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-				unsigned long *start, unsigned long *end);
+				unsigned long *start, unsigned long *end,
+				unsigned long min_sz_region);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 93848b4c6944..e29f08b8a114 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2767,6 +2767,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * @t:		The monitoring target to set the region.
  * @start:	The pointer to the start address of the region.
  * @end:	The pointer to the end address of the region.
+ * @min_sz_region:	Minimum region size.
  *
  * This function sets the region of @t as requested by @start and @end.  If the
  * values of @start and @end are zero, however, this function finds the biggest
@@ -2777,7 +2778,8 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-			unsigned long *start, unsigned long *end)
+			unsigned long *start, unsigned long *end,
+			unsigned long min_sz_region)
 {
 	struct damon_addr_range addr_range;
 
@@ -2790,7 +2792,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, DAMON_MIN_REGION);
+	return damon_set_regions(t, &addr_range, 1, min_sz_region);
 }
 
 /*
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 42b9a656f9de..49b4bc294f4e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -242,7 +242,8 @@ static int damon_lru_sort_apply_parameters(void)
 
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
-					&monitor_region_end);
+					&monitor_region_end,
+					param_ctx->min_sz_region);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 7ba3d0f9a19a..36a582e09eae 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -250,7 +250,8 @@ static int damon_reclaim_apply_parameters(void)
 
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
-					&monitor_region_end);
+					&monitor_region_end,
+					param_ctx->min_sz_region);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index d8010968bbed..6c4503d2aee3 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -187,7 +187,8 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	if (damon_set_region_biggest_system_ram_default(target, &start, &end))
+	if (damon_set_region_biggest_system_ram_default(target, &start, &end,
+							ctx->min_sz_region))
 		goto free_out;
 	return ctx;
 free_out:
-- 
2.43.0

