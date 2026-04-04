Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF42236F7
	for <damon@lists.linux.dev>; Sat,  4 Apr 2026 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265749; cv=none; b=SDpnGZ7jzHL4nJQ8ZLeasP4J98zXbP1YG4hK0PolD2vpodm7wUeWvJVZiIO6MU3AXIXXFTbDgyRSMcpifb3Qj4VIUJSDz7GDBiFynhwvelCsy1qwHK26K1A1iC/MUAgoYoBFkrkNGB6baz60Ro0Z0xKdYdfD1bvkCEhQe96fDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265749; c=relaxed/simple;
	bh=W0XAT43KSS5zGtBZZIIxzXQgZvaC49gsBS6FFqGPCo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDsG/Q5q7PenVjYHjz1YWia7lFglV3wbWO63sG2KIhwcZGXJhhQlKjbnvqrOUIqbcYhP4hF65mJr03PFLOqhZxH0ZCeYneqoJwmpwXNExG8jW1zjPeb6W7tq0xp2aDZ49gebABnRUYfWqDsuhum+1pFdE8nu9kElSo5YkKA+EYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUkfssyf; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUkfssyf"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-4042fe53946so943049fac.3
        for <damon@lists.linux.dev>; Fri, 03 Apr 2026 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775265747; x=1775870547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQnrzxZZC9imzBgdexmxyRP9cTwF/HChSkxF/hZUuZQ=;
        b=rUkfssyfOr5P9qOXhJDVVcBdcugU5dnVvW3hdqBGfDD8ORvttvtyqS8mS4d9/flYgx
         IhjnBgX9afu6kBlYyO23XSNcBRVS0YhsouJE3RhljCWi/rnucQyz66lqJ1IXf87iJXbV
         WC8kFa1+AkClyl+INih+DzH62GDIWMrPNMVRTR0McG00q+81lZ2fFyviLnm6MBf+53jk
         ijQyFpyqzPrAxWc799JH/K+Jnio1Vd/ii48NGiwFyKjC7KEBiMwSWTrGHiJT1rnIIWCv
         lBFkwQbNoAwymfgl+Dr7jQ7olytyQZjqBJjIEIYJH9cd4JjFEn+TGEm4Mv23VK8SDQq0
         /0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775265747; x=1775870547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQnrzxZZC9imzBgdexmxyRP9cTwF/HChSkxF/hZUuZQ=;
        b=BrPENbqFEUobABz4KbDbcQS72P3oMYrdL6TpUMdaFxTop4Yxpea9RJG/+SUtH4TBxP
         ZUS+OzwGpB3wfQMoiHs7GmTojRuAH8s3Bt3mLoS1u7mRJc3hIeKy8WsjYYPQwDuxWgEE
         HsGEvC3diasDBeRoFi0tDNV5qOm05X5rkRan6jUB2JxbJadv25HbY3LgdH8CftR6u6PG
         oFG4Z530aFQdEy7jxz/h5BOyS3tc1gAtbnb7LHGLq0e6dswHa8zyxohXRXyue3aX7x1t
         hN0J2SpABsAOnoOOfPc+fT6C0nGoT+KiqmS/eRXFId7MXKPj1wqMZBnxG7Jq1cyx4XEJ
         R5aw==
X-Forwarded-Encrypted: i=1; AJvYcCWE18K0NObV4c/Lr2A/QE/WQmkhv0lBCFgYCm8R45r6bzWfINgEytdIPQnieLmZKB6uk8U+gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzNfIzvp4AeYJKxo1AAa8Q/6jvPIO5NQOpmN6zF2pwRZ4tSGlk
	AjNGC/deU6Bl91mHzyY6n5/+db9dtLTenXTuvRb2fU5K++gYrDr4y28=
X-Gm-Gg: ATEYQzyg4nHFiRiZMNjfoZrErceVnks9GPiXY+FsQMijZ6biIwOWKtZZUgAEPGNP7oR
	T0JLriBpc8+kPcuTKeLt15VMDq6YABso8z3a14UNxu131J0MMol0ugkoViQqYm+GUgx3pPM87+L
	PokNG8E7avrn/2VNPNP/gp8xm0jZFw3g3r7bumm2loW5jyCjQ0z2PbSj1DSz8sDVHAJPmv+51yx
	0zCv6lJUzIIkz6gtIkAT7rWqgCn1SXXCqN+aXpGixZ+oxZH4ksMdUnab+eXbxS0NvUB1TdoYey/
	GcFCbCEPcCektkEJjJajGcVM/ndZ/PTJqaW2hTKgo876w0gpt770xBD1mKOggnJ7bwQCi/BK++6
	yCtwFN920tSXzou3pV5h/P2p7eUWaqqO8FLwXVX+i4WFa6gUJVKbXH1fuNn1ZpSKJENfeTmaweL
	C5K6gjQe13xHTFqjYJeBK/vw==
X-Received: by 2002:a05:6870:70a8:b0:41c:20cd:c0b5 with SMTP id 586e51a60fabf-4230fbe8016mr2558822fac.6.1775265747042;
        Fri, 03 Apr 2026 18:22:27 -0700 (PDT)
Received: from localhost ([108.147.99.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4230fb42ec7sm3290263fac.0.2026.04.03.18.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 18:22:26 -0700 (PDT)
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
	kernel test robot <lkp@intel.com>
Subject: [PATCH v5 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Fri,  3 Apr 2026 18:22:15 -0700
Message-ID: <20260404012215.1539-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404012215.1539-1-ravis.opensrc@gmail.com>
References: <20260404012215.1539-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new quota goal metrics for memory tiering that track scheme-eligible
memory distribution across NUMA nodes:

- DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP: ratio of eligible memory on a node
- DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP: ratio of ineligible memory on a
  node

These complementary metrics enable push-pull migration schemes that
maintain a target memory distribution across different NUMA nodes
representing different memory tiers, based on access patterns defined
by each scheme.

The metrics iterate scheme-eligible regions and use damon_get_folio()
to determine NUMA node placement of each folio, calculating the ratio
of eligible memory on the specified node versus total eligible memory.

The implementation is guarded by CONFIG_DAMON_PADDR since damon_get_folio()
is only available when physical address space monitoring is enabled.

Suggested-by: SeongJae Park <sj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603251034.978zcsQ2-lkp@intel.com/
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h    |   6 ++
 mm/damon/core.c          | 186 ++++++++++++++++++++++++++++++++++++---
 mm/damon/sysfs-schemes.c |  12 +++
 3 files changed, 190 insertions(+), 14 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c15a7d2a05c6..98dbf6911dad 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -193,6 +193,10 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
  * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to total LRU memory ratio.
  * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to total LRU memory ratio.
+ * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:	Scheme-eligible memory ratio of a
+ *					node.
+ * @DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:	Scheme-ineligible memory ratio of a
+ *					node.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -206,6 +210,8 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
+	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+	DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5908537f45f1..f71ee19f526d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -17,6 +17,9 @@
 #include <linux/string.h>
 #include <linux/string_choices.h>
 
+/* for damon_get_folio() used by node eligible memory metrics */
+#include "ops-common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
@@ -2549,7 +2552,136 @@ static unsigned long damos_get_node_memcg_used_bp(
 		numerator = i.totalram - used_pages;
 	return mult_frac(numerator, 10000, i.totalram);
 }
-#else
+
+#ifdef CONFIG_DAMON_PADDR
+/*
+ * damos_calc_eligible_bytes() - Calculate raw eligible bytes per node.
+ * @c:		The DAMON context.
+ * @s:		The scheme.
+ * @nid:	The target NUMA node id.
+ * @total:	Output for total eligible bytes across all nodes.
+ *
+ * Iterates through each folio in eligible regions to accurately determine
+ * which node the memory resides on. Returns eligible bytes on the specified
+ * node and sets *total to the sum across all nodes.
+ *
+ * Note: This function requires damon_get_folio() from ops-common.c, which is
+ * only available when CONFIG_DAMON_PADDR or CONFIG_DAMON_VADDR is enabled.
+ */
+static unsigned long damos_calc_eligible_bytes(struct damon_ctx *c,
+		struct damos *s, int nid, unsigned long *total)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long total_eligible = 0;
+	unsigned long node_eligible = 0;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			phys_addr_t addr, end_addr;
+
+			if (!__damos_valid_target(r, s))
+				continue;
+
+			/* Convert from core address units to physical bytes */
+			addr = r->ar.start * c->addr_unit;
+			end_addr = r->ar.end * c->addr_unit;
+			while (addr < end_addr) {
+				struct folio *folio;
+				unsigned long folio_sz, counted;
+
+				folio = damon_get_folio(PHYS_PFN(addr));
+				if (!folio) {
+					addr += PAGE_SIZE;
+					continue;
+				}
+
+				folio_sz = folio_size(folio);
+				/*
+				 * Clip to region boundaries to avoid counting
+				 * bytes outside the region when folio spans
+				 * region boundaries.
+				 */
+				counted = min(folio_sz, (unsigned long)(end_addr - addr));
+				total_eligible += counted;
+				if (folio_nid(folio) == nid)
+					node_eligible += counted;
+
+				addr += folio_sz;
+				folio_put(folio);
+			}
+		}
+	}
+
+	*total = total_eligible;
+	return node_eligible;
+}
+
+/*
+ * damos_get_node_eligible_mem_bp() - Get eligible memory ratio for a node.
+ * @c:		The DAMON context.
+ * @s:		The scheme.
+ * @nid:	The target NUMA node id.
+ *
+ * Calculates scheme-eligible bytes on the specified node and returns the
+ * ratio in basis points (0-10000) relative to total eligible bytes across
+ * all nodes.
+ */
+static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	unsigned long total_eligible = 0;
+	unsigned long node_eligible = 0;
+
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
+		return 0;
+
+	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
+
+	if (!total_eligible)
+		return 0;
+
+	return mult_frac(node_eligible, 10000, total_eligible);
+}
+
+static unsigned long damos_get_node_ineligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	unsigned long total_eligible = 0;
+	unsigned long node_eligible;
+
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
+		return 0;
+
+	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
+
+	/* No eligible memory anywhere - ratio is undefined, return 0 */
+	if (!total_eligible)
+		return 0;
+
+	/* Compute ineligible ratio directly: 10000 - eligible_bp */
+	return 10000 - mult_frac(node_eligible, 10000, total_eligible);
+}
+#else /* CONFIG_DAMON_PADDR */
+/*
+ * Stub functions when CONFIG_DAMON_PADDR is disabled.
+ * The node_eligible/ineligible metrics require physical address operations
+ * to iterate folios, which are only available with PA-mode DAMON.
+ */
+static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	return 0;
+}
+
+static unsigned long damos_get_node_ineligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	return 0;
+}
+#endif /* CONFIG_DAMON_PADDR */
+
+#else /* CONFIG_NUMA */
 static __kernel_ulong_t damos_get_node_mem_bp(
 		struct damos_quota_goal *goal)
 {
@@ -2561,7 +2693,19 @@ static unsigned long damos_get_node_memcg_used_bp(
 {
 	return 0;
 }
-#endif
+
+static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	return 0;
+}
+
+static unsigned long damos_get_node_ineligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	return 0;
+}
+#endif /* CONFIG_NUMA */
 
 /*
  * Returns LRU-active or inactive memory to total LRU memory size ratio.
@@ -2581,7 +2725,8 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
-static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+static void damos_set_quota_goal_current_value(struct damon_ctx *c,
+		struct damos *s, struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
 
@@ -2608,19 +2753,28 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = damos_get_in_active_mem_bp(
 				goal->metric == DAMOS_QUOTA_ACTIVE_MEM_BP);
 		break;
+	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
+				goal->nid);
+		break;
+	case DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:
+		goal->current_value = damos_get_node_ineligible_mem_bp(c, s,
+				goal->nid);
+		break;
 	default:
 		break;
 	}
 }
 
 /* Return the highest score since it makes schemes least aggressive */
-static unsigned long damos_quota_score(struct damos_quota *quota)
+static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	struct damos_quota_goal *goal;
 	unsigned long highest_score = 0;
 
 	damos_for_each_quota_goal(goal, quota) {
-		damos_set_quota_goal_current_value(goal);
+		damos_set_quota_goal_current_value(c, s, goal);
 		highest_score = max(highest_score,
 				mult_frac(goal->current_value, 10000,
 					goal->target_value));
@@ -2629,17 +2783,20 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 	return highest_score;
 }
 
-static void damos_goal_tune_esz_bp_consist(struct damos_quota *quota)
+static void damos_goal_tune_esz_bp_consist(struct damon_ctx *c, struct damos *s)
 {
-	unsigned long score = damos_quota_score(quota);
+	struct damos_quota *quota = &s->quota;
+	unsigned long score = damos_quota_score(c, s);
 
 	quota->esz_bp = damon_feed_loop_next_input(
 			max(quota->esz_bp, 10000UL), score);
 }
 
-static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
+static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
+		struct damos *s)
 {
-	unsigned long score = damos_quota_score(quota);
+	struct damos_quota *quota = &s->quota;
+	unsigned long score = damos_quota_score(c, s);
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
@@ -2652,8 +2809,9 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damon_ctx *c, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
 
@@ -2664,9 +2822,9 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (!list_empty(&quota->goals)) {
 		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
-			damos_goal_tune_esz_bp_consist(quota);
+			damos_goal_tune_esz_bp_consist(c, s);
 		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
-			damos_goal_tune_esz_bp_temporal(quota);
+			damos_goal_tune_esz_bp_temporal(c, s);
 		esz = quota->esz_bp / 10000;
 	}
 
@@ -2715,7 +2873,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s);
 		if (trace_damos_esz_enabled())
 			damos_trace_esz(c, s, quota);
 	}
@@ -2737,7 +2895,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bf923709ab91..7e9cd19d5bff 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1084,6 +1084,14 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_INACTIVE_MEM_BP,
 		.name = "inactive_mem_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+		.name = "node_eligible_mem_bp",
+	},
+	{
+		.metric = DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
+		.name = "node_ineligible_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2717,6 +2725,10 @@ static int damos_sysfs_add_quota_score(
 		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 			goal->nid = sysfs_goal->nid;
 			break;
+		case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		case DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:
+			goal->nid = sysfs_goal->nid;
+			break;
 		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
 		case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 			err = damon_sysfs_memcg_path_to_id(
-- 
2.43.0

