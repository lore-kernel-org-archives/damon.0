Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69F392B94;
	Tue, 13 Jan 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318051; cv=none; b=QOPIS9YuobUwTtzp3He/jQ1piI9nKsmmXw45Fwo6VITz8jwhZlsFXJvnhVAyWzz1rS/k1eNVDkJCjECT55tzwoKZ3S8HQkN4jOY1R/5QHc1Y5qx/goR0ZL+XB7vSsPJK/Qhw5vDpFn8zHRHesh+KE/63tQdQFNNrBmz0gNCyBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318051; c=relaxed/simple;
	bh=7NAyhkfQbcxTPtt6Wuep4buJLBzXp37MO61JEyiUHsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My74nN90Dlxn34aMBmllbj5oO2Nzn8wXKtNqmGn3R04u3DDKqBBnq9QZdcltrgmvp4Wj+OGmZ72+Z8ayhu/GTeXkE5qHU05kZwXhfPQIr9aZI+msdJrrnjz/vQZpY5NWGfLUa4hoXoaauw2D66ckFVyVVtgpTTanGbYYdoGopAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVbA/nvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVbA/nvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689D4C19421;
	Tue, 13 Jan 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318050;
	bh=7NAyhkfQbcxTPtt6Wuep4buJLBzXp37MO61JEyiUHsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVbA/nvADP0cj5hfiuCwC6TlLON6/t/yO31DIlKvYC1iFdH9LbvsxLk0sjAUDvqDG
	 voTJWWNodHb86PVFPoavd1lCpIB0J7IMmdcHEsfShFogBolKJ1i8AbX8MAvxsJsgmI
	 3n6qC6Uhn5NllSe4LEWSJwdnlIsUiFGpyiTFOUsGnSDF/GpJUYMt5ZfyCW5p6ACa4s
	 jBz7BYffQ4d7O4qC5bKvKEV8fey4j/onYserdl1kxQNlzAWwrfRH5h0HW6Ru6CEWhd
	 hDLhNkwwuqd0e2rRonjmvZ4ACNbFK9rM+2nVRxadDRz5s55s3dAyMIrsaYYthhtK3L
	 nePNsyWQz9rww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/11] mm/damon/core: introduce [in]active memory ratio damos quota goal metric
Date: Tue, 13 Jan 2026 07:27:06 -0800
Message-ID: <20260113152717.70459-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_LRU_[DE]PRIO are DAMOS actions for making balance of active and
inactive memory size.  There is no appropriate DAMOS quota auto-tuning
target metric for the use case.  Add two new DAMOS quota goal metrics
for the purpose, namely DAMOS_QUOTA_[IN]ACTIVE_MEM_BP.  Those will
represent the ratio of [in]active memory to total (inactive + active)
memory.  Hence, users will be able to ask DAMON to, for example, "find
hot and cold memory, and move pages of those to active and inactive LRU
lists, adjusting the hot/cold thresholds aiming 50:50 active:inactive
memory ratio."

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  4 ++++
 mm/damon/core.c       | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 650e7ecfa32b..26fb8e90dff6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -155,6 +155,8 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
  * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
+ * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to total LRU memory ratio.
+ * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to total LRU memory ratio.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -166,6 +168,8 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+	DAMOS_QUOTA_ACTIVE_MEM_BP,
+	DAMOS_QUOTA_INACTIVE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index abda850c28c0..d2ed75e521bd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2132,6 +2132,23 @@ static unsigned long damos_get_node_memcg_used_bp(
 }
 #endif
 
+/*
+ * Returns LRU-active or inactive memory to total LRU memory size ratio.
+ */
+static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
+{
+	unsigned long active, inactive, total;
+
+	/* This should align with /proc/meminfo output */
+	active = global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_ANON) +
+		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
+	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
+		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
+	total = active + inactive;
+	if (active_ratio)
+		return active * 10000 / total;
+	return inactive * 10000 / total;
+}
 
 static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 {
@@ -2154,6 +2171,11 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		goal->current_value = damos_get_node_memcg_used_bp(goal);
 		break;
+	case DAMOS_QUOTA_ACTIVE_MEM_BP:
+	case DAMOS_QUOTA_INACTIVE_MEM_BP:
+		goal->current_value = damos_get_in_active_mem_bp(
+				goal->metric == DAMOS_QUOTA_ACTIVE_MEM_BP);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
