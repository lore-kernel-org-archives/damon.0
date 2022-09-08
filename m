Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7197C
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 08:19:40 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VP1jGxJ_1662625176;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VP1jGxJ_1662625176)
          by smtp.aliyun-inc.com;
          Thu, 08 Sep 2022 16:19:37 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH] mm/damon/sysfs: change few functions execute order
Date: Thu,  8 Sep 2022 16:19:32 +0800
Message-Id: <20220908081932.77370-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call
kstrtoint() to get relative values from sysfs interface, if it return an
error, there get kobject instance would be meaningless through 'container_of'.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 88f208ff235d..54fdfcdbb3e4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1031,8 +1031,7 @@ static ssize_t nr_schemes_show(struct kobject *kobj,
 static ssize_t nr_schemes_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_schemes *schemes = container_of(kobj,
-			struct damon_sysfs_schemes, kobj);
+	struct damon_sysfs_schemes *schemes;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -1040,6 +1039,8 @@ static ssize_t nr_schemes_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
+	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_schemes_add_dirs(schemes, nr);
@@ -1237,8 +1238,7 @@ static ssize_t nr_regions_show(struct kobject *kobj,
 static ssize_t nr_regions_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_regions *regions = container_of(kobj,
-			struct damon_sysfs_regions, kobj);
+	struct damon_sysfs_regions *regions;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -1246,6 +1246,8 @@ static ssize_t nr_regions_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
+	regions = container_of(kobj, struct damon_sysfs_regions, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_regions_add_dirs(regions, nr);
@@ -1440,8 +1442,7 @@ static ssize_t nr_targets_show(struct kobject *kobj,
 static ssize_t nr_targets_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_targets *targets = container_of(kobj,
-			struct damon_sysfs_targets, kobj);
+	struct damon_sysfs_targets *targets;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -1449,6 +1450,8 @@ static ssize_t nr_targets_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
+	targets = container_of(kobj, struct damon_sysfs_targets, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_targets_add_dirs(targets, nr);
@@ -1962,8 +1965,7 @@ static ssize_t nr_contexts_show(struct kobject *kobj,
 static ssize_t nr_contexts_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_contexts *contexts = container_of(kobj,
-			struct damon_sysfs_contexts, kobj);
+	struct damon_sysfs_contexts *contexts;
 	int nr, err;
 
 	err = kstrtoint(buf, 0, &nr);
@@ -1973,6 +1975,7 @@ static ssize_t nr_contexts_store(struct kobject *kobj,
 	if (nr < 0 || 1 < nr)
 		return -EINVAL;
 
+	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_contexts_add_dirs(contexts, nr);
@@ -2741,8 +2744,7 @@ static ssize_t nr_kdamonds_show(struct kobject *kobj,
 static ssize_t nr_kdamonds_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
-			struct damon_sysfs_kdamonds, kobj);
+	struct damon_sysfs_kdamonds *kdamonds;
 	int nr, err;
 
 	err = kstrtoint(buf, 0, &nr);
@@ -2751,6 +2753,8 @@ static ssize_t nr_kdamonds_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
+	kdamonds = container_of(kobj, struct damon_sysfs_kdamonds, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
-- 
2.31.0

