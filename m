Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598E1FA8
	for <damon@lists.linux.dev>; Fri, 30 Dec 2022 06:53:11 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NjwsW5Mtxz16Lxp;
	Fri, 30 Dec 2022 14:51:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 14:53:02 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v4 0/8] mm: convert page_idle/damon to use folios
Date: Fri, 30 Dec 2022 15:08:41 +0800
Message-ID: <20221230070849.63358-1-wangkefeng.wang@huawei.com>
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

v4:
- correct some wrong spell pointed by SeongJae
- add new folio_memcg_check() from Matthew and use it in patch0005
- add RBs

v3:
- more thoroughly converting in page_idle_get_folio() suggested by Matthew
  also do it in damon_get_folio().
- address some commets from SeongJae

v2:
- drop unsafe pfn_to_online_folio(), convert page_idle_get_page() and 
  damon_get_page() to return a folio after grab a reference
- convert damon hugetlb related functions
- rebased on next-20221226.


Kefeng Wang (7):
  mm: page_idle: convert page idle to use a folio
  mm/damon: introduce damon_get_folio()
  mm/damon: convert damon_ptep/pmdp_mkold() to use a folio
  mm/damon/paddr: convert damon_pa_*() to use a folio
  mm/damon/vaddr: convert damon_young_pmd_entry() to use a folio
  mm/damon: remove unneeded damon_get_page()
  mm/damon/vaddr: convert hugetlb related functions to use a folio

Matthew Wilcox (1):
  mm: memcg: Add folio_memcg_check()

 include/linux/memcontrol.h | 40 +++++++++++++++++---------
 mm/damon/ops-common.c      | 38 ++++++++++++++-----------
 mm/damon/ops-common.h      |  2 +-
 mm/damon/paddr.c           | 58 +++++++++++++++++---------------------
 mm/damon/vaddr.c           | 38 ++++++++++++-------------
 mm/memcontrol.c            |  6 ++--
 mm/page_idle.c             | 47 +++++++++++++++---------------
 7 files changed, 120 insertions(+), 109 deletions(-)

-- 
2.35.3

