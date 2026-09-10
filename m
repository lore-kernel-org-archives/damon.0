Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61688559C8E
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060608; cv=none; b=L139dFLwMsj8zqBruMi6bQha+cXVp6AQYpSTUDYV4Aih+Nnk6RhUskP3ibDHsZPE2O19cK7ghYMuO3bzIJ4DHEg4qRyNsDuje47I0vTZSnzhDEB9WQZbeNTgZsJL1NTNwTeihBuUrVXnloI3fYOMA6PL/AfFDksIwI3pSN5SkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060608; c=relaxed/simple;
	bh=KwUQXBvFl8h+cWa2Ry5TXnxYBk4dX+ldcnuqkwMZDa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biJgI4eUcuiwkIQWQp64J1gSI2o/JF2DgcvE9R8ILw7iLf53htHi6U7REunHA5VVvEHAp+Q9fgxKJ63DS54rRZ91SCw2YgsmUWGFNFU5WQHWcRD7KvNrqlD3lAtrkrdXhOk+f+5Y/cSFYyQU2eXx1qBHmv47gO1Y58pG8L4GZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNnPNtsa; arc=none smtp.client-ip=74.125.224.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNnPNtsa"
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70f7a790so2343465d50.1
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060600; x=1789665400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33JbaTzVaS9WwHfpEPKLTYlvXLw2aDfEmaGs4zEFu2Y=;
        b=aNnPNtsaPQXF0ltBnJeZIfbYmFwosi6H+KX09KFL4+YMOi3S+mBPqvvXHTBU7IXHN2
         xHu86E8wQ55hcxTCeaa7q6SgyMvpOHsbre0cOAXr4XWhHFCwXTHg1fpavu55M75+NlnA
         E11TON9JBz20SkSBj8gYvNpgK5vVfIgd03L1GcnFyQwLrqfPMQ5UbdUwxzOuLecWI+yJ
         pACWORb9C+wba3BgxL+tHav1Nkhxm9sDU9JYqZHDlunS5sxU17AK84u/Tbhs+i/izK4H
         AM1Ifw+ljJhBwOCBCjITOgjqHvqGNUFIf/ATsxrwwI6CsSsbYXnBuJRhPpijq7XqwnUz
         UauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060600; x=1789665400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=33JbaTzVaS9WwHfpEPKLTYlvXLw2aDfEmaGs4zEFu2Y=;
        b=fT4clwb8m6pvcRSqrlgmdqO4kIACAB7haXVP/+zkH06BkEna7Xkj5r26twEhnjzrfc
         QhIxbiwZyYv0JO3vnJlhnw6jgIbpS2R2ZhewVkHchQN/cnbvV1K97lLzCUvAb/qOzzC6
         Bmr1EW2ob7Ut9WM2toipSW0ZdViyyg7zl859/KpU+yqwj3+yWzuAhAsrUt4ESHDw8WQC
         ddN+K4vGKP+6aZPCMAllDJBwSt+hyQgjA6BY8Wr6CABtELc6K3uaJlGRwIZ/proxd3f2
         HOrI1YFJwGLESP036rncfte2k1JvYLFojlCcfUjPn6j0wfhxFYyEOb8QKwVk8sWS/lJV
         Sfzg==
X-Forwarded-Encrypted: i=1; AKwUvByypijWQB6UVIg6Z4zDY09XpIySj0epGWVgigoRhyFGcnFs/mHwn8gujX6/1ACAKrb6cLYxkA==@lists.linux.dev
X-Gm-Message-State: AFuF++k1+gzaqjd41B6r+L8DEeuY8hBTjAsQVm6P1VHnIWCKS4tqCb1G
	vjBAFqxvSJ70yJ+rWHSNuRom6hBhe6r2qhDh7oFvxoscbpMZMudvtUg=
X-Gm-Gg: AYBFou2B/Rvc5XH0lltvMohgAyX+dzuoXuxq3Soit6xe18GW7oS/3LeZNNYInWAyiDF
	s59KtJlgHOJBfaiFFpGKOr4Mvb9CnVTGwruN3d6Zv5bXtMJrwTskcPQydTWO7RRYwptF1TtCotC
	4ry8NVgNO+SEGq+5VdgvCWXE3jtVmBfbyGeOZfYG3thAAecTDlvZ20kCTuXQRPBS0nzAro3QmfL
	PSKowAV0MmKUmj2FHQeCAePPIeJ+Xx8uVhy4Fg4ReCIuExcr9Za8nQWDm7d+OWMxRZ6Vc9UxPMZ
	5G0M1jhZSjkenJjdVh5yxlV9YIqaRoxNCzGukhVhjJb2XXTnHOx9aAamrYxdqK6Y3/n2BXFOvQZ
	mNGrfUN5cZi0DjiKH+f1wVh9vJHuoIiC4gnd6gDPONays6T20go/yIobsbH9AVYVCuUFoA3qsi6
	AwhIwRtbklUEfySE9J06uu87PCEPeavnXn6r1XCnw3jV7UUUS6koP/IB81/1huBbBjNzgGcQYCk
	0aGcwJP+f2ByW0cRGBksAagfsmjM9YJID4vgRGeTZkdfxe/PA==
X-Received: by 2002:a05:690c:6e87:b0:873:5ddf:d870 with SMTP id 00721157ae682-884b423a43fmr1497757b3.59.1789060599401;
        Thu, 10 Sep 2026 10:16:39 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88487ea38e1sm2327237b3.30.2026.09.10.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:38 -0700 (PDT)
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
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 6/9] mm/damon: add perf-event overflow handler feeding the report ring
Date: Thu, 10 Sep 2026 10:16:20 -0700
Message-ID: <20260910171623.6638-7-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mm/damon/perf_source.c, an ops-agnostic perf-event source that turns
PMU overflow samples into DAMON access reports.  The overflow handler runs
in NMI context and reports through damon_report_access(), so it works with
either paddr or vaddr ops.

The handler sets whichever address fields the PMU provides: paddr when
PERF_SAMPLE_PHYS_ADDR is set, vaddr when PERF_SAMPLE_ADDR is set, plus the
CPU it runs on.  The unified drain matches on whichever is present.  It
reports both the thread id and the thread group id, because a VA-only PMU
samples whichever thread of a process happened to access memory while the
drain matches a target created for that process.

Per-CPU perf events are armed and released through cpuhp callbacks, so a
CPU coming online while a probe is armed gets a counter and a CPU going
offline releases its own.

damon_perf_probe_alloc() allocates a perf-event-backed damon_probe with
event_driven set, so its hits are credited through the report-ring drain
rather than the apply_probes vtable; callers set the perf attributes after
allocation.  Both ops sets honour that flag in their probe vtables: an
event-driven probe has no software prep action, and is skipped in the
apply_probes loop, so the drain is the only thing that credits its
probe_hits[].

damon_perf_probe_setup() computes probe_idx by walking ctx->probes,
assigning 1-based indices because 0 is the zero-init sentinel
DAMON_PROBE_IDX_NONE, and the overflow handler warns once if it sees 0.

A refcounted per-PMU owner tracks which context owns each PMU type: a
second context claiming the same type gets -EBUSY, and ownership is
released when the last probe for that type is torn down.  Module exit
refuses to unload while any owner remains.

Co-developed-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/Kconfig       |  18 ++
 mm/damon/Makefile      |   1 +
 mm/damon/paddr.c       |  19 +-
 mm/damon/perf_source.c | 402 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/perf_source.h |  26 +++
 mm/damon/vaddr.c       |  18 +-
 6 files changed, 482 insertions(+), 2 deletions(-)
 create mode 100644 mm/damon/perf_source.c
 create mode 100644 mm/damon/perf_source.h

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index c7b6f3125e79e..4a4f4381dc3b7 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -64,6 +64,24 @@ config DAMON_PADDR
 	  This builds the default data access monitoring operations for DAMON
 	  that works for the physical address space.
 
+config DAMON_PERF_SOURCE
+	bool "perf-event source for DAMON probes"
+	depends on DAMON && PERF_EVENTS
+	help
+	  Provides a PMU-agnostic perf-event overflow handler that feeds
+	  physical-address access reports into DAMON via damon_report_access().
+	  Required for DAMON probe-weighted tiering with any address-sampling PMU.
+
+	  The overflow handler is NMI-safe: it writes to a per-CPU SPSC
+	  ring rather than taking any lock. The PMU is selected at probe
+	  creation time via perf_event_attr (e.g. AMD IBS Op, Intel PEBS).
+
+	  A given PMU type may be driven by at most one DAMON context at a
+	  time (hardware constraint); damon_perf_probe_setup() returns -EBUSY
+	  if another context already owns that PMU type.  Distinct contexts may
+	  each drive different PMUs concurrently, each draining its own
+	  per-context report ring.
+
 config DAMON_VADDR_KUNIT_TEST
 	bool "Test for DAMON operations" if !KUNIT_ALL_TESTS
 	depends on DAMON_VADDR && KUNIT=y
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 22494754f41e8..1abf6f2a5133f 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
 obj-$(CONFIG_DAMON_ACMA)	+= modules-common.o acma.o
+obj-$(CONFIG_DAMON_PERF_SOURCE)	+= perf_source.o
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5fcef3005c536..c6ac44561ee46 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -179,6 +179,16 @@ static void damon_pa_prep_probes_region(struct damon_region *r,
 {
 	struct damon_prep *p;
 
+	/*
+	 * Event-driven probes have no software prep action: their hits arrive
+	 * asynchronously through the per-CPU report rings and are applied by
+	 * the kdamond ring drain, so skip the software prep path here.
+	 * Reaching this for an event-driven probe is normal (prep runs for
+	 * every probe); it is silently skipped, not a warning.
+	 */
+	if (probe->event_driven)
+		return;
+
 	damon_for_each_prep(p, probe) {
 		switch (p->action) {
 		case DAMON_PREP_SET_PGIDLE:
@@ -268,7 +278,14 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
 			damon_for_each_probe(p, ctx) {
-				if (damon_pa_filter_pass(folio, p))
+				/*
+				 * Event-driven probes skip this software apply
+				 * path; their hits are counted asynchronously by
+				 * the kdamond ring drain.  Only sampling-based
+				 * probes credit probe_hits[] here.
+				 */
+				if (!p->event_driven &&
+				    damon_pa_filter_pass(folio, p))
 					r->probe_hits[i]++;
 				i++;
 			}
diff --git a/mm/damon/perf_source.c b/mm/damon/perf_source.c
new file mode 100644
index 0000000000000..1102426152eca
--- /dev/null
+++ b/mm/damon/perf_source.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON perf-event source
+ *
+ * Provides a PMU-agnostic NMI-safe overflow handler that feeds
+ * physical-address access reports into DAMON via damon_report_access().
+ * The PMU is selected at probe creation time via perf_event_attr.
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/damon.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include "perf_source.h"
+
+/* PMU event attribute for perf-event probe configuration */
+struct damon_perf_event_attr {
+	u32 type;
+	u64 config;
+	u64 config1;
+	u64 config2;
+	bool sample_phys_addr;
+	bool sample_weight_struct;
+	bool exclude_kernel;
+	bool exclude_hv;
+	bool freq;
+	u64 sample_freq;
+	u64 sample_period;
+	u32 wakeup_events;
+	u32 precise_ip;
+};
+
+struct damon_perf_probe_event {
+	struct damon_perf_event_attr attr;
+	void *priv;		/* struct damon_perf_probe_state * */
+	struct hlist_node hlist_node;
+	int probe_idx;		/* index into probe_hits[]; set at registration */
+};
+
+struct damon_perf_probe_state {
+	struct perf_event * __percpu *event;
+};
+
+static DEFINE_PER_CPU(unsigned long, damon_perf_samples_total);
+static DEFINE_PER_CPU(unsigned long, damon_perf_samples_filtered);
+static DEFINE_PER_CPU(unsigned long, damon_perf_samples_no_addr);
+
+static void damon_perf_overflow(struct perf_event *perf_event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	int probe_idx = (int)(unsigned long)perf_event->overflow_handler_context;
+	struct damon_access_report report = {
+		.probe_idx = probe_idx,
+		.size = PAGE_SIZE,
+		.cpu = smp_processor_id(),
+	};
+
+	/* probe_idx 0 is the zero-init sentinel; a valid index must be >= 1 */
+	if (WARN_ONCE(probe_idx == 0,
+		      "damon-perf: overflow handler called with probe_idx=0\n"))
+		return;
+
+	if (!data) {
+		this_cpu_inc(damon_perf_samples_no_addr);
+		return;
+	}
+
+	/*
+	 * Populate whichever address fields the PMU provides.
+	 * IBS provides PA (and optionally VA); PEBS provides VA only.
+	 * Gate on sample_flags rather than testing for zero: the flag is
+	 * the authoritative indicator of field validity.
+	 */
+	if (data->sample_flags & PERF_SAMPLE_PHYS_ADDR)
+		report.paddr = data->phys_addr & PAGE_MASK;
+	if (data->sample_flags & PERF_SAMPLE_ADDR)
+		report.vaddr = data->addr;
+
+	if (!report.paddr && !report.vaddr) {
+		this_cpu_inc(damon_perf_samples_filtered);
+		return;
+	}
+
+	report.is_write = !!(data->data_src.mem_op & PERF_MEM_OP_STORE);
+	report.tid = task_pid_vnr(current);
+	report.tgid = task_tgid_vnr(current);
+	damon_report_access(&report);
+	this_cpu_inc(damon_perf_samples_total);
+}
+
+static enum cpuhp_state damon_perf_cpuhp_state;
+
+/*
+ * Per-PMU exclusivity: each PMU type may be owned by at most one damon_ctx.
+ * Multiple probes from the same ctx sharing a PMU type are allowed; a second
+ * ctx attempting to grab a PMU type already owned returns -EBUSY.
+ */
+struct damon_pmu_owner {
+	struct list_head node;
+	u32 pmu_type;
+	atomic_long_t owner_ctx;
+	atomic_t refcount;
+};
+
+static LIST_HEAD(damon_pmu_owner_list);
+static DEFINE_SPINLOCK(damon_pmu_owner_lock);
+
+static void damon_perf_event_init_attr(struct damon_perf_probe_event *event,
+				       struct perf_event_attr *attr)
+{
+	u64 stype = PERF_SAMPLE_TIME | PERF_SAMPLE_PERIOD | PERF_SAMPLE_ADDR;
+
+	/*
+	 * Gate PERF_SAMPLE_PHYS_ADDR on the probe attribute: Intel PEBS
+	 * has sample_phys_addr=0 by default; forcing it triggers an
+	 * NMI-context pagetable walk per sample and sets entry->paddr
+	 * unconditionally, which prevents the vaddr drain branch from
+	 * ever being exercised.
+	 */
+	if (event->attr.sample_phys_addr)
+		stype |= PERF_SAMPLE_PHYS_ADDR;
+	if (event->attr.sample_weight_struct)
+		stype |= PERF_SAMPLE_WEIGHT_STRUCT;
+	stype |= PERF_SAMPLE_DATA_SRC;
+
+	*attr = (struct perf_event_attr) {
+		.size = sizeof(*attr),
+		.type = event->attr.type,
+		.config = event->attr.config,
+		.config1 = event->attr.config1,
+		.config2 = event->attr.config2,
+		.freq = event->attr.freq,
+		.sample_type = stype,
+		.precise_ip = event->attr.precise_ip,
+		.pinned = 1,
+		/*
+		 * Created disabled, and enabled by the caller once the counter
+		 * is fully set up.
+		 */
+		.disabled = 1,
+		.wakeup_events = event->attr.wakeup_events,
+		.exclude_kernel = event->attr.exclude_kernel,
+		.exclude_hv = event->attr.exclude_hv,
+	};
+	if (event->attr.freq)
+		attr->sample_freq = event->attr.sample_freq;
+	else
+		attr->sample_period = event->attr.sample_period;
+}
+
+static int damon_perf_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct damon_perf_probe_event *event = hlist_entry(node,
+			struct damon_perf_probe_event, hlist_node);
+	struct damon_perf_probe_state *perf = event->priv;
+	struct perf_event_attr attr;
+	struct perf_event *perf_event;
+
+	if (!perf)
+		return 0;
+
+	damon_perf_event_init_attr(event, &attr);
+
+	perf_event = perf_event_create_kernel_counter(&attr, cpu, NULL,
+						      damon_perf_overflow,
+						      (void *)(unsigned long)event->probe_idx);
+	if (IS_ERR(perf_event)) {
+		pr_warn_ratelimited("damon-perf: cpu %u event create failed: %ld\n",
+				    cpu, PTR_ERR(perf_event));
+		return 0;
+	}
+	per_cpu(*perf->event, cpu) = perf_event;
+
+	perf_event_enable(perf_event);
+	return 0;
+}
+
+static int damon_perf_cpu_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct damon_perf_probe_event *event = hlist_entry(node,
+			struct damon_perf_probe_event, hlist_node);
+	struct damon_perf_probe_state *perf = event->priv;
+	struct perf_event *perf_event;
+
+	if (!perf)
+		return 0;
+
+	perf_event = per_cpu(*perf->event, cpu);
+	if (perf_event) {
+		perf_event_disable(perf_event);
+		perf_event_release_kernel(perf_event);
+		per_cpu(*perf->event, cpu) = NULL;
+	}
+	return 0;
+}
+
+/**
+ * damon_perf_probe_setup - arm perf_events for a DAMON probe.
+ * @ctx:   DAMON context that owns the probe.
+ * @probe: the damon_probe being armed; its list position in ctx->probes
+ *         determines the probe_idx stored in ring entries.
+ * @event: perf event descriptor (caller fills .attr fields)
+ *
+ * Computes probe_idx by walking ctx->probes so the caller does not need
+ * to track it externally.  Returns 0 on success, negative errno on failure.
+ */
+int damon_perf_probe_setup(struct damon_ctx *ctx,
+			   struct damon_probe *probe,
+			   struct damon_perf_probe_event *event)
+{
+	struct damon_perf_probe_state *perf;
+	struct damon_pmu_owner *owner, *found = NULL;
+	struct damon_probe *p;
+	int idx = 0;
+	int err = -ENOMEM;
+
+	/*
+	 * Per-PMU exclusivity: find or create an owner slot for this PMU type.
+	 * Multiple probes from the same ctx sharing a PMU type are allowed;
+	 * a second ctx attempting the same PMU type returns -EBUSY.
+	 */
+	spin_lock(&damon_pmu_owner_lock);
+	list_for_each_entry(owner, &damon_pmu_owner_list, node) {
+		if (owner->pmu_type == event->attr.type) {
+			long cur = atomic_long_read(&owner->owner_ctx);
+
+			if (cur != 0L && cur != (long)ctx) {
+				spin_unlock(&damon_pmu_owner_lock);
+				return -EBUSY;
+			}
+			atomic_long_set(&owner->owner_ctx, (long)ctx);
+			atomic_inc(&owner->refcount);
+			found = owner;
+			break;
+		}
+	}
+	if (!found) {
+		/*
+		 * GFP_ATOMIC: this allocation runs while holding
+		 * damon_pmu_owner_lock (a spinlock), so it must not sleep.
+		 */
+		owner = kzalloc_obj(*owner, GFP_ATOMIC);
+		if (!owner) {
+			spin_unlock(&damon_pmu_owner_lock);
+			return -ENOMEM;
+		}
+		owner->pmu_type = event->attr.type;
+		atomic_long_set(&owner->owner_ctx, (long)ctx);
+		atomic_set(&owner->refcount, 1);
+		list_add(&owner->node, &damon_pmu_owner_list);
+		found = owner;
+	}
+	spin_unlock(&damon_pmu_owner_lock);
+
+	/* Compute probe_idx by walking ctx->probes list */
+	damon_for_each_probe(p, ctx) {
+		if (p == probe)
+			break;
+		idx++;
+	}
+	/*
+	 * Probe indices are 1-based (0 is the zero-init sentinel).
+	 * With DAMON_MAX_PROBES slots (0..DAMON_MAX_PROBES-1), valid probe
+	 * indices are 1..DAMON_MAX_PROBES-1, so the 0-based list position
+	 * must be < DAMON_MAX_PROBES-1.
+	 */
+	if (idx >= DAMON_MAX_PROBES - 1) {
+		err = -ENOSPC;
+		goto release_owner;
+	}
+	event->probe_idx = idx + 1;	/* 1-based; 0 is reserved sentinel */
+
+	perf = kzalloc_obj(*perf, GFP_KERNEL);
+	if (!perf)
+		goto release_owner;
+
+	perf->event = alloc_percpu(typeof(*perf->event));
+	if (!perf->event)
+		goto free_perf;
+
+	event->priv = perf;
+	INIT_HLIST_NODE(&event->hlist_node);
+
+	err = cpuhp_state_add_instance(damon_perf_cpuhp_state,
+				       &event->hlist_node);
+	if (err)
+		goto free_event;
+
+	return 0;
+
+free_event:
+	free_percpu(perf->event);
+free_perf:
+	kfree(perf);
+	event->priv = NULL;
+release_owner:
+	spin_lock(&damon_pmu_owner_lock);
+	if (atomic_dec_and_test(&found->refcount)) {
+		list_del(&found->node);
+		spin_unlock(&damon_pmu_owner_lock);
+		kfree(found);
+	} else {
+		spin_unlock(&damon_pmu_owner_lock);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(damon_perf_probe_setup);
+
+/**
+ * damon_perf_probe_teardown - disarm perf_events.
+ * @event: perf event descriptor previously passed to damon_perf_probe_setup()
+ */
+void damon_perf_probe_teardown(struct damon_ctx *ctx,
+			       struct damon_perf_probe_event *event)
+{
+	struct damon_perf_probe_state *perf = event->priv;
+	struct damon_pmu_owner *owner, *tmp;
+
+	if (!perf)
+		return;
+
+	cpuhp_state_remove_instance(damon_perf_cpuhp_state,
+				    &event->hlist_node);
+	free_percpu(perf->event);
+	kfree(perf);
+	event->priv = NULL;
+
+	/*
+	 * Release per-PMU ownership when the last probe for this
+	 * ctx/PMU-type pair is torn down.
+	 */
+	spin_lock(&damon_pmu_owner_lock);
+	list_for_each_entry_safe(owner, tmp, &damon_pmu_owner_list, node) {
+		if (owner->pmu_type == event->attr.type &&
+		    atomic_long_read(&owner->owner_ctx) == (long)ctx) {
+			/*
+			 * Free under the lock so a concurrent same-PMU teardown
+			 * cannot observe and free the same owner. kfree() under
+			 * a non-irq spinlock in process context is safe.
+			 */
+			if (atomic_dec_and_test(&owner->refcount)) {
+				list_del(&owner->node);
+				kfree(owner);
+			}
+			break;
+		}
+	}
+	spin_unlock(&damon_pmu_owner_lock);
+}
+EXPORT_SYMBOL_GPL(damon_perf_probe_teardown);
+
+/**
+ * damon_perf_probe_alloc - allocate and initialise a perf-event-backed damon_probe.
+ * @weight: probe weight for probe-weighted tiering scoring.
+ *
+ * The caller sets perf->attr directly after allocation to select the PMU
+ * and sampling parameters (e.g. AMD IBS Op, Intel PEBS).
+ *
+ * Returns a new probe on success, NULL on allocation failure.
+ */
+struct damon_probe *damon_perf_probe_alloc(unsigned int weight)
+{
+	struct damon_probe *probe = damon_new_probe();
+
+	if (!probe)
+		return NULL;
+	probe->weight = weight;
+	probe->event_driven = true;
+	return probe;
+}
+EXPORT_SYMBOL_GPL(damon_perf_probe_alloc);
+
+static int __init damon_perf_source_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "mm/damon/perf_source:online",
+				      damon_perf_cpu_online,
+				      damon_perf_cpu_offline);
+	if (ret < 0)
+		return ret;
+	damon_perf_cpuhp_state = ret;
+	return 0;
+}
+
+static void __exit damon_perf_source_exit(void)
+{
+	spin_lock(&damon_pmu_owner_lock);
+	if (!list_empty(&damon_pmu_owner_list)) {
+		spin_unlock(&damon_pmu_owner_lock);
+		WARN(1, "damon_perf_source: unloading with active probes\n");
+		return;
+	}
+	spin_unlock(&damon_pmu_owner_lock);
+	cpuhp_remove_multi_state(damon_perf_cpuhp_state);
+}
+
+module_init(damon_perf_source_init);
+module_exit(damon_perf_source_exit);
diff --git a/mm/damon/perf_source.h b/mm/damon/perf_source.h
new file mode 100644
index 0000000000000..5de55a29785f4
--- /dev/null
+++ b/mm/damon/perf_source.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON perf-event source - public interface
+ *
+ * Callers that register perf-event probes include this header.
+ */
+
+#ifndef _DAMON_PERF_SOURCE_H
+#define _DAMON_PERF_SOURCE_H
+
+#ifdef CONFIG_DAMON_PERF_SOURCE
+
+#include <linux/damon.h>
+#include <linux/perf_event.h>
+
+struct damon_perf_probe_event;
+
+int damon_perf_probe_setup(struct damon_ctx *ctx,
+			   struct damon_probe *probe,
+			   struct damon_perf_probe_event *event);
+void damon_perf_probe_teardown(struct damon_ctx *ctx,
+			       struct damon_perf_probe_event *event);
+struct damon_probe *damon_perf_probe_alloc(unsigned int weight);
+
+#endif /* CONFIG_DAMON_PERF_SOURCE */
+#endif /* _DAMON_PERF_SOURCE_H */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1f2d923e569d6..3d6387d4ef7bb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -552,6 +552,16 @@ static void damon_va_prep_probe_region(struct damon_ctx *ctx,
 {
 	struct damon_prep *p;
 
+	/*
+	 * Event-driven probes have no software prep action: their hits arrive
+	 * asynchronously through the per-CPU report rings and are applied by
+	 * the kdamond ring drain, so skip the software prep path here.
+	 * Reaching this for an event-driven probe is normal (prep runs for
+	 * every probe); it is silently skipped, not a warning.
+	 */
+	if (probe->event_driven)
+		return;
+
 	damon_for_each_prep(p, probe) {
 		switch (p->action) {
 		case DAMON_PREP_SET_PGIDLE:
@@ -656,7 +666,13 @@ static void damon_va_probe_folio(struct damon_ctx *ctx,
 	int i = 0;
 
 	damon_for_each_probe(probe, ctx) {
-		if (damon_va_filter_pass(folio, probe, pte, pmd, mm,
+		/*
+		 * Event-driven probes skip this software apply path; their hits
+		 * are counted asynchronously by the kdamond ring drain.  Only
+		 * sampling-based probes credit probe_hits[] here.
+		 */
+		if (!probe->event_driven &&
+		    damon_va_filter_pass(folio, probe, pte, pmd, mm,
 					r->sampling_addr))
 			r->probe_hits[i]++;
 		i++;
-- 
2.43.0

