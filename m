Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46431BD01D;
	Thu, 20 Mar 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449185; cv=none; b=gOuqZznTDM8CALdkFPSYkEgE8GAhqzZ4/kMnTKgwDqtZEezEGbcaLeJYCLIOJMQL6pxF0k6UYtRpYZwU31AbPFKDEYtowfxtNKrdCKPVuVNoCmNFvEx/nBtVaCvt00+XysJVhlxAJbVv5X1aMD9l23Qm9G0xJ/xkUD94NOJ5+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449185; c=relaxed/simple;
	bh=OWte6lejDS7n5xIpsWqNW8pBu+MRjbH+R4O10AsrXCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIfIMTAHnOe2Y/LTtm1ic1UVMJAriBmvG3iEPmFFiWulyv/tSFIIeata3H8+YqHupAMOtpMq1fISrcOpDRjiBReyxnWSLi5NSRSBHqwC5X0Sj2USwrV8pPHNrJYF+3Z/fny/nbxDPMlrOQ7Ia18QYFIo/wx5GBAh83niY5TjZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyc9tomQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyc9tomQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A920C4CEE3;
	Thu, 20 Mar 2025 05:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742449185;
	bh=OWte6lejDS7n5xIpsWqNW8pBu+MRjbH+R4O10AsrXCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fyc9tomQ64s56+TofXY8CXmj7hPdLTha2V/olx6+ZQbTBJJanyE+TAb6+p2b94+RZ
	 1P64OLMK8aXnOoWxEkCbHrxkFhqEN9O2lRgKkUcrJaOLVZvsDmKf9+cMwcZAJU42t0
	 Vi164iO6fwcKtPiEpGv8rv+FisbgxZWnLQtk24QCtlmZYCsCiut9gIX2COawqTk/i8
	 ZKjsMGo4YuEOm7HbXO4mR8zpF5ZDX0YNZKq/JPeGuRQ4NRVBn+lxSAn9EYq0p3YGPJ
	 bhCakZMystvl3krGPdFcIpMpgerUxj73uB4KopW95FsZdEn6ZrxOOrInavSdZX4WAL
	 0X8/1PZZdnasg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/core: introduce two damos quota goal metrics for NUMA memory utilization and free space ratios
Date: Wed, 19 Mar 2025 22:39:34 -0700
Message-Id: <20250320053937.57734-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320053937.57734-1-sj@kernel.org>
References: <20250320053937.57734-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilization and free space ratios for specific NUMA nodes can be useful
inputs for NUMA-specific DAMOS schemes' aggressiveness self-tuning
feedback loop.  Implement DAMOS quota goal metrics for such self-tuned
schemes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    |  6 ++++++
 mm/damon/core.c          | 27 +++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9f0eec85e636..ba3604cd4d60 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -154,6 +154,8 @@ enum damos_action {
  *
  * @DAMOS_QUOTA_USER_INPUT:	User-input value.
  * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
+ * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
+ * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -161,6 +163,8 @@ enum damos_action {
 enum damos_quota_goal_metric {
 	DAMOS_QUOTA_USER_INPUT,
 	DAMOS_QUOTA_SOME_MEM_PSI_US,
+	DAMOS_QUOTA_NODE_MEM_USED_BP,
+	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
@@ -170,6 +174,7 @@ enum damos_quota_goal_metric {
  * @target_value:	Target value of @metric to achieve with the tuning.
  * @current_value:	Current value of @metric.
  * @last_psi_total:	Last measured total PSI
+ * @nid:		Node id.
  * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
@@ -188,6 +193,7 @@ struct damos_quota_goal {
 	/* metric-dependent fields */
 	union {
 		u64 last_psi_total;
+		int nid;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fc1eba3da419..c4ce8e2c22c1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1890,6 +1890,29 @@ static inline u64 damos_get_some_mem_psi_total(void)
 
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
@@ -1903,6 +1926,10 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
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
index 9cff4ec6973f..0f338ba1db43 100644
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
