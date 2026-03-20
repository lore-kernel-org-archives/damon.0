Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583C3016EE
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033505; cv=none; b=sFfKBcUvAXYbiIfsYxOQcRPLsBFaAEYHWPMfpfquitfqJpEmR+ZliqnwkJTwxWRp0tDMCn9Lm2lrMgl/AYZi6eG5i91Qb8rPdtkprn1WM2bPHGlDQM13Szoh4r1Kf86lFaM7sIUISgmktFFYx0G249urd6HMLWPs0veyw85seTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033505; c=relaxed/simple;
	bh=wSfIa4k2FoGGGse9nhlCXRZG1PNoyEALZd0TlgrqxZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVvBXspyBkAZ9QuayvDSm/zjjKnYSCGZiq3ymxvBHgmzl2eM3O6MYWxx60KpbE/huReI7nJqT1DuZqkmdKcL2tX4kiMm5znj21Do5TTKjtrMdGPXcaLRgPUnfAWvB9tT5W+23AlssIZ5tn+7H3PRTjNw4C5EW3hqKV38g3PmcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWB9vfi3; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWB9vfi3"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so2608556d50.1
        for <damon@lists.linux.dev>; Fri, 20 Mar 2026 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774033501; x=1774638301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsaG2cqBlzmGBKhCZrr0TNjZqNjOAajTDrfTI+nVTrg=;
        b=gWB9vfi3vhKeDrOtov9q1yJowCdBuNcryPtBDFuqPYsU7sIjJvF7d2VM5A9cE5xTip
         +oeGT/HYRdoHkuwm3ZsK7Updjf0qn/zlfV+/QaKT9l5BGvAsyOROXi4QijAFb6qUs70A
         Nsbg6kNPhbZIw4iN3OPeuOv5GamngTPsrj9z3fCAmBgEqqK0BlXJxA3r6DfX0f/qECZN
         TMDPGfjTMtOX3zdAyrVCiz8NkjqOVF86JvxhI6q/mGyKhj83JTCqzxHkFzlcs4mk2wDa
         gyRYrW1dMStqeMFn2kx2MZcf1SnPKGmyOww7mbTt125G173NWUDCaTz+o6Ca0XvFGMaZ
         NnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033501; x=1774638301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsaG2cqBlzmGBKhCZrr0TNjZqNjOAajTDrfTI+nVTrg=;
        b=HhmiED+V8Oj5FVZWvMtlMDKM3/ccpbEAT+keiTt+6VOlBvU4DkQQMKJYOAnP1jTozH
         M0GaCgAE1VCViJUD5rjOnaX0i3+5Jlb/6VKuPx2EIY5e/2X+QHNG+AmJIYg4CB15D8yC
         Aiq6BvEEUndDnApSrLl3JYxMxeF0kOJMC9aB4lJHNmWR85nTzb6whTS1eiAuYMJxr8il
         me3Lh3ihET9iJgqngqwESMllXP10/PYrgAPRTKVy7tpPrD+kXlh6FvOv+Yq52XeKm7rZ
         OT6mwFcXyXiDh41pM10MxOHGIuJZtLyF9YEdr0Iqymg8eTbtptiz3Rophqmb0VywIujx
         UoWw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wdFW7JstW0snb+urT9NwqxHbUllHcFcAaRlm+v12pQ4TBiF0wTbdU/Vy0Z3sm2bD+6AhMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9uzTCsIgx93m/B3/+V0bxN5GjQIivuod97WExaEsDUEoEZvHM
	IaSIqaQ9Hb4jfD13kPEV/NnuL4Ahr3XAYnQBjz5ticqmlitoDPaDFsg=
X-Gm-Gg: ATEYQzyu59yaODLUp/H/8oIdkVIX374umaDPdyG5ZVovadFlaS+2EVngFT2vpoiLZKm
	TAffatJw2C1O6qy5DzpcQm+i+J9HeMDaR2OirJfCXiEia9cSSmXOTs4YQmmEs+3t1BHFCEDGHIk
	V45kC6C8SQHao3FrisD8jqoPyUJxLIE1gy/VNpxJkYzASnEmL9lckXZLlaAmhv9XluPRdiSgPlK
	gcFW60Dzax5rdQFPjo6Dqdu3i07myE+EFMrMxN1rviArUcjVqS1Q52zW7uzVs4ybQrquQmxdERg
	iVGQwMlSOQLotPOqiPG1IVOn582cXNSu0g8PPyXP9XQ2FQOsn6IyrV0Yxh9elJIKVTYckv+wvWG
	9heRv9/gQA5qVTAkW7jyHGz8X6H9UTNGT/SgtNd3OORge4YS55tdZgRhyCQKHKFLEj8UXoPzUby
	3GStz/+3FIdGqNTeFsTQcrFCZ0HuJofz8MUOf8kDZkON9FpM78+8e+uXlUixcpbfgLiPLHEfHJt
	Q==
X-Received: by 2002:a05:690e:e83:b0:64a:d705:31d0 with SMTP id 956f58d0204a3-64eaa701833mr4984332d50.28.1774033500742;
        Fri, 20 Mar 2026 12:05:00 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7e34esm1990519d50.10.2026.03.20.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:05:00 -0700 (PDT)
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
	ravis.opensrc@gmail.com
Subject: [RFC PATCH v4 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Fri, 20 Mar 2026 12:04:53 -0700
Message-ID: <20260320190453.1430-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320190453.1430-1-ravis.opensrc@gmail.com>
References: <20260320190453.1430-1-ravis.opensrc@gmail.com>
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
- DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP: ratio of eligible memory NOT on
  a node

These complementary metrics enable push-pull migration schemes that
maintain a target memory distribution across different NUMA nodes
representing different memory tiers, based on access patterns defined
by each scheme.

The metrics iterate scheme-eligible regions and use damon_get_folio()
to determine NUMA node placement of each folio, calculating the ratio
of eligible memory on the specified node versus total eligible memory.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h    |   6 ++
 mm/damon/core.c          | 158 ++++++++++++++++++++++++++++++++++++---
 mm/damon/sysfs-schemes.c |  12 +++
 3 files changed, 164 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b1d8fd88a0fc..490918804f85 100644
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
index b9e12865622c..3e0ac65e34a0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -17,6 +17,8 @@
 #include <linux/string.h>
 #include <linux/string_choices.h>
 
+#include "ops-common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
@@ -2552,6 +2554,112 @@ static unsigned long damos_get_node_memcg_used_bp(
 		numerator = i.totalram - used_pages;
 	return mult_frac(numerator, 10000, i.totalram);
 }
+
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
 #else
 static __kernel_ulong_t damos_get_node_mem_bp(
 		struct damos_quota_goal *goal)
@@ -2564,6 +2672,18 @@ static unsigned long damos_get_node_memcg_used_bp(
 {
 	return 0;
 }
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
 #endif
 
 /*
@@ -2584,7 +2704,8 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
-static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+static void damos_set_quota_goal_current_value(struct damon_ctx *c,
+		struct damos *s, struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
 
@@ -2611,19 +2732,28 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
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
@@ -2632,17 +2762,20 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
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
@@ -2655,8 +2788,9 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damon_ctx *c, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
 
@@ -2667,9 +2801,9 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (!list_empty(&quota->goals)) {
 		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
-			damos_goal_tune_esz_bp_consist(quota);
+			damos_goal_tune_esz_bp_consist(c, s);
 		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
-			damos_goal_tune_esz_bp_temporal(quota);
+			damos_goal_tune_esz_bp_temporal(c, s);
 		esz = quota->esz_bp / 10000;
 	}
 
@@ -2718,7 +2852,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s);
 		if (trace_damos_esz_enabled())
 			damos_trace_esz(c, s, quota);
 	}
@@ -2739,7 +2873,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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

