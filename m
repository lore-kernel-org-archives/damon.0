Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B63E9C26
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033480; cv=none; b=qpZrJEPXBKNLwaC23ps/bXKxG7rxZzBdDhed3bXZyY1w5q4m3qQKT3Tc7a2n9xPu7lDBUrRU0mQdoy4te6u/zX349Y78cs6sIJmU/Ob/JlDs8QDjfXrOhm+8ZO3tEX+PGu2AuXU7A3P7H5RPYG31noljbMtQHNASu45jH04ypdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033480; c=relaxed/simple;
	bh=j7Uj2GO9RyEHH/pDmfQU4PHrULq40dlgjm/Tga2f6BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCaqz0uFY5j8xyynA2iFbNlyEuRGhhfQRpoFRZrd4BZTLxX3mdwaKrz0mtRW6NSRKs1tM6ogupVucQKR59EI/WEEmQT6wvQaGD5EsissUPDqqbDWI51ChdzVD4usrrfsjkqO9PP8ZnXWhicG6A77Z52VDVmesltLZkZ1SGF3wLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjutTGSr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjutTGSr"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e08baf860so4252274a91.2
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033478; x=1787638278; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=stz2R8m9lkuSZFQdtg7AzG6IQOSAxbyACeZhPcbbimg=;
        b=WjutTGSrcGDsptksBREPS0oiPY4MZ0XWE5ytCQ5XbEdqnDEg4yXbjt1g8yEhcF4ThY
         wf4e/qz8p+R+VtOgcidgY/fNnc5M4cxYbE3GT6X+mOdQfJ4JHYFz+SctTqCblDtR/XLz
         dPBFRcqfGCpMNHsw0qt2uBpkCdW2AqS7qfr4T8jy4M7b6EeUYm7n0MuqGpcnLKZ/ioRe
         33GxoEirOF6EsaZDwQWKJHsg0wuODK76ZM4OYJKkmoPTXFqvCCQaYb+bBACeOIr2TWrR
         lBAyoKKJ+bfqbIuN0GG1LuUFRCM17uFdqQfvPsbQoVtjC/WU+fASXnanjZjAqbIqzegK
         x3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033478; x=1787638278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stz2R8m9lkuSZFQdtg7AzG6IQOSAxbyACeZhPcbbimg=;
        b=lF6Oxl0obVMUH45OmdXFCqZrAfT2BbvWeF3HENGVm8wtGfCluykYcBujRQTiBQP4qC
         1cUVL2cfo9nIF/MTKrFzWEezEuJ6IyDgeuAaO+xYDsLKFMbxZjwQMG0pjY5y9C/pOY3I
         gZ2hQpp1VEUaL7hZ/OXlaUG7GgV9KH9a99lJQPIbnsPBmnYEEEZAmG57wQ5NUV5f5fbK
         r9ch20KXTBs028WdZrBgH5GtwsB9sOx1NeXIbj0MgAqYuFdZeabTRKgam6E1iViZkwId
         o3f+PPhm9FKO8tBC8MhBUYwBcGzijNGQiQ15oPavEaCnCH2C/jIKfukAX/kRZgllOCeu
         TnDw==
X-Gm-Message-State: AOJu0YzNh2bJ82sb0Ag/AQbQ0YbW5dT1XawSqAnq3IDVZA+4yL2rAPOI
	geWPnoyVV7uVyJKypE+veA89LWqJkybfaIB42WmYhSFayfc6rTlsQvUt
X-Gm-Gg: AR+sD12Ayuc6XFKpmqpNu+YRQhp98F8h8FGhCrAsUmMxwIM0sL/g6vI7K/FxgJ1i9Ij
	x31jXKlcXx92F+WN0gAtpxszWA3EN9C6KSufzJ8kmJcrQLd9E4ROpn5JgKWVHLKzgVLTrcRi5Gs
	H/o71ueVEdk9AE/YO/Nd6NdRGYcq+pExhkcdeEBZrcrb8AnEGLfh2UGzn3+YW0O21El/y2CPqhs
	kLi3ZVdY+QnAisVzJvDL7esSLBjG06nKmKdzxsEuvNHp8bR3Y9YXX8+7XR4DMWIqnEYfE7PFA2X
	G2Xp7W73Gki4Fuo/ALni6gJYU6xPNYXshyWiJB59yV1mIisXBaHvpbovs/QLdMwbGxR19ef9HwK
	E5pprJ7q6l1Xgsl1H2xMxVnS0PYBS7Nf//Cq9oYjBJTpSBOtZ6h4hOLbLwXgtHZj/eQKfuzR3Br
	TdIzTeRw1vNst2Pwkr61ByHJbcgFKDbhacwxpSpmY/0UeDgbNAJfxZ8qMQ6in5ja6FXYE3TCwO8
	ThKK1Y=
X-Received: by 2002:a17:90b:58e5:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-3933caf3a05mr33753321a91.7.1787033477673;
        Mon, 17 Aug 2026 23:11:17 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:17 -0700 (PDT)
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
Subject: [RFC PATCH 5/7] selftests/damon: add automated layer-by-layer observability test
Date: Tue, 18 Aug 2026 14:10:29 +0800
Message-ID: <20260818061031.827057-6-kunwu.chan@linux.dev>
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

Drive the observe framework end-to-end with a software page-fault PMU
positive control (no hardware PMU required): create a kdamond with a
perf event via the DAMON sysfs interface, run a memory-pressure
workload, capture a bounded trace window, and assert each pipeline
layer from per-run snapshot/delta counter deltas (counters are
cumulative since boot, so the snapshot is taken before the workload
window): callbacks, valid data addresses, ring enqueue/dequeue/
overflow, drain match/update, the four DAMON perf tracepoints, and the
per-CPU state column advancing CREATED/BOUND/ENABLED to RUNNING after
the first callback.

A clean-session guard refuses to run while a kdamond already exists.
Ends with a PMU support verdict (FULLY INTEGRATED / PLUMBING-ONLY /
UNUSABLE).  Cleanup is ownership safe: it tears down only the kdamond,
workload and debugfs mount created by this invocation, and retains the
raw evidence directory by default.

Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |   1 +
 .../selftests/damon/damon_perf_obs_test.sh    | 562 ++++++++++++++++++
 2 files changed, 563 insertions(+)
 create mode 100755 tools/testing/selftests/damon/damon_perf_obs_test.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 2180c328a825..1db8fa95ba2d 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -23,4 +23,5 @@ TEST_PROGS += sysfs_no_op_commit_break.py
 
 EXTRA_CLEAN = __pycache__
 
+TEST_PROGS += damon_perf_obs_test.sh
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/damon_perf_obs_test.sh b/tools/testing/selftests/damon/damon_perf_obs_test.sh
new file mode 100755
index 000000000000..4c4074cdd191
--- /dev/null
+++ b/tools/testing/selftests/damon/damon_perf_obs_test.sh
@@ -0,0 +1,562 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# DAMON Perf Observability Framework — Automated Layer-by-Layer Test
+#
+# Validates all 7 pipeline stages:
+#   Layer 1: Event Create   Layer 2: Event Bind
+#   Layer 3: Event Enable   Layer 4: Sampling (callback)
+#   Layer 5: Ring           Layer 6: Drain
+#   Layer 7: Match & Update
+#
+# The framework counters are cumulative since boot, so this script
+# snapshots them before the workload and reports per-run deltas.  It
+# also clears the trace buffer before the sampling window so trace.txt
+# carries only records produced by this run.
+#
+# Usage:
+#   # Software page-fault positive control (exercises the FULL pipeline,
+#   # works on any machine, no HW PMU required).  Defaults to sampling
+#   # every page fault (period 1); override with --freq/--period:
+#   sudo ./damon_perf_obs_test.sh --pmu software
+#   sudo ./damon_perf_obs_test.sh --pmu software --freq 1 --sample-freq 100
+#
+#   # With ARM SPE:
+#   sudo ./damon_perf_obs_test.sh --pmu arm_spe_0 --freq 0 --period 256
+#
+#   # With any PMU type number:
+#   sudo ./damon_perf_obs_test.sh --pmu-type 38 --freq 0 --period 256
+#
+# Notes:
+#   - `--config N` sets perf_event_attr.config.  For PERF_TYPE_SOFTWARE,
+#     config 2 (PERF_COUNT_SW_PAGE_FAULTS) is the only software event
+#     that populates data->addr; cpu-clock (config 0) delivers callbacks
+#     with addr always 0, so it can only validate Layers 1-4.
+#   - ARM SPE cannot sample through perf_event_create_kernel_counter()
+#     (it requires an AUX ring buffer, see arm_spe_pmu.c), so an SPE run
+#     is expected to report zero callbacks until an AUX backend exists.
+#     A zero-callback delta is the correct "PMU not usable" verdict.
+#
+# Requirements:
+#   - CONFIG_DAMON_PERF_OBSERVE=y (fatal if missing)
+#   - Root privileges
+#   - debugfs mounted
+
+set -e
+
+# ---- defaults ----
+PMU_NAME=""
+PMU_TYPE=""
+PMU_CONFIG=0
+CONFIG_EXPLICIT=0
+FREQ=0
+PERIOD=256
+FREQ_EXPLICIT=0
+PERIOD_EXPLICIT=0
+SAMPLE_FREQ=100
+TIMEOUT=10
+TRACE_WINDOW=3
+TARGET_PID=""
+RESULTS_DIR="/tmp/damon_perf_test_$$"
+PASSED=0
+FAILED=0
+SKIPPED=0
+STRESS_PID=""
+CREATED_KDAMOND=0
+MOUNTED_DEBUGFS=0
+KEEP_RESULTS=${KEEP_RESULTS:-1}
+
+# ---- helpers ----
+pass() { echo "  [PASS] $1"; PASSED=$((PASSED + 1)); }
+fail() { echo "  [FAIL] $1 — $2"; FAILED=$((FAILED + 1)); }
+skip() { echo "  [SKIP] $1 — $2"; SKIPPED=$((SKIPPED + 1)); }
+die()  { echo "FATAL: $1"; exit 1; }
+
+# ---- sysfs roots (kept under 100 columns) ----
+KD=/sys/kernel/mm/damon/admin/kdamonds
+ADMIN=$KD/0
+TRACE=/sys/kernel/debug/tracing
+TPD=$TRACE/events/damon
+PE=$ADMIN/contexts/0/monitoring_attrs/sample/perf_events
+
+# ---- saved pre-test state (restored in cleanup so the test is
+# ---- side-effect free: tracepoints, tracing_on)
+ORIG_TRACING_ON=$(cat $TRACE/tracing_on 2>/dev/null || echo 0)
+ORIG_TP_SAMPLE=$(cat $TRACE/events/damon/damon_perf_sample/enable 2>/dev/null || echo 0)
+ORIG_TP_OVERFLOW=$(cat $TRACE/events/damon/damon_perf_ring_overflow/enable 2>/dev/null || echo 0)
+ORIG_TP_MISSED=$(cat $TRACE/events/damon/damon_perf_report_missed/enable 2>/dev/null || echo 0)
+ORIG_TP_DRAIN=$(cat $TRACE/events/damon/damon_perf_drain/enable 2>/dev/null || echo 0)
+
+cleanup() {
+	echo ""
+	echo "=== Cleaning up ==="
+	if [[ -n "$STRESS_PID" ]]; then
+		kill "$STRESS_PID" 2>/dev/null || true
+		wait "$STRESS_PID" 2>/dev/null || true
+		STRESS_PID=""
+	fi
+	# Tear down only the kdamond instance created by this test.  In
+	# particular, the early "existing kdamonds" guard must be read-only.
+	if [[ "$CREATED_KDAMOND" == "1" ]]; then
+		echo off > $ADMIN/state 2>/dev/null || true
+		echo 0 > $KD/nr_kdamonds 2>/dev/null || true
+		CREATED_KDAMOND=0
+	fi
+	# Restore tracepoint and tracing state
+	echo 0 > $TRACE/tracing_on 2>/dev/null || true
+	echo "$ORIG_TP_SAMPLE" > $TRACE/events/damon/damon_perf_sample/enable 2>/dev/null || true
+	echo "$ORIG_TP_OVERFLOW" > $TPD/damon_perf_ring_overflow/enable 2>/dev/null || true
+	echo "$ORIG_TP_MISSED" > $TPD/damon_perf_report_missed/enable 2>/dev/null || true
+	echo "$ORIG_TP_DRAIN" > $TRACE/events/damon/damon_perf_drain/enable 2>/dev/null || true
+	echo "$ORIG_TRACING_ON" > $TRACE/tracing_on 2>/dev/null || true
+	if [[ "$MOUNTED_DEBUGFS" == "1" ]]; then
+		umount /sys/kernel/debug 2>/dev/null || true
+		MOUNTED_DEBUGFS=0
+	fi
+	[ "$KEEP_RESULTS" != "1" ] && rm -rf "$RESULTS_DIR"
+}
+trap cleanup EXIT
+
+# ---- argument parsing ----
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+		--pmu)       PMU_NAME="$2"; shift 2 ;;
+		--pmu-type)  PMU_TYPE="$2"; shift 2 ;;
+		--config)    PMU_CONFIG="$2"; CONFIG_EXPLICIT=1; shift 2 ;;
+		--freq)      FREQ="$2"; FREQ_EXPLICIT=1; shift 2 ;;
+		--period)    PERIOD="$2"; PERIOD_EXPLICIT=1; shift 2 ;;
+		--sample-freq) SAMPLE_FREQ="$2"; shift 2 ;;
+		--trace-window) TRACE_WINDOW="$2"; shift 2 ;;
+		--timeout)   TIMEOUT="$2"; shift 2 ;;
+		--pid)       TARGET_PID="$2"; shift 2 ;;
+		*) echo "Unknown: $1"; exit 1 ;;
+	esac
+done
+
+# Resolve PMU type
+if [[ -n "$PMU_NAME" && -z "$PMU_TYPE" ]]; then
+	if [[ "$PMU_NAME" == "software" ]]; then
+		PMU_TYPE=1
+	else
+		PMU_TYPE=$(cat /sys/bus/event_source/devices/$PMU_NAME/type 2>/dev/null) ||
+			die "Cannot find PMU: $PMU_NAME"
+	fi
+fi
+[[ -z "$PMU_TYPE" ]] && die "Specify --pmu <name> or --pmu-type <number>"
+
+# For PERF_TYPE_SOFTWARE default to PERF_COUNT_SW_PAGE_FAULTS (config 2):
+# the only software event that carries a data address, i.e. the only one
+# that can exercise Layers 5-7.  Override with --config 0 for a pure
+# plumbing (cpu-clock) smoke test.
+if [[ "$PMU_TYPE" == "1" && "$CONFIG_EXPLICIT" == "0" ]]; then
+	PMU_CONFIG=2
+fi
+
+# For the page-fault positive control, sample every fault (period 1) by
+# default so enough reports flow for the ring/drain/match checks to be
+# meaningful on a short run.  Explicit --freq/--period override this.
+if [[ "$PMU_TYPE" == "1" && "$PMU_CONFIG" == "2" &&
+      "$FREQ_EXPLICIT" == "0" && "$PERIOD_EXPLICIT" == "0" ]]; then
+	FREQ=0
+	PERIOD=1
+fi
+
+# For cpu-clock (config 0), sample_period is a TIME in ns, so the
+# default period 256 would mean 4 MHz of callbacks per CPU.  Never
+# let an unguarded default hit that: fall back to a gentle 100 Hz.
+if [[ "$PMU_TYPE" == "1" && "$PMU_CONFIG" == "0" &&
+      "$FREQ_EXPLICIT" == "0" && "$PERIOD_EXPLICIT" == "0" ]]; then
+	FREQ=1
+	SAMPLE_FREQ=100
+fi
+
+# ---- Layer 0: Environment ----
+echo "=========================================="
+echo " DAMON Perf Observability — Layer-by-Layer Test"
+echo "=========================================="
+echo "PMU type: $PMU_TYPE  config: $PMU_CONFIG  freq: $FREQ  period: $PERIOD  timeout: ${TIMEOUT}s"
+if [[ -n "$TARGET_PID" ]]; then
+	echo "Target PID: $TARGET_PID (explicit)"
+else
+	echo "Target PID: workload process (started below)"
+fi
+echo ""
+
+mkdir -p "$RESULTS_DIR"
+
+echo "--- Layer 0: Environment ---"
+
+# Check kernel config
+CONFIG=""
+if [[ -f /proc/config.gz ]]; then
+	CONFIG=$(zcat /proc/config.gz)
+elif [[ -f /boot/config-$(uname -r) ]]; then
+	CONFIG=$(cat /boot/config-$(uname -r))
+else
+	die "Cannot read /proc/config.gz or /boot/config-$(uname -r)"
+fi
+
+for opt in DAMON DAMON_SYSFS DAMON_VADDR PERF_EVENTS DEBUG_FS TRACING \
+		TRACEPOINTS; do
+	if echo "$CONFIG" | grep -q "CONFIG_${opt}=y"; then
+		pass "CONFIG_${opt}=y"
+	else
+		fail "CONFIG_${opt}" "not enabled"
+	fi
+done
+
+# DAMON_PERF_OBSERVE is fatal — the test cannot run without it
+if echo "$CONFIG" | grep -q "CONFIG_DAMON_PERF_OBSERVE=y"; then
+	pass "CONFIG_DAMON_PERF_OBSERVE=y"
+else
+	die "kernel not built with CONFIG_DAMON_PERF_OBSERVE=y"
+fi
+
+# Check root
+[[ $(id -u) -eq 0 ]] || die "Must run as root"
+
+# Mount debugfs only when this test owns the mount, and undo it on exit.
+if ! mountpoint -q /sys/kernel/debug; then
+	mount -t debugfs none /sys/kernel/debug || die "Cannot mount debugfs"
+	MOUNTED_DEBUGFS=1
+fi
+[[ -d /sys/kernel/debug/damon ]] || die "debugfs damon/ not found"
+pass "debugfs mounted"
+
+# Check tracepoints
+for tp in damon_perf_sample damon_perf_ring_overflow damon_perf_report_missed damon_perf_drain; do
+	if [[ -d /sys/kernel/debug/tracing/events/damon/$tp ]]; then
+		pass "tracepoint $tp exists"
+	else
+		fail "tracepoint $tp" "not found"
+	fi
+done
+
+# Check debugfs file (perf_stats only; format is debug-only, not an ABI)
+if [[ -f /sys/kernel/debug/damon/perf_stats ]]; then
+	pass "debugfs perf_stats exists"
+else
+	fail "debugfs perf_stats" "not found"
+fi
+
+# ---- Guard: refuse to run if kdamonds already exist ----
+NR_KDAMONDS=$(cat $KD/nr_kdamonds 2>/dev/null || echo 0)
+if [[ "$NR_KDAMONDS" -gt 0 ]]; then
+	skip "runtime" "kdamonds exist (nr_kdamonds=$NR_KDAMONDS) — refusing"
+	KEEP_RESULTS=1
+	exit 0
+fi
+
+# ---- Generate memory pressure workload first: the default DAMON
+# ---- target must be the workload process itself, so the workload
+# ---- must be running before the target PID is written.
+echo ""
+echo "Starting memory workload for ${TIMEOUT}s..."
+if command -v stress-ng &>/dev/null; then
+	stress-ng --vm 2 --vm-bytes 256M --timeout "${TIMEOUT}s" &
+	STRESS_PID=$!
+elif command -v stress &>/dev/null; then
+	stress --vm 2 --vm-bytes 256M --timeout "${TIMEOUT}s" &
+	STRESS_PID=$!
+else
+	# Fallback: dd-based memory pressure
+	dd if=/dev/zero of=/dev/null bs=1M count=1024 &
+	STRESS_PID=$!
+fi
+
+# Resolve target PID: explicit --pid wins, otherwise the workload
+if [[ -z "$TARGET_PID" ]]; then
+	TARGET_PID=$STRESS_PID
+fi
+
+echo ""
+echo "--- Layer 1: Event Create ---"
+
+# Configure kdamond
+echo 1 > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
+CREATED_KDAMOND=1
+echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts
+echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets
+echo "$TARGET_PID" > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/0/pid_target
+
+# Disable page-fault-based access check
+echo 0 > $PE/nr_perf_events 2>/dev/null || true
+
+# Configure perf event
+echo 1 > $PE/nr_perf_events
+echo "$PMU_TYPE" > $PE/0/type
+echo "$PMU_CONFIG" > $PE/0/config
+
+if [[ "$FREQ" -eq 1 ]]; then
+	echo "$SAMPLE_FREQ" > $PE/0/sample_freq
+else
+	echo "$PERIOD" > $PE/0/sample_period
+fi
+echo "$FREQ" > $PE/0/freq
+
+# Take a dmesg snapshot before enabling the kdamond, so we can
+# detect error messages that appear during the test.
+DMESG_BEFORE="$RESULTS_DIR/dmesg_before.txt"
+dmesg > "$DMESG_BEFORE" 2>/dev/null || true
+# Snapshot counters BEFORE the workload window.  All counters are
+# cumulative since boot; every Analysis number below is a delta against
+# this snapshot.  Read before echo on so the window starts at zero.
+STATS_BASE="$RESULTS_DIR/perf_stats_base.txt"
+cat /sys/kernel/debug/damon/perf_stats > "$STATS_BASE" 2>/dev/null || true
+
+echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state
+sleep 2
+
+DMESG_OUT="$RESULTS_DIR/dmesg_create.txt"
+DMESG_DELTA="$RESULTS_DIR/dmesg_delta.txt"
+dmesg > "$DMESG_OUT" 2>/dev/null || true
+# Delta: lines in $DMESG_OUT not already present in $DMESG_BEFORE
+awk 'NR==FNR { seen[$0]++ }
+     NR>FNR { if (seen[$0] > 0) seen[$0]--; else print }' \
+	"$DMESG_BEFORE" "$DMESG_OUT" > "$DMESG_DELTA" || true
+
+# Check state is on
+STATE_VAL=$(cat /sys/kernel/mm/damon/admin/kdamonds/0/state 2>/dev/null)
+if [[ "$STATE_VAL" == "on" ]]; then
+	pass "Kdamond state is on"
+else
+	fail "Kdamond state" "expected 'on', got '$STATE_VAL'"
+fi
+
+echo ""
+echo "--- Layer 2-3: Enable & Run (via per-CPU state) ---"
+
+# Parse the maximum per-CPU state from the debugfs output.
+# The per-CPU line format is:
+#   CPU%02d: st=<state> cb=... enq=... ...
+max_cpu_state() {
+	awk -F'st=' '/^  CPU/ {
+		split($2, a, " ")
+		s = a[1]
+		# Map state name to numeric rank
+		if (s == "ERROR")   v = 5
+		else if (s == "RUNNING") v = 4
+		else if (s == "ENABLED") v = 3
+		else if (s == "BOUND")   v = 2
+		else if (s == "CREATED") v = 1
+		else v = 0
+		if (v > max) max = v
+	} END { print max+0 }' "$1" 2>/dev/null
+}
+
+CPU_ST_BASE=$(max_cpu_state "$STATS_BASE")
+
+if [[ "$CPU_ST_BASE" -ge 1 ]]; then
+	pass "Event Created (max per-CPU state >= CREATED)"
+else
+	fail "Event Created" "max per-CPU state is $CPU_ST_BASE"
+fi
+
+if [[ "$CPU_ST_BASE" -ge 2 ]]; then
+	pass "Event Bound (max per-CPU state >= BOUND)"
+else
+	fail "Event Bound" "max per-CPU state is $CPU_ST_BASE"
+fi
+
+if [[ "$CPU_ST_BASE" -ge 3 ]]; then
+	pass "Event Enabled (max per-CPU state >= ENABLED)"
+else
+	fail "Event Enabled" "max per-CPU state is $CPU_ST_BASE"
+fi
+
+# Check dmesg delta for errors (vaddr.c pr_warn_ratelimited paths)
+if grep -q 'damon-perf.*failed\|event create failed' "$DMESG_DELTA" 2>/dev/null; then
+	fail "Perf event" "perf event creation failed (see dmesg delta)"
+else
+	pass "Perf event creation (no errors in dmesg delta)"
+fi
+
+echo ""
+echo "--- Layer 4: Sampling (Callback) ---"
+
+# Clear the trace buffer so trace.txt only contains records produced by
+# this run, then enable tracepoints for a bounded sampling window.
+echo 0 > $TRACE/tracing_on 2>/dev/null || true
+echo > $TRACE/trace 2>/dev/null || true
+echo 1 > $TRACE/events/damon/damon_perf_sample/enable
+echo 1 > $TRACE/events/damon/damon_perf_ring_overflow/enable
+echo 1 > $TRACE/events/damon/damon_perf_report_missed/enable
+echo 1 > $TRACE/events/damon/damon_perf_drain/enable
+echo 1 > $TRACE/tracing_on
+
+# Sampling window: keeps trace.txt bounded even on PMUs that sample at
+# tens of kHz.  Counters keep accumulating for the full TIMEOUT.
+sleep "$TRACE_WINDOW"
+echo 0 > $TRACE/tracing_on 2>/dev/null || true
+[[ "$TIMEOUT" -gt "$TRACE_WINDOW" ]] && sleep $((TIMEOUT - TRACE_WINDOW))
+
+kill $STRESS_PID 2>/dev/null || true
+wait $STRESS_PID 2>/dev/null || true
+STRESS_PID=""
+echo "Workload done."
+
+sleep 2  # let kdamond drain
+
+# Collect trace
+TRACE_OUT="$RESULTS_DIR/trace.txt"
+cat /sys/kernel/debug/tracing/trace > "$TRACE_OUT" 2>/dev/null || true
+TRACE_LINES=$(wc -l < "$TRACE_OUT" 2>/dev/null || echo 0)
+
+# Collect stats (re-read after workload)
+STATS_OUT="$RESULTS_DIR/perf_stats.txt"
+cat /sys/kernel/debug/damon/perf_stats > "$STATS_OUT" 2>/dev/null || true
+
+# ---- Analysis ----
+echo ""
+echo "--- Analysis ---"
+
+
+# Aggregate counter reads
+stat_of() {
+	awk -v k="$1" '$1==k {print $2}' "$2" 2>/dev/null
+}
+
+# Per-run delta between baseline and post-workload snapshots
+delta() {
+	local b a
+	b=$(stat_of "$1" "$STATS_BASE")
+	a=$(stat_of "$1" "$STATS_OUT")
+	[[ -z "$b" ]] && b=0
+	[[ -z "$a" ]] && a=0
+	echo $((a-b))
+}
+
+CALLBACK=$(delta callback)
+VALID=$(delta valid)
+ADDR_ZERO=$(delta addr_zero)
+KERNEL=$(delta kernel)
+ENQUEUE=$(delta enqueue)
+DEQUEUE=$(delta dequeue)
+OVERFLOW=$(delta overflow)
+MATCH=$(delta match)
+UPDATE=$(delta update)
+
+echo "  Callback delta this run: ${CALLBACK} (cumulative totals in perf_stats.txt)"
+
+if [[ "$CALLBACK" -gt 0 ]]; then
+	pass "Sampling: ${CALLBACK} callbacks received"
+else
+	fail "Sampling" "0 callbacks — PMU is not delivering samples to DAMON"
+fi
+
+echo "  Callback breakdown (delta): valid=${VALID} addr_zero=${ADDR_ZERO} kernel=${KERNEL}"
+
+# Verify RUNNING state: first callback advances per-CPU state to
+# RUNNING, which persists until the kdamond is stopped.
+CPU_ST_FINAL=$(max_cpu_state "$STATS_OUT")
+if [[ "$CALLBACK" -gt 0 && "$CPU_ST_FINAL" -ge 4 ]]; then
+	pass "Event Running (max per-CPU state >= RUNNING)"
+elif [[ "$CALLBACK" -eq 0 ]]; then
+	skip "Event Running" "no callbacks — state cannot advance past ENABLED"
+else
+	fail "Event Running" "callbacks > 0 but max state is $CPU_ST_FINAL"
+fi
+
+echo "  Ring: enqueue=${ENQUEUE} dequeue=${DEQUEUE} overflow=${OVERFLOW}"
+
+if [[ "$ENQUEUE" -gt 0 ]]; then
+	pass "Ring: enqueue > 0"
+	if [[ "$DEQUEUE" -gt 0 ]]; then
+		pass "Ring: dequeue > 0"
+	else
+		fail "Ring: dequeue" "enqueued but never dequeued"
+	fi
+else
+	skip "Ring" "no enqueues (no valid samples: addr=0 or no callbacks)"
+fi
+
+echo "  Match: match=${MATCH} update=${UPDATE}"
+
+if [[ "$MATCH" -gt 0 ]]; then
+	pass "Drain & Match: ${MATCH} matched"
+	if [[ "$UPDATE" -gt 0 ]]; then
+		pass "Update: ${UPDATE} region updates"
+	else
+		fail "Update" "matched but never updated"
+	fi
+else
+	skip "Match/Update" "no matches (no valid samples reached region matching)"
+fi
+
+# Drain tracepoint: kdamond fires damon_perf_drain whenever it drained
+# at least one report.  The drain tracepoint is only expected when the
+# ring actually produced entries.
+DRAIN_COUNT=$(grep -c "damon_perf_drain" "$TRACE_OUT" 2>/dev/null || true)
+DRAIN_COUNT=${DRAIN_COUNT:-0}
+echo "  Drain tracepoint: ${DRAIN_COUNT} records"
+if [[ "$MATCH" -gt 0 ]]; then
+	if [[ "$DRAIN_COUNT" -gt 0 ]]; then
+		pass "Drain tracepoint fired (${DRAIN_COUNT} records)"
+	else
+		fail "Drain tracepoint" "matches occurred but damon_perf_drain never fired"
+	fi
+else
+	skip "Drain tracepoint" "no drained reports to summarize"
+fi
+
+# Context verification
+if grep -q 'context=' "$TRACE_OUT" 2>/dev/null; then
+	NMI_COUNT=$(grep -c 'context=3' "$TRACE_OUT" 2>/dev/null || true)
+	PROC_COUNT=$(grep -c 'context=0' "$TRACE_OUT" 2>/dev/null || true)
+	NMI_COUNT=${NMI_COUNT:-0}
+	PROC_COUNT=${PROC_COUNT:-0}
+	echo "  Context: NMI=${NMI_COUNT} process=${PROC_COUNT}"
+	pass "Context field in trace output"
+else
+	skip "Context" "no trace output to analyze"
+fi
+
+# Show a few sample records as raw evidence (they are the per-sample
+# view of the pipeline; useful for PMU support evaluation).
+echo ""
+echo "  First damon_perf_sample record(s) this run:"
+if grep -q "damon_perf_sample" "$TRACE_OUT" 2>/dev/null; then
+	grep -m 3 "damon_perf_sample" "$TRACE_OUT" | sed 's/^/    /'
+else
+	echo "    (none — no samples captured in the ${TRACE_WINDOW}s window)"
+fi
+echo "  First damon_perf_drain record(s) this run:"
+if grep -q "damon_perf_drain" "$TRACE_OUT" 2>/dev/null; then
+	grep -m 3 "damon_perf_drain" "$TRACE_OUT" | sed 's/^/    /'
+else
+	echo "    (none)"
+fi
+
+# ---- PMU support verdict ----
+echo ""
+echo "--- PMU support verdict ---"
+if [[ "$CALLBACK" -eq 0 ]]; then
+	echo "  UNUSABLE: the PMU never delivered a sample to DAMON"
+	echo "  (e.g. ARM SPE requires an AUX ring buffer that kernel"
+	echo "  counters do not provide; see arm_spe_pmu.c)"
+elif [[ "$VALID" -eq 0 ]]; then
+	echo "  PLUMBING-ONLY: callbacks flow but no data addresses"
+	echo "  (address-less PMU, e.g. cpu-clock / task-clock)"
+elif [[ "$ENQUEUE" -gt 0 && "$MATCH" -gt 0 ]]; then
+	echo "  FULLY INTEGRATED: samples carry addresses and reach"
+	echo "  DAMON region matching/update"
+else
+	echo "  PARTIAL: callbacks with addresses, but the drain/match"
+	echo "  pipeline did not complete (see counters above)"
+fi
+
+# ---- Summary ----
+echo ""
+echo "=========================================="
+echo " SUMMARY: $PASSED passed, $FAILED failed, $SKIPPED skipped"
+echo "=========================================="
+echo ""
+echo "Results retained in: $RESULTS_DIR (set KEEP_RESULTS=0 to remove)"
+
+if [[ "$FAILED" -gt 0 ]]; then
+	echo "Overall: FAIL ($FAILED checks failed)"
+	exit 1
+else
+	echo "Overall: PASS"
+	exit 0
+fi
-- 
2.43.0

