Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAF1C6F75
	for <damon@lists.linux.dev>; Thu, 10 Oct 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564856; cv=none; b=uL9vi3Ny6YoOn3sgOYX6cRSM+69XfeUL1+wRmcfKcdThsV8BBcaTeMMmXWImRBWIQJGWHqxgnPea3qBqJBYNIpc+694X4bgoQjKaGFqm+4klOrFsGP+c+0Jy1LSw0GM03iDDXc4JJu6+yb0C62493x53oz3v0tG+zXzlmWzIrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564856; c=relaxed/simple;
	bh=97tLnF4AS+RZyQ0ivH1Pce210sanpQtAzJD7zCqUW1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CR3bjfNdPwJEMVb7YZRjGH1ldGBTESu008o+4PZ2yEnFAxyqZlAfA4t5wTSdcXsLiHAKEn1OOUaujRSEsdiDMViSEah9pewaS4/d72lfJlPn2O/GxYbiue/TuJEzTKkt41vNjqubgHxbdKZr/6+lhkbj3z+K/GeKhMpJAQbgBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPV300dX8z1HKkn;
	Thu, 10 Oct 2024 20:50:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 017A41400DC;
	Thu, 10 Oct 2024 20:54:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 20:54:10 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] mm/damon: Fix memory leak in damon_sysfs_test_add_targets()
Date: Thu, 10 Oct 2024 20:53:23 +0800
Message-ID: <20241010125323.3127187-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sysfs_target->regions allocated in damon_sysfs_regions_alloc()
is not freed in damon_sysfs_test_add_targets(), which cause the following
memory leak, free it to fix it.

	unreferenced object 0xffffff80c2a8db80 (size 96):
	  comm "kunit_try_catch", pid 187, jiffies 4294894363
	  hex dump (first 32 bytes):
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	  backtrace (crc 0):
	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
	    [<000000008e6835c1>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000001286d9f8>] damon_sysfs_test_add_targets+0x1cc/0x738
	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000adf936cf>] kthread+0x2e8/0x374
	    [<0000000041bb1628>] ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 mm/damon/tests/sysfs-kunit.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 1c9b596057a7..7b5c7b307da9 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -67,6 +67,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 	damon_destroy_ctx(ctx);
 	kfree(sysfs_targets->targets_arr);
 	kfree(sysfs_targets);
+	kfree(sysfs_target->regions);
 	kfree(sysfs_target);
 }
 
-- 
2.34.1

