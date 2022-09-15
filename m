Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56A15A5
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 02:03:24 +0000 (UTC)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSgQT0CMlznVGh;
	Thu, 15 Sep 2022 10:00:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 10:03:15 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 10:03:14 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-mm@kvack.org>, <damon@lists.linux.dev>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>
Subject: [PATCH -next 1/2] mm/damon/reclaim: change damon_reclaim_wmarks to static
Date: Thu, 15 Sep 2022 10:10:23 +0800
Message-ID: <20220915021024.4177940-1-yangyingliang@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

damon_reclaim_wmarks is only used in reclaim.c now, change it to static.

Fixes: 89dd02d8abd1 ("mm/damon/reclaim: use watermarks parameters generator macro")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 mm/damon/reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 1acf808e1624..039fa55e0ae9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -64,7 +64,7 @@ static struct damos_quota damon_reclaim_quota = {
 };
 DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_reclaim_quota);
 
-struct damos_watermarks damon_reclaim_wmarks = {
+static struct damos_watermarks damon_reclaim_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
 	.interval = 5000000,	/* 5 seconds */
 	.high = 500,		/* 50 percent */
-- 
2.25.1

