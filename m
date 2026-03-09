Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03511F16B
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018040; cv=none; b=G385BxccNSvaxlEsCYFwCAUo0Yk03SsvmUjmzY+Gjba8htlfZ8Wxjspynzu+3RsTF2IMqXGryDouPAAQZiWSC13cvQo99q11RMvTxjaYfSQsuXmxG1zUkh0W8eh0IZlb8rJMEITwhy3L4X9c4ZyzpHzcj2sPJ6hsoHbugm3WBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018040; c=relaxed/simple;
	bh=NGQAwbh0eonvMn/502fepVgx9WwjPmeAEqNFF5zQefY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/WbmGCno5MC0S1xP0dCFTlctz6vkESJzh+acR+VaKqhd86DLfi9Uaj/OKp+QkRXKrd4mko0MIfBzU9/0Xj51ef8LoIKKFZ0IxeC9vr9CNxZcQRQroHBsbiKFt16Qiul0d2nEDadcA97xDjfCJft0rQlVf5OqLEN/4TR2YMlM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXpFQLkX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXpFQLkX"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so11157098b3a.3
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018038; x=1773622838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ftia8jqG22JrmUTK8MZbXcb4EANSUCc/UjRFsQcjVtY=;
        b=YXpFQLkXZLHOwaVHTwJ9Z9FzBHQpr0dX63ScGRCLIr0OWj8H9UaUpkldyl4r2b7r/v
         7vJG07rV0jQaUZf05jIMnk0CqEWaY2lH+X/EkaWf3CuBGexbedaDuGh+73BVTSx08TZb
         pRIgHzRlMki94iza78smQVmdz02fuwe+mfWfTf2+FX1YDqeW/+Gh8jNPoNZhb2n+Styo
         V2hwLnggkg0xu18s7cRdm4YpWcmPBvXkUMUPgY7U8jsn5oqg2tkR+4xJgnlId4rmHCZ2
         DbrQ5pURdrnVzPdmvcSWbihxxDPjEfMtfONKNZ6O52VkLNl5l5C64/x+HxBxEGArQ4hG
         TgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018038; x=1773622838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ftia8jqG22JrmUTK8MZbXcb4EANSUCc/UjRFsQcjVtY=;
        b=MJLvZsSKB7yJz8V9Xx+zTag5El3Hz2KvUb52mVVom2V+KUhO3DjUAzclCrxElXrmCg
         xm9E8pWS4Idl1FIwkuzWV2dB6I8xNmlhbtl6i4UzplwnhfsDW5wbNmKXDVhIylTIPVqG
         X+byLQ9jquxwYoLafc011KcJc6RixWEQXZmT5HUQZqxzTq988AqsxQeOGB76fagIKtQa
         lzIvRol3ga8JTkmrmNDDHLVbq4wOPVXde4Bt8VPuq2pM7oKV+d5fWvOk5u0F+R92OAYM
         l6KYHX1zTSz51S+2jpF/r3sRsZOXYVEvyTcsn/NEN9tB3yFyitS42G31zdC2L8Uj0yCB
         wmcQ==
X-Gm-Message-State: AOJu0Yyg8H5RG5OVJNaSKq1pxgVSSScz4VU3Q3Vu6pzX374baSL8nLu6
	SkrskBPLMi64f7Bx2vcKZ06PE+/XiFVB/akjUFOlYBHFlx6p4FY0Q9SsDlY3hw==
X-Gm-Gg: ATEYQzwkxOfrwJcJxZOxh85wZ21BCYQohAdu1Y+SS7MSAvBqqP0HnyUEDZj1QRVeoj1
	uHc5T79O61lEv9I91fXH/6JgTR+eVekniFxbOju9I/jPyKcKDAUMJEuU9eBtR30S8ORcmwYh1w1
	In2Pn1PY7N3zXK6N355pC7nJuv5Nv1mELdInT4EKKtYVWKUbnbf+TpKzFKBWJLarLzCYI80R9xj
	w59c72C9cIgFL4W7NzZxYkobfrRf3xp3pNLR9ru0HtKDeonLoBXLnE1IcTUd5i3yDVOFmUzbsDX
	dAs6/LDOD7C//lYQLpGesO3h/wbsIBqXIwN7cByvvttUkFlGQFYW3e5gsYoAMZJaznPXifVmJV0
	9zSA2aBR1Hne3g50ifpFh40HhmzaXA35tnmpb5GYh54YjrDjz67Uv50BIgccVsipuIXOGGd1VEa
	cgpaPWxWKGhYIzX/hLf8RMNpvaVl3w0VMKZYZ/NQ==
X-Received: by 2002:a05:6a00:4211:b0:829:924c:3488 with SMTP id d2e1a72fcca58-829a30c40e1mr7033001b3a.55.1773018037634;
        Sun, 08 Mar 2026 18:00:37 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:37 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 4/6] mm/damon/vaddr: support perf event based access check
Date: Mon,  9 Mar 2026 10:00:07 +0900
Message-ID: <20260309010009.11639-5-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds perf event based access check for virtual address space monitoring.

The perf event that can be specified for perf event-based access check must be able
to obtain the data source address corresponding to the sample.
In other words, PERF_SAMPLE_DATA_SRC must be able to be specified in perf_event_attr.sample_type

The perf event based access check is performed as follows:

1. During the sampling interval, samples of the perf event are stored in a sampling buffer.

2. After the sampling interval ends, during the access check, a histogram showing the number of accesses
to each memory address is generated based on each sample contained in the sampling buffer.

If the sampling buffer is full during a sampling interval,
the sampling buffer is expanded to prepare for the next sampling interval.

If you configure the memory addresses corresponding to the perf event samples to be obtained
as virtual addresses, the histogram is implemented as a two-dimensional xarray indexed
by pid and virtual memory address.

If you configure perf event samples to have their corresponding memory addresses retrieved
by physical addresses, the histogram is implemented using an xarray indexed by physical addresses.

3. For each monitoring target region, the number of accesses is updated based on the histogram.
---
 mm/damon/ops-common.h |  18 ++
 mm/damon/vaddr.c      | 406 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 418 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 395af11b91fb..7791e3fa0b7f 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -28,11 +28,29 @@ bool damos_ops_has_filter(struct damos *s);
 
 void damon_perf_prepare_access_checks(struct damon_ctx *ctx, struct damon_perf_event *event);
 
+struct damon_vaddr_histogram {
+	struct xarray targets;
+};
+
+struct damon_paddr_histogram {
+	struct xarray accesses;
+};
+
 struct damon_perf {
 	struct perf_event * __percpu *event;
 	struct damon_perf_buffer __percpu *buffer;
+	union {
+		struct damon_vaddr_histogram vaddr_histogram;
+		struct damon_paddr_histogram paddr_histogram;
+	};
 };
 
+void damon_paddr_histogram_init(struct damon_paddr_histogram *histogram);
+unsigned long damon_paddr_histogram_count(struct damon_paddr_histogram *histogram, u64 paddr);
+void damon_paddr_histogram_destroy(struct damon_paddr_histogram *histogram);
+
+void damon_perf_populate_paddr_histogram(struct damon_ctx *ctx, struct damon_perf_event *event);
+
 #else /* CONFIG_PERF_EVENTS */
 
 static inline void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4eb81cc1e8cd..a9398c319331 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -17,6 +17,7 @@
 
 #include <linux/circ_buf.h>
 #include <linux/perf_event.h>
+#include <linux/xarray.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -401,7 +402,7 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
  * Functions for the access checking of the regions
  */
 
-static void __damon_va_prepare_access_check(struct mm_struct *mm,
+static void __damon_va_basic_prepare_access_check(struct mm_struct *mm,
 					struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
@@ -409,7 +410,7 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
 	damon_va_mkold(mm, r->sampling_addr);
 }
 
-static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
+static void damon_va_basic_prepare_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct mm_struct *mm;
@@ -420,7 +421,7 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			__damon_va_prepare_access_check(mm, r);
+			__damon_va_basic_prepare_access_check(mm, r);
 		mmput(mm);
 	}
 }
@@ -539,7 +540,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void __damon_va_check_access(struct mm_struct *mm,
+static void __damon_va_basic_check_access(struct mm_struct *mm,
 				struct damon_region *r, bool same_target,
 				struct damon_attrs *attrs)
 {
@@ -565,7 +566,7 @@ static void __damon_va_check_access(struct mm_struct *mm,
 	last_addr = r->sampling_addr;
 }
 
-static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
+static unsigned int damon_va_basic_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct mm_struct *mm;
@@ -577,7 +578,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		mm = damon_get_mm(t);
 		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target,
+			__damon_va_basic_check_access(mm, r, same_target,
 					&ctx->attrs);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 			same_target = true;
@@ -1015,6 +1016,63 @@ struct damon_perf_buffer {
 	unsigned long size;
 };
 
+struct damon_vaddr_histogram_per_target {
+	struct xarray accesses;
+};
+
+static void damon_vaddr_histogram_init(struct damon_vaddr_histogram *histogram)
+{
+	xa_init(&histogram->targets);
+}
+
+static void damon_vaddr_histogram_add(struct damon_vaddr_histogram *histogram, u32 pid,
+						u64 vaddr)
+{
+	struct damon_vaddr_histogram_per_target *target;
+	unsigned long nr_accesses;
+
+	while (!(target = xa_load(&histogram->targets, pid))) {
+		target = kmalloc(sizeof(*target), GFP_KERNEL);
+		if (!target)
+			return;
+
+		xa_init(&target->accesses);
+
+		if (xa_err(xa_store(&histogram->targets, pid, target, GFP_KERNEL))) {
+			pr_warn_once("Failed to store target histogram\n");
+			kfree(target);
+			return;
+		}
+	}
+
+	nr_accesses = xa_to_value(xa_load(&target->accesses, vaddr));
+	xa_store(&target->accesses, vaddr, xa_mk_value(nr_accesses + 1), GFP_KERNEL);
+}
+
+static unsigned long damon_vaddr_histogram_count(struct damon_vaddr_histogram *histogram,
+							u32 pid, u64 vaddr)
+{
+	struct damon_vaddr_histogram_per_target *target;
+	unsigned long nr_accesses = 0;
+
+	target = xa_load(&histogram->targets, pid);
+	if (target)
+		nr_accesses = xa_to_value(xa_load(&target->accesses, vaddr));
+
+	return nr_accesses;
+}
+
+static void damon_vaddr_histogram_destroy(struct damon_vaddr_histogram *histogram)
+{
+	unsigned long index;
+	struct damon_vaddr_histogram_per_target *target;
+
+	xa_for_each(&histogram->targets, index, target)
+		xa_destroy(&target->accesses);
+
+	xa_destroy(&histogram->targets);
+}
+
 static void damon_perf_overflow(struct perf_event *perf_event, struct perf_sample_data *data,
 				struct pt_regs *regs)
 {
@@ -1158,6 +1216,298 @@ void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
 	}
 }
 
+static void damon_va_perf_check_accesses_by_vaddr(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	struct damon_target *t;
+	int cpu;
+	unsigned int tidx = 0;
+
+	if (!perf)
+		return;
+
+	damon_vaddr_histogram_init(&perf->vaddr_histogram);
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+		unsigned long head, tail, count, i;
+
+		if (!perf_event)
+			continue;
+
+		perf_event_disable(perf_event);
+
+		head = smp_load_acquire(&buffer->head);
+		tail = buffer->tail;
+		count = CIRC_CNT(head, tail, buffer->size);
+
+		for (i = 0; i < count; i++) {
+			struct damon_access_report *report =
+				&buffer->reports[(tail + i) & (buffer->size - 1)];
+
+			damon_vaddr_histogram_add(&perf->vaddr_histogram, report->tid,
+							report->vaddr & PAGE_MASK);
+		}
+		smp_store_release(&buffer->tail, (tail + count) & (buffer->size - 1));
+
+		if ((count == buffer->size - 1) && (buffer->size < DAMON_PERF_MAX_RECORDS)) {
+			void *new_reports = kvcalloc_node(buffer->size * 2,
+					sizeof(buffer->reports[0]), GFP_KERNEL,
+					cpu_to_node(cpu));
+
+			if (new_reports) {
+				kvfree(buffer->reports);
+				buffer->reports = new_reports;
+				buffer->head = 0;
+				buffer->tail = 0;
+				buffer->size *= 2;
+			}
+		}
+	}
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+		u32 pid = pid_nr(t->pid);
+		unsigned int nr_accessed = 0;
+
+		damon_for_each_region(r, t) {
+			unsigned long addr;
+
+			if (r->accessed)
+				continue;
+
+			for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+				if (damon_vaddr_histogram_count(&perf->vaddr_histogram, pid,
+									addr & PAGE_MASK)) {
+					r->accessed = true;
+					nr_accessed++;
+					break;
+				}
+			}
+		}
+		tidx++;
+	}
+
+	damon_vaddr_histogram_destroy(&perf->vaddr_histogram);
+}
+
+struct damon_paddr_walk {
+	struct damon_paddr_histogram *histogram;
+	bool accessed;
+};
+
+static void damon_paddr_histogram_add(struct damon_paddr_histogram *histogram, u64 paddr);
+static const struct mm_walk_ops damon_paddr_ops;
+
+void damon_perf_populate_paddr_histogram(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	int cpu;
+
+	if (!perf)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+		unsigned long head, tail, count, i;
+
+		if (!perf_event)
+			continue;
+
+		perf_event_disable(perf_event);
+
+		head = smp_load_acquire(&buffer->head);
+		tail = buffer->tail;
+		count = CIRC_CNT(head, tail, buffer->size);
+
+		for (i = 0; i < count; i++) {
+			struct damon_access_report *report =
+				&buffer->reports[(tail + i) & (buffer->size - 1)];
+
+			damon_paddr_histogram_add(&perf->paddr_histogram,
+							report->paddr & PAGE_MASK);
+		}
+		smp_store_release(&buffer->tail, (tail + count) & (buffer->size - 1));
+
+		if ((count == buffer->size - 1) && (buffer->size < DAMON_PERF_MAX_RECORDS)) {
+			void *new_reports = kvcalloc_node(buffer->size * 2,
+					sizeof(buffer->reports[0]), GFP_KERNEL,
+					cpu_to_node(cpu));
+
+			if (new_reports) {
+				kvfree(buffer->reports);
+				buffer->reports = new_reports;
+				buffer->head = 0;
+				buffer->tail = 0;
+				buffer->size *= 2;
+			}
+		}
+	}
+}
+
+static void damon_va_perf_check_accesses_by_paddr(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	struct damon_target *t;
+	unsigned int tidx = 0;
+
+	if (!perf)
+		return;
+
+	damon_paddr_histogram_init(&perf->paddr_histogram);
+
+	damon_perf_populate_paddr_histogram(ctx, event);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+		struct mm_struct *mm = damon_get_mm(t);
+		unsigned int nr_accessed = 0;
+
+		if (!mm)
+			continue;
+
+		mmap_read_lock(mm);
+		damon_for_each_region(r, t) {
+			struct damon_paddr_walk walk_private = {
+				.histogram = &perf->paddr_histogram,
+				.accessed = false,
+			};
+
+			if (r->accessed)
+				continue;
+
+			walk_page_range(mm, r->ar.start, r->ar.end, &damon_paddr_ops,
+					&walk_private);
+			if (walk_private.accessed) {
+				r->accessed = true;
+				nr_accessed++;
+			}
+		}
+		mmap_read_unlock(mm);
+		mmput(mm);
+		tidx++;
+	}
+
+	damon_paddr_histogram_destroy(&perf->paddr_histogram);
+}
+
+static void damon_va_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	if (event->attr.sample_phys_addr)
+		return damon_va_perf_check_accesses_by_paddr(ctx, event);
+	else
+		return damon_va_perf_check_accesses_by_vaddr(ctx, event);
+}
+
+void damon_paddr_histogram_init(struct damon_paddr_histogram *histogram)
+{
+	xa_init(&histogram->accesses);
+}
+
+static void damon_paddr_histogram_add(struct damon_paddr_histogram *histogram,
+						u64 paddr)
+{
+	unsigned long nr_accesses;
+
+	nr_accesses = xa_to_value(xa_load(&histogram->accesses, paddr));
+	xa_store(&histogram->accesses, paddr, xa_mk_value(nr_accesses + 1), GFP_KERNEL);
+}
+
+unsigned long damon_paddr_histogram_count(struct damon_paddr_histogram *histogram, u64 paddr)
+{
+	return xa_to_value(xa_load(&histogram->accesses, paddr));
+}
+
+void damon_paddr_histogram_destroy(struct damon_paddr_histogram *histogram)
+{
+	xa_destroy(&histogram->accesses);
+}
+
+static int damon_paddr_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	pte_t *pte;
+	spinlock_t *ptl;
+	struct damon_paddr_walk *paddr_walk = walk->private;
+
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		pmd_t pmde = pmdp_get(pmd);
+
+		if (pmd_present(pmde)) {
+			for (; addr < next && !paddr_walk->accessed; addr += PAGE_SIZE) {
+				u64 frame = pmd_pfn(pmde) +
+					((addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT);
+
+				if (damon_paddr_histogram_count(paddr_walk->histogram,
+						PFN_PHYS(frame))) {
+					paddr_walk->accessed = true;
+					break;
+				}
+			}
+		}
+		spin_unlock(ptl);
+		return paddr_walk->accessed ? 1 : 0;
+	}
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	for (; addr < next && !paddr_walk->accessed; pte++, addr += PAGE_SIZE) {
+		pte_t ptent = ptep_get(pte);
+
+		if (pte_present(ptent)) {
+			if (damon_paddr_histogram_count(paddr_walk->histogram,
+					PFN_PHYS(pte_pfn(ptent)))) {
+				paddr_walk->accessed = true;
+			}
+		}
+	}
+
+	pte_unmap_unlock(pte - 1, ptl);
+
+	return paddr_walk->accessed ? 1 : 0;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static int damon_paddr_hugetlb_entry(pte_t *pte, unsigned long hmask,
+		unsigned long addr, unsigned long end,
+		struct mm_walk *walk)
+{
+	struct damon_paddr_walk *paddr_walk = walk->private;
+	pte_t entry = huge_ptep_get(walk->mm, addr, pte);
+
+	if (pte_present(entry)) {
+		for (; addr < end; addr += PAGE_SIZE) {
+			u64 frame = pte_pfn(entry) + ((addr & ~hmask) >> PAGE_SHIFT);
+
+			if (damon_paddr_histogram_count(paddr_walk->histogram,
+						PFN_PHYS(frame))) {
+				paddr_walk->accessed = true;
+				break;
+			}
+		}
+	}
+
+	return paddr_walk->accessed ? 1 : 0;
+}
+#else
+#define damon_perf_hugetlb_entry NULL
+#endif /* CONFIG_HUGETLB_PAGE */
+
+static const struct mm_walk_ops damon_paddr_ops = {
+	.pmd_entry = damon_paddr_pmd_entry,
+	.hugetlb_entry = damon_paddr_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
 #else
 
 static inline int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
@@ -1197,6 +1547,50 @@ static void damon_va_init(struct damon_ctx *ctx)
 		damon_va_init_regions(ctx);
 }
 
+static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event;
+
+	if (list_empty(&ctx->perf_events))
+		return damon_va_basic_prepare_access_checks(ctx);
+
+	list_for_each_entry(event, &ctx->perf_events, list) {
+		damon_perf_prepare_access_checks(ctx, event);
+	}
+}
+
+static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_perf_event *event;
+	unsigned int max_nr_accesses = 0;
+
+	if (list_empty(&ctx->perf_events))
+		return damon_va_basic_check_accesses(ctx);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t)
+			r->accessed = false;
+	}
+
+	list_for_each_entry(event, &ctx->perf_events, list) {
+		damon_va_perf_check_accesses(ctx, event);
+	}
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t) {
+			damon_update_region_access_rate(r, r->accessed, &ctx->attrs);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
 void damon_ops_cleanup(struct damon_ctx *ctx)
 {
 	struct damon_perf_event *event;
-- 
2.43.0

