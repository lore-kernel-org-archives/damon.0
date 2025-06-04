Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E84202C2B;
	Wed,  4 Jun 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061894; cv=none; b=qQLrDxtPo10ImyUgtVILqTxVZVIy8DRToC+bFEuB8xx11iS1cE+W4o977mZhSt4uscIws9q8Q3iJzeqrnpa3m4IaKb+rCS/4WXQUa9+eX0aX+23lg1ruxyEXwXFs6boc6Cdf/xoNh/slrVQmjxHrrNnLmVZ/P4zl2Q4dvGLytn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061894; c=relaxed/simple;
	bh=hKn9MHEuhQIYyoRWDiRwIxmlR7BH2F01294Qax+v28s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMEBQw3j97VIiv2w8OqyxIa62LBoPNZ6x4TgniA/qNnwOT1ZrrXXw2DdHiQlZ7HUJxSy4ef++3L3eWHh1Oz/nitS4ag4VdK81I8nPyRPYxZTgWX+Kvw3GAzkDndTItYohLhubg3PHmuNP2H2WzZUxEOHU3Q7FKH9Fz/d8kW8QU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU3vznkD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU3vznkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67576C4CEED;
	Wed,  4 Jun 2025 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749061892;
	bh=hKn9MHEuhQIYyoRWDiRwIxmlR7BH2F01294Qax+v28s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hU3vznkDCsNTeiF+uurCkOF/Jd/lXzFOOJY034BGjIMGUmUDh1c7xklG+SWZvbrS4
	 KrYbKwaSKN2gRU4v5FWl+yiw2BwS2abIiJRgnKEBALsi5ZGEhilfnuhalzTpnVHmYu
	 8LhRNMd86nbzoltzqWuQs1/4Y15tekwwLAVU8cKWcu9UZj6HRSZ749dpaNkN4Ekjti
	 Jt5mNtzh7WTmh3nccAbgKJLNukfQw4VjfzidGnULjHAgOlnP5iBnO9c1ol/IKYG5w1
	 qRkNsVYkXvfA6+Unw/lUNFozFW4fDthKtdU97fJJfxe3EnqyLR6Q5OHcKK3DoNh+Wd
	 xKuDIlfCNOhzw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/4] mm/damon: introduce DAMON_STAT module
Date: Wed,  4 Jun 2025 11:31:24 -0700
Message-Id: <20250604183127.13968-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604183127.13968-1-sj@kernel.org>
References: <20250604183127.13968-1-sj@kernel.org>
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
