Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19C76669
	for <damon@lists.linux.dev>; Fri, 15 Jul 2022 06:17:06 +0000 (UTC)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lkh1C0SQDzlVvF;
	Fri, 15 Jul 2022 14:15:27 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 14:17:03 +0800
From: Yuanzheng Song <songyuanzheng@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/damon/reclaim: fix 'enabled' is incorrectly set because 'system_wq' is not initialized
Date: Fri, 15 Jul 2022 06:16:09 +0000
Message-ID: <20220715061609.48463-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected

The 'enabled' will be incorrectly set because the 'system_wq'
might not initialized yet. This results in 'enabled=true',
but the 'damon_reclaim_timer' is inactive. So fix it by moving
the judgment logic of the 'damon_reclaim_initialized' to the
start position of the enable_store().

Fixes: 294928293813 ("mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized")
Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 mm/damon/reclaim.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e69b807fefe4..b13d5a02bf2e 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -374,13 +374,14 @@ static bool damon_reclaim_initialized;
 static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	int rc = param_set_bool(val, kp);
-
-	if (rc < 0)
-		return rc;
+	int rc;
 
 	/* system_wq might not initialized yet */
 	if (!damon_reclaim_initialized)
+		return -EINVAL;
+
+	rc = param_set_bool(val, kp);
+	if (rc < 0)
 		return rc;
 
 	schedule_delayed_work(&damon_reclaim_timer, 0);
-- 
2.25.1

