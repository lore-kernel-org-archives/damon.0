Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99634351C0B
	for <damon@lists.linux.dev>; Thu, 26 Mar 2026 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510067; cv=pass; b=CC8maakLCKfpkhE04jBw7bwZ6CY3z3S785MlutQCzwOQaBKg77moPXerm4yWHLtLKe/SPF3M5BhZith8kGv+4jV5QjNokq6VqCrD29LegQ4qXh8GNLjv3ynCqXBDNs4WzHt0z9fw7bAgQkN8Mafcjo5bCO+y8g6xfbIJzrb5PMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510067; c=relaxed/simple;
	bh=VMTAZn/n69TJg1eFkzx4eza4EVDYS6Kgckjeu7iCF5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIfFT2wesuDS064tMlXNDRfxz7lr9ZgFRIDyH9B/Vv4KNqhpcsHX6OqYPJmKmBPb+l3tlMZWH+whhbEPZSQ1fxN7ecqb+0BmZ+oJ6YG0q6T7qbsiqIIm1SqQD4ReHXKcfKifu/6w2NL9zxR9IIJ3xhzAS6a44Ff+ZmsCP96EI38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=nZGSemKE; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="nZGSemKE"
ARC-Seal: i=1; a=rsa-sha256; t=1774510060; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MVdil4SwXBeFJKOakdTnhZ8pNsxWFSdSIBw0exhJdVZJ7yCu6ZKGUmtn2pmykJxeWYYgi+mG2x4lglGmDl3gzxavduMfCef0Ur0G/0Ook1XqHk2/wBX8oE5zfB5aERyHjIJM1qMSAwqxuCUlBHKFWC9wrof0grM6dbOy0s0rOHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774510060; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fSlpjn3oksxevhf5a8wMKDNUaIUou3AgbGClEtPqm2Q=; 
	b=kf6sROimXyIcVaYDTbkQddj9etmuyLhOyXzNxXLZ7kH6DsbIyrkVblJ5YdPM6bIaviFQ4ZjS52vxZH0qAa1GJE0xcyi+zBDMZbPWu/AeC7UftRz5PovKTBte+OnhUkuDVh1JQdnKkmZTcy/aIFDRv+HMzW3VKBVrBHlN1IA97B8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774510060;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=fSlpjn3oksxevhf5a8wMKDNUaIUou3AgbGClEtPqm2Q=;
	b=nZGSemKEuL74477gEe3T4eBgUUDy1Mwx84OJYswWWieAutUG9y9kjeC8q+Xkt4No
	p3j+mnAxk6Stlo4M2dVwBE1hF3iRwDxs5lpPuw64DHFJnI83Uf7XYiAdBaB5IFjogV3
	NYCkCMGw8wTDYsOcvoIFz74o/1r5615nrQ4oWsms=
Received: by mx.zoho.eu with SMTPS id 1774510059069430.69969836521636;
	Thu, 26 Mar 2026 08:27:39 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering module
Date: Thu, 26 Mar 2026 07:27:37 +0000
Message-Id: <20260326072737.341964-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new DAMON special-purpose module for NUMA memory tiering.
DAMON_TIER monitors physical memory access patterns and migrates hot
pages from slow NUMA nodes to fast NUMA nodes (promotion), and cold
pages in the opposite direction (demotion).

The module uses two DAMOS schemes, one for each migration direction,
with DAMOS_QUOTA_NODE_MEM_USED_BP and DAMOS_QUOTA_NODE_MEM_FREE_BP
quota goals to automatically adjust aggressiveness based on the fast
node's utilization.  It also applies YOUNG page filters to avoid
migrating pages that have been recently accessed in the wrong direction.

This is a production-quality version of the samples/damon/mtier.c proof
of concept, following the same module_param-based interface pattern
as DAMON_RECLAIM and DAMON_LRU_SORT.  It reuses the modules-common.h
infrastructure for monitoring attributes, quotas, watermarks, and
statistics.

Module parameters allow configuring:
- promote_target_nid / demote_target_nid: the NUMA node pair
- promote_target_mem_used_bp / demote_target_mem_free_bp: utilization
  goals driving quota auto-tuning
- Standard DAMON module knobs: monitoring intervals, quotas, watermarks,
  region bounds, stats, and runtime reconfiguration via commit_inputs

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/Kconfig  |   9 +
 mm/damon/Makefile |   1 +
 mm/damon/tier.c   | 409 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 mm/damon/tier.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 34631a44cdec..fc45564d4e2e 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -105,6 +105,15 @@ config DAMON_LRU_SORT
 	  protect frequently accessed (hot) pages while rarely accessed (cold)
 	  pages reclaimed first under memory pressure.
 
+config DAMON_TIER
+	bool "Build DAMON-based NUMA memory tiering (DAMON_TIER)"
+	depends on DAMON_PADDR && NUMA
+	help
+	  This builds the DAMON-based NUMA memory tiering subsystem.  It
+	  monitors memory access patterns and migrates hot pages from slow
+	  NUMA nodes to fast NUMA nodes, and cold pages in the opposite
+	  direction, aiming a target utilization of the fast node.
+
 config DAMON_STAT
 	bool "Build data access monitoring stat (DAMON_STAT)"
 	depends on DAMON_PADDR
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index d8d6bf5f8bff..d70d994b227f 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
+obj-$(CONFIG_DAMON_TIER)	+= modules-common.o tier.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
diff --git a/mm/damon/tier.c b/mm/damon/tier.c
new file mode 100644
index 000000000000..4a5078685f1f
--- /dev/null
+++ b/mm/damon/tier.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON-based NUMA Memory Tiering
+ *
+ * Promotes hot pages from slow NUMA node(s) to fast NUMA node(s) and demotes
+ * cold pages in the opposite direction, based on DAMON-observed access
+ * patterns.  Adjusts the aggressiveness of each direction aiming for a target
+ * utilization of the fast (promote_target_nid) node.
+ */
+
+#define pr_fmt(fmt) "damon-tier: " fmt
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
+#define MODULE_PARAM_PREFIX "damon_tier."
+
+/*
+ * Enable or disable DAMON_TIER.
+ *
+ * You can enable DAMON_TIER by setting the value of this parameter as ``Y``.
+ * Setting it as ``N`` disables DAMON_TIER.  Note that DAMON_TIER could do no
+ * real monitoring and migration due to the watermarks-based activation
+ * condition.  Refer to below descriptions for the watermarks parameter for
+ * this.
+ */
+static bool enabled __read_mostly;
+
+/*
+ * Make DAMON_TIER reads the input parameters again, except ``enabled``.
+ *
+ * Input parameters that updated while DAMON_TIER is running are not applied
+ * by default.  Once this parameter is set as ``Y``, DAMON_TIER reads values
+ * of parameters except ``enabled`` again.  Once the re-reading is done, this
+ * parameter is set as ``N``.  If invalid parameters are found while the
+ * re-reading, DAMON_TIER will be disabled.
+ */
+static bool commit_inputs __read_mostly;
+module_param(commit_inputs, bool, 0600);
+
+/*
+ * NUMA node ID of the fast (promote target) memory tier.
+ *
+ * Pages that are hot on the slow node will be migrated to this node.
+ * Cold pages on this node will be demoted to the slow node.  0 by default.
+ */
+static int promote_target_nid __read_mostly;
+module_param(promote_target_nid, int, 0600);
+
+/*
+ * NUMA node ID of the slow (demote target) memory tier.
+ *
+ * Pages that are cold on the fast node will be migrated to this node.
+ * Hot pages on this node will be promoted to the fast node.  1 by default.
+ */
+static int demote_target_nid __read_mostly = 1;
+module_param(demote_target_nid, int, 0600);
+
+/*
+ * Desired utilization of the fast node in basis points (1/10,000).
+ *
+ * DAMON_TIER automatically adjusts the promotion and demotion quotas to keep
+ * the fast node at this utilization level.  9960 (99.6 %) by default.
+ */
+static unsigned long promote_target_mem_used_bp __read_mostly = 9960;
+module_param(promote_target_mem_used_bp, ulong, 0600);
+
+/*
+ * Desired free ratio of the fast node in basis points for demotion.
+ *
+ * DAMON_TIER adjusts the demotion quota aiming to keep at least this much
+ * free memory on the fast node.  40 (0.4 %) by default.
+ */
+static unsigned long demote_target_mem_free_bp __read_mostly = 40;
+module_param(demote_target_mem_free_bp, ulong, 0600);
+
+static struct damos_quota damon_tier_quota = {
+	/* 200 MiB per 1 sec by default */
+	.ms = 0,
+	.sz = 200 * 1024 * 1024,
+	.reset_interval = 1000,
+	/* Ignore region size; prioritize by access pattern */
+	.weight_sz = 0,
+	.weight_nr_accesses = 100,
+	.weight_age = 100,
+};
+DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_tier_quota);
+
+static struct damos_watermarks damon_tier_wmarks = {
+	.metric = DAMOS_WMARK_FREE_MEM_RATE,
+	.interval = 5000000,	/* 5 seconds */
+	.high = 200,		/* 20 percent */
+	.mid = 150,		/* 15 percent */
+	.low = 50,		/* 5 percent */
+};
+DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_tier_wmarks);
+
+static struct damon_attrs damon_tier_mon_attrs = {
+	.sample_interval = 5000,	/* 5 ms */
+	.aggr_interval = 100000,	/* 100 ms */
+	.ops_update_interval = 0,
+	.min_nr_regions = 10,
+	.max_nr_regions = 1000,
+};
+DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_tier_mon_attrs);
+
+/*
+ * Start of the target memory region in physical address.
+ *
+ * The start physical address of memory region that DAMON_TIER will monitor.
+ * By default, biggest System RAM is used as the region.
+ */
+static unsigned long monitor_region_start __read_mostly;
+module_param(monitor_region_start, ulong, 0600);
+
+/*
+ * End of the target memory region in physical address.
+ *
+ * The end physical address of memory region that DAMON_TIER will monitor.
+ * By default, biggest System RAM is used as the region.
+ */
+static unsigned long monitor_region_end __read_mostly;
+module_param(monitor_region_end, ulong, 0600);
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_TIER is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+static int kdamond_pid __read_mostly = -1;
+module_param(kdamond_pid, int, 0400);
+
+static struct damos_stat damon_tier_promote_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_tier_promote_stat,
+		promote_tried_regions, promoted_regions,
+		promote_quota_exceeds);
+
+static struct damos_stat damon_tier_demote_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_tier_demote_stat,
+		demote_tried_regions, demoted_regions,
+		demote_quota_exceeds);
+
+static struct damon_ctx *ctx;
+static struct damon_target *target;
+
+static struct damos *damon_tier_new_scheme(
+		struct damos_access_pattern *pattern,
+		enum damos_action action, int target_nid)
+{
+	struct damos_quota quota = damon_tier_quota;
+
+	/* Use half of total quota for each direction */
+	quota.sz = quota.sz / 2;
+
+	return damon_new_scheme(
+			pattern,
+			action,
+			/* apply once per second */
+			1000000,
+			&quota,
+			&damon_tier_wmarks,
+			target_nid);
+}
+
+static struct damos *damon_tier_new_promote_scheme(void)
+{
+	struct damos_access_pattern pattern = {
+		.min_sz_region = PAGE_SIZE,
+		.max_sz_region = ULONG_MAX,
+		/* hot: accessed at least once */
+		.min_nr_accesses = 1,
+		.max_nr_accesses = UINT_MAX,
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
+
+	return damon_tier_new_scheme(&pattern, DAMOS_MIGRATE_HOT,
+			promote_target_nid);
+}
+
+static struct damos *damon_tier_new_demote_scheme(void)
+{
+	struct damos_access_pattern pattern = {
+		.min_sz_region = PAGE_SIZE,
+		.max_sz_region = ULONG_MAX,
+		/* cold: not accessed at all */
+		.min_nr_accesses = 0,
+		.max_nr_accesses = 0,
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
+
+	return damon_tier_new_scheme(&pattern, DAMOS_MIGRATE_COLD,
+			demote_target_nid);
+}
+
+static int damon_tier_add_quota_goals(struct damos *promote_scheme,
+		struct damos *demote_scheme)
+{
+	struct damos_quota_goal *goal;
+
+	goal = damos_new_quota_goal(DAMOS_QUOTA_NODE_MEM_USED_BP,
+			promote_target_mem_used_bp);
+	if (!goal)
+		return -ENOMEM;
+	goal->nid = promote_target_nid;
+	damos_add_quota_goal(&promote_scheme->quota, goal);
+
+	goal = damos_new_quota_goal(DAMOS_QUOTA_NODE_MEM_FREE_BP,
+			demote_target_mem_free_bp);
+	if (!goal)
+		return -ENOMEM;
+	goal->nid = promote_target_nid;
+	damos_add_quota_goal(&demote_scheme->quota, goal);
+	return 0;
+}
+
+static int damon_tier_add_filters(struct damos *promote_scheme,
+		struct damos *demote_scheme)
+{
+	struct damos_filter *filter;
+
+	/* skip promoting pages that are already young (recently accessed) */
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, true);
+	if (!filter)
+		return -ENOMEM;
+	damos_add_filter(promote_scheme, filter);
+
+	/* skip demoting pages that are young */
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, false);
+	if (!filter)
+		return -ENOMEM;
+	damos_add_filter(demote_scheme, filter);
+	return 0;
+}
+
+static int damon_tier_apply_parameters(void)
+{
+	struct damon_ctx *param_ctx;
+	struct damon_target *param_target;
+	struct damos *promote_scheme, *demote_scheme;
+	int err;
+
+	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
+	if (err)
+		return err;
+
+	err = damon_set_attrs(param_ctx, &damon_tier_mon_attrs);
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
+	promote_scheme = damon_tier_new_promote_scheme();
+	if (!promote_scheme)
+		goto out;
+
+	demote_scheme = damon_tier_new_demote_scheme();
+	if (!demote_scheme) {
+		damon_destroy_scheme(promote_scheme);
+		goto out;
+	}
+
+	damon_set_schemes(param_ctx, &promote_scheme, 1);
+	damon_add_scheme(param_ctx, demote_scheme);
+
+	err = damon_tier_add_quota_goals(promote_scheme, demote_scheme);
+	if (err)
+		goto out;
+	err = damon_tier_add_filters(promote_scheme, demote_scheme);
+	if (err)
+		goto out;
+
+	err = damon_set_region_biggest_system_ram_default(param_target,
+					&monitor_region_start,
+					&monitor_region_end,
+					param_ctx->min_region_sz);
+	if (err)
+		goto out;
+	err = damon_commit_ctx(ctx, param_ctx);
+out:
+	damon_destroy_ctx(param_ctx);
+	return err;
+}
+
+static int damon_tier_handle_commit_inputs(void)
+{
+	int err;
+
+	if (!commit_inputs)
+		return 0;
+
+	err = damon_tier_apply_parameters();
+	commit_inputs = false;
+	return err;
+}
+
+static int damon_tier_damon_call_fn(void *arg)
+{
+	struct damon_ctx *c = arg;
+	struct damos *s;
+
+	/* update the stats parameters */
+	damon_for_each_scheme(s, c) {
+		if (s->action == DAMOS_MIGRATE_HOT)
+			damon_tier_promote_stat = s->stat;
+		else if (s->action == DAMOS_MIGRATE_COLD)
+			damon_tier_demote_stat = s->stat;
+	}
+
+	return damon_tier_handle_commit_inputs();
+}
+
+static struct damon_call_control call_control = {
+	.fn = damon_tier_damon_call_fn,
+	.repeat = true,
+};
+
+static int damon_tier_turn(bool on)
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
+	err = damon_tier_apply_parameters();
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
+static int damon_tier_enabled_store(const char *val,
+		const struct kernel_param *kp)
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
+	/* Called before init function.  The function will handle this. */
+	if (!damon_initialized())
+		goto set_param_out;
+
+	err = damon_tier_turn(enable);
+	if (err)
+		return err;
+
+set_param_out:
+	enabled = enable;
+	return err;
+}
+
+static const struct kernel_param_ops enabled_param_ops = {
+	.set = damon_tier_enabled_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled,
+	"Enable or disable DAMON_TIER (default: disabled)");
+
+static int __init damon_tier_init(void)
+{
+	int err;
+
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	if (err)
+		goto out;
+
+	call_control.data = ctx;
+
+	/* 'enabled' has set before this function, probably via command line */
+	if (enabled)
+		err = damon_tier_turn(true);
+
+out:
+	if (err && enabled)
+		enabled = false;
+	return err;
+}
+
+module_init(damon_tier_init);
-- 
2.34.1

