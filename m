Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD073F5BF0
	for <damon@lists.linux.dev>; Fri, 29 May 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073823; cv=none; b=pS2VGKsW0pBbLNJIQSPzgP2ZXYqGhw0Le/Xl1uvHZBxcULa7nTQyGJwMwYGMVp5nK9S1hrJK5EFpsIKHd7H/sqeRebZg6N1ITltCaYoO+XttXI1dMRSjE4F2gcqaylB0PNRQ+zAJrflE+jdq7HuQZymE4hi3N7ZJZYVSXMxHOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073823; c=relaxed/simple;
	bh=/WB7DhhL0YPzVpIXGI8fiP8eIBsrpdAk77Iyd16ISAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U64IFm2WHHHIEHdzQ1/oXv+jYvdxE36RLa7LlumH9d+rqd0kTEEf6aGedlzIGCo8naiBrX9M91fli28CyA5hiwFFlwpYlDXfD/5YFG5c6Nj22V5B9//oaUCqFUskJXVdTgLhoydR/0GHIILkqpRDNxOzFxzjorBOOcu7+fZ+QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl8nEKXF; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl8nEKXF"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso3830278fac.0
        for <damon@lists.linux.dev>; Fri, 29 May 2026 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073820; x=1780678620; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBG7U8aH1ARs37G3HmZz4dhZEB7morx48iJcdEwFffY=;
        b=Fl8nEKXFrO11P0ubx3DvR+1JiiA3k0AClZjmc3LzKBGKP9KwWjoER6BqJeDU6J0Wkx
         Cs+UDUjzFogNiP5Liy54Rajh3bGN7GGx4UTgsNbFx0ZwpTJfP25va2Dh6CiBJ+B1LmI/
         GNa/5yl61GYfwk44EXtUQ4WdQjktiwKqaeU5eed9yA2u+/5QMLL2EGFXSZwcmjpAz9nl
         s4srf6Mov9DIUJsMayGD0BRA8rt7EGYmIXrzq1wzxFYQjp6jATXkN9nxbGR/FhhPaMMr
         OxICv+ceD/XID5g8nzT1wEGl6ZjKfUQobyRd6aVTrbUG8bDFCarjKzjXon1OsrIaS1sx
         JNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073820; x=1780678620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBG7U8aH1ARs37G3HmZz4dhZEB7morx48iJcdEwFffY=;
        b=QkWjFwIPEjC+UaMz2L7mDVgTunltvGiJ45ZKZoiFNHOsLoPs4slZFFrCqRV26J3tkV
         5QVSGRcL42ckrCMAzoRyvRlsbQrijZ8VyBQ+KZXwnrmYdFn5Ej0CXGHEejLAqrivs21r
         jqxc9blr+TgK0MVA1svzcCy60AvP6MN/B8zq+42KLC81rfBZ3C5aOORJBMw83ImWGmjJ
         f2GCIfcobiA4MZuP33yNCyxQB0NhE7OXkhcRccdCl1Ln0tfYlJm5ekKi1LYZn1UlY1M0
         1KSkaI5TVlVi20VbASiE2yRQAYgDSySQWyF/Kc/WNjW4KHxqc9CTH8WqEFhNt4gNlbib
         3VRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ceAg4mUQ4q1hSHYIo3Sv/jcpVg7f7cJo7muczjl0PKkpukOAv4UXX5aGrefoP8l9L9noOrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRfZcZz7IJ5jZ4ADBWl7URll8SvaayxAFuZPjZMVEGeSoVMn4c
	mUXWaiSaj31m/5s7NqIb3hMPn5SNwMwi3W/wXNESrsKa4uVwrcNzkok=
X-Gm-Gg: Acq92OGcbz1jvnRNB6tVqO87FcZy8qH+BOegwc+DG/HVee5cMGqHc21+W2+mRF6I4c4
	+AjqVttGe0Ng31xnqmgpfaSJooadYh5rF+w8vO5NDfqVDyq70eRIdcN4pkcqvfVOdE8mSZyN5Mn
	km9cedKxsPwjCrm2xeivM966Re7K4axPfNp0GrdVBoA9X3AKrPhohTO9jZ6qdo6j4M5WJ5w0Y8i
	FpymkYejDHsjdQzv/inu0hKn6ICg81z+i2AF6THlaOL9UK3cijfvuz+ICOuw2Fk90wlbHN3pbyr
	UvXeQhqDrrYnE20MUE3HISE0i/Ot433gFeh1yS1DJDCLmOkfP0fT5UWKeKoCDnKPPvCSTDKx+2h
	XZ1DZvzQ1ASefhtMM9uGxf26UQb6u8OOHz/L/splVsVmAsCfS4dQYxBBJeRjvF6b3Qt/v0TkVMY
	uq2aCKp5pnNwWIJ65PRJIliPcUUX9AOsTpylfwHKL/sOQ2zsCc20KOv/efmjggpl8ZuAO7bMMs9
	ZaJb10Qd/d6
X-Received: by 2002:a05:6871:890:b0:423:4260:2e0d with SMTP id 586e51a60fabf-43c891e473cmr1659989fac.8.1780073820507;
        Fri, 29 May 2026 09:57:00 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ef3ad7sm1403070fac.9.2026.05.29.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:57:00 -0700 (PDT)
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
Subject: [RFC PATCH 1/6] mm/damon: add struct damon_perf_event{,_attr} and per-ctx perf_events list
Date: Fri, 29 May 2026 09:56:35 -0700
Message-ID: <20260529165640.820-2-ravis.opensrc@gmail.com>
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

Introduce the substrate types for using perf events as DAMON access
check sources.  struct damon_perf_event_attr carries the raw PMU attr
configurable from userspace; struct damon_perf_event is the per-event
entry on a new damon_ctx::perf_events list.

Declare damon_perf_init() and damon_perf_cleanup() in
mm/damon/ops-common.h.  When CONFIG_PERF_EVENTS=n they fold to a no-op
returning -ENOSYS.

Suggested-by: Akinobu Mita <akinobu.mita@gmail.com>
Link: https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h   | 80 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h   | 39 ++++++++++++++++++++
 mm/damon/sysfs-common.h |  6 ++++
 3 files changed, 125 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c0375035a3a7b..11f1c1071b9ba 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -123,6 +123,7 @@ struct damon_target {
  * @size:		The size of the accessed address range.
  * @cpu:		The id of the CPU that made the access.
  * @tid:		The task id of the task that made the access.
+ * @tgid:		Thread group id of the task that made the access.
  * @is_write:		Whether the access is write.
  *
  * Any DAMON API callers that notified access events can report the information
@@ -135,6 +136,7 @@ struct damon_access_report {
 	unsigned long size;
 	unsigned int cpu;
 	pid_t tid;
+	pid_t tgid;
 	bool is_write;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
@@ -501,6 +503,7 @@ struct damos_filter {
 };
 
 struct damon_ctx;
+struct damon_target_lookup;
 struct damos;
 
 /**
@@ -966,6 +969,67 @@ struct damon_sample_control {
 	struct list_head sample_filters;
 };
 
+/**
+ * struct damon_perf_event_attr - raw PMU event attr for access check.
+ *
+ * @type:		raw PMU event type.
+ * @config:		raw PMU event config.
+ * @config1:		raw PMU event config1.
+ * @config2:		raw PMU event config2.
+ * @sample_phys_addr:	whether to set PERF_SAMPLE_PHYS_ADDR in sample_type.
+ * @sample_weight_struct:	whether to set PERF_SAMPLE_WEIGHT_STRUCT in
+ *				sample_type.  PMUs that do not advertise
+ *				weight (e.g. AMD IBS Op) reject events with
+ *				this flag set, so it must be opt-in.
+ * @exclude_kernel:	exclude kernel-mode samples.
+ * @exclude_hv:		exclude hypervisor samples.
+ * @freq:		when true use @sample_freq, otherwise @sample_period.
+ * @sample_freq:	target sample rate when @freq is true.
+ * @sample_period:	period (samples-between-overflows) when @freq is false.
+ * @wakeup_events:	perf_event_attr.wakeup_events.
+ * @precise_ip:		precise sampling skid bound (PEBS-style PMUs).
+ */
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
+/**
+ * struct damon_perf_event - perf event for access check.
+ *
+ * @attr:	Per-event PMU attribute (configured via sysfs).
+ * @priv:	Monitoring operations-specific data.
+ * @list:	List head for &damon_ctx->perf_events siblings.
+ * @hlist_node:	Tracks this event among cpuhp multi-instance entries.
+ * @init_complete:	Set after the synchronous online sweep finishes; gates
+ *		@any_cpu_failed writes from late hotplug callbacks.
+ * @any_cpu_failed:	Set by the cpuhp online callback if perf_event creation
+ *		fails on any CPU during the synchronous initial install.
+ * @ctx:	Back-pointer to the owning damon_ctx; the cpu_online callback
+ *		reads ctx->perf_events_active to decide whether to enable a
+ *		late-onlining CPU's event immediately after create.
+ */
+struct damon_perf_event {
+	struct damon_perf_event_attr attr;
+	void *priv;
+	struct list_head list;
+	struct hlist_node hlist_node;
+	bool init_complete;
+	bool any_cpu_failed;
+	struct damon_ctx *ctx;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
@@ -991,6 +1055,11 @@ struct damon_sample_control {
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
  * @pause:	Pause kdamond main loop.
+ * @perf_events:	Head of perf events (&damon_perf_event) list.
+ * @perf_events_active:	Set while kdamond_fn has the perf events armed.
+ *		Cleared in the kdamond_fn done path before the events are
+ *		disabled; serves as the gate for damon_commit_perf_events()
+ *		and the kdamond_fn drain dispatch.
  */
 struct damon_ctx {
 	struct damon_attrs attrs;
@@ -1046,6 +1115,9 @@ struct damon_ctx {
 	unsigned long min_region_sz;
 	bool pause;
 
+	struct list_head perf_events;
+	bool perf_events_active;
+
 /* private: */
 	/* Head of monitoring targets (&damon_target) list. */
 	struct list_head adaptive_targets;
@@ -1054,6 +1126,14 @@ struct damon_ctx {
 
 	/* Per-ctx PRNG state for damon_rand(); kdamond is the sole consumer. */
 	struct rnd_state rnd_state;
+
+	/* Reusable drain-loop snapshot buffer (avoids per-tick kmalloc). */
+	struct {
+		struct damon_target_lookup *lookups;
+		unsigned int nr_lookups;
+		struct damon_region **region_buf;
+		unsigned int region_buf_cap;
+	} drain_snapshot;
 };
 
 /* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 5efa5b5970def..35da400a67ec1 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -23,3 +23,42 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
 
 bool damos_ops_has_filter(struct damos *s);
+
+#ifdef CONFIG_PERF_EVENTS
+
+/*
+ * Per-event opaque allocated by damon_perf_init().  The NMI overflow
+ * handler does NOT touch this struct; submission goes through the
+ * shared per-CPU SPSC ring via damon_report_access().
+ */
+struct damon_perf {
+	struct perf_event * __percpu *event;
+};
+
+int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event);
+void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event);
+void damon_perf_event_arm(struct damon_perf_event *event);
+void damon_perf_event_disarm(struct damon_perf_event *event);
+
+#else /* !CONFIG_PERF_EVENTS */
+
+static inline int damon_perf_init(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+	return -ENOSYS;
+}
+
+static inline void damon_perf_cleanup(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+}
+
+static inline void damon_perf_event_arm(struct damon_perf_event *event)
+{
+}
+
+static inline void damon_perf_event_disarm(struct damon_perf_event *event)
+{
+}
+
+#endif /* CONFIG_PERF_EVENTS */
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 25a6c28abdea8..67c7545fd57d0 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -66,10 +66,13 @@ int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id);
  * sample directory
  */
 
+struct damon_sysfs_perf_events;
+
 struct damon_sysfs_sample {
 	struct kobject kobj;
 	struct damon_sysfs_primitives *primitives;
 	struct damon_sysfs_sample_filters *filters;
+	struct damon_sysfs_perf_events *perf_events;
 };
 
 struct damon_sysfs_sample *damon_sysfs_sample_alloc(void);
@@ -82,3 +85,6 @@ extern const struct kobj_type damon_sysfs_sample_ktype;
 int damon_sysfs_set_sample_control(
 		struct damon_sample_control *control,
 		struct damon_sysfs_sample *sysfs_sample);
+
+int damon_sysfs_add_perf_events(struct damon_ctx *ctx,
+		struct damon_sysfs_sample *sysfs_sample);
-- 
2.43.0

