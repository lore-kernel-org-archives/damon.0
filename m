Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84F126C17
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018039; cv=none; b=DJJ9sfFKxeI/PVMOT4bCFZ6duNFZbF4bbfYW1wrc/AF9l2cJ/dzdLxtZ78y6e5syobeBpUOTkXH6KwHAIVh8vBOm/+FD1VxkiDSzyZ5BpzpqbSdEB4z7MDTxAqP0qplcO9gIG1Ukaq0sEEBWTNruElV5cfF7avvQZwevrE4055w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018039; c=relaxed/simple;
	bh=tmZgeMFVXZcXxhUmwNAIRZhXuc/EUv5z6HTJt1GeE0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6WwcdhRGF3cEFQ/SCNAhU0oum8B0/DNPoUB6yNFXIKSi4EWjXwLR2FArPZT39bYewKbBcm0QoPt5sFjJQ0je62iXZJU4S43XCuIEsgcxazqYanVuWm7me+HfSo3FtUXub3cVPUIfY32sNRz1QMcH+9KEgQjPGCzrylHnQjumRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad3Q6clF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad3Q6clF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829865a8471so3839125b3a.3
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018036; x=1773622836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahibmsSkG/0ElmTnVIZocBJIBiGGJCCqKoqnmIcOmvE=;
        b=Ad3Q6clFq5+I25eqrL5QhQhJnMlsNfnxPiF5KpH3pXx4tHmfzRst43qnlr7RshMII0
         0mtSALx4+6hnPn6lsCLEQyoIJ98+f21hkazS26HnJJzjuTSCrdD4P0W76/PTcJ522Dya
         3Id1XFim4HEXYr29HWEiPSCjNnSyPlwjVgsXUJ1zTgMgCwZqCkPollT7yJLr5elFt53V
         JeD9bfAmDshqQIyNaIAQU5c0UxT55Kyo8ASbYkLXDmmGwp9zv2wEWZ+vxF4l3wLLMv+m
         isPNjWlxGnXuv3n4s2q+862q4D38nKQZmxfQrgnRgNlW0MjMfHe1G2ZUrvaRq2fyUL9Z
         WqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018036; x=1773622836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahibmsSkG/0ElmTnVIZocBJIBiGGJCCqKoqnmIcOmvE=;
        b=lf5wwCNcUkx3RuBOcy51Sm5Bzl/GrssqItNA404v2d6f09tJ8NSI8QuksA3Q37eqRS
         copZf6ZJVMWUPzUYotzKcmVExfM2fI2ozZd1Tf51ltNDUoYrucQW6Qtg5dzSGqxVDTtp
         hQlHET0NpK9E7SmzeHzvciBS0B28j+o8e+gRPt1koxulULzHw7XBkW831V77uljRqTwl
         LzXErPo7dxHY4rrRu5nLWWKpANnx+xSdEO2TulpCFwsr+z4dS4TbK1id3AXcqcZqE9qH
         frLybDA9Mzks/TlwWEnB2iR4FFz+dfOIWgJerzbyeNQa7vNf7+ClamgiYUmlss6qYQKB
         ktjQ==
X-Gm-Message-State: AOJu0YwoLJvVmuCWzVadMB0S5Er52axe4xEdpbK63CJcDRutoXFywYaZ
	233MWQ+exp/8nbo9kb3RQTCWI6JpHsXWF1qCLAMbWQu4xVhqAMfOLdoNIDdRMA==
X-Gm-Gg: ATEYQzzz/ngQIWk/sRNwKF3LhC7i/SAwOSM0OsmHeBi/4BOC9h4EA6htZ6bpmV3UdMK
	duIF7SBzeua3keCJ1tjPEAK+UlG5zcZ2y9LBL2qNHPoLjsgJwvx2zj7IXJZRfYVPKQ0iRTtYeKu
	2oVidNKQveNeUrdduNp9xQrvTDOKjh168btn0gPs2Yt2+JA38QO8U3AMaNa7+5oDQuT3s1UofS8
	Zer+AwlHwx0P/I4RZt4oeCXtSk358xkXLkT/w/vJHK0QPnXsQN8cxvGHUm92C4hBuNGc16efxYl
	Q0EGa0LGdPa9YzwJuFqrp0ML+VlZAMJXprsWB067+iV4Higxwii/dFpWWI4hB0OeG5w0rhE+/IQ
	ssbpxNR2szz/TOjUpjNx310L2OGEup7ziWao7q91MwsI/eZXtP0HMsNtRXXRNjes4aIPRX2Ry/S
	BeskbmHikGQDOnBC2JYL/ESBNjMJtLi11hDKnybA==
X-Received: by 2002:a05:6a00:7586:b0:827:2a07:231d with SMTP id d2e1a72fcca58-829a2dbaa39mr6983080b3a.17.1773018036180;
        Sun, 08 Mar 2026 18:00:36 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:35 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 3/6] mm/damon/core: add common code for perf event based access check
Date: Mon,  9 Mar 2026 10:00:06 +0900
Message-ID: <20260309010009.11639-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch creates the necessary infrastructure (structure definitions,
functions, sysfs interfaces) to support perf event based access checks
for both physical and virtual address space monitoring.

Perf events can be added through the following sysfs interface:

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/nr_perf_events
Description: Writing a number 'N' to this file creates the number of
directories for controlling each perf event named '0' to 'N-1' under the
perf_events/ directory.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/type
Description: Writing to and reading from this file sets and gets the
"type" field of struct perf_event_attr for perf event based access
check.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config1
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config2
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/sample_freq
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/sample_phys_addr
Description: Writing to and reading from this file sets and gets the
PERF_SAMPLE_PHYS_ADDR bitfield in the "sample_type" field of struct
perf_event_attr for perf event based access check.

The perf event that can be specified for the perf event based access
check must be able to obtain the data source address corresponding to
the sample.

One way to find such perf event settings is to run `perf mem record -vv`
and look for a dump of the perf_event_attr structure given to the
perf_event_open() system call in the debug messages output.

If at least one perf event is specified, the perf event based access
check will be enabled instead of the existing PTE accessed-bit based
access check.  In other words, if no perf event is specified, the
existing PTE accessed-bit based access check will be used.

Add the following common functions required for both physical and
virtual address space monitoring:

damon_ops_init()
This is the function to call in the damon_operations->init callback.
Each perf event specified by the sysfs interface is initialized with
perf_event_create_kernel_counter().

damon_ops_cleanup()
This is the function to call in the damon_operations->cleanup callback.
Release each initialized perf event with perf_event_release_kernel().

damon_perf_prepare_access_checks()
This is the function used to implement the
damon_operations->prepare_access_checks callback.  Enable each
initialized perf event with perf_event_enable().
---
 .../ABI/testing/sysfs-kernel-mm-damon         |   8 +
 include/linux/damon.h                         |  34 ++
 mm/damon/core.c                               |  52 +++
 mm/damon/ops-common.h                         |  21 +
 mm/damon/paddr.c                              |   4 +-
 mm/damon/sysfs.c                              | 373 +++++++++++++++++-
 mm/damon/vaddr.c                              | 208 +++++++++-
 7 files changed, 692 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f2af2ddedd32..405a1a7f1eb6 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -570,3 +570,11 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the size of the memory in the region
 		that passed DAMON operations layer-handled filters of the
 		scheme in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/nr_perf_events
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/type
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config1
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config2
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/sample_phys_addr
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/sample_freq
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5f2870ae02ba..c1cf3b5b990b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -54,6 +54,7 @@ struct damon_size_range {
  *			each sampling interval.
  * @list:		List head for siblings.
  * @age:		Age of this region.
+ * @accessed:		Whether the region has accessed during last sampling interval.
  *
  * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
  * increased for every &damon_attrs->sample_interval if an access to the region
@@ -83,6 +84,7 @@ struct damon_region {
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	bool accessed;
 };
 
 /**
@@ -777,6 +779,36 @@ struct damon_attrs {
 	unsigned long aggr_samples;
 };
 
+/**
+ * struct damon_perf_event_attr - raw PMU event attr for access check
+ *
+ * @type:		raw PMU event type for access check
+ * @config:		raw PMU event config for access check
+ * @config1:		raw PMU event config1 for access check
+ * @config2:		raw PMU event config2 for access check
+ * @sample_phys_addr:	raw PMU event PERF_SAMPLE_PHYS_ADDR in sample_type for access check
+ * @sample_freq:	raw PMU event sample_freq for access check
+ */
+struct damon_perf_event_attr {
+	u32 type;
+	u64 config;
+	u64 config1;
+	u64 config2;
+	bool sample_phys_addr;
+	u64 sample_freq;
+};
+
+/**
+ * struct damon_perf_event - perf event for access check
+ *
+ * @priv:		Monitoring operations-specific data
+ */
+struct damon_perf_event {
+	struct damon_perf_event_attr attr;
+	void *priv;
+	struct list_head list;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
@@ -801,6 +833,7 @@ struct damon_attrs {
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
+ * @perf_events:	Head of perf events (&damon_perf_event) list.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -847,6 +880,7 @@ struct damon_ctx {
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
 
+	struct list_head perf_events;
 	struct list_head adaptive_targets;
 	struct list_head schemes;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d0d9659658bd..f8e4db2e80d6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -555,6 +555,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->addr_unit = 1;
 	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
+	INIT_LIST_HEAD(&ctx->perf_events);
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
@@ -578,6 +579,18 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme_safe(s, next_s, ctx)
 		damon_destroy_scheme(s);
 
+	if (ctx->ops.cleanup)
+		ctx->ops.cleanup(ctx);
+
+	while (!list_empty(&ctx->perf_events)) {
+		struct damon_perf_event *event =
+			list_first_entry(&ctx->perf_events, typeof(*event), list);
+
+		WARN_ON(event->priv);
+		list_del(&event->list);
+		kfree(event);
+	}
+
 	kfree(ctx);
 }
 
@@ -1235,6 +1248,42 @@ static int damon_commit_targets(
 	return 0;
 }
 
+static int damon_commit_perf_events(struct damon_ctx *dst, struct damon_ctx *src)
+{
+	struct damon_perf_event *dst_event, *src_event, *new_event;
+
+	if (dst->ops.cleanup)
+		dst->ops.cleanup(dst);
+
+	while (!list_empty(&dst->perf_events)) {
+		dst_event = list_first_entry(&dst->perf_events, typeof(*dst_event), list);
+
+		WARN_ON(dst_event->priv);
+		list_del(&dst_event->list);
+		kfree(dst_event);
+	}
+
+	list_for_each_entry(src_event, &src->perf_events, list) {
+		new_event = kzalloc(sizeof(*new_event), GFP_KERNEL);
+		if (!new_event)
+			return -ENOMEM;
+
+		new_event->attr.type = src_event->attr.type;
+		new_event->attr.config = src_event->attr.config;
+		new_event->attr.config1 = src_event->attr.config1;
+		new_event->attr.config2 = src_event->attr.config2;
+		new_event->attr.sample_phys_addr = src_event->attr.sample_phys_addr;
+		new_event->attr.sample_freq = src_event->attr.sample_freq;
+
+		list_add_tail(&new_event->list, &dst->perf_events);
+	}
+
+	if (src->ops.init)
+		src->ops.init(dst);
+
+	return 0;
+}
+
 /**
  * damon_commit_ctx() - Commit parameters of a DAMON context to another.
  * @dst:	The commit destination DAMON context.
@@ -1259,6 +1308,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	if (err)
 		return err;
 	err = damon_commit_targets(dst, src);
+	if (err)
+		return err;
+	err = damon_commit_perf_events(dst, src);
 	if (err)
 		return err;
 	/*
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 5efa5b5970de..395af11b91fb 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -23,3 +23,24 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
 
 bool damos_ops_has_filter(struct damos *s);
+
+#ifdef CONFIG_PERF_EVENTS
+
+void damon_perf_prepare_access_checks(struct damon_ctx *ctx, struct damon_perf_event *event);
+
+struct damon_perf {
+	struct perf_event * __percpu *event;
+	struct damon_perf_buffer __percpu *buffer;
+};
+
+#else /* CONFIG_PERF_EVENTS */
+
+static inline void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+}
+
+#endif /* CONFIG_PERF_EVENTS */
+
+void damon_ops_init(struct damon_ctx *ctx);
+void damon_ops_cleanup(struct damon_ctx *ctx);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4c2c935d82d6..68dcde5d423f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -368,12 +368,12 @@ static int __init damon_pa_initcall(void)
 {
 	struct damon_operations ops = {
 		.id = DAMON_OPS_PADDR,
-		.init = NULL,
+		.init = damon_ops_init,
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
 		.target_valid = NULL,
-		.cleanup = NULL,
+		.cleanup = damon_ops_cleanup,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
 	};
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 576d1ddd736b..040b669d0f49 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -747,6 +747,309 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * perf_event_attr directory
+ */
+
+struct damon_sysfs_perf_event_attr {
+	struct kobject kobj;
+	u32 type;
+	u64 config;
+	u64 config1;
+	u64 config2;
+	bool sample_phys_addr;
+	u64 sample_freq;
+};
+
+static struct damon_sysfs_perf_event_attr *damon_sysfs_perf_event_attr_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_perf_event_attr), GFP_KERNEL);
+}
+
+static ssize_t type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%x\n", perf_event_attr->type);
+}
+
+static ssize_t type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou32(buf, 0, &perf_event_attr->type);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t config_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%llx\n", perf_event_attr->config);
+}
+
+static ssize_t config_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->config);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t config1_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%llx\n", perf_event_attr->config1);
+}
+
+static ssize_t config1_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->config1);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t config2_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%llx\n", perf_event_attr->config2);
+}
+
+static ssize_t config2_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->config2);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t sample_phys_addr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%d\n", perf_event_attr->sample_phys_addr);
+}
+
+static ssize_t sample_phys_addr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	bool sample_phys_addr;
+	int err = kstrtobool(buf, &sample_phys_addr);
+
+	if (err)
+		return -EINVAL;
+
+	perf_event_attr->sample_phys_addr = sample_phys_addr;
+	return count;
+}
+
+static ssize_t sample_freq_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%llu\n", perf_event_attr->sample_freq);
+}
+
+static ssize_t sample_freq_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->sample_freq);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_perf_event_attr_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_perf_event_attr, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_type_attr =
+		__ATTR_RW_MODE(type, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_config_attr =
+		__ATTR_RW_MODE(config, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_config1_attr =
+		__ATTR_RW_MODE(config1, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_config2_attr =
+		__ATTR_RW_MODE(config2, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_sample_phys_addr_attr =
+		__ATTR_RW_MODE(sample_phys_addr, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_sample_freq_attr =
+		__ATTR_RW_MODE(sample_freq, 0600);
+
+static struct attribute *damon_sysfs_perf_event_attr_attrs[] = {
+	&damon_sysfs_perf_event_attr_type_attr.attr,
+	&damon_sysfs_perf_event_attr_config_attr.attr,
+	&damon_sysfs_perf_event_attr_config1_attr.attr,
+	&damon_sysfs_perf_event_attr_config2_attr.attr,
+	&damon_sysfs_perf_event_attr_sample_phys_addr_attr.attr,
+	&damon_sysfs_perf_event_attr_sample_freq_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_perf_event_attr);
+
+static const struct kobj_type damon_sysfs_perf_event_attr_ktype = {
+	.release = damon_sysfs_perf_event_attr_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_perf_event_attr_groups,
+};
+
+/*
+ * perf_events directory
+ */
+
+struct damon_sysfs_perf_events {
+	struct kobject kobj;
+	struct damon_sysfs_perf_event_attr **attrs_arr;
+	int nr;
+};
+
+static struct damon_sysfs_perf_events *damon_sysfs_perf_events_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_perf_events), GFP_KERNEL);
+}
+
+static void damon_sysfs_perf_events_rm_dirs(struct damon_sysfs_perf_events *events)
+{
+	struct damon_sysfs_perf_event_attr **attrs_arr = events->attrs_arr;
+	int i;
+
+	for (i = 0; i < events->nr; i++)
+		kobject_put(&attrs_arr[i]->kobj);
+	events->nr = 0;
+	kfree(attrs_arr);
+	events->attrs_arr = NULL;
+}
+
+static int damon_sysfs_perf_events_add_dirs(struct damon_sysfs_perf_events *events,
+		int nr_events)
+{
+	struct damon_sysfs_perf_event_attr **attrs_arr, *attr;
+	int err, i;
+
+	damon_sysfs_perf_events_rm_dirs(events);
+	if (!nr_events)
+		return 0;
+
+	attrs_arr = kmalloc_array(nr_events, sizeof(*attrs_arr), GFP_KERNEL);
+	if (!attrs_arr)
+		return -ENOMEM;
+	events->attrs_arr = attrs_arr;
+
+	for (i = 0; i < nr_events; i++) {
+		attr = damon_sysfs_perf_event_attr_alloc();
+		if (!attr) {
+			damon_sysfs_perf_events_rm_dirs(events);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&attr->kobj,
+				&damon_sysfs_perf_event_attr_ktype, &events->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&attr->kobj);
+			damon_sysfs_perf_events_rm_dirs(events);
+			return err;
+		}
+		attrs_arr[i] = attr;
+		events->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_perf_events_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_events *events = container_of(kobj,
+			struct damon_sysfs_perf_events, kobj);
+
+	return sysfs_emit(buf, "%d\n", events->nr);
+}
+
+static ssize_t nr_perf_events_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_events *events;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	events = container_of(kobj, struct damon_sysfs_perf_events, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_perf_events_add_dirs(events, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_perf_events_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_perf_events, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_perf_events_nr_attr =
+		__ATTR_RW_MODE(nr_perf_events, 0600);
+
+static struct attribute *damon_sysfs_perf_events_attrs[] = {
+	&damon_sysfs_perf_events_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_perf_events);
+
+static const struct kobj_type damon_sysfs_perf_events_ktype = {
+	.release = damon_sysfs_perf_events_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_perf_events_groups,
+};
+
 /*
  * monitoring_attrs directory
  */
@@ -864,6 +1167,7 @@ struct damon_sysfs_context {
 	enum damon_ops_id ops_id;
 	unsigned long addr_unit;
 	struct damon_sysfs_attrs *attrs;
+	struct damon_sysfs_perf_events *perf_events;
 	struct damon_sysfs_targets *targets;
 	struct damon_sysfs_schemes *schemes;
 };
@@ -903,6 +1207,23 @@ static int damon_sysfs_context_set_attrs(struct damon_sysfs_context *context)
 	return err;
 }
 
+static int damon_sysfs_context_set_perf_events(struct damon_sysfs_context *context)
+{
+	struct damon_sysfs_perf_events *events = damon_sysfs_perf_events_alloc();
+	int err;
+
+	if (!events)
+		return -ENOMEM;
+	err = kobject_init_and_add(&events->kobj, &damon_sysfs_perf_events_ktype,
+			&context->kobj, "perf_events");
+	if (err) {
+		kobject_put(&events->kobj);
+		return err;
+	}
+	context->perf_events = events;
+	return 0;
+}
+
 static int damon_sysfs_context_set_targets(struct damon_sysfs_context *context)
 {
 	struct damon_sysfs_targets *targets = damon_sysfs_targets_alloc();
@@ -945,18 +1266,25 @@ static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
 	if (err)
 		return err;
 
-	err = damon_sysfs_context_set_targets(context);
+	err = damon_sysfs_context_set_perf_events(context);
 	if (err)
 		goto rmdir_put_attrs_out;
 
+	err = damon_sysfs_context_set_targets(context);
+	if (err)
+		goto put_perf_events_out;
+
 	err = damon_sysfs_context_set_schemes(context);
 	if (err)
-		goto put_targets_attrs_out;
+		goto put_targets_out;
 	return 0;
 
-put_targets_attrs_out:
+put_targets_out:
 	kobject_put(&context->targets->kobj);
 	context->targets = NULL;
+put_perf_events_out:
+	kobject_put(&context->perf_events->kobj);
+	context->perf_events = NULL;
 rmdir_put_attrs_out:
 	damon_sysfs_attrs_rm_dirs(context->attrs);
 	kobject_put(&context->attrs->kobj);
@@ -970,6 +1298,8 @@ static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
 	kobject_put(&context->attrs->kobj);
 	damon_sysfs_targets_rm_dirs(context->targets);
 	kobject_put(&context->targets->kobj);
+	damon_sysfs_perf_events_rm_dirs(context->perf_events);
+	kobject_put(&context->perf_events->kobj);
 	damon_sysfs_schemes_rm_dirs(context->schemes);
 	kobject_put(&context->schemes->kobj);
 }
@@ -1430,6 +1760,40 @@ static int damon_sysfs_add_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static int damon_sysfs_add_perf_event(struct damon_sysfs_perf_event_attr *sys_attr,
+		struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event = kzalloc(sizeof(*event), GFP_KERNEL);
+
+	if (!event)
+		return -ENOMEM;
+
+	event->attr.type = sys_attr->type;
+	event->attr.config = sys_attr->config;
+	event->attr.config1 = sys_attr->config1;
+	event->attr.config2 = sys_attr->config2;
+	event->attr.sample_phys_addr = sys_attr->sample_phys_addr;
+	event->attr.sample_freq = sys_attr->sample_freq;
+
+	list_add_tail(&event->list, &ctx->perf_events);
+	return 0;
+}
+
+static int damon_sysfs_add_perf_events(struct damon_ctx *ctx,
+		struct damon_sysfs_perf_events *sysfs_perf_events)
+{
+	int i, err;
+
+	for (i = 0; i < sysfs_perf_events->nr; i++) {
+		struct damon_sysfs_perf_event_attr *attr = sysfs_perf_events->attrs_arr[i];
+
+		err = damon_sysfs_add_perf_event(attr, ctx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
  * @data:	The kobject wrapper that associated to the kdamond thread.
@@ -1471,6 +1835,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		return err;
+	err = damon_sysfs_add_perf_events(ctx, sys_ctx->perf_events);
 	if (err)
 		return err;
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 8a58aa912112..4eb81cc1e8cd 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -15,6 +15,9 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 
+#include <linux/circ_buf.h>
+#include <linux/perf_event.h>
+
 #include "../internal.h"
 #include "ops-common.h"
 
@@ -277,7 +280,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 }
 
 /* Initialize '->regions_list' of every target (task) */
-static void damon_va_init(struct damon_ctx *ctx)
+static void damon_va_init_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 
@@ -1003,6 +1006,206 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+
+struct damon_perf_buffer {
+	struct damon_access_report *reports;
+	unsigned long head;
+	unsigned long tail;
+	unsigned long size;
+};
+
+static void damon_perf_overflow(struct perf_event *perf_event, struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	struct damon_perf_event *event = perf_event->overflow_handler_context;
+	struct damon_perf *perf = event->priv;
+	struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, smp_processor_id());
+	unsigned long head = buffer->head;
+	unsigned long tail = READ_ONCE(buffer->tail);
+
+	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
+		struct damon_access_report *report = &buffer->reports[head];
+
+		report->tid = task_pid_nr(current);
+		report->vaddr = data->addr;
+		report->paddr = data->phys_addr;
+
+		smp_store_release(&buffer->head, (head + 1) & (buffer->size - 1));
+	}
+}
+
+#define DAMON_PERF_MAX_RECORDS (1UL << 20)
+#define DAMON_PERF_INIT_RECORDS (1UL << 15)
+
+static int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	struct damon_perf *perf;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_RAW,
+		.size = sizeof(attr),
+		.type = event->attr.type,
+		.config = event->attr.config,
+		.config1 = event->attr.config1,
+		.config2 = event->attr.config2,
+		.sample_freq = event->attr.sample_freq,
+		.freq = 1,
+		.sample_type = PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |
+			PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC |
+			(event->attr.sample_phys_addr ? PERF_SAMPLE_PHYS_ADDR : 0) |
+			PERF_SAMPLE_WEIGHT_STRUCT,
+		.precise_ip = 3,
+		.pinned = 1,
+		.disabled = 1,
+	};
+	int cpu;
+	int err = -ENOMEM;
+	bool found = false;
+
+	perf = kzalloc(sizeof(*perf), GFP_KERNEL);
+	if (!perf)
+		return -ENOMEM;
+
+	perf->event = alloc_percpu(typeof(*perf->event));
+	if (!perf->event)
+		goto free_percpu;
+
+	perf->buffer = alloc_percpu(typeof(*perf->buffer));
+	if (!perf->buffer)
+		goto free_percpu;
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event;
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+
+		perf_event = perf_event_create_kernel_counter(&attr, cpu, NULL,
+				damon_perf_overflow, event);
+		if (IS_ERR(perf_event)) {
+			err = PTR_ERR(perf_event);
+			if (err == -ENODEV)
+				continue;
+			pr_err("perf event create on CPU %d failed with %d\n", cpu, err);
+			goto free_for_each_cpu;
+		}
+		found = true;
+		*per_cpu_ptr(perf->event, cpu) = perf_event;
+
+		buffer->size = DAMON_PERF_INIT_RECORDS;
+		buffer->reports = kvcalloc_node(buffer->size, sizeof(buffer->reports[0]),
+						GFP_KERNEL, cpu_to_node(cpu));
+		if (!buffer->reports)
+			goto free_for_each_cpu;
+	}
+	event->priv = perf;
+
+	return found ? 0 : -ENODEV;
+
+free_for_each_cpu:
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+
+		if (perf_event)
+			perf_event_release_kernel(perf_event);
+		kvfree(buffer->reports);
+	}
+free_percpu:
+	free_percpu(perf->event);
+	free_percpu(perf->buffer);
+	kfree(perf);
+
+	return err;
+}
+
+static void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	int cpu;
+
+	if (!perf)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+
+		if (!perf_event)
+			continue;
+		perf_event_disable(perf_event);
+		perf_event_release_kernel(perf_event);
+		kvfree(buffer->reports);
+	}
+	free_percpu(perf->event);
+	free_percpu(perf->buffer);
+	kfree(perf);
+	event->priv = NULL;
+}
+
+void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	int cpu;
+
+	if (!perf)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+
+		if (perf_event)
+			perf_event_enable(perf_event);
+	}
+}
+
+#else
+
+static inline int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	return 0;
+}
+
+static inline void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+}
+
+static void damon_va_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+}
+
+#endif /* CONFIG_PERF_EVENTS */
+
+void damon_ops_init(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event, *next;
+	int err = 0;
+
+	list_for_each_entry_safe(event, next, &ctx->perf_events, list) {
+		err = damon_perf_init(ctx, event);
+		if (err) {
+			list_del(&event->list);
+			kfree(event);
+		}
+	}
+}
+
+static void damon_va_init(struct damon_ctx *ctx)
+{
+	damon_ops_init(ctx);
+
+	if (ctx->ops.id == DAMON_OPS_VADDR)
+		damon_va_init_regions(ctx);
+}
+
+void damon_ops_cleanup(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event;
+
+	list_for_each_entry(event, &ctx->perf_events, list) {
+		damon_perf_cleanup(ctx, event);
+	}
+}
+
 static int __init damon_va_initcall(void)
 {
 	struct damon_operations ops = {
@@ -1013,7 +1216,7 @@ static int __init damon_va_initcall(void)
 		.check_accesses = damon_va_check_accesses,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
-		.cleanup = NULL,
+		.cleanup = damon_ops_cleanup,
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
 	};
@@ -1023,7 +1226,6 @@ static int __init damon_va_initcall(void)
 
 	/* Don't set the monitoring target regions for the entire mapping */
 	ops_fvaddr.id = DAMON_OPS_FVADDR;
-	ops_fvaddr.init = NULL;
 	ops_fvaddr.update = NULL;
 
 	err = damon_register_ops(&ops);
-- 
2.43.0

