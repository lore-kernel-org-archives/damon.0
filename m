Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A738F92D
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970910; cv=none; b=Mp/CnyLm68GeIAYQgg8cTYU7gFodJXpC9MRme2G6QF0OOhLgu5PQ95i6Le/tJIdkkMURCRCPGNfL2KU5NSIt7hr1nGBTrtucgTZcysguNiERQIWArFpFnhfRfBoCk/e6700UGDGPdqqNbYBSRxVgZRDqJ1WV6eVxPloMK5B1Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970910; c=relaxed/simple;
	bh=C1VJDWaTu/84/0Jx2DjeM70yxTyztJpxfgkG+Kg0D4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RK58951hrSJGUo2NAW3SahAxCVEoO10GyVTu1gQKWYmJku1YAN0wsiRNibXeWw3yONcJLEzJdT3gkptXDMHsCLZZOzdo9ScXxAzeggFjfGdi83t3XXSpAijnJ0b3xHxRXDYv7kuUy5kMTIA1T/DXW8yrBoKx80/py9gJsSdUX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQF8XlLM; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQF8XlLM"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7c2fa14795aso4559947b3.1
        for <damon@lists.linux.dev>; Sat, 16 May 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970897; x=1779575697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvMZysC8itbbidjyAgiRDox5/pyQFwV2BMVhnr5sBjw=;
        b=MQF8XlLM7LozB9O2PIV5bvLw7seD517oLOyWI/+qkLsLSU/qgJ3wWdr8foT6Pvcr4b
         arYqhUh5iMYiHHeglskDG+6otZTYzB2qtNuwFvpJqcp0KdoPfu3OxPnd2vFVGJpaXXAf
         EOMyqtASMlGG4aXRPh9kjBVY69riRfJU/9QiQJTjcuWSSGhUIk4HItrd/ZHq390ojBRK
         bmELP3E0WrqnhrvX9GDjLe28Q9G+qaiUdt3j09/2a3i+epDZ/1QHCUki501/gLl7BPG5
         WK0GcXg9EnaZk4OsD0komhBcOajvNlmuEGWJC19AGvVE/XlzsNCOpm2iYY4Cy2JbrV12
         n+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970897; x=1779575697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvMZysC8itbbidjyAgiRDox5/pyQFwV2BMVhnr5sBjw=;
        b=RTa2ottYWssLb091e6J1DgZCd3rzKiHxJWijohTM+FxSx8FFraqwfn78y7sKXE07Km
         9aYGuvCV+apuXBr6ssb1zSMCoi5mz7EYKJiFOydwit0ALILzcOE/f7bM1E4XIcR3ywoe
         0YLUT+3xE8i/xfDKQgU0ZMuQpeMy06N4WnNQNteHNdC5vt/a8MfVUtYIpkzmZVj9M53H
         UGQjBY7279MbJ5JETCP9MdGrcHbG+OFtTmfq1XQWprDsocevyWXlBBu9ufufJ8HG7X4o
         H29h60h8AS09NpK4LUVKwwHx1zEMXAhFwHTRvaiMo+uc6RtpmC4rxUKqCjwWMb9s4Ji8
         cvmA==
X-Forwarded-Encrypted: i=1; AFNElJ9rBdELnqUQHsXTl2kOgGxbFEvohp344v7Me7BUYjIDubqjRWz8+eM2XuBQrJipZGbcnamlgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFMH/cHqM6bAAGBFHAwDsGEXkNuKZJ00a9uwPXwLx5KJg4L66u
	eo8PbjoMrJDLkSBuLljfc/p4AzqiKeAEwrCcKD0hduu36HBNJvLm5Yw=
X-Gm-Gg: Acq92OFg6nMmiQvtoenfA9bT5ubuFh+SM+av0uEeLBd1FPb6HOpELd1HNkvEIAVCtbJ
	Rm4pRdzDiavj8RyPWfYT54XlnzKpwKD4key0yJSIgHWpY+bnTTlJp0rX3FgBKNJyGw0cIOL3B1p
	txfEOcO6CjpX+0EMHkIdT8DhZn78w8DY2yPZYxdaBAW8pKSRlvpUf8EIlCZcy3Gvo5QDfPbDXIn
	GXcw4yGZF19Uuc6bXLg4GswYg7pl9R3PoMgQf+Rof/thQcADvwbBSq+vsXJFuolN3ezgY9XSORI
	nrWtFkXXsfXO3TSQxh/tz36LrNNp7z+GbCRbDr5dwhMoPRVFoAz/uA9v+H8d9xz+kIBlhgtoQW+
	8NjZvVIMaHcp9uvzyaE2N+p+/8CgqXqwNn0TRHjB6NSXx4sr0RXueji+Uj2VrYNhhTaNulUMBaH
	f8iRKprE9+N0SLsh+qu0nnep1r/EImj3L3WK1oObGrAwpqmXKaMztJdd91M7hFSL9m+CbevnKlx
	A==
X-Received: by 2002:a05:690c:c364:b0:7c0:de77:f466 with SMTP id 00721157ae682-7c9594b3711mr86084717b3.2.1778970896587;
        Sat, 16 May 2026 15:34:56 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0db09sm690837b3.27.2026.05.16.15.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:34:56 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com,
	bharata@amd.com
Subject: [RFC PATCH 7/7] mm/damon/damon_ibs: add AMD IBS-based access sampling backend
Date: Sat, 16 May 2026 15:34:32 -0700
Message-ID: <20260516223439.4033-8-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516223439.4033-1-ravis.opensrc@gmail.com>
References: <20260516223439.4033-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add paddr_ibs operations using AMD IBS Op sampling via
perf_event_create_kernel_counter().  IBS delivers physical-address-
keyed access reports to DAMON's shared-layer ring buffer
(damon_report_access()), without dependency on PTE Accessed-bit
scanning or page faults.

Per-CPU IBS events are created and torn down via cpuhp notifiers
(CPUHP_AP_ONLINE_DYN).  Routing of access reports through the ring-
drain path is bound to ops.id == DAMON_OPS_PADDR_IBS at the dispatch
site (see "mm/damon: add sysfs binding and dispatch hookup for
paddr_ibs operations"), so .init does not need to flip a per-context
flag.

Sample-time discipline:
  - PERF_SAMPLE_PHYS_ADDR is requested in attr.sample_type, but the
    IBS perf driver only fills data->phys_addr when
    IBS_OP_DATA3.dc_phy_addr_valid is set.  Skip stale-PA samples by
    inspecting data->sample_flags rather than testing phys_addr for
    zero (which would also drop legitimate page 0).
  - PERF_SAMPLE_DATA_SRC is requested so the perf driver decodes
    IBS_OP_DATA3.{ld_op,st_op} into data->data_src.mem_op; the
    backend reports load vs store accordingly via
    damon_access_report.is_write.

Module parameters:
  - max_cnt: IBS Op MaxCnt (writable; writes call
    damon_ibs_set_sample_rate() to restart sampling at the new rate)
  - samples_total / samples_filtered: per-CPU-aggregated counters
    (read-only)

Source file is mm/damon/damon_ibs.c (renamed from mm/damon/ibs.c) so
the resulting module is loaded as damon_ibs.ko, avoiding the generic
"ibs" namespace.

The IBS sampling approach is derived from Bharata B Rao's pghot RFC v5
series; the attribution header is in damon_ibs.c.

Suggested-by: Bharata B Rao <bharata@amd.com>
Link: https://lore.kernel.org/linux-mm/20260129144043.231636-1-bharata@amd.com/
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/Kconfig     |  10 ++
 mm/damon/Makefile    |   1 +
 mm/damon/damon_ibs.c | 369 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+)
 create mode 100644 mm/damon/damon_ibs.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index ad629f0f31d8d..bb698d2717f34 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -131,4 +131,14 @@ config DAMON_ACMA
 	  min/max memory for the system and maximum memory pressure stall time
 	  ratio.
 
+config DAMON_IBS
+	tristate "AMD IBS-based access sampling for DAMON"
+	depends on DAMON_PADDR && CPU_SUP_AMD && X86_64 && PERF_EVENTS
+	help
+	  Uses AMD IBS (Instruction-Based Sampling) hardware to deliver
+	  physical-address-keyed access reports to DAMON's shared-layer
+	  ring buffer, without relying on PTE Accessed-bit scanning or
+	  page faults.  Registers as the "paddr_ibs" operations set.
+	  Requires AMD processors with IBS Op support.
+
 endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 22494754f41e8..109d0fb1db97d 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
 obj-$(CONFIG_DAMON_ACMA)	+= modules-common.o acma.o
+obj-$(CONFIG_DAMON_IBS)		+= damon_ibs.o
diff --git a/mm/damon/damon_ibs.c b/mm/damon/damon_ibs.c
new file mode 100644
index 0000000000000..1dd99e91c3928
--- /dev/null
+++ b/mm/damon/damon_ibs.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON IBS (Instruction-Based Sampling) backend for AMD processors.
+ *
+ * Uses AMD IBS Op sampling via the perf kernel counter infrastructure to
+ * deliver PA-keyed access reports to DAMON's shared-layer ring buffer
+ * (see damon_report_access()).  This enables physical-address hot-page
+ * detection without relying on page-table Accessed bits or page faults.
+ *
+ * The IBS sampling approach in this file derives from concepts in
+ * Bharata B Rao's pghot RFC v5 series for hot page tracking.
+ * See: https://lore.kernel.org/linux-mm/20260129144043.231636-1-bharata@amd.com/
+ *
+ * Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
+ */
+
+#include <linux/cpu.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <linux/damon.h>
+#include "ops-common.h"
+
+#define DAMON_IBS_DEFAULT_MAX_CNT	262144	/* ~4K samples/sec/core */
+#define IBS_OP_PMU_TYPE_PATH	"/sys/bus/event_source/devices/ibs_op/type"
+
+static unsigned int damon_ibs_max_cnt = DAMON_IBS_DEFAULT_MAX_CNT;
+
+static int damon_ibs_set_sample_rate(unsigned int max_cnt);
+
+static int max_cnt_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int new_cnt;
+	int ret;
+
+	ret = kstrtouint(val, 0, &new_cnt);
+	if (ret)
+		return ret;
+	if (!new_cnt)
+		return -EINVAL;
+	return damon_ibs_set_sample_rate(new_cnt);
+}
+static const struct kernel_param_ops max_cnt_ops = {
+	.set = max_cnt_set,
+	.get = param_get_uint,
+};
+module_param_cb(max_cnt, &max_cnt_ops, &damon_ibs_max_cnt, 0644);
+MODULE_PARM_DESC(max_cnt,
+	"IBS MaxCnt (ops between samples). Writes restart sampling.");
+
+static DEFINE_MUTEX(damon_ibs_lock);
+static bool damon_ibs_enabled;
+static enum cpuhp_state damon_ibs_cpuhp_state;
+static unsigned int ibs_pmu_type;	/* discovered at init */
+
+static DEFINE_PER_CPU(struct perf_event *, damon_ibs_event);
+
+/*
+ * Diagnostic counters.  Incremented from NMI context, so use per-CPU
+ * counters and sum them on read.
+ */
+static DEFINE_PER_CPU(unsigned long, ibs_samples_total_pcpu);
+static DEFINE_PER_CPU(unsigned long, ibs_samples_filtered_pcpu);
+
+static unsigned long damon_ibs_sum_pcpu(unsigned long __percpu *var)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		sum += per_cpu(*var, cpu);
+	return sum;
+}
+
+static int samples_total_get(char *buffer, const struct kernel_param *kp)
+{
+	return sysfs_emit(buffer, "%lu\n",
+			damon_ibs_sum_pcpu(&ibs_samples_total_pcpu));
+}
+
+static int samples_filtered_get(char *buffer, const struct kernel_param *kp)
+{
+	return sysfs_emit(buffer, "%lu\n",
+			damon_ibs_sum_pcpu(&ibs_samples_filtered_pcpu));
+}
+
+static const struct kernel_param_ops samples_total_ops = {
+	.get = samples_total_get,
+};
+static const struct kernel_param_ops samples_filtered_ops = {
+	.get = samples_filtered_get,
+};
+
+module_param_cb(samples_total, &samples_total_ops, NULL, 0444);
+MODULE_PARM_DESC(samples_total, "Total IBS samples delivered (read-only)");
+module_param_cb(samples_filtered, &samples_filtered_ops, NULL, 0444);
+MODULE_PARM_DESC(samples_filtered, "IBS samples filtered out (read-only)");
+
+/**
+ * damon_ibs_overflow_handler() - IBS overflow callback.
+ *
+ * Called when an IBS Op counter overflows.  The IBS perf driver fills
+ * data->phys_addr from IBSDCPHYSAD when dc_phy_addr_valid is set.
+ *
+ * Context: NMI — no sleeping, no mutex, no kmalloc.
+ */
+static void damon_ibs_overflow_handler(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
+{
+	struct damon_access_report report;
+	unsigned long phys_addr;
+
+	if (!data)
+		return;
+
+	/*
+	 * PERF_SAMPLE_PHYS_ADDR was requested in attr.sample_type, but
+	 * the IBS perf driver only populates data->phys_addr when
+	 * IBS_OP_DATA3.dc_phy_addr_valid is set.  Skip stale-PA samples
+	 * by checking the sample_flags rather than testing phys_addr
+	 * for zero (which would also drop legitimate page 0).
+	 */
+	if (!(data->sample_flags & PERF_SAMPLE_PHYS_ADDR)) {
+		this_cpu_inc(ibs_samples_filtered_pcpu);
+		return;
+	}
+	phys_addr = data->phys_addr;
+
+	report = (struct damon_access_report){
+		.paddr = phys_addr & PAGE_MASK,
+		.size = PAGE_SIZE,
+		.cpu = smp_processor_id(),
+		.is_write = !!(data->data_src.mem_op & PERF_MEM_OP_STORE),
+	};
+	damon_report_access(&report);
+	this_cpu_inc(ibs_samples_total_pcpu);
+}
+
+static int damon_ibs_create_event(int cpu)
+{
+	struct perf_event_attr attr = {
+		.type = ibs_pmu_type,
+		.size = sizeof(attr),
+		/* config=0: IBS perf driver uses sample_period as MaxCnt. */
+		.config = 0,
+		.sample_period = damon_ibs_max_cnt,
+		.sample_type = PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_SRC,
+		.pinned = 1,
+	};
+	struct perf_event *event;
+
+	event = perf_event_create_kernel_counter(&attr, cpu, NULL,
+						 damon_ibs_overflow_handler,
+						 NULL);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	/*
+	 * perf_event_create_kernel_counter() returns the event already
+	 * enabled; no perf_event_enable() needed here.
+	 */
+	per_cpu(damon_ibs_event, cpu) = event;
+	return 0;
+}
+
+static void damon_ibs_destroy_event(int cpu)
+{
+	struct perf_event *event = per_cpu(damon_ibs_event, cpu);
+
+	if (!event)
+		return;
+
+	perf_event_disable(event);
+	perf_event_release_kernel(event);
+	per_cpu(damon_ibs_event, cpu) = NULL;
+}
+
+static int damon_ibs_cpu_online(unsigned int cpu)
+{
+	int ret = damon_ibs_create_event(cpu);
+
+	if (ret)
+		pr_warn_ratelimited(
+			"damon-ibs: failed to create perf_event on cpu %u (err %d); "
+			"this cpu will not contribute samples\n", cpu, ret);
+	return 0;	/* never block CPU online */
+}
+
+static int damon_ibs_cpu_offline(unsigned int cpu)
+{
+	damon_ibs_destroy_event(cpu);
+	return 0;
+}
+
+/* Caller must hold damon_ibs_lock. */
+static int __damon_ibs_start(void)
+{
+	int ret;
+
+	if (damon_ibs_enabled)
+		return -EBUSY;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "damon/ibs:online",
+				damon_ibs_cpu_online, damon_ibs_cpu_offline);
+	if (ret < 0)
+		return ret;
+	damon_ibs_cpuhp_state = ret;
+
+	damon_ibs_enabled = true;
+	pr_info_once("damon-ibs: first start (max_cnt=%u, pmu_type=%u)\n",
+		     damon_ibs_max_cnt, ibs_pmu_type);
+	return 0;
+}
+
+/* Caller must hold damon_ibs_lock. */
+static void __damon_ibs_stop(void)
+{
+	if (!damon_ibs_enabled)
+		return;
+
+	cpuhp_remove_state(damon_ibs_cpuhp_state);
+	damon_ibs_enabled = false;
+}
+
+static int damon_ibs_start(void)
+{
+	int ret;
+
+	mutex_lock(&damon_ibs_lock);
+	ret = __damon_ibs_start();
+	mutex_unlock(&damon_ibs_lock);
+	return ret;
+}
+
+static void damon_ibs_stop(void)
+{
+	mutex_lock(&damon_ibs_lock);
+	__damon_ibs_stop();
+	mutex_unlock(&damon_ibs_lock);
+}
+
+/**
+ * damon_ibs_set_sample_rate() - Set IBS sampling interval.
+ * @max_cnt: IBS Op MaxCnt value (ops between samples).
+ *           Higher = fewer samples/sec.
+ *
+ * If IBS is already running, restart it with the new rate.
+ *
+ * Return: 0 on success; if a restart was required and failed,
+ * propagate the error so callers (e.g. the max_cnt module-param
+ * .set callback) surface it to userspace instead of silently
+ * leaving sampling stopped.
+ */
+static int damon_ibs_set_sample_rate(unsigned int max_cnt)
+{
+	int ret = 0;
+
+	mutex_lock(&damon_ibs_lock);
+	damon_ibs_max_cnt = max_cnt ? max_cnt : DAMON_IBS_DEFAULT_MAX_CNT;
+
+	if (damon_ibs_enabled) {
+		__damon_ibs_stop();
+		ret = __damon_ibs_start();
+		if (ret)
+			pr_warn("damon-ibs: restart failed: %d\n", ret);
+	}
+	mutex_unlock(&damon_ibs_lock);
+	return ret;
+}
+
+
+static void damon_ibs_init_ctx(struct damon_ctx *ctx)
+{
+	int ret;
+
+	/* IBS is the access-detection source for this ctx. */
+	ctx->sample_control.primitives_enabled.page_table = false;
+
+	ret = damon_ibs_start();
+	if (ret && ret != -EBUSY)
+		pr_warn("damon-ibs: failed to start IBS sampling: %d\n", ret);
+}
+
+/**
+ * damon_ibs_discover_pmu_type() - Discover IBS Op PMU type from sysfs.
+ *
+ * Reads /sys/bus/event_source/devices/ibs_op/type to get the PMU type
+ * identifier needed for perf_event_attr.type.
+ *
+ * TODO: replace sysfs-read with a PMU lookup API when one becomes
+ * available.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int damon_ibs_discover_pmu_type(void)
+{
+	struct file *f;
+	char buf[16];
+	loff_t pos = 0;
+	ssize_t len;
+	int ret;
+
+	f = filp_open(IBS_OP_PMU_TYPE_PATH, O_RDONLY, 0);
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+
+	len = kernel_read(f, buf, sizeof(buf) - 1, &pos);
+	filp_close(f, NULL);
+	if (len <= 0)
+		return -EIO;
+
+	buf[len] = '\0';
+	ret = kstrtouint(strim(buf), 10, &ibs_pmu_type);
+	if (ret)
+		return ret;
+
+	pr_info("damon-ibs: discovered ibs_op PMU type=%u\n", ibs_pmu_type);
+	return 0;
+}
+
+static int __init damon_ibs_init(void)
+{
+	struct damon_operations ops = {
+		.id = DAMON_OPS_PADDR_IBS,
+		.owner = THIS_MODULE,
+		.init = damon_ibs_init_ctx,
+		.prepare_access_checks = damon_pa_prepare_access_checks,
+		.check_accesses = damon_pa_check_accesses,
+		.apply_probes = damon_pa_apply_probes,
+		.apply_scheme = damon_pa_apply_scheme,
+		.get_scheme_score = damon_pa_scheme_score,
+	};
+	int err;
+
+	if (!boot_cpu_has(X86_FEATURE_IBS))
+		return -ENODEV;
+
+	err = damon_ibs_discover_pmu_type();
+	if (err) {
+		pr_err("damon-ibs: failed to discover IBS PMU type: %d\n", err);
+		return err;
+	}
+
+	err = damon_register_ops(&ops);
+	if (err)
+		return err;
+
+	pr_info("damon-ibs: AMD IBS backend registered (max_cnt=%u, pmu_type=%u)\n",
+		damon_ibs_max_cnt, ibs_pmu_type);
+	return 0;
+}
+
+static void __exit damon_ibs_exit(void)
+{
+	damon_ibs_stop();
+	damon_unregister_ops(DAMON_OPS_PADDR_IBS);
+}
+
+module_init(damon_ibs_init);
+module_exit(damon_ibs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ravi Jonnalagadda <ravis.opensrc@gmail.com>");
+MODULE_DESCRIPTION("AMD IBS-based access sampling backend for DAMON");
-- 
2.43.0

