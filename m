Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A52E6CC8
	for <damon@lists.linux.dev>; Sun,  5 Apr 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775414581; cv=none; b=olbkz5bjFwq7f4r8elv4K9wrJVr7STvY0HCPdCZzHKSYhw1zAlm9ZfRMo2fAS5dgYFqMakuHT/5HcS1LSCC4cIo67LoxDRf5tVtzz6NapUsnhxKRjj69EmgCjoVf1kotjf7MqO9XxrCOYxZCA+YtB0bcdKx+nHlIUtSqQonnV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775414581; c=relaxed/simple;
	bh=aLKoj5T6Y1Hq/63N0ofOdGla42IB3T21JHaswyIp9sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP5rgDEKH5MFuoRjuVftBhVgV/czZUZ76YfDJdEa7X39SsXB5OcIy2b/uSK1ltRGHhguAfjUjvAmTUXje2RjzjQHyBekIrdarsrFldHmUldnz+VR8b3NM1tms/QoLTr31VUWc2lzeT4dfzBk1ZhHddsAC2vwfXMCAjVa6KxFKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XycwMypG; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XycwMypG"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64ee82e853cso2444313d50.3
        for <damon@lists.linux.dev>; Sun, 05 Apr 2026 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775414578; x=1776019378; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEKRNySrl5bfNR25LuvdIM9mAYLQZGQHO8FJc6GF6Vs=;
        b=XycwMypGld89K/4eEkIiabHDrMDPraHqm3/EWHX/4Bu0+BqG6evoP3NU0KPi5kq3D3
         fi5OGITsxfE0IVkjbVe4QX/bPJBV4DFbjZZ2xsqhuaJTTWTF7doL/9v5WzfMErDj4DOa
         RNHu7holiesJBTnzIOwNqOy+9duOSOFcvHrWxLPB42Q4VUmQqYI5q+LZI2VeFDTjYzV4
         U9PbQSAFgW2FP3nNnyq4DEl2mtfxIbiDUF/KY4VpI2CjVGoLsjwWIggGswRE4VOLSusv
         xhHOza3EHCAbmgDjG5d29B8AjV+YzdmlPieFCrWK6A0DmHVX4UcEGyPlv/tWzHovnRs9
         uw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775414578; x=1776019378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEKRNySrl5bfNR25LuvdIM9mAYLQZGQHO8FJc6GF6Vs=;
        b=NDghM4uf6kDpDiZVDUkMm2eGKE28p8a90g2bzgW0I8EzZ4cAp6D0teuWZg3i0Zt6HL
         YWi31qEeO19zIU4NMedR2YqdNgmNcfy2IsZMpvk6FbV2C1CPxty1Whh2IG6oqRWBck1d
         oI0sWcFaWqTgQh4vpmN7xH4dF201xmCWohlP86wsYST4x7YDBj5vP2/PNrvgRkprcyhA
         XqTitlAN6DhBEDRfV7JOPjkj7FhjtWdx/zkjYYIE9rNB8k7jHSS31WbQZoltO5z45aXs
         0uw3vZ9eRziZtuhrMyoh4QdkXka8Wz1PtSeJxslN2d54ZlchFmYRjbyROLiVL0HH2/Jl
         qUlw==
X-Forwarded-Encrypted: i=1; AJvYcCUTVRgQiDhzsuPk2fuEaGxR2WlDDHkjZsYGrULxzX81D6Z2V0ANBs5wf8pBb0NnbOdEtEcJYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFfXJ7Wzq7QJfkSQcE8/j3y5yeOLYSUmdJAHMwMWGqkdzKMPg/
	ljGtWziTL7YffisFP22n6Dauqdcv68961DtYL3UNwA7xbnAiNf7uCi4=
X-Gm-Gg: AeBDietT+LSyXqGd01uwd+JvIgdgaq5z/Q9tC7d21Y1BTmCVCELIUNMRQzC/craKInW
	TSKuJWV03sOli6jeksE/x1c8tTN0YtnK2vc9/B8RkOvQKsVS8ouM+Yo4CS1HVGP6aeOGAEJEtAe
	1/B0JcGmNOj9629vR5N2mHUn6iUYXX5Vkc6RirhH+3wOci1u5yU1vMrCc7yKczhWi8OBULFeGD3
	InbOPekjBVzg1TuYk3cvSWSXSSap96ahnCTX0Tyn+vBMUxtfgpxBwABkuAMR4hQz9y8m09WRvka
	vQQNfnjvO59RslkdYtguP5ySzWfXclZIHB8rEesXZG/UJagpMo4iALp/BDQZYbUmQ2Dd2O0DsCX
	e7gh9ObyThVB/vwq1hkI3yuPi+9VpKmygFxcHLIerOrBuN+AoLxmkGhhXTJ/7Loi6DSjXYGWtwX
	UduiR9A2odNmKUUOUxqK84KfTHUMasPL6PyygF5JC/7TuHq+ZYd3zm/aoQUjC/3mXEuN4cynZzB
	g==
X-Received: by 2002:a05:690e:440d:b0:649:bbf4:121b with SMTP id 956f58d0204a3-650486bf82emr7496002d50.2.1775414577596;
        Sun, 05 Apr 2026 11:42:57 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d8c2fsm4963299d50.20.2026.04.05.11.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 11:42:57 -0700 (PDT)
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
Subject: [PATCH v6 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Sun,  5 Apr 2026 11:42:47 -0700
Message-ID: <20260405184247.2690-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405184247.2690-1-ravis.opensrc@gmail.com>
References: <20260405184247.2690-1-ravis.opensrc@gmail.com>
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
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h    |   6 ++
 mm/damon/core.c          | 188 ++++++++++++++++++++++++++++++++++++---
 mm/damon/sysfs-schemes.c |  12 +++
 3 files changed, 192 insertions(+), 14 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6..a268f44beabf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -159,6 +159,10 @@ enum damos_action {
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
@@ -172,6 +176,8 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
+	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+	DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3bc7a2bbfe7d..bac810f740c3 100644
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
 
@@ -2282,7 +2285,136 @@ static unsigned long damos_get_node_memcg_used_bp(
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
@@ -2294,7 +2426,19 @@ static unsigned long damos_get_node_memcg_used_bp(
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
@@ -2314,7 +2458,8 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
-static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+static void damos_set_quota_goal_current_value(struct damon_ctx *c,
+		struct damos *s, struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
 
@@ -2340,19 +2485,28 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
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
@@ -2361,17 +2515,20 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
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
@@ -2384,8 +2541,9 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damon_ctx *c, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
 
@@ -2396,9 +2554,9 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (!list_empty(&quota->goals)) {
 		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
-			damos_goal_tune_esz_bp_consist(quota);
+			damos_goal_tune_esz_bp_consist(c, s);
 		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
-			damos_goal_tune_esz_bp_temporal(quota);
+			damos_goal_tune_esz_bp_temporal(c, s);
 		esz = quota->esz_bp / 10000;
 	}
 
@@ -2445,7 +2603,9 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s);
+		if (trace_damos_esz_enabled())
+			damos_trace_esz(c, s, quota);
 	}
 
 	/* New charge window starts */
@@ -2460,7 +2620,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966dafb3..aade681b4868 100644
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
@@ -2655,6 +2663,10 @@ static int damos_sysfs_add_quota_score(
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

