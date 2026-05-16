Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064C35E957
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970891; cv=none; b=Biu38CCRx1QbMAJAZcmBK9q/c3l/wDQC4ne4z9TarBmZyIixcMlV0u8rTIRyjjheIAJru6f/8JMXusIeQAr+qrljVqKB3YCIoPKJFjkMfPomvtJJmqFcme541i2woTKKsNiZkMD8XFuL/KIt6CbYz53R6XDZQzds3GqhjIi4ds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970891; c=relaxed/simple;
	bh=9qCyQuXla6OX/PfPv/Mgm7xBHK14vZ4tbPQnAPQWEbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4IjCdQnOp5h2muOq6fSSzN3ip/8jrbX5FJdv5SGOzY35a+inCIapRtB7h16T8JYnmHw3NQ8bhAd1eRI91728SqLqkDJB7GF7unWfywQ7Ay2SUOOvvTnipzS5rsDpi2MLGFJPuIXGZ+iBCtHV0SPC2jFEkowBxb0WpJX2aiAO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEfu/vWi; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEfu/vWi"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bd6f65c781so5177427b3.1
        for <damon@lists.linux.dev>; Sat, 16 May 2026 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970889; x=1779575689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV43Lg6ZeBSxT2gi43CrNOJZdZ5c40FejoI6Xqvs4d0=;
        b=iEfu/vWiY39BGTF/86afU2BFBiZ6qtE5tsPPjUg4c+s56zHFhjmKPEydIqv809jw00
         FA6ZU0slmfHZSspP+9INiPF4RFkblWpM7Qa6JJL115afAKa4JPuMB/FcHsySbBmfXxnH
         jxPNdCNBoFmy1HR9xCZhXCp+/63+qwIQVv70+SCjTrVrXxVynbxO8Y20QkJtRAmxlj2R
         zenVjkagPDLRJXqmHLSlTzWQuc7YsiBXkcmPX6SdtqVFFwWP+Kta7MUlh5YRpTsmistv
         61v21vrLQNOywC5trjqkgrASMqc48UXOCwad9mN0yXYuPEAPl9/sB/pzbV3hP69usJ3Q
         9A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970889; x=1779575689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV43Lg6ZeBSxT2gi43CrNOJZdZ5c40FejoI6Xqvs4d0=;
        b=VEJYDRmVjHA0tEWUtzkQ7XYbh3bX04mN895cPK3piAPX2q0j/cRX+fzkEWLk76yYyC
         zNcDRBkMTP1+Amquz4zzG3J+tcd2k2C+KHdVHg9JCy2H4DxWN4rzSGEpxn6zrnboViCF
         6qN1tQwbD/vQXy3RI/jp7cjotFTsVKT04oh6UziQq2G5C1E+72KfhJ/fHAJ/C/yw1JlZ
         c7dQ6rOWBYi6svm4cKq/oHZ0SEgSHz3BuL9Ibkahs5oe5fpRMXvs1cO/MFyHNlPgN2AW
         eK6OoNURD6ebWUKvptsY7CrggpUxN0hJzF6ifB23D3vKROfThsg64xH2+QRDIQ1MlSAn
         f4UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/z8lNznuFqdsnTpgdFhBKfir2fQG6Jh7YQD+oJyYFjfuPmUen/rezKQG2+pTlTcNp1EZR5+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8tZx385Nj5xY8PUastFl3zUQZGEjYhh89ZjvFY8JsN3vV7u+m
	sq/1WlxsV5P44/TfHRYWzjyZtREZAshmQNMxQ5NHAHhSdqN1qJsAfTs=
X-Gm-Gg: Acq92OGGNq6wrkcIdJSsLaskgnIekLomKyatuVUIEOh7HjzJMfomOo3jz8OpFNwNTKc
	iZM/naEGDd5P70sRY9GyfAYsdZyYYnj0Cvi7V+7S8Pz5uTj0wjHYd78zKPmh5gzENxMv3Otg5ea
	iys0SStR2yFg++FAgq89nJm8839eXIlIZH/uScanPTDoasVGrfMsHNAPUt2PPVKtzKe8dxVv9Vm
	BDUGzRwB7w/5tyluwi5m1pybXjZhJz19DimzdBvbvqkFfq46b1C3EWaIGi76gCRDqvP7531xnM1
	ayEkQ3Vg4dNjS9GiepyH4hLxMH7bTnPTXfOeMk907VeyWfcoNS/nDxKOmRcg2xNk5DwDZYdYj6D
	lXMvxyGb3jlaT92J3cUaCbBt1XUtD/t7xp5zFG9A1M1Ejti/EyCIsg2m08samEgz73FpY/BXo2K
	DJPTF6jFvjKvHxOePn23DSgw03bsC5frpnhmK1E+e3Ig0qRD7Avr7Uq/knH+o0Nx7WTv+4JSZwS
	yfw0PeWGHp0
X-Received: by 2002:a05:690c:e04e:b0:7c2:fa53:6d7f with SMTP id 00721157ae682-7c9463a2449mr68267967b3.3.1778970888966;
        Sat, 16 May 2026 15:34:48 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6cd4f5sm666137b3.35.2026.05.16.15.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:34:48 -0700 (PDT)
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
Subject: [RFC PATCH 3/7] mm/damon/core: replace mutex-protected report buffer with per-CPU lockless ring
Date: Sat, 16 May 2026 15:34:28 -0700
Message-ID: <20260516223439.4033-4-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516223439.4033-1-ravis.opensrc@gmail.com>
References: <20260516223439.4033-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the mutex-protected fixed-size array (DAMON_ACCESS_REPORTS_CAP=1000)
with a per-CPU lockless ring buffer.  This enables damon_report_access()
to be called from NMI context.

Ring design:
- Producer is serialized per CPU: only one in-flight producer per CPU
  is allowed.  A per-CPU damon_report_ring_busy counter detects
  NMI-on-process nesting and drops the nested attempt, preserving the
  single-writer invariant on the slot.
- head is advanced by the producer with smp_wmb() before publish.
- tail is advanced by the consumer (kdamond) after the entries[] reads.
- Overflow: sample silently dropped.  NMI context is allocation-free
  and access reports are best-effort.

To keep the producer/consumer pattern scalable on systems with many
CPUs and a high NMI rate, the ring layout follows three rules:

- head, tail and entries[] live on separate cache lines via
  ____cacheline_aligned_in_smp, so producer and consumer do not
  invalidate each other's working set on every advance.
- DAMON_REPORT_RING_SIZE is bounded so the per-CPU footprint stays
  small (256 entries x sizeof(struct damon_access_report) plus head
  and tail cache lines), keeping draining all rings during one
  kdamond tick from evicting unrelated data on contemporary server
  parts.
- A cpumask, damon_rings_pending, is set by the producer after
  publishing and cleared by the consumer per ring drained, so the
  consumer iterates only CPUs with pending entries instead of
  walking every online CPU.  An smp_mb__before_atomic() between the
  head publish and the cpumask_set_cpu() ensures observers of the
  pending bit also observe the published head; without it, weakly-
  ordered architectures could let the consumer drain stale head and
  delay the report.  The consumer pairs this with an
  smp_mb__after_atomic() between cpumask_clear_cpu() and reading
  head, so a producer that publishes between the consumer's clear
  and head-read is observed via the bit it re-sets rather than
  silently stranded.

Consumer (kdamond_check_reported_accesses) drains the rings of CPUs
in damon_rings_pending, applying reports to targets.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 143 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 42 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b605d36b29b1a..9ed789e932ebd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -25,7 +25,26 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
-#define DAMON_ACCESS_REPORTS_CAP 1000
+/* Sized so the per-CPU ring set fits in L3 on typical multi-socket boxes. */
+#define DAMON_REPORT_RING_SIZE	256
+#define DAMON_REPORT_RING_MASK	(DAMON_REPORT_RING_SIZE - 1)
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
+static DEFINE_PER_CPU(int, damon_report_ring_busy);
+/*
+ * Per-CPU bitmap: producer (NMI) sets after publishing a report;
+ * consumer (kdamond) clears before draining the corresponding ring.
+ * Hot-write under sampling load - do NOT mark __read_mostly.
+ */
+static cpumask_t damon_rings_pending;
 
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
@@ -36,10 +55,6 @@ static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
 static struct kmem_cache *damon_region_cache __ro_after_init;
 
-static DEFINE_MUTEX(damon_access_reports_lock);
-static struct damon_access_report damon_access_reports[
-	DAMON_ACCESS_REPORTS_CAP];
-static int damon_access_reports_len;
 
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
 static bool __damon_is_registered_ops(enum damon_ops_id id)
@@ -2127,33 +2142,56 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 }
 
 /**
- * damon_report_access() - Report identified access events to DAMON.
- * @report:	The reporting access information.
+ * damon_report_access() - Report a hardware-observed memory access.
+ * @report:	pointer to a filled damon_access_report struct.
  *
- * Report access events to DAMON.
- *
- * Context: May sleep.
- *
- * NOTE: we may be able to implement this as a lockless queue, and allow any
- * context.  As the overhead is unknown, and region-based DAMON logics would
- * guarantee the reports would be not made that frequently, let's start with
- * this simple implementation.
+ * Context: NMI-safe.  No sleeping, no allocation, no locks.
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
+	/*
+	 * NMI nesting on the same CPU as a process-context producer would
+	 * stomp the same entries[head] slot.  Detect and drop instead.
+	 */
+	if (this_cpu_inc_return(damon_report_ring_busy) != 1) {
+		/* NMI nested on a process-context producer; drop. */
+		goto out;
+	}
+
+	ring = this_cpu_ptr(&damon_report_rings);
+	head = ring->head;
+	next = (head + 1) & DAMON_REPORT_RING_MASK;
+
+	if (next == READ_ONCE(ring->tail)) {
+		/* Ring full; consumer is behind, drop the report. */
+		goto out;
+	}
+
+	ring->entries[head] = *report;
+	ring->entries[head].report_jiffies = jiffies;
+	smp_wmb(); /* ensure entry visible before head advance */
+	WRITE_ONCE(ring->head, next);
+	/*
+	 * Order the head advance before publishing the pending bit
+	 * so that the consumer, on observing the bit, is also
+	 * guaranteed to observe the new head.  set_bit/cpumask_set_cpu
+	 * are documented as unordered RMW (atomic_bitops.txt), hence
+	 * the explicit barrier; without it, a weakly-ordered arch
+	 * could let the consumer drain stale head, clear the bit, and
+	 * delay the report until the next producer sets the bit again.
+	 */
+	smp_mb__before_atomic();
+	cpumask_set_cpu(smp_processor_id(), &damon_rings_pending);
+out:
+	this_cpu_dec(damon_report_ring_busy);
+	preempt_enable();
 }
+EXPORT_SYMBOL_GPL(damon_report_access);
 
 #ifdef CONFIG_MMU
 void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
@@ -3814,26 +3852,47 @@ static unsigned int kdamond_apply_zero_access_report(struct damon_ctx *ctx)
 
 static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 {
-	int i;
-	struct damon_access_report *report;
+	int cpu;
 	struct damon_target *t;
 
-	/* currently damon_access_report supports only physical address */
-	if (damon_target_has_pid(ctx))
-		return 0;
+	for_each_cpu(cpu, &damon_rings_pending) {
+		struct damon_report_ring *ring =
+			per_cpu_ptr(&damon_report_rings, cpu);
+		unsigned int head, tail;
 
-	mutex_lock(&damon_access_reports_lock);
-	for (i = 0; i < damon_access_reports_len; i++) {
-		report = &damon_access_reports[i];
-		if (time_before(report->report_jiffies,
-					jiffies -
-					usecs_to_jiffies(
-						ctx->attrs.sample_interval)))
-			continue;
-		damon_for_each_target(t, ctx)
-			kdamond_apply_access_report(report, t, ctx);
+		cpumask_clear_cpu(cpu, &damon_rings_pending);
+		/*
+		 * Pair with the producer's smp_mb__before_atomic() between
+		 * the head publish and cpumask_set_cpu(): order the bit
+		 * clear before the head read so that a producer publishing
+		 * between our clear and our READ_ONCE(head) is observed via
+		 * the bit it re-sets, not lost as a stale-head drain.
+		 */
+		smp_mb__after_atomic();
+		head = READ_ONCE(ring->head);
+		/*
+		 * Pair with smp_wmb in damon_report_access(): the entry
+		 * data published before the producer advanced head must be
+		 * visible to the entries[] reads inside the loop below.
+		 */
+		smp_rmb();
+		tail = ring->tail;
+
+		while (tail != head) {
+			struct damon_access_report *report =
+				&ring->entries[tail];
+
+			if (!time_before(report->report_jiffies,
+					jiffies - usecs_to_jiffies(
+						ctx->attrs.sample_interval))) {
+				damon_for_each_target(t, ctx)
+					kdamond_apply_access_report(
+							report, t, ctx);
+			}
+			tail = (tail + 1) & DAMON_REPORT_RING_MASK;
+		}
+		WRITE_ONCE(ring->tail, tail);
 	}
-	mutex_unlock(&damon_access_reports_lock);
 	/* For nr_accesses_bp, absence of access should also be reported. */
 	return kdamond_apply_zero_access_report(ctx);
 }
-- 
2.43.0

