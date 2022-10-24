Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC256AD8
	for <damon@lists.linux.dev>; Mon, 24 Oct 2022 20:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0F5C433C1;
	Mon, 24 Oct 2022 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666644569;
	bh=zkSKxd+aFM4wLLzA3DhfvQt2mZE0FdxT9KFkAovv2q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6WZBASYLD6LklC/+lqeZoDfG3dGQIzRLumccHTMO4T7Q5mINGCI4MIgGb2B0XqhT
	 1NFEYa+1n12cb74Dg3VHsDmrhWsQPW2QOb8aIS/NQ9qxx+vLNRqeyDN2xi75Omjov1
	 oToMe521lNjikNFXIh0rt82zJXngxjovF3SSWwZDJ8UzVuc8yIBdlOt8tgk3BiVeB9
	 ZCt2PNnfHBZqzAxrxHxb2bIa7JRuZA4O8gVk3m4FyTSyi7rH0uLhiLIu/+aN4igQlr
	 Orb4Ju7MGgTATAU84n36nZY4tv4zqMrn8Rs76A+rg7UpvX7X2Wq2vKi93zy0khlsY+
	 1m7BXfV5hTJzA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mm/damon/sysfs: move unsigned long range directory to common module
Date: Mon, 24 Oct 2022 20:49:16 +0000
Message-Id: <20221024204919.18524-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of unsigned long type range directories can be reused
by multiple DAMON sysfs directories including those for DAMON-based
Operation Schemes and the range of number of monitoring regions.  Move
the code into the files for DAMON sysfs common logics.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.c |  96 ++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-common.h |  13 ++++++
 mm/damon/sysfs.c        | 100 ----------------------------------------
 3 files changed, 109 insertions(+), 100 deletions(-)

diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 9dc743868d5b..52bebf242f74 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -5,7 +5,103 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/slab.h>
+
 #include "sysfs-common.h"
 
 DEFINE_MUTEX(damon_sysfs_lock);
 
+/*
+ * unsigned long range directory
+ */
+
+struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
+		unsigned long min,
+		unsigned long max)
+{
+	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
+			GFP_KERNEL);
+
+	if (!range)
+		return NULL;
+	range->kobj = (struct kobject){};
+	range->min = min;
+	range->max = max;
+
+	return range;
+}
+
+static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->min);
+}
+
+static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long min;
+	int err;
+
+	err = kstrtoul(buf, 0, &min);
+	if (err)
+		return err;
+
+	range->min = min;
+	return count;
+}
+
+static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->max);
+}
+
+static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long max;
+	int err;
+
+	err = kstrtoul(buf, 0, &max);
+	if (err)
+		return err;
+
+	range->max = max;
+	return count;
+}
+
+void damon_sysfs_ul_range_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_ul_range_min_attr =
+		__ATTR_RW_MODE(min, 0600);
+
+static struct kobj_attribute damon_sysfs_ul_range_max_attr =
+		__ATTR_RW_MODE(max, 0600);
+
+static struct attribute *damon_sysfs_ul_range_attrs[] = {
+	&damon_sysfs_ul_range_min_attr.attr,
+	&damon_sysfs_ul_range_max_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
+
+struct kobj_type damon_sysfs_ul_range_ktype = {
+	.release = damon_sysfs_ul_range_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ul_range_groups,
+};
+
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 745a918b94f5..56e6a99e353b 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -9,3 +9,16 @@
 #include <linux/kobject.h>
 
 extern struct mutex damon_sysfs_lock;
+
+struct damon_sysfs_ul_range {
+	struct kobject kobj;
+	unsigned long min;
+	unsigned long max;
+};
+
+struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
+		unsigned long min,
+		unsigned long max);
+void damon_sysfs_ul_range_release(struct kobject *kobj);
+
+extern struct kobj_type damon_sysfs_ul_range_ktype;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0f3f06d8dae7..129743292e17 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -11,106 +11,6 @@
 
 #include "sysfs-common.h"
 
-/*
- * unsigned long range directory
- */
-
-struct damon_sysfs_ul_range {
-	struct kobject kobj;
-	unsigned long min;
-	unsigned long max;
-};
-
-static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
-		unsigned long min,
-		unsigned long max)
-{
-	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
-			GFP_KERNEL);
-
-	if (!range)
-		return NULL;
-	range->kobj = (struct kobject){};
-	range->min = min;
-	range->max = max;
-
-	return range;
-}
-
-static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-
-	return sysfs_emit(buf, "%lu\n", range->min);
-}
-
-static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-	unsigned long min;
-	int err;
-
-	err = kstrtoul(buf, 0, &min);
-	if (err)
-		return err;
-
-	range->min = min;
-	return count;
-}
-
-static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-
-	return sysfs_emit(buf, "%lu\n", range->max);
-}
-
-static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-	unsigned long max;
-	int err;
-
-	err = kstrtoul(buf, 0, &max);
-	if (err)
-		return err;
-
-	range->max = max;
-	return count;
-}
-
-static void damon_sysfs_ul_range_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_ul_range_min_attr =
-		__ATTR_RW_MODE(min, 0600);
-
-static struct kobj_attribute damon_sysfs_ul_range_max_attr =
-		__ATTR_RW_MODE(max, 0600);
-
-static struct attribute *damon_sysfs_ul_range_attrs[] = {
-	&damon_sysfs_ul_range_min_attr.attr,
-	&damon_sysfs_ul_range_max_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
-
-static struct kobj_type damon_sysfs_ul_range_ktype = {
-	.release = damon_sysfs_ul_range_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_ul_range_groups,
-};
-
 /*
  * schemes/stats directory
  */
-- 
2.25.1

