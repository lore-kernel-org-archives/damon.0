Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CC29B0
	for <damon@lists.linux.dev>; Thu,  2 Mar 2023 14:29:12 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PSCyq3R4pzKmK3;
	Thu,  2 Mar 2023 22:24:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 22:29:03 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] mm/damon/paddr: minor refactor of damon_pa_pageout()
Date: Thu, 2 Mar 2023 22:49:26 +0800
Message-ID: <20230302144926.40012-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

Omit two lines by converting if(!folio_isolate_lru()) to
if(folio_isolate_lru()).

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6c655d9b5639..a557f3c9300f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -246,14 +246,12 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
-		if (!folio_isolate_lru(folio)) {
-			folio_put(folio);
-			continue;
+		if (folio_isolate_lru(folio)) {
+			if (folio_test_unevictable(folio))
+				folio_putback_lru(folio);
+			else
+				list_add(&folio->lru, &folio_list);
 		}
-		if (folio_test_unevictable(folio))
-			folio_putback_lru(folio);
-		else
-			list_add(&folio->lru, &folio_list);
 		folio_put(folio);
 	}
 	applied = reclaim_pages(&folio_list);
-- 
2.35.3

