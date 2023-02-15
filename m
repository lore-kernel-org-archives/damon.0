Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F62F34
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 10:39:54 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VbkDfVz_1676457584;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbkDfVz_1676457584)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 18:39:44 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	sj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	naoya.horiguchi@nec.com,
	linmiaohe@huawei.com,
	david@redhat.com,
	osalvador@suse.de,
	mike.kravetz@oracle.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Change the return value for page isolation functions
Date: Wed, 15 Feb 2023 18:39:33 +0800
Message-Id: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the page isolation functions did not return a boolean to indicate
success or not, instead it will return a negative error when failed
to isolate a page. So below code used in most places seem a boolean
success/failure thing, which can confuse people whether the isolation
is successful.

if (folio_isolate_lru(folio))
        continue;

Moreover the page isolation functions only return 0 or -EBUSY, and
most users did not care about the negative error except for few users,
thus we can convert all page isolation functions to return a boolean
value, which can remove the confusion to make code more clear.

No functional changes intended in this patch series.

Changes from v2:
 - Add a new boolean 'isolated' variable for functions that require the
 negative error value.
 - Keep the same return value logic in do_migrate_range(), that means it
 will return -EBUSY if all pages are failed to be isolated.
 - Collect Acked-by and Reviewed-by tags. Thanks David and SeongJae.

Changes from v1:
 - Convert all isolation functions to return bool.

Baolin Wang (4):
  mm: change to return bool for folio_isolate_lru()
  mm: change to return bool for isolate_lru_page()
  mm: hugetlb: change to return bool for isolate_hugetlb()
  mm: change to return bool for isolate_movable_page()

 include/linux/hugetlb.h |  6 +++---
 include/linux/migrate.h |  6 +++---
 mm/compaction.c         |  2 +-
 mm/damon/paddr.c        |  2 +-
 mm/folio-compat.c       |  4 ++--
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 13 ++++++++-----
 mm/internal.h           |  4 ++--
 mm/khugepaged.c         |  4 ++--
 mm/madvise.c            |  4 ++--
 mm/memcontrol.c         |  4 ++--
 mm/memory-failure.c     | 10 +++++-----
 mm/memory_hotplug.c     |  8 +++++---
 mm/mempolicy.c          |  4 ++--
 mm/migrate.c            | 20 +++++++++++---------
 mm/migrate_device.c     |  2 +-
 mm/vmscan.c             | 10 +++++-----
 17 files changed, 56 insertions(+), 49 deletions(-)

-- 
2.27.0

