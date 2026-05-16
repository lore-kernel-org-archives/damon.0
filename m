Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0B38AC6E
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970895; cv=none; b=EkDfLm5aiyeFM6xg1QgBW+QtKl8ULu+y6sTrcdXFjNiYieWp66Y0Vg0I2dn9xEfQlDzBS/qJuL/Ey2OTHH/cJX8BFVFIR07MFBWfOvONjarlbQoE+O5K2FnxEQQSBKliROZPryDwnqLEawyWIrrlwJaq3xZtmzEuRTv/9KUzTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970895; c=relaxed/simple;
	bh=U7geW279ChrFXLde61M58WBHBu8SgrbFDoM4Qrvb2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ckn2F8Hp/x3Z5d/HnCn95p1+1/viQEFlyC1TsfSNCPFChmtHh1RMccbPEwAh3noa/OrLApntfVynAqMIePgnA2VtndxF4vNsVicA4/lt18OdliLXV1Fizl7o4oyZC8oCG1wZemKrNDcV2lyXYybyHfVjegSCf4+Ew/Fnp/htt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTUSzsx8; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTUSzsx8"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7bdf83185bbso5223207b3.2
        for <damon@lists.linux.dev>; Sat, 16 May 2026 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970891; x=1779575691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8+0GSDgF6eaqM7aU4GbWIS0I2DgBkn1ubqIjVsKT2c=;
        b=YTUSzsx8U5noqQGfJEmYbvRsyG3a4/o/SVAkgo5Sv7lA2rXE0Azz4QPSlN6pv9frXm
         yMf4JYWOkcysL6HTh3nH0PD34cKlRKOEucVwNtdYXXaC4GUAjPsYfL7VmLBY6vq4pVDP
         R2EF2GPuhi3PFLVV+CK/4/uAQfu5ooKuNlketdOLCgIpBAAfhbuCXBzB5Zh4hid5eBrS
         RowPr2RFCw3kQb8rBCpJ6L6nyefkdzTQ93dyvZjMdGtQ5NxyVyNAaX554RjMZr1KR7Xn
         mVsj8Y/kg71+Q/X53ZIVjacB74gz+Epz27DXYUn2eeqyv4zIRogWA4ie++8AltvLMVqq
         7nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970891; x=1779575691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8+0GSDgF6eaqM7aU4GbWIS0I2DgBkn1ubqIjVsKT2c=;
        b=Bgy8e9vrrZVSxQuJxDz4ZtK6zzSc1uapCUZhYUDH+sCJMBYVroe/dS/C3VfzgzOMP9
         bijGvZ33AbNsTKpxrpqnYqsR81j4pJ87cHqGsL06mJ14/ZLd8mAWcuasiEkYrP3dhmc1
         io2bS+4RukxEpNfwHl7gHOQkcPr8fHooMaxuf8yQB0ie67cWyhtKsGITfU+vP1zYBLfz
         fpGi9HZXdRkJFwojlMDyi9DiEn+rLuGWIXsw3RBft+k7eAu4+NGGpO87HJY6/mDRYkxy
         zbobelObePlH1LT+wv0YY3wcIboeHICmiNOHTLymVnTh+YtgQCV7AbZTGsbrwxy7UoAa
         eXMA==
X-Forwarded-Encrypted: i=1; AFNElJ+E9kDUK8Hc08ybTS8MoTCx53+ioaAcpfZ0Hv69Qq1fb2zXqX5NUd/I2qXnmNjIKKXIo7wvag==@lists.linux.dev
X-Gm-Message-State: AOJu0YySf4CAb5gRS5FxQWFSamJ1WIZRrrUh+rhaJEVGTnSjX0TrKd73
	gDLdVAwaZiXW5PAJQ35Mqm/0EPtmtwQzKlEkfP0YLfjrELBWPQGjxkw=
X-Gm-Gg: Acq92OF0jm4qpuK8lTQcf985RSlLbUKaO2YieoZX5Uwrkx+D/I2VlS6vYAyFgj6agHY
	UiNT9gp5i3Rao1f4WqeiavMxOnkztoeJO6RHYP49TCkn9meORnvFcB+bzIHn9NfcQJQxrJaOf/E
	lvgEpBNACW5OXvSromvgvenvi7Ubj+wLZIXuBd+AvjdYnDncBBmHBsYRdhz/PTPxWP59fTixuCC
	Dg6ZKid8m3RTV38OQy6/sUWt/4IMLPNbe0R1XURh2OXPFRRpXSruk50Hohfs8o8JCP4FGV3S16A
	wWI0qDi/u0bUZ8SMoMS7ugzc2xIGjzWWfMOPh5LPVHirXTiBO5CkNxHdYSjL1tkgDiAKzpUR6cn
	aDb++eBM2F2c82wsTLQtcm7kn9/WPDvW4vzI4qCoLuhv4uKWSYFUWJi3+H+A/+Bi7l8MeT8FC8W
	nSjtPVmmmzlI6BLbsvBf7JpSW6vHwoGXYKuZPSw+ePduw4luIjTBoxeQCZF9nawpSh5tiMKNBjV
	Q==
X-Received: by 2002:a05:690c:4a01:b0:79a:b440:5c77 with SMTP id 00721157ae682-7c959e890bfmr110956107b3.17.1778970890889;
        Sat, 16 May 2026 15:34:50 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18c769sm641257b3.47.2026.05.16.15.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:34:50 -0700 (PDT)
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
Subject: [RFC PATCH 4/7] mm/damon/core: flat-array snapshot + bsearch in ring-drain loop
Date: Sat, 16 May 2026 15:34:29 -0700
Message-ID: <20260516223439.4033-5-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516223439.4033-1-ravis.opensrc@gmail.com>
References: <20260516223439.4033-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The drain loop is O(reports x regions) when matching each ring entry
back to a region.  At sufficiently large CPU x region products the
linear scan exceeds the sample interval, producing unbounded backlog.

At drain start, snapshot each target's regions into a flat array
(struct damon_target_lookup), already sorted by ascending r->ar.start.
Replace the linear lookup with binary search over the snapshot,
reducing the drain to O(reports x log2(regions)).

Reject reports that straddle a region boundary
(addr + report->size > r->ar.end) so partial-region accesses are
not credited to the lower region.

If the snapshot allocation fails under memory pressure, log
ratelimited and fall through to zero-access reporting; the next
tick retries.

Hoist the per-report damon_sample_filter_out() check out of the
per-target loop so it runs once per ring entry rather than N times.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h |   7 +++
 mm/damon/core.c       | 137 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 126 insertions(+), 18 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8e6e1cd89e551..35cc3d42fcba8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1045,6 +1045,13 @@ struct damon_ctx {
 
 	/* Per-ctx PRNG state for damon_rand(); kdamond is the sole consumer. */
 	struct rnd_state rnd_state;
+	/* Reusable drain-loop snapshot buffer (avoids per-tick kmalloc) */
+	struct {
+		struct damon_target_lookup *lookups;
+		unsigned int nr_lookups;
+		struct damon_region **region_buf;
+		unsigned int region_buf_cap;
+	} drain_snapshot;
 };
 
 /* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9ed789e932ebd..03f9c671e8bc9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -29,6 +29,13 @@
 #define DAMON_REPORT_RING_SIZE	256
 #define DAMON_REPORT_RING_MASK	(DAMON_REPORT_RING_SIZE - 1)
 
+/* Per-target region lookup for drain loop */
+struct damon_target_lookup {
+	struct damon_region **regions;
+	unsigned int nr_regions;
+};
+
+
 struct damon_report_ring {
 	unsigned int head;	/* written by producer (NMI) */
 	unsigned int tail	/* written by consumer (kdamond) */
@@ -855,6 +862,7 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->schemes);
 
 	prandom_seed_state(&ctx->rnd_state, get_random_u64());
+	/* drain_snapshot zero-initialized by kzalloc — no explicit init */
 
 	return ctx;
 }
@@ -884,6 +892,8 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_sample_filter_safe(f, next_f, &ctx->sample_control)
 		damon_destroy_sample_filter(f, &ctx->sample_control);
 
+	kfree(ctx->drain_snapshot.lookups);
+	kfree(ctx->drain_snapshot.region_buf);
 	module_put(ctx->ops.owner);
 	kfree(ctx);
 }
@@ -3806,27 +3816,44 @@ static bool damon_sample_filter_out(struct damon_access_report *report,
 	return !filter->allow;
 }
 
+
 static void kdamond_apply_access_report(struct damon_access_report *report,
-		struct damon_target *t, struct damon_ctx *ctx)
+		struct damon_region **regions, unsigned int nr_regions,
+		struct damon_ctx *ctx)
 {
 	struct damon_region *r;
 	unsigned long addr;
+	int left, right, mid;
 
-	if (damon_sample_filter_out(report, &ctx->sample_control))
-		return;
 	if (damon_target_has_pid(ctx))
 		addr = report->vaddr;
 	else
 		addr = report->paddr;
 
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
@@ -3850,10 +3877,79 @@ static unsigned int kdamond_apply_zero_access_report(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+/*
+ * Build a snapshot of the ctx's targets and their region arrays for
+ * use by the ring drain loop.
+ *
+ * The two-pass walk over adaptive_targets is safe even though
+ * krealloc_array() may sleep: target list mutation is funneled
+ * through damon_call onto the kdamond itself, so no other thread
+ * can mutate the list while kdamond is running this function.
+ */
+static struct damon_target_lookup *damon_build_target_lookup(
+		struct damon_ctx *ctx, unsigned int *nr_targets_out)
+{
+	struct damon_target *t;
+	struct damon_target_lookup *tbl;
+	unsigned int nr_targets = 0, total_regions = 0, ti = 0, ri = 0;
+
+	damon_for_each_target(t, ctx) {
+		nr_targets++;
+		total_regions += damon_nr_regions(t);
+	}
+
+	/* Realloc lookups array if needed */
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
+	/* Realloc contiguous region_buf if needed */
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
+	/* Fill lookup table, slicing region_buf across targets */
+	ri = 0;
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
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
 static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 {
 	int cpu;
-	struct damon_target *t;
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
 
 	for_each_cpu(cpu, &damon_rings_pending) {
 		struct damon_report_ring *ring =
@@ -3881,14 +3977,19 @@ static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 		while (tail != head) {
 			struct damon_access_report *report =
 				&ring->entries[tail];
-
-			if (!time_before(report->report_jiffies,
+			if (time_before(report->report_jiffies,
 					jiffies - usecs_to_jiffies(
-						ctx->attrs.sample_interval))) {
-				damon_for_each_target(t, ctx)
-					kdamond_apply_access_report(
-							report, t, ctx);
+						ctx->attrs.sample_interval)))
+				goto next;
+			if (damon_sample_filter_out(report,
+					&ctx->sample_control))
+				goto next;
+			for (i = 0; i < nr_targets; i++) {
+				kdamond_apply_access_report(report,
+						tbl[i].regions,
+						tbl[i].nr_regions, ctx);
 			}
+next:
 			tail = (tail + 1) & DAMON_REPORT_RING_MASK;
 		}
 		WRITE_ONCE(ring->tail, tail);
-- 
2.43.0

