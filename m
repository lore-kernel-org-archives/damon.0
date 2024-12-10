Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB123A59F;
	Tue, 10 Dec 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867441; cv=none; b=PUG0aSmb8Z104G9MicybpM+z8VKx/9s1cjOkuYzfmcYtMjfKRU914w0tzBX/9ZRw8doACnSS4bU8OgmJX/pRrG/utlf+9RiGYA4cKPKuqMyaIiq+vdrqmYjxs1TS56eeaUNCbYplWqrTPerdkApKEYM1wCb0oBft7A3JQA41erA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867441; c=relaxed/simple;
	bh=7FEsy6E4p0WwhU+DV5aMiawHvgrRCnoGLK5GZ2jkVJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnLAaOS0g2kN+FqtOhkgHeSVu55L5RySWRTCD/PPleuSc9i3+YV2LqzEAhetmCqFkoHT1brQ63XJMpwFQoOvIpatwUg/Gt7D831rgyZV5mHtw/2Xp1rzmLmcMTmB2alwPQdysgMCyVFdFFJobq8rVH1LthOjvkESwxXf6NB/mD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D15Zzayf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D15Zzayf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865A5C4CED6;
	Tue, 10 Dec 2024 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733867440;
	bh=7FEsy6E4p0WwhU+DV5aMiawHvgrRCnoGLK5GZ2jkVJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D15ZzayfcegIah0G2/GjTG3mOixo+knKcaGLxl3qTlHsz1ye8cAFdYef2OgA7Rjxy
	 qswkyU7NMOc8lTa3B/lHqiAgrX6D3M7EQufPx/+1d/5nbdYJv4l/GRAPsU7NiC9DOG
	 65rq7/frDYJQg/agSTFvwoVtW9Yhx2karjpOzP2pqUZmK16YJa4pJisysczCaeNSmH
	 VBoCynKIjHOGkTzVHPEgFJk+xwsaq0+e1QyD/L84EOYQYaxLXXJc/onZ6cRbajfejQ
	 AkfpJgJLBm+4ZIc03oL6MQIeHOXMSgDkvtgAWI2Uodunac0jT/9OhQ02S/0SOdDLIU
	 /mlgSJMIdkKAA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/5] samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation
Date: Tue, 10 Dec 2024 13:50:29 -0800
Message-Id: <20241210215030.85675-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210215030.85675-1-sj@kernel.org>
References: <20241210215030.85675-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON is not only for monitoring of access patterns, but also for
access-aware system operations.  For the system operations, DAMON
provides a feature called DAMOS (Data Access Monitoring-based Operation
Schemes).  There is no sample API usage of DAMOS, though.  Copy the
working set size estimation sample modules with changed names of the
module and symbols, to use it as a skeleton for a sample module showing
the DAMOS API usage.  The following commit will make it proactively
reclaim cold memory of the given process, using DAMOS.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/Makefile       |   1 +
 samples/damon/Kconfig  |  13 +++++
 samples/damon/Makefile |   1 +
 samples/damon/prcl.c   | 116 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 samples/damon/prcl.c

diff --git a/samples/Makefile b/samples/Makefile
index 726bb5293486..5af6bb8afb07 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
+obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index b799e01345c8..63f6dcd71daa 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -14,4 +14,17 @@ config SAMPLE_DAMON_WSSE
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_PRCL
+	bool "DAMON sameple module for access-aware proactive reclamation"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This builds DAMON sample module for access-aware proactive
+	  reclamation.
+
+	  The module receives a pid, monitor access to the virtual address
+	  space of the process, find memory regions that not accessed, and
+	  proactively reclaim the regions.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index ccbe93d40130..7f155143f237 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
+obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
new file mode 100644
index 000000000000..b34b9bfed532
--- /dev/null
+++ b/samples/damon/prcl.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * proactive reclamation: monitor access pattern of a given process, find
+ * regiosn that seems not accessed, and proactively page out the regions.
+ */
+
+#define pr_fmt(fmt) "damon_sample_prcl: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static int target_pid __read_mostly;
+module_param(target_pid, int, 0600);
+
+static int damon_sample_prcl_enable_store(
+		const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops enable_param_ops = {
+	.set = damon_sample_prcl_enable_store,
+	.get = param_get_bool,
+};
+
+static bool enable __read_mostly;
+module_param_cb(enable, &enable_param_ops, &enable, 0600);
+MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_WSSE");
+
+static struct damon_ctx *ctx;
+static struct pid *target_pidp;
+
+static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+		unsigned long wss = 0;
+
+		damon_for_each_region(r, t) {
+			if (r->nr_accesses > 0)
+				wss += r->ar.end - r->ar.start;
+		}
+		pr_info("wss: %lu\n", wss);
+	}
+	return 0;
+}
+
+static int damon_sample_prcl_start(void)
+{
+	struct damon_target *target;
+
+	pr_info("start\n");
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
+	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
+
+	return damon_start(&ctx, 1, true);
+}
+
+static void damon_sample_prcl_stop(void)
+{
+	pr_info("stop\n");
+	if (ctx) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	if (target_pidp)
+		put_pid(target_pidp);
+}
+
+static int damon_sample_prcl_enable_store(
+		const char *val, const struct kernel_param *kp)
+{
+	bool enabled = enable;
+	int err;
+
+	err = kstrtobool(val, &enable);
+	if (err)
+		return err;
+
+	if (enable == enabled)
+		return 0;
+
+	if (enable)
+		return damon_sample_prcl_start();
+	damon_sample_prcl_stop();
+	return 0;
+}
+
+static int __init damon_sample_prcl_init(void)
+{
+	return 0;
+}
+
+module_init(damon_sample_prcl_init);
-- 
2.39.5

