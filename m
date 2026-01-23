Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2137B406
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134303; cv=none; b=CmJfYwA9Xhn2WRamMfgThSzskJ1qKr8+Jv2+fuCwqeIrs7nNYpj3Cg8jyh9NiEVXfDQEMGNLRPfoA+KocKHyC6b/bL5DSWJ9EGNk6EU43D3I8wm73Np5tBJxs44XVFHEUeLbZy7EzHXZW9dRcr8nL+r7hpIXo8pUU0lbLU1WXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134303; c=relaxed/simple;
	bh=XLxOp+SksKhv+5T175voz/v1FYX6066z5ZIehTIlo44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATmUmIqRQT3JUlzqU5IZS/ut+QNlBYtrhNCa7qPPESaXTtMmoieT3KNh9Asp72yJf+ppfcgXZ7p4duHOp/vwCKo1k2zpck7xe0vup8VygWIGhwpaXgFwVjyeMXVt0VxPYcZg8CcUpD2NeCXnE8duSqsiNvM2+rvaPn8zaQEo6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThCT+Uip; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThCT+Uip"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c622ce9a33bso515538a12.2
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 18:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769134258; x=1769739058; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MWWNUHdoxkkBnQ9aWgKGZtECd2UHxVzPBy9BVberW4=;
        b=ThCT+UipvF+9QuQ57nKudXXZLtt7XBHStPg4Xs9fWjHHpkG6KtotzHY2OXxhPWHjW5
         BwwH+ZmwxB4YUMWF6odvWgZsmz+tClbMkr57toef/UwOWEYvIIZFgamKPBtkIlVsh6Wb
         3gb/AJoqsTkSjPQAXRlyG8UalITBB3Uoo+GpG7XH0+ezklmfA9GnxdqEQA5dVAQkZ7nz
         UL+WKBkyWzOlUzX3cGwwc4tvzizdQiaZTbloCm4D0k418XcwccL050QPDTnR2dgmkt3/
         GSUgTnFk5r/38o/JtLJPhjQc6RSVC5Gfh2wOYQdfCmQP9MbNjeToRNGABa7NC8im4wFU
         2kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769134258; x=1769739058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MWWNUHdoxkkBnQ9aWgKGZtECd2UHxVzPBy9BVberW4=;
        b=CzHjfCfh4PzCbWy17CyMBKxKt/+08UE00jc0GbjGrdPEAgz80MCTfUDpBOpFj6svSV
         8Hiy0hx3CC4YfvEe0rFKoivWYrkA/TFpxcjKBL4rnJtS+koEUou3mJmdo2+sqOI/96Kc
         YyFhqBvldzZhWDQhraPPK9FhD2KxVdq0E7DEfSLJ8V/sL1bdcBgL4Kh4t43U9JHk/XCw
         +XouuXB/tU5mvogT822In1LiM+ocCgyncoFXf6CzZwNpTasfl/Xw4jfF7+gLsdjVSyYQ
         Ftew26rKpzD9yDKzKS9DIyJpuFjeAvSRU8j/cuRbD5DkeJ5uwVIJU7J4oDqhH/A89ro/
         2pxg==
X-Gm-Message-State: AOJu0YwCSGgh3H8ij5cjR97BEntIEXP7frbDrkK7K8UKUCUn7w97JLQb
	aJSWVlKxzOglpsscZPXib8+RMCtQvkrB2qzTk1gE0vNSMs6IiBmX1r35pqGXF3e1
X-Gm-Gg: AZuq6aKtMpAm2rKE7xsDdKrkZbPNhImvnjWryQYLpngo0/gnyZxysetUoZe7TK+26Kc
	TDv2E+uRCd+EzLLLA7UFlNJxwieEGayE8ptzVBl6YFGSiG7VlYzAmFaYLK/k2GvG9m2Yex865ff
	d6Ms7deltRNqIamJJ8+TMS+KfF7qJDlr3nCZPYGo3yFMxLGP4j+uWWDRAqGKbKdRYF+V7Fqw7jB
	yE7SuvcSP/B9mHuPS/2nVQdPn4Cm4kjB6u/sCj1cPVxnQRYhE3POrAc6NPDl1cJ3cIhnqH7PwFO
	HjRd4efEcsOk1jftMKInuhrvebpm5k5y7J/FGY0i+ymscSgiaqqUPkvlWxNUb8zezPOHcArq2aB
	7zDgdmzmuabZ/TwPCQJMuKZcrHcot+hwKZvrk1865LkrL39AXk9PtkNGdw88W7HVHMwBneee0IL
	5FJbvfmRS/dN3gw7W4rGuRpKh/sw==
X-Received: by 2002:a17:90b:2701:b0:353:49f2:1e7c with SMTP id 98e67ed59e1d1-35369308d98mr1102690a91.30.1769134258095;
        Thu, 22 Jan 2026 18:10:58 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:a458:c153:e5c3:234f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3533521707asm3544251a91.8.2026.01.22.18.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 18:10:57 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 4/4] mm/damon: allow user to set min and max size of region
Date: Fri, 23 Jan 2026 11:10:14 +0900
Message-ID: <20260123021014.26915-5-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123021014.26915-1-akinobu.mita@gmail.com>
References: <20260123021014.26915-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the region size is limited to a page size or more,
but this patch makes it possible to set the upper and lower limits using
the following sysfs interfaces:

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/region_sz/min
Description: Writing a value to this file sets the minimum size of monitoring regions of
the DAMON target as the value.  Reading this file returns the value.

What: /sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/region_sz/max
Description: Writing a value to this file sets the maximum size of monitoring regions of
the DAMON target as the value.  Reading this file returns the value.

By setting the minimum and maximum sizes of regions to the same value,
the region size can be kept constant (no region merging or splitting).

This patch allows you to set the minimum and maximum size of a region,
so it may not be possible to simultaneously satisfy the existing minimum and
maximum settings for the number of damon regions (min_regions, max_regions).
---
 .../ABI/testing/sysfs-kernel-mm-damon         |   3 +
 include/linux/damon.h                         |   8 +-
 mm/damon/core.c                               | 150 +++++++++++++++---
 mm/damon/sysfs.c                              |  29 +++-
 mm/damon/tests/core-kunit.h                   |   2 +-
 mm/damon/tests/sysfs-kunit.h                  |   2 +
 mm/damon/tests/vaddr-kunit.h                  |   7 +-
 mm/damon/vaddr.c                              |  68 ++++----
 8 files changed, 211 insertions(+), 58 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 405a1a7f1eb6..5a49a65966b2 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -571,6 +571,9 @@ Description:	Reading this file returns the size of the memory in the region
 		that passed DAMON operations layer-handled filters of the
 		scheme in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/region_sz/min
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/region_sz/max
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/nr_perf_events
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/type
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/perf_events/<P>/config
diff --git a/include/linux/damon.h b/include/linux/damon.h
index c50c1beea5b2..00b4890a3ec2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -91,6 +91,8 @@ struct damon_region {
  * struct damon_target - Represents a monitoring target.
  * @pid:		The PID of the virtual address space to monitor.
  * @nr_regions:		Number of monitoring target regions of this target.
+ * @min_region_sz:	The minimum size of adaptive monitoring regions.
+ * @max_region_sz:	The maximum size of adaptive monitoring regions.
  * @regions_list:	Head of the monitoring target regions of this target.
  * @list:		List head for siblings.
  * @obsolete:		Whether the commit destination target is obsolete.
@@ -107,6 +109,8 @@ struct damon_region {
 struct damon_target {
 	struct pid *pid;
 	unsigned int nr_regions;
+	unsigned long min_region_sz;
+	unsigned long max_region_sz;
 	struct list_head regions_list;
 	struct list_head list;
 	bool obsolete;
@@ -944,7 +948,7 @@ static inline void damon_insert_region(struct damon_region *r,
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges, unsigned long min_sz_region);
+		unsigned int nr_ranges, unsigned long min_sz_region, bool split);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
@@ -1013,6 +1017,8 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
 				unsigned long min_sz_region);
+int damon_evenly_split_region(struct damon_target *t,
+			struct damon_region *r, unsigned int nr_pieces, unsigned long sz_piece);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 186c3bbf9534..2e5795632865 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -178,9 +178,10 @@ static bool damon_intersect(struct damon_region *r,
  * Fill holes in regions with new regions.
  */
 static int damon_fill_regions_holes(struct damon_region *first,
-		struct damon_region *last, struct damon_target *t)
+		struct damon_region *last, struct damon_target *t, bool split)
 {
 	struct damon_region *r = first;
+	unsigned long max_region_sz = split ? t->max_region_sz : 0;
 
 	damon_for_each_region_from(r, t) {
 		struct damon_region *next, *newr;
@@ -193,6 +194,8 @@ static int damon_fill_regions_holes(struct damon_region *first,
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, r, next, t);
+			if (max_region_sz)
+				damon_evenly_split_region(t, newr, -1, max_region_sz);
 		}
 	}
 	return 0;
@@ -204,6 +207,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * @ranges:	array of new monitoring target ranges.
  * @nr_ranges:	length of @ranges.
  * @min_sz_region:	minimum region size.
+ * @split:	split a new region into small regions
  *
  * This function adds new regions to, or modify existing regions of a
  * monitoring target to fit in specific ranges.
@@ -211,9 +215,12 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * Return: 0 if success, or negative error code otherwise.
  */
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges, unsigned long min_sz_region)
+		unsigned int nr_ranges, unsigned long min_sz_region, bool split)
 {
 	struct damon_region *r, *next;
+	unsigned long min_region_sz = max(min_sz_region, t->min_region_sz);
+	unsigned long max_region_sz = split ? t->max_region_sz : 0;
+	unsigned long orig_start, orig_end;
 	unsigned int i;
 	int err;
 
@@ -248,19 +255,34 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			/* no region intersects with this range */
 			newr = damon_new_region(
 					ALIGN_DOWN(range->start,
-						min_sz_region),
-					ALIGN(range->end, min_sz_region));
+						min_region_sz),
+					ALIGN(range->end, min_region_sz));
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
+			if (max_region_sz)
+				damon_evenly_split_region(t, newr, -1, max_region_sz);
 		} else {
 			/* resize intersecting regions to fit in this range */
+			orig_start = first->ar.start;
 			first->ar.start = ALIGN_DOWN(range->start,
-					min_sz_region);
-			last->ar.end = ALIGN(range->end, min_sz_region);
+					min_region_sz);
+			orig_end = last->ar.end;
+			last->ar.end = ALIGN(range->end, min_region_sz);
+			if (first->ar.start < orig_start) {
+				if (max_region_sz)
+					damon_evenly_split_region(t, first, -1, max_region_sz);
+				if (first == last)
+					continue;
+			}
+
+			if (orig_end < last->ar.end) {
+				if (max_region_sz)
+					damon_evenly_split_region(t, last, -1, max_region_sz);
+			}
 
 			/* fill possible holes in the range */
-			err = damon_fill_regions_holes(first, last, t);
+			err = damon_fill_regions_holes(first, last, t, split);
 			if (err)
 				return err;
 		}
@@ -479,6 +501,8 @@ struct damon_target *damon_new_target(void)
 
 	t->pid = NULL;
 	t->nr_regions = 0;
+	t->min_region_sz = 0;
+	t->max_region_sz = 0;
 	INIT_LIST_HEAD(&t->regions_list);
 	INIT_LIST_HEAD(&t->list);
 	t->obsolete = false;
@@ -1172,7 +1196,7 @@ static int damon_commit_target_regions(struct damon_target *dst,
 	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
-	err = damon_set_regions(dst, ranges, i, src_min_sz_region);
+	err = damon_set_regions(dst, ranges, i, src_min_sz_region, true);
 	kfree(ranges);
 	return err;
 }
@@ -1192,6 +1216,25 @@ static int damon_commit_target(
 	if (src_has_pid)
 		get_pid(src->pid);
 	dst->pid = src->pid;
+	dst->min_region_sz = src->min_region_sz;
+	dst->max_region_sz = src->max_region_sz;
+	if (dst->min_region_sz > dst->max_region_sz) {
+		pr_debug("invalid min_region_sz=%lu and max_region_sz=%lu\n",
+				dst->min_region_sz, dst->max_region_sz);
+		dst->min_region_sz = dst->max_region_sz = 0;
+	}
+	if (dst->min_region_sz) {
+		if (dst->min_region_sz < DAMON_MIN_REGION || !is_power_of_2(dst->min_region_sz)) {
+			pr_debug("invalid min_region_sz=%lu\n", dst->min_region_sz);
+			dst->min_region_sz = dst->max_region_sz = 0;
+		}
+	}
+	if (dst->max_region_sz) {
+		if (dst->max_region_sz < DAMON_MIN_REGION || !is_power_of_2(dst->max_region_sz)) {
+			pr_debug("invalid max_region_sz=%lu\n", dst->max_region_sz);
+			dst->min_region_sz = dst->max_region_sz = 0;
+		}
+	}
 	return 0;
 }
 
@@ -1770,6 +1813,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
 	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
+	unsigned long min_region_sz = max(min_sz_region, t->min_region_sz);
 	unsigned long sz_to_skip;
 
 	/* Skip previously charged regions */
@@ -1788,11 +1832,11 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, min_sz_region);
+					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_sz_region)
+				if (damon_sz_region(r) <= min_region_sz)
 					return true;
-				sz_to_skip = min_sz_region;
+				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			r = damon_next_region(r);
@@ -1823,6 +1867,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
+	unsigned long min_region_sz = max(min_sz_region, t->min_region_sz);
 	unsigned long start, end;
 
 	switch (filter->type) {
@@ -1835,8 +1880,8 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = target_idx == filter->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, min_sz_region);
-		end = ALIGN_DOWN(filter->addr_range.end, min_sz_region);
+		start = ALIGN_DOWN(filter->addr_range.start, min_region_sz);
+		end = ALIGN_DOWN(filter->addr_range.end, min_region_sz);
 
 		/* inside the range */
 		if (start <= r->ar.start && r->ar.end <= end) {
@@ -1974,6 +2019,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
+	unsigned long min_region_sz = max(c->min_sz_region, t->min_region_sz);
 	unsigned long sz_applied = 0;
 	unsigned long sz_ops_filter_passed = 0;
 	/*
@@ -2007,7 +2053,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					c->min_sz_region);
+					min_region_sz);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -2484,6 +2530,14 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	}
 }
 
+static bool damon_adaptive_region_adjustment_is_enabled(struct damon_target *t)
+{
+	if (!t->min_region_sz || !t->max_region_sz)
+		return true;
+
+	return t->min_region_sz != t->max_region_sz;
+}
+
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -2507,17 +2561,28 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	struct damon_target *t;
 	unsigned int nr_regions;
 	unsigned int max_thres;
+	bool might_merge = false;
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit);
+			unsigned long target_sz_limit = max(sz_limit, t->min_region_sz);
+
+			if (t->max_region_sz)
+				target_sz_limit = min(sz_limit, t->max_region_sz);
+			if (damon_adaptive_region_adjustment_is_enabled(t))
+				might_merge = true;
+			else
+				target_sz_limit = 0;
+
+			damon_merge_regions_of(t, threshold, target_sz_limit);
 			nr_regions += damon_nr_regions(t);
 		}
 		threshold = max(1, threshold * 2);
 	} while (nr_regions > c->attrs.max_nr_regions &&
+			might_merge &&
 			threshold / 2 < max_thres);
 }
 
@@ -2551,6 +2616,7 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs,
 				  unsigned long min_sz_region)
 {
 	struct damon_region *r, *next;
+	unsigned long min_region_sz = max(min_sz_region, t->min_region_sz);
 	unsigned long sz_region, sz_sub = 0;
 	int i;
 
@@ -2558,17 +2624,20 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs,
 		sz_region = damon_sz_region(r);
 
 		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * min_sz_region; i++) {
+				sz_region > 2 * min_region_sz; i++) {
 			/*
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
 			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, min_sz_region);
+					sz_region / 10, min_region_sz);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
+			if (t->max_region_sz)
+				sz_sub = min(sz_sub, t->max_region_sz);
+
 			damon_split_region_at(t, r, sz_sub);
 			sz_region = sz_sub;
 		}
@@ -2603,8 +2672,11 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 			nr_regions < ctx->attrs.max_nr_regions / 3)
 		nr_subregions = 3;
 
-	damon_for_each_target(t, ctx)
+	damon_for_each_target(t, ctx) {
+		if (!damon_adaptive_region_adjustment_is_enabled(t))
+			continue;
 		damon_split_regions_of(t, nr_subregions, ctx->min_sz_region);
+	}
 
 	last_nr_regions = nr_regions;
 }
@@ -3005,7 +3077,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, min_sz_region);
+	return damon_set_regions(t, &addr_range, 1, min_sz_region, true);
 }
 
 /*
@@ -3078,6 +3150,46 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		r->nr_accesses++;
 }
 
+int damon_evenly_split_region(struct damon_target *t,
+		struct damon_region *r, unsigned int nr_pieces, unsigned long sz_piece)
+{
+	unsigned long sz_orig, orig_end;
+	struct damon_region *n = NULL, *next;
+	unsigned long start;
+	unsigned int i;
+
+	if (!r || !nr_pieces || !sz_piece)
+		return -EINVAL;
+
+	if (nr_pieces == 1)
+		return 0;
+
+	orig_end = r->ar.end;
+	sz_orig = damon_sz_region(r);
+
+	if (t->max_region_sz)
+		sz_piece = min(sz_piece, t->max_region_sz);
+
+	if (sz_orig <= sz_piece)
+		return 0;
+
+	r->ar.end = r->ar.start + sz_piece;
+	next = damon_next_region(r);
+	for (start = r->ar.end, i = 1; i < nr_pieces && start + sz_piece <= orig_end;
+			start += sz_piece, i++) {
+		n = damon_new_region(start, start + sz_piece);
+		if (!n)
+			return -ENOMEM;
+		damon_insert_region(n, r, next, t);
+		r = n;
+	}
+	/* complement last region for possible rounding error */
+	if (n)
+		n->ar.end = orig_end;
+
+	return 0;
+}
+
 /**
  * damon_initialized() - Return if DAMON is ready to be used.
  *
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1dc996f810bb..b48ffbcf8805 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -211,6 +211,7 @@ static const struct kobj_type damon_sysfs_regions_ktype = {
 struct damon_sysfs_target {
 	struct kobject kobj;
 	struct damon_sysfs_regions *regions;
+	struct damon_sysfs_ul_range *region_sz_range;
 	int pid;
 	bool obsolete;
 };
@@ -223,6 +224,7 @@ static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
 static int damon_sysfs_target_add_dirs(struct damon_sysfs_target *target)
 {
 	struct damon_sysfs_regions *regions = damon_sysfs_regions_alloc();
+	struct damon_sysfs_ul_range *region_sz_range;
 	int err;
 
 	if (!regions)
@@ -231,14 +233,35 @@ static int damon_sysfs_target_add_dirs(struct damon_sysfs_target *target)
 	err = kobject_init_and_add(&regions->kobj, &damon_sysfs_regions_ktype,
 			&target->kobj, "regions");
 	if (err)
-		kobject_put(&regions->kobj);
+		goto put_regions_out;
 	else
 		target->regions = regions;
+
+	region_sz_range = damon_sysfs_ul_range_alloc(0, 0);
+	if (!region_sz_range) {
+		err = -ENOMEM;
+		goto put_regions_out;
+	}
+
+	err = kobject_init_and_add(&region_sz_range->kobj,
+			&damon_sysfs_ul_range_ktype, &target->kobj, "region_sz");
+	if (err)
+		goto put_region_sz_out;
+	target->region_sz_range = region_sz_range;
+	return 0;
+
+put_region_sz_out:
+	kobject_put(&region_sz_range->kobj);
+	target->region_sz_range = NULL;
+put_regions_out:
+	kobject_put(&regions->kobj);
+	target->regions = NULL;
 	return err;
 }
 
 static void damon_sysfs_target_rm_dirs(struct damon_sysfs_target *target)
 {
+	kobject_put(&target->region_sz_range->kobj);
 	damon_sysfs_regions_rm_dirs(target->regions);
 	kobject_put(&target->regions->kobj);
 }
@@ -1717,7 +1740,7 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 		if (ranges[i - 1].end > ranges[i].start)
 			goto out;
 	}
-	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_sz_region);
+	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_sz_region, true);
 out:
 	kfree(ranges);
 	return err;
@@ -1739,6 +1762,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			return -EINVAL;
 	}
 	t->obsolete = sys_target->obsolete;
+	t->min_region_sz = sys_target->region_sz_range->min;
+	t->max_region_sz = sys_target->region_sz_range->max;
 	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
 }
 
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 92ea25e2dc9e..d873582b729c 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -399,7 +399,7 @@ static void damon_test_set_regions(struct kunit *test)
 
 	damon_add_region(r1, t);
 	damon_add_region(r2, t);
-	damon_set_regions(t, &range, 1, 1);
+	damon_set_regions(t, &range, 1, 1, false);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
 	damon_for_each_region(r, t) {
diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 0c665ed255a3..2298bd63de5e 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -70,6 +70,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 		kunit_skip(test, "sysfs_regions alloc fail");
 	}
 
+	sysfs_target->region_sz_range = damon_sysfs_ul_range_alloc(0, 0);
 	sysfs_targets->targets_arr[0] = sysfs_target;
 
 	ctx = damon_new_ctx();
@@ -93,6 +94,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 	kfree(sysfs_targets->targets_arr);
 	kfree(sysfs_targets);
 	kfree(sysfs_target->regions);
+	kfree(sysfs_target->region_sz_range);
 	kfree(sysfs_target);
 }
 
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 30dc5459f1d2..a898403cf879 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -65,6 +65,7 @@ static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	struct damon_target *t = damon_new_target();
 	static struct mm_struct mm;
 	struct damon_addr_range regions[3] = {0};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
@@ -81,7 +82,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
 		kunit_skip(test, "Failed to create VMA tree");
 
-	__damon_va_three_regions(&mm, regions);
+	__damon_va_three_regions(t, &mm, regions);
 
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
@@ -89,6 +90,8 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
 	KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
 	KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
+
+	damon_free_target(t);
 }
 
 static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
@@ -147,7 +150,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION, false);
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 68f2bb844d06..c4dbc50c7baa 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -69,10 +69,8 @@ static struct mm_struct *damon_get_mm(struct damon_target *t)
 static int damon_va_evenly_split_region(struct damon_target *t,
 		struct damon_region *r, unsigned int nr_pieces)
 {
-	unsigned long sz_orig, sz_piece, orig_end;
-	struct damon_region *n = NULL, *next;
-	unsigned long start;
-	unsigned int i;
+	unsigned long sz_piece;
+	unsigned long min_region_sz = max(DAMON_MIN_REGION, t->min_region_sz);
 
 	if (!r || !nr_pieces)
 		return -EINVAL;
@@ -80,27 +78,12 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	if (nr_pieces == 1)
 		return 0;
 
-	orig_end = r->ar.end;
-	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+	sz_piece = ALIGN_DOWN(damon_sz_region(r) / nr_pieces, min_region_sz);
 
 	if (!sz_piece)
 		return -EINVAL;
 
-	r->ar.end = r->ar.start + sz_piece;
-	next = damon_next_region(r);
-	for (start = r->ar.end, i = 1; i < nr_pieces; start += sz_piece, i++) {
-		n = damon_new_region(start, start + sz_piece);
-		if (!n)
-			return -ENOMEM;
-		damon_insert_region(n, r, next, t);
-		r = n;
-	}
-	/* complement last region for possible rounding error */
-	if (n)
-		n->ar.end = orig_end;
-
-	return 0;
+	return damon_evenly_split_region(t, r, -1, sz_piece);
 }
 
 static unsigned long sz_range(struct damon_addr_range *r)
@@ -121,12 +104,13 @@ static unsigned long sz_range(struct damon_addr_range *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct mm_struct *mm,
+static int __damon_va_three_regions(struct damon_target *t, struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
 	struct damon_addr_range first_gap = {0}, second_gap = {0};
 	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma, *prev = NULL;
+	unsigned long min_region_sz = max(DAMON_MIN_REGION, t->min_region_sz);
 	unsigned long start;
 
 	/*
@@ -157,20 +141,35 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	}
 	rcu_read_unlock();
 
-	if (!sz_range(&second_gap) || !sz_range(&first_gap))
+	if (!sz_range(&second_gap) || !sz_range(&first_gap)) {
+		pr_warn_once("The size of the first and second gaps are %lu and %lu\n",
+				sz_range(&first_gap), sz_range(&second_gap));
 		return -EINVAL;
+	}
 
 	/* Sort the two biggest gaps by address */
 	if (first_gap.start > second_gap.start)
 		swap(first_gap, second_gap);
 
 	/* Store the result */
-	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION);
-	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION);
-	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION);
-	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION);
+	regions[0].start = ALIGN_DOWN(start, min_region_sz);
+	regions[0].end = ALIGN(first_gap.start, min_region_sz);
+	regions[1].start = ALIGN_DOWN(first_gap.end, min_region_sz);
+	regions[1].end = ALIGN(second_gap.start, min_region_sz);
+	regions[2].start = ALIGN_DOWN(second_gap.end, min_region_sz);
+	regions[2].end = ALIGN(prev->vm_end, min_region_sz);
+
+	for (int i = 0; i < 3; i++) {
+		if (!sz_range(&regions[i])) {
+			pr_warn_once("The size of the %dth range is %lu\n",
+					i, sz_range(&regions[i]));
+			return -EINVAL;
+		}
+		if (i > 0 && regions[i - 1].end >= regions[i].start) {
+			pr_warn_once("%dth and %dth regions overlap\n", i - 1, i);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -191,7 +190,7 @@ static int damon_va_three_regions(struct damon_target *t,
 		return -EINVAL;
 
 	mmap_read_lock(mm);
-	rc = __damon_va_three_regions(mm, regions);
+	rc = __damon_va_three_regions(t, mm, regions);
 	mmap_read_unlock(mm);
 
 	mmput(mm);
@@ -246,6 +245,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 	struct damon_target *ti;
 	struct damon_region *r;
 	struct damon_addr_range regions[3];
+	unsigned long min_region_sz = max(DAMON_MIN_REGION, t->min_region_sz);
 	unsigned long sz = 0, nr_pieces;
 	int i, tidx = 0;
 
@@ -263,8 +263,10 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (t->max_region_sz)
+		sz = clamp(sz, min_region_sz, t->max_region_sz);
+	else
+		sz = max(sz, min_region_sz);
 
 	/* Set the initial three regions of the target */
 	for (i = 0; i < 3; i++) {
@@ -303,7 +305,7 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
-		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION, true);
 	}
 }
 
-- 
2.43.0

