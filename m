Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459DED3
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 02:57:26 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQH27MH_1663642320;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQH27MH_1663642320)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 10:52:02 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH v2] mm/damon/sysfs: return 'err' value when call kstrtoul() failed
Date: Tue, 20 Sep 2022 10:51:58 +0800
Message-Id: <20220920025158.70293-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had better return the 'err' value when calling kstrtoul() failed, so
the user will know why it really fails, there do little change, let it
return the 'err' value when failed.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Changes from v1
https://lore.kernel.org/linux-mm/20220919170305.61335-1-sj@kernel.org/T/
- keep the 'err' variable, and return the 'err' value when failed.
---
 mm/damon/sysfs.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0cca1909bf67..455215a5c059 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -58,7 +58,7 @@ static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,

 	err = kstrtoul(buf, 0, &min);
 	if (err)
-		return -EINVAL;
+		return err;

 	range->min = min;
 	return count;
@@ -83,7 +83,7 @@ static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,

 	err = kstrtoul(buf, 0, &max);
 	if (err)
-		return -EINVAL;
+		return err;

 	range->max = max;
 	return count;
@@ -291,9 +291,7 @@ static ssize_t interval_us_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->interval_us);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t high_show(struct kobject *kobj,
@@ -312,9 +310,7 @@ static ssize_t high_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->high);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t mid_show(struct kobject *kobj,
@@ -333,9 +329,7 @@ static ssize_t mid_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->mid);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t low_show(struct kobject *kobj,
@@ -354,9 +348,7 @@ static ssize_t low_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->low);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static void damon_sysfs_watermarks_release(struct kobject *kobj)
@@ -437,9 +429,7 @@ static ssize_t sz_permil_store(struct kobject *kobj,
 			struct damon_sysfs_weights, kobj);
 	int err = kstrtouint(buf, 0, &weights->sz);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t nr_accesses_permil_show(struct kobject *kobj,
@@ -458,9 +448,7 @@ static ssize_t nr_accesses_permil_store(struct kobject *kobj,
 			struct damon_sysfs_weights, kobj);
 	int err = kstrtouint(buf, 0, &weights->nr_accesses);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t age_permil_show(struct kobject *kobj,
@@ -479,9 +467,7 @@ static ssize_t age_permil_store(struct kobject *kobj,
 			struct damon_sysfs_weights, kobj);
 	int err = kstrtouint(buf, 0, &weights->age);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static void damon_sysfs_weights_release(struct kobject *kobj)
@@ -1111,9 +1097,7 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 			struct damon_sysfs_region, kobj);
 	int err = kstrtoul(buf, 0, &region->start);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1132,9 +1116,7 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 			struct damon_sysfs_region, kobj);
 	int err = kstrtoul(buf, 0, &region->end);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static void damon_sysfs_region_release(struct kobject *kobj)
@@ -1528,7 +1510,7 @@ static ssize_t sample_us_store(struct kobject *kobj,
 	int err = kstrtoul(buf, 0, &us);

 	if (err)
-		return -EINVAL;
+		return err;

 	intervals->sample_us = us;
 	return count;
@@ -1552,7 +1534,7 @@ static ssize_t aggr_us_store(struct kobject *kobj, struct kobj_attribute *attr,
 	int err = kstrtoul(buf, 0, &us);

 	if (err)
-		return -EINVAL;
+		return err;

 	intervals->aggr_us = us;
 	return count;
@@ -1576,7 +1558,7 @@ static ssize_t update_us_store(struct kobject *kobj,
 	int err = kstrtoul(buf, 0, &us);

 	if (err)
-		return -EINVAL;
+		return err;

 	intervals->update_us = us;
 	return count;
--
2.31.0
