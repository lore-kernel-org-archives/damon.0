Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CF1FAD
	for <damon@lists.linux.dev>; Fri,  3 Mar 2023 08:22:54 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PSgr53cdczSkdP;
	Fri,  3 Mar 2023 16:19:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 16:22:46 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/3] mm/damon/paddr: minor code improvement
Date: Fri, 3 Mar 2023 16:43:40 +0800
Message-ID: <20230303084343.171958-1-wangkefeng.wang@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

Unify folio_put() to make code more clear.

v2: 
- use goto lable in damon_pa_pageout() and refact too more functions

Kefeng Wang (3):
  mm/damon/paddr: minor refactor of damon_pa_pageout()
  mm/damon/paddr: minor refactor of damon_pa_young()
  mm/damon/paddr: minor refactor of
    damon_pa_mark_accessed_or_deactivate()

 mm/damon/paddr.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
2.35.3

