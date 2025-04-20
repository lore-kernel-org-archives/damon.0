Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580B1C5F2C;
	Sun, 20 Apr 2025 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178038; cv=none; b=aVw6C2tifI9zjKPWuqhOZZ8VeYTb15ttNA0PdCI2cOLaDlDsESzis8tNbYuaUi6DhkzGYkMPy5Jwmr4T1fxFyGFsgLlh3ZOnVLuezLizERjBnGW+VIeGw5vRFNRmzaajYq8l4jNBgEMR6A4RS0XHnb4ecJyq7cyCMB066sdQThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178038; c=relaxed/simple;
	bh=TOtCGrkDZVAaA1HvRz3yyFtveCVko96aYWnah99Y0Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A2pPmRK6XK8KMo4Vebt9+mL+ckSD+fCS0PTY+CtwQ1lNeRPjYkX8zs0lDfB/z2xqaz3jh+ZhGoYW9WxyFh/qMWvqU+TO+XGLjUh0M4tayT0svO0PMOKcXuJlZi79EjgZq/QpytXWtt0DyeYBc/SL4bdako77rwkUUGS0g4OG8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie2sg2Qu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie2sg2Qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C559C4CEE2;
	Sun, 20 Apr 2025 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178037;
	bh=TOtCGrkDZVAaA1HvRz3yyFtveCVko96aYWnah99Y0Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ie2sg2Qu7jppqBnu2UeOfQIH9KynSFtWEMiz3BdekMK/ampgBmK5k/e8jyQZJbPBp
	 BZYAumO5SAPYm9b4MT9jUG4cO30+GAJALnRYVRE6ihy8VK/tAdRvcwqcxS3dZi+b+n
	 /f6SfVVSPATV3YKyTtAbCU75FSSZXYK6f6UZLtD8cov2OL42qef344nDm0Tzl/1Jav
	 dfGsT2Cu0qMIhFB409ft1P/IZsn9Z3MnBqVvi2+fHOOiiAZinhjLVZ0vhLU2GfisJT
	 cyy+PAublkveW3rr1LV7BZsxF2C1O+kNc4u2dXyly9qGDail84tbtMrvR+2CrKKrL/
	 mr4aWpm9Q27CA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/core: introduce damos quota goal metrics for memory node utilization
Date: Sun, 20 Apr 2025 12:40:24 -0700
Message-Id: <20250420194030.75838-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Used and free space ratios for specific NUMA nodes can be useful inputs
for NUMA-specific DAMOS schemes' aggressiveness self-tuning feedback
loop.  Implement DAMOS quota goal metrics for such self-tuned schemes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    |  6 ++++++
 mm/damon/core.c          | 27 +++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 47e36e6ea203..a4011726cb3b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -145,6 +145,8 @@ enum damos_action {
  *
  * @DAMOS_QUOTA_USER_INPUT:	User-input value.
  * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
+ * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
+ * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -152,6 +154,8 @@ enum damos_action {
 enum damos_quota_goal_metric {
 	DAMOS_QUOTA_USER_INPUT,
 	DAMOS_QUOTA_SOME_MEM_PSI_US,
+	DAMOS_QUOTA_NODE_MEM_USED_BP,
+	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
@@ -161,6 +165,7 @@ enum damos_quota_goal_metric {
  * @target_value:	Target value of @metric to achieve with the tuning.
  * @current_value:	Current value of @metric.
  * @last_psi_total:	Last measured total PSI
+ * @nid:		Node id.
  * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
@@ -179,6 +184,7 @@ struct damos_quota_goal {
 	/* metric-dependent fields */
 	union {
 		u64 last_psi_total;
+		int nid;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f0c1676f0599..587fb9a4fef8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1889,6 +1889,29 @@ static inline u64 damos_get_some_mem_psi_total(void)
 
 #endif	/* CONFIG_PSI */
 
+#ifdef CONFIG_NUMA
+static __kernel_ulong_t damos_get_node_mem_bp(
+		struct damos_quota_goal *goal)
+{
+	struct sysinfo i;
+	__kernel_ulong_t numerator;
+
+	si_meminfo_node(&i, goal->nid);
+	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
+		numerator = i.totalram - i.freeram;
+	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+		numerator = i.freeram;
+	return numerator * 10000 / i.totalram;
+}
+#else
+static __kernel_ulong_t damos_get_node_mem_bp(
+		struct damos_quota_goal *goal)
+{
+	return 0;
+}
+#endif
+
+
 static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
@@ -1902,6 +1925,10 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = now_psi_total - goal->last_psi_total;
 		goal->last_psi_total = now_psi_total;
 		break;
+	case DAMOS_QUOTA_NODE_MEM_USED_BP:
+	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+		goal->current_value = damos_get_node_mem_bp(goal);
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 23b562df0839..98108f082178 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -942,6 +942,8 @@ struct damos_sysfs_quota_goal {
 static const char * const damos_sysfs_quota_goal_metric_strs[] = {
 	"user_input",
 	"some_mem_psi_us",
+	"node_mem_used_bp",
+	"node_mem_free_bp",
 };
 
 static struct damos_sysfs_quota_goal *damos_sysfs_quota_goal_alloc(void)
-- 
2.39.5
