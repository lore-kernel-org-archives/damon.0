Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71D1392
	for <damon@lists.linux.dev>; Tue, 27 Dec 2022 12:11:44 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NhD4S5MCrzmWr7;
	Tue, 27 Dec 2022 20:10:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 20:11:32 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<willy@infradead.org>, <david@redhat.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 0/7] mm: convert page_idle/damon to use folios
Date: Tue, 27 Dec 2022 20:27:07 +0800
Message-ID: <20221227122714.161224-1-wangkefeng.wang@huawei.com>
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

v2:
- drop unsafe pfn_to_online_folio(), convert page_idle_get_page() and 
damon_get_page() to return a folio after grab a refence
- convert damon hugetlb related functions
- rebased on next-20221226.

Kefeng Wang (7):
  mm: page_idle: Convert page idle to use folios
  mm: damon: introduce damon_get_folio()
  mm: damon: convert damon_ptep/pmdp_mkold() to use folios
  mm: damon: paddr: convert damon_pa_*() to use folios
  mm: damon: vaddr: convert damon_young_pmd_entry() to use folio
  mm: damon: remove unneed damon_get_page()
  mm: damon: vaddr: convert hugetlb related function to use folios

 mm/damon/ops-common.c | 34 +++++++++++++------------
 mm/damon/ops-common.h |  2 +-
 mm/damon/paddr.c      | 59 +++++++++++++++++++------------------------
 mm/damon/vaddr.c      | 38 ++++++++++++++--------------
 mm/page_idle.c        | 45 ++++++++++++++++-----------------
 5 files changed, 86 insertions(+), 92 deletions(-)

-- 
2.35.3

