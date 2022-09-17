Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117B1378
	for <damon@lists.linux.dev>; Sat, 17 Sep 2022 12:05:29 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MV8fm4YVVzlVwB;
	Sat, 17 Sep 2022 20:01:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 20:05:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 20:05:22 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-mm@kvack.org>, <damon@lists.linux.dev>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>, <xhao@linux.alibaba.com>
Subject: [PATCH -next] mm/damon: change damon_lru_sort_stub_pattern to static
Date: Sat, 17 Sep 2022 20:12:28 +0800
Message-ID: <20220917121228.1889699-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

damon_lru_sort_stub_pattern is only used in lru_sort.c now,
change it to static.

Fixes: 27812ec2a990 ("mm/damon: simplify scheme create in lru_sort.c")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index abfaf471e3e9..4a40054ba03b 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -132,7 +132,7 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
 		cold_quota_exceeds);
 
-struct damos_access_pattern damon_lru_sort_stub_pattern = {
+static struct damos_access_pattern damon_lru_sort_stub_pattern = {
 	/* Find regions having PAGE_SIZE or larger size */
 	.min_sz_region = PAGE_SIZE,
 	.max_sz_region = ULONG_MAX,
-- 
2.25.1

