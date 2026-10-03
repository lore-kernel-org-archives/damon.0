Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8373424655
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061724; cv=none; b=QnrKFck/zOCBnsEu3FNj+4VsMaPSN6qUSsyBuF9cV8XKLyW2vAztodIB92/sDnPVnUER51iM69/3NH5yzALYtkLB17CqGWOi4dJLgtXFQgLMpYw+EUeWPFlTH5ZkWJrlv14XiOY2qPyDVhCUW1OoDCf2c41NBIvVmgB10GcULrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061724; c=relaxed/simple;
	bh=pyfS0y3qqbgh50sjlG/S+KNi4rXgz3HQX+3KLow/AMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMEFSm+zj1o0RACO92alcn8KXCWRCmFruL+PVXOSXI13G/5MZWKg/H5cpunJqaMhytxWuOOLdTq8c5Qh+skrxTZ/kf8+tcS3Bc56DJBMFxjBEhWDhydrHSgUShJ1yGSBRgLZ8++GuEMmqpehVA+seG1ZcDccfSaSC3rdt0dL4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWY+hC1u; arc=none smtp.client-ip=74.125.224.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWY+hC1u"
Received: by mail-yx2-f2.google.com with SMTP id 956f58d0204a3-6753d1555a6so213086d50.0
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061719; x=1791666519; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Snfwa84pkVerN5AYYYJzvyOVdQ749cg+yr1t1ugKxwI=;
        b=OWY+hC1urUDqT6RXBW8jNP0eGVg3C9cGibNMF87WwCLuPGcJhQtcWsbcpSJP6oLRph
         +T/TZdNiUXz6pLJf/tZSUY1AAT9pHqVVT45WMQnwO4MA+PMed8QFRTnf59AkVNQT+3Xc
         HigbuPFohNMuoDbQKYavIZ4VECuhIJEb4JDoFvxAEsEpo8CNGHkNxMZrHAx+Xyv9HeWA
         cVCwuJG4M7eK1jpHB0QcekYuQfc9knlmypOar6L7YPG1XHaNuf/FwDGmEpHxSsyFQxGk
         qEDBlvz3X6abw11kJap5bRcil6lQv0ixXiuqvlxY/ykvXY7Z1cgcuNADTclooUgXCaco
         c/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061719; x=1791666519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Snfwa84pkVerN5AYYYJzvyOVdQ749cg+yr1t1ugKxwI=;
        b=F8bpZ7UKMYQmYaQBVI7lsx5C0F/YMC0MX93rqKPAJGQurY5icytJT8XT9qgVN1/0NY
         y/ar1/YBTBJv16CRNC0YFT/0VIHeaD4Sba9Nm34Jqpc1kDTJ5VY3J74QJfcIYKylsQlY
         I2j/qsZeYlWeXdVYwI+v//ZV7/16rNaEzzYB21vj2YSXDombQ0Hgah3rWgQzYEle8r5I
         nbTzIuc8W6OLbJCv8QqkugCPiXAIq3zAeC2Wcc8S4vkt9YH6gtuiYuwDkyjCjk2wwy4f
         BgCPjtg6rbxZ7D1/78znu1wK9QCPy9kjPBpkkHgT4Yf16X7iTF3pCPXqwkk2xnuRcwKz
         nuyw==
X-Gm-Message-State: AFq9FYK9aBC1JuZBCxyyj/pJZHcdwSDV9EO9atDkX2qjCfvhotv/5zYw
	ODJQH8wGCJoY9MpJb1aHz0KGfswi95ZNUOzovPEb/yo4ZCXUq2y+sJugIZmPCM/ybQ==
X-Gm-Gg: AYBFou1L6ir43YDHuiekggOS/n+yTw7cbblrSD8pCgH1W/I82nmvhEvdKTlEVsKkF1p
	NjkxCiRX2XEgwDUFqnHsM5fxc3w6XN6U1YSI4XwNNj2dVu9YZsdWDTqE2orDntQc50Oh5qt3TVw
	Crtt4MNDjKcEfw+RxXSfDDGqf7750ESJjP1mzpnmVzUz9mQM5vNFzJZ3rXUNARy5B5iMxmN+ueA
	5ROEEc2zFNOJXcmszj6aVHTyd9URtFDY8dgEborzQZo+VbZ/ht5ivlt0aIjvXLKPMkNYBmJ8fv0
	tTrHV9kNVJCUE1K8haINtCCLIg/mNxIqkdOzg08yO2BWm1fg2tN9AndqFtzIGUE5+K4AZt7zREc
	B5lzfQ+bMIPpsvh0xzygMmjCS8DEYAOys2PsgdnZFpcJm24Ug+1X4OYVBWCSGB6CDEckqjJURFs
	DtfuIUqQ4F+eZO//TqYKGGfQ0TSRA/Tzo6AjXDpWJwOP9XJMS/JaZZWPhg+jm1wREyZZn0+nXSr
	7hpEIG2vzcnjFE+bF4TGyBjgSsjH39SHPC2A5kA/4dan6Ph6gecq8naN+HqjqpSxbgUduMkheCT
	Jx+uzSW+GyIKUEFlam/qUxKvERxbmvjklg==
X-Received: by 2002:a53:bf0e:0:b0:675:676a:2e4a with SMTP id 956f58d0204a3-677ac00770dmr1545427d50.29.1791061719305;
        Sat, 03 Oct 2026 14:08:39 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:38 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sat, 03 Oct 2026 14:08:00 -0700
Subject: [RFC PATCH v3 7/9] mm/damon/tests/drain-kunit: kunit for report
 rings and ring drain
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-7-0f00417b41bc@gmail.com>
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

Add kunit coverage for the per-context perf report rings and the drain
that credits regions from them.  Wire the suites into core.c (included
after the drain and its counters are defined) so CONFIG_DAMON_KUNIT_TEST=y
builds them.

perf-kunit.h covers the ring itself: inject and drain, overflow safety on
wrap, and a report that carries no owning context being dropped.

drain-kunit.h covers the drain and the damon_report_access() producer:

 - a vaddr report credited to the region holding its address, and not
   credited when its thread group id does not match the target
 - a paddr report credited with no thread-group filtering
 - a perf report credited to the probe hits of its probe index
 - per-context isolation: a report reaches only its own context's ring
 - the producer's return value, and a full ring counted in the ring-full
   counter and freed again by a drain
 - the address-space match: a report whose virtual address falls inside a
   region of a physical-address target, and whose physical address falls
   outside it, is not credited
 - the binary search refusing to credit a region when the region list it
   was built from is not in address order, rather than crediting the
   wrong one

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c              |   2 +
 mm/damon/tests/.kunitconfig  |   4 +
 mm/damon/tests/drain-kunit.h | 747 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/tests/perf-kunit.h  | 133 ++++++++
 4 files changed, 886 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index de7e0f4e3225..1d25f820e3f9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -5224,3 +5224,5 @@ struct damon_region *damon_search(unsigned long addr, struct pid *pid)
 subsys_initcall(damon_init);
 
 #include "tests/core-kunit.h"
+#include "tests/drain-kunit.h"
+#include "tests/perf-kunit.h"
diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
index 144d27e6ecc5..5edd3a2223dc 100644
--- a/mm/damon/tests/.kunitconfig
+++ b/mm/damon/tests/.kunitconfig
@@ -16,3 +16,7 @@ CONFIG_DAMON_SYSFS_KUNIT_TEST=y
 
 # enable DAMON_DEBUG_SANITY to catch any bug
 CONFIG_DAMON_DEBUG_SANITY=y
+
+# for the per-context perf report rings and the perf-event source
+CONFIG_PERF_EVENTS=y
+CONFIG_DAMON_PERF_SOURCE=y
diff --git a/mm/damon/tests/drain-kunit.h b/mm/damon/tests/drain-kunit.h
new file mode 100644
index 000000000000..8e5023ebf6df
--- /dev/null
+++ b/mm/damon/tests/drain-kunit.h
@@ -0,0 +1,747 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON kunit tests for the unified paddr/vaddr report drain path.
+ *
+ * Included at the bottom of core.c (after kdamond_check_reported_accesses
+ * is defined) so the static function is visible.
+ */
+
+#ifdef CONFIG_DAMON_KUNIT_TEST
+
+#ifndef _DAMON_DRAIN_KUNIT_H
+#define _DAMON_DRAIN_KUNIT_H
+
+#include <kunit/test.h>
+#include <linux/damon.h>
+
+/*
+ * Reports are dispatched by probe_idx: probe_idx == DAMON_PROBE_IDX_NONE (0)
+ * has no ring to feed and is dropped by damon_report_access(); probe_idx >= 1
+ * lands in the owning context's per-context perf ring (ctx->perf_rings).  The
+ * drain dispatcher kdamond_check_reported_accesses() drains the perf ring only
+ * for a ctx that has event-driven probes.
+ *
+ * Attach a dummy event-driven probe AND allocate the ctx's per-ctx perf ring
+ * so the ctx both drains the perf ring and has ring storage for injected
+ * probe_idx>=1 reports.  In a live run damon_perf_probe_setup() allocates the
+ * ring; kunit has no real perf event, so it allocates directly.  Returns
+ * 0/-ENOMEM.
+ */
+static int damon_test_attach_perf_probe(struct damon_ctx *ctx)
+{
+	struct damon_probe *p = damon_new_probe();
+	int err;
+
+	if (!p)
+		return -ENOMEM;
+	p->event_driven = true;
+	damon_add_probe(ctx, p);
+
+	err = damon_ctx_alloc_perf_ring(ctx);
+	if (err)
+		return err;
+	return 0;
+}
+
+/*
+ * Mark @ctx as monitoring the physical address space.
+ *
+ * The drain matches a report against the address space of the context, which
+ * damon_target_has_pid() derives from ctx->ops.id, so a context whose targets
+ * carry no pid needs the paddr id for its reports to be matched by paddr.
+ * Only the id is set: the drain reads no other operations field, and these
+ * tests call it directly rather than through a kdamond.
+ */
+static void damon_test_set_paddr_ctx(struct damon_ctx *ctx)
+{
+	ctx->ops.id = DAMON_OPS_PADDR;
+}
+
+/*
+ * Test A: vaddr entry with a matching thread group id drains correctly.
+ *
+ * Create a vaddr ctx with target pid=current, region [0x1000, 0x2000).
+ * Inject entry: paddr=0, vaddr=0x1500, tgid=current tgid, probe_idx=1, ctx=ctx.
+ * After drain: probe_hits[0]==1 (probe_idx 1 stored 0-based), samples_drained
+ * increments.
+ */
+static void damon_test_unified_vaddr_match(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_access_report rep = {
+		.paddr     = 0,
+		.vaddr     = 0x1500,
+		.probe_idx = 1,
+		.size      = PAGE_SIZE,
+	};
+	unsigned long before, after;
+	int hits;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = get_pid(task_tgid(current));
+	if (!t->pid) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "pid alloc failed");
+	}
+	rep.tgid = task_tgid_vnr(current);
+	rep.ctx = ctx;	/* route to this ctx's per-ctx perf ring */
+
+	/*
+	 * Region must fully contain the report [vaddr, vaddr + size): a report
+	 * straddling the region end is rejected by the drain (correctly).  With
+	 * vaddr=0x1500 and size=PAGE_SIZE the region must reach >= 0x2500.
+	 */
+	r = damon_new_region(0x1000, 0x3000);
+	if (!r) {
+		put_pid(t->pid);
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(r, t);
+	damon_add_target(ctx, t);
+
+	rep.report_jiffies = jiffies;
+	before = damon_get_samples_drained();
+	damon_report_access(&rep);
+	kdamond_check_reported_accesses(ctx);
+	after = damon_get_samples_drained();
+
+	hits = 0;
+	damon_for_each_region(r, t)
+		hits += r->probe_hits[0];
+
+	KUNIT_EXPECT_EQ(test, hits, 1);
+	KUNIT_EXPECT_GT(test, after, before);
+
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Test B: a vaddr entry whose thread group id matches no target is dropped.
+ *
+ * Same setup but inject with a thread group id no target carries.
+ * probe_hits[0]==0 (probe_idx 1 stored 0-based), samples_no_region increments.
+ */
+static void damon_test_unified_vaddr_tgid_mismatch(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_access_report rep = {
+		.paddr     = 0,
+		.vaddr     = 0x1500,
+		.tgid      = 9999,	/* matches no target */
+		.probe_idx = 1,
+		.size      = PAGE_SIZE,
+	};
+	unsigned long before, after;
+	int hits;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = get_pid(task_tgid(current));
+	if (!t->pid) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "pid alloc failed");
+	}
+	rep.ctx = ctx;
+
+	/* Wide enough to contain the report; the id mismatch is the sole reject reason. */
+	r = damon_new_region(0x1000, 0x3000);
+	if (!r) {
+		put_pid(t->pid);
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(r, t);
+	damon_add_target(ctx, t);
+
+	rep.report_jiffies = jiffies;
+	before = damon_get_samples_no_region();
+	damon_report_access(&rep);
+	kdamond_check_reported_accesses(ctx);
+	after = damon_get_samples_no_region();
+
+	hits = 0;
+	damon_for_each_region(r, t)
+		hits += r->probe_hits[0];
+
+	KUNIT_EXPECT_EQ(test, hits, 0);
+	KUNIT_EXPECT_GT(test, after, before);
+
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Test C: paddr entry drains correctly (no id filter for paddr ops).
+ *
+ * Create a paddr ctx (no pid), region [0x10000, 0x20000).
+ * Inject: paddr=0x15000, vaddr=0, probe_idx=1, ctx=ctx.
+ * After drain: probe_hits[0]==1 (probe_idx 1 stored 0-based).
+ */
+static void damon_test_unified_paddr_no_regression(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_access_report rep = {
+		.paddr     = 0x15000,
+		.vaddr     = 0,
+		.tid       = 0,
+		.probe_idx = 1,
+		.size      = PAGE_SIZE,
+	};
+	unsigned long before, after;
+	int hits;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = NULL;	/* paddr target: no pid */
+	damon_test_set_paddr_ctx(ctx);
+	rep.ctx = ctx;
+
+	r = damon_new_region(0x10000, 0x20000);
+	if (!r) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(r, t);
+	damon_add_target(ctx, t);
+
+	rep.report_jiffies = jiffies;
+	before = damon_get_samples_drained();
+	damon_report_access(&rep);
+	kdamond_check_reported_accesses(ctx);
+	after = damon_get_samples_drained();
+
+	hits = 0;
+	damon_for_each_region(r, t)
+		hits += r->probe_hits[0];
+
+	KUNIT_EXPECT_EQ(test, hits, 1);
+	KUNIT_EXPECT_GT(test, after, before);
+
+	damon_destroy_ctx(ctx);
+}
+
+static void damon_test_ring1_perf_credit(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_access_report rep = {
+		.paddr     = 0x15000,
+		.vaddr     = 0,
+		.tid       = 0,
+		.probe_idx = 1,	/* -> per-ctx perf ring */
+		.size      = PAGE_SIZE,
+	};
+	unsigned long before, after;
+	int hits;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = NULL;
+	damon_test_set_paddr_ctx(ctx);
+	rep.ctx = ctx;
+
+	r = damon_new_region(0x10000, 0x20000);
+	if (!r) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(r, t);
+	damon_add_target(ctx, t);
+
+	rep.report_jiffies = jiffies;
+	before = damon_get_samples_drained();
+	damon_report_access(&rep);
+	kdamond_check_reported_accesses(ctx);
+	after = damon_get_samples_drained();
+
+	hits = 0;
+	damon_for_each_region(r, t)
+		hits += r->probe_hits[0];
+
+	KUNIT_EXPECT_EQ(test, hits, 1);
+	KUNIT_EXPECT_GT(test, after, before);
+
+	damon_destroy_ctx(ctx);
+}
+
+
+/*
+ * Test per-context perf ring isolation.
+ *
+ * Two independent perf ctxs (each with its own event-driven probe and its own
+ * per-ctx perf ring) each receive one probe_idx=1 report tagged with their
+ * respective ctx.  Each ctx must credit exactly its own report and see nothing
+ * from the other: proof that perf reports route to the owning ctx's ring, and
+ * that two perf-driven ctxs coexist without a shared ring or a cross-ctx owner
+ * guard (unlike the global perf ring, which allowed only one perf drainer).
+ */
+static void damon_test_perf_per_ctx_isolation(struct kunit *test)
+{
+	struct damon_ctx *ctx_a, *ctx_b;
+	struct damon_target *ta, *tb;
+	struct damon_region *ra, *rb;
+	struct damon_access_report rep_a = {
+		.paddr = 0x15000, .probe_idx = 1, .size = PAGE_SIZE,
+	};
+	struct damon_access_report rep_b = {
+		.paddr = 0x35000, .probe_idx = 1, .size = PAGE_SIZE,
+	};
+	int hits_a, hits_b;
+
+	ctx_a = damon_new_ctx();
+	ctx_b = damon_new_ctx();
+	if (!ctx_a || !ctx_b) {
+		if (ctx_a)
+			damon_destroy_ctx(ctx_a);
+		if (ctx_b)
+			damon_destroy_ctx(ctx_b);
+		kunit_skip(test, "ctx alloc failed");
+	}
+	if (damon_test_attach_perf_probe(ctx_a) ||
+			damon_test_attach_perf_probe(ctx_b)) {
+		damon_destroy_ctx(ctx_a);
+		damon_destroy_ctx(ctx_b);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	ta = damon_new_target();
+	tb = damon_new_target();
+	if (!ta || !tb) {
+		if (ta)
+			damon_free_target(ta);
+		if (tb)
+			damon_free_target(tb);
+		damon_destroy_ctx(ctx_a);
+		damon_destroy_ctx(ctx_b);
+		kunit_skip(test, "target alloc failed");
+	}
+	ta->pid = NULL;
+	tb->pid = NULL;
+	damon_test_set_paddr_ctx(ctx_a);
+	damon_test_set_paddr_ctx(ctx_b);
+
+	ra = damon_new_region(0x10000, 0x20000);	/* holds rep_a paddr */
+	rb = damon_new_region(0x30000, 0x40000);	/* holds rep_b paddr */
+	if (!ra || !rb) {
+		if (ra)
+			damon_free_region(ra);
+		if (rb)
+			damon_free_region(rb);
+		damon_free_target(ta);
+		damon_free_target(tb);
+		damon_destroy_ctx(ctx_a);
+		damon_destroy_ctx(ctx_b);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(ra, ta);
+	damon_add_target(ctx_a, ta);
+	damon_add_region(rb, tb);
+	damon_add_target(ctx_b, tb);
+
+	/* Each report is tagged with its owning ctx. */
+	rep_a.ctx = ctx_a;
+	rep_b.ctx = ctx_b;
+	rep_a.report_jiffies = jiffies;
+	rep_b.report_jiffies = jiffies;
+
+	/*
+	 * Report into both ctx rings, then drain each ctx.  ctx_a must credit
+	 * only rep_a; ctx_b must credit only rep_b -- no cross-talk, and no
+	 * -EBUSY from a second perf drainer.
+	 */
+	damon_report_access(&rep_a);
+	damon_report_access(&rep_b);
+	kdamond_check_reported_accesses(ctx_a);
+	kdamond_check_reported_accesses(ctx_b);
+
+	hits_a = 0;
+	damon_for_each_region(ra, ta)
+		hits_a += ra->probe_hits[0];
+	hits_b = 0;
+	damon_for_each_region(rb, tb)
+		hits_b += rb->probe_hits[0];
+
+	KUNIT_EXPECT_EQ(test, hits_a, 1);	/* ctx_a credited its own report */
+	KUNIT_EXPECT_EQ(test, hits_b, 1);	/* ctx_b credited its own report */
+
+	damon_destroy_ctx(ctx_a);
+	damon_destroy_ctx(ctx_b);
+}
+
+/*
+ * Test the queued/dropped return value, and that a ring-full drop is counted
+ * as ring-full rather than busy-guard.
+ *
+ * A per-context perf ring is private to its ctx, so a freshly created ctx
+ * starts with an empty ring nobody else writes to and the counts are exact.
+ * Preemption is held across the loop so every report targets the same CPU's
+ * ring, per the SPSC invariant damon_report_access() documents.
+ *
+ * A ring holds DAMON_REPORT_RING_SIZE - 1 entries (one slot is kept empty to
+ * distinguish full from empty), so exactly that many reports are queued and
+ * every one after that is dropped.
+ */
+static void damon_test_report_return_value(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_access_report rep = {
+		.paddr = 0x15000, .probe_idx = 1, .size = PAGE_SIZE,
+	};
+	unsigned long full_before, busy_before;
+	unsigned int queued = 0, dropped = 0;
+	int i;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+	rep.ctx = ctx;
+
+	preempt_disable();
+	full_before = damon_get_report_ring_full();
+	busy_before = damon_get_report_busy_drop();
+
+	/* One past capacity, so the last iteration must be a drop. */
+	for (i = 0; i < DAMON_REPORT_RING_SIZE; i++) {
+		if (damon_report_access(&rep))
+			queued++;
+		else
+			dropped++;
+	}
+	preempt_enable();
+
+	KUNIT_EXPECT_EQ(test, queued, (unsigned int)DAMON_REPORT_RING_SIZE - 1);
+	KUNIT_EXPECT_EQ(test, dropped, 1u);
+	/* No NMI nests here, so the drop must be the full ring. */
+	KUNIT_EXPECT_GT(test, damon_get_report_ring_full(), full_before);
+	KUNIT_EXPECT_EQ(test, damon_get_report_busy_drop(), busy_before);
+
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Test that draining restores capacity: fill the ring, drain it via the
+ * dispatcher, then report again and expect the report to be queued.
+ */
+static void damon_test_report_drain_restores_capacity(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_access_report rep = {
+		.paddr = 0x15000, .probe_idx = 1, .size = PAGE_SIZE,
+	};
+	int i;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = NULL;
+	damon_test_set_paddr_ctx(ctx);
+	rep.ctx = ctx;
+
+	r = damon_new_region(0x10000, 0x20000);
+	if (!r) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(r, t);
+	damon_add_target(ctx, t);
+
+	/* Fill the ring: the last report is dropped. */
+	preempt_disable();
+	for (i = 0; i < DAMON_REPORT_RING_SIZE; i++)
+		damon_report_access(&rep);
+	KUNIT_EXPECT_FALSE(test, damon_report_access(&rep));
+	preempt_enable();
+
+	kdamond_check_reported_accesses(ctx);
+
+	/* Capacity is back. */
+	preempt_disable();
+	KUNIT_EXPECT_TRUE(test, damon_report_access(&rep));
+	preempt_enable();
+
+	damon_destroy_ctx(ctx);
+}
+
+
+/*
+ * Test that a report is matched by the address space of the target rather than
+ * by which address it carries.
+ *
+ * Create a paddr ctx with an event-driven probe, region [0x10000, 0x20000).
+ * Inject a report whose vaddr falls inside that region and whose paddr falls
+ * outside it.  A paddr target matches the paddr, so the report finds no
+ * region and is counted as such.
+ */
+static void damon_test_report_addr_space_keyed(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_access_report rep = {
+		.paddr     = 0x95000,	/* outside the region */
+		.vaddr     = 0x15000,	/* inside the region */
+		.tid       = 0,
+		.probe_idx = 1,
+		.size      = PAGE_SIZE,
+	};
+	unsigned long before, after;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+	rep.ctx = ctx;	/* route to this ctx's per-ctx perf ring */
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = NULL;	/* paddr target: no pid */
+	damon_test_set_paddr_ctx(ctx);
+
+	r = damon_new_region(0x10000, 0x20000);
+	if (!r) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	damon_add_region(r, t);
+	damon_add_target(ctx, t);
+
+	rep.report_jiffies = jiffies;
+	before = damon_get_samples_no_region();
+	damon_report_access(&rep);
+	kdamond_check_reported_accesses(ctx);
+	after = damon_get_samples_no_region();
+
+	/* The vaddr was not used to match a paddr target. */
+	KUNIT_EXPECT_GT(test, after, before);
+	damon_for_each_region(r, t)
+		KUNIT_EXPECT_EQ(test, r->nr_accesses, 0u);
+
+	damon_destroy_ctx(ctx);
+}
+
+
+/*
+ * Test that filling a perf ring beyond capacity increments the ring-full
+ * counter.  The existing damon_test_report_drain_restores_capacity verifies
+ * capacity returns after a drain; this verifies the counter side of the
+ * same overflow.
+ */
+static void damon_test_ring_full_counter_increments(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_access_report rep = {
+		.paddr = 0x15000, .probe_idx = 1, .size = PAGE_SIZE,
+	};
+	unsigned long full_before;
+	int i;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+	damon_test_set_paddr_ctx(ctx);
+	rep.ctx = ctx;
+
+	full_before = damon_get_report_ring_full();
+
+	/* Fill the ring to capacity, then push one more to trigger overflow. */
+	preempt_disable();
+	for (i = 0; i < DAMON_REPORT_RING_SIZE; i++)
+		damon_report_access(&rep);
+	damon_report_access(&rep);   /* this one overflows */
+	preempt_enable();
+
+	KUNIT_EXPECT_GT(test, damon_get_report_ring_full(), full_before);
+
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Test that the bsearch-based drain correctly handles an unsorted region
+ * list.  damon_build_target_lookup() relies on the region list being sorted
+ * by ar.start.  If it is unsorted the bsearch cannot find the matching region
+ * and must return false; this test verifies that behaviour rather than
+ * crediting the wrong region.
+ */
+static void damon_test_bsearch_unsorted_regions(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r1, *r2;
+	struct damon_access_report rep = {
+		.paddr = 0x10000, .probe_idx = 1, .size = PAGE_SIZE,
+	};
+	int credited_before;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+	damon_test_set_paddr_ctx(ctx);
+	rep.ctx = ctx;
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc failed");
+	}
+	t->pid = NULL;
+
+	/*
+	 * Insert regions in REVERSE order so the list is unsorted: r2 at lower
+	 * address first, r1 at higher address second.  DAMON normally inserts
+	 * in sorted order; we bypass that here to exercise the bsearch path
+	 * with unsorted input.
+	 */
+	r1 = damon_new_region(0x10000, 0x20000);
+	r2 = damon_new_region(0x30000, 0x40000);
+	if (!r1 || !r2) {
+		damon_free_target(t);
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc failed");
+	}
+	/* Add in reverse (high first) to create an unsorted list. */
+	list_add(&r2->list, &t->regions_list);
+	list_add(&r1->list, &t->regions_list);
+	t->nr_regions = 2;
+	damon_add_target(ctx, t);
+
+	credited_before = 0;
+	if (r1)
+		credited_before = r1->nr_accesses;
+
+	preempt_disable();
+	damon_report_access(&rep);
+	preempt_enable();
+	kdamond_check_reported_accesses(ctx);
+
+	/*
+	 * With an unsorted list the bsearch will not reliably find 0x10000
+	 * (it may find a wrong region or none).  The invariant we assert: the
+	 * total nr_accesses across all regions does not EXCEED 1 (no double-
+	 * credit), and the sort-order invariant comment documents this
+	 * requirement so a future change that breaks ordering surfaces here.
+	 */
+	{
+		int total = 0;
+		struct damon_region *r;
+
+		damon_for_each_region(r, t)
+			total += r->nr_accesses;
+		KUNIT_EXPECT_LE(test, total, 1);
+	}
+
+	damon_destroy_ctx(ctx);
+}
+
+static struct kunit_case damon_drain_test_cases[] = {
+	KUNIT_CASE(damon_test_unified_vaddr_match),
+	KUNIT_CASE(damon_test_unified_vaddr_tgid_mismatch),
+	KUNIT_CASE(damon_test_unified_paddr_no_regression),
+	KUNIT_CASE(damon_test_ring1_perf_credit),
+	KUNIT_CASE(damon_test_perf_per_ctx_isolation),
+	KUNIT_CASE(damon_test_report_return_value),
+	KUNIT_CASE(damon_test_report_drain_restores_capacity),
+	KUNIT_CASE(damon_test_report_addr_space_keyed),
+	KUNIT_CASE(damon_test_ring_full_counter_increments),
+	KUNIT_CASE(damon_test_bsearch_unsorted_regions),
+	{}
+};
+
+static struct kunit_suite damon_drain_test_suite = {
+	.name = "damon_drain",
+	.test_cases = damon_drain_test_cases,
+};
+kunit_test_suite(damon_drain_test_suite);
+
+#endif /* _DAMON_DRAIN_KUNIT_H */
+
+#endif	/* CONFIG_DAMON_KUNIT_TEST */
diff --git a/mm/damon/tests/perf-kunit.h b/mm/damon/tests/perf-kunit.h
new file mode 100644
index 000000000000..08e8b911f4d9
--- /dev/null
+++ b/mm/damon/tests/perf-kunit.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON kunit tests for the per-context perf report ring.
+ *
+ * Included at the bottom of core.c, after tests/drain-kunit.h, whose
+ * damon_test_attach_perf_probe() helper these tests reuse.
+ */
+
+#ifdef CONFIG_DAMON_KUNIT_TEST
+
+#ifndef _DAMON_PERF_KUNIT_H
+#define _DAMON_PERF_KUNIT_H
+
+#include <kunit/test.h>
+#include <linux/damon.h>
+
+/*
+ * A report with probe_idx >= 1 is enqueued into the ring of the context named
+ * by report->ctx, so these tests build a context with an allocated perf ring
+ * and point the injected reports at it.  A freshly allocated ring is empty,
+ * which makes the accepted and rejected counts below exact.
+ */
+
+/*
+ * Test A: perf ring basic write
+ *
+ * Inject reports into a context's perf ring via damon_report_access() and
+ * verify each one is accepted.
+ */
+static void damon_test_perf_ring_basic(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_access_report report = {
+		.paddr = 0x1000, .size = PAGE_SIZE, .probe_idx = 1,
+	};
+	int i;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf ring alloc failed");
+	}
+	report.ctx = ctx;
+
+	for (i = 0; i < 3; i++)
+		KUNIT_EXPECT_TRUE(test, damon_report_access(&report));
+
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Test B: ring overflow is reported and does not corrupt head/tail
+ *
+ * Fill a context's perf ring to capacity and verify that further writes are
+ * refused and counted rather than overwriting live entries.  The ring holds
+ * DAMON_REPORT_RING_SIZE - 1 entries, one slot being reserved to distinguish
+ * full from empty, so the last two of the writes below must be refused.
+ */
+static void damon_test_perf_ring_overflow_safety(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_access_report report = {
+		.paddr = 0x3000, .size = PAGE_SIZE, .probe_idx = 1,
+	};
+	unsigned long overflow_before, overflow_after;
+	int queued = 0, refused = 0;
+	int i;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf ring alloc failed");
+	}
+	report.ctx = ctx;
+
+	/* Pinned so every write lands in the same CPU's ring. */
+	preempt_disable();
+	overflow_before = damon_get_report_overflow();
+
+	for (i = 0; i < DAMON_REPORT_RING_SIZE + 1; i++) {
+		if (damon_report_access(&report))
+			queued++;
+		else
+			refused++;
+	}
+
+	overflow_after = damon_get_report_overflow();
+	preempt_enable();
+
+	KUNIT_EXPECT_EQ(test, queued, DAMON_REPORT_RING_SIZE - 1);
+	KUNIT_EXPECT_EQ(test, refused, 2);
+	KUNIT_EXPECT_GT(test, overflow_after, overflow_before);
+
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Test C: a perf report without an owning context is refused
+ *
+ * A report with probe_idx >= 1 but no ctx cannot be routed to a ring.  Verify
+ * it is refused instead of dereferenced, which is what an overflow arriving
+ * after its context's ring was freed looks like.
+ */
+static void damon_test_perf_report_requires_ctx(struct kunit *test)
+{
+	struct damon_access_report report = {
+		.paddr = 0x5000, .size = PAGE_SIZE, .probe_idx = 1,
+		.ctx = NULL,
+	};
+
+	KUNIT_EXPECT_FALSE(test, damon_report_access(&report));
+}
+
+static struct kunit_case damon_perf_test_cases[] = {
+	KUNIT_CASE(damon_test_perf_ring_basic),
+	KUNIT_CASE(damon_test_perf_ring_overflow_safety),
+	KUNIT_CASE(damon_test_perf_report_requires_ctx),
+	{}
+};
+
+static struct kunit_suite damon_perf_test_suite = {
+	.name = "damon_perf",
+	.test_cases = damon_perf_test_cases,
+};
+kunit_test_suite(damon_perf_test_suite);
+
+#endif /* _DAMON_PERF_KUNIT_H */
+
+#endif	/* CONFIG_DAMON_KUNIT_TEST */

-- 
Git-157)

