Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709615A7
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 02:03:25 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSgP20cRbzlVvx;
	Thu, 15 Sep 2022 09:59:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 10:03:15 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 10:03:15 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-mm@kvack.org>, <damon@lists.linux.dev>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>
Subject: [PATCH -next 2/2] mm/damon/lru_sort: change damon_lru_sort_wmarks to static
Date: Thu, 15 Sep 2022 10:10:24 +0800
Message-ID: <20220915021024.4177940-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915021024.4177940-1-yangyingliang@huawei.com>
References: <20220915021024.4177940-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

damon_lru_sort_wmarks is only used in lru_sort.c now, change it to static.

Fixes: 189aa3d58206 ("mm/damon/lru_sort: use watermarks parameters generator macro")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 07a0908963fd..46e7c0738bc5 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -77,7 +77,7 @@ static struct damos_quota damon_lru_sort_quota = {
 };
 DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_lru_sort_quota);
 
-struct damos_watermarks damon_lru_sort_wmarks = {
+static struct damos_watermarks damon_lru_sort_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
 	.interval = 5000000,	/* 5 seconds */
 	.high = 200,		/* 20 percent */
-- 
2.25.1

