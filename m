Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384E33291F;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736435; cv=none; b=VlEvTPbgBgPbvNGpLog/9Kylooo5Y0ZTds0OnjN00VUVoU4yfacSp/kSVz0FiykMu6BE8IVOBRtwiGV+nviPOgdG4b35Fqm3xUz6varKKX1k4M+rUj9mjrlxChwOxNNmC8Jzy+QwLrmqo7uc0i+4S9sQ+K1JNmNmE1DyFdWQT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736435; c=relaxed/simple;
	bh=r1QRmbQ0ckNwsPpAqp/NhFI/Nrd0yqfQwVomPU13aMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTGRP9Hask+/mibb7FsG9/JBJmAZAa3dqt6IU5JnXqv8bJVcR3HO7xhMOo5NwozsX4ngdnZs8QYG4P7bfzIgqwOxveuYbRv8PR2bzS3vGTqgByC/ai4lCoHjNjypGRoiJIBWRpKkWG/VpWe3TcUWKwqv5iYP6aGg8fxolktrABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1sivf6R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1sivf6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309B6C4CEE7;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736435;
	bh=r1QRmbQ0ckNwsPpAqp/NhFI/Nrd0yqfQwVomPU13aMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1sivf6RmIIQvpCVclfSkMGi4RwQqfkkqwO/EvMqrM3e6n5P0vuBS65Lruodm8a+5
	 t1LNAPUE6FG8euuAYXE6vUvVNSbSuiGSFrW9WArIO4o3tkmf1J7534dVJmdoohiYcJ
	 LZcDqyHKiQurrcu5H1bhVpM0kqV8EtlQTPkaR1vH0HIqo2e1UVbjQL3D+5FT7tlnOY
	 XeHSY9ogCR6P0jmgyndjG86U+5F/HkdIuYHJDnWPaTFbsmoyjo/HxKMJXH3CkFRxwa
	 gaqrrtZgDC6JGqgx/bjdmpV6xSXN9cJjdShYRc10I7J1p2ggtGrm5/cHFsduYzNYB7
	 +WkS7PnxXomhg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/core: add DAMOS quota gaol metric for per-memcg per-numa free memory
Date: Fri, 17 Oct 2025 14:26:58 -0700
Message-ID: <20251017212706.183502-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
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
 include/linux/damon.h |  6 ++++--
 mm/damon/core.c       | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 862531f1a379..9ee026c2db53 100644
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
index 00f1686d767f..82546d138a5a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -790,6 +790,7 @@ static void damos_commit_quota_goal_union(
 		dst->nid = src->nid;
 		break;
 	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		dst->nid = src->nid;
 		dst->memcg_id = src->memcg_id;
 		break;
@@ -2046,7 +2047,7 @@ static unsigned long damos_get_node_memcg_used_bp(
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-	unsigned long used_pages;
+	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
 	rcu_read_lock();
@@ -2066,7 +2067,11 @@ static unsigned long damos_get_node_memcg_used_bp(
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
@@ -2101,6 +2106,7 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = damos_get_node_mem_bp(goal);
 		break;
 	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		goal->current_value = damos_get_node_memcg_used_bp(goal);
 		break;
 	default:
-- 
2.47.3
