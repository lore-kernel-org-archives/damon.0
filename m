Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03134B697
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917347; cv=none; b=ihmPx+iCWWUYy7P2CbLNSZN1qgOwAI8ncdO96iXog4I1I6bCh7rDxgeP1nVHBIbqNHlbJYOBAtGRkXcCUVw/iWhRVGiorQiFS5YfQt0nDNlE7VQ8X5OKK8V3vxGIIeZH8gtL2BwT58SFLb+JKCEHE29yB3wgmQh9lRD+FrOavNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917347; c=relaxed/simple;
	bh=mLsfLkVhy/gvj2ONK5Zx0NuE4AwPjfI+7Kf0QNkXDtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YEHbg4dVfW5dMmhmYeQ29v8uxOyq/GTi8GSVHflcwm98sIZzgtV8Pdc4B7ViPia5bu3/x9xQA0XFWC4DRGqwajWkYy/552+70zZzpk7QoncwByCOjSQk44dDlbwWZt7vNJDGAFL20K/arICkPn/TNfth9RJR6OuR8nr7VnO2AdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MTm0efw7; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MTm0efw7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5FPC2aDwg5mBNqHLEf0QUYF464aa6oMYs9z5oC3+/mQ=;
	b=MTm0efw7c9Kg084CS0dQqAJe5WrTttbpao8SeMxt3fefxTd2DcxZJBgejnC92rLgTGh2VQRaD
	Xf48sm+p7iPqkzJPii/f/Tk9j+WBsTc4bm9DguS732djCEQoW2VNpQWqvHnzcUGS9UMUx8Rqbbi
	zSWAaL1IO0t1RWfgKe52KfQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gYq5L49b8znTVy;
	Mon,  8 Jun 2026 19:07:50 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id C20E640575;
	Mon,  8 Jun 2026 19:15:40 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 19:15:40 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>, <wangzhigang17@huawei.com>,
	<liqiqi23@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon, 8 Jun 2026 19:15:34 +0800
Message-ID: <20260608111534.264-1-yuzenghui@huawei.com>
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
 WARNING: mm/damon/core.c:116 at damon_new_region+0xf0/0x118, CPU#39: bash/34144
 Call trace:
  damon_new_region+0xf0/0x118 (P)
  damon_sample_mtier_build_ctx+0xd4/0x368
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

Fix it by checking the validity of parameters right before
damon_new_region() and fail early if they're invalid.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 775838a23d93..4a5d3fb12e1b 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	} else {
 		addr.start = promote ? node1_start_addr : node0_start_addr;
 		addr.end = promote ? node1_end_addr : node0_end_addr;
+
+		if (addr.start >= addr.end)
+			goto free_out;
 	}
 
 	region = damon_new_region(addr.start, addr.end);
-- 
2.33.0

