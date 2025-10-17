Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C6330B31;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736434; cv=none; b=TbnG+NOpyjZlhC5yMbK/fSWSR4zSJufONpoTNTqi/WhZK2AW64mZOi5evazfYp/Y5erx5x/Trx1Z2xGwKDHBP4NR5pb8ZcJKC6LXUlBnSiBhyjAPTKEUfaiR4wgKeUluvM7LyxCvqL4zT3C5d8RAGPcKAS2odgpILxwB6G6kt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736434; c=relaxed/simple;
	bh=TXnOxLHlQsz7DpkuFGQ5HlVDsoXT2xlK8gPHnzDuxz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smP4msCxoXSFHHekHWnIipsiorpJw22VNZfostEHtxh7S+ojAoArIfkVU2Br1IUfRnE9V6gzmOrLw6evk5LCCrx3gmlP6P/jzm1phzyfcBBjGA3P642ASvG8Xl22J1lZGQwTvicvRTKPMHbdfwi/TfxH+62r6fomZ5xsVdgX4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+yN6taF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+yN6taF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B48DC116C6;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736434;
	bh=TXnOxLHlQsz7DpkuFGQ5HlVDsoXT2xlK8gPHnzDuxz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+yN6taFSUqSAUEhHtyGiwsy1LGNCf4WWkeAhIcHgVhg0aGsOCyomXhgzmIQyipes
	 3NrAJ+BHdIx1HLjpRkT3VtrnIpPOAmBEQxtw6Fyku1mXu01mSRV76hzup9JESMLldh
	 EoTlJUJkGaM/fupQiVl8U9ukruUe+mn0ZZq955LA+X5TWQnl8GSV+o8QOuk65o7TUY
	 ZPJeGS4IycxdPsPRfefZ4qyY7efkfNnszCFoNtifsZEVNLaHS605y8GihFkkmImCfJ
	 YXiSj2lMD12yJCrKOP1luw3pNEVPzQdMK0q6dAOrpumYRBvdEFPF256fas3AcqQSHb
	 zmu1aLnJSUiWQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm/damon: add DAMOS quota goal type for per-memcg per-node memory usage
Date: Fri, 17 Oct 2025 14:26:54 -0700
Message-ID: <20251017212706.183502-3-sj@kernel.org>
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

Define a new DAMOS quota auto-tuning target metric for per-cgroup
per-node memory usage.  For specifying the cgroup of the interest, add a
field, namely memcg_id, to damos_quota_goal struct.

Note that this commit is only implementing the interface.  The handling
of the interface (the metric value calculation) will be implemented in
the following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bb92c5f396cf..862531f1a379 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -147,6 +147,7 @@ enum damos_action {
  * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
  * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
+ * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -156,6 +157,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_SOME_MEM_PSI_US,
 	DAMOS_QUOTA_NODE_MEM_USED_BP,
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
+	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
@@ -166,6 +168,7 @@ enum damos_quota_goal_metric {
  * @current_value:	Current value of @metric.
  * @last_psi_total:	Last measured total PSI
  * @nid:		Node id.
+ * @memcg_id:		Memcg id.
  * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
@@ -179,6 +182,9 @@ enum damos_quota_goal_metric {
  *
  * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
  * id of the target node to account the used/free memory.
+ *
+ * If @metric is DAMOS_QUOTA_NODE_MEMCG_USED_BP, @nid and @memcg_id represents
+ * the node id and the cgroup to account the used memory for.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
@@ -187,7 +193,10 @@ struct damos_quota_goal {
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
2.47.3
