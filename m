Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B513E0C7A
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033447; cv=none; b=L95c+l7WgJZe2YtgwuAV+p52leWl8iTI08bAzSJ1KcaWtHxxcYqT2DTAL3h75TKJ/CaSm9oOFuMikq0MvjyjjPFHvgkQrZnueJ4TK5YBjaGdY32COUWYVql5qSLrvH4gvOr85Tt1kJyCooy2rggFSLoyT4ez6MP4qfA4i6eCCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033447; c=relaxed/simple;
	bh=2FOLVCfC4ofTUJxtY8JQkfWysWQNWsICB/k6OH+f7kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iqg5RxEA5fNBhd33ggFls5p0b/uJORxXX2mpxZr7I4STXB9ZBc1zV+gyMHzuTo9bV7gXe8HjVGKl3U/cJhwwWhSRtONKf21c6eS+f7EnjdP3RHxoDS9OF0t+QnD0ZGRwFKX8kbLjRZBTYVGMVN3K4Aa/sikIArpCByAJmOmr19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZh1PGJT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZh1PGJT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3900e39d935so3825494a91.0
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033445; x=1787638245; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03XrAgWUIfiSPQ5t3z3JrnXITobmfpDmBrpvKrXoXgU=;
        b=sZh1PGJT8vfSXzHV9RBm8o7Id1Dbk5/GxFz+Cq2+ghLT/KkNL+zhxANMYICaTXvwej
         6a469gPvde40n0W9p6nupW4E2gtGl0l4j6GpnFdR2Qrx0MLqQZvNdl2Tt0LmUJ07MSBC
         SU8NhxPmQ4c9DxZ+BRklcSky6DaF6mw9Nr8HAO1ZyXUHoCWolhOSSuYnZ/yh1YhNIT4t
         H8pN2iIw5wVdy4NmR+JvPQa3QZmPzr163FZqlIRKu+3aU7wwZxIhKoWC1KNw1DieeF8q
         rsvNj0431i8R+1C+q4tAaq1eaTIetLYDy8do11t8WuBohSj3Cz8HqwFfQl1GIIwu24iz
         EulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033445; x=1787638245;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03XrAgWUIfiSPQ5t3z3JrnXITobmfpDmBrpvKrXoXgU=;
        b=ktQHIL6/h6gJASQb5y7GuzMNWWX5FKk0PUeF6xoux2HmSi9obSq2+uPp97u4sM8/tu
         86tcS8OIahlHmjpZJVsLFlGZWHLjw+afxr3nv7eooF3lYZUQBxtQYI3R+JqbfphTPbVC
         96c8emqAyp75e66DtBZjtEg+H8N/3cAsM+Ik1XrXmcKZseQkV8618UaWZnV3/UmKdKVQ
         gnMqtHP2vX4QCUow8UBDI+pcdeuia/X3OfAFX5LPOXtt07wrgGBGhYm4jYMWBH4ft++5
         AzvMkUPkIA+pZ+Cv95MsE27X4/Ddx6dzeMFuLy99p2/FQvN6mk4eSHiq6IW744Xo3Z+0
         Zc0Q==
X-Gm-Message-State: AOJu0Ywz64uViOTH4Zx5aC6OqyctfF4pF6n6WCaGzfRaWxyde3GThCt6
	bLH2JmEd+Z9/GQO+B3X4Fl08eZXhP/vYtjw1zvsdMPmAi3z8IoxBmNkP
X-Gm-Gg: AR+sD10Im39OyQkF4M01J6LqYqC+7dsN12oNfbKGN7OIsbqtNUJzkg6kHA0Ov7JGuF4
	MJAp6rnv2Gh8Ei4p2l3NbbKbHf6A9lEpLKz5RiERM/+5X89fNnXnkitrjIGOqR/OnsZIkoYdFlY
	pJQ+k0QRz05ytz7rR+y2YQGEoGxDltRX92HsnlyljmSAFEGrZC0T+BAhp51vSdyCzYtEO4yMPg5
	OCJCGk40nTwdF/ke9eLRNhBVq4Bv0+Th0Zn82nGYbB22REfBOgUdseDqMmoMIAEktRhm2x2XaYr
	Vq1WphBmuu9Do/hVzOICysdSE+VDsVYm/J2fJ7yhGVfzpwVJFZrmecO1u6ec0NKjErYnOi3M497
	IdF7mGvq+A28JmdjX1PVcWSlZ9l54x+Q3JmT4tp1+/kT43mp2sy4WGsSJccYpLWoVqJlLNSE6oU
	+gc5lgF+efcgifpprD3BLn4JXgEADVGbU0gKrROGH/hAlvy5XYM1M43oye90WpsJ+4Q1y4Z6ct4
	g0sfMw=
X-Received: by 2002:a17:90b:5707:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3933e61bee2mr33646076a91.15.1787033445097;
        Mon, 17 Aug 2026 23:10:45 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:10:44 -0700 (PDT)
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
Subject: [RFC PATCH 0/7] mm/damon/perf: observability framework for hardware-sampled access reports
Date: Tue, 18 Aug 2026 14:10:24 +0800
Message-ID: <20260818061031.827057-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

This series adds a unified observability framework to DAMON's
hardware-sampled access report pipeline.  When a PMU backend delivers
zero callbacks, the framework pinpoints the failing stage —
was the event not created?  not enabled?  did the hardware produce
no samples?  did the ring drop them?  did the drain fail to match? —
without a single printk.  Every PMU backend (ARM SPE, AMD IBS,
Intel PEBS, …) funnels through the same damon_perf_observe_*() API,
which fans out to per-CPU pipeline counters, debugfs statistics,
and tracepoints.

The framework does not contain any PMU driver.  It is pure
observability infrastructure that sits alongside the existing
DAMON software statistics (scheme stats, kdamond stats) and
complements them for the hardware-sampling path.

Why this framework exists
-------------------------
The framework was built to answer a concrete question during ARM SPE
bring-up: what prevents SPE from delivering samples to DAMON?  The
answer could be anywhere in the pipeline — the event wasn't created,
the PMU wasn't enabled, the hardware produced no samples, the ring
dropped them, or the drain failed to match — and without per-stage
visibility, the only way to find out was to insert printks across the
entire pipeline.

The framework instruments every stage with zero-overhead counters
(when CONFIG_DAMON_PERF_OBSERVE=n) and optional tracepoints, so the
failing stage is revealed at a glance.  It immediately diagnosed the
ARM SPE gap: Layers 1-3 (event create/bind/enable) passed, but the
PMU was not producing data — a PMU-level gap, not a DAMON pipeline
bug.  This confirmed that SPE required an AUX buffer backend, which
does not fit the perf_event_create_kernel_counter() API.

During the subsequent ARM SPE AUX backend development [2] (which builds
on the perf AUX kernel-consumer API [3]), the framework was used to
verify each pipeline fix.  When the AUX backend was complete, the same
framework confirmed a fully functional pipeline: Layers 1-7 all pass,
real SPE hardware samples flow through the ring, match, and update
stages.  The before/after results are shown in the Testing section.

We are posting the framework now so that other PMU backends can reuse
the same infrastructure instead of re-deriving it.

How to use
----------
Compile with CONFIG_DAMON_PERF_OBSERVE=y.  After starting a kdamond
with a perf event, the pipeline is visible at a glance:

  # cat /sys/kernel/debug/damon/perf_stats
      --------------  ----------
      Counter          Value
      --------------  ----------
      callback          233
      valid             233
      ...
      enqueue           233
      dequeue           233
      match              12
      update              9

For automated diagnosis, run the selftest:

  # sudo ./damon_perf_obs_test.sh --pmu software --freq 1 --sample-freq 100

For structured diagnostics, enable the tracepoints under
/sys/kernel/debug/tracing/events/damon/.

What the series adds
--------------------
Patch 1 defines the three tracepoints (damon_perf_sample with 8 fields
including sample_flags, sample_type, and execution context, plus
damon_perf_report_missed and damon_perf_drain) with the CONFIG switch,
the observe API declarations, no-op stubs, and the Kconfig / Makefile
wiring.  (Reviewers: tracepoint folks — Steven, Masami, Mathieu.)

Patch 2 implements the observe_*() core: per-CPU monotonic counters,
event-lifecycle hooks with lazily-allocated per-event per-CPU state,
NMI-safe sample classification with execution-context detection,
ring enqueue/dequeue/peak, match/miss/update, and framework init.

Patch 3 adds the debugfs perf_stats interface (debug-only, format
unstable).

Patch 4 wires the observe calls into the vaddr overflow handlers and
the kdamond drain, integrating the framework into the hot path.
Reads ring->tail once with READ_ONCE and reuses the cached value
for the peak-occupancy estimate, avoiding a compiler reload and a
torn read on the NMI producer side.

Patch 5 adds the automated selftest with snapshot/delta accounting,
per-CPU state-column checks, clean-session guard, and a PMU support
verdict (FULLY INTEGRATED / PLUMBING-ONLY / UNUSABLE).
(Reviewers: kselftest folks — Shuah.)

Patch 6 documents the framework.

Patch 7 adds CONFIG_DAMON_PERF_DEBUG as an optional Kconfig option for
verbose pr_debug() output via damon_perf_dbg(), wired into every
event-lifecycle hook, the drain summary, and the init paths.  Adds a
pipeline health check to the selftest that diagnoses which stage is
broken when callbacks are zero.

Testing
=======
Tested on Kunpeng 920 (256 CPUs, ARM SPE, kernel 7.1.0-rc5-mm-new-damon+).

KUnit: 35/35 PASSED (damon 29, damon-operations 5, damon-sysfs 1).

The framework is PMU-agnostic.  Three configurations demonstrate this,
with the ARM SPE case being the framework's core diagnostic value:

**Software PMU** (page-fault sampling, exercises the full pipeline,
no hardware required):

  $ sudo ./damon_perf_obs_test.sh --pmu software --freq 1 --sample-freq 100
  SUMMARY: 27 passed, 0 failed, 0 skipped (FULLY INTEGRATED)
  callback=170, valid=170, enqueue=170, dequeue=170, match=6, update=3

**CPU-clock** (address-less PMU, plumbing-only):

  $ sudo ./damon_perf_obs_test.sh --pmu software --config 0 --freq 1 --sample-freq 100
  SUMMARY: 22 passed, 0 failed, 3 skipped (PLUMBING-ONLY)
  callback=1913, valid=0, addr_zero=1913, enqueue=0
  Layers 1-4 pass; Ring/Match/Drain skipped as expected.

**ARM SPE** (hardware trace).  This is the scenario that motivated the
  framework: without an AUX buffer backend, SPE cannot deliver samples
  through perf_event_create_kernel_counter(), and the framework
  pinpoints the failure without a single printk:

  $ sudo ./damon_perf_obs_test.sh --pmu arm_spe_0 --freq 0 --period 256

  --- Layer 2-3: Enable & Run (via per-CPU state) ---
    [PASS] Event Created (max per-CPU state >= CREATED)
    [PASS] Event Bound (max per-CPU state >= BOUND)
    [PASS] Event Enabled (max per-CPU state >= ENABLED)
    [PASS] Perf event creation (no errors in dmesg delta)

  --- Analysis ---
    Pipeline diagnosis: PMU not producing data or AUX pipeline broken
    [FAIL] Sampling — 0 callbacks — PMU is not delivering samples to DAMON
    [SKIP] Event Running — no callbacks — state cannot advance past ENABLED
    Ring: enqueue=0 dequeue=0 overflow=0

  --- PMU support verdict ---
    UNUSABLE: the PMU never delivered a sample to DAMON

  SUMMARY: 19 passed, 1 failed, 5 skipped

  Layers 1-3 pass — the per-CPU state advances to ENABLED — so the
  kernel-side plumbing is intact.  The health check confirms
  state >= ENABLED but enqueue=0, ruling out event-creation and enable
  bugs.  The failure is isolated to Layer 4 (Sampling): the PMU itself
  is not producing data.  This is the expected result for ARM SPE
  without an AUX buffer backend, and the framework diagnoses it as a
  PMU-level gap rather than a DAMON pipeline bug.

  After the AUX backend is added [2] (which itself depends on the
  perf AUX kernel-consumer API [3]), the same test script confirms a
  fully functional pipeline, including real SPE hardware samples:

  $ sudo ./damon_perf_obs_test.sh --pmu arm_spe_0 --freq 0 --period 256
  SUMMARY: 27 passed, 0 failed, 0 skipped (FULLY INTEGRATED)
  callback=47248, valid=47248, enqueue=15161, dequeue=15161,
  overflow=32087, match=255, update=4
  All 7 pipeline stages pass.  The AUX drain path delivers samples in
  process context (context=0), and the ring overflow counter (32087)
  shows the ring is sized for software PMU rates — a real-world
  observation the framework provides without any additional
  instrumentation.

Known limitations
=================
- The debugfs perf_stats format is explicitly unstable and must not
  be used by scripts.  Tracepoints and counters are the stable
  diagnostic interface.
- The global per-CPU lifecycle state is monotonic and never reset,
  so a previous RUNNING event can mask a current event's failure.
  Per-event per-CPU state is available for accurate tracking.
- This series depends on Ravi's hardware-sampled access reports
  branch [1] for the following facilities:
    * Per-CPU SPSC report ring (damon_report_rings,
      DAMON_REPORT_RING_MASK)
    * damon_report_access() and damon_report_page_fault() as the
      ring producer
    * kdamond_check_reported_accesses() as the drain path
    * damon_perf_event lifecycle (create/bind/enable/disable/free)
  Without [1] this series cannot compile, so [1] must be merged
  first.

References
==========
Link [1]: https://github.com/damonitor/linux.git
          branch: ravi_hw_sampled_access_reports_rfc_v1
          commit: fd968106e5bf
Link [2]: https://lore.kernel.org/all/20260816142222.689624-1-kunwu.chan@linux.dev/
Link [3]: https://lore.kernel.org/all/20260814144927.489172-1-kunwu.chan@linux.dev/

Base: fd968106e5bf ("mm/damon: add damos_node_eligible_mem_bp tracepoint")

Kunwu Chan (4):
  mm/damon/perf: add observability framework with tracepoints and CONFIG
    switch
  mm/damon/perf: implement observe API and per-CPU statistics engine
  mm/damon: integrate observe API into vaddr overflow handlers and core
    drain
  selftests/damon: add automated layer-by-layer observability test

Lian Wang (3):
  mm/damon/perf: add debugfs statistics interface
  Docs/mm/damon: document the perf observability framework
  mm/damon/perf: add CONFIG_DAMON_PERF_DEBUG and pipeline health check

 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 .../mm/damon/perf-observability.rst           | 210 +++++++
 include/linux/damon.h                         |  44 ++
 include/trace/events/damon.h                  | 120 ++++
 mm/damon/Kconfig                              |  33 +
 mm/damon/Makefile                             |   1 +
 mm/damon/core.c                               | 129 +++-
 mm/damon/perf/Makefile                        |   5 +
 mm/damon/perf/debugfs.c                       | 145 +++++
 mm/damon/perf/perf.h                          | 235 +++++++
 mm/damon/perf/stats.c                         | 308 ++++++++++
 mm/damon/vaddr.c                              | 104 +++-
 tools/testing/selftests/damon/Makefile        |   1 +
 .../selftests/damon/damon_perf_obs_test.sh    | 578 ++++++++++++++++++
 14 files changed, 1880 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/perf-observability.rst
 create mode 100644 mm/damon/perf/Makefile
 create mode 100644 mm/damon/perf/debugfs.c
 create mode 100644 mm/damon/perf/perf.h
 create mode 100644 mm/damon/perf/stats.c
 create mode 100755 tools/testing/selftests/damon/damon_perf_obs_test.sh

-- 
2.43.0

