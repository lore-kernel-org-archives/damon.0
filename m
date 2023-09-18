Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D038F93
	for <damon@lists.linux.dev>; Mon, 18 Sep 2023 12:10:27 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rq3RS3MBfztSZn;
	Mon, 18 Sep 2023 20:06:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 20:10:24 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <brendan.higgins@linux.dev>,
	<feng.tang@intel.com>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/2] mm/damon/core-test: Fix memory leaks in core-test
Date: Mon, 18 Sep 2023 20:09:49 +0800
Message-ID: <20230918120951.2230468-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected

There are a few memory leak in core-test which is detected by kmemleak,
the patch set fix the issue.

Changes in v3:
- Add new Reviewed-by.
- Update the first patch's commit message to make the description more
  accurate.

Changes in v2:
- Add Reviewed-by.
- Rebased on mm-unstable.
- Replace the damon_del_region() with damon_destroy_region() rather than
  calling damon_free_region().
- Update the commit message.

Jinjie Ruan (2):
  mm/damon/core-test: Fix memory leak in damon_new_region()
  mm/damon/core-test: Fix memory leak in damon_new_ctx()

 mm/damon/core-test.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1

