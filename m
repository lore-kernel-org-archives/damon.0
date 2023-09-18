Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A223A7
	for <damon@lists.linux.dev>; Mon, 18 Sep 2023 07:48:44 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RpxdV6RbqztS88;
	Mon, 18 Sep 2023 15:44:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 15:48:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <brendan.higgins@linux.dev>,
	<feng.tang@intel.com>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 1/2] mm/damon/core-test: Fix memory leak in damon_new_region()
Date: Mon, 18 Sep 2023 15:47:58 +0800
Message-ID: <20230918074759.3895339-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918074759.3895339-1-ruanjinjie@huawei.com>
References: <20230918074759.3895339-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected

When CONFIG_DAMON_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.

The damon_region which is allocated by kmem_cache_alloc() in
damon_new_region() in damon_test_regions() and
damon_test_update_monitoring_result() are not freed. So use
damon_free_region() to free it. After applying this patch, the following
memory leak is never detected.

    unreferenced object 0xffff2b49c3edc000 (size 56):
      comm "kunit_try_catch", pid 338, jiffies 4294895280 (age 557.084s)
      hex dump (first 32 bytes):
        01 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 49 2b ff ff  ............I+..
      backtrace:
        [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
        [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
        [<000000008603f022>] damon_new_region+0x28/0x54
        [<00000000a3b8c64e>] damon_test_regions+0x38/0x270
        [<00000000559c4801>] kunit_try_run_case+0x50/0xac
        [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
        [<000000003c3e9211>] kthread+0x124/0x130
        [<0000000028f85bdd>] ret_from_fork+0x10/0x20
    unreferenced object 0xffff2b49c5b20000 (size 56):
      comm "kunit_try_catch", pid 354, jiffies 4294895304 (age 556.988s)
      hex dump (first 32 bytes):
        03 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 96 00 00 00 49 2b ff ff  ............I+..
      backtrace:
        [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
        [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
        [<000000008603f022>] damon_new_region+0x28/0x54
        [<00000000ca019f80>] damon_test_update_monitoring_result+0x18/0x34
        [<00000000559c4801>] kunit_try_run_case+0x50/0xac
        [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
        [<000000003c3e9211>] kthread+0x124/0x130
        [<0000000028f85bdd>] ret_from_fork+0x10/0x20

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Replace the damon_del_region() with damon_destroy_region() rather than
  calling damon_free_region().
- Update the commit message.
---
 mm/damon/core-test.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 79f1f12e0dd5..3959be35b901 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -30,7 +30,7 @@ static void damon_test_regions(struct kunit *test)
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test, 1u, damon_nr_regions(t));
 
-	damon_del_region(r, t);
+	damon_destroy_region(r, t);
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_free_target(t);
@@ -321,6 +321,8 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 20);
+
+	damon_free_region(r);
 }
 
 static void damon_test_set_attrs(struct kunit *test)
-- 
2.34.1

