Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBF2980DF;
	Thu, 19 Jun 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370439; cv=none; b=XKNpv7oXu09ZKv9D5fpgmECv+ugG8tHueEp+eqzkcNW07dCfPiDOMal7tFGkrqrOAF+oqG1wos7qtn96WJvMKedzyA3bxFMIem7BxT3uw76wn/up9vxN4Q7vWzwH2qI/Fm7ToJwawMpt40WsXAzX798KvdCj5EBaULcpWSGjGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370439; c=relaxed/simple;
	bh=SD/oeFdnj1gBxwoLiXjI4d1QKLNcRhVN2gjFTeKD8k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQnKVZ46p643ZTzCfAnkAMkd5fK0GQcIukKZREPj4xQ4ruCc4uoj6PUoZWRB3WMJsBEujuAB5eRTLkRt9QLe+lv1yiJRIuXiX0EXakVBAsqDQmKkUGCzVfGjykgAT1Mom/Y3nrLVmYe9MgBH+vMuGfQEAWaXmUicsgi6AVDznM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtyZUZKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtyZUZKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AC4C4CEEA;
	Thu, 19 Jun 2025 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370437;
	bh=SD/oeFdnj1gBxwoLiXjI4d1QKLNcRhVN2gjFTeKD8k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtyZUZKtBQqNFhYY/V1AEtjRwk1uHPZShVWg9p8KpXOUV444YhNyTSMs4gcbAp3WJ
	 7eW1AWkETUtr0Z8RG0WO7DM7bML78Qa74KWMEnhS0dDvFeCO5t8g7hfv+/lbi9UCZz
	 Fo/S+eq8YAwWOsNeWyMyq/27DLQ2kWjQdPA/gC3HABWz1Cy0MyelNo7zOa+Ek2cGkh
	 e7ZPR7fUZYLyRTCxmJKWkfE86ijwsP+uouKuc0xCi/QcqEFlEX+3axLDBqqPMAdVmJ
	 5BhZhwnYItUrYlVd40hZKlOnnw1N0mYp9tNoWrW4wyc51pxRA+jXDl7bvISJtVW+sL
	 6UaQYqIIG/YOQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/11] mm/damon: add DAMOS_QUOTA_NODE_MEMCG_FREE_BP quota tuning goal metric
Date: Thu, 19 Jun 2025 15:00:20 -0700
Message-Id: <20250619220023.24023-9-sj@kernel.org>
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

Add a variant of DAMOS_QUOTA_NODE_MEMCG_USED_BP, for free memory
portion.  Note that this commit only extends the DAMON API.  The real
behavior will be implemented by a following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 43aef959d357..ba02c95e7d85 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -176,6 +176,7 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
+ * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
  * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to inactive memory ratio.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
@@ -187,6 +188,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEM_USED_BP,
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
+	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
@@ -213,8 +215,8 @@ enum damos_quota_goal_metric {
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
-- 
2.39.5
