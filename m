Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3202D662F
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345530; cv=none; b=OCR5Jt2HBCQs+c5LMxPlZrGKOY0OfHeuHN4F472poLMk6AbiqNf5ic+SlSqcH/nLv46gw7G3FxV8uAqJp8KvjPQu0hYUU02XrAfFeNQkT9236LIgy2g7sjYf0FHwO5wh/Ke9QIKfYb2MlQGo2KHK6EprazxSwh9nGvsZ1C0kkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345530; c=relaxed/simple;
	bh=retzMbJfFdFP1pbEwjmmvYWmzsURRod0nYGG7biY03o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MU8yf07l0xfrZPmoXIgj5z46lp1puKJBl1gD7PlLsv1T44/OBkj1DuDKte5hUBXMSIC9/SKC6e6TKTqTqoLsfsYMe62akWCrWU7rn8rUiJ8wYqfZCcQnKEj1WJaKkFYuZtdzG+/9Glm4brZbGWFjWd+TX3e/b4WfDrsHRb5Sym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4wj9Ala; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4wj9Ala"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64937edbc9eso9439257d50.2
        for <damon@lists.linux.dev>; Mon, 27 Apr 2026 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777345527; x=1777950327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKzRA9juVdBMs1pZDV3CeSH66YJK3jXv7jdwa1xUxyQ=;
        b=q4wj9AlamuxFOe1vIQe89jXV1EPb5S/pSbRz5IdTb6ydk/I0Xem1iq9HPtDIBHoTCH
         q9j7VREDdirXpI9vw6UZUuLrZSlj2DcOq8zZpuV4wBcaQeczGVSUk+WYLf0Kn1ROjVhP
         ibHBSPz3MzXUbcHgliPjbDTuz2cum5JGRWTSyIClLB1OdABDzbcrhJKZyC6DYJE+H8g2
         caJ9Oiy2/mLhFwPJxWqt8tdLvLoVqqqwp2YMTHXp0yv0RmO6ZONvqJU/7waoYKexAD91
         SF8fEF7VbmV6mRZFYjI91v32L2SAph8nk0NZv06oD28cTxlOTIBeMYTycXuSeoI/KfX/
         MxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777345527; x=1777950327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKzRA9juVdBMs1pZDV3CeSH66YJK3jXv7jdwa1xUxyQ=;
        b=RNmYqHsE/liY89RoI2lh9vDiGwW3fDyVGCC0M++8s6DUcZIMJ10hqD5dppT2jygBI9
         i6WhnMd8Ga1RZuIkymzKQWPB2pxgRfpyZ30tkhAtXOFoRqtOat2G8Jx2EIqd+J+8wfjq
         fhqk+mJ93t7bmLLG+UzDxCu+5OJGA3Lo5D+x3RzZO83ibPAdmGEaDpFx6ogEqaSDK8jk
         iZCXN7saWKxgn2oB1mhezb5S0SlDirG3Q4RhB+sGkFh5le3MB64mVuCVma2l+q8vrPGY
         cdCspLtAUGdJtXoGsl75N4Xy+G8NtE+O/VwINQU/4IRmb4yqGnvZm6JzB2NonSbCOM0R
         GW3A==
X-Forwarded-Encrypted: i=1; AFNElJ+A3TPUzBriV0mTXNgwDZsNeEVpwWt3v+CJs72yRnG9nfKFf3AyJq04aYekSK5KBLKqtqXLYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwECQutlMjex3hmKATi3IyJLdOUD52B57cB7TE541cr+yVh7bB8
	dYThYQUtulNt2deBwcU6ZVSjUxduiIEWQH5v6UCol+mF1Ba3VkDPpU0=
X-Gm-Gg: AeBDievYRV3SorqkMIrDwQnBQzPFQKG+rFhek9+stWFAJ+4Ks2IL/FfeyikYEgjUWLy
	cz41tw2t/m4cR7NQ+3/SVTLibFe8FsJZmxKTrbYGSQB1LVmyqtkejQIBe5ZFQVGjpx/t3eMSpIU
	aigrQCaUVa357o25h5P7d1YhckQyu1HoYffnLlMUZY6PwnfWx5iBNfdLpUFaXi9mb6u0wXzrGsJ
	cdEiElrPeBQ6hg8eGIzBzmWOFOIXkpI7AuN7sFoMxpDLhXH279AfMs3CnQKCUtFiGV3KxN9jrid
	YMwWdh/oGzgwlRw538KcOphEwny+SuTwzxg0QWiEaEFYaw5YvRavVc1fbMQCPKCWG30H2v2UMrG
	u6grulKGUICNTOfRB8vLeJZCnziS58d/CYkAVufVJb3lE+xN1d9/7Px9ExA2a2gQRM74+FBwZ9A
	AbD9pBYVMr5uImwuQ96vhhwODTQeC3sJyLUzK1fzQOLRzj+B7M0TehhRsIYmn0CS5CzZxjC2HBs
	AiJtTVxhsF68VVmeAMjpI4=
X-Received: by 2002:a05:690e:14cc:b0:654:ea8a:f2e with SMTP id 956f58d0204a3-65beed3d1cemr1081635d50.3.1777345526966;
        Mon, 27 Apr 2026 20:05:26 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bee26b960sm738059d50.1.2026.04.27.20.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:05:26 -0700 (PDT)
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
Subject: [PATCH v9.2] mm/damon: add node_eligible_mem_bp goal metric
Date: Mon, 27 Apr 2026 20:05:20 -0700
Message-ID: <20260428030520.701-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background and Motivation
=========================

In heterogeneous memory systems, controlling memory distribution across
NUMA nodes is essential for performance optimization. This patch enables
system-wide page distribution with target-state goals such as "maintain
60% of scheme-eligible memory on DRAM" using PA-mode DAMON schemes.

Rather than using absolute thresholds, this metric tracks the ratio of
memory that matches each scheme's access pattern filters on a target
node, enabling the quota system to automatically adjust migration
aggressiveness to maintain the desired distribution.

What This Metric Measures
=========================

node_eligible_mem_bp:
    scheme_eligible_bytes_on_node / total_scheme_eligible_bytes * 10000

Two-Scheme Setup for Hot Page Distribution
==========================================

For maintaining 60% of hot memory on DRAM (node 0) and 40% on CXL
(node 1):

    PULL scheme: migrate_hot to node 0
      goal: node_eligible_mem_bp, nid=0, target=6000
      addr filter: node 1 address range (only migrate FROM CXL)
      "Move hot pages to DRAM if less than 60% of hot data is in DRAM"

    PUSH scheme: migrate_hot to node 1
      goal: node_eligible_mem_bp, nid=1, target=4000
      addr filter: node 0 address range (only migrate FROM DRAM)
      "Move hot pages to CXL if less than 40% of hot data is in CXL"

Each scheme independently measures its own eligible memory and adjusts
its quota to achieve its target ratio. The schemes work in concert
through DAMON's unified monitoring context, with the quota autotuner
balancing their relative aggressiveness.

Implementation Details
======================

The implementation adds a new quota goal metric type
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP to the existing DAMOS quota goal
framework. When this metric is configured for a scheme:

1. During each quota adjustment cycle, damos_get_node_eligible_mem_bp()
   is called to calculate the current memory distribution.

2. The function iterates through all regions that match the scheme's
   access pattern (via __damos_valid_target()) and calculates:
   - Total eligible bytes across all nodes
   - Eligible bytes specifically on the target node (goal->nid)

3. For each eligible region, damos_calc_eligible_bytes() walks through
   the physical address range, using damon_get_folio() to look up
   each folio and determine its NUMA node via folio_nid().

4. Large folios are handled by calculating the exact overlap between
   the region boundaries and folio boundaries, ensuring accurate
   byte counts even when regions partially span folios.

5. The ratio (node_eligible / total_eligible * 10000) is returned
   as basis points, which the quota autotuner uses to adjust the
   scheme's effective quota size (esz).

The implementation requires CONFIG_DAMON_PADDR since damon_get_folio()
is only available for physical address space monitoring.

Testing Results
===============

Functionally tested on a two-node heterogeneous memory system with DRAM
(node 0) and CXL memory (node 1). A PUSH+PULL scheme configuration using
migrate_hot actions was used to reach a target hot memory ratio between
the two tiers.

With the TEMPORAL tuner, the system converges quickly to the target
distribution. The tuner drives esz to maximum when under goal and to
zero once the goal is met, forming a simple on/off feedback loop that
stabilizes at the desired ratio.

With the CONSIST tuner, the scheme still converges but more slowly, as
it migrates and then throttles itself based on quota feedback. The time
to reach the goal varies depending on workload intensity.

Note: This metric works with both TEMPORAL and CONSIST goal tuners.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
Changes since v9.1:
===================
https://lore.kernel.org/linux-mm/20260427010209.843-1-ravis.opensrc@gmail.com/

- Break calc_eligible_bytes() loop if addr overflows to prevent infinite
  loop when addr + PAGE_SIZE wraps around (SJ's fixup based on Sashiko
  review)

Changes since v9:
=================
https://lore.kernel.org/linux-mm/20260426213859.1835-1-ravis.opensrc@gmail.com/

- Cast phys_addr_t to unsigned long before mult_frac() to avoid
  __udivdi3 linking error on 32-bit systems with CONFIG_PHYS_ADDR_T_64BIT
  (SJ's fixup suggestion based on Sashiko review)
- Check !(unsigned long)total_eligible to avoid divide-by-zero after
  casting (SJ review)

Changes since v8:
=================
https://lore.kernel.org/linux-mm/20260426003245.2687-1-ravis.opensrc@gmail.com/

- Removed unnecessary casts in mult_frac() call to fix potential
  divide-by-zero on 32-bit PAE systems (Sashiko/SJ review)
- Kept original parameter name 'ctx' in damos_set_effective_quota()
  to avoid unnecessary diff (SJ review)

Changes since v7:
=================
https://lore.kernel.org/linux-mm/20260424203448.5040-1-ravis.opensrc@gmail.com/

- Wrapped if condition for goal->metric check to fix 80-column violation
- Used PAGE_ALIGN_DOWN(addr + PAGE_SIZE) instead of addr += PAGE_SIZE
  for proper page-aligned advancement
- Wrapped damos_goal_tune_esz_bp_temporal() function signature for
  80-column compliance
- Removed unintended damos_trace_esz() call from first charge window
- Added addr filter usage note in two-scheme setup documentation

Changes since v6:
=================
https://lore.kernel.org/linux-mm/20260405184247.2690-1-ravis.opensrc@gmail.com/

- Dropped node_ineligible_mem_bp metric per maintainer feedback
- Updated two-scheme setup to use 60%/40% split with both schemes using
  node_eligible_mem_bp (per SeongJae Park's suggestion)

Changes since v5:
=================
https://lore.kernel.org/linux-mm/20260404012215.1539-1-ravis.opensrc@gmail.com/

- Rebased onto mm-new instead of damon/next for sashiko review
- Removed Reported-by/Closes tags per maintainer feedback (not needed
  for bugs found before merge)

Changes since v4:
=================
https://lore.kernel.org/linux-mm/20260320190453.1430-1-ravis.opensrc@gmail.com/

- Fixed commit message description for DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP
  per review feedback
- Added clarifying comment for ops-common.h include (for damon_get_folio())
- Fixed build error when CONFIG_DAMON_PADDR is disabled by adding
  #ifdef CONFIG_DAMON_PADDR guards around functions using damon_get_folio()
- Dropped RFC tag per maintainer feedback

Changes since RFC v3:
=====================
https://lore.kernel.org/linux-mm/20260314223432.2292-1-ravis.opensrc@gmail.com/

- Fixed phys_addr_t overflow on 32-bit PAE systems by using phys_addr_t
  for intermediate byte calculations
- Added cond_resched() per region to prevent CPU soft lockups
- Improved folio overlap calculation for accurate byte counting

Changes since RFC v2:
=====================
https://lore.kernel.org/linux-mm/20260228191045.1892-1-ravis.opensrc@gmail.com/

- Added node_ineligible_mem_bp complementary metric
- Fixed DAMON_OPS_PADDR validation in damon_commit_ctx()
- Improved commit message with two-scheme setup documentation

Changes since RFC v1:
=====================
https://lore.kernel.org/linux-mm/20260215184523.1432-1-ravis.opensrc@gmail.com/

- Initial implementation based on SeongJae Park's suggestion
- Added basic node_eligible_mem_bp metric
---
 include/linux/damon.h    |   3 +
 mm/damon/core.c          | 172 +++++++++++++++++++++++++++++++++++----
 mm/damon/sysfs-schemes.c |   7 ++
 3 files changed, 167 insertions(+), 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d3054af1d964f..82dd43fb639ad 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -161,6 +161,8 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
  * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to total LRU memory ratio.
  * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to total LRU memory ratio.
+ * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:	Scheme-eligible memory ratio of a
+ *					node in basis points (0-10000).
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -174,6 +176,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
+	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 278594847cf94..00ff1a1c92e73 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -13,10 +13,14 @@
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
 #include <linux/psi.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_choices.h>
 
+/* for damon_get_folio() used by node eligible memory metrics */
+#include "ops-common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
@@ -1326,11 +1330,26 @@ static int damon_commit_targets(
 int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
+	struct damos *scheme;
+	struct damos_quota_goal *goal;
 
 	dst->maybe_corrupted = true;
 	if (!is_power_of_2(src->min_region_sz))
 		return -EINVAL;
 
+	/* node_eligible_mem_bp metric requires PADDR ops */
+	if (src->ops.id != DAMON_OPS_PADDR) {
+		damon_for_each_scheme(scheme, src) {
+			struct damos_quota *quota = &scheme->quota;
+
+			damos_for_each_quota_goal(goal, quota) {
+				if (goal->metric ==
+						DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP)
+					return -EINVAL;
+			}
+		}
+	}
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;
@@ -2288,7 +2307,115 @@ static unsigned long damos_get_node_memcg_used_bp(
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
+ * only available when CONFIG_DAMON_PADDR is enabled. It also requires the
+ * context to be using PADDR operations for meaningful results.
+ */
+static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
+		struct damos *s, int nid, phys_addr_t *total)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	phys_addr_t total_eligible = 0;
+	phys_addr_t node_eligible = 0;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			phys_addr_t addr, end_addr;
+
+			if (!__damos_valid_target(r, s))
+				continue;
+
+			/* Convert from core address units to physical bytes */
+			addr = (phys_addr_t)r->ar.start * c->addr_unit;
+			end_addr = (phys_addr_t)r->ar.end * c->addr_unit;
+			while (addr < end_addr) {
+				struct folio *folio;
+				phys_addr_t folio_start, folio_end;
+				phys_addr_t overlap_start, overlap_end;
+				phys_addr_t counted;
+
+				folio = damon_get_folio(PHYS_PFN(addr));
+				if (!folio) {
+					addr = PAGE_ALIGN_DOWN(addr +
+							PAGE_SIZE);
+					if (!addr)
+						break;
+					continue;
+				}
+
+				/*
+				 * Calculate exact overlap between the region
+				 * [addr, end_addr) and the folio range.
+				 * The folio may start before addr if addr is
+				 * in the middle of a large folio.
+				 */
+				folio_start = PFN_PHYS(folio_pfn(folio));
+				folio_end = folio_start + folio_size(folio);
+
+				overlap_start = max(addr, folio_start);
+				overlap_end = min(end_addr, folio_end);
+
+				if (overlap_end > overlap_start) {
+					counted = overlap_end - overlap_start;
+					total_eligible += counted;
+					if (folio_nid(folio) == nid)
+						node_eligible += counted;
+				}
+
+				/* Advance past the entire folio */
+				addr = folio_end;
+				folio_put(folio);
+			}
+			cond_resched();
+		}
+	}
+
+	*total = total_eligible;
+	return node_eligible;
+}
+
+static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	phys_addr_t total_eligible = 0;
+	phys_addr_t node_eligible;
+
+	if (c->ops.id != DAMON_OPS_PADDR)
+		return 0;
+
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
+		return 0;
+
+	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
+
+	if (!(unsigned long)total_eligible)
+		return 0;
+
+	return mult_frac((unsigned long)node_eligible, 10000,
+			(unsigned long)total_eligible);
+}
+#else /* CONFIG_DAMON_PADDR */
+static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
+		struct damos *s, int nid)
+{
+	return 0;
+}
+#endif /* CONFIG_DAMON_PADDR */
+#else /* CONFIG_NUMA */
 static __kernel_ulong_t damos_get_node_mem_bp(
 		struct damos_quota_goal *goal)
 {
@@ -2300,7 +2427,13 @@ static unsigned long damos_get_node_memcg_used_bp(
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
+#endif /* CONFIG_NUMA */
 
 /*
  * Returns LRU-active or inactive memory to total LRU memory size ratio.
@@ -2320,7 +2453,8 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
-static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+static void damos_set_quota_goal_current_value(struct damon_ctx *c,
+		struct damos *s, struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
 
@@ -2346,19 +2480,24 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = damos_get_in_active_mem_bp(
 				goal->metric == DAMOS_QUOTA_ACTIVE_MEM_BP);
 		break;
+	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
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
 	struct damos_quota_goal *goal;
+	struct damos_quota *quota = &s->quota;
 	unsigned long highest_score = 0;
 
 	damos_for_each_quota_goal(goal, quota) {
-		damos_set_quota_goal_current_value(goal);
+		damos_set_quota_goal_current_value(c, s, goal);
 		highest_score = max(highest_score,
 				mult_frac(goal->current_value, 10000,
 					goal->target_value));
@@ -2367,17 +2506,20 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
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
@@ -2390,9 +2532,9 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota,
-		struct damon_ctx *ctx)
+static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
 
@@ -2403,9 +2545,9 @@ static void damos_set_effective_quota(struct damos_quota *quota,
 
 	if (!list_empty(&quota->goals)) {
 		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
-			damos_goal_tune_esz_bp_consist(quota);
+			damos_goal_tune_esz_bp_consist(ctx, s);
 		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
-			damos_goal_tune_esz_bp_temporal(quota);
+			damos_goal_tune_esz_bp_temporal(ctx, s);
 		esz = quota->esz_bp / 10000;
 	}
 
@@ -2453,7 +2595,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota, c);
+		damos_set_effective_quota(c, s);
 	}
 
 	/* New charge window starts */
@@ -2468,7 +2610,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota, c);
+		damos_set_effective_quota(c, s);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index c14a564dd8218..e897745f1e185 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1094,6 +1094,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_INACTIVE_MEM_BP,
 		.name = "inactive_mem_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+		.name = "node_eligible_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2690,6 +2694,9 @@ static int damos_sysfs_add_quota_score(
 			}
 			goal->nid = sysfs_goal->nid;
 			break;
+		case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+			goal->nid = sysfs_goal->nid;
+			break;
 		default:
 			break;
 		}

base-commit: a1316f1941695b84c9b9eff946bee67b8c8ff0d8
-- 
2.43.0

