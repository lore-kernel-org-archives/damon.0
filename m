Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341DF3C1D
	for <damon@lists.linux.dev>; Thu, 18 Aug 2022 10:57:39 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMaUrG7_1660820254;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMaUrG7_1660820254)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 18:57:35 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH V2 0/2] mm/damon: A few fixup with lru_sort
Date: Thu, 18 Aug 2022 18:57:30 +0800
Message-Id: <20220818105732.34492-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
https://lore.kernel.org/damon/20220818082538.67825-1-xhao@linux.alibaba.com/


Xin Hao (2):
  mm/damon/lru_sort: Move target memory region check to head of func
  mm/damon/lru_sort: Remove struct of damon_lru_sort_ram_walk_arg

 mm/damon/lru_sort.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

--
2.27.0
