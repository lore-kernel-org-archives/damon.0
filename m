Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8143D4FB
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622272; cv=none; b=MXXOPhH820ixbApWyOnHGrI6qzdDlJOYtK3DrSmompv77f1TyseuLrLsf+/6WtgCKhFhSOpOgSV/6ctB9Y7BXwGdF0faDbUgpWMh7Ej8/FX00PDXM+W6N9XVDxiFmx3yvTdXgvN2HMAI98zRgL+v/ul5usI7lGC0N/tTWXrKoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622272; c=relaxed/simple;
	bh=i6Ao6bB9JrPsNXHvXsGwHoj88Jg7DLWljqMOWYElo5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma2KGhYkRXbTYAXYzpihDiPEzi9t623AKqyYVku/LJYDl3+rvRvsjejHNNVGyfphnmJjJv00Q1lV2qpZVH2Hm7NPuZjpsDEKmbeqm5HqB2oVA5dbvRgdd0eE91uj/ibErOSah+tM/Faml7AwiKjLq5+gFIXilpfL09NXpUihjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gfqxz22VmzJ46bP;
	Tue, 16 Jun 2026 23:03:51 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C58C940574;
	Tue, 16 Jun 2026 23:04:14 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:04:14 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Tue, 16 Jun 2026 15:03:15 +0000
Message-ID: <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616150316.580819-1-gutierrez.asier@huawei-partners.com>
References: <20260616150316.580819-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
which collapses hot regions into huge pages.

SAMPLE_DAMON_HPAGE operates in the virtual memory space, for a
specific task. The user is expected to supply the PID of the task
that is going to be monitored through the target_pid module
variable.

SAMPLE_DAMON_HPAGE uses the hugepage auto-tune mechanism to
increase or decrease the aggressiveness of page collapsing. User
autotuning is also available for additional tuning aggressiveness
control.

The module also includes changes to the DAMON compilation, so that
the module can be enabled or disabled.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 samples/damon/Kconfig       |  14 +++
 samples/damon/Makefile      |   1 +
 samples/damon/hpage.c (new) | 207 ++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index cbf96fd8a8bf..1ef0b12c32e6 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -40,4 +40,18 @@ config SAMPLE_DAMON_MTIER
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_HPAGE
+	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HPAGE)"
+	depends on DAMON && DAMON_VADDR && TRANSPARENT_HUGEPAGE
+	help
+	  This builds DAMON sample module for collapsing regions into huge pages.
+
+	  This module monitors a certain PID provided by the user through
+	  target_pid attribute. Hot regions are determined by DAMON-based
+	  sampling. Collapsing occurs according to the quota goal using total
+	  memory usage to huge page usage ratio. The ratio is set by the user
+	  through a module attribute.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index 72f68cbf422a..a348dc74ddcb 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
 obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
 obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
+obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE) += hpage.o
diff --git a/samples/damon/hpage.c b/samples/damon/hpage.c
new file mode 100644
index 000000000000..ebbe5e1be1a1
--- /dev/null
+++ b/samples/damon/hpage.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 HUAWEI, Inc.
+ *             https://www.huawei.com
+ *
+ * Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
+ */
+
+#define pr_fmt(fmt) "damon_sample_hpage: " fmt
+
+#include <linux/damon.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_sample_hpage."
+
+static bool enabled __read_mostly;
+
+static unsigned long target_pid;
+module_param(target_pid, ulong, 0600);
+
+/* By default, total huge pages to system memory usage ratio set to 10% */
+static unsigned long quota_percentage_hugepage __read_mostly = 1000;
+module_param(quota_percentage_hugepage, ulong, 0600);
+
+static unsigned long quota_autotune_feedback __read_mostly;
+module_param(quota_autotune_feedback, ulong, 0600);
+
+static struct damon_ctx *ctx;
+static struct pid *target_pidp;
+
+static int damon_sample_hpage_damon_call_fn(void *data)
+{
+	struct damon_ctx *c = data;
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+		unsigned long hugepages = 0;
+
+		damon_for_each_region(r, t) {
+			if (r->nr_accesses > 0)
+				hugepages += r->ar.end - r->ar.start;
+		}
+		hugepages = hugepages / HPAGE_PMD_SIZE;
+		pr_info("hugepage: %lu\n", hugepages);
+	}
+	return 0;
+}
+
+static struct damon_call_control call_control = {
+	.fn = damon_sample_hpage_damon_call_fn,
+	.repeat = true,
+};
+
+static int damon_sample_hpage_start(void)
+{
+	int err;
+	struct damon_target *target;
+	struct damos *scheme;
+	struct damos_quota_goal *goal;
+
+	pr_info("start\n");
+
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+	target_pidp = find_get_pid(target_pid);
+	if (!target_pidp) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+	target->pid = target_pidp;
+
+	scheme = damon_new_scheme(&(struct damos_access_pattern) {
+				.min_sz_region = HPAGE_PMD_SIZE,
+				.max_sz_region = ULONG_MAX,
+				.min_nr_accesses = 0,
+				.max_nr_accesses = UINT_MAX,
+				.min_age_region = 50,
+				.max_age_region = UINT_MAX},
+				DAMOS_COLLAPSE, 0,
+				&(struct damos_quota) {
+				.ms = 10,
+				.sz = 128 * 1024 * 1024,
+				.reset_interval = 1000,
+				.weight_sz = 0,
+				.weight_nr_accesses = 1,
+				.weight_age = 1,
+				.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL},
+				&(struct damos_watermarks){}, NUMA_NO_NODE);
+	if (!scheme) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_set_schemes(ctx, &scheme, 1);
+	goal = damos_new_quota_goal(DAMOS_QUOTA_HUGEPAGE_MEM_BP,
+				quota_percentage_hugepage);
+	if (!goal) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damos_add_quota_goal(&scheme->quota, goal);
+
+	if (quota_autotune_feedback) {
+		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
+		if (!goal) {
+			damon_destroy_ctx(ctx);
+			return -ENOMEM;
+		}
+		goal->current_value = quota_autotune_feedback;
+		damos_add_quota_goal(&scheme->quota, goal);
+	}
+
+	err = damon_start(&ctx, 1, true);
+	if (err) {
+		damon_destroy_ctx(ctx);
+		return err;
+	}
+
+	call_control.data = ctx;
+	err = damon_call(ctx, &call_control);
+	if (err) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	return err;
+}
+
+static void damon_sample_hpage_stop(void)
+{
+	pr_info("stop\n");
+	if (ctx) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+}
+static int damon_sample_hpage_enabled_store(const char *val,
+				const struct kernel_param *kp)
+{
+	bool is_enabled = enabled;
+	int err;
+
+	err = kstrtobool(val, &enabled);
+	if (err)
+		return err;
+
+	if (enabled == is_enabled)
+		return 0;
+
+	if (!damon_initialized())
+		return 0;
+
+	if (enabled) {
+		err = damon_sample_hpage_start();
+		if (err)
+			enabled = false;
+		return err;
+	}
+	damon_sample_hpage_stop();
+	return 0;
+}
+
+static const struct kernel_param_ops enabled_param_ops = {
+	.set = damon_sample_hpage_enabled_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled,
+	"Enable or disable DAMON_HUGEPAGE (default: disabled)");
+
+static int __init damon_sample_hpage_init(void)
+{
+	int err = 0;
+
+	if (!damon_initialized()) {
+		if (enabled)
+			enabled = false;
+		pr_warn("Module not initialized\n");
+		return -ENOMEM;
+	}
+
+	if (enabled) {
+		err = damon_sample_hpage_start();
+		if (err)
+			enabled = false;
+	}
+	return err;
+}
+
+module_init(damon_sample_hpage_init);
-- 
2.43.0

