Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230412DDA9
	for <damon@lists.linux.dev>; Mon, 26 Feb 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956388; cv=none; b=DzWQyNdEoKygK0/0Y5dWSmulx5KaWbkgONrK+MbKWBLJP+/AiRv7LAuLYGHnbsLcrbS3Q+BJ2B2JibV9I0zH0/ktmkDdOtZn45CsZkTeIntpU+sOQbVhczPl5jQOL4RtaLVxjAGRotFTzRHM3erFh2I9IKaomF5ujYtcmQWBwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956388; c=relaxed/simple;
	bh=rwgghmTg7o4FR0Bv2KuCZkmTtPHv9JXSryRKMphOOMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4hRtYwZGIERQQXhsLjnWYZGSo9ammfXUoysHrxqgQ4TuPz1eDjWwQG6gUViTnrq8+nrKx0ZI4eO85U0I53YvM4Zc+bPZwM7fgzQXDlspr1NCQCnVrqE3+nP1KVlzmkDEXO+ul+ecnYVMiuHfr6TgzTniTLP10PayMqGvF+XwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-93-65dc9ade7648
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: [PATCH v2 7/7] mm/damon/sysfs-schemes: apply target_nid for promote and demote actions
Date: Mon, 26 Feb 2024 23:05:53 +0900
Message-ID: <20240226140555.1615-8-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226140555.1615-1-honggyu.kim@sk.com>
References: <20240226140555.1615-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXC9ZZnoe69WXdSDZa1cVtM7DGwmLN+DZvF
	rhshFv/3HmO0ePL/N6vFiZuNbBad35eyWFzeNYfN4t6a/6wWR9afZbFYdwvI2nz2DLPF4uVq
	Fvs6HjBZHP76hsli8qUFbBYvppxhtDg5azKLxeyj99gdhD3+H5zE7LH09Bs2jw1NQGLnrLvs
	Hi37brF7LNhU6tFy5C2rx+I9L5k8Nq3qZPPY9GkSu8eJGb9ZPHY+tPR4sXkmo0dv8zs2j8+b
	5AL4o7hsUlJzMstSi/TtErgyPl+/wVTwQ76iqe8rWwNjr2QXIyeHhICJxLEtr1hh7L2rzzCC
	2GwCahJXXk5i6mLk4BARcJBY9VWhi5GLg1mggUXix+dLLCA1wgLxEiu27wPrZRFQlTg77RqY
	zStgJrH9dhcjxExNicfbf7KD2JwC5hL/D7ezgcwUAqo5epsZolxQ4uTMJ2AjmQXkJZq3zmYG
	2SUhcIpd4tSzU+wQcyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczMMdHLqMzLrNBLzs/d
	xAiMv2W1f6J3MH66EHyIUYCDUYmH16H2TqoQa2JZcWXuIUYJDmYlEd5wmZupQrwpiZVVqUX5
	8UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhgDSu/zu586uPSX6Afb/49c
	H9mJSL3S3Oza2bzPtvHlHn6HZ4efrk3U2mXIuNGh8s5Jmd4db1Y+nJi7XHX+Ufut0qt7jJb9
	esMlvcxL6ajI/jlM4QdWZr8N3MNz/v+t4Cus5efixB2shdX+MbnsCYqb/UjEXDJ7ltbRPvNL
	joKHVk16Hv13+9JSJZbijERDLeai4kQAoSBEXbsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLT/furDupBrPvWFlM7DGwmLN+DZvF
	rhshFv/3HmO0ePL/N6vFiZuNbBafn71mtuh88p3R4vDck6wWnd+Xslhc3jWHzeLemv+sFkfW
	n2WxWHcLyNp89gyzxeLlahaHrj1ntdjX8YDJ4vDXN0wWky8tYLN4MeUMo8XJWZNZLGYfvcfu
	IO7x/+AkZo+lp9+weWxoAhI7Z91l92jZd4vdY8GmUo+WI29ZPRbvecnksWlVJ5vHpk+T2D1O
	zPjN4rHzoaXHi80zGT16m9+xeXy77eGx+MUHpgDBKC6blNSczLLUIn27BK6Mz9dvMBX8kK9o
	6vvK1sDYK9nFyMkhIWAisXf1GUYQm01ATeLKy0lMXYwcHCICDhKrvip0MXJxMAs0sEj8+HyJ
	BaRGWCBeYsX2fawgNouAqsTZadfAbF4BM4ntt7sYIWZqSjze/pMdxOYUMJf4f7idDWSmEFDN
	0dvMEOWCEidnPgEbySwgL9G8dTbzBEaeWUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBL
	zs/dxAiMtWW1fybuYPxy2f0QowAHoxIPr0PtnVQh1sSy4srcQ4wSHMxKIrzhMjdThXhTEiur
	Uovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjNfZR5/H8w5K5/oMaV
	Y7nh34Ppcn3CBydPUVNkPLBLYOv6U00bsl53xitqxr+L+F4TvfNi5YUdIfFxIqxS28oFOnQP
	JGv0b3lRYO4jc03guYyn96xV6R6z1vlvqTzA5jKD+9xvw00WryXCAn49CPO/LvWttOIS143F
	y+IzlzhrTombvf9R9SQlluKMREMt5qLiRACjXRGRsQIAAA==
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch changes DAMOS_PROMOTE and DAMOS_DEMOTE to use target_nid of
sysfs as the destination NUMA node of migration.  This has been tested
on qemu as follows:

  $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
  $ cat contexts/<N>/schemes/<N>/action
  promote
  $ echo 1 > contexts/<N>/schemes/<N>/target_nid
  $ echo commit > state
  $ numactl -p 2 ./hot_cold 500M 600M &
  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  701 (hot_cold)       0    501    601  1101

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/paddr.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 37a7b34a36dd..5e057a69464f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -240,9 +240,9 @@ enum migration_mode {
  */
 static unsigned int migrate_folio_list(struct list_head *migrate_folios,
 				       struct pglist_data *pgdat,
-				       enum migration_mode mm)
+				       enum migration_mode mm,
+				       int target_nid)
 {
-	int target_nid;
 	unsigned int nr_succeeded;
 	nodemask_t allowed_mask;
 	int reason;
@@ -250,12 +250,14 @@ static unsigned int migrate_folio_list(struct list_head *migrate_folios,
 
 	switch (mm) {
 	case MIG_PROMOTE:
-		target_nid = next_promotion_node(pgdat->node_id);
+		if (target_nid == NUMA_NO_NODE)
+			target_nid = next_promotion_node(pgdat->node_id);
 		reason = MR_PROMOTION;
 		vm_event = PGPROMOTE;
 		break;
 	case MIG_DEMOTE:
-		target_nid = next_demotion_node(pgdat->node_id);
+		if (target_nid == NUMA_NO_NODE)
+			target_nid = next_demotion_node(pgdat->node_id);
 		reason = MR_DEMOTION;
 		vm_event = PGDEMOTE_DIRECT;
 		break;
@@ -358,7 +360,8 @@ static enum folio_references folio_check_references(struct folio *folio)
  */
 static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 						struct pglist_data *pgdat,
-						enum migration_mode mm)
+						enum migration_mode mm,
+						int target_nid)
 {
 	unsigned int nr_migrated = 0;
 	struct folio *folio;
@@ -399,7 +402,7 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */
 
 	/* Migrate folios selected for migration */
-	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, mm);
+	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, mm, target_nid);
 	/* Folios that could not be migrated are still in @migrate_folios */
 	if (!list_empty(&migrate_folios)) {
 		/* Folios which weren't migrated go back on @folio_list */
@@ -426,7 +429,8 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
  *      common function for both cases.
  */
 static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
-					    enum migration_mode mm)
+					    enum migration_mode mm,
+					    int target_nid)
 {
 	int nid;
 	unsigned int nr_migrated = 0;
@@ -449,12 +453,14 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 		}
 
 		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
-							   NODE_DATA(nid), mm);
+							   NODE_DATA(nid), mm,
+							   target_nid);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
 	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
-						   NODE_DATA(nid), mm);
+						   NODE_DATA(nid), mm,
+						   target_nid);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
@@ -499,7 +505,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		break;
 	case MIG_PROMOTE:
 	case MIG_DEMOTE:
-		applied = damon_pa_migrate_pages(&folio_list, mm);
+		applied = damon_pa_migrate_pages(&folio_list, mm,
+						 s->target_nid);
 		break;
 	default:
 		/* Unexpected migration mode. */
-- 
2.34.1

