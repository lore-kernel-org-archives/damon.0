Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393757E
	for <damon@lists.linux.dev>; Tue, 14 Feb 2023 03:34:04 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vbe-fxI_1676344705;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbe-fxI_1676344705)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 11:18:26 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	sj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Some cleanups for page isolation
Date: Tue, 14 Feb 2023 11:18:05 +0800
Message-Id: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The page isolation functions did not return a boolean to indicate
success or not, instead it will return a negative error when failed
to isolate a page. So it's better to check the negative error explicitly
for isolation to make the code more clear per Linus's suggestion in [1].

No functional changes intended in this patch series.

[1] https://lore.kernel.org/all/CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com/

Baolin Wang (3):
  mm: check negative error of folio_isolate_lru() when failed to isolate
    a folio
  mm: check negative error of isolate_lru_page() when failed to isolate
    a page
  mm: mempolicy: check negative error of isolate_hugetlb() when failed
    to isolate a hugetlb

 mm/damon/paddr.c    | 2 +-
 mm/gup.c            | 2 +-
 mm/khugepaged.c     | 4 ++--
 mm/memcontrol.c     | 2 +-
 mm/mempolicy.c      | 2 +-
 mm/migrate.c        | 4 ++--
 mm/migrate_device.c | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.27.0

