Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACF31AA8D;
	Mon,  8 Dec 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175402; cv=none; b=Vli6durf3/GgjnsvJzGEU8J0JYEp+Ce2YbnOKmFYo8E5oKjc1iujCSGw830mdDLE/XA2jzFvvfza4Ul8TotNm42Q3o7Umn6Q43DuP/SmSgON3kIyEbPeEUxny6XZVP/vVK/GCK0G1eU/6DJ7dLoyee3PwV16QfWdTpuW0Zrzb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175402; c=relaxed/simple;
	bh=yNKU0Z4igXUk3W3EuJXr4KHd7edg/Rmbwvdbsef5Gq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+8dMqEL5Krf/GAYQYZ075lES9gyDiZ7Ii240iDnE0ysKc9ylWizpprs/9acPfMDmJCF5HUIN5SiYENXJdvEME5aUNE6h7Rcis5pMjCGvdYyVT/rseQGer5LaoqZo/1Lk/lrRs8sVUspkOj19wpzf8wdIzgLNKb7CvyoqCMFJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrME62N/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrME62N/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEA4C4CEF1;
	Mon,  8 Dec 2025 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175402;
	bh=yNKU0Z4igXUk3W3EuJXr4KHd7edg/Rmbwvdbsef5Gq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrME62N/PIHC0ErSD9JgYLo9mp27uJj3fEFSvF32aAnvVB0Mc9jn/hxaAvgLXa3Zy
	 HKLkMxqoIIIYF2fMInXLwCbzYMSF4F6isxZ5pkA+LWtHcntMpjy72AiBnmrtm3Fzsd
	 Jl5Jxw6g3zU66UjAL+5M3P1ftZ0GstG2jEsL57AfRFuqmF49XAHTpKOKxmkjH865zp
	 39h3e/whDgUHJzw+ZhkCLPumPQv/WsrDdeAFrubui+vA69poFTnVqTMYpFmzMoRZeK
	 3xsr3NSLbACB/5uT0gEFuTjM1TxMdzEaXwg3H7qAWiuBrdhShHMvUyRvp6QSTAirD/
	 DJs0J+I5eOpjQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 09/37] mm/damon/sysfs: implement sample/primitives/ dir
Date: Sun,  7 Dec 2025 22:29:13 -0800
Message-ID: <20251208062943.68824-10-sj@kernel.org>
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

Add a sysfs directory that will be used to let DAMON ABI users control
what access sampling primitives to use, among page table Accessed bit,
and page fault events.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 851e8c0dc989..14478fd79953 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -749,12 +749,111 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * access check primitives directory
+ */
+
+struct damon_sysfs_primitives {
+	struct kobject kobj;
+	bool page_table;
+	bool page_fault;
+};
+
+static struct damon_sysfs_primitives *damon_sysfs_primitives_alloc(
+		bool page_table, bool page_fault)
+{
+	struct damon_sysfs_primitives *primitives = kmalloc(
+			sizeof(*primitives), GFP_KERNEL);
+
+	if (!primitives)
+		return NULL;
+
+	primitives->kobj = (struct kobject){};
+	primitives->page_table = page_table;
+	primitives->page_fault = page_fault;
+	return primitives;
+}
+
+static ssize_t page_table_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_primitives *primitives = container_of(kobj,
+			struct damon_sysfs_primitives, kobj);
+
+	return sysfs_emit(buf, "%c\n", primitives->page_table ? 'Y' : 'N');
+}
+
+static ssize_t page_table_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_primitives *primitives = container_of(kobj,
+			struct damon_sysfs_primitives, kobj);
+	bool enable;
+	int err = kstrtobool(buf, &enable);
+
+	if (err)
+		return err;
+	primitives->page_table = enable;
+	return count;
+}
+
+static ssize_t page_fault_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_primitives *primitives = container_of(kobj,
+			struct damon_sysfs_primitives, kobj);
+
+	return sysfs_emit(buf, "%c\n", primitives->page_fault ? 'Y' : 'N');
+}
+
+static ssize_t page_fault_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_primitives *primitives = container_of(kobj,
+			struct damon_sysfs_primitives, kobj);
+	bool enable;
+	int err = kstrtobool(buf, &enable);
+
+	if (err)
+		return err;
+	primitives->page_fault = enable;
+	return count;
+}
+
+static void damon_sysfs_primitives_release(struct kobject *kobj)
+{
+	struct damon_sysfs_primitives *primitives = container_of(kobj,
+			struct damon_sysfs_primitives, kobj);
+
+	kfree(primitives);
+}
+
+static struct kobj_attribute damon_sysfs_primitives_page_table_attr =
+		__ATTR_RW_MODE(page_table, 0600);
+
+static struct kobj_attribute damon_sysfs_primitives_page_fault_attr =
+		__ATTR_RW_MODE(page_fault, 0600);
+
+static struct attribute *damon_sysfs_primitives_attrs[] = {
+	&damon_sysfs_primitives_page_table_attr.attr,
+	&damon_sysfs_primitives_page_fault_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_primitives);
+
+static const struct kobj_type damon_sysfs_primitives_ktype = {
+	.release = damon_sysfs_primitives_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_primitives_groups,
+};
+
 /*
  * sample directory
  */
 
 struct damon_sysfs_sample {
 	struct kobject kobj;
+	struct damon_sysfs_primitives *primitives;
 };
 
 static struct damon_sysfs_sample *damon_sysfs_sample_alloc(void)
@@ -768,6 +867,35 @@ static struct damon_sysfs_sample *damon_sysfs_sample_alloc(void)
 	return sample;
 }
 
+static int damon_sysfs_sample_add_dirs(
+		struct damon_sysfs_sample *sample)
+{
+	struct damon_sysfs_primitives *primitives;
+	int err;
+
+	primitives = damon_sysfs_primitives_alloc(true, false);
+	if (!primitives)
+		return -ENOMEM;
+	err = kobject_init_and_add(&primitives->kobj,
+			&damon_sysfs_primitives_ktype, &sample->kobj,
+			"primitives");
+	if (err)
+		goto put_primitives_out;
+	sample->primitives = primitives;
+
+put_primitives_out:
+	kobject_put(&primitives->kobj);
+	sample->primitives = NULL;
+	return err;
+}
+
+static void damon_sysfs_sample_rm_dirs(
+		struct damon_sysfs_sample *sample)
+{
+	if (sample->primitives)
+		kobject_put(&sample->primitives->kobj);
+}
+
 static void damon_sysfs_sample_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_sample, kobj));
@@ -847,6 +975,9 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	err = kobject_init_and_add(&sample->kobj,
 			&damon_sysfs_sample_ktype, &attrs->kobj,
 			"sample");
+	if (err)
+		goto put_sample_out;
+	err = damon_sysfs_sample_add_dirs(sample);
 	if (err)
 		goto put_sample_out;
 	attrs->sample = sample;
@@ -869,6 +1000,7 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->nr_regions_range->kobj);
 	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
+	damon_sysfs_sample_rm_dirs(attrs->sample);
 	kobject_put(&attrs->sample->kobj);
 }
 
-- 
2.47.3
