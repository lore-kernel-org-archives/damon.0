Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73567C
	for <damon@lists.linux.dev>; Mon, 19 Sep 2022 15:12:17 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQEvWFT_1663600327;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQEvWFT_1663600327)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 23:12:08 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH v1 1/2] mm/damon/sysfs: remove unnecessary variables
Date: Mon, 19 Sep 2022 23:12:00 +0800
Message-Id: <20220919151201.66696-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just do a little change here, the 'err' variable really no need to stay
here.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0cca1909bf67..b852a75b9f39 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1109,9 +1109,8 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->start);

-	if (err)
+	if (kstrtoul(buf, 0, &region->start))
 		return -EINVAL;
 	return count;
 }
@@ -1130,9 +1129,8 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->end);

-	if (err)
+	if (kstrtoul(buf, 0, &region->end))
 		return -EINVAL;
 	return count;
 }
--
2.31.0
