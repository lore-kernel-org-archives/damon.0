Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31963AB284
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061712; cv=none; b=fYVGspoGhI/9wGZ2azUIgHa18Olrcg9ZXI8IAvLkZU26Fkr4P3mHn6EfYUIEGyydqDLdMkTi9pik777uiED7WWiFXarpphOwZE5yGta0eJOKJiIRxxBfX8bYLMut1fIz2zQhDQUrrT18uUBlvXIbFLp3NM/cZ/V017dhkeN1KFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061712; c=relaxed/simple;
	bh=7zOHby9cDul39Wnj0X0SN8EbOC9xBkbHaZRJn3rMoe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F26OsouvQ/2lfBFcCw0utqrwfw1wutMoJM74nvoIlhUjxXquyYx8+FUoii3GzsRGaG7jCitZBEGeGUYcCMC+sFv1bwOw47AiMSp7tMSsqCxkO5yCAgS+WWFjifPZRn09KfB7VXCo8J0u1YxNpBo3f+jOTdYlsBPpTMhAUfE2Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8JyudOd; arc=none smtp.client-ip=74.125.224.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8JyudOd"
Received: by mail-yx2-f9.google.com with SMTP id 00721157ae682-8a77e8b7a95so369937b3.0
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061709; x=1791666509; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihH5QoOWQsyO/U84LYAf5Q31ga4ia8Sph2YHBUkvsV0=;
        b=j8JyudOdZurl8+MAf44ptAJIOqMa6xfa3HXkLtwpUcFFaweHeyND4zMspsl3TPieF9
         ZMNVyIc19rVDQmVmVf/W2qml8EU/W9FTGrupoYbBgx0ShRjM5EnGP/JCEePrsdvaaPrt
         4Kix1DYx26Fk94KJsZoZ+Jfo4trto0Cgi3QFSOpcoPnKFshIBcyD7x7aBuyOGJJKcAeJ
         9Yetgp3h+zg57AbMIM/4d1FzWpBEQXt0zQO2JkKbPPMBt41jG/lVSoyg9sK0n5k3Ydf5
         yosnJcgtSEDA6M77XcIqE7o3Cl7eIyG+ri2KpyhUCwRmuLys7rPnZi7ElyeMggvmieJt
         wIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061709; x=1791666509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihH5QoOWQsyO/U84LYAf5Q31ga4ia8Sph2YHBUkvsV0=;
        b=mgYsHg57QZuSQN2LN/Sff7yflMX7NqBN7UewXo/oc43Kdzy5Qt8hQcdX5Gf9Eu+qaC
         vEfP7ZyBxwo78JRaZrUh21e+1s/6vf8Il8kv36oc+tUNvQCFkRVrhVaz6+VDjD4Nf8ff
         kJurdt9A3ulglQlavwrrcyY/ch3BgAgrVSiVYbzdl4tuP3Mm2HTjiHHkVmkp2Op3tJys
         gVnHo6qKeqn0woST3yt7Bh9ifyRjj2+gnV3Or0L7YFk8hbD0Ce8GYDgsZhdTfeSTPC6T
         6GzNP4lSALaRYE45BON4l5HcICIAT+H4suBn7c8VfiwbL4IPkKtg/MahDDwcADmvwQU+
         1PWw==
X-Gm-Message-State: AFq9FYJe2YKDx+C5RX4hLsasoLYXe4AtCvy4K+v+swrNHcPWKa3W2HE1
	N7YMB9lZS/ivi1q8f9idfs+NYmuE6xnjgZzfi1owwOXWS60JZxBjr8M=
X-Gm-Gg: AYBFou3AvJX9qhrVCJYjwWzWriUi2aO81ir/rruW08Mg+1ERN2VkMsyt5RgyatzOTsE
	eKa0nCzTTA/++R4A4KXCH/W3DHlKx7IQ2RGuyplH8i85DQXstG3KSnLb/ag6iQ20ERkuP6h1IwB
	E5NA5EODBUO6nxx8BXhA/tP30vYBC1Sg2pPbGj18LG1DhO69LFBRSK/iPzZXNlXZzAzz/tIhnWb
	oSaXzmfZNQBf/dffTjmlodXRneObspCQkj9F7Bty8tvEOqGw3redBX0JQH42g+DshdQtXSXJZUZ
	VXWXznoef/+KXktI1aPyfPWekHUJA6I6lwf0VfAM6sDBiCa0B7n+rJ7nS8brD6lQqcDLhtoLzOe
	eG24u8STG6gqLP6WTB5Muev/a7YNj8hlZNG8euYStVw7zSp8z+5m57fpjAf1jCpfMuJKkxZAvVG
	E+V7pCvuOU6EweNdIrjftrEMgXweNaL7xNggQqlHV4r7i1HE7tlJmB8GtzQDc6pWXb8qzkXNHaa
	gELFLdKBMCp7+ZBP5np+ddAori1hKcfrUayHXukrwieZnqa4zgVnWPdQGIglSrh4ZgUIUzir0BB
	sEN1TFCN6NwnZlxji3tXrtrKOf0FhSgNyA==
X-Received: by 2002:a05:690c:698a:b0:873:5c6b:a31e with SMTP id 00721157ae682-8ae3acd6cf1mr24556887b3.24.1791061708647;
        Sat, 03 Oct 2026 14:08:28 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:27 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sat, 03 Oct 2026 14:07:56 -0700
Subject: [RFC PATCH v3 3/9] mm/damon: add perf-event overflow handler
 feeding the report ring
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-3-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

Add mm/damon/perf_source.c, an ops-agnostic perf-event source that turns
PMU overflow samples into DAMON access reports.  The overflow handler runs
in NMI context and reports through damon_report_access(), so it works with
either paddr or vaddr ops.

Each armed event carries its owning context, set when the probe is set up,
and the handler routes every report to that context's perf ring.  Setup
allocates the ring before arming the first counter, so the handler always
finds one.  Teardown clears the event's context with a release store
before releasing the counters, and the handler reads it with a matching
acquire load, so an overflow racing teardown drops its sample instead of
reporting into a context that is going away.

The handler sets whichever address fields the PMU provides: paddr when
PERF_SAMPLE_PHYS_ADDR is set, vaddr when PERF_SAMPLE_ADDR is set, plus the
CPU it runs on.  Both addresses are page aligned, matching the PAGE_SIZE
report size, so a sample that lands in the last page of a region is not
rejected by the drain as straddling the region end.  The drain matches on
whichever address the context's targets use.  The handler reports both
the thread id and the thread group id, because a VA-only PMU samples
whichever thread of a process happened to access memory while the drain
matches a target created for that process.

Per-CPU perf events are armed and released through cpuhp callbacks, so a
CPU coming online while a probe is armed gets a counter and a CPU going
offline releases its own.

A perf-event-backed damon_probe sets event_driven, so its hits are
credited through the report-ring drain rather than the apply_probes
vtable.  Both ops sets honour that flag in their probe vtables: an
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
 mm/damon/Kconfig       |  19 +++
 mm/damon/Makefile      |   1 +
 mm/damon/paddr.c       |  19 ++-
 mm/damon/perf_source.c | 411 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/damon/perf_source.h |  25 +++
 mm/damon/vaddr.c       |  18 ++-
 6 files changed, 491 insertions(+), 2 deletions(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index c7b6f3125e79..fd3a29f6c161 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -64,6 +64,25 @@ config DAMON_PADDR
 	  This builds the default data access monitoring operations for DAMON
 	  that works for the physical address space.
 
+config DAMON_PERF_SOURCE
+	bool "perf-event source for DAMON probes"
+	depends on DAMON && PERF_EVENTS
+	help
+	  Provides a PMU-agnostic perf-event overflow handler that feeds
+	  physical-address and virtual-address access reports into DAMON via
+	  damon_report_access().  Required for DAMON probe-weighted tiering
+	  with any address-sampling PMU.
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
index 22494754f41e..1abf6f2a5133 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
 obj-$(CONFIG_DAMON_ACMA)	+= modules-common.o acma.o
+obj-$(CONFIG_DAMON_PERF_SOURCE)	+= perf_source.o
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 65a5b3269d1d..80da41d20195 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -118,6 +118,16 @@ static void damon_pa_prep_probes_region(struct damon_region *r,
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
@@ -207,7 +217,14 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
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
index 000000000000..51e8957aed8c
--- /dev/null
+++ b/mm/damon/perf_source.c
@@ -0,0 +1,411 @@
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
+	struct damon_ctx *ctx;	/* owning ctx; NULLed at teardown */
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
+	struct damon_perf_probe_event *event =
+		(struct damon_perf_probe_event *)perf_event->overflow_handler_context;
+	int probe_idx;
+	struct damon_ctx *ctx;
+	struct damon_access_report report = {
+		.size = PAGE_SIZE,
+		.cpu = smp_processor_id(),
+	};
+
+	/*
+	 * Teardown NULLs event->ctx (with a release barrier) before releasing
+	 * the per-CPU perf events, so an in-flight overflow racing the
+	 * disable/release observes the torn-down state and drops the sample
+	 * instead of reporting into a freed ctx.  Pairs with the
+	 * smp_store_release(&event->ctx, NULL) in damon_perf_probe_teardown().
+	 */
+	ctx = smp_load_acquire(&event->ctx);
+	if (!ctx)
+		return;
+	probe_idx = event->probe_idx;
+	report.probe_idx = probe_idx;
+	report.ctx = ctx;	/* route to this ctx's per-ctx perf ring */
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
+		report.vaddr = data->addr & PAGE_MASK;
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
+						      event);
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
+	event->ctx = ctx;		/* route overflow reports to this ctx */
+
+	/*
+	 * Allocate the ctx's per-ctx perf report ring before arming any event,
+	 * so the overflow handler always finds a ready ring.  Idempotent across
+	 * a ctx's multiple probes.
+	 */
+	err = damon_ctx_alloc_perf_ring(ctx);
+	if (err)
+		goto release_owner;
+
+	err = -ENOMEM;
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
+	/* Stop in-flight overflows from reporting; see damon_perf_overflow(). */
+	smp_store_release(&event->ctx, NULL);
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
index 000000000000..8dcb128936ef
--- /dev/null
+++ b/mm/damon/perf_source.h
@@ -0,0 +1,25 @@
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
+
+#endif /* CONFIG_DAMON_PERF_SOURCE */
+#endif /* _DAMON_PERF_SOURCE_H */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b549496ea8e2..690da51758f2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -490,6 +490,16 @@ static void damon_va_prep_probe_region(struct damon_ctx *ctx,
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
@@ -594,7 +604,13 @@ static void damon_va_probe_folio(struct damon_ctx *ctx,
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
Git-157)

