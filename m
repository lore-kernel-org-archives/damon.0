Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3273E5585
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033473; cv=none; b=p2J8oFS+Sp+I7CoS+gbmRPuCAwVuyy01D1REtfI/Pi/ym87tOxMyjirjAGY9XKIILNUXXbmOGKggBbG1a7JpjvF8tZP2Qy3PaP8LKsp2S3LWtnmwd12g7XfykWrAJD64e9aPKQKsXBe4IzwKgRfLZvRInOjh+hq44x6RcfHIGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033473; c=relaxed/simple;
	bh=GCJfR6dFKIlj1FLeCSmVPQc4zronWrksr3AN1wVaOAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNpioR0povs9pMIrKrn56kJLY44M+Oauugksr+0VuP/EUxHkIfji8CoFKwJvDGJw9clOLi8lNNk56FfMPlstE0jnspzD4oTFMy/jq2n4yaxpJ6qQ8m4p5FHJOM9vYI0mv3lwl/1vdtnHTT/SQBoW0e79w2D/dXAf5Ol4Lo3cJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcSTcoiA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcSTcoiA"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so3543107a91.0
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 23:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033471; x=1787638271; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7MnRAqJMoLRpsIrwycTnpOzFMIb3xRRTSx1mdIHCeG0=;
        b=lcSTcoiAKiAWIlRlsycpcnC+HWnznfE963D1dnldwnG+R6njt6kW4SED81i9+fUYPc
         XY1Ix9KmotofdI7A+vpOXFtwXE7rutlEPCPG6aPW4Zpck/8fwlhhoeAPFS6dNt5JjHyT
         fCmRSuppI4SRl18cQN/Vw0FTq2pILABMj1mLX/0PWzBYjF9bY0WBtOZtz6vPJdD/UjYz
         BnSAixunuxsFagj6lh8eU6dIWvpOxNPsC2Cx6weZZVFH667PKGd5E/HkSAHqSF//Np1v
         DOtVY59oA4OrxVr94057bR/7XMisa9XpskTe2DMJX/FaA5hrtPS1P0mM1J/pPLQrOIcR
         szlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033471; x=1787638271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MnRAqJMoLRpsIrwycTnpOzFMIb3xRRTSx1mdIHCeG0=;
        b=RBSZ6DCtomb3y7hX093zsDqOON3g9DL/UTwLASbr8AlSYKvuvS3xc27YSn+rRLm6d1
         4LbPjIVF8uaB1NdIj3STaR9GsFwKQTDNWhFxWnJU8ALe6asC0l8rsiT1H0M9icrYxQOK
         RR5vGRsqP0m/hDxT5b8l+tLj0jofrrSL54fCWAwc+g/tgGjozvk2K1dFHPVbjsI8ZiTd
         4G0+gFQka/c/iLrFxHp2iBj5Kch1H1hAzWAGJJ2FiQ/JwLPUS9jl9xKbfhRhlPElSHxf
         YdnGZounSlOOjGJwqfKpYsvT7KPo7Rdnxoq5NdJgMv4YbIta3hDC9bzrxtuGsUh8W1hy
         610g==
X-Gm-Message-State: AOJu0YyvTfIBSaVRJk5wZVeiYjQ/+Nc4PegRyWv14RtaywmS9vKsLkJ/
	4qN0AyRUDlRuXvP6YGa9ZTpEC5JEmp63KZBAdW9FNnoZnJcjt97MQWuKIKvCe8lX
X-Gm-Gg: AR+sD13K1yHXUmwRPu6ioa/wrjxm7w7eHLTiLiTvP2MydzzD0DaqZOF/88s25QPzLxI
	NgH1SX1dgQP9AB8UZxeuSL+i67LaL7xP9QgeBBd6Ca9ycDGmGpMloWNRpvyAttzRrt0JqsRs3Bq
	hREbQyKZehmb5iwUsPm8+E5pVmSNe8HWtMlgLpzWpbdkIv2WuJbjkaSlMoLj9we2J7k2ZPqsAjV
	Oqpv1UHv5a7TrMS2EO2Ol2LC+OJaz2lywvdHLTKMizyZ7kSX2R7VZoWv6mHprwlbze/C7SvZw5k
	dPuBCurWQwjHjqVBgdXA31Qb9+2xuT0NF2RdTyEZ4brFob6bi1zRcLIKUrd8vyNVgbjCoh9qhhc
	UtbSygI7Lsrix2M4sqi2jMRmrLjG+Qeik673DyC2Nu2gaFc1pOl0G5h57njYo0gSdsJfWLK5e47
	i1++fawousDQfKrGdCRXEH/TfMwmBH5HwjpgHq1OkHP8Wol8/KV4acxjnX1cbKpVbfKaitPcOa/
	gCENhs=
X-Received: by 2002:a17:90b:1d45:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-3933b7c3b71mr32119576a91.1.1787033470824;
        Mon, 17 Aug 2026 23:11:10 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:10 -0700 (PDT)
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
Subject: [RFC PATCH 4/7] mm/damon: integrate observe API into vaddr overflow handlers and core drain
Date: Tue, 18 Aug 2026 14:10:28 +0800
Message-ID: <20260818061031.827057-5-kunwu.chan@linux.dev>
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

Wire the observe_*() calls into the DAMON hot paths: vaddr access-check
overflow handlers report into the per-CPU ring, and the kdamond drain
matches each report against the target whose tgid owns it.  The observe
calls are pure side-effect statistics (no-ops under
CONFIG_DAMON_PERF_OBSERVE=n), so the switch never changes DAMON matching
semantics.  The vaddr teardown frees the per-event cpu_state array.

Read ring->tail once with READ_ONCE in damon_report_access() and reuse
the cached value for the peak-occupancy estimate, avoiding a torn read
and a compiler reload on the producer side.

Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 mm/damon/core.c  | 129 +++++++++++++++++++++++++++++++++++++----------
 mm/damon/vaddr.c | 104 +++++++++++++++++++++++++++++++++++---
 2 files changed, 199 insertions(+), 34 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 609d627e2b33..377f07122fb0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -21,6 +21,7 @@
 
 /* for damon_get_folio() used by node eligible memory metrics */
 #include "ops-common.h"
+#include "perf/perf.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
@@ -2243,24 +2244,41 @@ void damon_report_access(struct damon_access_report *report)
 	preempt_disable();
 	if (local_inc_return(this_cpu_ptr(&damon_report_ring_busy)) != 1) {
 		/* NMI nested on a process-context producer; drop. */
-		trace_damon_perf_ring_overflow(smp_processor_id());
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+		damon_perf_observe_ring_overflow(smp_processor_id());
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 		goto out;
 	}
 
 	ring = this_cpu_ptr(&damon_report_rings);
 	head = ring->head;
 	next = (head + 1) & DAMON_REPORT_RING_MASK;
+	{
+		unsigned int tail = READ_ONCE(ring->tail);
 
-	if (next == READ_ONCE(ring->tail)) {
-		trace_damon_perf_ring_overflow(smp_processor_id());
-		goto out;
-	}
+		if (next == tail) {
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+			damon_perf_observe_ring_overflow(smp_processor_id());
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
+			goto out;
+		}
 
-	ring->entries[head] = *report;
-	ring->entries[head].report_jiffies = jiffies;
-	smp_wmb(); /* publish entry before head advance */
-	WRITE_ONCE(ring->head, next);
-	WRITE_ONCE(*this_cpu_ptr(&damon_ring_pending), 1);
+		ring->entries[head] = *report;
+		ring->entries[head].report_jiffies = jiffies;
+		smp_wmb(); /* publish entry before head advance */
+		WRITE_ONCE(ring->head, next);
+		WRITE_ONCE(*this_cpu_ptr(&damon_ring_pending), 1);
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+		damon_perf_observe_ring_enqueue();
+		/*
+		 * Track peak occupancy for health evaluation.
+		 * next is the new head; tail was read before enqueue
+		 * (may be slightly stale — acceptable for a peak estimate).
+		 */
+		damon_perf_observe_ring_peak(
+				(next - tail) & DAMON_REPORT_RING_MASK);
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
+	}
 out:
 	local_dec(this_cpu_ptr(&damon_report_ring_busy));
 	preempt_enable();
@@ -2276,6 +2294,9 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 		.tid = current->pid,
 		.tgid = task_tgid_nr(current),
 		.is_write = vmf->flags & FAULT_FLAG_WRITE,
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+		.source = DAMON_REPORT_SRC_PAGE_FAULT,
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 	};
 
 	if (huge_pmd)
@@ -3917,8 +3938,16 @@ static bool damon_sample_filter_out(struct damon_access_report *report,
 	return !filter->allow;
 }
 
-static void kdamond_apply_access_report(struct damon_access_report *report,
-		struct damon_target *t,
+/*
+ * Try to apply one access report to a target's region snapshot.
+ *
+ * Caller has already resolved tgid (for pid-based monitoring), so this
+ * function only does address-to-region matching.  Miss reasons for
+ * trace_damon_perf_report_missed use enum damon_report_miss_reason.
+ *
+ * Return: true if the report fell inside a known region, false otherwise.
+ */
+static bool kdamond_apply_access_report(struct damon_access_report *report,
 		struct damon_region **regions, unsigned int nr_regions,
 		struct damon_ctx *ctx)
 {
@@ -3926,13 +3955,7 @@ static void kdamond_apply_access_report(struct damon_access_report *report,
 	unsigned long addr;
 	int left, right, mid;
 
-	if (damon_target_has_pid(ctx)) {
-		if (pid_nr(t->pid) != report->tgid)
-			return;
-		addr = report->vaddr;
-	} else {
-		addr = report->paddr;
-	}
+	addr = damon_target_has_pid(ctx) ? report->vaddr : report->paddr;
 
 	/* Binary search the snapshot for the region containing addr. */
 	left = 0;
@@ -3951,17 +3974,27 @@ static void kdamond_apply_access_report(struct damon_access_report *report,
 		}
 	}
 
-	if (!r)
-		return;
+	if (!r) {
+		damon_perf_observe_miss(addr, report->cpu,
+				DAMON_REPORT_MISS_NOREGION);
+		return false;
+	}
 	/* Reject reports straddling a region boundary. */
-	if (addr + report->size > r->ar.end)
-		return;
+	if (addr + report->size > r->ar.end) {
+		damon_perf_observe_miss(addr, report->cpu,
+				DAMON_REPORT_MISS_BOUNDARY);
+		return false;
+	}
 	if (!r->access_reported) {
 		damon_update_region_access_rate(r, true, &ctx->attrs);
 		r->access_reported = true;
+		damon_perf_observe_update(report->cpu);
 	}
+	damon_perf_observe_match(addr, report->cpu);
+	return true;
 }
 
+
 static unsigned int kdamond_apply_zero_access_report(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
@@ -4045,6 +4078,7 @@ static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 	struct damon_target_lookup *tbl;
 	unsigned int nr_targets = 0;
 	unsigned int i;
+	unsigned int total_reports = 0, matched_reports = 0;
 
 	tbl = damon_build_target_lookup(ctx, &nr_targets);
 	if (!tbl) {
@@ -4077,6 +4111,10 @@ static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 		while (tail != head) {
 			struct damon_access_report *report =
 				&ring->entries[tail];
+			bool applied = false;
+
+			/* Count every entry removed from the ring */
+			damon_perf_observe_ring_dequeue(report->cpu);
 
 			if (time_before(report->report_jiffies,
 					jiffies - usecs_to_jiffies(
@@ -4085,16 +4123,52 @@ static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 			if (damon_sample_filter_out(report,
 					&ctx->sample_control))
 				goto next;
-			for (i = 0; i < nr_targets; i++)
-				kdamond_apply_access_report(report,
-						tbl[i].t,
+			/*
+			 * For pid-based monitoring, resolve tgid to the
+			 * single matching target before calling
+			 * kdamond_apply_access_report(), avoiding a
+			 * spurious miss tracepoint for every non-matching
+			 * target.
+			 */
+			if (damon_target_has_pid(ctx)) {
+				for (i = 0; i < nr_targets; i++) {
+					if (pid_nr(tbl[i].t->pid) ==
+							report->tgid) {
+						applied =
+					    kdamond_apply_access_report(
+							report,
+							tbl[i].regions,
+							tbl[i].nr_regions,
+							ctx);
+						break;
+					}
+				}
+				if (!applied && i == nr_targets)
+					damon_perf_observe_miss(
+						report->vaddr,
+						report->cpu,
+						DAMON_REPORT_MISS_TGID);
+			} else {
+				for (i = 0; i < nr_targets; i++)
+					applied |=
+					    kdamond_apply_access_report(
+						report,
 						tbl[i].regions,
 						tbl[i].nr_regions, ctx);
+			}
+			total_reports++;
+			if (applied)
+				matched_reports++;
+
 next:
 			tail = (tail + 1) & DAMON_REPORT_RING_MASK;
 		}
 		WRITE_ONCE(ring->tail, tail);
 	}
+
+	if (total_reports)
+		damon_perf_observe_drain(total_reports, matched_reports);
+
 	/* For nr_accesses_bp, absence of access should also be reported. */
 	return kdamond_apply_zero_access_report(ctx);
 }
@@ -4158,8 +4232,9 @@ static int kdamond_fn(void *data)
 		ctx->passed_sample_intervals++;
 
 		if (!list_empty(&ctx->perf_events) ||
-		    ctx->sample_control.primitives_enabled.page_fault)
+		    ctx->sample_control.primitives_enabled.page_fault) {
 			max_nr_accesses = kdamond_check_reported_accesses(ctx);
+		}
 		else if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 73fcea91afa0..a68c7262d533 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -17,6 +17,8 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 
+#include "perf/perf.h"
+
 #include "../internal.h"
 #include "ops-common.h"
 
@@ -975,13 +977,49 @@ static void damon_perf_overflow_vaddr(struct perf_event *perf_event,
 		struct perf_sample_data *data, struct pt_regs *regs)
 {
 	struct damon_access_report report;
+	u64 data_src_val;
+	u64 period_val;
+
+	/*
+	 * Observe every hardware sample through the unified API.
+	 *
+	 * reason encodes why a sample was dropped at the handler level:
+	 *   0 = valid, queued to ring
+	 *   1 = data == NULL
+	 *   2 = addr == 0 (PMU did not populate data->addr)
+	 *   3 = kernel address (addr >= TASK_SIZE)
+	 */
+	if (!data) {
+		damon_perf_observe_sample(0, 0, 0,
+				smp_processor_id(), 1, 0,
+				perf_event->attr.sample_type);
+		return;
+	}
 
-	if (!data || !data->addr)
+	data_src_val = data->data_src.val;
+	period_val = data->period;
+
+	if (!data->addr) {
+		damon_perf_observe_sample(0, data_src_val, period_val,
+				smp_processor_id(), 2,
+				data->sample_flags,
+				perf_event->attr.sample_type);
 		return;
+	}
 
 	/* Drop kernel-VA hits -- only user-space VAs land in damon vaddr regions. */
-	if (data->addr >= TASK_SIZE)
+	if (data->addr >= TASK_SIZE) {
+		damon_perf_observe_sample(data->addr, data_src_val, period_val,
+				smp_processor_id(), 3,
+				data->sample_flags,
+				perf_event->attr.sample_type);
 		return;
+	}
+
+	damon_perf_observe_sample(data->addr, data_src_val, period_val,
+			smp_processor_id(), 0,
+			data->sample_flags,
+			perf_event->attr.sample_type);
 
 	report = (struct damon_access_report){
 		.vaddr = data->addr & PAGE_MASK,
@@ -990,6 +1028,9 @@ static void damon_perf_overflow_vaddr(struct perf_event *perf_event,
 		.tid = current->pid,
 		.tgid = current->tgid,
 		.is_write = !!(data->data_src.mem_op & PERF_MEM_OP_STORE),
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+		.source = DAMON_REPORT_SRC_PERF_OVERFLOW,
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 	};
 	damon_report_access(&report);
 }
@@ -998,9 +1039,18 @@ static void damon_perf_overflow_paddr(struct perf_event *perf_event,
 		struct perf_sample_data *data, struct pt_regs *regs)
 {
 	struct damon_access_report report;
+	u64 data_src_val;
+	u64 period_val;
 
-	if (!data)
+	if (!data) {
+		damon_perf_observe_sample(0, 0, 0,
+				smp_processor_id(), 1, 0,
+				perf_event->attr.sample_type);
 		return;
+	}
+
+	data_src_val = data->data_src.val;
+	period_val = data->period;
 
 	/*
 	 * AMD IBS Op only populates data->phys_addr when
@@ -1008,14 +1058,27 @@ static void damon_perf_overflow_paddr(struct perf_event *perf_event,
 	 * carries a stale value.  Gate on sample_flags rather than testing
 	 * phys_addr for zero (which would also drop legitimate page 0).
 	 */
-	if (!(data->sample_flags & PERF_SAMPLE_PHYS_ADDR))
+	if (!(data->sample_flags & PERF_SAMPLE_PHYS_ADDR)) {
+		damon_perf_observe_sample(0, data_src_val,
+				period_val, smp_processor_id(), 4,
+				data->sample_flags,
+				perf_event->attr.sample_type);
 		return;
+	}
+
+	damon_perf_observe_sample(data->phys_addr, data_src_val, period_val,
+			smp_processor_id(), 0,
+			data->sample_flags,
+			perf_event->attr.sample_type);
 
 	report = (struct damon_access_report){
 		.paddr = data->phys_addr & PAGE_MASK,
 		.size = PAGE_SIZE,
 		.cpu = smp_processor_id(),
 		.is_write = !!(data->data_src.mem_op & PERF_MEM_OP_STORE),
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+		.source = DAMON_REPORT_SRC_PERF_OVERFLOW,
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 	};
 	damon_report_access(&report);
 }
@@ -1070,6 +1133,8 @@ static int damon_perf_cpu_online(unsigned int cpu, struct hlist_node *node)
 	if (!perf)
 		return 0;
 
+	damon_perf_observe_event_created(event, cpu);
+
 	damon_perf_event_init_attr(event, &attr);
 
 	/*
@@ -1092,14 +1157,20 @@ static int damon_perf_cpu_online(unsigned int cpu, struct hlist_node *node)
 		return 0;	/* never block CPU online */
 	}
 	*per_cpu_ptr(perf->event, cpu) = perf_event;
+
+	damon_perf_observe_event_bound(event, cpu, perf_event);
+
 	/*
 	 * Late-online CPU after the substrate is armed: events are created
 	 * with attr.disabled = 1 and would otherwise stay quiescent on this
 	 * CPU until the next arm walk.  Enable here so coverage matches the
 	 * already-online CPUs.
 	 */
-	if (event->ctx && READ_ONCE(event->ctx->perf_events_active))
+	if (event->ctx && READ_ONCE(event->ctx->perf_events_active)) {
 		perf_event_enable(perf_event);
+		damon_perf_observe_event_enabled(event, cpu,
+				perf_event->state, perf_event->oncpu);
+	}
 	return 0;
 }
 
@@ -1115,6 +1186,7 @@ static int damon_perf_cpu_offline(unsigned int cpu, struct hlist_node *node)
 
 	perf_event = per_cpu(*perf->event, cpu);
 	if (perf_event) {
+		damon_perf_observe_event_destroyed(event, cpu);
 		perf_event_disable(perf_event);
 		perf_event_release_kernel(perf_event);
 		*per_cpu_ptr(perf->event, cpu) = NULL;
@@ -1133,8 +1205,12 @@ void damon_perf_event_arm(struct damon_perf_event *event)
 
 	for_each_online_cpu(cpu) {
 		perf_event = *per_cpu_ptr(perf->event, cpu);
-		if (perf_event)
+		if (perf_event) {
 			perf_event_enable(perf_event);
+			damon_perf_observe_event_enabled(event, cpu,
+					perf_event->state,
+					perf_event->oncpu);
+		}
 	}
 }
 
@@ -1149,8 +1225,11 @@ void damon_perf_event_disarm(struct damon_perf_event *event)
 
 	for_each_online_cpu(cpu) {
 		perf_event = *per_cpu_ptr(perf->event, cpu);
-		if (perf_event)
+		if (perf_event) {
 			perf_event_disable(perf_event);
+			damon_perf_observe_event_disabled(event, cpu,
+					perf_event->state);
+		}
 	}
 }
 
@@ -1192,6 +1271,7 @@ int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
 	return 0;
 
 free_event:
+	damon_perf_observe_event_free(event);
 	free_percpu(perf->event);
 free_perf:
 	kfree(perf);
@@ -1203,6 +1283,8 @@ void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event)
 {
 	struct damon_perf *perf = event->priv;
 
+	damon_perf_observe_event_free(event);
+
 	if (!perf)
 		return;
 
@@ -1244,6 +1326,14 @@ static int __init damon_va_initcall(void)
 	if (err < 0)
 		return err;
 	damon_perf_cpuhp_state = err;
+
+#ifdef CONFIG_DAMON_PERF_OBSERVE
+	err = damon_perf_framework_init();
+	if (err < 0)
+		pr_warn("damon-perf: framework init failed, observability unavailable: %d\n",
+			err);
+	/* Non-fatal: vaddr/fvaddr ops still register. */
+#endif /* CONFIG_DAMON_PERF_OBSERVE */
 #endif
 
 	err = damon_register_ops(&ops);
-- 
2.43.0

