Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4420330;
	Mon, 26 May 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293782; cv=none; b=QeroD7FIZNmTX2E6siO+P4peJlzE3PQH0utD9leMox0A502hvrwLKFTbdGKYJ9rbAZs4GNHf4RgPhPYg6h4FWDc/RvvkQNERxpZuGna1+ZgVAKGrHnW5r2XbWEKm4ME+vCjR0hMkEtSXwmhMYKCNPDaQNx3B9Jq3r6Ttyvpjy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293782; c=relaxed/simple;
	bh=hKn9MHEuhQIYyoRWDiRwIxmlR7BH2F01294Qax+v28s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al2IjlF/sQBDhO7BE39yjB+xMiE2x7uUzaGGf/zHJKK+6EvsAlrDJaJs2jw7bEdTT37IV+zx90Fd8QfuwYTF4TJ0uWv8dQM72Yrnrc/TvDP3KVH0wAEzV3J18T38PfJ41eYqp2JnETD4SHfVO99Hzd+/IZCAIDgl45liScnv90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKdcCS2E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKdcCS2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE024C4CEEE;
	Mon, 26 May 2025 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748293782;
	bh=hKn9MHEuhQIYyoRWDiRwIxmlR7BH2F01294Qax+v28s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKdcCS2EWqLYinEOmrPSDcgg0gJRzLafODRPQBm+Pl8XXyFEtWLCgk627f3mW+XQS
	 KELmM7R305BbpswkAd02zUD4HsgLjBvfn5iIr/JB6cBhAzucmfoESr+il5aKUNd5uE
	 WtpaKk0CMMX4EHF3APGtATra5z3ZmccJBEx/erJNaefEufEAKdi4YmbNWSnsK0tDIk
	 Q1iCNdxd8xhs+VI6HYpRC2UansXRHS0+LG8uY3vZHMP8gw3Zt6cvgvWDCewdYKF6e/
	 9SgalZERP9ra1GnA709Odp6l48PBfqNspqydS2IEIqIOaQLMgqSWCjVOnv0pgr0gxU
	 XwT08eMaMm9uQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/damon: introduce DAMON_STAT module
Date: Mon, 26 May 2025 14:09:33 -0700
Message-Id: <20250526210936.2744-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526210936.2744-1-sj@kernel.org>
References: <20250526210936.2744-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To use DAMON for monitoring access patterns of the system, users should
manually start DAMON via DAMON sysfs ABI with a number of parameters for
specifying the monitoring target address space, address ranges, and
monitoring intervals.  After that, users should also wait until desired
amount of time data is captured into DAMON's monitoring results.  It is
bothersome and take a long time to be practical for access monitoring on
large fleet level production environments.

For access-aware system operations use cases like proactive cold memory
reclamation, similar problems existed.  We we solved those by
introducing dedicated static kernel modules such as DAMON_RECLAIM.

Implement such static kernel module for access monitoring, namely
DAMON_STAT.  It monitors the entire physical address space with
auto-tuned monitoring intervals.  The auto-tuning is set to capture 4 %
of observable access events in each snapshot while keeping the sampling
intervals 5 milliseconds in minimum and 10 seconds in maximum.  From
a few production environments, we confirmed this setup provides high
quality monitoring results with minimum overheads.  The module therefore
receives only one user input, whether to enable or disable it.  It can
be set on build or boot time via build configuration or kernel boot
command line.  It can also be overridden at runtime.

Note that this commit only implements the DAMON control part of the
module.  Users could get the monitoring results via
damon:damon_aggregated tracepoint, but that's of course not the
recommended way.  Following commits will implement convenient and
optimized ways for serving the monitoring results to users.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig  |  16 ++++++
 mm/damon/Makefile |   1 +
 mm/damon/stat.c   | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 mm/damon/stat.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 551745df011b..9f482e3adc67 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -95,4 +95,20 @@ config DAMON_LRU_SORT
 	  protect frequently accessed (hot) pages while rarely accessed (cold)
 	  pages reclaimed first under memory pressure.
 
+config DAMON_STAT
+	bool "Build data access monitoring stat (DAMON_STAT)"
+	depends on DAMON_PADDR
+	help
+	  This builds the DAMON-based access monitoring statistics subsystem.
+	  It runs DAMON and expose access monitoring results in simple stat
+	  metrics.
+
+config DAMON_STAT_ENABLED_DEFAULT
+	bool "Enable DAMON_STAT by default"
+	depends on DAMON_PADDR
+	default DAMON_STAT
+	help
+	  Whether to enable DAMON_STAT by default.  Users can disable it in
+	  boot or runtime using its 'enabled' parameter.
+
 endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 8b49012ba8c3..d8d6bf5f8bff 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
+obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
new file mode 100644
index 000000000000..852848ce844e
--- /dev/null
+++ b/mm/damon/stat.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shows data access monitoring resutls in simple metrics.
+ */
+
+#define pr_fmt(fmt) "damon-stat: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sort.h>
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_stat."
+
+static int damon_stat_enabled_store(
+		const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops enabled_param_ops = {
+	.set = damon_stat_enabled_store,
+	.get = param_get_bool,
+};
+
+static bool enabled __read_mostly = CONFIG_DAMON_STAT_ENABLED_DEFAULT;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
+
+static struct damon_ctx *damon_stat_context;
+
+static struct damon_ctx *damon_stat_build_ctx(void)
+{
+	struct damon_ctx *ctx;
+	struct damon_attrs attrs;
+	struct damon_target *target;
+	unsigned long start = 0, end = 0;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return NULL;
+	attrs = (struct damon_attrs) {
+		.sample_interval = 5 * USEC_PER_MSEC,
+		.aggr_interval = 100 * USEC_PER_MSEC,
+		.ops_update_interval = 60 * USEC_PER_MSEC * MSEC_PER_SEC,
+		.min_nr_regions = 10,
+		.max_nr_regions = 1000,
+	};
+	/*
+	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
+	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
+	 */
+	attrs.intervals_goal = (struct damon_intervals_goal) {
+		.access_bp = 400, .aggrs = 3,
+		.min_sample_us = 5000, .max_sample_us = 10000000,
+	};
+	if (damon_set_attrs(ctx, &attrs))
+		goto free_out;
+
+	/*
+	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
+	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
+	 */
+	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
+		.access_bp = 400, .aggrs = 3,
+		.min_sample_us = 5000, .max_sample_us = 10000000,
+	};
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
+		goto free_out;
+
+	target = damon_new_target();
+	if (!target)
+		goto free_out;
+	damon_add_target(ctx, target);
+	if (damon_set_region_biggest_system_ram_default(target, &start, &end))
+		goto free_out;
+	return ctx;
+free_out:
+	damon_destroy_ctx(ctx);
+	return NULL;
+}
+
+static int damon_stat_start(void)
+{
+	damon_stat_context = damon_stat_build_ctx();
+	if (!damon_stat_context)
+		return -ENOMEM;
+	return damon_start(&damon_stat_context, 1, true);
+}
+
+static void damon_stat_stop(void)
+{
+	damon_stop(&damon_stat_context, 1);
+	damon_destroy_ctx(damon_stat_context);
+}
+
+static bool damon_stat_init_called;
+
+static int damon_stat_enabled_store(
+		const char *val, const struct kernel_param *kp)
+{
+	bool is_enabled = enabled;
+	int err;
+
+	err = kstrtobool(val, &enabled);
+	if (err)
+		return err;
+
+	if (is_enabled == enabled)
+		return 0;
+
+	if (!damon_stat_init_called)
+		/*
+		 * probably called from command line parsing (parse_args()).
+		 * Cannot call damon_new_ctx().  Let damon_stat_init() handle.
+		 */
+		return 0;
+
+	if (enabled)
+		return damon_stat_start();
+	damon_stat_stop();
+	return 0;
+}
+
+static int __init damon_stat_init(void)
+{
+	int err = 0;
+
+	damon_stat_init_called = true;
+
+	/* probably set via command line */
+	if (enabled)
+		err = damon_stat_start();
+	return err;
+}
+
+module_init(damon_stat_init);
-- 
2.39.5
