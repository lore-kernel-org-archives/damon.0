Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597D32E6B4
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586682; cv=none; b=Zr3Z7f/AvKpxJFd++4ST1jmgYeesBYQ6f1xLoMUsed8/LzYjLafv0lfkUgYUBB87u2CTlA94piFeY4F4vW3YD85SYhz8RGMUf2xui9pBcaegDd2w2fjR8KeMAIjuE19Mgkq2+ofHmdk15zQm/Jhwe7q7q5M0s4u0d5hIRpO6Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586682; c=relaxed/simple;
	bh=BuDDOkvu9teO1TboNb2iPY2PuBn5dU462SQmNMRS3R4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/IRwjQBjSe5M/FY/FFREMPmgIax61yFQRJTN3TsrqXjRkyZxm2e9DukPdBE8D1GR907VZ2kImG2fWqEyCP2TgsBX0S4Lwusa17Bp0tuLnmp46nkqcvOp6qqZ7l7c+641I4Z/8U7Ka06twNj2CwS5QFz/K+vbXvsu86QqvYsSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWSW76vkszHnGjM;
	Thu,  4 Jun 2026 23:03:31 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id A381740569;
	Thu,  4 Jun 2026 23:04:25 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 18:04:25 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Thu, 4 Jun 2026 15:03:36 +0000
Message-ID: <20260604150338.501128-4-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604150338.501128-1-gutierrez.asier@huawei-partners.com>
References: <20260604150338.501128-1-gutierrez.asier@huawei-partners.com>
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

This patch introduces a new DAMON module (SAMPLE_DAMON_HUGEPAGE)
which collapses hot regions into huge pages.

SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
specific task. The user is expected to supply the PID of the task
that is going to be monitored through the monitored_pid module
variable.

SAMPLE_DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to
increase or decrease the aggressiveness of page collapsing. User
autotuning is also available for additional tuning aggressiveness
control.

The module also includes changes to the DAMON compilation, so that
the module can be enabled or disabled.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 mm/damon/Makefile              |   8 +-
 samples/damon/Kconfig          |  12 ++
 samples/damon/Makefile         |   2 +
 samples/damon/hugepage.c (new) | 350 +++++++++++++++++++++++++++++++++
 4 files changed, 368 insertions(+), 4 deletions(-)

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index d8d6bf5f8bff..16459ce40304 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y				:= core.o
+obj-y				:= core.o modules-common.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
-obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
-obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
-obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
+obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
+obj-$(CONFIG_DAMON_LRU_SORT)	+= lru_sort.o
+obj-$(CONFIG_DAMON_STAT)	+= stat.o
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index cbf96fd8a8bf..512f150aaabb 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_HUGEPAGE
+	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HUGEPAGE)"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This module monitors a certain PID provided by the user through
+	  monitored_pid attribute. Hot regions are determined by DAMON-based
+	  sampling. Collapsing occurs according to the quota goal using total
+	  memory usage to huge page usage ratio. The ratio is set by the user
+	  through a module attribute.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index 72f68cbf422a..f90845faec85 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -3,3 +3,5 @@
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
 obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
 obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
+obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE)	+= hugepage.o
+ccflags-$(CONFIG_SAMPLE_DAMON_HUGEPAGE)	+= -I$(srctree)/mm/damon
diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
new file mode 100644
index 000000000000..e24562c92348
--- /dev/null
+++ b/samples/damon/hugepage.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 HUAWEI, Inc.
+ *             https://www.huawei.com
+ *
+ * Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
+ */
+
+#define pr_fmt(fmt) "damon-hugepage: " fmt
+
+#include <linux/damon.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+
+#include "modules-common.h"
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_hugepage."
+
+/*
+ * Enable or disable DAMON_HUGEPAGE.
+ *
+ * You can enable DAMON_HUGEPAGE by setting the value of this parameter
+ * as ``Y``. Setting it as ``N`` disables DAMON_HUGEPAGE.
+ */
+static bool enabled __read_mostly;
+
+/*
+ * Make DAMON_HUGEPAGE reads the input parameters again, except ``enabled``.
+ *
+ * Input parameters that updated while DAMON_HUGEPAGE is running are not applied
+ * by default.  Once this parameter is set as ``Y``, DAMON_HUGEPAGE reads values
+ * of parametrs except ``enabled`` again.  Once the re-reading is done, this
+ * parameter is set as ``N``.  If invalid parameters are found while the
+ * re-reading, DAMON_HUGEPAGE will be disabled.
+ */
+static bool commit_inputs __read_mostly;
+module_param(commit_inputs, bool, 0600);
+
+/*
+ * Scale factor for DAMON_HUGEPAGE to ops address conversion.
+ *
+ * This parameter must not be set to 0.
+ */
+static unsigned long addr_unit __read_mostly = 1;
+
+static unsigned long monitored_pid;
+module_param(monitored_pid, ulong, 0600);
+
+/*
+ * Time threshold for hot memory regions identification in microseconds.
+ *
+ * If a memory region has been accessed for this or longer time,
+ * DAMON_HUGEPAGE identifies the region as hot, and collapse it into a huge
+ * page.  100 microseconds by default.
+ */
+static unsigned long min_age __read_mostly = 100000;
+module_param(min_age, ulong, 0600);
+
+static struct damos_quota damon_hugepage_quota = {
+	/* use up to 10 ms time, collapse up to 128 MiB per 1 sec by default */
+	.ms = 10,
+	.sz = 128 * 1024 * 1024,
+	.reset_interval = 1000,
+	.weight_sz = 0,
+	.weight_nr_accesses = 1,
+	.weight_age = 1
+};
+DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_hugepage_quota);
+
+
+/*
+ * Desired ratio of huge pages use vs total anonymous memory usage.
+ *
+ * While keeping the caps that set by other quotas, DAMON_HUGEPAGE automatically
+ * increases and decreases the effective level of the quota to achieve the
+ * desired ratio.
+ *
+ * 100 bp by default.
+ */
+static unsigned long quota_percentage_hugepage __read_mostly = 100;
+module_param(quota_percentage_hugepage, ulong, 0600);
+
+/*
+ * User-specifiable feedback for auto-tuning of the effective quota.
+ *
+ * While keeping the caps that set by other quotas, DAMON_HUGEPAGE automatically
+ * increases and decreases the effective level of the quota aiming receiving this
+ * feedback of value ``10,000`` from the user.  DAMON_HUGEPAGE assumes the feedback
+ * value and the quota are positively proportional.  Value zero means disabling
+ * this auto-tuning feature.
+ *
+ * Disabled by default.
+ *
+ */
+static unsigned long quota_autotune_feedback __read_mostly;
+module_param(quota_autotune_feedback, ulong, 0600);
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_HUGEPAGE is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+static int kdamond_pid __read_mostly = -1;
+module_param(kdamond_pid, int, 0400);
+
+static struct damos_stat damon_hugepage_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_hugepage_stat,
+		hugepage_tried_regions, hugepage_regions, quota_exceeds);
+
+static struct damon_attrs damon_hugepage_mon_attrs = {
+	.sample_interval = 5 * USEC_PER_MSEC,
+	.aggr_interval = 100 * USEC_PER_MSEC,
+	.ops_update_interval = 60 * USEC_PER_MSEC * MSEC_PER_SEC,
+	.min_nr_regions = 10,
+	.max_nr_regions = 1000,
+};
+DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_hugepage_mon_attrs);
+
+static struct damon_ctx *ctx;
+static struct damon_target *target;
+
+static struct damos *damon_hugepage_new_scheme(void)
+{
+	struct damos_access_pattern pattern = {
+		/* Find regions having PMD_SIZE or larger size */
+		.min_sz_region = PMD_SIZE,
+		.max_sz_region = ULONG_MAX,
+		.min_nr_accesses = 0,
+		.max_nr_accesses = UINT_MAX,
+		.min_age_region = min_age /
+			damon_hugepage_mon_attrs.aggr_interval,
+		.max_age_region = UINT_MAX,
+	};
+
+	return damon_new_scheme(
+		&pattern,
+		/* synchrounous partial collapse as soon as found */
+		DAMOS_COLLAPSE, 0,
+		/* under the quota. */
+		&damon_hugepage_quota,
+		&(struct damos_watermarks){}, NUMA_NO_NODE);
+}
+
+static int damon_hugepage_apply_parameters(void)
+{
+	struct damon_ctx *param_ctx;
+	struct damon_target *param_target;
+	struct damos *scheme;
+	struct damos_quota_goal *goal;
+	struct pid *spid;
+	int err;
+
+	err = damon_modules_new_vaddr_ctx_target(&param_ctx, &param_target);
+	if (err)
+		return err;
+
+	param_ctx->addr_unit = addr_unit;
+    // align power of two
+	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / ALIGN(addr_unit, 2), 1);
+
+	spid = find_get_pid(monitored_pid);
+	if (!spid) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	param_target->pid = spid;
+
+	if (!damon_hugepage_mon_attrs.aggr_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = damon_set_attrs(param_ctx, &damon_hugepage_mon_attrs);
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
+	scheme = damon_hugepage_new_scheme();
+	if (!scheme)
+		goto out;
+	damon_set_schemes(param_ctx, &scheme, 1);
+
+	goal = damos_new_quota_goal(DAMOS_QUOTA_HUGEPAGE, quota_percentage_hugepage);
+	if (!goal)
+		goto out;
+	damos_add_quota_goal(&scheme->quota, goal);
+
+	if (quota_autotune_feedback) {
+		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
+		if (!goal)
+			goto out;
+		goal->current_value = quota_autotune_feedback;
+		damos_add_quota_goal(&scheme->quota, goal);
+	}
+
+	err = damon_commit_ctx(ctx, param_ctx);
+out:
+	damon_destroy_ctx(param_ctx);
+	return err;
+}
+
+static int damon_hugepage_handle_commit_inputs(void)
+{
+	int err;
+
+	if (!commit_inputs)
+		return 0;
+
+	err = damon_hugepage_apply_parameters();
+	commit_inputs = false;
+	return err;
+}
+
+static int damon_hugepage_damon_call_fn(void *arg)
+{
+	struct damon_ctx *c = arg;
+	struct damos *s;
+
+	/* update the stats parameter */
+	damon_for_each_scheme(s, c)
+		damon_hugepage_stat = s->stat;
+
+	return damon_hugepage_handle_commit_inputs();
+}
+
+static struct damon_call_control call_control = {
+	.fn = damon_hugepage_damon_call_fn,
+	.repeat = true,
+};
+
+static int damon_hugepage_turn(bool on)
+{
+	int err;
+
+	if (!on) {
+		err = damon_stop(&ctx, 1);
+		if (!err)
+			kdamond_pid = -1;
+		return err;
+	}
+
+	err = damon_hugepage_apply_parameters();
+	if (err)
+		return err;
+
+	err = damon_start(&ctx, 1, true);
+	if (err)
+		return err;
+	kdamond_pid = damon_kdamond_pid(ctx);
+	if (kdamond_pid < 0)
+		return kdamond_pid;
+	return damon_call(ctx, &call_control);
+}
+
+static int damon_hugepage_addr_unit_store(const char *val,
+		const struct kernel_param *kp)
+{
+	unsigned long input_addr_unit;
+	int err = kstrtoul(val, 0, &input_addr_unit);
+
+	if (err)
+		return err;
+	if (!input_addr_unit)
+		return -EINVAL;
+
+	addr_unit = input_addr_unit;
+	return 0;
+}
+
+static const struct kernel_param_ops addr_unit_param_ops = {
+	.set = damon_hugepage_addr_unit_store,
+	.get = param_get_ulong,
+};
+
+module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
+MODULE_PARM_DESC(addr_unit,
+	"Scale factor for DAMON_HUGEPAGE to ops address conversion (default: 1)");
+
+static int damon_hugepage_enabled_store(const char *val,
+				const struct kernel_param *kp)
+{
+	bool is_enabled = enabled;
+	bool enable;
+	int err;
+
+	err = kstrtobool(val, &enable);
+	if (err)
+		return err;
+
+	if (is_enabled == enable)
+		return 0;
+
+	/* Monitored process may have exited. In that case, ctx->kdamon is set */
+	/* to NULL. If enabled is set to 'off' through sysfs, we just set the  */
+	/* params and exit */
+	if (!damon_is_running(ctx) && !enable)
+		goto set_param_out;
+
+	/* Called before init function.  The function will handle this. */
+	if (!damon_initialized())
+		goto set_param_out;
+
+	err = damon_hugepage_turn(enable);
+	if (err)
+		return err;
+
+set_param_out:
+	enabled = enable;
+	return err;
+}
+
+static const struct kernel_param_ops enabled_param_ops = {
+	.set = damon_hugepage_enabled_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled,
+	"Enable or disable DAMON_HUGEPAGE (default: disabled)");
+
+static int __init damon_hugepage_init(void)
+{
+	int err;
+
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = damon_modules_new_vaddr_ctx_target(&ctx, &target);
+	if (err)
+		goto out;
+
+	call_control.data = ctx;
+
+	/* 'enabled' has set before this function, probably via command line */
+	if (enabled)
+		err = damon_hugepage_turn(true);
+
+out:
+	if (err && enabled)
+		enabled = false;
+	return err;
+}
+
+module_init(damon_hugepage_init);
-- 
2.43.0

