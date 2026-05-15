Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8E331213;
	Fri, 15 May 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805892; cv=none; b=VrQ51HjjG3TemV+P0xIk6GkYjPP2zXhp8oxsuoZncwjN4Etig6yQIx1lu+VBA9hzdxHTNS+Ow+eOjFKh0io9S4rnOHRNktXjtqFy60A/sD31tMfwedFr/u/fJMcbB7+t83+Y+m4GoAxZDAWRE+1dCtl06xJ0tK7W4aiEUBI0z8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805892; c=relaxed/simple;
	bh=zfDwKIyyj4OhfH36VyCWqtoWpGK8YTbqZuxXCa/IX6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN4hmLKGjtWWcXAp3M7aeD/kzWVF89L2X5PlECMqQBTZkAcTsKaTf5zMRqA/lZE4sOikIuiiOomodC05u8Zjh4vK3m7cazZwAbzuEZOVfgNuxlp4af2bxjtdwWGTYDIRmNFPbpW8vDFVHvfH8KZpKryK96QoI36ICXCXM3Fin0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA2TSQEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA2TSQEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C939AC2BCC7;
	Fri, 15 May 2026 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805891;
	bh=zfDwKIyyj4OhfH36VyCWqtoWpGK8YTbqZuxXCa/IX6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RA2TSQEVJhVhzO7gF5aqMZ/OvHsa6L40Jgzr1AEMykZpdrFgObt/f9S5tat0JddI1
	 naZzD6QeN8XperO1UlN+3CtDrK5cI0mHkyJQvvLPRxyJVC2Ioa9c5EXRDPIYCtdVx8
	 yIsz9NDuh289RfhKm46JIXVX6h88MAu2hUw7ccI6QMadWIEU+mAEcX6d/Pve+bI0Cs
	 rqsj1X5e+3l2BsiuP65I8QSdrBVl0YS0xuLdyu24SeAqJAm0nU4wvSiuVLdoVDDSQc
	 aRFQhZ924DCxOvbtPCVHXMngPEX6YVvKp5RzMnByG20O6lTuUQCTTRVYgtGwWQVIT0
	 QztMt2NBIcZJA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 12/28] mm/damon/sysfs: implement filter dir
Date: Thu, 14 May 2026 17:44:13 -0700
Message-ID: <20260515004433.128933-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a sysfs directory for letting the users to configure each data
probe filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6b15886190545..9f4ab28cf8734 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -747,12 +747,46 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * filter directory
+ */
+
+struct damon_sysfs_filter {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_filter);
+}
+
+static void damon_sysfs_filter_release(struct kobject *kobj)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+
+	kfree(filter);
+}
+
+static struct attribute *damon_sysfs_filter_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_filter);
+
+static const struct kobj_type damon_sysfs_filter_ktype = {
+	.release = damon_sysfs_filter_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_filter_groups,
+};
+
 /*
  * filters directory
  */
 
 struct damon_sysfs_filters {
 	struct kobject kobj;
+	struct damon_sysfs_filter **filters_arr;
+	int nr;
 };
 
 static struct damon_sysfs_filters *damon_sysfs_filters_alloc(void)
@@ -760,12 +794,98 @@ static struct damon_sysfs_filters *damon_sysfs_filters_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_filters);
 }
 
+static void damon_sysfs_filters_rm_dirs(struct damon_sysfs_filters *filters)
+{
+	struct damon_sysfs_filter **filters_arr = filters->filters_arr;
+	int i;
+
+	for (i = 0; i < filters->nr; i++)
+		kobject_put(&filters_arr[i]->kobj);
+	filters->nr = 0;
+	kfree(filters_arr);
+	filters->filters_arr = NULL;
+}
+
+static int damon_sysfs_filters_add_dirs(
+		struct damon_sysfs_filters *filters, int nr_filters)
+{
+	struct damon_sysfs_filter **filters_arr, *filter;
+	int err, i;
+
+	damon_sysfs_filters_rm_dirs(filters);
+	if (!nr_filters)
+		return 0;
+
+	filters_arr = kmalloc_objs(*filters_arr, nr_filters,
+				   GFP_KERNEL | __GFP_NOWARN);
+	if (!filters_arr)
+		return -ENOMEM;
+	filters->filters_arr = filters_arr;
+
+	for (i = 0; i < nr_filters; i++) {
+		filter = damon_sysfs_filter_alloc();
+		if (!filter) {
+			damon_sysfs_filters_rm_dirs(filters);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&filter->kobj,
+				&damon_sysfs_filter_ktype, &filters->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&filter->kobj);
+			damon_sysfs_filters_rm_dirs(filters);
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
+	struct damon_sysfs_filters *filters = container_of(kobj,
+			struct damon_sysfs_filters, kobj);
+
+	return sysfs_emit(buf, "%d\n", filters->nr);
+}
+
+static ssize_t nr_filters_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filters *filters;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	filters = container_of(kobj, struct damon_sysfs_filters, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_filters_add_dirs(filters, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_filters_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_filters, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_filters_nr_attr =
+		__ATTR_RW_MODE(nr_filters, 0600);
+
 static struct attribute *damon_sysfs_filters_attrs[] = {
+	&damon_sysfs_filters_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_filters);
@@ -811,7 +931,10 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
 
 static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *attr)
 {
-	kobject_put(&attr->filters->kobj);
+	if (attr->filters) {
+		damon_sysfs_filters_rm_dirs(attr->filters);
+		kobject_put(&attr->filters->kobj);
+	}
 }
 
 static void damon_sysfs_probe_release(struct kobject *kobj)
-- 
2.47.3
