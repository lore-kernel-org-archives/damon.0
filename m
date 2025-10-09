Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0301283FEA;
	Thu,  9 Oct 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044849; cv=none; b=JhULQOXEIne3yNPzoHdSPO/UvxOKFnFODnDe2o0NVlXwK/0R2mdx798vvedEa6Uu3z6TNGJ9BcXYz/v+i1NEdnZH77PjEo2gZNn8qimnuidByBRRg6A8IPBdadljBrZg6wQV9Llk159Ht3dM+ck6oVYYx6a1FrXEJsmbS3CfNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044849; c=relaxed/simple;
	bh=1CIUK+8rJXZdcUGVSAXbpo+NPkJ8Yup2LU3ew0CDXuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twe2g1Wtqrc5pCuN91BRnYhUGNetbh2wC7au0wymqih+0TS0m0X1QDcSRDRF7DbT1kMu4PFnlvFcrOz9DPJOJ9eYBhg281yQQkIaVpOUta8ozXPzVWnIwymSNTojhdqwJ3dgjUGGsCPDWB9FzzBn+Vn6GPH3qbFiaLs0u7ZPJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL5dvLdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL5dvLdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA3AC4CEFE;
	Thu,  9 Oct 2025 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044849;
	bh=1CIUK+8rJXZdcUGVSAXbpo+NPkJ8Yup2LU3ew0CDXuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL5dvLdKsBzT9ZGTax9IUxnfFckwub2guE+Nbf6VOC/LsoUruROAkfDj+3MR8hL5m
	 hZ2Py91uHheq/rMel/lyVBEHxt1xtyAXm8I8Eqt2ADnbaDJRAWQ5EYC2GVM6htOu7D
	 +a9gqXt2p8XoeUw8z1HRe5SX/ty/2+QhCDHM0KXYd52CSMR2bhMqKhcYeH1imoxcxJ
	 MSvIarMhK7E2FXdGpm9dODpZNuOWu9RtIH/BHmZ0VqVjHU6ctsQnDsaT/EsONx9Obu
	 nbhjh7DLcyxfqPOvw6HxFZaa8MZ3R4fGLG14NLHd9YfyuoLV9S4tMPV5H9aZf0+hIu
	 msjumprO4kjUA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 02/10] mm/damon: add DAMOS quota goal type for per-memcg per-node memory usage
Date: Thu,  9 Oct 2025 14:20:34 -0700
Message-Id: <20251009212042.60084-3-sj@kernel.org>
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
index dc9c310e0e75..0d63ceb7e6ef 100644
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
2.39.5
