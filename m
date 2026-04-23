Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE11D5ABA
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905001; cv=none; b=hSZIrNbDO+YsO8GUTtP0z1pkoO3Z7YauCgmFHgKbNDQbbnuLHCurmbLblt9NOWTWp9OLGdmxP1o28GIk1PChUpOMtA68g9fIfAjJe5Cdzjm7CD2SZ/3Ru7VGAXOEvQxxkvKRIb7hA5rJvmWZfCcMZ4MS/IpqpIMlASuLKNgOgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905001; c=relaxed/simple;
	bh=p2VMbwx9CRVU8YlKJde9eWW6nK8l8Jg9QZWedI6GXbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOnrCmdqAhkPpVugUREEZiT80P33s+6lXQvbhOedwi2IFsAAPDhRXjtWU4eQwnfx84H7o/J11RErC3hVs08JvXKqSRrIqVtoJtV5C06QgjZjIvF4SXMfm+EHQjrp6VSaxyugqYREVxE3h8mEI9t3GVpzi4nAXRuraNYmSMgvcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRJOc0GS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRJOc0GS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso28402915ad.1
        for <damon@lists.linux.dev>; Wed, 22 Apr 2026 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776904999; x=1777509799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGyaTZAVR0gi4W8cRPqgOT4qBMfHwh1rPE8qwQ7RFhc=;
        b=hRJOc0GSE/eKJgxyQaVdia3EXbicemSFTTJjWXIEUqILZ/KrrdzWsQ4a9HfdbNB1fp
         3jOEcgiLVTvwq05NfDlQYiY7J3s/QUCa+7+Sy+JOMWNx/Ss9MBJxyMopOrDmj6/CbKHc
         ocrq7h9UZ49Ua+WGQA7Imf61LzSmIXOnoM+vADTzq960l5+p17tbFMXfqeXpfs60BXjv
         j0ghCaS1dRSfpc5KniwKCdyY2CUXTEuPfpEUUkeOF0tmTkYTwyyIAdWV55yC9IiaBeLb
         kZgGeIi02LXv4g3EeniqHZHbMA+Rslv0XqMby5nk8uB25Y9ySWUAq67novwsPbtzVE8W
         xKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776904999; x=1777509799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGyaTZAVR0gi4W8cRPqgOT4qBMfHwh1rPE8qwQ7RFhc=;
        b=HKRr5t592lPGVvauG3fgRFxQP8ZJU0Oz8N/SnEoaya+j9Zx2XxNpA7rj4ZPdxAap27
         o0YjsGfgESx4ji+6ZmvVX8uWPEU0AB0EaiXIxU312zi3Chks3sY+yQuUNl+SlyDmBzY0
         KTCw2+j4hl7xcA/sJUxxMaQAk8YFdwJJRDJ/TX6fv0AWrSs1iIxaZGEddcpS07FaY+4j
         R49nHQ2MZCAfCUsjoYVYcJf2ZPSt+eoto3klgFQyvcSKQiaxFwOpSo/tRd8wTWoW3cF8
         lYZEpf9xLKIfAG08ljn1GnWq+MS8cbQvX7qS9oVwJahRPOh/mmYxgUXRyXEXiolBFg6d
         ve4A==
X-Gm-Message-State: AOJu0Yz45Zp8LjSo1ccsPkrGFkaKc0O9mfLhiaCh/JPR1+3M4ASm3cRP
	OSgpAof0GGDrpvl87+1SgOxlFixqVxtvQ92LguExR8rNTsJaDip3ddua8T20jw==
X-Gm-Gg: AeBDietvnpmHKj1HKEGTt2SbeBYuHy8uD8jnv1Ub8UFUXt+BhtaMkxY8z9aWk3ouArd
	vT/iHAimcRgIplhXmDw5O7hTsGnhbaMVoEwgeQYDXH1Z1ggGC3PqXOtcdpIXptUlI7bVS4MerUx
	1JNSNxnVRtriNTjiQDFQScE7hvsCgb9oWp9K0tu7PVoAfZntAJIVUcdfHeAQDTNMwFQir9Kakdj
	XGNgwSC0VSgBjZ53jz2IEN0JlTx+dpech6uHP0YheLMeJUn6mXcDtKKcorUwQY0p2BaFI1Z4SE4
	p+iIZt/3ZN6RSbOxkNr/D+wzc4Whew3F2D9tDWKZ15ngHhIx/2vhAEMqjWBdorP91CtNXxqqwvP
	TmAWUW+AoEga/l2KwASyQDu735DeHuXqqzt+OKNh1OMQB+1COgsz4P72HXMbrNVvnYACprGxS+N
	6huE0fTKSpDgLTFy6tThHIZSQsqXnU8ZaEQXlThJkq8ZKx+6DJ
X-Received: by 2002:a17:903:120d:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b5f9e8195fmr265633975ad.11.1776904998793;
        Wed, 22 Apr 2026 17:43:18 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:963d:c5da:6762:8843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4bf7bsm176724085ad.81.2026.04.22.17.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:43:18 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v3 1/4] mm/damon/core: add code borrowed from report-based monitoring work
Date: Thu, 23 Apr 2026 09:42:07 +0900
Message-ID: <20260423004211.7037-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423004211.7037-1-akinobu.mita@gmail.com>
References: <20260423004211.7037-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf event-based monitoring will be implemented on top of the
report-based monitoring infrastructure, but since the migration is
still in progress, only borrow the following necessary code for now.

* struct damon_access_report
* access_reported field in struct damon_region
* sample/primitives/ sysfs directory

[1] https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org/T/
---
 include/linux/damon.h |  68 ++++++
 mm/damon/core.c       |   1 +
 mm/damon/sysfs.c      | 499 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 568 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6..9ba26d8a0bce 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -85,6 +85,7 @@ struct damon_region {
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	bool access_reported;
 };
 
 /**
@@ -112,6 +113,30 @@ struct damon_target {
 	bool obsolete;
 };
 
+/**
+ * struct damon_access_report - Represent single access report information.
+ * @paddr:		Start physical address of the accessed address range.
+ * @vaddr:		Start virtual address of the accessed address range.
+ * @size:		The size of the accessed address range.
+ * @cpu:		The id of the CPU that made the access.
+ * @tid:		The task id of the task that made the access.
+ * @is_write:		Whether the access is write.
+ *
+ * Any DAMON API callers that notified access events can report the information
+ * to DAMON using damon_report_access().  This struct contains the reporting
+ * information.  Refer to damon_report_access() for more details.
+ */
+struct damon_access_report {
+	unsigned long paddr;
+	unsigned long vaddr;
+	unsigned long size;
+	unsigned int cpu;
+	pid_t tid;
+	bool is_write;
+/* private: */
+	unsigned long report_jiffies;	/* when this report is made */
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
@@ -763,6 +788,49 @@ struct damon_attrs {
 	unsigned long aggr_samples;
 };
 
+/**
+ * enum damon_sample_filter_type - Type of &struct damon_sample_filter.
+ *
+ * @DAMON_FILTER_TYPE_CPUMASK:	Filter by access-generated CPUs.
+ * @DAMON_FILTER_TYPE_THREADS:	Filter by access-generated threads.
+ * @DAMON_FILTER_TYPE_WRITE:	Filter by whether the access was for writing.
+ *
+ * Read &struct damon_sample_control for more details.
+ */
+enum damon_sample_filter_type {
+	DAMON_FILTER_TYPE_CPUMASK,
+	DAMON_FILTER_TYPE_THREADS,
+	DAMON_FILTER_TYPE_WRITE,
+};
+
+/**
+ * struct damon_sample_filter - &struct damon_access_report filter.
+ *
+ * @type:	The type of this filter.
+ * @matching:	Whether it is for condition-matching reports.
+ * @allow:	Whether to include or excludie the @matching reports.
+ * @cpumask:	Access-generated CPUs if @type is DAMON_FILTER_TYPE_CPUMASK.
+ * @tid_arr:	Array of access-generated thread ids, if @type is
+ *		DAMON_FILTER_TYPE_THREADS.
+ * @nr_tids:	Size of @tid_arr, if @type is DAMON_FILTER_TYPE_THREADS.
+ * @list:	List head for siblings.
+ *
+ * Read &struct damon_sample_control for more details.
+ */
+struct damon_sample_filter {
+	enum damon_sample_filter_type type;
+	bool matching;
+	bool allow;
+	union {
+		cpumask_t cpumask;
+		struct {
+			pid_t *tid_arr;
+			int nr_tids;
+		};
+	};
+	struct list_head list;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff71..a52b2962aa22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -142,6 +142,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 
 	region->age = 0;
 	region->last_nr_accesses = 0;
+	region->access_reported = false;
 
 	return region;
 }
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index eefa959aa30a..c19556f2af3b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -747,6 +747,483 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * access check report filter directory
+ */
+
+struct damon_sysfs_sample_filter {
+	struct kobject kobj;
+	enum damon_sample_filter_type type;
+	bool matching;
+	bool allow;
+	cpumask_t cpumask;
+};
+
+static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_sample_filter), GFP_KERNEL);
+}
+
+struct damon_sysfs_sample_filter_type_name {
+	enum damon_sample_filter_type type;
+	char *name;
+};
+
+static const struct damon_sysfs_sample_filter_type_name
+damon_sysfs_sample_filter_type_names[] = {
+	{
+		.type = DAMON_FILTER_TYPE_CPUMASK,
+		.name = "cpumask",
+	},
+};
+
+static ssize_t type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(damon_sysfs_sample_filter_type_names); i++) {
+		const struct damon_sysfs_sample_filter_type_name *type_name;
+
+		type_name = &damon_sysfs_sample_filter_type_names[i];
+		if (type_name->type == filter->type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	ssize_t ret = -EINVAL;
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(damon_sysfs_sample_filter_type_names); i++) {
+		const struct damon_sysfs_sample_filter_type_name *type_name;
+
+		type_name = &damon_sysfs_sample_filter_type_names[i];
+		if (sysfs_streq(buf, type_name->name)) {
+			filter->type = type_name->type;
+			ret = count;
+			break;
+		}
+	}
+	return ret;
+}
+
+static ssize_t matching_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->matching ? 'Y' : 'N');
+}
+
+static ssize_t matching_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	bool matching;
+	int err = kstrtobool(buf, &matching);
+
+	if (err)
+		return err;
+
+	filter->matching = matching;
+	return count;
+}
+
+static ssize_t allow_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->allow ? 'Y' : 'N');
+}
+
+static ssize_t allow_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	bool allow;
+	int err = kstrtobool(buf, &allow);
+
+	if (err)
+		return err;
+
+	filter->allow = allow;
+	return count;
+}
+
+static ssize_t cpumask_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&filter->cpumask));
+}
+
+static ssize_t cpumask_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	cpumask_t cpumask;
+	int err = cpulist_parse(buf, &cpumask);
+
+	if (err)
+		return err;
+	filter->cpumask = cpumask;
+	return count;
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
+static struct kobj_attribute damon_sysfs_sample_filter_type_attr =
+		__ATTR_RW_MODE(type, 0600);
+
+static struct kobj_attribute damon_sysfs_sample_filter_matching_attr =
+		__ATTR_RW_MODE(matching, 0600);
+
+static struct kobj_attribute damon_sysfs_sample_filter_allow_attr =
+		__ATTR_RW_MODE(allow, 0600);
+
+static struct kobj_attribute damon_sysfs_sample_filter_cpumask_attr =
+		__ATTR_RW_MODE(cpumask, 0600);
+
+static struct attribute *damon_sysfs_sample_filter_attrs[] = {
+	&damon_sysfs_sample_filter_type_attr.attr,
+	&damon_sysfs_sample_filter_matching_attr.attr,
+	&damon_sysfs_sample_filter_allow_attr.attr,
+	&damon_sysfs_sample_filter_cpumask_attr.attr,
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
+/*
+ * access check report filters directory
+ */
+
+struct damon_sysfs_sample_filters {
+	struct kobject kobj;
+	struct damon_sysfs_sample_filter **filters_arr;
+	int nr;
+};
+
+static struct damon_sysfs_sample_filters *
+damon_sysfs_sample_filters_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_sample_filters), GFP_KERNEL);
+}
+
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
+static void damon_sysfs_sample_filters_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_sample_filters, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_sample_filters_nr_attr =
+		__ATTR_RW_MODE(nr_filters, 0600);
+
+static struct attribute *damon_sysfs_sample_filters_attrs[] = {
+	&damon_sysfs_sample_filters_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_sample_filters);
+
+static const struct kobj_type damon_sysfs_sample_filters_ktype = {
+	.release = damon_sysfs_sample_filters_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_sample_filters_groups,
+};
+
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
+/*
+ * sample directory
+ */
+
+struct damon_sysfs_sample {
+	struct kobject kobj;
+	struct damon_sysfs_primitives *primitives;
+	struct damon_sysfs_sample_filters *filters;
+};
+
+static struct damon_sysfs_sample *damon_sysfs_sample_alloc(void)
+{
+	struct damon_sysfs_sample *sample = kmalloc(
+			sizeof(*sample), GFP_KERNEL);
+
+	if (!sample)
+		return NULL;
+	sample->kobj = (struct kobject){};
+	return sample;
+}
+
+static int damon_sysfs_sample_add_dirs(
+		struct damon_sysfs_sample *sample)
+{
+	struct damon_sysfs_primitives *primitives;
+	struct damon_sysfs_sample_filters *filters;
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
+	filters = damon_sysfs_sample_filters_alloc();
+	if (!filters) {
+		err = -ENOMEM;
+		goto put_primitives_out;
+	}
+	err = kobject_init_and_add(&filters->kobj,
+			&damon_sysfs_sample_filters_ktype, &sample->kobj,
+			"filters");
+	if (err)
+		goto put_filters_out;
+	sample->filters = filters;
+	return 0;
+put_filters_out:
+	kobject_put(&filters->kobj);
+	sample->filters = NULL;
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
+	if (sample->filters) {
+		damon_sysfs_sample_filters_rm_dirs(sample->filters);
+		kobject_put(&sample->filters->kobj);
+	}
+}
+
+static void damon_sysfs_sample_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_sample, kobj));
+}
+
+static struct attribute *damon_sysfs_sample_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_sample);
+
+static const struct kobj_type damon_sysfs_sample_ktype = {
+	.release = damon_sysfs_sample_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_sample_groups,
+};
+
 /*
  * monitoring_attrs directory
  */
@@ -755,6 +1232,7 @@ struct damon_sysfs_attrs {
 	struct kobject kobj;
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	struct damon_sysfs_sample *sample;
 };
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
@@ -771,6 +1249,7 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 {
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	struct damon_sysfs_sample *sample;
 	int err;
 
 	intervals = damon_sysfs_intervals_alloc(5000, 100000, 60000000);
@@ -799,8 +1278,26 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	if (err)
 		goto put_nr_regions_intervals_out;
 	attrs->nr_regions_range = nr_regions_range;
+
+	sample = damon_sysfs_sample_alloc();
+	if (!sample) {
+		err = -ENOMEM;
+		goto put_nr_regions_intervals_out;
+	}
+	err = kobject_init_and_add(&sample->kobj,
+			&damon_sysfs_sample_ktype, &attrs->kobj,
+			"sample");
+	if (err)
+		goto put_sample_out;
+	err = damon_sysfs_sample_add_dirs(sample);
+	if (err)
+		goto put_sample_out;
+	attrs->sample = sample;
 	return 0;
 
+put_sample_out:
+	kobject_put(&sample->kobj);
+	attrs->sample = NULL;
 put_nr_regions_intervals_out:
 	kobject_put(&nr_regions_range->kobj);
 	attrs->nr_regions_range = NULL;
@@ -817,6 +1314,8 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->nr_regions_range->kobj);
 	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
+	damon_sysfs_sample_rm_dirs(attrs->sample);
+	kobject_put(&attrs->sample->kobj);
 }
 
 static void damon_sysfs_attrs_release(struct kobject *kobj)
-- 
2.43.0

