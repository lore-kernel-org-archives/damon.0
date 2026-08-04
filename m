Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E546AF00
	for <damon@lists.linux.dev>; Tue,  4 Aug 2026 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838035; cv=none; b=kN3PJXD2APIvQq7zK9vF9YrB0mSEN+yrHshgAN2GkkX69kOcp4oV1UEEX/y0TMGXzah+qWL1j0IhbwF0nHu/tnNgJP0YE0AbPixgObJswaqzlDqcVXRgeOWlQeRf1G4KsyHr7pN6dX8Q/liJU2fH4uJ609CMbyFsJ62oAnojXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838035; c=relaxed/simple;
	bh=lw7792hVIVV1hxAlcIrYHTSifdDtcusGkElxgR5cZcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE64vjxl/sfMHXdPgYxmCbwZW8cBxic1puaRKQoJXdyF4IGigvBda4zyQhOpieYhgasKYTcAzhGPMzb3/DjShy5lCxlKYsR/3qjURLvty6LpJj2eEwK/mmkNQkhQuxq7a0nKj9U3sagFaxO7zxgdZyOkEJsDpacVhvintkP6I3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2LFWs+X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2LFWs+X"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso33938965ad.3
        for <damon@lists.linux.dev>; Tue, 04 Aug 2026 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785838032; x=1786442832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2t9K3rCy8mMBuyLN8Fc4dcYNWuaEGqN0qq6fEe+cxoo=;
        b=d2LFWs+XAnbFAekY3RnWTslEbHt0Rmeon9+UCBQubKjhJV+C5D/MaF4FetgTHZBCxr
         iQOo+YvPEpq4fQqnnLXsRkKc6TFofmROO+sQCxpB7pJhcBZnmvXNuVIqKgScsS88Ckk4
         PoJoTwoUiCyaF80/kCtuD5OKUkWrwefuBrgATBhXobgyf3dp8b1b5QFpOSz5mrlzBRo1
         h8djptdmNunXGE64wFL0FgxeWGbwNAdBqVwaNKTOC2OAcXz8nNMru3Kdb0NadOmnZEr6
         H+Z5KS4USIBT4qXqHlIggpXl+vE1ZtAcRowm5Mhkha3S1mKuplR5ZM8VUxdfbSrXnRr2
         6L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838032; x=1786442832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2t9K3rCy8mMBuyLN8Fc4dcYNWuaEGqN0qq6fEe+cxoo=;
        b=kdXSjjhs3X0D02EZ4Ql4n/NRucJHD43K9JAOB2ZHIDnkDI2zFwR53moyBBT4iKn3QU
         Q+OpWtcCgmEP0m3d8xYNnXYYBwRZ/5wj0j3qdPM9uHv1ck+f/xKV4VovPrmmezZZIU8j
         +3ccTG4nIcjDvZOpZTaoW1JGhnQ22KL4+JsTTlsbcuK54WbQuHjfnGmC7KDRjhtglRQ8
         JaVDk7ktTcvIdU+DLEUz428i2GvJmPJLSTmqwJmskPor97upI0UhmDP3utvXyCJpRLpU
         g54NujD/lGi/OidLnttr9S7U80FBk5SCkfd3lmnHmeIjhLlltJz4thYo3ED+sdz+F4TB
         EiEw==
X-Gm-Message-State: AOJu0Yz11gAr8osoWinsPZmK4/xWO06tYrBvKb5pbeLNbFKTT/mZ5mZv
	f2PLEuS7KN8IossPcg2zMA1kzO2gDz2nZHS/Vx7kDo1iibZQdbm8trOUNfW8Vg==
X-Gm-Gg: AR+sD11ru+uNoVatxVYuxQL7r4r+uGWNGwxjs2GX4tchU0ElHiedKgnlJHZRswwtNTH
	VGpQYm/Ow0yP9cHJKYgRKY99yoXRosh51oqCn+57PkMkL63xf4GBOzJeUJZGmSkpZfwkAF2w+FL
	BwDVo3mZWUDTwbDrrEMvl5ZwtUdiveOvacPULdk7aKRfV+a+hBcCAPPrIVKTF1ZGKaxdK9jvHZy
	0P6CVBQarv8pmsdWQum+qwFZoGcN5Ou3p5wOedGEerDalL+KT5kNhL8uVPjjpQQUWlL51SyNhot
	QXTuddwT+QoouKHtNALj3CjYwTtHTFwieByRAvsxMr9xVz4olNszGTttR7HV91o6sg/uHI2hECF
	KlcBTZY2LTcJX+A9wuUv5n4xLl5226arDuH5AhmFDS0Fkfw/XdzTCHatXbqEgbd49wBOUczmZfI
	vIOvE4jXFxCSrmpjqfKn/zacItqHUWgq8JNaRw9jh9OI7J8YMczv9Vqy7z7B6oNYOvKVauKM7Y3
	Rub
X-Received: by 2002:a17:902:ef4d:b0:2cf:ca89:499d with SMTP id d9443c01a7336-2d052188ccdmr135810865ad.7.1785838032295;
        Tue, 04 Aug 2026 03:07:12 -0700 (PDT)
Received: from celestia ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4bda53sm3891205ad.63.2026.08.04.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:07:11 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH] mm/damon: introduce damos_sort_type for re-ordering regions list
Date: Tue,  4 Aug 2026 18:07:19 +0800
Message-ID: <20260804100719.116538-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======

A DAMOS scheme filters its target regions using an access pattern, which
is constructed with the size, the access frequency (nr_accesses), and
the age of the regions. The age here means how long the current access
pattern of a region has been maintained.

For the pageout action, the age.min of the access pattern effectively
acts as the minimum amount of time that the target regions must have been
unused.

The definition of cold memory highly depends on the devices and
workloads, and thus setting a proper default age.min (e.g., min_age of
DAMON_RECLAIM) is both important and nearly impossible to make suitable
for all devices and workloads.

Solution
========

Add a per-scheme sysfs attribute, schemes/<N>/sort_type, whose default
value is 'none'. A scheme can set it to 'score_desc', which makes the
scheme to collect the target regions and apply its action in descending
order of the regions' scores, as calculated by the ops.get_scheme_score()
callback, during the application. For a pageout scheme, the callback
returns the coldness score of each region.

Instead of modifying the region list, DAMON copies the target valid
regions into a temporary array, sorts the array in descending order of
the regions' scores, and applies the action in the sorted order.

With this, the scheme gives absolute priority to the highest-scored
region. For example, a pageout scheme with 'score_desc' reclaims the
coldest region of the target first. Users can thus keep the age.min
relatively small and let the score ordering do the precise
prioritization.

Note that regions are applied in the score order, not the address order.
Therefore, the address-based quota charge resume mechanism is not
available for such schemes. Instead, the quota is spent on the
highest-scored regions of each charge window. Applying an action
resets the age of the applied regions (except for 'stat' action), so
those regions are naturally excluded from the next window if the scheme
has a non-zero age.min. Also, when a region is split for the quota, the
age of the split-out part is preserved, and thus the highest-scored
region is continuously applied until it is fully reclaimed, even when it
is larger than the remaining quota of a single window.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
I am currently running the corresponding benchmarks to ensure that this
does not introduce too much performance overhead, at least not on my
device.

The purpose of sending this patch is to make sure this is a right
direction.

About my device/VM
==================

CPU: AMD Ryzen 5 5600H (12 Cores)
RAM: 8GiB in VM (4GiB + 4GiB ZRAM)

I currently foresee two potential issues with thiss patch, though I
have not obtained the test results yet, so these are just guesses.

1. Excessive memory allocations and deallocations 

    The default aggr_interval is 100ms. Executing at least one
    allocation and deallocation every 100ms is very likely to cause
    unnecessary performance overhead.

    I think this issue could be resolved by having the scheme maintain
    its own buffer.

2. Performance overhead of re-ordering

    Although on my device the number of regions is not very large, and
    DAMON's default limit of 1,000 regions also helps avoid performance
    overhead, I suspect that large servers might not stick to just 1,000
    regions.

    A solution I can think of is using a Top K Min Heap, though that
    might significantly increase code complexity and reduce readability.

As a reminder, these are just my __guesses__ and do not necessarily
reflect what will happen in practice. I will send another email after
completing the benchmarks and micro-performance testing.

 include/linux/damon.h    |   6 ++
 mm/damon/core.c          | 125 ++++++++++++++++++++++++++++++++++++++-
 mm/damon/sysfs-schemes.c |  57 ++++++++++++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..88a3f9f4a4ca 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -140,6 +140,11 @@ enum damos_action {
 	NR_DAMOS_ACTIONS,
 };
 
+enum damos_sort_type {
+	DAMOS_SORT_NONE,
+	DAMOS_SORT_SCORE_DESC,
+};
+
 /**
  * enum damos_quota_goal_metric - Represents the metric to be used as the goal
  *
@@ -565,6 +570,7 @@ struct damos {
 	};
 	struct damos_stat stat;
 	unsigned long max_nr_snapshots;
+	enum damos_sort_type sort_type;
 /* private: internal use only */
 	/*
 	 * number of sample intervals that should be passed before applying
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..b0c52c9eabe8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_choices.h>
+#include <linux/sort.h>
 
 /* for damon_get_folio() used by node eligible memory metrics */
 #include "ops-common.h"
@@ -705,6 +706,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
 	scheme->max_nr_snapshots = 0;
+	scheme->sort_type = DAMOS_SORT_NONE;
 	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
@@ -1465,6 +1467,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	dst->max_nr_snapshots = src->max_nr_snapshots;
+	dst->sort_type = src->sort_type;
 	return 0;
 }
 
@@ -2627,7 +2630,12 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		damos_charge_quota(quota, sz, sz_applied);
-		if (damos_quota_is_full(quota, c->min_region_sz)) {
+		/*
+		 * Since it can no longer be guaranteed that the re-ordered
+		 * Region List is sorted by address. So, no record.
+		 */
+		if (s->sort_type == DAMOS_SORT_NONE &&
+			damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end;
 		}
@@ -2648,6 +2656,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 
+		if (s->sort_type != DAMOS_SORT_NONE)
+			continue;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
@@ -2673,6 +2684,107 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	}
 }
 
+struct damos_sort_priv {
+	struct damon_ctx *c;
+	struct damos *s;
+};
+
+static int damos_sort_score_desc_cmp(const void *a, const void *b,
+		const void *priv)
+{
+	struct damon_region *ra = *(struct damon_region **)a;
+	struct damon_region *rb = *(struct damon_region **)b;
+	const struct damos_sort_priv *p = priv;
+	int score_a = p->c->ops.get_scheme_score(p->c, ra, p->s);
+	int score_b = p->c->ops.get_scheme_score(p->c, rb, p->s);
+
+	return cmp_int(score_b, score_a);
+}
+
+static void damos_apply_sorted_scheme(struct damon_ctx *c,
+		struct damon_target *t, struct damos *s)
+{
+	struct damon_region **arr;
+	struct damon_region *r;
+	struct damos_quota *quota = &s->quota;
+	struct damos_sort_priv priv = { .c = c, .s = s };
+	unsigned long nr = 0, i = 0;
+
+	if (!c->ops.get_scheme_score)
+		return;
+	/* Avoid unnecessary kvmalloc_array() */
+	if (damos_quota_is_full(quota, c->min_region_sz))
+		return;
+
+	damon_for_each_region(r, t) {
+		if (__damos_valid_target(r, s, c))
+			nr++;
+	}
+	if (nr == 0)
+		return;
+	if (nr == 1)
+		goto single_valid_region;
+
+	arr = kvmalloc_array(nr, sizeof(*arr), GFP_KERNEL);
+
+	if (!arr)
+		return;
+
+	damon_for_each_region(r, t) {
+		if (__damos_valid_target(r, s, c))
+			arr[i++] = r;
+	}
+
+	sort_r_nonatomic(arr, nr, sizeof(*arr), damos_sort_score_desc_cmp, NULL, &priv);
+
+	for (i = 0; i < nr; i++) {
+		r = arr[i];
+
+		/* Check the quota */
+		if (damos_quota_is_full(quota, c->min_region_sz))
+			break;
+
+		if (s->max_nr_snapshots &&
+				s->max_nr_snapshots <= s->stat.nr_snapshots)
+			continue;
+
+		if (damos_valid_target(c, r, s)) {
+			damos_apply_scheme(c, t, r, s);
+		} else {
+			/*
+			 * There is no need to continue because the score is
+			 * already lower than quota.min_score.
+			 */
+			break;
+		}
+
+		if (i == nr - 1)
+			s->stat.nr_snapshots++;
+	}
+
+	kvfree(arr);
+	return;
+
+single_valid_region:
+	damon_for_each_region(r, t) {
+		if (__damos_valid_target(r, s, c))
+			break;
+	}
+
+	/* Check the quota */
+	if (damos_quota_is_full(quota, c->min_region_sz))
+		return;
+
+	if (s->max_nr_snapshots &&
+			s->max_nr_snapshots <= s->stat.nr_snapshots)
+		return;
+
+	if (damos_valid_target(c, r, s))
+		damos_apply_scheme(c, t, r, s);
+
+	s->stat.nr_snapshots++;
+}
+
 /*
  * damos_apply_target() - Apply DAMOS schemes to a given target.
  * @c:			monitoring context to apply its DAMOS schemes to..
@@ -2695,6 +2807,17 @@ static void damos_apply_target(struct damon_ctx *c, struct damon_target *t,
 		unsigned long max_region_sz)
 {
 	struct damon_region *r;
+	struct damos *s;
+
+	damon_for_each_scheme(s, c) {
+		if (s->sort_type == DAMOS_SORT_NONE)
+			continue;
+		if (!s->wmarks.activated)
+			continue;
+		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
+			continue;
+		damos_apply_sorted_scheme(c, t, s);
+	}
 
 	damon_for_each_region(r, t) {
 		struct damon_region *prev_r;
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 32f495a96b17..1fcbc39b5cd6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2261,6 +2261,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_scheme_regions *tried_regions;
 	int target_nid;
 	struct damos_sysfs_dests *dests;
+	enum damos_sort_type sort_type;
 };
 
 struct damos_sysfs_action_name {
@@ -2315,6 +2316,20 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 	},
 };
 
+static struct damos_sysfs_sort_type_name {
+	enum damos_sort_type sort_type;
+	char *name;
+} damos_sysfs_sort_type_names[] = {
+	{
+		.sort_type = DAMOS_SORT_NONE,
+		.name = "none",
+	},
+	{
+		.sort_type = DAMOS_SORT_SCORE_DESC,
+		.name = "score_desc",
+	},
+};
+
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 		enum damos_action action, unsigned long apply_interval_us)
 {
@@ -2326,6 +2341,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
 	scheme->target_nid = NUMA_NO_NODE;
+	scheme->sort_type = DAMOS_SORT_NONE;
 	return scheme;
 }
 
@@ -2645,6 +2661,42 @@ static ssize_t target_nid_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t sort_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_sort_type_names); i++) {
+		struct damos_sysfs_sort_type_name *type_name;
+
+		type_name = &damos_sysfs_sort_type_names[i];
+		if (type_name->sort_type == scheme->sort_type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t sort_type_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_sort_type_names); i++) {
+		struct damos_sysfs_sort_type_name *type_name;
+
+		type_name = &damos_sysfs_sort_type_names[i];
+		if (sysfs_streq(buf, type_name->name)) {
+			scheme->sort_type = type_name->sort_type;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -2659,10 +2711,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
 		__ATTR_RW_MODE(target_nid, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_sort_type_attr =
+		__ATTR_RW_MODE(sort_type, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
 	&damon_sysfs_scheme_target_nid_attr.attr,
+	&damon_sysfs_scheme_sort_type_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -3038,6 +3094,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		return NULL;
 	}
 	scheme->max_nr_snapshots = sysfs_scheme->stats->max_nr_snapshots;
+	scheme->sort_type = sysfs_scheme->sort_type;
 	return scheme;
 }
 
-- 
2.55.0

