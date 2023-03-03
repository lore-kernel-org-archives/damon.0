Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F211FAF
	for <damon@lists.linux.dev>; Fri,  3 Mar 2023 08:22:58 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PSgsH2FF9z9tKK;
	Fri,  3 Mar 2023 16:20:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 16:22:47 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/3] mm/damon/paddr: minor refactor of damon_pa_young()
Date: Fri, 3 Mar 2023 16:43:42 +0800
Message-ID: <20230303084343.171958-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230303084343.171958-1-wangkefeng.wang@huawei.com>
References: <20230303084343.171958-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

Omit three lines by unified folio_put(), and make code more clear.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3fda00a0f786..2ef9db0189ca 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 			accessed = false;
 		else
 			accessed = true;
-		folio_put(folio);
 		goto out;
 	}
 
 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio)) {
-		folio_put(folio);
-		return false;
-	}
+	if (need_lock && !folio_trylock(folio))
+		goto out;
 
 	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
-	folio_put(folio);
 
-out:
 	*folio_sz = folio_size(folio);
+out:
+	folio_put(folio);
 	return accessed;
 }
 
-- 
2.35.3

