Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8883EAC68
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033487; cv=none; b=R34YII6G7KR0+5eICQLlU02wz1yTxFeAmvp1bgH7cHUHIjjkrGqgfTVdqWX9hE5xTb2ks4L95hkkTQ2T6Jr0bQ1jrtUntio3JiLKP4C+KWt9IWQtdUI5CWJNHauFlu0kQESPxC9lTeV6qQTh4TmKlEK70NpkXFWNWWMIld5cPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033487; c=relaxed/simple;
	bh=gXkE5z9olmERVRUNaNaZmccPuEwdj1m2bfUVPwANH4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCO64FY6lwwdRIYuxlPcKkF6ukVnAFBdgku+YhwxeBH5tmE9rLadZWcqGIo8biJeRwKaqxz2jMjEHl8+qcP5B5xIHHr7OXppA6icLr0ONnwsUT8nuZxnhExlyfK/zla5WDwqKTkVLmrRlGyUgN9y72mKAM7kW9i3i4BoIt9neLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ov3ryNmG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov3ryNmG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4400720a91.0
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033484; x=1787638284; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OkufMBhFwqowO3sZfc9l3+J3Km3N7KYxt/zmtGdjLcc=;
        b=ov3ryNmGdhhJ7aAtdKkQuy2PILP+FVusVlunkv8mLxwkXKnea2pwH0o14XwMCxT5fA
         wS3Yc2URvvnphiHUIChWz38pY5b4FWELf4OVgF7/tunpwY56pYIF7P64s/GrTWsllIYw
         DUSReQBrPGKsbE1o/RyAYd3r8X7naLIat7aDcTQWCfvSeY2V9OIiwacDufmzd0CzpksW
         crhXRIHhAon8qNubkNAuwaDMQB4npT8n1i/JBN3JA+9LkUO4Anu5KXIgMDu7toddrgGb
         CmW6O+znBBzLr+4cpd75l/YECOAGteqS7xFsPSNP1wuBoGdP/zk4XX8JAXt0Wu62ck20
         QVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033484; x=1787638284;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkufMBhFwqowO3sZfc9l3+J3Km3N7KYxt/zmtGdjLcc=;
        b=WDivhGh69SxmNhjav0YkPubLVojuA0DTZWrTf9uQqdn43EDLVSiOjNiaLJeGgI8n38
         LDh1wmF6dtDyofuUtChdzDJTevbb0gyYbhpc4M83kgA0HK/Da0frwkEY78IqBJyyYAfz
         4ypWVeoLNB0Yxv68FN/6GlAvNKSTw6SKK0/r48YI5/ydwsnJ7CStjGbQDWS7cIUMLjqQ
         QJLCAlAyTMpYIpvgd+4EwNmNroWMz5XXtu00g3eajyM9WaCMwdyoZk/Xvk9fN+VMEZLv
         ayA/9X55J6txGtNSNWB3cqHj+Xd5UygtPfLiHyquCR8sYL7Z12HJTgPv7Qo1WOu0K8FJ
         tlxw==
X-Gm-Message-State: AOJu0YzAZGtQvtFcgTT92C+5PLBY6dHUy0hiDcnDcHTWw4ZGxVQEsa8Y
	x4jgtISDdw/6paCPQQ76GFeLJsUXnmVHCz3J5ADY8GPgbJ5Pizlm4MXJLRN9FRgG
X-Gm-Gg: AR+sD12h3xEuUfwAv6gmE2LAIqH2rJ1fPJnicyh6tJ9YZ/1IeT4YSYHbGsCRwP1g2Ou
	3Hm3M8qk3oRhoEB5QYgmrImNAhONfjn3wQ9m8U/y82cPGP45fwKZS7DB+XvoLMPrrFCBWpQOkxm
	w3d82PbNgbWQxUGzZ2D6YhnYBcEiKRug22a69WN65mmFmeEb/MxcK0agS301/7DA3KZyouR4RVS
	E9L7l6beNak7uujHUuofPhAnebuEqRYq3DBGAKeBEaYY8D4/9qL3PRv5fX/rBqfc+cc8mt8GZhk
	vqcYqnY5wev1iEfdFeo7+XBZ7Z/pi6agtqi0GGt8PIP1J5cRereyA8ZbIkwEO2RCMRQoEZmWaEU
	vHLiuRDd/+BBO2uGNXpVrlS2KRf2dSZkCbX8CGaZAdb7KZI11d1ZNALIs3kUMC7RCCsbl8IdrZc
	oFZXZ/oMDg8+UN3Sp/qQPri0lND/zNz/zhRlFo0bbVn6+47fJtG9d+Y8affAnYCtTKtZX92YAgX
	mceoE0YUls1
X-Received: by 2002:a17:90b:2f10:b0:38e:f6eb:2b38 with SMTP id 98e67ed59e1d1-3933e63ba0bmr31731771a91.17.1787033483851;
        Mon, 17 Aug 2026 23:11:23 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:23 -0700 (PDT)
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
Subject: [RFC PATCH 6/7] Docs/mm/damon: document the perf observability framework
Date: Tue, 18 Aug 2026 14:10:30 +0800
Message-ID: <20260818061031.827057-7-kunwu.chan@linux.dev>
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

From: Lian Wang <lianux.mm@gmail.com>

Add documentation for the DAMON perf observability framework,
covering the CONFIG_DAMON_PERF_OBSERVE Kconfig option, the
debugfs perf_stats interface, the tracepoints, and the per-CPU
pipeline counter model.  The debugfs format is explicitly marked
as unstable and must not be used by scripts.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 .../mm/damon/perf-observability.rst           | 210 ++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/perf-observability.rst

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 3ce3164480c7..623a5c312b69 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -15,3 +15,4 @@ access monitoring and access-aware system operations.
    reclaim
    lru_sort
    stat
+   perf-observability
diff --git a/Documentation/admin-guide/mm/damon/perf-observability.rst b/Documentation/admin-guide/mm/damon/perf-observability.rst
new file mode 100644
index 000000000000..3aa8185de314
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/perf-observability.rst
@@ -0,0 +1,210 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================
+DAMON Perf Event Observability Framework
+=============================================
+
+The DAMON perf event observability framework provides per-CPU counters and
+tracepoints for hardware-sampled access reports.  When DAMON is configured to
+use a hardware PMU (e.g. AMD IBS, Intel PEBS, or ARM SPE) instead of page-table
+walks, this framework exposes raw pipeline diagnostics so that every stage of
+the PMU-to-DAMON pipeline can be inspected.
+
+Counters are best-effort: individual ``u64`` writes are atomic on 64-bit
+platforms, but no cross-field consistency is guaranteed.  Do not build
+policy on snapshot reads.  For stable, structured diagnostics, use the
+tracepoints under ``/sys/kernel/debug/tracing/events/damon/``.
+
+Pipeline Stages
+===============
+
+::
+
+  PMU hardware → overflow_handler / AUX drain
+    → damon_report_access() → per-CPU SPSC ring
+    → kdamond drain → target match → region update
+
+  Layer 1:  Event Create   perf_event_create_kernel_counter()
+  Layer 2:  Event Bind     per-CPU PMU attachment
+  Layer 3:  Event Enable   perf_event_enable()
+  Layer 4:  Sampling       callback / AUX record received
+  Layer 5:  Ring           SPSC enqueue / dequeue / overflow
+  Layer 6:  Drain          kdamond consumes entries from ring
+  Layer 7:  Match & Update region access-rate update
+
+Each layer has a dedicated counter, and most layers have corresponding
+tracepoints.  Per-CPU event state (UNINIT → CREATED → BOUND → ENABLED →
+RUNNING) is recorded unconditionally and exposed via the debugfs
+perf_stats file.
+
+Overhead Control
+================
+
+Two levels of overhead control are provided:
+
+1. **Compile-time** — ``CONFIG_DAMON_PERF_OBSERVE``
+   When set to ``n``, all observe functions are compiled to static-inline
+   no-ops.  No code is generated and no runtime overhead exists.
+
+2. **Per-tracepoint on/off** — standard ftrace ``enable`` files
+   Individual tracepoints (``damon_perf_sample``, etc.) can be
+   enabled or disabled independently via
+   ``/sys/kernel/debug/tracing/events/damon/``.  Counter increments are
+   unconditional (cheap per-CPU ``inc``); tracepoint decisions are
+   guarded by the ftrace static key and are zero-overhead when disabled.
+
+When ``CONFIG_DAMON_PERF_OBSERVE=y``, per-CPU counters always increment.
+There is no runtime toggle for counters; compile-time is the sole gate.
+
+Debugfs Interface
+=================
+
+Mount debugfs::
+
+    # mount -t debugfs none /sys/kernel/debug
+
+One file is created under ``/sys/kernel/debug/damon/``:
+
+perf_stats
+----------
+
+**DEBUG ONLY — format may change without notice.**  Do not parse in
+scripts or tools.  For stable diagnostics, use the tracepoints.
+
+Read-only.  Aggregated counter table with all pipeline counters plus
+per-CPU breakdown::
+
+    # cat /sys/kernel/debug/damon/perf_stats
+      ┌──────────────┬──────────┐
+      │ Counter      │   Value  │
+      ├──────────────┼──────────┤
+      │ callback     │    233   │
+      │ valid        │      0   │
+      │ null         │      0   │
+      │ addr_zero    │    233   │
+      │ kernel       │      0   │
+      │ inv_phys     │      0   │
+      │ enqueue      │      0   │
+      │ dequeue      │      0   │
+      │ overflow     │      0   │
+      │ ring_peak    │      0   │
+      │ match        │      0   │
+      │ miss_tgid    │      0   │
+      │ miss_region  │      0   │
+      │ miss_bound   │      0   │
+      │ update       │      0   │
+      └──────────────┴──────────┘
+
+      Per-CPU (non-zero / non-UNINIT):
+      CPU00: st=BOUND   cb=44 enq=0 deq=0 ovf=0 match=0 miss=0 upd=0
+      ...
+
+The ``st=<state>`` column shows the per-CPU event state machine position
+(UNINIT, CREATED, BOUND, ENABLED, RUNNING, ERROR), derived from the
+lifecycle observe calls.  This allows verifying lifecycle progression
+without parsing dmesg.
+
+All counters are monotonic (cumulative since boot); userspace computes
+deltas between snapshots.
+
+Tracepoints
+===========
+
+Four tracepoints are defined::
+
+    damon_perf_sample
+    damon_perf_ring_overflow
+    damon_perf_report_missed
+    damon_perf_drain
+
+Enable via ftrace::
+
+    # echo 1 > /sys/kernel/debug/tracing/events/damon/damon_perf_sample/enable
+    # cat /sys/kernel/debug/tracing/trace_pipe
+
+Each ``damon_perf_sample`` record includes:
+
+  - ``addr``: the accessed virtual address (0 if the PMU did not populate)
+  - ``data_src``: PERF_MEM_* encoding (PMU-dependent)
+  - ``period``: sample period or frequency count
+  - ``cpu``: CPU that generated the sample
+  - ``reason``: 0=valid, 1=null-data, 2=addr-zero, 3=kernel-addr, 4=invalid-phys
+  - ``sample_flags``: what the PMU actually populated
+  - ``sample_type``: what DAMON requested
+  - ``context``: 0=process, 1=softirq, 2=hardirq, 3=NMI
+
+The ``context`` field is particularly useful for cross-PMU validation.
+For example, AMD IBS samples arrive in NMI context (context=3), while
+ARM SPE data from an AUX backend would arrive in process context (context=0).
+A mismatch between the expected and actual context is immediately visible.
+
+Selftest
+========
+
+A comprehensive automated test script is provided::
+
+    # cd tools/testing/selftests/damon
+    # sudo ./damon_perf_obs_test.sh --pmu arm_spe_0 --freq 0 --period 256
+
+The script performs a layer-by-layer validation:
+
+1. Checks kernel configuration (CONFIG_DAMON, CONFIG_DAMON_PERF_OBSERVE, etc.)
+2. Verifies PMU availability, tracepoints, and the debugfs perf_stats file
+3. Refuses to run if existing kdamonds are present (side-effect guard)
+4. Configures DAMON with the specified PMU via sysfs
+5. Runs a memory workload (stress-ng, stress, or dd fallback)
+6. Collects dmesg delta, trace output, and perf_stats
+7. Verifies per-CPU state progression and counter values
+
+Example output::
+
+    --- Layer 0: Environment ---
+    [PASS] CONFIG_DAMON_PERF_OBSERVE=y
+    [PASS] debugfs perf_stats exists
+
+    --- Layer 2-3: Enable & Run (via per-CPU state) ---
+    [PASS] Event Created (max per-CPU state >= CREATED)
+    [PASS] Event Bound (max per-CPU state >= BOUND)
+    [PASS] Event Enabled (max per-CPU state >= ENABLED)
+
+    --- Layer 4: Sampling (Callback) ---
+    [PASS] Sampling: 84532 callbacks received
+    Callback breakdown: valid=82103 addr_zero=0 kernel=2429
+
+    --- Layer 5: Ring ---
+    [PASS] Ring: enqueue > 0
+    [PASS] Ring: dequeue > 0
+    Ring: enqueue=82100 dequeue=81987 overflow=0
+
+    --- Layer 6: Drain & Match ---
+    [PASS] Drain & Match: 81987 matched
+    [PASS] Update: 81987 region updates
+
+Additional PMU examples::
+
+    # Software page-fault event (positive control):
+    sudo ./damon_perf_obs_test.sh --pmu software --freq 1 --sample-freq 100
+
+    # Any PMU by type number:
+    sudo ./damon_perf_obs_test.sh --pmu-type 38 --freq 0 --period 256
+
+Kernel Configuration
+====================
+
+Required for observability::
+
+    CONFIG_DAMON=y
+    CONFIG_DAMON_SYSFS=y
+    CONFIG_DAMON_VADDR=y
+    CONFIG_PERF_EVENTS=y
+    CONFIG_DEBUG_FS=y
+    CONFIG_TRACING=y
+    CONFIG_TRACEPOINTS=y
+
+Optional (enables observability framework)::
+
+    CONFIG_DAMON_PERF_OBSERVE=y
+
+When ``CONFIG_DAMON_PERF_OBSERVE=n``, ``/sys/kernel/debug/damon/perf_stats``
+is not created, tracepoints are not registered, and all observe functions
+are compiled to empty static inlines with zero overhead.
-- 
2.43.0

