Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D61109
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 11:18:26 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NhprZ0ZyxzRqJw;
	Wed, 28 Dec 2022 19:17:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 19:18:23 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v3 0/7] mm: convert page_idle/damon to use folios
Date: Wed, 28 Dec 2022 19:34:06 +0800
Message-ID: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected

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
  mm: page_idle: Convert page idle to use folios
  mm/damon: introduce damon_get_folio()
  mm/damon: convert damon_ptep/pmdp_mkold() to use folios
  mm/damon: paddr: convert damon_pa_*() to use folios
  mm/damon: vaddr: convert damon_young_pmd_entry() to use folio
  mm/damon: remove unneed damon_get_page()
  mm/damon: vaddr: convert hugetlb related function to use folios

 mm/damon/ops-common.c | 38 +++++++++++++++-------------
 mm/damon/ops-common.h |  2 +-
 mm/damon/paddr.c      | 58 +++++++++++++++++++------------------------
 mm/damon/vaddr.c      | 38 ++++++++++++++--------------
 mm/page_idle.c        | 47 ++++++++++++++++++-----------------
 5 files changed, 91 insertions(+), 92 deletions(-)

-- 
2.35.3

