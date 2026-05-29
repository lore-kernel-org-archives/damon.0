Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABE3FFABE
	for <damon@lists.linux.dev>; Fri, 29 May 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073831; cv=none; b=dmupKABXkmxhaugTFZDrkurMXjvANsyZz33ulk9DhO5iDxQarVGp7QP/xj4eN0OclF6ra4/g3Pd9wDWvYaaf7IP3koN4FTV09BiNFhoAOfW0DfAr+Oi70gjSLedd8nAEZY5Yz9d9Btym6DQW0eNbdpD3di76J70Tutn4eDs8uS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073831; c=relaxed/simple;
	bh=tUr1nCqvOmJ8pMbk3sKPt+KNtqSVL2gMU1FHcdfHjrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/VwD/cJKvIixDndUj88J/RVwmuO2o97OkDvAQEIXM3ecO1sl+w1lDH2ccpPbbmbp9CRmIWygPqiuCxzShRfPNLmTCJF+OD2eWkev4juoGaHcgYEcqMLDF4u0ZBcd2yEFZYG5k/lV4IoQRdZo3Daq8cfwKIu/8XYIkC8ata5/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiomlo8D; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiomlo8D"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7dcdd1b492eso13495303a34.1
        for <damon@lists.linux.dev>; Fri, 29 May 2026 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073828; x=1780678628; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w8JzV6Ke6m6ss7khBxwWJgK/oI1uoZHRLSFhlaSQYw=;
        b=oiomlo8DAVvf+TFnexwGFmhDICQLu1W9xnXvbOMcgCNemen0Je9aDkZFQ4fdXzrnXR
         qch2Mn6D9gsVOBg2swSJw8OiFb/cmYS0n4POgoxPOHfPNrvNHi2sKjuXZ4KCd2J+AtYl
         5E0LiaEzzpXG5vIt7Okfq8qFpP/2zY5E57vdMpVKyCCEcm+DpJYDD8Kpg4+w3ieJHNhf
         V0CkcZYLf5TdBYkwLgFty8kZjJZmowOqgz4oebEfUaYBk2dwCJUmY7b7y4Hxt8vmBPKo
         7jvyJT6QEgGRSPXPmxaS4Qyrc+XEuhcm8T2X6QL/eFhe4qcaTWeEYFFFLDmzLkLAK7WE
         0Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073828; x=1780678628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9w8JzV6Ke6m6ss7khBxwWJgK/oI1uoZHRLSFhlaSQYw=;
        b=l19JhxVpGmqsuPNNbvR+iUJPrFjU8gHH+KfvlC92n7TemGvTH2qiaEmceJNXwrW4Vf
         DjvrdbEhexzDqJWI4Ooiqy2Myx8uWf5/JDFa0pfy/g66Mfuy0j1pauL7MLDUpzL1dkF8
         pAQcHjRrCr88LlWpF0QZz0T9G5C7sInqtojHna4LoJF9InvH3ojsllHB3PzptT19cASL
         fjJbrPQ022M8fUx7lwk5dhlHONve9b48c3Cs8x0U3dVptCmcKNf5vG8hhRm4wfbQl/z0
         E96jwjiaAKed4WsOh8pvpvg6QfCMBkWvNIrEXDMHxptju6lXoQLtK0d6EOC25L+pXjuI
         +TVw==
X-Forwarded-Encrypted: i=1; AFNElJ+J2B1myMd3cX+B+GqU09TzU75OtlItapOpdZuqyC3H7Q1DRE2MjRXFS0EDivFQ4O/JkEUoBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxg0Z9RqENb92rCE0cRlJt8zacYBB567UuEQWfKKtmGmfItDrO
	yvtuJyNf1Ki3yybB/o37h7vDPy9oWzhzVCZUTue8jzEDS6mjZoez3Ig=
X-Gm-Gg: Acq92OFG31P3vcnto5YG4CGDBbCz4uXQx4Zw0DzVug1BHQ0qxx/xZpGieOyahIyTOqj
	1kGhGwYgLgMnm4DcIUK2K4+gqKbfzvamwZAiP/V+nSfOq8urJF+7TMxSbzeGLHZC5YtQn5YfWfm
	kjN2OEMSZuscd9SVRD1H3vigzGMsr8epWEC0LPTaCP542zHIJoxcX5o+CyrT6SzUhA3YDe/3VRw
	BV2pCgxzhjvpUyNIvOvQawpDuKBJlISayUgnEaBdhV6g1cPiBBRDOneCf4uYwQrF731Tx2FepUR
	PttVQRAgDILjJQ85+dQ3alAZ3iqoelA5ZNOJ1xz7kR1killdRCMRd+sX0KezcYKxPF5LZrJEZDh
	Rb/lv3STTk8JJq5XVmxJDG7liwbr21neUaUYibEUy1a94Ad9S/+a7mSUoSvkJucRiO4/NP7LxFE
	oq3VY5DtsGVT469IBZUvHIbQqeapCJzKTCrroeUjxGnBwubu0JGaJTNT+ggvM/adf4mZnvevOMw
	OQjOJEXh7eK
X-Received: by 2002:a05:6830:1e21:b0:7e3:be56:e0e7 with SMTP id 46e09a7af769-7e6951dfbbbmr1403852a34.11.1780073828441;
        Fri, 29 May 2026 09:57:08 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bd9c9csm1806545a34.11.2026.05.29.09.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:57:07 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
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
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 4/6] mm/damon/core: per-CPU SPSC ring drain and damon_perf_event lifecycle
Date: Fri, 29 May 2026 09:56:38 -0700
Message-ID: <20260529165640.820-5-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529165640.820-1-ravis.opensrc@gmail.com>
References: <20260529165640.820-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the mutex-protected damon_access_reports[] single-buffer with
a per-CPU SPSC ring.  The producer (damon_report_access) is called
from NMI by perf overflow handlers; the consumer
(kdamond_check_reported_accesses) runs once per sample tick.

  - 256-entry ring per CPU with cache-line-aligned head/tail
  - per-CPU damon_report_ring_busy guards against NMI nesting on top
    of a process-context producer on the same CPU
  - per-CPU damon_ring_pending bit so the consumer iterates only CPUs
    that produced samples this tick
  - smp_mb between flag clear and head read on the consumer side
    pairs with the producer's head-publish ordering

Replace the O(N) per-region scan in kdamond_apply_access_report() with
bsearch over a per-tick per-target snapshot built into a reusable
damon_ctx::drain_snapshot buffer.  The pid-based ctx early-reject is
no longer needed: kdamond_apply_access_report() already discriminates
report->vaddr vs report->paddr per ctx.

Wire the damon_perf_event lifecycle: init per attached event when
kdamond starts, teardown when the ctx is destroyed, replayed across
damon_commit_ctx.  Add the matching forward decl + drain_snapshot
field on struct damon_ctx.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/trace/events/damon.h |  17 ++
 mm/damon/core.c              | 383 ++++++++++++++++++++++++++++++-----
 2 files changed, 344 insertions(+), 56 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index b131bee27cc4a..e97e70579a8c8 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -74,6 +74,23 @@ TRACE_EVENT(damos_esz,
 			__entry->esz)
 );
 
+TRACE_EVENT(damon_perf_ring_overflow,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d", __entry->cpu)
+);
+
 TRACE_EVENT_CONDITION(damos_before_apply,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 23311189b589e..1e6966e45144f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "damon: " fmt
 
 #include <linux/damon.h>
+#include <asm/local.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
@@ -24,22 +25,43 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
-#define DAMON_ACCESS_REPORTS_CAP 1000
+#define DAMON_REPORT_RING_SIZE	256
+#define DAMON_REPORT_RING_MASK	(DAMON_REPORT_RING_SIZE - 1)
+
+/* Per-target region lookup snapshot for the drain loop. */
+struct damon_target_lookup {
+	struct damon_target *t;
+	struct damon_region **regions;
+	unsigned int nr_regions;
+};
+
+struct damon_report_ring {
+	unsigned int head;	/* written by producer (NMI) */
+	unsigned int tail	/* written by consumer (kdamond) */
+		____cacheline_aligned_in_smp;
+	struct damon_access_report entries[DAMON_REPORT_RING_SIZE]
+		____cacheline_aligned_in_smp;
+};
+
+static DEFINE_PER_CPU(struct damon_report_ring, damon_report_rings);
+static DEFINE_PER_CPU(local_t, damon_report_ring_busy);
+/*
+ * Producer (NMI) sets after publishing a report; consumer (kdamond) clears
+ * before draining the corresponding ring.  Per-CPU to avoid cross-CPU
+ * cacheline bouncing under sampling load on large systems.
+ */
+static DEFINE_PER_CPU(unsigned long, damon_ring_pending);
 
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 static bool running_exclusive_ctxs;
+static struct damon_ctx *damon_perf_owner;
 
 static DEFINE_MUTEX(damon_ops_lock);
 static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
 static struct kmem_cache *damon_region_cache __ro_after_init;
 
-static DEFINE_MUTEX(damon_access_reports_lock);
-static struct damon_access_report damon_access_reports[
-	DAMON_ACCESS_REPORTS_CAP];
-static int damon_access_reports_len;
-
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
 static bool __damon_is_registered_ops(enum damon_ops_id id)
 {
@@ -805,11 +827,24 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
+	INIT_LIST_HEAD(&ctx->perf_events);
+
 	prandom_seed_state(&ctx->rnd_state, get_random_u64());
 
 	return ctx;
 }
 
+static void damon_perf_destroy(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event, *next;
+
+	list_for_each_entry_safe(event, next, &ctx->perf_events, list) {
+		damon_perf_cleanup(ctx, event);
+		list_del(&event->list);
+		kfree(event);
+	}
+}
+
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next_t;
@@ -835,6 +870,11 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_sample_filter_safe(f, next_f, &ctx->sample_control)
 		damon_destroy_sample_filter(f, &ctx->sample_control);
 
+	damon_perf_destroy(ctx);
+
+	kfree(ctx->drain_snapshot.lookups);
+	kfree(ctx->drain_snapshot.region_buf);
+
 	kfree(ctx);
 }
 
@@ -1694,6 +1734,45 @@ static int damon_commit_sample_control(
 	return damon_commit_sample_filters(dst, src);
 }
 
+static int damon_commit_perf_events(struct damon_ctx *dst,
+		struct damon_ctx *src)
+{
+	struct damon_perf_event *src_event, *new_event;
+	int err = 0;
+
+	damon_perf_destroy(dst);
+
+	list_for_each_entry(src_event, &src->perf_events, list) {
+		new_event = kzalloc(sizeof(*new_event), GFP_KERNEL);
+		if (!new_event) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		new_event->attr = src_event->attr;
+
+		if (damon_is_running(dst)) {
+			err = damon_perf_init(dst, new_event);
+			if (err) {
+				kfree(new_event);
+				goto out;
+			}
+			/*
+			 * Events are created with attr.disabled=1 and only fire while
+			 * the kdamond runs.  Arm now if we are committing into a
+			 * running ctx whose substrate is already armed.
+			 */
+			if (dst->perf_events_active)
+				damon_perf_event_arm(new_event);
+		}
+		list_add_tail(&new_event->list, &dst->perf_events);
+	}
+	return 0;
+out:
+	damon_perf_destroy(dst);
+	return err;
+}
+
 static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
@@ -1742,6 +1821,9 @@ static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		return err;
 	err = damon_commit_sample_control(&dst->sample_control,
 			&src->sample_control);
+	if (err)
+		return err;
+	err = damon_commit_perf_events(dst, src);
 	if (err)
 		return err;
 	dst->addr_unit = src->addr_unit;
@@ -1929,12 +2011,40 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 		return -EBUSY;
 	}
 
+	/*
+	 * The per-CPU PMU events backing the perf-event substrate are a single
+	 * shared resource; only one ctx may own them.  Reject the start if
+	 * another already-running ctx owns the substrate, or if more than one
+	 * ctx in this batch wants it.
+	 */
+	for (i = 0; i < nr_ctxs; i++) {
+		if (!list_empty(&ctxs[i]->perf_events)) {
+			int j;
+
+			if (damon_perf_owner) {
+				mutex_unlock(&damon_lock);
+				return -EBUSY;
+			}
+			for (j = i + 1; j < nr_ctxs; j++) {
+				if (!list_empty(&ctxs[j]->perf_events)) {
+					mutex_unlock(&damon_lock);
+					return -EBUSY;
+				}
+			}
+			damon_perf_owner = ctxs[i];
+			break;
+		}
+	}
+
 	for (i = 0; i < nr_ctxs; i++) {
 		err = __damon_start(ctxs[i]);
 		if (err)
 			break;
 		nr_running_ctxs++;
 	}
+	if (err && damon_perf_owner &&
+			!damon_perf_owner->kdamond)
+		damon_perf_owner = NULL;
 	if (exclusive && nr_running_ctxs)
 		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
@@ -2113,29 +2223,47 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
  * damon_report_access() - Report identified access events to DAMON.
  * @report:	The reporting access information.
  *
- * Report access events to DAMON.
+ * Report access events to DAMON via a per-CPU SPSC lockless ring.  Producer
+ * is the local CPU (typically NMI from a hardware-sampling backend);
+ * consumer is the kdamond drain in kdamond_check_reported_accesses().
  *
- * Context: May sleep.
+ * Context: any (NMI-safe).  An NMI nesting on top of a process-context
+ * producer on the same CPU would otherwise stomp the same entries[head]
+ * slot; the busy guard detects and drops in that case.
  *
- * NOTE: we may be able to implement this as a lockless queue, and allow any
- * context.  As the overhead is unknown, and region-based DAMON logics would
- * guarantee the reports would be not made that frequently, let's start with
- * this simple implementation.
+ * If the ring is full, the sample is dropped and the per-CPU overflow
+ * counter incremented.
  */
 void damon_report_access(struct damon_access_report *report)
 {
-	struct damon_access_report *dst;
+	struct damon_report_ring *ring;
+	unsigned int head, next;
 
-	/* silently fail for races */
-	if (!mutex_trylock(&damon_access_reports_lock))
-		return;
-	dst = &damon_access_reports[damon_access_reports_len++];
-	/* just drop all existing reports in favor of simplicity. */
-	if (damon_access_reports_len == DAMON_ACCESS_REPORTS_CAP)
-		damon_access_reports_len = 0;
-	*dst = *report;
-	dst->report_jiffies = jiffies;
-	mutex_unlock(&damon_access_reports_lock);
+	/* Pin to a CPU so the SPSC invariant holds for preemptible callers. */
+	preempt_disable();
+	if (local_inc_return(this_cpu_ptr(&damon_report_ring_busy)) != 1) {
+		/* NMI nested on a process-context producer; drop. */
+		trace_damon_perf_ring_overflow(smp_processor_id());
+		goto out;
+	}
+
+	ring = this_cpu_ptr(&damon_report_rings);
+	head = ring->head;
+	next = (head + 1) & DAMON_REPORT_RING_MASK;
+
+	if (next == READ_ONCE(ring->tail)) {
+		trace_damon_perf_ring_overflow(smp_processor_id());
+		goto out;
+	}
+
+	ring->entries[head] = *report;
+	ring->entries[head].report_jiffies = jiffies;
+	smp_wmb(); /* publish entry before head advance */
+	WRITE_ONCE(ring->head, next);
+	WRITE_ONCE(*this_cpu_ptr(&damon_ring_pending), 1);
+out:
+	local_dec(this_cpu_ptr(&damon_report_ring_busy));
+	preempt_enable();
 }
 
 #ifdef CONFIG_MMU
@@ -2145,7 +2273,8 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 		.vaddr = vmf->address,
 		.size = 1,	/* todo: set appripriately */
 		.cpu = smp_processor_id(),
-		.tid = task_pid_vnr(current),
+		.tid = current->pid,
+		.tgid = task_tgid_nr(current),
 		.is_write = vmf->flags & FAULT_FLAG_WRITE,
 	};
 
@@ -3700,6 +3829,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
 		ctx->attrs.sample_interval : 1;
 	struct damos *scheme;
+	struct damon_perf_event *event, *next;
 
 	ctx->passed_sample_intervals = 0;
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
@@ -3713,6 +3843,15 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 		damos_set_next_apply_sis(scheme, ctx);
 		damos_set_filters_default_reject(scheme);
 	}
+
+	list_for_each_entry_safe(event, next, &ctx->perf_events, list) {
+		int err = damon_perf_init(ctx, event);
+
+		if (err) {
+			list_del(&event->list);
+			kfree(event);
+		}
+	}
 }
 
 static bool damon_sample_filter_matching(struct damon_access_report *report,
@@ -3759,26 +3898,46 @@ static bool damon_sample_filter_out(struct damon_access_report *report,
 }
 
 static void kdamond_apply_access_report(struct damon_access_report *report,
-		struct damon_target *t, struct damon_ctx *ctx)
+		struct damon_target *t,
+		struct damon_region **regions, unsigned int nr_regions,
+		struct damon_ctx *ctx)
 {
 	struct damon_region *r;
 	unsigned long addr;
+	int left, right, mid;
 
-	if (damon_sample_filter_out(report, &ctx->sample_control))
-		return;
-	if (damon_target_has_pid(ctx))
+	if (damon_target_has_pid(ctx)) {
+		if (pid_nr(t->pid) != report->tgid)
+			return;
 		addr = report->vaddr;
-	else
+	} else {
 		addr = report->paddr;
+	}
 
-	/* todo: make search faster, e.g., binary search? */
-	damon_for_each_region(r, t) {
-		if (addr < r->ar.start)
-			continue;
-		if (r->ar.end < addr + report->size)
-			continue;
-		if (!r->access_reported)
-			damon_update_region_access_rate(r, true, &ctx->attrs);
+	/* Binary search the snapshot for the region containing addr. */
+	left = 0;
+	right = nr_regions - 1;
+	r = NULL;
+	while (left <= right) {
+		/* Avoid (left + right) overflow at large nr_regions. */
+		mid = left + (right - left) / 2;
+		if (addr < regions[mid]->ar.start)
+			right = mid - 1;
+		else if (addr >= regions[mid]->ar.end)
+			left = mid + 1;
+		else {
+			r = regions[mid];
+			break;
+		}
+	}
+
+	if (!r)
+		return;
+	/* Reject reports straddling a region boundary. */
+	if (addr + report->size > r->ar.end)
+		return;
+	if (!r->access_reported) {
+		damon_update_region_access_rate(r, true, &ctx->attrs);
 		r->access_reported = true;
 	}
 }
@@ -3802,28 +3961,120 @@ static unsigned int kdamond_apply_zero_access_report(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
+/*
+ * Build a snapshot of the ctx's targets and their region arrays for use
+ * by the ring drain loop.  The snapshot buffer is reused across ticks,
+ * grown via krealloc only when a new high water mark is reached.
+ *
+ * The two-pass walk over adaptive_targets is safe even though
+ * krealloc_array() may sleep: target list mutation is funneled through
+ * damon_call onto the kdamond itself, so no other thread can mutate the
+ * list while kdamond is running this function.
+ */
+static struct damon_target_lookup *damon_build_target_lookup(
+		struct damon_ctx *ctx, unsigned int *nr_targets_out)
 {
-	int i;
-	struct damon_access_report *report;
 	struct damon_target *t;
+	struct damon_target_lookup *tbl;
+	unsigned int nr_targets = 0, total_regions = 0, ti = 0, ri = 0;
 
-	/* currently damon_access_report supports only physical address */
-	if (damon_target_has_pid(ctx))
-		return 0;
+	damon_for_each_target(t, ctx) {
+		nr_targets++;
+		total_regions += damon_nr_regions(t);
+	}
 
-	mutex_lock(&damon_access_reports_lock);
-	for (i = 0; i < damon_access_reports_len; i++) {
-		report = &damon_access_reports[i];
-		if (time_before(report->report_jiffies,
-					jiffies -
-					usecs_to_jiffies(
-						ctx->attrs.sample_interval)))
+	if (nr_targets > ctx->drain_snapshot.nr_lookups) {
+		tbl = krealloc_array(ctx->drain_snapshot.lookups,
+				nr_targets, sizeof(*tbl), GFP_KERNEL);
+		if (!tbl)
+			return NULL;
+		ctx->drain_snapshot.lookups = tbl;
+		ctx->drain_snapshot.nr_lookups = nr_targets;
+	}
+	tbl = ctx->drain_snapshot.lookups;
+
+	if (total_regions > ctx->drain_snapshot.region_buf_cap) {
+		struct damon_region **buf;
+
+		buf = krealloc_array(ctx->drain_snapshot.region_buf,
+				total_regions, sizeof(*buf), GFP_KERNEL);
+		if (!buf)
+			return NULL;
+		ctx->drain_snapshot.region_buf = buf;
+		ctx->drain_snapshot.region_buf_cap = total_regions;
+	}
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		tbl[ti].t = t;
+		tbl[ti].regions = &ctx->drain_snapshot.region_buf[ri];
+		tbl[ti].nr_regions = damon_nr_regions(t);
+		damon_for_each_region(r, t)
+			ctx->drain_snapshot.region_buf[ri++] = r;
+		ti++;
+	}
+
+	*nr_targets_out = nr_targets;
+	return tbl;
+}
+
+static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
+{
+	int cpu;
+	struct damon_target_lookup *tbl;
+	unsigned int nr_targets = 0;
+	unsigned int i;
+
+	tbl = damon_build_target_lookup(ctx, &nr_targets);
+	if (!tbl) {
+		pr_warn_ratelimited(
+			"damon: target-lookup alloc failed; ring drain skipped this tick\n");
+		return kdamond_apply_zero_access_report(ctx);
+	}
+
+	for_each_online_cpu(cpu) {
+		struct damon_report_ring *ring;
+		unsigned int head, tail;
+
+		if (!READ_ONCE(*per_cpu_ptr(&damon_ring_pending, cpu)))
 			continue;
-		damon_for_each_target(t, ctx)
-			kdamond_apply_access_report(report, t, ctx);
+		ring = per_cpu_ptr(&damon_report_rings, cpu);
+
+		WRITE_ONCE(*per_cpu_ptr(&damon_ring_pending, cpu), 0);
+		/*
+		 * Pair with the producer's smp_wmb between entry and head
+		 * publish: order our flag clear before the head read so that
+		 * a producer publishing between our clear and READ_ONCE(head)
+		 * is observed via the flag it re-sets, not lost as a
+		 * stale-head drain.
+		 */
+		smp_mb();
+		head = READ_ONCE(ring->head);
+		smp_rmb(); /* pair with smp_wmb in producer */
+		tail = ring->tail;
+
+		while (tail != head) {
+			struct damon_access_report *report =
+				&ring->entries[tail];
+
+			if (time_before(report->report_jiffies,
+					jiffies - usecs_to_jiffies(
+						ctx->attrs.sample_interval)))
+				goto next;
+			if (damon_sample_filter_out(report,
+					&ctx->sample_control))
+				goto next;
+			for (i = 0; i < nr_targets; i++)
+				kdamond_apply_access_report(report,
+						tbl[i].t,
+						tbl[i].regions,
+						tbl[i].nr_regions, ctx);
+next:
+			tail = (tail + 1) & DAMON_REPORT_RING_MASK;
+		}
+		WRITE_ONCE(ring->tail, tail);
 	}
-	mutex_unlock(&damon_access_reports_lock);
 	/* For nr_accesses_bp, absence of access should also be reported. */
 	return kdamond_apply_zero_access_report(ctx);
 }
@@ -3848,6 +4099,14 @@ static int kdamond_fn(void *data)
 	complete(&ctx->kdamond_started);
 	kdamond_init_ctx(ctx);
 
+	if (!list_empty(&ctx->perf_events)) {
+		struct damon_perf_event *event;
+
+		WRITE_ONCE(ctx->perf_events_active, true);
+		list_for_each_entry(event, &ctx->perf_events, list)
+			damon_perf_event_arm(event);
+	}
+
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
 	ctx->regions_score_histogram = kmalloc_array(DAMOS_MAX_SCORE + 1,
@@ -3871,14 +4130,15 @@ static int kdamond_fn(void *data)
 		if (kdamond_wait_activation(ctx))
 			break;
 
-		if (ctx->ops.prepare_access_checks)
+		if (list_empty(&ctx->perf_events) &&
+				ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
 
-		/* todo: make these non-exclusive */
-		if (ctx->sample_control.primitives_enabled.page_fault)
+		if (!list_empty(&ctx->perf_events) ||
+		    ctx->sample_control.primitives_enabled.page_fault)
 			max_nr_accesses = kdamond_check_reported_accesses(ctx);
 		else if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
@@ -3965,6 +4225,15 @@ static int kdamond_fn(void *data)
 		}
 	}
 done:
+	if (ctx->perf_events_active) {
+		struct damon_perf_event *event;
+
+		WRITE_ONCE(ctx->perf_events_active, false);
+		list_for_each_entry(event, &ctx->perf_events, list)
+			damon_perf_event_disarm(event);
+		/* Drain any in-flight reports queued before disarm took effect. */
+		kdamond_check_reported_accesses(ctx);
+	}
 	damon_destroy_targets(ctx);
 
 	kfree(ctx->regions_score_histogram);
@@ -3986,6 +4255,8 @@ static int kdamond_fn(void *data)
 	nr_running_ctxs--;
 	if (!nr_running_ctxs && running_exclusive_ctxs)
 		running_exclusive_ctxs = false;
+	if (damon_perf_owner == ctx)
+		damon_perf_owner = NULL;
 	mutex_unlock(&damon_lock);
 
 	return 0;
-- 
2.43.0

