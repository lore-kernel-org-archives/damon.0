Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A858261591;
	Thu, 19 Jun 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370431; cv=none; b=pFR+aQe+91tbUCnYMoL7NfR4ByYmKaMKOosYipzEPKtqwRFsJyrYJ7MBHJcbSXEXhy8BhLwZPhUtnQgXixcW4JCovQuuG7KcbJbZEuMuLXAIYN+N+EjDFKfuO1kGpC4SXzwOyY6Odift5hR6+tO3OhnNisdstNEFa2V7y3mc9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370431; c=relaxed/simple;
	bh=Sd7W7p0Z+HVtPzictunii3Ma4j0vmmcBWE6o+ftHaDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jz8F6W6AfbRx0vA/bfMtBdbojpmJCW1iTJC8vDKxzsfm/iWgiLYxHNdWNuFAmdpt7Gahb+fSNViJpS6+p/OXShX3GE6a6Sqg0ujz4PBPyNoEzKfqqrmjrcBm6FmwtSPP++Y1ZMiOvwg+Otcpofhu1EQlRJkIG9wXiiSzJL8M4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Wlabva; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Wlabva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34ADC4CEEE;
	Thu, 19 Jun 2025 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370431;
	bh=Sd7W7p0Z+HVtPzictunii3Ma4j0vmmcBWE6o+ftHaDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3Wlabva7fAPBjEGLuMNQ/vz15Fk+3x9EUkjlHBmWHgr2zK4gj09L5hNDPPFyQHvk
	 J7g1SmiAaB4nMCr/cCXJBvsj8KiROywzeioOQzLjW0KaYApGD+IoJo07eVzbkaVp91
	 k1SzEEb9o22+akiOCGUNxXs8/SHQOk8PpD04btxTp1p1x8Og7QlhlVwK7FQOSZvaCD
	 w+z+nVv5ggR2InyUb4GF6xf3VjLHdwWvPxNkegzogPLn3Pgyvh+u3/wEwIPDf6P8F2
	 qqS/yfzmNguoOOSuwBWr89lkgu5lsvI8PGy0CN04sHp8B9XD8Tx0Z81gpG1q/IjWD8
	 ApmV4xtHuCBqg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/11] mm/damon: add a new DAMOS quota goal metric for cgroup on node memory usage
Date: Thu, 19 Jun 2025 15:00:14 -0700
Message-Id: <20250619220023.24023-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new DAMOS quota auto-tuning target metrics for per-cgroup
per-node memory usage.  Also extend damos_quota_goal struct to have a
field for specifying the cgroup of the interest.

Note that this commit is only for DAMON kernel API extension.  Real
behavior of the new metric will be implemented by a following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 39b835dd3c4d..43aef959d357 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -175,6 +175,7 @@ enum damos_action {
  * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
  * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
+ * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
  * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to inactive memory ratio.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
@@ -185,6 +186,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_SOME_MEM_PSI_US,
 	DAMOS_QUOTA_NODE_MEM_USED_BP,
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
+	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
@@ -196,6 +198,7 @@ enum damos_quota_goal_metric {
  * @current_value:	Current value of @metric.
  * @last_psi_total:	Last measured total PSI
  * @nid:		Node id.
+ * @memcg:		Memcg id.
  * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
@@ -209,6 +212,9 @@ enum damos_quota_goal_metric {
  *
  * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
  * id of the target node to account the used/free memory.
+ *
+ * If @metric is DAMOS_QUOTA_NODE_MEMCG_USED_BP, @nid and @memcg_id represents
+ * the node id and the cgroup to account the used memory for.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
@@ -217,7 +223,10 @@ struct damos_quota_goal {
 	/* metric-dependent fields */
 	union {
 		u64 last_psi_total;
-		int nid;
+		struct {
+			int nid;
+			unsigned short memcg_id;
+		};
 	};
 	struct list_head list;
 };
-- 
2.39.5
