Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36823236F;
	Tue, 10 Dec 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867438; cv=none; b=O+KKHvr+ROH1sCEzs051mR7nLS/Y9tchbEyuNn3JtizkNP6fk1f73WAkRmbKsDs3kHQX02EUqihNoIzYPCfbEtfTXQdNncfJBLZVsvP+Oc5XpE3LdBzEsDp6gUMo2dQU6VuZkMbwGXY6t1eHPRepN76+ffB4gFbEh8sggxVbFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867438; c=relaxed/simple;
	bh=jB3IdYIaZt6diKe0C9b6i8dd46f2ua9DxU6E12pOiyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQgSCvTmodjOvf99LeWY18zzJYCmJjyFhXX3NdIBomegtBT6BsezMGYgKwkBcNr3oWtmeFOC7EnS5Z6iaM03rnrS4NuK+NoCg40W6hO+FlGtMceTHQan+11LuCuGg5KJWLt/XWRdeTBVIUssdPbCZkH9gHEz3kh7sf7xXmPKD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNReYWYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNReYWYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3A2C4CED6;
	Tue, 10 Dec 2024 21:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733867437;
	bh=jB3IdYIaZt6diKe0C9b6i8dd46f2ua9DxU6E12pOiyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNReYWYc6t6JPmtGOCpuSkxP8a/ufQVYtC4vVsoaWJcdcEW212jts0kBclf3jFszr
	 /2HuzNHpYAKsjcWYBlwteMlCTwfTjIPQ/6eMmgV9mY0VDr9tUnjS2qN1j3s9ZLyUQZ
	 LbGnkrxvhaEEwpVPIoYqJAAW4/PPNpzvCy9qE2dDzxeFJy8eWHOYBjbJZXUx9tM6JK
	 giskQ8rX1qZ9t+Z+NliBXXK4Kj0eEZldVkxlzG99L1q8zQGoUFxgXXWxxLa5N2nXr7
	 cV+rSMecRabVS0IS9Yz7u/yPNemmi4qLGKSdcQpiolcQk6Lr5rxeqpGEnCPK5m3x/J
	 WDvC2woiHovbA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/5] samples: add a skeleton of a sample DAMON module for working set size estimation
Date: Tue, 10 Dec 2024 13:50:26 -0800
Message-Id: <20241210215030.85675-2-sj@kernel.org>
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

Add a skeleton for a sample DAMON static module that can be used for
estimating working set size of a given process.  Note that it is a
static module since DAMON is not exporting symbols to loadable modules
for now.  It exposes two module parameters, namely 'pid' and 'enable'.
'pid' will specify the process that the module will estimate the working
set size of.  'enable' will receive whether to start or stop the
estimation.  Because this is just a skeleton, the parameters do nothing,
though.  The functionalities will be implemented by following commits.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS            |  1 +
 samples/Kconfig        |  2 ++
 samples/Makefile       |  1 +
 samples/damon/Kconfig  | 17 +++++++++++
 samples/damon/Makefile |  3 ++
 samples/damon/wsse.c   | 65 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/wsse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..68d825a4c69c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6328,6 +6328,7 @@ F:	Documentation/mm/damon/
 F:	include/linux/damon.h
 F:	include/trace/events/damon.h
 F:	mm/damon/
+F:	samples/damon/
 F:	tools/testing/selftests/damon/
 
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..8d5a36f0e5d6 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -293,6 +293,8 @@ config SAMPLE_CGROUP
 
 source "samples/rust/Kconfig"
 
+source "samples/damon/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..726bb5293486 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
new file mode 100644
index 000000000000..b799e01345c8
--- /dev/null
+++ b/samples/damon/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "DAMON Samples"
+
+config SAMPLE_DAMON_WSSE
+	bool "DAMON sameple module for working set size estimation"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This builds DAMON sample module for working set size estimation.
+
+	  The module receives a pid, monitor access to the virtual address
+	  space of the process, estimate working set size of the process, and
+	  repeatedly prints the size on the kernel log.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
new file mode 100644
index 000000000000..ccbe93d40130
--- /dev/null
+++ b/samples/damon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
new file mode 100644
index 000000000000..7f2cb76a1a70
--- /dev/null
+++ b/samples/damon/wsse.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * working set size estimation: monitor access pattern of given process and
+ * print estimated working set size (total size of regions that showing some
+ * access).
+ */
+
+#define pr_fmt(fmt) "damon_sample_wsse: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static int target_pid __read_mostly;
+module_param(target_pid, int, 0600);
+
+static int damon_sample_wsse_enable_store(
+		const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops enable_param_ops = {
+	.set = damon_sample_wsse_enable_store,
+	.get = param_get_bool,
+};
+
+static bool enable __read_mostly;
+module_param_cb(enable, &enable_param_ops, &enable, 0600);
+MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
+
+static int damon_sample_wsse_start(void)
+{
+	pr_info("start\n");
+	return 0;
+}
+
+static void damon_sample_wsse_stop(void)
+{
+	pr_info("stop\n");
+}
+
+static int damon_sample_wsse_enable_store(
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
+		return damon_sample_wsse_start();
+	damon_sample_wsse_stop();
+	return 0;
+}
+
+static int __init damon_sample_wsse_init(void)
+{
+	return 0;
+}
+
+module_init(damon_sample_wsse_init);
-- 
2.39.5

