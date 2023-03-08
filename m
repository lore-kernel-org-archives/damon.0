Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59A7B
	for <damon@lists.linux.dev>; Wed,  8 Mar 2023 08:12:52 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWlPG1fzPzKqMs;
	Wed,  8 Mar 2023 16:10:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 16:12:29 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/3] mm/damon/paddr: fix missing folio_sz update in damon_pa_young()
Date: Wed, 8 Mar 2023 16:33:11 +0800
Message-ID: <20230308083311.120951-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
References: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

The *folio_sz in damon_pa_young() will be used(as last_folio_sz) by
__damon_pa_check_access(), so it's need to be updated, fix missing
branch.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b22f6fbb5816..467b99166b43 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -134,10 +134,8 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 	}
 
 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio)) {
-		folio_put(folio);
-		return false;
-	}
+	if (need_lock && !folio_trylock(folio))
+		goto out;
 
 	rmap_walk(folio, &rwc);
 
-- 
2.35.3

