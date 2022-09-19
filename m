Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A06121
	for <damon@lists.linux.dev>; Mon, 19 Sep 2022 15:12:17 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQEvWGD_1663600329;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQEvWGD_1663600329)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 23:12:09 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to simplify codes
Date: Mon, 19 Sep 2022 23:12:01 +0800
Message-Id: <20220919151201.66696-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220919151201.66696-1-xhao@linux.alibaba.com>
References: <20220919151201.66696-1-xhao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
we can use kzmalloc to alloc instance of the related structs, This makes
the function code much cleaner.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b852a75b9f39..06154ece7960 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -657,13 +657,7 @@ struct damon_sysfs_access_pattern {
 static
 struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
 {
-	struct damon_sysfs_access_pattern *access_pattern =
-		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
-
-	if (!access_pattern)
-		return NULL;
-	access_pattern->kobj = (struct kobject){};
-	return access_pattern;
+	return kzalloc(sizeof(struct damon_sysfs_access_pattern), GFP_KERNEL);
 }
 
 static int damon_sysfs_access_pattern_add_range_dir(
@@ -1620,12 +1614,7 @@ struct damon_sysfs_attrs {
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
 {
-	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
-
-	if (!attrs)
-		return NULL;
-	attrs->kobj = (struct kobject){};
-	return attrs;
+	return kzalloc(sizeof(struct damon_sysfs_attrs), GFP_KERNEL);
 }
 
 static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
-- 
2.31.0

