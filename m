Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29C31AF17;
	Mon,  8 Dec 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175419; cv=none; b=k8UdxgxDVunLXq8JewZKAMP2OS7UFatE7fuO2s3WRKQEPM8dEJNyEl/68kRpklxPFUznjo3l7+sodG+WE7aJievdI7MyOQRg0u0f1FIucEIUTiNPQ4jjiWWoLZYOdUDoHzOdgS0alb2KTGcfwKzB7bCXgxkjSs7K2TMLYr2CHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175419; c=relaxed/simple;
	bh=fqtI2Gnz07OVYPT/2oX+SDTbNLPGFodcuU+kQDn13Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+A1iLvP9GcxjOfzmv7C7disTc2Z/MUg9Yy1ccm1OlP9hB0668xhSvgJHhhsdgly837Yw5ssSVJ1GgMg8GApdmH4RSZn7YCwhN9wZI5kUKxy9YIMu0DOaqxmd3XgRLJb1F8ihcJcF2Boiein9odO1RXG0uXll/85Fsp35b9RRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diF8S5Xl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diF8S5Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D0BC19421;
	Mon,  8 Dec 2025 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175419;
	bh=fqtI2Gnz07OVYPT/2oX+SDTbNLPGFodcuU+kQDn13Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diF8S5Xl62t4a4nrz6s9jCM+NbKUjbmQqLXN6ILr6Xw7ZT9FjwflJzMxaRNvwJ3xS
	 0qJlyuAKQSwruTpl/XCWLD27ziMxSuAnNrATHYkI6vMUm+Pts1Ap79LBGceoNAa04F
	 RnjRiX+z4WCT5BINlgRz623mMcThFeb3xcqQGAcAdB112HUr40JjaHQkUj9NqBW8c9
	 R+OdqQeNs5DTvdLmzFmUorj1/3LKOz8wpb4tvhZ6JzJKvMm+O9ymy4c6YfcIM5cawr
	 3bdgx3SBR+sHWHr962QlfwlxxxUzZ5H2wAPSQhyJrBKurxOcZR/dWoQu3bBKB+cO1p
	 IXPyl/gyERCXQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 20/37] mm/damon/sysfs: implement sample filter directory
Date: Sun,  7 Dec 2025 22:29:24 -0800
Message-ID: <20251208062943.68824-21-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement sysfs directory for setting individual DAMON sample filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 4208fed2b8df..ba0c76c1300c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -749,12 +749,46 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * access check report filter directory
+ */
+
+struct damon_sysfs_sample_filter {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_sample_filter), GFP_KERNEL);
+}
+
+static void damon_sysfs_sample_filter_release(struct kobject *kobj)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	kfree(filter);
+}
+
+static struct attribute *damon_sysfs_sample_filter_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_sample_filter);
+
+static const struct kobj_type damon_sysfs_sample_filter_ktype = {
+	.release = damon_sysfs_sample_filter_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_sample_filter_groups,
+};
+
 /*
  * access check report filters directory
  */
 
 struct damon_sysfs_sample_filters {
 	struct kobject kobj;
+	struct damon_sysfs_sample_filter **filters_arr;
+	int nr;
 };
 
 static struct damon_sysfs_sample_filters *
@@ -763,12 +797,99 @@ damon_sysfs_sample_filters_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_sample_filters), GFP_KERNEL);
 }
 
+static void damon_sysfs_sample_filters_rm_dirs(
+		struct damon_sysfs_sample_filters *filters)
+{
+	struct damon_sysfs_sample_filter **filters_arr = filters->filters_arr;
+	int i;
+
+	for (i = 0; i < filters->nr; i++)
+		kobject_put(&filters_arr[i]->kobj);
+	filters->nr = 0;
+	kfree(filters_arr);
+	filters->filters_arr = NULL;
+}
+
+static int damon_sysfs_sample_filters_add_dirs(
+		struct damon_sysfs_sample_filters *filters, int nr_filters)
+{
+	struct damon_sysfs_sample_filter **filters_arr, *filter;
+	int err, i;
+
+	damon_sysfs_sample_filters_rm_dirs(filters);
+	if (!nr_filters)
+		return 0;
+
+	filters_arr = kmalloc_array(nr_filters, sizeof(*filters_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!filters_arr)
+		return -ENOMEM;
+	filters->filters_arr = filters_arr;
+
+	for (i = 0; i < nr_filters; i++) {
+		filter = damon_sysfs_sample_filter_alloc();
+		if (!filter) {
+			damon_sysfs_sample_filters_rm_dirs(filters);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&filter->kobj,
+				&damon_sysfs_sample_filter_ktype,
+				&filters->kobj, "%d", i);
+		if (err) {
+			kobject_put(&filter->kobj);
+			damon_sysfs_sample_filters_rm_dirs(filters);
+			return err;
+		}
+
+		filters_arr[i] = filter;
+		filters->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_filters_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_sample_filters *filters = container_of(kobj,
+			struct damon_sysfs_sample_filters, kobj);
+
+	return sysfs_emit(buf, "%d\n", filters->nr);
+}
+
+static ssize_t nr_filters_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filters *filters;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	filters = container_of(kobj, struct damon_sysfs_sample_filters, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_sample_filters_add_dirs(filters, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_sample_filters_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_sample_filters, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_sample_filters_nr_attr =
+		__ATTR_RW_MODE(nr_filters, 0600);
+
 static struct attribute *damon_sysfs_sample_filters_attrs[] = {
+	&damon_sysfs_sample_filters_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_sample_filters);
@@ -940,6 +1061,7 @@ static void damon_sysfs_sample_rm_dirs(
 	if (sample->primitives)
 		kobject_put(&sample->primitives->kobj);
 	if (sample->filters) {
+		damon_sysfs_sample_filters_rm_dirs(sample->filters);
 		kobject_put(&sample->filters->kobj);
 	}
 }
-- 
2.47.3
