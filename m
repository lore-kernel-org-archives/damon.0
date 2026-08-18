Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE43E3176
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033454; cv=none; b=saq6xXtPz+jnEk5MfcIAYs7V5fMU+nNOHSOXVUX66wKiz/l0YbiCPiNzT996zD4SH+OpLYQo/GlDuePo6mgsbfGXqyB0SvgPFX8ChSeGLZw3Lx7+u/A4lWm4ticQsnU4qgYOJdmN3yQUHvrQD5rdBAYwtoXLnPjMiz5uurGsbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033454; c=relaxed/simple;
	bh=J+lH5aIxoKZrtLS3G91f/QlNeqCm03+jL/fZVbeUkqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1wHnRSe1JXnSjgWr2vt19Sr/Sn8s62+L/KXvAPDHO4FnU1dOJ+yHiLxYGGL4+sOdz+huoIvALYcZPdcKjKeMgYnuqGdFG1cc911ZBIOamzC/A65smf9JXhisGsdkl1eDWXaBenG/uKr5mbZFYemOrDg5nc3TuLxzfq02sh/hFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6ppnwb0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6ppnwb0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so4766619a91.3
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033452; x=1787638252; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A673oz0E/o2MwRaOE5XvkcWpC/QdFWh299uzrbmuC70=;
        b=G6ppnwb0kLAa2g81yMBWyo517ev1uCAztm5vvkQZFRAzakCSlxA+3pWKOjsZpV/7MD
         ydJSP6UJEe4MyxSwQJ1psaruRW0g+9jC+X0GR9FmJIgsfW7jS7k+g8zvqOfYR4PIZfi1
         s1OamfXv3J3I837LUfBxmBQDGR744EQFAfy2BQepEa7JBxYiVq+c8QjVQtT1zhMVps/s
         f6ErMz3EUwEkS+03xPh3yb9VZfr/m8CYawQn7JFixip/9srQ3dFy81ZOUPq/glIIRj8e
         ZTAYiNngLdsVNRjVblFsmOOSNuXeTcr1leBrPOZs4bpbkq6lcidLWxW391cdLdHLQqMQ
         Z1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033452; x=1787638252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A673oz0E/o2MwRaOE5XvkcWpC/QdFWh299uzrbmuC70=;
        b=FfGtHfhzj+75EBp74+dALd6jVZ95vpajMw278AeEbDkyj+nImFgQFtc/wPSNGN9hV0
         EFjlGdWPbEBE+5sexsy2RK1FU8KY+9USYE6/mPT/SOFIBbf69z2NiQErLgSh6jcflWpa
         235Ne4QfPpIBUWml3PP65GcKtBfizVkiJsA5TZQ9ayT6buLKT6NDxsHCipP0qr60DYU2
         GasH7px5Ohxi3Sq133dPCPf+Fmw/1Wf/Yoj+j/sg5sHe25HD5yRgC1hF5DJLccoJ6eXe
         cCSqnXHLY8F2dbAgn1A+mc0ztYF9k+KpbhG8B9gO6Jn5iErGMPoNJAV2tSAmXjxb59Kn
         NXgw==
X-Gm-Message-State: AOJu0Yx5CMIek7Nb2Pwwid+2MjnhxDuYn0RZzjYX/zu+m+GcRDQZ5KD7
	Csms13cCRDjny2sXvM3r2szraPGQL5Yr4v7+Z+tgLyo6vsCZ/pfWklYX
X-Gm-Gg: AR+sD12UUuB+GyUwvS0ost3ZtmuB/HjT/z9r2MNk3V5a7HH913mf+pg8n2mgSHdJlGP
	X1L2ydfaryGCrQeqVs/SOYlng9RbMx/a+ddF6FpKWciau3q/0Jv4cZ6RX7k4Hswyv+mqz/JCJBR
	Xe1Mr6en8h82hNj15hgQjYRdPO6almRYhYeupb0KbuNDNI7xLJiDk/a7isda342q8Y9s2V5YLRB
	KXr8APzWYfhpRthW47lM03IqSRMONp5J1mF+wm1NPdJy5yu5Zuyf8XlslGXlsUgZg81BQRqLe/N
	ajJVMY/ZoXDF5jZFsrdo0LslI2OfSw3sy+sjsnr3h1w45gW6AyvNsX89fda3ly8ckipu2YprbKk
	dP+gbeRCMOx5H4kDSTcuEgQ1nJH5pKdfuCj11EKI/jdCB4aqxxMqvgLjq2CyAClAzlkhDklihya
	/cwo45JyU5MQw4JBJIRJUN6AplhO/NPo/YnmzqRoHIpnOX2NJ5qcFBi+8K9AiTDMK0fReVk+DC7
	EG9Z6OEh9sQ2CwwxA==
X-Received: by 2002:a17:90b:4f84:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3933bd186f4mr32421619a91.4.1787033451538;
        Mon, 17 Aug 2026 23:10:51 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:10:51 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	lianux.mm@gmail.com,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [RFC PATCH 1/7] mm/damon/perf: add observability framework with tracepoints and CONFIG switch
Date: Tue, 18 Aug 2026 14:10:25 +0800
Message-ID: <20260818061031.827057-2-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818061031.827057-1-kunwu.chan@linux.dev>
References: <20260818061031.827057-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add the observe framework headers together with the compile-time switch
that gates the whole feature: the three DAMON perf tracepoints this
series adds (guarded with CONFIG_DAMON_PERF_OBSERVE so they are not
registered when the switch is off; damon_perf_ring_overflow is provided
by the base series), the observe API declarations with static-inline
no-ops for disabled builds, the access-report contract (miss-reason
enum, report-source enum, report source field, per-event cpu_state
member), and the Kconfig and Makefile wiring.

The sample tracepoint carries what the PMU actually populated
(data->sample_flags), what was requested (perf_event->attr.
sample_type), and the execution context (process/softirq/hardirq/NMI)
in a single line, so PMU support gaps and context expectations (e.g.
IBS overflow in NMI, SPE AUX drain in process context) are verifiable
at a glance.

Every following commit in this series builds with CONFIG_DAMON_PERF_OBSERVE
both enabled and disabled.

Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/damon.h        |  44 +++++++
 include/trace/events/damon.h | 120 ++++++++++++++++++
 mm/damon/Kconfig             |  17 +++
 mm/damon/Makefile            |   1 +
 mm/damon/perf/Makefile       |   3 +
 mm/damon/perf/perf.h         | 228 +++++++++++++++++++++++++++++++++++
 6 files changed, 413 insertions(+)
 create mode 100644 mm/damon/perf/Makefile
 create mode 100644 mm/damon/perf/perf.h

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 11f1c1071b9b..c191c065b0e4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -116,6 +116,19 @@ struct damon_target {
 	bool obsolete;
 };
 
+/**
+ * enum damon_report_source - Tells which subsystem produced an access report.
+ *
+ * Ring and matching counters aggregate all sources; this enum lets callers
+ * tag reports so that tracepoints and future per-source breakdowns can
+ * distinguish NMI overflow-handler samples from
+ * page-fault hints.
+ */
+enum damon_report_source {
+	DAMON_REPORT_SRC_PERF_OVERFLOW = 0,  /* overflow_handler (IBS, PEBS) */
+	DAMON_REPORT_SRC_PAGE_FAULT,         /* damon_report_page_fault() */
+};
+
 /**
  * struct damon_access_report - Represent single access report information.
  * @paddr:		Start physical address of the accessed address range.
@@ -125,6 +138,8 @@ struct damon_target {
  * @tid:		The task id of the task that made the access.
  * @tgid:		Thread group id of the task that made the access.
  * @is_write:		Whether the access is write.
+ * @source:		Which subsystem produced this report
+ *			(enum damon_report_source).
  *
  * Any DAMON API callers that notified access events can report the information
  * to DAMON using damon_report_access().  This struct contains the reporting
@@ -138,10 +153,28 @@ struct damon_access_report {
 	pid_t tid;
 	pid_t tgid;
 	bool is_write;
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+	int source;
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
 };
 
+/*
+ * Reason codes for trace_damon_perf_report_missed.
+ *
+ * DAMON_REPORT_MISS_TGID:       tgid mismatch (pid-based monitoring,
+ *                               missed at drain-loop level before the
+ *                               per-target iteration).
+ * DAMON_REPORT_MISS_NOREGION:   binary search found no containing region.
+ * DAMON_REPORT_MISS_BOUNDARY:   address + size straddles region boundary.
+ */
+enum damon_report_miss_reason {
+	DAMON_REPORT_MISS_TGID = 1,
+	DAMON_REPORT_MISS_NOREGION = 2,
+	DAMON_REPORT_MISS_BOUNDARY = 3,
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
@@ -1027,6 +1060,17 @@ struct damon_perf_event {
 	struct hlist_node hlist_node;
 	bool init_complete;
 	bool any_cpu_failed;
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+	/*
+	 * Per-CPU lifecycle state (enum damon_perf_event_state).
+	 * Allocated lazily on the first observe_event_created(),
+	 * freed on observe_event_destroyed().  Each event tracks
+	 * its own progression through CREATED->BOUND->ENABLED,
+	 * so destroying one event does not overwrite another"s
+	 * state on the same CPU.
+	 */
+	int __percpu *cpu_state;
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 	struct damon_ctx *ctx;
 };
 
diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 877627c9a1a1..c87fbeefb85a 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -91,6 +91,126 @@ TRACE_EVENT(damon_perf_ring_overflow,
 	TP_printk("cpu=%d", __entry->cpu)
 );
 
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+/*
+ * Fires from NMI overflow handlers on every hardware sample received,
+ * before any DAMON-side filtering.  Records the raw address, full
+ * data_src (mem_op, mem_lvl, mem_snoop, mem_remote), period, and a
+ * reason code so userspace can distinguish:
+ *
+ *   0 = valid sample, queued to per-CPU ring
+ *   1 = data == NULL
+ *   2 = addr == 0 (PMU did not populate data->addr)
+ *   3 = kernel address (vaddr handler: addr >= TASK_SIZE)
+ *   4 = phys_addr not valid (paddr handler: !PERF_SAMPLE_PHYS_ADDR)
+ *
+ * data_src carries the raw union perf_mem_data_src value; use
+ * perf_mem__xxx macros to decode.
+ *
+ * sample_flags is what the PMU *actually* populated (from
+ * data->sample_flags); sample_type is what was *requested* (from
+ * perf_event->attr.sample_type).  Comparing them immediately
+ * reveals whether the PMU is providing the fields DAMON asked for
+ * — e.g. sample_type has PERF_SAMPLE_PHYS_ADDR but sample_flags
+ * does not → the PMU does not support physical-address sampling.
+ */
+TRACE_EVENT(damon_perf_sample,
+
+	TP_PROTO(unsigned long addr, u64 data_src, u64 period, int cpu,
+		u8 reason, u64 sample_flags, u64 sample_type,
+		u8 context),
+
+	TP_ARGS(addr, data_src, period, cpu, reason, sample_flags,
+		sample_type, context),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(u64, data_src)
+		__field(u64, period)
+		__field(int, cpu)
+		__field(u8, reason)
+		__field(u64, sample_flags)
+		__field(u64, sample_type)
+		__field(u8, context)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->data_src = data_src;
+		__entry->period = period;
+		__entry->cpu = cpu;
+		__entry->reason = reason;
+		__entry->sample_flags = sample_flags;
+		__entry->sample_type = sample_type;
+		__entry->context = context;
+	),
+
+	TP_printk("addr=0x%lx data_src=0x%llx period=%llu cpu=%d reason=%u context=%u sample_flags=0x%llx sample_type=0x%llx",
+		__entry->addr, __entry->data_src, __entry->period,
+		__entry->cpu, __entry->reason, __entry->context,
+		__entry->sample_flags, __entry->sample_type)
+);
+
+/*
+ * Fires when a report survived all ring/drain checks but could not be
+ * applied to any DAMON region.  Reasons correspond to
+ * enum damon_report_miss_reason:
+ *
+ *   DAMON_REPORT_MISS_TGID     (1): no target matched the report's tgid
+ *   DAMON_REPORT_MISS_NOREGION (2): binary search found no containing region
+ *   DAMON_REPORT_MISS_BOUNDARY (3): address + size straddles region boundary
+ *
+ * Note: tgid mismatches are now resolved in the drain loop *before*
+ * iterating targets, so there is at most one trace hit per report
+ * (rather than one per non-matching target as in earlier revisions).
+ */
+TRACE_EVENT(damon_perf_report_missed,
+
+	TP_PROTO(unsigned long addr, int cpu, int reason),
+
+	TP_ARGS(addr, cpu, reason),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(int, cpu)
+		__field(int, reason)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->cpu = cpu;
+		__entry->reason = reason;
+	),
+
+	TP_printk("addr=0x%lx cpu=%d reason=%d", __entry->addr,
+		__entry->cpu, __entry->reason)
+);
+
+/*
+ * Per-tick drain summary.  Fires from kdamond after draining the per-CPU
+ * SPSC ring, so users can observe total vs matched without polling dmesg
+ * or correlating individual miss tracepoints.
+ */
+TRACE_EVENT(damon_perf_drain,
+
+	TP_PROTO(unsigned int total, unsigned int matched),
+
+	TP_ARGS(total, matched),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, total)
+		__field(unsigned int, matched)
+	),
+
+	TP_fast_assign(
+		__entry->total = total;
+		__entry->matched = matched;
+	),
+
+	TP_printk("total=%u matched=%u", __entry->total, __entry->matched)
+);
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
+
 /* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
 TRACE_EVENT(damos_node_eligible_mem_bp,
 
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index ad629f0f31d8..9f811510760f 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -131,4 +131,21 @@ config DAMON_ACMA
 	  min/max memory for the system and maximum memory pressure stall time
 	  ratio.
 
+config DAMON_PERF_OBSERVE
+	bool "DAMON perf event observability framework"
+	depends on DAMON
+	depends on PERF_EVENTS
+	depends on DEBUG_FS
+	default n
+	help
+	  Enable per-CPU pipeline counters, tracepoints, and a
+	  debug-only debugfs perf_stats file for DAMON
+	  hardware-sampled access reports.  The debugfs format is
+	  unstable and must not be used by scripts; counters and
+	  tracepoints are the diagnostic interface.
+
+	  When disabled, all observe functions are compiled to
+	  static-inline no-ops with zero runtime overhead.
+
+	  If unsure, say N.
 endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 22494754f41e..04da39a9f56c 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
 obj-$(CONFIG_DAMON_ACMA)	+= modules-common.o acma.o
+obj-$(CONFIG_DAMON)		+= perf/
diff --git a/mm/damon/perf/Makefile b/mm/damon/perf/Makefile
new file mode 100644
index 000000000000..cc0d4f1d1d28
--- /dev/null
+++ b/mm/damon/perf/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Observability: per-CPU counters, tracepoints, debugfs perf_stats
diff --git a/mm/damon/perf/perf.h b/mm/damon/perf/perf.h
new file mode 100644
index 000000000000..78e23d436336
--- /dev/null
+++ b/mm/damon/perf/perf.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON Hardware-sampled Access Report Observability Framework
+ *
+ * Single entry-point for all hardware sampling backends (ARM SPE,
+ * AMD IBS, Intel PEBS, …).  Every event, sample, ring operation,
+ * match decision, and region update flows through the
+ * damon_perf_observe_*() API, which fans out to per-CPU counters
+ * and tracepoints.  When CONFIG_DAMON_PERF_OBSERVE=n, everything
+ * compiles to static-inline no-ops.
+ *
+ * Author: Kunwu Chan <kunwu.chan@gmail.com>
+ */
+
+#ifndef _DAMON_PERF_H
+#define _DAMON_PERF_H
+
+struct perf_event;
+#include <linux/types.h>
+
+struct damon_perf_event;
+
+/*
+ * Per-event state machine
+ *
+ * Each per-CPU damon_perf_event transitions through these states.
+ * State is tracked in a per-CPU integer (damon_perf_cpu_state).
+ */
+enum damon_perf_event_state {
+	DAMON_PERF_STATE_UNINIT = 0,
+	DAMON_PERF_STATE_CREATED,	/* struct allocated, cpuhp registered */
+	DAMON_PERF_STATE_BOUND,		/* perf_event_create_kernel_counter() ok */
+	DAMON_PERF_STATE_ENABLED,	/* perf_event_enable() called */
+	DAMON_PERF_STATE_RUNNING,	/* first overflow callback received */
+	DAMON_PERF_STATE_ERROR,		/* unrecoverable failure */
+};
+
+/*
+ * Per-CPU statistics
+ *
+ * All counters are monotonic, best-effort reads.  Userspace computes
+ * deltas between snapshots.  Stored per-CPU so the NMI fast path uses
+ * this_cpu_inc() with no locking.  Counter values are raw facts:
+ * interpretation (thresholds, verdicts) belongs in userspace.
+ *
+ * The kernel provides tracepoints under events/damon/ for structured,
+ * stable diagnostics.  The debugfs perf_stats file is DEBUG ONLY and
+ * its format may change without notice.
+ */
+struct damon_perf_stats {
+	/* Per-CPU event state (enum damon_perf_event_state) */
+	int cpu_state;
+
+	/* Sampling pipeline */
+	u64 callback;
+	u64 sample_valid;
+	u64 sample_null;
+	u64 sample_addr_zero;
+	u64 sample_kernel;
+	u64 sample_invalid_phys;
+
+	/* Ring */
+	u64 enqueue;
+	u64 dequeue;
+	u64 overflow;
+	u64 ring_peak;
+
+	/* Matching */
+	u64 match;
+	u64 miss_tgid;
+	u64 miss_region;
+	u64 miss_boundary;
+	u64 update;
+};
+
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+
+/*
+ * damon_perf_observe_*() — Unified Observability API
+ *
+ * These are the ONLY hooks that hardware-sampling backends should
+ * call.  They are split into NMI-safe (sampling, ring-enqueue) and
+ * process-context (event lifecycle, drain, matching, update) groups.
+ *
+ * Counters always increment when CONFIG_DAMON_PERF_OBSERVE=y.
+ * Tracepoints are guarded by trace_*_enabled() and incur zero
+ * overhead when ftrace is not attached.
+ */
+
+/* Event lifecycle — process context (kdamond / cpuhp callbacks) */
+void damon_perf_observe_event_created(struct damon_perf_event *event,
+		int cpu);
+void damon_perf_observe_event_bound(struct damon_perf_event *event,
+		int cpu, struct perf_event *perf_event);
+void damon_perf_observe_event_enabled(struct damon_perf_event *event,
+		int cpu, int state, int oncpu);
+void damon_perf_observe_event_disabled(struct damon_perf_event *event,
+		int cpu, int state);
+void damon_perf_observe_event_destroyed(struct damon_perf_event *event,
+		int cpu);
+void damon_perf_observe_event_free(struct damon_perf_event *event);
+
+/*
+ * Sample observed — NMI-safe.
+ *
+ * @reason:  0 = valid (queued to ring)
+ *           1 = data NULL
+ *           2 = addr == 0 (PMU did not populate)
+ *           3 = kernel address (vaddr only)
+ *           4 = phys_addr not valid (paddr only)
+ */
+void damon_perf_observe_sample(unsigned long addr, u64 data_src,
+		u64 period, int cpu, u8 reason,
+		u64 sample_flags, u64 sample_type);
+
+/* Ring operations — enqueue/overflow are NMI-safe */
+void damon_perf_observe_ring_enqueue(void);
+void damon_perf_observe_ring_overflow(int cpu);
+void damon_perf_observe_ring_dequeue(int cpu);
+void damon_perf_observe_ring_peak(unsigned int occupancy);
+
+/* Matching — process context (kdamond drain loop) */
+void damon_perf_observe_match(unsigned long addr, int cpu);
+void damon_perf_observe_miss(unsigned long addr, int cpu, int reason);
+void damon_perf_observe_update(int cpu);
+void damon_perf_observe_drain(unsigned int total, unsigned int matched);
+
+/* Debugfs (debug-only, format unstable) */
+int damon_perf_debugfs_init(void);
+
+/* Per-CPU stats accessors (for debugfs) */
+void damon_perf_stats_snapshot(int cpu, struct damon_perf_stats *dst);
+void damon_perf_stats_aggregate(struct damon_perf_stats *dst);
+
+/* Subsystem init */
+int damon_perf_framework_init(void);
+
+#else /* !CONFIG_DAMON_PERF_OBSERVE */
+
+static inline void damon_perf_observe_event_created(struct damon_perf_event *e,
+						    int c)
+{
+}
+
+static inline void damon_perf_observe_event_bound(struct damon_perf_event *e,
+						  int c, struct perf_event *p)
+{
+}
+
+static inline void damon_perf_observe_event_enabled(struct damon_perf_event *e,
+						    int c, int s, int o)
+{
+}
+
+static inline void damon_perf_observe_event_disabled(struct damon_perf_event *e,
+						     int c, int s)
+{
+}
+
+static inline void damon_perf_observe_event_destroyed(struct damon_perf_event *e,
+						      int c)
+{
+}
+
+static inline void damon_perf_observe_event_free(struct damon_perf_event *e)
+{
+}
+
+static inline void damon_perf_observe_sample(unsigned long a, u64 d, u64 p,
+					     int c, u8 r, u64 f, u64 t)
+{
+}
+
+static inline void damon_perf_observe_ring_enqueue(void)
+{
+}
+
+static inline void damon_perf_observe_ring_overflow(int c)
+{
+}
+
+static inline void damon_perf_observe_ring_dequeue(int c)
+{
+}
+
+static inline void damon_perf_observe_ring_peak(unsigned int o)
+{
+}
+
+static inline void damon_perf_observe_match(unsigned long a, int c)
+{
+}
+
+static inline void damon_perf_observe_miss(unsigned long a, int c, int r)
+{
+}
+
+static inline void damon_perf_observe_update(int c)
+{
+}
+
+static inline void damon_perf_observe_drain(unsigned int t, unsigned int m)
+{
+}
+
+static inline int damon_perf_debugfs_init(void)
+{
+	return 0;
+}
+
+static inline void damon_perf_stats_snapshot(int c, struct damon_perf_stats *d)
+{
+	memset(d, 0, sizeof(*d));
+}
+
+static inline void damon_perf_stats_aggregate(struct damon_perf_stats *d)
+{
+	memset(d, 0, sizeof(*d));
+}
+
+static inline int damon_perf_framework_init(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
+
+#endif /* _DAMON_PERF_H */
-- 
2.43.0

