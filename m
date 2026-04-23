Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FE21638D
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905003; cv=none; b=E7wcYh7rRCCNIye0oGBBI4FjfqymWbGXmbNJAisTyD4rw9vA+EBNqQxTlGeP5ynN7X9cHh5AnvYrhhPKFZEFzCpmtmh4jjB6PHNBn+yFRTbErFaa2Tw8nZ9s3Mu0jmN2kYv+bc66GAaGYw4XkUx+yj46WgdBgxoxeD7LkTDR1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905003; c=relaxed/simple;
	bh=kCu7zNq+y5kRTsli6n5wrRrlJJ6Q3Li4VX9WeSw1Z4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbdtfn1jn6oA90l1N5nTkg36hcbiPW2aFLc2YFqf7Vc/cIyroKhMQnuZAJdd673MLHszB+QPNB124JrOGbvcq8rfVJBz4/4yrfbTDV8uwNtRdMTDUav98Pbhi61FeiW7DxmedPS8iBS8oISa3Dzs8qwaSim/PHo7gWcHbPivujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggnKM2t3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggnKM2t3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae146b604so40489115ad.3
        for <damon@lists.linux.dev>; Wed, 22 Apr 2026 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776905000; x=1777509800; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOXe1rethwzY+08hEtSCjTzdTDB2rEKnvZJR0mvkp/E=;
        b=ggnKM2t3t8el4A6UKQ2U9jmIO/ELh5ZnUg4evpIiQRNQMghaR1R560kuca3I9Ac+x9
         qBxHUxkwluGunqNHolsLHS3+sfoNCMcHkGk0vE6/bY20Fn8cM2bgTG5mcE1SxuaxWDlR
         /0iPsekUQLR5URoY1LZRBukXtfy2JLSp8NLyEDb/Yq8ybRdbXoJRQZXo6+B2PJ16X/+a
         UjNy5t4m0SuLTgJcvChZhLf5+MsDmZZcz6Y2Z0Ph+ISycsOiIgL7uqeg92wmsfYc/bnu
         5ha+TXfwmSd+etjyfm9WDCvVjFoXfoCmhvNulOHtpR9AkHkZvjhfArCFiiZBypd+yXUI
         hxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776905000; x=1777509800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zOXe1rethwzY+08hEtSCjTzdTDB2rEKnvZJR0mvkp/E=;
        b=ZbSuCOQXh30hnOoYa7JuBufZ/lIvv3r8pvKm5fhr/YQ9IS2lsdZXCNnXlpsRawIFvw
         OZvS7evRXVrmUR/75AoJJG7rN1OxFCkt8U+O/f40fLYvhlfIjDDk0Zijk37d5mXP4tLq
         Lm9HCI47m4m+2mEXjydXlkw2MuoWoS4NTorsb2mKkSdSc0v+zDJwPKDs21pLy6Bae7VI
         FdYb3CxsDMHHVJ0EBrYGUEvqn6LLlBinzbHxojrsOFYyxaUYW4nRpavJiJacgz51KGvq
         umRgjLmn9AfaCJz3s3K95Z6iCHVTUmWFYvGNEoJuIF5SSu3T0P0gFU5piRkwGtiqhhi7
         AbRg==
X-Gm-Message-State: AOJu0YyjULw+yEDnsrCfCeMVent1dHq3rLTMZKkS/BvZuDOFMVN0D9TB
	3qqNTSqi8R+GdYzeBaLZdWl38oXPv2kKwPB1FBx4cTfxtwSaA6sGSALL5iTQSw==
X-Gm-Gg: AeBDiete7AAqAmIey95u0bkRWC2i+JnhSqKJTtyQlV3gmx+MK59mWee26s7h19APl68
	0hUYd+Mf0oWYovzphFpEG3H3LIn3KxbQox+QUC3qHDWP3VdbMtSWb3OKvva/kg+YrXKfeMhT+sL
	GyqWDjpOstHTBjlIBv/DprW8E9awjhaTbZ6EldqTY31CCZG+XCRejV7NhIECGwzc6JRe14qL604
	K76PzhxHppl6bhYTL6Jn6vUZBIV8Xy0kz6c9LQQEOUp23dJcP52WIU4zlUYWSssjkya4m1LXqmW
	jqZaSqa9stJZdtDYY7L0PFLCDa8QrZQZbEPYAG3FANOl/BemddJ7snbNjmTU4JVAqRqn2xZFs8G
	BgLNL1PiG8bF+sP2t0CJs5NB7ceXY4YDSfHiKy1c4nmCApHheRcsT1xE0Y38mVLx2a45yQi3HZW
	QeJqxirUsx7+Jbrud1y09tXEwOxz35RzTrLYGJWNcTfxnSERAt
X-Received: by 2002:a17:903:2984:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b5f9fd146amr257845035ad.37.1776905000056;
        Wed, 22 Apr 2026 17:43:20 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:963d:c5da:6762:8843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4bf7bsm176724085ad.81.2026.04.22.17.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:43:19 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v3 2/4] mm/damon/core: add common code for perf event based access check
Date: Thu, 23 Apr 2026 09:42:08 +0900
Message-ID: <20260423004211.7037-3-akinobu.mita@gmail.com>
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

This patch creates the necessary infrastructure (structure definitions,
functions, sysfs interfaces) to support perf event based access checks
for both physical and virtual address space monitoring.

Perf events can be added through the following sysfs interface:

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/nr_perf_events
Description: Writing a number 'N' to this file creates the number of
directories for controlling each perf event named '0' to 'N-1' under the
perf_events/ directory.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/type
Description: Writing to and reading from this file sets and gets the
"type" field of struct perf_event_attr for perf event based access
check.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/config
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/config1
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/config2
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/sample_freq
Description: Same as above.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/sample_phys_addr
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

damon_perf_init()
Each perf event specified by the sysfs interface is initialized with
perf_event_create_kernel_counter().

damon_perf_cleanup()
Release each initialized perf event with perf_event_release_kernel().

damon_perf_prepare_access_checks()
Enable each initialized perf event with perf_event_enable().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         |   8 +
 include/linux/damon.h                         |  34 ++
 mm/damon/core.c                               |  67 ++++
 mm/damon/ops-common.h                         |  29 ++
 mm/damon/sysfs.c                              | 377 +++++++++++++++++-
 mm/damon/vaddr.c                              | 158 ++++++++
 6 files changed, 669 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb10..aa69ce09789a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -576,3 +576,11 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the size of the memory in the region
 		that passed DAMON operations layer-handled filters of the
 		scheme in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/nr_perf_events
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/type
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/config
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/config1
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/config2
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/sample_phys_addr
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/sample/primitives/perf_events/<P>/sample_freq
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9ba26d8a0bce..2e7b5939f350 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -120,6 +120,7 @@ struct damon_target {
  * @size:		The size of the accessed address range.
  * @cpu:		The id of the CPU that made the access.
  * @tid:		The task id of the task that made the access.
+ * @tgid:		The task group id of the task that made the access.
  * @is_write:		Whether the access is write.
  *
  * Any DAMON API callers that notified access events can report the information
@@ -132,6 +133,7 @@ struct damon_access_report {
 	unsigned long size;
 	unsigned int cpu;
 	pid_t tid;
+	pid_t tgid;
 	bool is_write;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
@@ -831,6 +833,36 @@ struct damon_sample_filter {
 	struct list_head list;
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
@@ -855,6 +887,7 @@ struct damon_sample_filter {
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
+ * @perf_events:	Head of perf events (&damon_perf_event) list.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -909,6 +942,7 @@ struct damon_ctx {
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
 
+	struct list_head perf_events;
 	struct list_head adaptive_targets;
 	struct list_head schemes;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a52b2962aa22..220b105482da 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -20,6 +20,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
+#include "ops-common.h"
+
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 static bool running_exclusive_ctxs;
@@ -605,6 +607,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->addr_unit = 1;
 	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
+	INIT_LIST_HEAD(&ctx->perf_events);
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
@@ -619,6 +622,19 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 		damon_destroy_target(t, ctx);
 }
 
+static void damon_perf_destroy(struct damon_ctx *ctx)
+{
+	while (!list_empty(&ctx->perf_events)) {
+		struct damon_perf_event *event =
+			list_first_entry(&ctx->perf_events, typeof(*event), list);
+
+		damon_perf_cleanup(ctx, event);
+		list_del(&event->list);
+		kfree(event);
+	}
+
+}
+
 void damon_destroy_ctx(struct damon_ctx *ctx)
 {
 	struct damos *s, *next_s;
@@ -628,6 +644,8 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme_safe(s, next_s, ctx)
 		damon_destroy_scheme(s);
 
+	damon_perf_destroy(ctx);
+
 	kfree(ctx);
 }
 
@@ -1311,6 +1329,42 @@ static int damon_commit_targets(
 	return 0;
 }
 
+static int damon_commit_perf_events(struct damon_ctx *dst, struct damon_ctx *src)
+{
+	struct damon_perf_event *src_event, *new_event;
+	int err = 0;
+
+	damon_perf_destroy(dst);
+
+	list_for_each_entry(src_event, &src->perf_events, list) {
+		new_event = kzalloc_obj(*new_event);
+		if (!new_event) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		new_event->attr.type = src_event->attr.type;
+		new_event->attr.config = src_event->attr.config;
+		new_event->attr.config1 = src_event->attr.config1;
+		new_event->attr.config2 = src_event->attr.config2;
+		new_event->attr.sample_phys_addr = src_event->attr.sample_phys_addr;
+		new_event->attr.sample_freq = src_event->attr.sample_freq;
+
+		if (damon_is_running(dst)) {
+			err = damon_perf_init(dst, new_event);
+			if (err) {
+				kfree(new_event);
+				goto out;
+			}
+		}
+		list_add_tail(&new_event->list, &dst->perf_events);
+	}
+	return 0;
+out:
+	damon_perf_destroy(dst);
+	return err;
+}
+
 /**
  * damon_commit_ctx() - Commit parameters of a DAMON context to another.
  * @dst:	The commit destination DAMON context.
@@ -1336,6 +1390,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	if (err)
 		return err;
 	err = damon_commit_targets(dst, src);
+	if (err)
+		return err;
+	err = damon_commit_perf_events(dst, src);
 	if (err)
 		return err;
 	/*
@@ -2933,6 +2990,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
 		ctx->attrs.sample_interval : 1;
 	struct damos *scheme;
+	struct damon_perf_event *event, *next;
 
 	ctx->passed_sample_intervals = 0;
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
@@ -2945,6 +3003,15 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 		damos_set_next_apply_sis(scheme, ctx);
 		damos_set_filters_default_reject(scheme);
 	}
+
+	list_for_each_entry_safe(event, next, &ctx->perf_events, list) {
+		int err = damon_perf_init(ctx, event);
+
+		if (err) {
+			list_del(&event->list);
+			kfree(event);
+		}
+	}
 }
 
 /*
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 5efa5b5970de..e28c5afab7f0 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -23,3 +23,32 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
 
 bool damos_ops_has_filter(struct damos *s);
+
+#ifdef CONFIG_PERF_EVENTS
+
+void damon_perf_prepare_access_checks(struct damon_ctx *ctx, struct damon_perf_event *event);
+int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event);
+void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event);
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
+static inline int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	return 0;
+}
+
+static inline void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+}
+
+#endif /* CONFIG_PERF_EVENTS */
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c19556f2af3b..9a3b42d241d4 100644
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
+static ssize_t attr_type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%x\n", perf_event_attr->type);
+}
+
+static ssize_t attr_type_store(struct kobject *kobj,
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
+		__ATTR(type, 0600, attr_type_show, attr_type_store);
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
  * access check report filter directory
  */
@@ -1048,6 +1351,7 @@ struct damon_sysfs_primitives {
 	struct kobject kobj;
 	bool page_table;
 	bool page_fault;
+	struct damon_sysfs_perf_events *perf_events;
 };
 
 static struct damon_sysfs_primitives *damon_sysfs_primitives_alloc(
@@ -1159,6 +1463,24 @@ static struct damon_sysfs_sample *damon_sysfs_sample_alloc(void)
 	return sample;
 }
 
+static int damon_sysfs_context_set_perf_events(struct damon_sysfs_primitives
+		*primitives)
+{
+	struct damon_sysfs_perf_events *events = damon_sysfs_perf_events_alloc();
+	int err;
+
+	if (!events)
+		return -ENOMEM;
+	err = kobject_init_and_add(&events->kobj, &damon_sysfs_perf_events_ktype,
+			&primitives->kobj, "perf_events");
+	if (err) {
+		kobject_put(&events->kobj);
+		return err;
+	}
+	primitives->perf_events = events;
+	return 0;
+}
+
 static int damon_sysfs_sample_add_dirs(
 		struct damon_sysfs_sample *sample)
 {
@@ -1176,10 +1498,14 @@ static int damon_sysfs_sample_add_dirs(
 		goto put_primitives_out;
 	sample->primitives = primitives;
 
+	err = damon_sysfs_context_set_perf_events(primitives);
+	if (err)
+		goto put_primitives_out;
+
 	filters = damon_sysfs_sample_filters_alloc();
 	if (!filters) {
 		err = -ENOMEM;
-		goto put_primitives_out;
+		goto put_perf_events_out;
 	}
 	err = kobject_init_and_add(&filters->kobj,
 			&damon_sysfs_sample_filters_ktype, &sample->kobj,
@@ -1191,6 +1517,9 @@ static int damon_sysfs_sample_add_dirs(
 put_filters_out:
 	kobject_put(&filters->kobj);
 	sample->filters = NULL;
+put_perf_events_out:
+	kobject_put(&primitives->perf_events->kobj);
+	primitives->perf_events = NULL;
 put_primitives_out:
 	kobject_put(&primitives->kobj);
 	sample->primitives = NULL;
@@ -1200,8 +1529,11 @@ static int damon_sysfs_sample_add_dirs(
 static void damon_sysfs_sample_rm_dirs(
 		struct damon_sysfs_sample *sample)
 {
-	if (sample->primitives)
+	if (sample->primitives) {
+		damon_sysfs_perf_events_rm_dirs(sample->primitives->perf_events);
+		kobject_put(&sample->primitives->perf_events->kobj);
 		kobject_put(&sample->primitives->kobj);
+	}
 	if (sample->filters) {
 		damon_sysfs_sample_filters_rm_dirs(sample->filters);
 		kobject_put(&sample->filters->kobj);
@@ -1450,10 +1782,10 @@ static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
 
 	err = damon_sysfs_context_set_schemes(context);
 	if (err)
-		goto put_targets_attrs_out;
+		goto put_targets_out;
 	return 0;
 
-put_targets_attrs_out:
+put_targets_out:
 	kobject_put(&context->targets->kobj);
 	context->targets = NULL;
 rmdir_put_attrs_out:
@@ -1929,6 +2261,40 @@ static int damon_sysfs_add_targets(struct damon_ctx *ctx,
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
@@ -1970,6 +2336,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		return err;
+	err = damon_sysfs_add_perf_events(ctx, sys_ctx->attrs->sample->primitives->perf_events);
 	if (err)
 		return err;
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b069dbc7e3d2..1534372e7637 100644
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
 
@@ -936,6 +939,161 @@ static int damon_va_scheme_score(struct damon_ctx *context,
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
+		report->tgid = task_tgid_nr(current);
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
+int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
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
+		.precise_ip = 2,
+		.pinned = 1,
+		.disabled = 1,
+	};
+	int cpu;
+	int err = -ENOMEM;
+	bool found = false;
+
+	perf = kzalloc_obj(*perf);
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
+void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event)
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
+#endif /* CONFIG_PERF_EVENTS */
+
 static int __init damon_va_initcall(void)
 {
 	struct damon_operations ops = {
-- 
2.43.0

