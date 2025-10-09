Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E72820DB;
	Thu,  9 Oct 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044855; cv=none; b=Iia2RCGWJf3dg3qdnFRyZwGRy+8YdxM1KNM49EPTZfykcyP95GNfjbDxULvSDoiZ8q371BUrep67WNaAlfsZ85CHdKMz5KhHuUgKJ/0PinELPWIsVj2GM/n2MvJk4hkaMHqYIl9X+0PkXHcB4YoegsmuiF2kuHsxoqQuCxqUwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044855; c=relaxed/simple;
	bh=CkhTLsuJMtU34HmXX0O02XR+nCAeXgrwHrAqstQf9yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFMTF+OsC1c09pO7egJn/aUAIeWToY4anh3cQv8TLnK0lwOcNUHjvDj5ajEB7oyKQlmO+SfKrtnlBeagTYlZhWuk2L256lheNHuU+zsxxtq0glCavq5J00rF0EkZuB9JrChuOB55Mwi2totzhBnuThOPCZ90bV7ENhQK+VRkG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEVumExa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEVumExa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8266DC113D0;
	Thu,  9 Oct 2025 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044854;
	bh=CkhTLsuJMtU34HmXX0O02XR+nCAeXgrwHrAqstQf9yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEVumExa/JemdD+OCfcpdTleOjTbQhH/UBhfCnnG/kq3lyQD+OIVN1PzJI9YBObXs
	 dCvMgOALWBGYu7MNRIRSWRCq92x1JKNgQzcsY6mXS9bVXnMRYQXi0Q+vowzSeJH3+o
	 GHieqAC4FdPUcc+yDKyJT4pMxYChEl0x4opfEqPfylL2IVAP/O1f6WeADIPIbkxoND
	 pa5hslqk2R0ZH+mRkQK6mHwZT1IPPQb6sFIlW6KCs0crcbRm9IUlyOoPwgcIq9Ett2
	 kZLNGw0z7wxyKMr7HWxtkIVk+MoS1AsB/b9gC8Lw76dgANzwsLsqnEdZDN/mKTsDM1
	 rbwC3AYpqbybA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/10] mm/damon/core: add DAMOS quota gaol metric for per-memcg per-numa free memory
Date: Thu,  9 Oct 2025 14:20:38 -0700
Message-Id: <20251009212042.60084-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a variant of DAMOS_QUOTA_NODE_MEMCG_USED_BP, for the free memory
portion.  The value of the metric is implemented as the entire memory of
the given NUMA node subtracted by the given cgroup's usage.  So from a
perspective, "unused" could be a better term than "free".  But arguably
it is not very clear what is better, so use the term "free".

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++--
 mm/damon/core.c       | 9 +++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0d63ceb7e6ef..0edf41d36ea1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -148,6 +148,7 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
+ * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -158,6 +159,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEM_USED_BP,
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
+	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
@@ -183,8 +185,8 @@ enum damos_quota_goal_metric {
  * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
  * id of the target node to account the used/free memory.
  *
- * If @metric is DAMOS_QUOTA_NODE_MEMCG_USED_BP, @nid and @memcg_id represents
- * the node id and the cgroup to account the used memory for.
+ * If @metric is DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP, @nid and @memcg_id
+ * represents the node id and the cgroup to account the used memory for.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1eacf78aa358..a31ede50906c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2039,7 +2039,7 @@ static unsigned long damos_get_node_memcg_used_bp(
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-	unsigned long used_pages;
+	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
 	rcu_read_lock();
@@ -2059,7 +2059,11 @@ static unsigned long damos_get_node_memcg_used_bp(
 	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
 
 	si_meminfo_node(&i, goal->nid);
-	return used_pages * 10000 / i.totalram;
+	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+		numerator = used_pages;
+	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+		numerator = i.totalram - used_pages;
+	return numerator * 10000 / i.totalram;
 }
 #else
 static __kernel_ulong_t damos_get_node_mem_bp(
@@ -2094,6 +2098,7 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = damos_get_node_mem_bp(goal);
 		break;
 	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		goal->current_value = damos_get_node_memcg_used_bp(goal);
 		break;
 	default:
-- 
2.39.5
