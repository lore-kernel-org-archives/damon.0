Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551435F16C
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987625; cv=none; b=F5EQS1ciAN4nOVpv+pS9GjQLjEh+AiWY8IAFWqRN66BfJIJ6zsA3zuBRngBhSClw9ZKFbvUCNyjqAhXJbgiw9JSxE38+XXYAO38r5wipqfFEoN5N939yEYVJzW1avRji5w3wASXYLPGzM0FlNRWniX6pFqhj7DwF4vUmxi7shgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987625; c=relaxed/simple;
	bh=bS8BHyasorUt4Ia8VHc2W8z2sVSx6Pr6Sz3B+u8D8Dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHm1FC+PZGtFgZp7hbUkC7C77dnWg4apZogkR/fqt1w1B4WF8OfelPPSSgr5YapYWwqh2oJ1jTqrlUlR4lAXfPXvG6XEy0WpmviDbF9Eaqu0hwvuK+TZdQYe2qcc027Hy1uaRLtGULXvi/kcgnOaTBZl6YFuT/seLElvihidryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FxGQcsb1; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FxGQcsb1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6O9vE//ZqlO4Gb4yDRMv8e+QwkXD/QOq+MMZNAQa+NU=;
	b=FxGQcsb13I2Xm9LCs9JqyTH3wH2YCXzdIa1ZW0Y3G8ZTugZfgqpTv7RDq8ZRm07YCYsAI+26Q
	yMdHk3U02w/yMBNoPl0jIsqK6/uCpEkE7qKRFOmjUaqrQ1o9woK4h51AO4Okqv0sR0GYA+RMEWL
	cYHoHEVGHx8kJsKyPIPaXwI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gZK4n6WTjzLlSX;
	Tue,  9 Jun 2026 14:39:05 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 149EF40562;
	Tue,  9 Jun 2026 14:46:59 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 14:46:58 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>, <wangzhigang17@huawei.com>,
	<liqiqi23@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2] samples/damon/mtier: fail early if address range parameters are invalid
Date: Tue, 9 Jun 2026 14:46:52 +0800
Message-ID: <20260609064653.1829-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200017.china.huawei.com (7.202.194.83)

The comment on top of `struct damon_region` clearly says that

    For any use case, @ar should be non-zero positive size.

which is now verified in damon_verify_new_region() if the kernel is built
with DAMON_DEBUG_SANITY.

The WARN_ONCE() can be triggered if the mtier sample module is enabled
before node{0,1}_{start,end}_addr have been properly initialized, which is
obviously not good.

 ------------[ cut here ]------------
 start 0 >= end 0
 WARNING: mm/damon/core.c:217 at damon_new_region+0xf4/0x118, CPU#59: bash/341468
 Call trace:
  damon_new_region+0xf4/0x118 (P)
  damon_set_regions+0xfc/0x3c0
  damon_sample_mtier_build_ctx+0xe8/0x3a8
  damon_sample_mtier_start+0x1c/0x90
  damon_sample_mtier_enable_store+0x98/0xb0
  param_attr_store+0xb4/0x128
  module_attr_store+0x2c/0x50
  sysfs_kf_write+0x58/0x90
  kernfs_fop_write_iter+0x16c/0x238
  vfs_write+0x2c0/0x370
  ksys_write+0x74/0x118
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0xa8/0x118
  el0_svc_common.constprop.0+0x48/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x54/0x370
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1ac/0x1b0
 ---[ end trace 0000000000000000 ]---

Note that the same issue can happen if detect_node_addresses is true, and
node 0 or 1 is memoryless. Fix it together by checking the validity of
parameters right before damon_new_region() and fail early if they're
invalid.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
* From v1 [1]:
  - take into account the detect_node_addresses case (Sashiko)
  - based on mm-new (SeongJae)

[1] https://lore.kernel.org/r/20260608111534.264-1-yuzenghui@huawei.com

 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index eb1143de8df1..3785b0c7ffb1 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 		addr.end = promote ? node1_end_addr : node0_end_addr;
 	}
 
+	if (addr.start >= addr.end)
+		goto free_out;
+
 	range.start = addr.start;
 	range.end = addr.end;
 
-- 
2.33.0

