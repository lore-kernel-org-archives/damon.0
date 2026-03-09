Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275B230BDB
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018043; cv=none; b=QBrqBZx51Cs2Gk/OXgZWklijZkK7wRV15ZbM2Y8kQfv4ConfkTORNs3vIYxYLOp7UICbO6NuoaB5EzYlKcd/mtm9eZasz3kcGx3nBwkRtpmBW5xMFn2mxIDVXmfmJMjdDiVhsufb1npgbv5HuKuEFvGK/LlcrbOXHKFKE2xy3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018043; c=relaxed/simple;
	bh=I/dSvmYFHpEzu0BwQ8jknnjbsOMMMgrVMepEV3YMCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL1fsZ3dRbACvOSpawy75u+7F9Rjf6fthKhQ7d6tDf0/rd05EYO5Z3RkUfqEUtwvScXfMdOqWbpjfr77M0h5TNSkxf4acd9TnYofbyZE+r4yu8ruzM+OZOi9Tg7NB221jtDQSImuh1SRz4vmu+D2OZ8qRIC5d0z7NTFv3tvOfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFd8IIrk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFd8IIrk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8299f1ca86fso1089555b3a.0
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018041; x=1773622841; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl+NzwF4I/yr9cuBytW8j+VQaFtY49NqDtGWFgHhj3w=;
        b=IFd8IIrkTuL8eWfyQKleoguYPa80pGrukt6ro8qW/MvQufn8JJwGqDznMlMbr56fRX
         vqLaS/bGP9v2MVF61xMS2Gm5ePedTayE09Gl10m/h8QXZXZ2Zxqnep413SduYtaBU+B1
         6LIvcewv+g50pOMeOFtyQt9bXBIasN07xHnZukvc+RJKOzUbKWOXnYeJCGcIHHuXy8oI
         QXS7Q+N6wdPkNLZUJgj0obV3aGm05+Ppv5oQCdYSlueN2x5qRqq6anh7nSSpviCVpGAm
         bzfJgZ/Z4wSjZy5RzXFBq5raFPOYh14AVBun2GucS1Riw6Lk9LVcyCXTLFWUgPn631Ux
         IanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018041; x=1773622841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bl+NzwF4I/yr9cuBytW8j+VQaFtY49NqDtGWFgHhj3w=;
        b=O0SRHLRtL58jvEUrWT4cC14gVfUU6+1k34YSPZ0kIi7jIz0Gk+Z7xzM9bti1kH9DJ+
         PYtFdf1s7H9fet5OcF/1UT6MGB549GYf6dfO7bO8f4KQInlPOgA60mB0MSo1EP9ujY2F
         YHrqkF34Va7lx8vYMYns+4akKPfm5vTwIE/WEJoAFSxaTHot2/hIBwb8F52l1EKnXeCI
         4XrQWvac6vUEb+t2lpYOsT3VBrnZg/nJ4RjvDDBgERhQ08K9HaOwmjDtE9qMx4B6X7rk
         xxXFK4LjN8rXRJZGRkkmzWyqLWYayyCdOPHHxmoJR9wU3OPS1HchEuFVQh2+qlbB6WUu
         aK/A==
X-Gm-Message-State: AOJu0Yyu08fuGTfVxCaTWv7/pQVo9ESACOZN4pmcu2qApamwv2j9MWN3
	um3fsrrhr2Lw/PG87BL+IF0IJIGjtliO71CPBGUi+8jFcmLG/q2mrJme7snvLA==
X-Gm-Gg: ATEYQzxXfo1JcFsDUoSI90+kDORmbLC4/As1FZBETv+UYo5JT39vuBvfsJCBqe45wYG
	QQl5VsRL1ofSDS30gP7ojc4LeeUOHJShEa62i15/VMgzaMRDcaiZQWiPFS037s76nzevJAWjF4L
	XwhW3HgSEHNO0FWtu8mRhBH6USX8k7+b7dfKK02L0UEnNcCx6AudvzYf9xRNJn8uG4TJuwPNqNu
	jHSndh6qqeLH1Qwsw2OyJjPbEawz+vrmC5ijfRFXlLfkrU/Sc+TApDpu54+O39rfRTnxa0z/Xbl
	aDSHO/ZuziDlrQ9jmxnFbQhzwyKwKH8vOms+aoT7nIVIVbW2BQIGY6GaqrxwuQJY/1DWQ3yB9YJ
	/7c9lVTfLzoXHDsHkUC0CfWFaHwz6Q4z/uwwcd2iQooSPGmAJdLY4cY1WBmtI2KxebKHpktRzf9
	ZWDkhExV3Yv5ADSwxbS+8H/QrkfAy6OKPaZt/jGA==
X-Received: by 2002:a05:6a00:4212:b0:824:18cd:f2f6 with SMTP id d2e1a72fcca58-829a30c8723mr7884169b3a.59.1773018040529;
        Sun, 08 Mar 2026 18:00:40 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:40 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 6/6] mm/damon: allow user to set min size of region
Date: Mon,  9 Mar 2026 10:00:09 +0900
Message-ID: <20260309010009.11639-7-akinobu.mita@gmail.com>
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

Currently, the region size is limited to a page size or more,
but this patch makes it possible to set the lower limit using
the following sysfs interfaces:

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/region_sz/min
Description: Writing a value to this file sets the minimum size of monitoring regions of
the DAMON target as the value.  Reading this file returns the value.

You can monitor fixed region size granularity by setting the ``min_nr_regions``
attribute greater than the working set size divided by the minimum size.
---
 .../ABI/testing/sysfs-kernel-mm-damon         |  2 +
 include/linux/damon.h                         |  2 +
 mm/damon/core.c                               | 23 ++++++++++-
 mm/damon/sysfs-common.c                       | 11 +++++
 mm/damon/sysfs-common.h                       |  1 +
 mm/damon/sysfs.c                              | 26 +++++++++++-
 mm/damon/tests/sysfs-kunit.h                  |  2 +
 mm/damon/tests/vaddr-kunit.h                  |  5 ++-
 mm/damon/vaddr.c                              | 41 +++++++++++++------
 9 files changed, 97 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 405a1a7f1eb6..21ab1b8d4008 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -571,6 +571,8 @@ Description:	Reading this file returns the size of the memory in the region
 		that passed DAMON operations layer-handled filters of the
 		scheme in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/region_sz/min
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/nr_perf_events
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/type
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config
diff --git a/include/linux/damon.h b/include/linux/damon.h
index c1cf3b5b990b..21d5deca9b11 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -91,6 +91,7 @@ struct damon_region {
  * struct damon_target - Represents a monitoring target.
  * @pid:		The PID of the virtual address space to monitor.
  * @nr_regions:		Number of monitoring target regions of this target.
+ * @min_region_sz:	The minimum size of adaptive monitoring regions.
  * @regions_list:	Head of the monitoring target regions of this target.
  * @list:		List head for siblings.
  * @obsolete:		Whether the commit destination target is obsolete.
@@ -107,6 +108,7 @@ struct damon_region {
 struct damon_target {
 	struct pid *pid;
 	unsigned int nr_regions;
+	unsigned long min_region_sz;
 	struct list_head regions_list;
 	struct list_head list;
 	bool obsolete;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f8e4db2e80d6..8a2e7bdfe904 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -217,6 +217,8 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	min_region_sz = max(min_region_sz, t->min_region_sz);
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {
@@ -479,6 +481,7 @@ struct damon_target *damon_new_target(void)
 
 	t->pid = NULL;
 	t->nr_regions = 0;
+	t->min_region_sz = 0;
 	INIT_LIST_HEAD(&t->regions_list);
 	INIT_LIST_HEAD(&t->list);
 	t->obsolete = false;
@@ -1192,6 +1195,13 @@ static int damon_commit_target(
 	if (src_has_pid)
 		get_pid(src->pid);
 	dst->pid = src->pid;
+	dst->min_region_sz = src->min_region_sz;
+	if (dst->min_region_sz) {
+		if (dst->min_region_sz < DAMON_MIN_REGION_SZ || !is_power_of_2(dst->min_region_sz)) {
+			pr_debug("invalid min_region_sz=%lu\n", dst->min_region_sz);
+			dst->min_region_sz = 0;
+		}
+	}
 	return 0;
 }
 
@@ -1776,6 +1786,8 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
+	min_region_sz = max(min_region_sz, t->min_region_sz);
+
 	/* Skip previously charged regions */
 	if (quota->charge_target_from) {
 		if (t != quota->charge_target_from)
@@ -1829,6 +1841,8 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	int target_idx = 0;
 	unsigned long start, end;
 
+	min_region_sz = max(min_region_sz, t->min_region_sz);
+
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
 		damon_for_each_target(ti, ctx) {
@@ -1978,6 +1992,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
+	unsigned long min_region_sz = max(c->min_region_sz, t->min_region_sz);
 	unsigned long sz_applied = 0;
 	unsigned long sz_ops_filter_passed = 0;
 	/*
@@ -2011,7 +2026,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					c->min_region_sz);
+					min_region_sz);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -2517,7 +2532,9 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit);
+			unsigned long target_sz_limit = max(sz_limit, t->min_region_sz);
+
+			damon_merge_regions_of(t, threshold, target_sz_limit);
 			nr_regions += damon_nr_regions(t);
 		}
 		threshold = max(1, threshold * 2);
@@ -2558,6 +2575,8 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs,
 	unsigned long sz_region, sz_sub = 0;
 	int i;
 
+	min_region_sz = max(min_region_sz, t->min_region_sz);
+
 	damon_for_each_region_safe(r, next, t) {
 		sz_region = damon_sz_region(r);
 
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 83e24a9b5a0d..d21649ac2589 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -104,3 +104,14 @@ const struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+static struct attribute *damon_sysfs_ul_min_attrs[] = {
+	&damon_sysfs_ul_range_min_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ul_min);
+
+const struct kobj_type damon_sysfs_ul_min_ktype = {
+	.release = damon_sysfs_ul_range_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ul_min_groups,
+};
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 2099adee11d0..71520dc97268 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -22,6 +22,7 @@ struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
 void damon_sysfs_ul_range_release(struct kobject *kobj);
 
 extern const struct kobj_type damon_sysfs_ul_range_ktype;
+extern const struct kobj_type damon_sysfs_ul_min_ktype;
 
 /*
  * schemes directory
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 040b669d0f49..aa4a8f0a36d9 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -211,6 +211,7 @@ static const struct kobj_type damon_sysfs_regions_ktype = {
 struct damon_sysfs_target {
 	struct kobject kobj;
 	struct damon_sysfs_regions *regions;
+	struct damon_sysfs_ul_range *region_sz_range;
 	int pid;
 	bool obsolete;
 };
@@ -223,6 +224,7 @@ static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
 static int damon_sysfs_target_add_dirs(struct damon_sysfs_target *target)
 {
 	struct damon_sysfs_regions *regions = damon_sysfs_regions_alloc();
+	struct damon_sysfs_ul_range *region_sz_range;
 	int err;
 
 	if (!regions)
@@ -231,14 +233,35 @@ static int damon_sysfs_target_add_dirs(struct damon_sysfs_target *target)
 	err = kobject_init_and_add(&regions->kobj, &damon_sysfs_regions_ktype,
 			&target->kobj, "regions");
 	if (err)
-		kobject_put(&regions->kobj);
+		goto put_regions_out;
 	else
 		target->regions = regions;
+
+	region_sz_range = damon_sysfs_ul_range_alloc(0, 0);
+	if (!region_sz_range) {
+		err = -ENOMEM;
+		goto put_regions_out;
+	}
+
+	err = kobject_init_and_add(&region_sz_range->kobj,
+			&damon_sysfs_ul_min_ktype, &target->kobj, "region_sz");
+	if (err)
+		goto put_region_sz_out;
+	target->region_sz_range = region_sz_range;
+	return 0;
+
+put_region_sz_out:
+	kobject_put(&region_sz_range->kobj);
+	target->region_sz_range = NULL;
+put_regions_out:
+	kobject_put(&regions->kobj);
+	target->regions = NULL;
 	return err;
 }
 
 static void damon_sysfs_target_rm_dirs(struct damon_sysfs_target *target)
 {
+	kobject_put(&target->region_sz_range->kobj);
 	damon_sysfs_regions_rm_dirs(target->regions);
 	kobject_put(&target->regions->kobj);
 }
@@ -1737,6 +1760,7 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			return -EINVAL;
 	}
 	t->obsolete = sys_target->obsolete;
+	t->min_region_sz = sys_target->region_sz_range->min;
 	return damon_sysfs_set_regions(t, sys_target->regions,
 			ctx->min_region_sz);
 }
diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index f9ec5e795b34..e558ec116c04 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -70,6 +70,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 		kunit_skip(test, "sysfs_regions alloc fail");
 	}
 
+	sysfs_target->region_sz_range = damon_sysfs_ul_range_alloc(0, 0);
 	sysfs_targets->targets_arr[0] = sysfs_target;
 
 	ctx = damon_new_ctx();
@@ -93,6 +94,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 	kfree(sysfs_targets->targets_arr);
 	kfree(sysfs_targets);
 	kfree(sysfs_target->regions);
+	kfree(sysfs_target->region_sz_range);
 	kfree(sysfs_target);
 }
 
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index cfae870178bf..263e6d026714 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -65,6 +65,7 @@ static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	struct damon_target *t = damon_new_target();
 	static struct mm_struct mm;
 	struct damon_addr_range regions[3] = {0};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
@@ -81,7 +82,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
 		kunit_skip(test, "Failed to create VMA tree");
 
-	__damon_va_three_regions(&mm, regions);
+	__damon_va_three_regions(t, &mm, regions);
 
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
@@ -89,6 +90,8 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
 	KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
 	KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
+
+	damon_free_target(t);
 }
 
 static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index a9398c319331..d8c78d34c346 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -73,6 +73,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	struct damon_region *n = NULL, *next;
 	unsigned long start;
 	unsigned int i;
+	unsigned long min_region_sz = max(DAMON_MIN_REGION_SZ, t->min_region_sz);
 
 	if (!r || !nr_pieces)
 		return -EINVAL;
@@ -82,7 +83,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION_SZ);
+	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, min_region_sz);
 
 	if (!sz_piece)
 		return -EINVAL;
@@ -121,12 +122,13 @@ static unsigned long sz_range(struct damon_addr_range *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct mm_struct *mm,
+static int __damon_va_three_regions(struct damon_target *t, struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
 	struct damon_addr_range first_gap = {0}, second_gap = {0};
 	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma, *prev = NULL;
+	unsigned long min_region_sz = max(DAMON_MIN_REGION_SZ, t->min_region_sz);
 	unsigned long start;
 
 	/*
@@ -157,20 +159,35 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	}
 	rcu_read_unlock();
 
-	if (!sz_range(&second_gap) || !sz_range(&first_gap))
+	if (!sz_range(&second_gap) || !sz_range(&first_gap)) {
+		pr_warn_once("The size of the first and second gaps are %lu and %lu\n",
+				sz_range(&first_gap), sz_range(&second_gap));
 		return -EINVAL;
+	}
 
 	/* Sort the two biggest gaps by address */
 	if (first_gap.start > second_gap.start)
 		swap(first_gap, second_gap);
 
 	/* Store the result */
-	regions[0].start = ALIGN(start, DAMON_MIN_REGION_SZ);
-	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION_SZ);
-	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION_SZ);
-	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION_SZ);
-	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION_SZ);
-	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION_SZ);
+	regions[0].start = ALIGN_DOWN(start, min_region_sz);
+	regions[0].end = ALIGN(first_gap.start, min_region_sz);
+	regions[1].start = ALIGN_DOWN(first_gap.end, min_region_sz);
+	regions[1].end = ALIGN(second_gap.start, min_region_sz);
+	regions[2].start = ALIGN_DOWN(second_gap.end, min_region_sz);
+	regions[2].end = ALIGN(prev->vm_end, min_region_sz);
+
+	for (int i = 0; i < 3; i++) {
+		if (!sz_range(&regions[i])) {
+			pr_warn_once("The size of the %dth range is %lu\n",
+					i, sz_range(&regions[i]));
+			return -EINVAL;
+		}
+		if (i > 0 && regions[i - 1].end >= regions[i].start) {
+			pr_warn_once("%dth and %dth regions overlap\n", i - 1, i);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -191,7 +208,7 @@ static int damon_va_three_regions(struct damon_target *t,
 		return -EINVAL;
 
 	mmap_read_lock(mm);
-	rc = __damon_va_three_regions(mm, regions);
+	rc = __damon_va_three_regions(t, mm, regions);
 	mmap_read_unlock(mm);
 
 	mmput(mm);
@@ -246,6 +263,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 	struct damon_target *ti;
 	struct damon_region *r;
 	struct damon_addr_range regions[3];
+	unsigned long min_region_sz = max(DAMON_MIN_REGION_SZ, t->min_region_sz);
 	unsigned long sz = 0, nr_pieces;
 	int i, tidx = 0;
 
@@ -263,8 +281,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION_SZ)
-		sz = DAMON_MIN_REGION_SZ;
+	sz = max(sz, min_region_sz);
 
 	/* Set the initial three regions of the target */
 	for (i = 0; i < 3; i++) {
-- 
2.43.0

